Return-Path: <bpf+bounces-44451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BEB9C309F
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 03:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB8F281E64
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 02:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB8713D244;
	Sun, 10 Nov 2024 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vl6Dj1xM"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C22563
	for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731206081; cv=none; b=p10Pc5Qo0nJFlxOIW4z4Ky4DuB2fAjIoyZpqiN0BLotbXU49LWgaHLAtbuTPGpyhJS8vGf0jBAvla5wV9IF4BIdZ4jwJnU8zMxGFDK83ctkcVF2RiAlN8Ewtk/G9OObJaZRgidyeiUaphHuYRMqCLF/8fN4ArUqfd7VQuyDIf8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731206081; c=relaxed/simple;
	bh=jgXeyE2UyztRvvF/pDGkze1e3MlYMNVfVRPfoh6cubo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgBx0K0eFAjBUzdhMlr7kP1LQWfn7+dlniafTWrezbdkd+pPwr+4cagEwSElnRCvCSXB8JOR187HsZPd+0UlCWilT9VPGXhs0eAOkx7hVycYMhHBBaJ2fpr3ZhfQUdJ8bjwfUb2iPJ3v0MNaosvLzb673NPe17BAHWqVUpDqQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vl6Dj1xM; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1004554b-d214-4d05-ade7-8585e1ac0025@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731206076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hg2kGAgGimA2PAU5Zw6jwxCnlPUMRruqP1yLj/yCS6Y=;
	b=Vl6Dj1xMwiscv0luCy/g6dYKDw2POrn5JFMR/qq5bxgvrldzW++a/zo1xk0ZAqt3HLFWIt
	DY+t5DGmcVF/1nRs6uG7Ig13uDmp4xYE6s/HBuxPslvTrVp0INhlobEG9DGo50A9FvZ9g9
	oZW2AmMjB7fRKoPg+RXbMlvlgOPig+w=
Date: Sat, 9 Nov 2024 18:34:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 4/7] bpf, x86: Support private stack in jit
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241109025312.148539-1-yonghong.song@linux.dev>
 <20241109025332.150019-1-yonghong.song@linux.dev>
 <CAADnVQJ4OiJbVMU-xrQhokPoECh4v4fWf-N-0YMx0k=h12f8EQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJ4OiJbVMU-xrQhokPoECh4v4fWf-N-0YMx0k=h12f8EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/9/24 12:14 PM, Alexei Starovoitov wrote:
> On Fri, Nov 8, 2024 at 6:53 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>          stack_depth = bpf_prog->aux->stack_depth;
>> +       if (bpf_prog->aux->priv_stack_ptr) {
>> +               priv_frame_ptr = bpf_prog->aux->priv_stack_ptr + round_up(stack_depth, 16);
>> +               stack_depth = 0;
>> +       }
> ...
>
>> +       priv_stack_ptr = prog->aux->priv_stack_ptr;
>> +       if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
>> +               priv_stack_ptr = __alloc_percpu_gfp(prog->aux->stack_depth, 16, GFP_KERNEL);
> After applying I started to see crashes running test_progs -j like:
>
> [  173.465191] Oops: general protection fault, probably for
> non-canonical address 0xdffffc0000000af9: 0000 [#1] PREEMPT SMP KASAN
> [  173.466053] KASAN: probably user-memory-access in range
> [0x00000000000057c8-0x00000000000057cf]
> [  173.466053] RIP: 0010:dst_dev_put+0x1e/0x220
> [  173.466053] Call Trace:
> [  173.466053]  <IRQ>
> [  173.466053]  ? die_addr+0x40/0xa0
> [  173.466053]  ? exc_general_protection+0x138/0x1f0
> [  173.466053]  ? asm_exc_general_protection+0x26/0x30
> [  173.466053]  ? dst_dev_put+0x1e/0x220
> [  173.466053]  rt_fibinfo_free_cpus.part.0+0x8c/0x130
> [  173.466053]  fib_nh_common_release+0xd6/0x2a0
> [  173.466053]  free_fib_info_rcu+0x129/0x360
> [  173.466053]  ? rcu_core+0xa55/0x1340
> [  173.466053]  rcu_core+0xa55/0x1340
> [  173.466053]  ? rcutree_report_cpu_dead+0x380/0x380
> [  173.466053]  ? hrtimer_interrupt+0x319/0x7c0
> [  173.466053]  handle_softirqs+0x14c/0x4d0
>
> [   35.134115] Oops: general protection fault, probably for
> non-canonical address 0xe0000bfff101fbbc: 0000 [#1] PREEMPT SMP KASAN
> [   35.135089] KASAN: probably user-memory-access in range
> [0x00007fff880fdde0-0x00007fff880fdde7]
> [   35.135089] RIP: 0010:destroy_workqueue+0x4b4/0xa70
> [   35.135089] Call Trace:
> [   35.135089]  <TASK>
> [   35.135089]  ? die_addr+0x40/0xa0
> [   35.135089]  ? exc_general_protection+0x138/0x1f0
> [   35.135089]  ? asm_exc_general_protection+0x26/0x30
> [   35.135089]  ? destroy_workqueue+0x4b4/0xa70
> [   35.135089]  ? destroy_workqueue+0x592/0xa70
> [   35.135089]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> [   35.135089]  ext4_put_super+0xff/0xd70
> [   35.135089]  generic_shutdown_super+0x148/0x4c0
> [   35.135089]  kill_block_super+0x3b/0x90
> [   35.135089]  ext4_kill_sb+0x65/0x90
>
> I think I see the bug... quoted it above...
>
> Please make sure you reproduce it first.
>
> Then let's figure out a way how to test for such things and
> what we can do to make kasan detect it sooner,
> since above crashes have no indication at all that bpf priv stack
> is responsible.
> If there is another bug in priv stack and it will cause future
> crashes we need to make sure that priv stack corruption is
> detected by kasan (or whatever mechanism) earlier.
>
> We cannot land private stack support when there is
> a possibility of such silent corruption.

I can reproduce it now when running multiple times.
I will debug this ASAP.

>
> pw-bot: cr


