Return-Path: <bpf+bounces-68665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D96B7FEB2
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A878179646
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2962D738E;
	Wed, 17 Sep 2025 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7tE4UdA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A453F1EF36C
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117813; cv=none; b=iwa0MfpBEEfMLmasb71+kY5ceSdhjL2m/gRfKT0UzX9oQjegMJd7Uu64oDvsgKElfa254IsYNAMKjIwMJe+uHDP7c79YbJogbhB5uT7oQvbDY8t8X5sdsFqlwuxEK8lWfTVvENK98DYZxHVOccti9c5B/7oE25K1bPSMdWdqMD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117813; c=relaxed/simple;
	bh=U/YEIYZSx2xYyFNRBM6IkakAFOfW+b3pLutNFouXV5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fSKGm7j6NLdVLZsya+bRTY8z9BsO/C/knhnLey8mebsaiHMvQLgDMJAlhjIzDrlOz+wz0VAjiel5iuJGSD22T/C4RJZiSCAMv16C7cf5kGv3B11I69DCefX8r7xLBFn90EtjyfkQzx/oVU053AcJ0wygMPkZ06f6nxlcPrr/flE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7tE4UdA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BE2C4CEF5;
	Wed, 17 Sep 2025 14:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758117811;
	bh=U/YEIYZSx2xYyFNRBM6IkakAFOfW+b3pLutNFouXV5c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H7tE4UdA/iqePs71rDYFxpAZrAZvhyblqsu+nWKuveM3+Iivd6Zu4vtAjnzrCR4Ew
	 NJNb3iDPuz6+uy+x0nsV/ff6gh/ILHx8WSK7W6/RM6yRhYVqFiLVCef39ZQBqCEEB3
	 kKXgBlmN4HmbTKWakzoJYA3I5UWJLpuWYk5ViWcJJGv6D5TgLx6TebOo7xNPWIalQA
	 1BwyN5gu8qwfEFU04Cs9RIj5YzbyTdawTusYlAgywWNDR76BhqDsaQxK0ten9OMQAO
	 GzC6OjD1YELpy8oEwXfItAJ24BqoPZmqn1si0wUcmr2pQTqzgrqymvMOmgDG1DR2ZE
	 4l0Lk9Gu6hC7Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 kernel-team@fb.com
Subject: Re: [PATCH bpf-next] bpf: support nested rcu critical sections
In-Reply-To: <c6e2c3c6-2ce5-4b52-8429-bcda39e452ab@gmail.com>
References: <20250916113622.19540-1-puranjay@kernel.org>
 <c6e2c3c6-2ce5-4b52-8429-bcda39e452ab@gmail.com>
Date: Wed, 17 Sep 2025 14:03:27 +0000
Message-ID: <mb61pa52tqiq8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Leon Hwang <hffilwlqm@gmail.com> writes:

> On 16/9/25 19:36, Puranjay Mohan wrote:
>> Currently, nested rcu critical sections are rejected by the verifier and
>> rcu_lock state is managed by a boolean variable. Add support for nested
>> rcu critical sections by make active_rcu_locks a counter similar to
>> active_preempt_locks. bpf_rcu_read_lock() increments this counter and
>> bpf_rcu_read_unlock() decrements it, MEM_RCU -> PTR_UNTRUSTED transition
>> happens when active_rcu_locks drops to 0.
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>
> [...]
>
>> @@ -13863,7 +13863,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  	preempt_disable = is_kfunc_bpf_preempt_disable(&meta);
>>  	preempt_enable = is_kfunc_bpf_preempt_enable(&meta);
>>
>> -	if (env->cur_state->active_rcu_lock) {
>> +	if (env->cur_state->active_rcu_locks) {
>>  		struct bpf_func_state *state;
>>  		struct bpf_reg_state *reg;
>>  		u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
>> @@ -13874,22 +13874,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  		}
>>
>>  		if (rcu_lock) {
>> -			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
>> -			return -EINVAL;
>> +			env->cur_state->active_rcu_locks++;
>
> Could we add a check for the maximum of 'active_rcu_locks'?
>
> From a cracker's perspective, this could potentially be abused to
> stall the kernel or trigger a deadlock. Underneath 'rcu_read_lock()',
> there are several RCU functions that tracing programs are able to
> attach to. If those functions are traced, a deadlock can be triggered.
>

IIUC what you are saying is that if I attach a BPF tracing program to
something under rcu_read_lock() and then call bpf_rcu_read_lock() in the
BPF program then there could recursion? Wouldn't that be triggered even
with a single call to bpf_rcu_read_lock() ?

Thanks,
Puranjay

