Return-Path: <bpf+bounces-31502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 370F38FEFF5
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 17:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B711C289504
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47921196C92;
	Thu,  6 Jun 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xCNBfre5"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608B196C78
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684982; cv=none; b=h8RZKnTsEw3W7pZkx16JjZoULmlgrotT3u85RO7psqIjOoS7VwtQuNsKBnfHxeoi8W2+GnssR47QJfiQqM7U92RrS/ugdmsZbckesY7fb/yXEVykmjETY84n4seuN9T3Hcvcw8xJ3kWwSBtMamxBsk3cKWAr6fsxOkSQOd/PIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684982; c=relaxed/simple;
	bh=ONW53m4ZycWO1OGtk0GeLM/2qht39lHSIfuM/kqo9lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fr13+BILgqyHtmBrAE+9+hgTiUwlmQRHLF/KZJzS66D/ptXc1lqYUzux31thKbi7pCA7lUbp1ATAYWhmy+b68lp5ifhHqu/xWqkFimbU2NGhuZpgO3v9YXapJhO2U37F3kI1ngi6DXUzFegMhpEwCPQH5qx18ZOyvXCeZwK5zE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xCNBfre5; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: daniel@iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717684978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyjftdVLlqSs/0Ocru/73Avy/AEFY5TKCAK8RNKM7vI=;
	b=xCNBfre5GyZDH2+KCsGM+3I2PIiduF9fFnPbIIVVzsrAIl9ILzELM/jdni4a2Wxwtz9G/C
	KxpDHdGXIROFCca9drkniNf1SLdGZvGDfzEgEE1L6yKDSTVfCFYJtUQLE27GSKUhHYRDfg
	Hug+9zPzWGIPO4d1sSmUu5A8uWJPevg=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: kuba@kernel.org
X-Envelope-To: mykolal@fb.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: ast@kernel.org
Message-ID: <2b629bd6-a497-410d-9193-f5e0a8cb91e4@linux.dev>
Date: Thu, 6 Jun 2024 15:42:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add CHECKSUM_COMPLETE to bpf test
 progs
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>
References: <20240527185928.1871649-1-vadfed@meta.com>
 <f7fe13a8-c379-495b-9e42-3a5ff50b50e3@linux.dev>
 <05dfb8f6-4325-62c9-b0b0-1bc22f0f8d93@iogearbox.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <05dfb8f6-4325-62c9-b0b0-1bc22f0f8d93@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 05/06/2024 15:43, Daniel Borkmann wrote:
> On 6/5/24 11:42 AM, Vadim Fedorenko wrote:
>> On 27/05/2024 19:59, Vadim Fedorenko wrote:
>>> Add special flag to validate that TC BPF program properly updates
>>> checksum information in skb.
>>>
>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>> ---
>>>   include/uapi/linux/bpf.h       |  2 ++
>>>   net/bpf/test_run.c             | 18 +++++++++++++++++-
>>>   tools/include/uapi/linux/bpf.h |  2 ++
>>>   3 files changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 90706a47f6ff..f7d458d88111 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -1425,6 +1425,8 @@ enum {
>>>   #define BPF_F_TEST_RUN_ON_CPU    (1U << 0)
>>>   /* If set, XDP frames will be transmitted after processing */
>>>   #define BPF_F_TEST_XDP_LIVE_FRAMES    (1U << 1)
>>> +/* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
>>> +#define BPF_F_TEST_SKB_CHECKSUM_COMPLETE    (1U << 2)
>>>   /* type for BPF_ENABLE_STATS */
>>>   enum bpf_stats_type {
>>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>>> index f6aad4ed2ab2..4c21562ad526 100644
>>> --- a/net/bpf/test_run.c
>>> +++ b/net/bpf/test_run.c
>>> @@ -977,7 +977,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, 
>>> const union bpf_attr *kattr,
>>>       void *data;
>>>       int ret;
>>> -    if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_size)
>>> +    if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
>>> +        kattr->test.cpu || kattr->test.batch_size)
>>>           return -EINVAL;
>>>       data = bpf_test_init(kattr, kattr->test.data_size_in,
>>> @@ -1025,6 +1026,12 @@ int bpf_prog_test_run_skb(struct bpf_prog 
>>> *prog, const union bpf_attr *kattr,
>>>       skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
>>>       __skb_put(skb, size);
>>> +
>>> +    if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
>>> +        skb->csum = skb_checksum(skb, 0, skb->len, 0);
>>> +        skb->ip_summed = CHECKSUM_COMPLETE;
>>> +    }
>>> +
>>>       if (ctx && ctx->ifindex > 1) {
>>>           dev = dev_get_by_index(net, ctx->ifindex);
>>>           if (!dev) {
>>> @@ -1079,6 +1086,15 @@ int bpf_prog_test_run_skb(struct bpf_prog 
>>> *prog, const union bpf_attr *kattr,
>>>       }
>>>       convert_skb_to___skb(skb, ctx);
>>> +    if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
>>> +        __wsum csum = skb_checksum(skb, 0, skb->len, 0);
>>> +
>>> +        if (skb->csum != csum) {
>>> +            ret = -EBADMSG;
>>> +            goto out;
>>> +        }
>>> +    }
>>> +
>>>       size = skb->len;
>>>       /* bpf program can never convert linear skb to non-linear */
>>>       if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
>>> diff --git a/tools/include/uapi/linux/bpf.h 
>>> b/tools/include/uapi/linux/bpf.h
>>> index 90706a47f6ff..f7d458d88111 100644
>>> --- a/tools/include/uapi/linux/bpf.h
>>> +++ b/tools/include/uapi/linux/bpf.h
>>> @@ -1425,6 +1425,8 @@ enum {
>>>   #define BPF_F_TEST_RUN_ON_CPU    (1U << 0)
>>>   /* If set, XDP frames will be transmitted after processing */
>>>   #define BPF_F_TEST_XDP_LIVE_FRAMES    (1U << 1)
>>> +/* If set, apply CHECKSUM_COMPLETE to skb and validate the checksum */
>>> +#define BPF_F_TEST_SKB_CHECKSUM_COMPLETE    (1U << 2)
>>>   /* type for BPF_ENABLE_STATS */
>>>   enum bpf_stats_type {
>>
>> Hi Daniel!
>>
>> Have you had a chance to look at v3 of this patch?
>> I think I addressed all your comments form v2.
> 
> Looks good, but I think there is something off given the test on arm64 
> and s390x
> fails in skb_pkt_end with EBADMSG. I wonder if we're missing a :
> 
>    skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
> 
> right after the eth_type_trans()?

Oh, thanks for bringing it up. Looks like it's a bit more complex.
Apparently, CHECKSUM_COMPLETE covers everything after the ethernet
header. That's why the code has to calculate checksum after network and
transport offsets are set. And for L2 case we have to skip ethernet
header.

Another issue is that correct check should use folded checksums instead
of raw values. I believe that was flagged by tests for other archs.

I'll do v4 soon and will be sure to have tests passing on all archs.

Thanks,
Vadim



> Thanks,
> Daniel


