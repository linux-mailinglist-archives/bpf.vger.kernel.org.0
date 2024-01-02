Return-Path: <bpf+bounces-18821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD5C82250A
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 23:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E13E1C219D4
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 22:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12EE1772F;
	Tue,  2 Jan 2024 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kfw1Fcfx"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732E17980
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dadb229a-d811-4542-a53f-3a78e559e639@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704236287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25gs3WH+C3MtBTiiFP49L8wsgVhUB8Z0Q30aeythoxg=;
	b=Kfw1FcfxvCB1Jp+1FFhSEdFRuFj7wNSiPPiI5NXLKW3ltZMt5eWDTHnYINUzcHwVtAlfdL
	hzyK4DBRHu4TnbV5x/nRfSVYzOp4lI9ct3Hy+U3DA3pyPV3FZUOEB3s1zmAoGGgckNs2nm
	83tujYyHTo40bZI3UCY3u2qbiO5S2o8=
Date: Tue, 2 Jan 2024 14:58:00 -0800
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231221132656.384606-3-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/21/23 5:26 AM, Maciej Fijalkowski wrote:
> This comes from __xdp_return() call with xdp_buff argument passed as
> NULL which is supposed to be consumed by xsk_buff_free() call.
> 
> To address this properly, in ZC case, a node that represents the frag
> being removed has to be pulled out of xskb_list. Introduce
> appriopriate xsk helpers to do such node operation and use them
> accordingly within bpf_xdp_adjust_tail().

[ ... ]

> +static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
> +{
> +	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
> +	struct xdp_buff_xsk *frag;
> +
> +	frag = list_last_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
> +			       xskb_list_node);
> +	return &frag->xdp;
> +}
> +

[ ... ]

> +static void __shrink_data(struct xdp_buff *xdp, struct xdp_mem_info *mem_info,
> +			  skb_frag_t *frag, int shrink)
> +{
> +	if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> +		struct xdp_buff *tail = xsk_buff_get_tail(xdp);
> +
> +		if (tail)
> +			tail->data_end -= shrink;
> +	}
> +	skb_frag_size_sub(frag, shrink);
> +}
> +
> +static bool shrink_data(struct xdp_buff *xdp, skb_frag_t *frag, int shrink)
> +{
> +	struct xdp_mem_info *mem_info = &xdp->rxq->mem;
> +
> +	if (skb_frag_size(frag) == shrink) {
> +		struct page *page = skb_frag_page(frag);
> +		struct xdp_buff *zc_frag = NULL;
> +
> +		if (mem_info->type == MEM_TYPE_XSK_BUFF_POOL) {
> +			zc_frag = xsk_buff_get_tail(xdp);
> +
> +			if (zc_frag) {

Based on the xsk_buff_get_tail(), would zc_frag ever be NULL?

> +				xdp_buff_clear_frags_flag(zc_frag);
> +				xsk_buff_del_tail(zc_frag);
> +			}
> +		}
> +
> +		__xdp_return(page_address(page), mem_info, false, zc_frag);

and iiuc, this patch is fixing a bug when zc_frag is NULL and 
MEM_TYPE_XSK_BUFF_POOL.

> +		return true;
> +	}
> +	__shrink_data(xdp, mem_info, frag, shrink);
> +	return false;
> +}
> +


