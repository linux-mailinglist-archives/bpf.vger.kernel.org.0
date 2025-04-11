Return-Path: <bpf+bounces-55782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26851A86598
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 20:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180C24A6F13
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F43268C75;
	Fri, 11 Apr 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lamnlwea"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6AE268C4C
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396631; cv=none; b=dCPW7e+2lzuwLSelNSr24ysOQ9h2/RC6xvEDhDQqAA4N3AfX0qrNy81UNp9MORMX0hjZGNcAAWtZD0sz7sEILAJrxnGNMpg8hPSvMFufr5ltCQclIahqvJy5nYon+2czk9wGzFqZ8EP3duY/eITqGcyVkGe3IM7Up4G73Ufu7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396631; c=relaxed/simple;
	bh=Kv5IkxLlECGnfk7z+3OGtjD0kjT1jZNIT/xmNYdn5k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyq45fGKCVwf1CNPhmifD9tZshMbAwuy75AQw3rC+wx1YnjvYjmAWtyXtNlDWS/ZaXojMfaWd0Dgohj/AIq5oqWkJNUzxCWhnJOb0KtWvgsBGnzJVSGl4GLVhI29nIjTlf46U6fkaCdb4qlP8D//uxCAYhshbV9KWviZhXZnvq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lamnlwea; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <08811dd9-2449-42c9-8028-8a4dfec20afd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744396616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0zRTmNq8a+4fGPeHsBO9fr7y7kzSzduNbofvzwiQtc=;
	b=lamnlweaT0Twy7uqvN68Uex2Up6GQblSPKX2LWfdwCCvzsprU/npzrrOcZJPDFJSZ8jNLx
	y2A73P5j1v9yUfv7CZAzPvu2huhX37Gt0qN21zsoNN7r66gh3h9xYX5PKsQGW18/uOxQrG
	OBzcYu1ZiXJcqgvbXzKNNZI2BFLLnzA=
Date: Fri, 11 Apr 2025 11:36:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 03/10] bpf: net_sched: Add basic bpf qdisc
 kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 edumazet@google.com, kuba@kernel.org, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, martin.lau@kernel.org, jiri@resnulli.us,
 stfomichev@gmail.com, toke@redhat.com, sinquersw@gmail.com,
 ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
 yepeilin.cs@gmail.com, kernel-team@meta.com
References: <20250409214606.2000194-1-ameryhung@gmail.com>
 <20250409214606.2000194-4-ameryhung@gmail.com>
 <CAP01T77ibGcEhwsyJb1WVaH-vhbZB_M2yVA8Uyv9b5fy=ErWQQ@mail.gmail.com>
 <CAMB2axNqfBpneVc9unn7S65Ewb1u6EpLudjtiq00-sqbfnSY7w@mail.gmail.com>
 <CAP01T76oTKg5H2nqd5ppyLhk1rNjPY0DcYVELmyZU+Du8izbbA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAP01T76oTKg5H2nqd5ppyLhk1rNjPY0DcYVELmyZU+Du8izbbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/11/25 10:08 AM, Kumar Kartikeya Dwivedi wrote:
> On Fri, 11 Apr 2025 at 18:59, Amery Hung <ameryhung@gmail.com> wrote:
>>
>> On Fri, Apr 11, 2025 at 6:32 AM Kumar Kartikeya Dwivedi
>> <memxor@gmail.com> wrote:
>>>
>>> On Wed, 9 Apr 2025 at 23:46, Amery Hung <ameryhung@gmail.com> wrote:
>>>>
>>>> From: Amery Hung <amery.hung@bytedance.com>
>>>>
>>>> Add basic kfuncs for working on skb in qdisc.
>>>>
>>>> Both bpf_qdisc_skb_drop() and bpf_kfree_skb() can be used to release
>>>> a reference to an skb. However, bpf_qdisc_skb_drop() can only be called
>>>> in .enqueue where a to_free skb list is available from kernel to defer
>>>> the release. bpf_kfree_skb() should be used elsewhere. It is also used
>>>> in bpf_obj_free_fields() when cleaning up skb in maps and collections.
>>>>
>>>> bpf_skb_get_hash() returns the flow hash of an skb, which can be used
>>>> to build flow-based queueing algorithms.
>>>>
>>>> Finally, allow users to create read-only dynptr via bpf_dynptr_from_skb().
>>>>
>>>> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
>>>> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>> ---
>>>
>>> How do we prevent UAF when dynptr is accessed after bpf_kfree_skb?
>>>
>>
>> Good question...
>>
>> Maybe we can add a ref_obj_id field to bpf_reg_state->dynptr to track
>> the ref_obj_id of the object underlying a dynptr?
>>
>> Then, in release_reference(), in addition to finding ref_obj_id in
>> registers, verifier will also search stack slots and invalidate all
>> dynptrs with the ref_obj_id.
>>
>> Does this sound like a feasible solution?
> 
> Yes, though I talked with Andrii and he has better ideas for doing
> this generically, but for now I think we can make this fix as a
> stopgap.

In case the better fix will take longer, just want to mention that an option is 
to remove the bpf_dynptr_from_skb() from bpf qdisc. I don't see an urgent need 
for the bpf qdisc to be able to directly access the skb->data. btw, I don't 
think bpf qdisc should write to the skb->data.

The same goes for the bpf_kfree_skb(). I was thinking if it is useful at all 
considering there is already a bpf_qdisc_skb_drop(). I kept it there because it 
is a little more intuitive in case the .reset/.destroy wanted to do a "skb = 
bpf_kptr_xchg(&skbn->skb, NULL);" and then explicitly free the 
bpf_kfree_skb(skb). However, the bpf prog can also directly do the 
bpf_obj_drop(skbn) and then bpf_kfree_skb() is not needed, right?



