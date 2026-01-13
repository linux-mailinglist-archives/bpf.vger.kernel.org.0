Return-Path: <bpf+bounces-78761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1F2D1B86F
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 23:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1BB630519D0
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 22:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008EE352FBC;
	Tue, 13 Jan 2026 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nD8b1xSf"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E22F363E;
	Tue, 13 Jan 2026 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341810; cv=none; b=SS7YbJc+7zbgZKWaaPnLtbtdTBrUoO45rz/3Y7ITSg7bMlzE4MHOAgv1WbOXhwk4//VdWZ+g9kL05ztbmAK69KkwYQDsYww5a1cgluwiHvUUHD5oC96jZMDd21rS1Z2VDK/UsTUvq5P92JAI9RXNpeHrR/k5KBAOMOVRlA/6XW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341810; c=relaxed/simple;
	bh=zWgeOzkHWbUnOGy9lzs8A4WO+6iwOfUjhJDj+GuY7Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PV8kWBvr7US52AtFxs1kh/V/WgRyCQRVKgL5wMIJM2Bu85Pz2aiKlywU2lfubtLoTq2JfAimaDLZIUi2KAEAiRw1SxSLxHXt8P8OSbJt8Vx838YulqfO3V5MF+jO0mMU2gBHTOETfKNXvMQFAgnSeAI872a7Fq7EL+9xBV3dO/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nD8b1xSf; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <93ecdc25-aa5e-485b-8ff4-a9db3b585861@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768341796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZE+DFQEijKauPk9j7KAXgeZ4o6kVJeDdPUaXV+RBwo=;
	b=nD8b1xSf1wwe1ZHIrh1U6Wgk494o/U3108fTJshJqTpCJCqrIeMdO2/h0QvduJQ8LhM2y0
	1Hl/Ungpc/1/hSEsC+azX8O+xC1cSv68YndnaTWReelZm+//VrNM2qzUvNDjXgw9DTrLnE
	W6LlPRtNVAWkEUdhf5a9Y0qkemXTT6c=
Date: Tue, 13 Jan 2026 14:03:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for
 KF_IMPLICIT_ARGS
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, sched-ext@lists.linux.dev
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-4-ihor.solodrai@linux.dev>
 <952853dd064d5303a7e7ec8e58028e9ee88f2fad.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <952853dd064d5303a7e7ec8e58028e9ee88f2fad.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/13/26 12:39 PM, Eduard Zingerman wrote:
> On Fri, 2026-01-09 at 10:48 -0800, Ihor Solodrai wrote:
>> A kernel function bpf_foo marked with KF_IMPLICIT_ARGS flag is
>> expected to have two associated types in BTF:
>>   * `bpf_foo` with a function prototype that omits implicit arguments
>>   * `bpf_foo_impl` with a function prototype that matches the kernel
>>      declaration of `bpf_foo`, but doesn't have a ksym associated with
>>      its name
>>
>> In order to support kfuncs with implicit arguments, the verifier has
>> to know how to resolve a call of `bpf_foo` to the correct BTF function
>> prototype and address.
>>
>> To implement this, in add_kfunc_call() kfunc flags are checked for
>> KF_IMPLICIT_ARGS. For such kfuncs a BTF func prototype is adjusted to
>> the one found for `bpf_foo_impl` (func_name + "_impl" suffix, by
>> convention) function in BTF.
>>
>> This effectively changes the signature of the `bpf_foo` kfunc in the
>> context of verification: from one without implicit args to the one
>> with full argument list.
>>
>> Whether a kfunc argument is implicit or not is determined by
>> is_kfunc_arg_implicit(). The values of implicit arguments by design
>> are provided by the verifier, and so they can only be of particular
>> types. In this patch the only allowed implicit arg type is a pointer
>> to struct bpf_prog_aux. The __prog args (usually void *) are also
>> considered implicit for backwards compatibility.
>>
>> In order to enable the verifier to correctly set an implicit
>> bpf_prog_aux arg value at runtime, is_kfunc_arg_prog() is extended to
>> check for the arg type. At a point when prog arg is determined in
>> check_kfunc_args() the kfunc with implicit args already has a
>> prototype with full argument list, so the existing value patch
>> mechanism just works.
>>
>> If a new kfunc with KF_IMPLICIT_ARG is declared for an existing kfunc
>> that uses a __prog argument (a legacy case), the prototype
>> substitution works in exactly the same way, assuming the kfunc follows
>> the _impl naming convention. The difference is only in how _impl
>> prototype is added to the BTF, which is not the verifier's
>> concern. See a subsequent resolve_btfids patch for details.
>>
>> In check_kfunc_call() reset the subreg_def of registers holding
>> implicit arguments to correctly track zero extensions.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
> 
> Overall lgtm.
> 
> [...]
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> 
> [...]
> 
>> @@ -14303,6 +14358,17 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  	for (i = 0; i < nargs; i++) {
>>  		u32 regno = i + 1;
>>  
>> +		/*
>> +		 * Implicit kfunc arguments are set after main verification pass.
>> +		 * For correct tracking of zero-extensions we have to reset subreg_def for such
>> +		 * args. Otherwise mark_btf_func_reg_size() will be inspecting subreg_def of regs
>> +		 * from an earlier (irrelevant) point in the program, which may lead to an error
>> +		 * in opt_subreg_zext_lo32_rnd_hi32().
>> +		 */
>> +		if (unlikely(KF_IMPLICIT_ARGS & meta.kfunc_flags
>> +				&& is_kfunc_arg_implicit(desc_btf, &args[i])))
>> +			regs[regno].subreg_def = DEF_NOT_SUBREG;
>> +
> 
> Did you try doing this in `mark_reg_not_init()`?
> This function is called for R1-R5 some time prior this hunk.

> Did you try doing this in `mark_reg_not_init()`?

Just tried, it doesn't work because REG0 is considered a caller saved
register, and so it breaks the zext tracking:

        #define CALLER_SAVED_REGS 6
        static const int caller_saved[CALLER_SAVED_REGS] = {
	     BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
        };

        [...]

	for (i = 0; i < CALLER_SAVED_REGS; i++)
		mark_reg_not_init(env, regs, caller_saved[i]);

CI run for the diff below (on top of this series):
https://github.com/kernel-patches/bpf/actions/runs/20972520708


diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b4e40b87e8fa..8bbcd1466815 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2784,6 +2784,8 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
        }
 }
 
+#define DEF_NOT_SUBREG (0)
+
 /* Mark a register as having a completely unknown (scalar) value. */
 static void __mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 {
@@ -2798,6 +2800,7 @@ static void __mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
        reg->var_off = tnum_unknown;
        reg->frameno = 0;
        reg->precise = false;
+       reg->subreg_def = DEF_NOT_SUBREG;
        __mark_reg_unbounded(reg);
 }
 
@@ -2892,7 +2895,6 @@ static int mark_btf_ld_reg(struct bpf_verifier_env *env,
        }
 }
 
-#define DEF_NOT_SUBREG (0)
 static void init_reg_state(struct bpf_verifier_env *env,
                           struct bpf_func_state *state)
 {
@@ -14363,17 +14365,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
        for (i = 0; i < nargs; i++) {
                u32 regno = i + 1;
 
-               /*
-                * Implicit kfunc arguments are set after main verification pass.
-                * For correct tracking of zero-extensions we have to reset subreg_def for such
-                * args. Otherwise mark_btf_func_reg_size() will be inspecting subreg_def of regs
-                * from an earlier (irrelevant) point in the program, which may lead to an error
-                * in opt_subreg_zext_lo32_rnd_hi32().
-                */
-               if (unlikely(KF_IMPLICIT_ARGS & meta.kfunc_flags
-                               && is_kfunc_arg_implicit(desc_btf, &args[i])))
-                       regs[regno].subreg_def = DEF_NOT_SUBREG;
-
                t = btf_type_skip_modifiers(desc_btf, args[i].type, NULL);
                if (btf_type_is_ptr(t))
                        mark_btf_func_reg_size(env, regno, sizeof(void *));

---

Resetting all reg args appears to be working however (see below).
CI: https://github.com/kernel-patches/bpf/actions/runs/20973490221

Should I send this as a separate patch?

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8bbcd1466815..9dfcf3149841 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2800,7 +2800,6 @@ static void __mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
        reg->var_off = tnum_unknown;
        reg->frameno = 0;
        reg->precise = false;
-       reg->subreg_def = DEF_NOT_SUBREG;
        __mark_reg_unbounded(reg);
 }
 
@@ -14241,6 +14240,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
        for (i = 0; i < CALLER_SAVED_REGS; i++)
                mark_reg_not_init(env, regs, caller_saved[i]);
 
+       for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
+               u32 regno = i + 1;
+               regs[regno].subreg_def = DEF_NOT_SUBREG;
+       }
+
        /* Check return type */
        t = btf_type_skip_modifiers(desc_btf, meta.func_proto->type, NULL);


> What I don't like from structural point of view is:
> - `is_kfunc_arg_implicit()` depends on KF_IMPLICIT_ARGS, but that
>   check is done externally. Hence, the naming is misleading or 'meta'
>   should be passed to `is_kfunc_arg_implicit()`.
> - doing DEF_NOT_SUBREG logically has not much to do with implicit args,
>   so it is a bit confusing that is pre-conditioned like that.
> 
>>  		t = btf_type_skip_modifiers(desc_btf, args[i].type, NULL);
>>  		if (btf_type_is_ptr(t))
>>  			mark_btf_func_reg_size(env, regno, sizeof(void *));


