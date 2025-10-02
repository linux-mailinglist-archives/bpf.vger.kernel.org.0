Return-Path: <bpf+bounces-70228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B539BB4E28
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 20:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B89E3BED5C
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E02274B40;
	Thu,  2 Oct 2025 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sKHttbYC"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ED534BA2B
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759429994; cv=none; b=M8JtF2F5fRNkMIHE2eFlLVdCm0kjAcWokYuqOu/9R5Boxp7EfR7RV8uOwrH4rIAYJk3QHB6/Zl/oo7l3L59DXgWtbuk/cJmV/vuH4jYeN41L8G47S1Ft23nybkijmcN7WUNz5xXYgg4QHBKXuj4dNt63vUinT5MDqC8+bQjnQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759429994; c=relaxed/simple;
	bh=/Unaob+RvOm8qTbbw6jRofIpk1EQtkCmjfOX2gNp+jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lG0TW3ahOgZg4s2BEugIEYLGMF9yyjWMO4PHa/Gzy9VKisNkRv4iFi+lhQnELnD0BhYYIiSComGG08G4JOePuDQabqKnKq2jIFy9oymdWamJgRZ0YPty3ilmWH5O2bKKqPQ1HQaD/zADKNwSuy23jAkYzUHslkWo7WVRUC50YJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sKHttbYC; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19df5360-9fee-4ca4-ab66-85aeede3979e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759429988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlIHZ4IuPxKLoliu2mwmCuYj3JjRMF3OZh4XaBrkFRc=;
	b=sKHttbYCIVxy8jEHASH9PVdk/tcmJaasQqIlfGAIR3dv8abyKndn6eKPyKpdxducEnijra
	5XekhvjeR7OB5yl9q0rcV/GFTA42hL9F8GEiN1erEC80+yosvALkCnOotaLOisdwRWZW1O
	Z0xj6bvuh8P3ahuc6CY9pGVt8xaluqw=
Date: Thu, 2 Oct 2025 11:32:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] xdp: update mem type when page pool is used for
 generic XDP
To: Octavian Purdila <tavip@google.com>, maciej.fijalkowski@intel.com
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 kuniyu@google.com, aleksander.lobakin@intel.com, toke@redhat.com,
 lorenzo@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
 Kernel Team <kernel-team@meta.com>
References: <20251001074704.2817028-1-tavip@google.com>
 <5af7b3b9-3ee1-4ef6-8431-72b40445eacd@linux.dev>
 <CAGWr4cQ6g5xw_iJK2KbyTbSszsf2gacUZ9v0wKAVWnyBAYz9nA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAGWr4cQ6g5xw_iJK2KbyTbSszsf2gacUZ9v0wKAVWnyBAYz9nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/1/25 6:02 PM, Octavian Purdila wrote:
> On Wed, Oct 1, 2025 at 1:26 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Hi Octavian,
>>
> 
> Hi Ihor,
> 
>> This patch seems to be causing a null pointer dereference.
>> See a splat caught by BPF CI below.
>>
>> You might be able to reproduce with:
>>
>> cd tools/testing/selftests/bpf
>> make test_progs
>> # in kernel with this patch
>> ./test_progs -t xdp_veth
>>
>> Reverting this commit mitigates the failure:
>> https://github.com/linux-netdev/testing-bpf-ci/commit/9e1eab63cd1bcbe37e205856f7ff7d1ad49669f5
>>
>> Could you please take a look?
>>
> 
> Thanks for the report, it looks like dev needs to be set in
> xdp_rxq_info. The following fix works me:
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 365c43ffc9c1..85b52c28660b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5449,7 +5449,9 @@ int do_xdp_generic(const struct bpf_prog
> *xdp_prog, struct sk_buff **pskb)
>         struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
> 
>         if (xdp_prog) {
> -               struct xdp_rxq_info rxq = {};
> +               struct xdp_rxq_info rxq = {
> +                       .dev = (*pskb)->dev,
> +               };
>                 struct xdp_buff xdp = {
>                         .rxq = &rxq,
>                 };
> 
> But probably Maciej approach is better.

Hi Octavian, Maciej,

I tested both diffs on BPF CI, no issues.

This patch + diff above assigning .dev:
* Revision: https://github.com/theihor/bpf/commits/refs/heads/netdev-fix-20251002.1/
* CI run: https://github.com/kernel-patches/bpf/actions/runs/18199837294

This patch reverted + Maciej's diff (pasted below):
* Revision: https://github.com/theihor/bpf/commits/refs/heads/netdev-fix-20251002.2/
* CI run: https://github.com/kernel-patches/bpf/actions/runs/18199860590

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

I am going to add the revert diff as a temporary patch to CI for now.

Thanks!


diff --git a/net/core/dev.c b/net/core/dev.c
index 93a25d87b86b..7707a95ca8ed 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5269,6 +5269,9 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 	orig_bcast = is_multicast_ether_addr_64bits(eth->h_dest);
 	orig_eth_type = eth->h_proto;
 
+	xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_page(xdp->data)) ?
+		MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
+
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 
 	/* check if bpf_xdp_adjust_head was used */




