Return-Path: <bpf+bounces-68663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F75B7F94F
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFED148671F
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F9C330D53;
	Wed, 17 Sep 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOUvXG9i"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1321B330D4D
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116702; cv=none; b=PsxoZxQ1hc6W53pPQMQp+j4woRREBMpLJ/wekRpyHC9KdD9BRUW+vA1d5G3KnBA8HpGjGCMDJWlVmJxO0wtJxtPhqPTjocolwCyL80RQ7ZshZqVMn4xbqGzEAhZzEk/QBI3qY5ZFDMf2JOA4uB8augsLzxI25t8FLGMpuc/4ev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116702; c=relaxed/simple;
	bh=ZrM7NxEPG9q7v0fuEOVfsyFVzTAGKpYj1ulXETGAELQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V+4PEng3vFI0hi+yFBifTIzhZ4cuc1zIPhGP8PScOA+j9OtBuf8NCm8cbcmMJzlyhL7ygyLFm72EjosSzOVe49RIqGhhIuiEZirH2AmyDiMdt92AmB1hvj8gQyESNHttR6cbkOPRAPKoS8ZrVztL0JbAk2SapRtTKtvyoBdUYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOUvXG9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE04C4CEF0;
	Wed, 17 Sep 2025 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758116701;
	bh=ZrM7NxEPG9q7v0fuEOVfsyFVzTAGKpYj1ulXETGAELQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QOUvXG9ivqyi9wokJvJP4AK1lP0WjSZE4mi9x6zW+u7EoMDmVmrcruHquUKjFVwbT
	 Y83zu0k+5J9nR7PnJk49oQXkHMgv2sgGnBIryuPrLH8RKfbb7nbWG26Th1usOGqy4s
	 w3K6kj2qiU4AoEr+IUFunvTjMbuV5fE5ghbjqwyyB5haVC8/RLVoPotu8kBD8h1sAH
	 6nKfF4s8WacrebnIJuv3G7WeqY8GlRpek9OM+Tfc5mswsLz7bF9E7DKWTIzEUYNwgR
	 PxfCnp6WJexAE41DXqsz/lYfi/K7OfVy8Dh0iDewt2AI1dqMOFhwA3a4eQmAxXCfn/
	 OKS6Amy3ieabA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] bpf: support nested rcu critical sections
In-Reply-To: <ea1536afc399eeda111f6f8e7c45ba81108fef6d.camel@gmail.com>
References: <20250916113622.19540-1-puranjay@kernel.org>
 <ea1536afc399eeda111f6f8e7c45ba81108fef6d.camel@gmail.com>
Date: Wed, 17 Sep 2025 13:44:58 +0000
Message-ID: <mb61pcy7pqjl1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Tue, 2025-09-16 at 11:36 +0000, Puranjay Mohan wrote:
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
>> @@ -13874,22 +13874,22 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  		}
>>  
>>  		if (rcu_lock) {
>> -			verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
>> -			return -EINVAL;
>> +			env->cur_state->active_rcu_locks++;
>>  		} else if (rcu_unlock) {
>> -			bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mask, ({
>> -				if (reg->type & MEM_RCU) {
>> -					reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
>> -					reg->type |= PTR_UNTRUSTED;
>> -				}
>> -			}));
>> -			env->cur_state->active_rcu_lock = false;
>> +			if (--env->cur_state->active_rcu_locks == 0) {
>> +				bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mask, ({
>> +					if (reg->type & MEM_RCU) {
>> +						reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
>> +						reg->type |= PTR_UNTRUSTED;
>> +					}
>> +				}));
>> +			}
>>  		} else if (sleepable) {
>>  			verbose(env, "kernel func %s is sleepable within rcu_read_lock region\n", func_name);
>>  			return -EACCES;
>>  		}
>>  	} else if (rcu_lock) {
>> -		env->cur_state->active_rcu_lock = true;
>> +		env->cur_state->active_rcu_locks++;
>>  	} else if (rcu_unlock) {
>>  		verbose(env, "unmatched rcu read unlock (kernel function %s)\n", func_name);
>>  		return -EINVAL;
>
> Nit: active_rcu_locks increment in two places can be avoided e.g. as follows:
>
>         if (rcu_lock) {
>                 env->cur_state->active_rcu_locks++;
>         } else if (rcu_unlock) {
>                 struct bpf_func_state *state;
>                 struct bpf_reg_state *reg;
>                 u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
>
>                 if (env->cur_state->active_rcu_locks == 0) {
>                         verbose(private_data: env, fmt: "unmatched rcu read unlock (kernel function %s)\n", func_name);
>                         return -EINVAL;
>                 }
>                 if (--env->cur_state->active_rcu_locks == 0) {
>                         bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg, clear_mask, ({
>                                 if (reg->type & MEM_RCU) {
>                                         reg->type &= ~(MEM_RCU | PTR_MAYBE_NULL);
>                                         reg->type |= PTR_UNTRUSTED;
>                                 }
>                         }));
>                 }
>         } else if (sleepable) {
>                 verbose(private_data: env, fmt: "kernel func %s is sleepable within rcu_read_lock region\n", func_name);
>                 return -EACCES;
>         }
>
>         if (in_rbtree_lock_required_cb(env) && (rcu_lock || rcu_unlock)) {
>                 verbose(private_data: env, fmt: "Calling bpf_rcu_read_{lock,unlock} in unnecessary rbtree callback\n");
>                 return -EACCES;
>         }
>
> [...]

I agree, this looks better. Will use it in the next version.

Thanks,
Puranjay

