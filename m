Return-Path: <bpf+bounces-50259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1814DA246D2
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 03:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B958188A51A
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 02:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F435953;
	Sat,  1 Feb 2025 02:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rjA/A0I2"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119035975
	for <bpf@vger.kernel.org>; Sat,  1 Feb 2025 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376387; cv=none; b=XFXT0EWyNC5Uf/PP42vn43PECUiaGnryb1395mJiwL6D49V6YzyTM9RFFbjhKlbV/UkOtcUsP/X7EeW/wnCs+qG1wbv9OKHplNQ03IMs0ZOMPPN2E1sXfuVIKDz38fVpF6We/C3Tw+/RRTlRqELncpQFUvgi6njIIalmvGEy+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376387; c=relaxed/simple;
	bh=shEg8TkPDjmmBCny6C6KUe4ykY1oNBTWWzUgJZe+X9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5m1w7SJgFVEcyW0ruyzOslRkgdyGmTA14WOtAkmp1H8xyMMdQYQ5Q8lR+yZ9WK//dQknGnOyx3k7pmbEKJJKI6FkW4C19POAHT0Ac/v8FXwbb2+LEVd0q8Op01RHbUQ3MKi8mzyNFIB0nemBmE3evmZHiASUeHoOlBWMzPnpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rjA/A0I2; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <feb7ac0f-54e7-4e45-b79e-0fc8a4509437@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738376368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9M1VAK24ZcB0wC1bhjvmob6YhxHfpQUegAUd5Iq/Ky0=;
	b=rjA/A0I2B0gMO0R0Q4AEXd/hrTUZ/Jrmx2krCiMd2kkAJnd25yyfh+qdJVSF4veoearNiH
	XgI40c746nmInAy+5ALFbywX0LVZHsfoJ52QL3SzM/fRpk/N4FtawOuDlonX/AosyobroP
	EeeZExdXt3sL61+o9u/q23hP8f2vFWo=
Date: Fri, 31 Jan 2025 18:19:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf] net: Annotate rx_sk with __nullable for
 trace_kfree_skb.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, Yan Zhai <yan@cloudflare.com>
References: <20250201001425.42377-1-kuniyu@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250201001425.42377-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/31/25 4:14 PM, Kuniyuki Iwashima wrote:
> Yan Zhai reported a BPF prog could trigger a null-ptr-deref [0]
> in trace_kfree_skb if the prog does not check if rx_sk is NULL.
> 
> Commit c53795d48ee8 ("net: add rx_sk to trace_kfree_skb") added
> rx_sk to trace_kfree_skb, but rx_sk is optional and could be NULL.
> 
> Let's add __nullable suffix to rx_sk to let the BPF verifier
> validate such a prog and prevent the issue.
> 
> Now we fail to load such a prog:
> 
>    libbpf: prog 'drop': -- BEGIN PROG LOAD LOG --
>    0: R1=ctx() R10=fp0
>    ; int BPF_PROG(drop, struct sk_buff *skb, void *location, @ kfree_skb_sk_null.bpf.c:21
>    0: (79) r3 = *(u64 *)(r1 +24)
>    func 'kfree_skb' arg3 has btf_id 5253 type STRUCT 'sock'
>    1: R1=ctx() R3_w=trusted_ptr_or_null_sock(id=1)
>    ; bpf_printk("sk: %d, %d\n", sk, sk->__sk_common.skc_family); @ kfree_skb_sk_null.bpf.c:24
>    1: (69) r4 = *(u16 *)(r3 +16)
>    R3 invalid mem access 'trusted_ptr_or_null_'
>    processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>    -- END PROG LOAD LOG --
> 
> Note this fix requires commit 8aeaed21befc ("bpf: Support
> __nullable argument suffix for tp_btf").

I believe the current way is to add kfree_skb to the raw_tp_null_args[],
https://lore.kernel.org/all/20241213221929.3495062-3-memxor@gmail.com/

cc: Kumar


