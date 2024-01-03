Return-Path: <bpf+bounces-18957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9125E823896
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16E5CB223BB
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 22:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AB41DDF8;
	Wed,  3 Jan 2024 22:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XjUhI/q/"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A51EB20
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7d2cd6c4-0d65-4a65-beb1-2dd995ac9b2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704322407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cz3W+QGbxOtKN2ZN3vU1nWmUAo8sjPozJY1qG8xxL2U=;
	b=XjUhI/q/vDDNe7G1kobnrcgPqH8g2n8hOYQdQ/z1ujp0mKHlZYCtUfACkZTq/ZCad0veas
	I41TFDVcFZgO0R0Qkumt66HDi6uyA95JTTnQIienGrXPEpONrjby5Eun9kXJyC+6B3SoY4
	xgSCC+Wfxt0OSKURvhcCk4KlqgBmnfg=
Date: Wed, 3 Jan 2024 14:53:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf 2/4] xsk: fix usage of multi-buffer BPF helpers for
 ZC XDP
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 echaudro@redhat.com, lorenzo@kernel.org, tirthendu.sarkar@intel.com,
 bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <20231221132656.384606-1-maciej.fijalkowski@intel.com>
 <20231221132656.384606-3-maciej.fijalkowski@intel.com>
 <dadb229a-d811-4542-a53f-3a78e559e639@linux.dev> <ZZVNa6CN8Y1KUtNM@boxer>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <ZZVNa6CN8Y1KUtNM@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/3/24 4:04 AM, Maciej Fijalkowski wrote:
> On Tue, Jan 02, 2024 at 02:58:00PM -0800, Martin KaFai Lau wrote:
>> On 12/21/23 5:26 AM, Maciej Fijalkowski wrote:
>>> This comes from __xdp_return() call with xdp_buff argument passed as
>>> NULL which is supposed to be consumed by xsk_buff_free() call.
>>>
>>> To address this properly, in ZC case, a node that represents the frag
>>> being removed has to be pulled out of xskb_list. Introduce
>>> appriopriate xsk helpers to do such node operation and use them
>>> accordingly within bpf_xdp_adjust_tail().
>>
>> [ ... ]
>>
>>> +static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
>>> +{
>>> +	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
>>> +	struct xdp_buff_xsk *frag;
>>> +
>>> +	frag = list_last_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
>>> +			       xskb_list_node);
>>> +	return &frag->xdp;
>>> +}
>>> +
>>
>> [ ... ]
>>
>>> +static void __shrink_data(struct xdp_buff *xdp, struct xdp_mem_info *mem_info,
>>> +			  skb_frag_t *frag, int shrink)
>>> +{
>>> +	if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
>>> +		struct xdp_buff *tail = xsk_buff_get_tail(xdp);
>>> +
>>> +		if (tail)
>>> +			tail->data_end -= shrink;
>>> +	}
>>> +	skb_frag_size_sub(frag, shrink);
>>> +}
>>> +
>>> +static bool shrink_data(struct xdp_buff *xdp, skb_frag_t *frag, int shrink)
>>> +{
>>> +	struct xdp_mem_info *mem_info = &xdp->rxq->mem;
>>> +
>>> +	if (skb_frag_size(frag) == shrink) {
>>> +		struct page *page = skb_frag_page(frag);
>>> +		struct xdp_buff *zc_frag = NULL;
>>> +
>>> +		if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
>>> +			zc_frag = xsk_buff_get_tail(xdp);
>>> +
>>> +			if (zc_frag) {
>>
>> Based on the xsk_buff_get_tail(), would zc_frag ever be NULL?
> 
> Hey Martin thanks for taking a look, I had to do this in order to satisfy
> !CONFIG_XDP_SOCKETS builds :/

There is compilation/checker warning if it does not check for NULL?

hmm... but it still should not reach here in the runtime and call 
xsk_buff_get_tail() in the !CONFIG_XDP_SOCKETS build. Can the NULL test on the 
get_tail() return value be removed? The above "mem_info->type == 
MEM_TYPE_XSK_BUFF_POOL" should have avoided the get_tail() call for the 
!CONFIG_XDP_SOCKETS build. Otherwise, it could be passing NULL to the 
__xdp_return() and hit the same bug again. The NULL check here is pretty hard to 
reason logically.

> 
>>
>>> +				xdp_buff_clear_frags_flag(zc_frag);
>>> +				xsk_buff_del_tail(zc_frag);
>>> +			}
>>> +		}
>>> +
>>> +		__xdp_return(page_address(page), mem_info, false, zc_frag);
>>
>> and iiuc, this patch is fixing a bug when zc_frag is NULL and
>> MEM_TYPE_XSK_BUFF_POOL.
> 
> Generally I don't see the need for xdp_return_buff() (which calls in the
> end __xdp_return() being discussed) to handle MEM_TYPE_XSK_BUFF_POOL, this
> could be refactored later and then probably this fix would look different,
> but this is out of the scope now.
> 
>>
>>> +		return true;
>>> +	}
>>> +	__shrink_data(xdp, mem_info, frag, shrink);
>>> +	return false;
>>> +}
>>> +
>>
>>
> 


