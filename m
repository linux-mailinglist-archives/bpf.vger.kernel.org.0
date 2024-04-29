Return-Path: <bpf+bounces-28159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A79C8B63E0
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C101F22886
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5451411EF;
	Mon, 29 Apr 2024 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uzWh9Rro"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73E178CC4
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423979; cv=none; b=SPO85ooFfwkKRf/toKQmmZgmLStmT+8iI4MOlOfDKukQR9pacDJDZ5mN6QDuKyGitnDasWF91bF5Oc6+hd+IlpEtWGzcijEDms3x4IUTvVI5YX+oeqszalQCW0YPttgVf/b5kV9cmV7aE9IEVKKqN1CCHUderfQfSCCivpJCNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423979; c=relaxed/simple;
	bh=peoGXzXlulRjYIhPHPlekn/MzNMhxO20n8iawvLF7+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0V8CQddhizZx7mXU2fP8LP2yT2uQh+XE09m2VFnoOVz+jOPxNacCyeRqMB8ftO2dzn7Tss9f0DClHeAZj+llixIM6q/o7+kPYvgrlFbiFGcswGuNUMb7poCXHEJXZjAKLa7CUi/H5Zx4vwlo5bRowPxIZBkqrsrSjOgm7ANYrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uzWh9Rro; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c4d99195-f000-47f2-b167-12e76b705dc9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714423975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vq4bHF/aIWwzza6UHgmuWcUb2lBm4T0y/dplEW0rLRs=;
	b=uzWh9Rroe9EmdBRf2vTp1Qqv0BD020yiynBrgJzXam2GDym0EYQQsxhpJzI2U5/HtF7lEb
	LyrkZeJBUwWKSDfROj7apXa4ZXxd7OGGP2ryP6qwLrie0CFefAOXbDofvK2x1J3vyixC/r
	An0DDsMygDvnAS0HR4++FhdtbCBY4fE=
Date: Mon, 29 Apr 2024 13:52:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: fix bpf_ksym_exists in GCC
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 david.faust@oracle.com, cupertino.miranda@oracle.com
References: <20240428112559.10518-1-jose.marchesi@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240428112559.10518-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/28/24 4:25 AM, Jose E. Marchesi wrote:
> The macro bpf_ksym_exists is defined in bpf_helpers.h as:
>
>    #define bpf_ksym_exists(sym) ({								\
>    	_Static_assert(!__builtin_constant_p(!!sym), #sym " should be marked as __weak");	\
>    	!!sym;											\
>    })
>
> The purpose of the macro is to determine whether a given symbol has
> been defined, given the address of the object associated with the
> symbol.  It also has a compile-time check to make sure the object
> whose address is passed to the macro has been declared as weak, which
> makes the check on `sym' meaningful.
>
> As it happens, the check for weak doesn't work in GCC in all cases,
> because __builtin_constant_p not always folds at parse time when
> optimizing.  This is because optimizations that happen later in the
> compilation process, like inlining, may make a previously non-constant
> expression a constant.  This results in errors like the following when
> building the selftests with GCC:
>
>    bpf_helpers.h:190:24: error: expression in static assertion is not constant
>    190 |         _Static_assert(!__builtin_constant_p(!!sym), #sym " should be marked as __weak");       \
>        |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fortunately recent versions of GCC support a __builtin_has_attribute
> that can be used to directly check for the __weak__ attribute.  This
> patch changes bpf_helpers.h to use that builtin when building with a
> recent enough GCC, and to omit the check if GCC is too old to support
> the builtin.
>
> The macro used for GCC becomes:
>
>    #define bpf_ksym_exists(sym) ({									\
> 	_Static_assert(__builtin_has_attribute (*sym, __weak__), #sym " should be marked as __weak");	\
> 	!!sym;												\
>    })
>
> Note that since bpf_ksym_exists is designed to get the address of the
> object associated with symbol SYM, we pass *sym to
> __builtin_has_attribute instead of sym.  When an expression is passed
> to __builtin_has_attribute then it is the type of the passed
> expression that is checked for the specified attribute.  The
> expression itself is not evaluated.  This accommodates well with the
> existing usages of the macro:
>
> - For function objects:
>
>    struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym __weak;
>    [...]
>    bpf_ksym_exists(bpf_task_acquire)
>
> - For variable objects:
>
>    extern const struct rq runqueues __ksym __weak; /* typed */
>    [...]
>    bpf_ksym_exists(&runqueues)
>
> Note also that BPF support was added in GCC 10 and support for
> __builtin_has_attribute in GCC 9.

It would be great if you can share details with asm code and
BTF so we can understand better. I am not 100% sure about
whether __builtin_has_attribute builtin can help to do
run-time ksym resolution with libbpf.

The following is what clang does:

For example, for progs/test_ksyms_weak.c, we have
  43         if (rq && bpf_ksym_exists(&runqueues))
  44                 out__existing_typed = rq->cpu;
...
  56         if (!bpf_ksym_exists(bpf_task_acquire))
  57                 /* dead code won't be seen by the verifier */
  58                 bpf_task_acquire(0);

The asm code:

         .loc    0 42 20 prologue_end            # progs/test_ksyms_weak.c:42:20
.Ltmp0:
         r6 = runqueues ll
         r1 = runqueues ll
         w2 = 0
         call 153
.Ltmp1:
.Ltmp2:
         #DEBUG_VALUE: pass_handler:rq <- $r0
         .loc    0 43 9                          # progs/test_ksyms_weak.c:43:9
.Ltmp3:
         if r0 == 0 goto LBB0_3
.Ltmp4:
.Ltmp5:
# %bb.1:                                # %entry
         #DEBUG_VALUE: pass_handler:rq <- $r0
         if r6 == 0 goto LBB0_3
...
LBB0_5:                                 # %if.end4
         .loc    0 56 6 is_stmt 1                # progs/test_ksyms_weak.c:56:6
.Ltmp25:
         r1 = bpf_task_acquire ll
         if r1 != 0 goto LBB0_7
# %bb.6:                                # %if.then9

Here, 'runqueues' and 'bpf_task_acquire' will be changed by libbpf
based on the *current* kernel state. The BTF datasec encodes such ksym
information like below which will be used by libbpf:

         .long   13079                           # BTF_KIND_DATASEC(id = 395)
         .long   251658247                       # 0xf000007
         .long   0
         .long   377
         .long   bpf_task_acquire
         .long   0
         .long   379
         .long   bpf_testmod_test_mod_kfunc
         .long   0
         .long   381
         .long   invalid_kfunc
         .long   0
         .long   387
         .long   runqueues
         .long   3264
         .long   388
         .long   bpf_prog_active
         .long   1
         .long   389
         .long   bpf_link_fops1
         .long   1
         .long   391
         .long   bpf_link_fops2
         .long   4

What gcc generates for the above example? It would be great
if this can be put in the commit message.

>
> Locally tested in bpf-next master branch.
> No regressions.
>
> Signed-of-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> ---
>   tools/lib/bpf/bpf_helpers.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 62e1c0cc4a59..a720636a87d9 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -186,10 +186,19 @@ enum libbpf_tristate {
>   #define __kptr __attribute__((btf_type_tag("kptr")))
>   #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
>   
> +#if defined (__clang__)
>   #define bpf_ksym_exists(sym) ({									\
>   	_Static_assert(!__builtin_constant_p(!!sym), #sym " should be marked as __weak");	\
>   	!!sym;											\
>   })
> +#elif __GNUC__ > 8

| +#define bpf_ksym_exists(sym) ({									\

> +	_Static_assert(__builtin_has_attribute (*sym, __weak__), #sym " should be marked as __weak");	\
> +	!!sym;												\
> +})
> +#else
> +#define bpf_ksym_exists(sym) !!sym
> +#endif
>   
>   #define __arg_ctx __attribute__((btf_decl_tag("arg:ctx")))
>   #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))

