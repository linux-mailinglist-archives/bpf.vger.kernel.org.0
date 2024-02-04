Return-Path: <bpf+bounces-21171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D718490A1
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 22:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B793B2146E
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0685D28E3E;
	Sun,  4 Feb 2024 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pfr+cBKH"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51D288D9
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707081827; cv=none; b=Y4OTpWp8aVMKEtmQ641LBykB/7q1hjbMklSoQR+3HkbwzmxFrT6KnT982P0AQpxmqEZ2sUyZ/wZxj05vr4VAC9lxTUYuccqyzxjz7+g3d2ynXApdqlusiE+4PGQmd9qMhdCbobo2Jd0IKO29DsaSOYJaqk4f/scSU6C3gUQdEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707081827; c=relaxed/simple;
	bh=QEp08/RfQBlfOxoPiZe0keyH+hSYXyz06TTxAtVKJUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4PwwCH4av8LoXmAzq/BSlhQKGDGbs1223oVFaQ6hCbliQyEuwivvrGuCuLYGSyQxqnIs2vOKV8wmgSPhYAleZxz3rBmUcXuoKlqS3RaiTHWAL3lXC6j5VC7cDR3FZrIEIWmWAAxM3dJcndcjLyg81H6JAdujWLiDjYOm7k6oHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pfr+cBKH; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e008ab1-44b8-4d1b-a86d-1f347d7630e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707081823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gb4n3i9d9YrD1/hc+W/zDHVRkhOH4FHLZ91SX2y3OqY=;
	b=pfr+cBKHq1F7Jncrb/ZfVXYouidEfyDuPnCxWKktrpk5fD/qJj0Bpdtdq3Aoy18QonT6hf
	/mocdbcOzZ69VWXqvl4UlHMxbkWA7IKX/quT7ZUrBJsjYWZEkwnwAmC12KQL64kIEvJdT/
	x9ObYzjktidXFYPv0ewMKcYVhmuiy6c=
Date: Sun, 4 Feb 2024 13:23:33 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Allow calling static subprogs while
 holding a bpf_spin_lock
Content-Language: en-GB
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Barret Rhoden <brho@google.com>,
 David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
References: <20240204120206.796412-1-memxor@gmail.com>
 <20240204120206.796412-2-memxor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240204120206.796412-2-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2/4/24 4:02 AM, Kumar Kartikeya Dwivedi wrote:
> Currently, calling any helpers, kfuncs, or subprogs except the graph
> data structure (lists, rbtrees) API kfuncs while holding a bpf_spin_lock
> is not allowed. One of the original motivations of this decision was to
> force the BPF programmer's hand into keeping the bpf_spin_lock critical
> section small, and to ensure the execution time of the program does not
> increase due to lock waiting times. In addition to this, some of the
> helpers and kfuncs may be unsafe to call while holding a bpf_spin_lock.
>
> However, when it comes to subprog calls, atleast for static subprogs,
> the verifier is able to explore their instructions during verification.
> Therefore, it is similar in effect to having the same code inlined into
> the critical section. Hence, not allowing static subprog calls in the
> bpf_spin_lock critical section is mostly an annoyance that needs to be
> worked around, without providing any tangible benefit.
>
> Unlike static subprog calls, global subprog calls are not safe to permit
> within the critical section, as the verifier does not explore them
> during verification, therefore whether the same lock will be taken
> again, or unlocked, cannot be ascertained.
>
> Therefore, allow calling static subprogs within a bpf_spin_lock critical
> section, and only reject it in case the subprog linkage is global.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

SGTM with a small nit below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/verifier.c                                  | 10 +++++++---
>   tools/testing/selftests/bpf/progs/verifier_spin_lock.c |  2 +-
>   2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 64fa188d00ad..f858c959753b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9493,6 +9493,12 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   	if (subprog_is_global(env, subprog)) {
>   		const char *sub_name = subprog_name(env, subprog);
>   
> +		/* Only global subprogs cannot be called with a lock held. */
> +		if (env->cur_state->active_lock.ptr) {
> +			verbose(env, "function calls are not allowed while holding a lock\n");

Maybe explicit to mention "global function calls are not allowed ..."?

> +			return -EINVAL;
> +		}
> +
>   		if (err) {
>   			verbose(env, "Caller passes invalid args into func#%d ('%s')\n",
>   				subprog, sub_name);
> @@ -17644,7 +17650,6 @@ static int do_check(struct bpf_verifier_env *env)
>   
>   				if (env->cur_state->active_lock.ptr) {
>   					if ((insn->src_reg == BPF_REG_0 && insn->imm != BPF_FUNC_spin_unlock) ||
> -					    (insn->src_reg == BPF_PSEUDO_CALL) ||
>   					    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
>   					     (insn->off != 0 || !is_bpf_graph_api_kfunc(insn->imm)))) {
>   						verbose(env, "function calls are not allowed while holding a lock\n");
> @@ -17692,8 +17697,7 @@ static int do_check(struct bpf_verifier_env *env)
>   					return -EINVAL;
>   				}
>   process_bpf_exit_full:
> -				if (env->cur_state->active_lock.ptr &&
> -				    !in_rbtree_lock_required_cb(env)) {
> +				if (env->cur_state->active_lock.ptr && !env->cur_state->curframe) {
>   					verbose(env, "bpf_spin_unlock is missing\n");
>   					return -EINVAL;
>   				}

[...]


