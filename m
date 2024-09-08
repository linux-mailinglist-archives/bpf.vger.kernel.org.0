Return-Path: <bpf+bounces-39199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062B19707A8
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 15:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05121F2193A
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 13:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16715C127;
	Sun,  8 Sep 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R5+/i/wG"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B263224
	for <bpf@vger.kernel.org>; Sun,  8 Sep 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800481; cv=none; b=mNxSYSNTwRsjETV8CpZeRJjhuLwBipkbDAlHTmH2PhvDKqKQBP81x5eUsuvWIDXDTr1pAR6mv3ysTfR5ARO2+abMsDci4hZN6+rl8ZSvqcxknpzKIUFCSwON3WyxyqioMFaoirU7WIkCws1sWkKBmO+8yGOCg/CcIT0LIrpiecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800481; c=relaxed/simple;
	bh=1DU/9yIr/WFNF/p6XVtZBjrZt8caEAmV7eaqK3qqoDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFRBjPMZKPLe+QT3pmbrwJq3VKyKyyIscLEXj4vAI1UQClUH1SlbQthKhR1A1m/Pw/rV3nOv7wW8I8SiGZzj2YDr8BxcZfS88dANIM5G2OE7Pw6i7pnhdaNBMOhQS6tHQ3N7Lr+SDkAu5SKsrU7vY+CUVWEnLFI8r50k9rgefbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R5+/i/wG; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fb6ed3e4-7ef2-4b7d-af7e-bf928d835fe9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725800476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwfVCrr//EyjUfmWgMIueWZIOTg9gmaFOwuMMWauE9M=;
	b=R5+/i/wGY2Hb6cmLzpiQKGlctwrIdYzickDFNGRczbCT7xfvX41ORcsgV8/98vT6mTFZGX
	0OiI/QM6aHfHeq6z/Btv8FLCOEdCEAhtcUqiYbt6B+q378x7Jta0bgMijAycOxgDOrHOVa
	H2FM1qTs1mdafeldC0x3Er1a9vlhuxM=
Date: Sun, 8 Sep 2024 21:01:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
Content-Language: en-US
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, toke@redhat.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, puranjay@kernel.org,
 xukuohai@huaweicloud.com, eddyz87@gmail.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com
References: <20240901133856.64367-1-leon.hwang@linux.dev>
 <20240901133856.64367-3-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20240901133856.64367-3-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/9/24 21:38, Leon Hwang wrote:
> Like "bpf, x64: Fix tailcall infinite loop caused by freplace", the same
> issue happens on arm64, too.
> 
> For example:
> 
> tc_bpf2bpf.c:
> 
> // SPDX-License-Identifier: GPL-2.0
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
> 
> __noinline
> int subprog_tc(struct __sk_buff *skb)
> {
> 	return skb->len * 2;
> }
> 
> SEC("tc")
> int entry_tc(struct __sk_buff *skb)
> {
> 	return subprog(skb);
> }
> 
> char __license[] SEC("license") = "GPL";
> 
> tailcall_bpf2bpf_hierarchy_freplace.c:
> 
> // SPDX-License-Identifier: GPL-2.0
> \#include <linux/bpf.h>
> \#include <bpf/bpf_helpers.h>
> 
> struct {
> 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> 	__uint(max_entries, 1);
> 	__uint(key_size, sizeof(__u32));
> 	__uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
> 
> int count = 0;
> 
> static __noinline
> int subprog_tail(struct __sk_buff *skb)
> {
> 	bpf_tail_call_static(skb, &jmp_table, 0);
> 	return 0;
> }
> 
> SEC("freplace")
> int entry_freplace(struct __sk_buff *skb)
> {
> 	count++;
> 	subprog_tail(skb);
> 	subprog_tail(skb);
> 	return count;
> }
> 
> char __license[] SEC("license") = "GPL";
> 
> The attach target of entry_freplace is subprog_tc, and the tail callee
> in subprog_tail is entry_tc.
> 
> Then, the infinite loop will be entry_tc -> entry_tc -> entry_freplace ->
> subprog_tail --tailcall-> entry_tc, because tail_call_cnt in
> entry_freplace will count from zero for every time of entry_freplace
> execution.
> 
> This patch fixes the issue by avoiding touching tail_call_cnt at
> prologue when it's subprog or freplace prog.
> 
> Then, when freplace prog attaches to entry_tc, it has to initialize
> tail_call_cnt and tail_call_cnt_ptr, because its target is main prog and
> its target's prologue hasn't initialize them before the attach hook.
> 
> So, this patch uses x7 register to tell freplace prog that its target
> prog is main prog or not.
> 
> Meanwhile, while tail calling to a freplace prog, it is required to
> reset x7 register to prevent re-initializing tail_call_cnt at freplace
> prog's prologue.
> 
> Fixes: 1c123c567fb1 ("bpf: Resolve fext program type when checking map compatibility")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 44 +++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 5 deletions(-)
> 
Hi Puranjay and Kuohai,

As it's not recommended to introduce arch_bpf_run(), this is my approach
to fix the niche case on arm64.

Do you have any better idea to fix it?

Thanks,
Leon


