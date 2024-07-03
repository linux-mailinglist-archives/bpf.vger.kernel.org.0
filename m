Return-Path: <bpf+bounces-33709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98413924C9A
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 02:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CB21C21B31
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF3646;
	Wed,  3 Jul 2024 00:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CE52NKp3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A0C621
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 00:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965257; cv=none; b=Y7Q6OSLHVLkvrKM/8Bqt33kw2FL7/zPZ0XGbLmjbGSnaJq36lf0CODk+Qo3PhJ9FOaUSHqyUE+eA8u+GRQntFMdQFgcFOJz88eHFtE0bb9u21Dj99V6JnXgyhcd4+y6zsZLdnRD4Xl1tHY8VGH6UJA3IrbX0/sp4OfWpY2sfvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965257; c=relaxed/simple;
	bh=mVVaIH1nTY8tv8G9c5MEymsjqrLr8e+PBD+Yf6To0gU=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=CBk3kH6Wj9vCrP2fMayp7aiuPuiySeds/HyRBXT5noHAgqL1JtxJzPMQ098CeoGx1yNnWqgDSUx2PmtlKHhIfHbuiJWIz7LMwIko7ocAB48/ICLne7JrMhYj7c4UysTo6iDP/eKprsOZ6eKXYQGhPeWoM5FY/JRzKDv4fJSbnlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CE52NKp3; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48f415262f5so1608980137.1
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 17:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719965255; x=1720570055; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+2N80Zil11BvOBZnEohMK2fQHMcVeNk7LshNUQFw9wM=;
        b=CE52NKp356mgM1xkPbuP19O4XeeGZqJjYYVg7i0yMjmbfgraWi0Wt4QwU+L3qJZuxq
         GfK4ToBZUvO2cvP98/qTwMVG7DaLWHY1z6JdgoO9tDhfKsDdG3nRBRzktqPP5xBKYMqg
         IhQhXx+LwX9EZcmQ2MXYD/PMOeERMLpfTw16jZT+M9sE06n8pqJsjmi5JhSmDChIYdbf
         F/BJK/DHsjocAHgpk2B5N1NI8DRwX/lLGdgr8t1CHIU52eCPkqzMPtvEorRLuOGPWMF7
         J5MwdkcdjzbVndEJR2k3g3y6SlY9FDXVdeJ3MQOeQYsjBt+MyPgpSoMiv8HMKHyoCTaf
         jIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719965255; x=1720570055;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2N80Zil11BvOBZnEohMK2fQHMcVeNk7LshNUQFw9wM=;
        b=ecfdUlXS4w4uK8kkCNoujdRon0wxkKlkIy0Q1v1s93bxoTXNucdKsuXN9G39SgZIol
         VZ6AjHuogklMUwnpn8D+6ONRj/DsrQQ54VDAL25XLsLB7peIxFWlWNJha5Z3gCjuc2Xz
         fDzQZG+Pzhi7UPyAe5HAajhnXcHJa8eJV+IwH6qmGAjssUsMezTm2vf37hXmKlpQqmaN
         PeNWoberBXUYAZCTzCuNSa/if7kxHIPzsOWYUUUp5O0YQkWfzTxckPyw/kVr0lHUI2+2
         ml6V/1retM/Crsb9krwm5Cs6en0Gh8PIWbjakDuoP/MHWwOSRGMktD+drbrx3XgdjUb3
         2l3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiEcUMHtETSpeN5Uua718gHQRlwPvDYrItB1os9m5zgaoKUwFJDhp/CMYjJm0krPdvGxmfKw4lLeeriVaAbiB1K2j9
X-Gm-Message-State: AOJu0YxmHBJXovVdP4WPGgN16fdqOzKRkPMlf0TCrw8eNF0zEOVaT85A
	IjCgQAWvAnlfaHji95vXRGAFT4w7/2UG26+8bQKaJdzjVMxX3Rq3yifoHIYASg==
X-Google-Smtp-Source: AGHT+IEaTCdcFmQNXFfrbtO/U7agFak2ag7L8iLLl/TBN8HY+XL1ENqwingrbQ1P6ci38oCC/muhQQ==
X-Received: by 2002:a05:6102:6d1:b0:48f:ba1e:8ce4 with SMTP id ada2fe7eead31-48fba1e8df6mr10832272137.5.1719965254668;
        Tue, 02 Jul 2024 17:07:34 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d80d85f1asm354933285a.69.2024.07.02.17.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 17:07:34 -0700 (PDT)
Date: Tue, 02 Jul 2024 20:07:33 -0400
Message-ID: <ce279e1f9a4e4226e7a87a7e2440fbe4@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net, renauld@google.com, revest@chromium.org, song@kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH v13 3/5] security: Replace indirect LSM hook calls with  static calls
References: <20240629084331.3807368-4-kpsingh@kernel.org>
In-Reply-To: <20240629084331.3807368-4-kpsingh@kernel.org>

On Jun 29, 2024 KP Singh <kpsingh@kernel.org> wrote:
> 
> LSM hooks are currently invoked from a linked list as indirect calls
> which are invoked using retpolines as a mitigation for speculative
> attacks (Branch History / Target injection) and add extra overhead which
> is especially bad in kernel hot paths:
> 
> security_file_ioctl:
>    0xff...0320 <+0>:	endbr64
>    0xff...0324 <+4>:	push   %rbp
>    0xff...0325 <+5>:	push   %r15
>    0xff...0327 <+7>:	push   %r14
>    0xff...0329 <+9>:	push   %rbx
>    0xff...032a <+10>:	mov    %rdx,%rbx
>    0xff...032d <+13>:	mov    %esi,%ebp
>    0xff...032f <+15>:	mov    %rdi,%r14
>    0xff...0332 <+18>:	mov    $0xff...7030,%r15
>    0xff...0339 <+25>:	mov    (%r15),%r15
>    0xff...033c <+28>:	test   %r15,%r15
>    0xff...033f <+31>:	je     0xff...0358 <security_file_ioctl+56>
>    0xff...0341 <+33>:	mov    0x18(%r15),%r11
>    0xff...0345 <+37>:	mov    %r14,%rdi
>    0xff...0348 <+40>:	mov    %ebp,%esi
>    0xff...034a <+42>:	mov    %rbx,%rdx
> 
>    0xff...034d <+45>:	call   0xff...2e0 <__x86_indirect_thunk_array+352>
>    			       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>     Indirect calls that use retpolines leading to overhead, not just due
>     to extra instruction but also branch misses.
> 
>    0xff...0352 <+50>:	test   %eax,%eax
>    0xff...0354 <+52>:	je     0xff...0339 <security_file_ioctl+25>
>    0xff...0356 <+54>:	jmp    0xff...035a <security_file_ioctl+58>
>    0xff...0358 <+56>:	xor    %eax,%eax
>    0xff...035a <+58>:	pop    %rbx
>    0xff...035b <+59>:	pop    %r14
>    0xff...035d <+61>:	pop    %r15
>    0xff...035f <+63>:	pop    %rbp
>    0xff...0360 <+64>:	jmp    0xff...47c4 <__x86_return_thunk>
> 
> The indirect calls are not really needed as one knows the addresses of
> enabled LSM callbacks at boot time and only the order can possibly
> change at boot time with the lsm= kernel command line parameter.
> 
> An array of static calls is defined per LSM hook and the static calls
> are updated at boot time once the order has been determined.
> 
> A static key guards whether an LSM static call is enabled or not,
> without this static key, for LSM hooks that return an int, the presence
> of the hook that returns a default value can create side-effects which
> has resulted in bugs [1].

I believe there have been improvements in the LSM framework since the
original problems were reported and I'm not entirely sure if this is
still a problem.  In particular I believe that commit
260017f31a8c ("lsm: use default hook return value in call_int_hook()")
and 61df7b828204 ("lsm: fixup the inode xattr capability handling")
should fix the more obvious problems.  I'd like to know if you are
aware of any others?  If not, the text above should be adjusted and
we should reconsider patch 5/5.  If there are other problems I'd
like to better understand them as there may be an independent
solution for those particular problems.

> With the hook now exposed as a static call, one can see that the
> retpolines are no longer there and the LSM callbacks are invoked
> directly:
> 
> security_file_ioctl:
>    0xff...0ca0 <+0>:	endbr64
>    0xff...0ca4 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xff...0ca9 <+9>:	push   %rbp
>    0xff...0caa <+10>:	push   %r14
>    0xff...0cac <+12>:	push   %rbx
>    0xff...0cad <+13>:	mov    %rdx,%rbx
>    0xff...0cb0 <+16>:	mov    %esi,%ebp
>    0xff...0cb2 <+18>:	mov    %rdi,%r14
>    0xff...0cb5 <+21>:	jmp    0xff...0cc7 <security_file_ioctl+39>
>   			       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    Static key enabled for SELinux
> 
>    0xffffffff818f0cb7 <+23>:	jmp    0xff...0cde <security_file_ioctl+62>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>    Static key enabled for BPF LSM. This is something that is changed to
>    default to false to avoid the existing side effect issues of BPF LSM
>    [1] in a subsequent patch.
> 
>    0xff...0cb9 <+25>:	xor    %eax,%eax
>    0xff...0cbb <+27>:	xchg   %ax,%ax
>    0xff...0cbd <+29>:	pop    %rbx
>    0xff...0cbe <+30>:	pop    %r14
>    0xff...0cc0 <+32>:	pop    %rbp
>    0xff...0cc1 <+33>:	cs jmp 0xff...0000 <__x86_return_thunk>
>    0xff...0cc7 <+39>:	endbr64
>    0xff...0ccb <+43>:	mov    %r14,%rdi
>    0xff...0cce <+46>:	mov    %ebp,%esi
>    0xff...0cd0 <+48>:	mov    %rbx,%rdx
>    0xff...0cd3 <+51>:	call   0xff...3230 <selinux_file_ioctl>
>    			       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    Direct call to SELinux.
> 
>    0xff...0cd8 <+56>:	test   %eax,%eax
>    0xff...0cda <+58>:	jne    0xff...0cbd <security_file_ioctl+29>
>    0xff...0cdc <+60>:	jmp    0xff...0cb7 <security_file_ioctl+23>
>    0xff...0cde <+62>:	endbr64
>    0xff...0ce2 <+66>:	mov    %r14,%rdi
>    0xff...0ce5 <+69>:	mov    %ebp,%esi
>    0xff...0ce7 <+71>:	mov    %rbx,%rdx
>    0xff...0cea <+74>:	call   0xff...e220 <bpf_lsm_file_ioctl>
>    			       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    Direct call to BPF LSM.
> 
>    0xff...0cef <+79>:	test   %eax,%eax
>    0xff...0cf1 <+81>:	jne    0xff...0cbd <security_file_ioctl+29>
>    0xff...0cf3 <+83>:	jmp    0xff...0cb9 <security_file_ioctl+25>
>    0xff...0cf5 <+85>:	endbr64
>    0xff...0cf9 <+89>:	mov    %r14,%rdi
>    0xff...0cfc <+92>:	mov    %ebp,%esi
>    0xff...0cfe <+94>:	mov    %rbx,%rdx
>    0xff...0d01 <+97>:	pop    %rbx
>    0xff...0d02 <+98>:	pop    %r14
>    0xff...0d04 <+100>:	pop    %rbp
>    0xff...0d05 <+101>:	ret
>    0xff...0d06 <+102>:	int3
>    0xff...0d07 <+103>:	int3
>    0xff...0d08 <+104>:	int3
>    0xff...0d09 <+105>:	int3
> 
> While this patch uses static_branch_unlikely indicating that an LSM hook
> is likely to be not present. In most cases this is still a better choice
> as even when an LSM with one hook is added, empty slots are created for
> all LSM hooks (especially when many LSMs that do not initialize most
> hooks are present on the system).
> 
> There are some hooks that don't use the call_int_hook and
> call_void_hook.

I think you mean "or" and not "and", yes?

> These hooks are updated to use a new macro called
> lsm_for_each_hook where the lsm_callback is directly invoked as an
> indirect call. These are updated in a subsequent patch to also use
> static calls.
> 
> Below are results of the relevant Unixbench system benchmarks with BPF LSM
> and SELinux enabled with default policies enabled with and without these
> patches.
> 
> Benchmark                                               Delta(%): (+ is better)
> ===============================================================================
> Execl Throughput                                             +1.9356
> File Write 1024 bufsize 2000 maxblocks                       +6.5953
> Pipe Throughput                                              +9.5499
> Pipe-based Context Switching                                 +3.0209
> Process Creation                                             +2.3246
> Shell Scripts (1 concurrent)                                 +1.4975
> System Call Overhead                                         +2.7815
> System Benchmarks Index Score (Partial Only):                +3.4859
> 
> In the best case, some syscalls like eventfd_create benefitted to about ~10%.
> 
> [1] https://lore.kernel.org/linux-security-module/20220609234601.2026362-1-kpsingh@kernel.org/
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/lsm_hooks.h |  72 ++++++++++++--
>  security/security.c       | 198 ++++++++++++++++++++++++++------------
>  2 files changed, 197 insertions(+), 73 deletions(-)

...

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index efd4a0655159..a66ca68485a2 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -30,19 +30,66 @@
>  #include <linux/init.h>
>  #include <linux/rculist.h>
>  #include <linux/xattr.h>
> +#include <linux/static_call.h>
> +#include <linux/unroll.h>
> +#include <linux/jump_label.h>
> +#include <linux/lsm_count.h>
> +
> +#define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK##_##IDX
> +
> +/*
> + * Identifier for the LSM static calls.
> + * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
> + * IDX is the index of the static call. 0 <= NUM < MAX_LSM_COUNT
> + */
> +#define LSM_STATIC_CALL(HOOK, IDX) lsm_static_call_##HOOK##_##IDX
> +
> +/*
> + * Call the macro M for each LSM hook MAX_LSM_COUNT times.
> + */
> +#define LSM_LOOP_UNROLL(M, ...) 		\
> +do {						\
> +	UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)	\
> +} while (0)
> +
> +#define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)

All of the macros above (SECURITY_HOOK_ACTIVE_KEY, LSM_STATIC_CALL,
LSM_LOOP_UNROLL, and LSM_DEFINE_UNROLL) are only used in
security/security.c, yes?  If so, is there a reason why they are
defined here and not in security/security.c?

> diff --git a/security/security.c b/security/security.c
> index 9c3fb2f60e2a..e0ec185cf125 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -112,6 +113,51 @@ static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
>  static __initdata struct lsm_info **ordered_lsms;
>  static __initdata struct lsm_info *exclusive;
>  
> +
> +#ifdef CONFIG_HAVE_STATIC_CALL
> +#define LSM_HOOK_TRAMP(NAME, NUM) \
> +	&STATIC_CALL_TRAMP(LSM_STATIC_CALL(NAME, NUM))
> +#else
> +#define LSM_HOOK_TRAMP(NAME, NUM) NULL
> +#endif
> +
> +/*
> + * Define static calls and static keys for each LSM hook.
> + */
> +
> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)			\
> +	DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),		\
> +				*((RET(*)(__VA_ARGS__))NULL));		\
> +	DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ACTIVE_KEY(NAME, NUM));
> +
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
> +	LSM_DEFINE_UNROLL(DEFINE_LSM_STATIC_CALL, NAME, RET, __VA_ARGS__)
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +#undef DEFINE_LSM_STATIC_CALL

If you end up respinning the patchset, drop the two blank lines
before the DEFINE_LSM_STATIC_CALL and LSM_HOOK definitions.

> @@ -856,29 +916,43 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
>   * call_int_hook:
>   *	This is a hook that returns a value.
>   */
> +#define __CALL_STATIC_VOID(NUM, HOOK, ...)				     \
> +do {									     \
> +	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {    \
> +		static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);	     \
> +	}								     \
> +} while (0);
>  
> -#define call_void_hook(FUNC, ...)				\
> -	do {							\
> -		struct security_hook_list *P;			\
> -								\
> -		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
> -			P->hook.FUNC(__VA_ARGS__);		\
> +#define call_void_hook(HOOK, ...)                                 \
> +	do {                                                      \
> +		LSM_LOOP_UNROLL(__CALL_STATIC_VOID, HOOK, __VA_ARGS__); \
>  	} while (0)
>  
> -#define call_int_hook(FUNC, ...) ({				\
> -	int RC = LSM_RET_DEFAULT(FUNC);				\
> -	do {							\
> -		struct security_hook_list *P;			\
> -								\
> -		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> -			RC = P->hook.FUNC(__VA_ARGS__);		\
> -			if (RC != LSM_RET_DEFAULT(FUNC))	\
> -				break;				\
> -		}						\
> -	} while (0);						\
> -	RC;							\
> +
> +#define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)			     \
> +do {									     \
> +	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
> +		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
> +		if (R != LSM_RET_DEFAULT(HOOK))				     \
> +			goto LABEL;					     \
> +	}								     \
> +} while (0);
> +
> +#define call_int_hook(HOOK, ...)					\
> +({									\
> +	__label__ out;							\

This is another only-if-you-respin, consider /out/OUT/ so it is more
consistent.

> +	int RC = LSM_RET_DEFAULT(HOOK);					\
> +									\
> +	LSM_LOOP_UNROLL(__CALL_STATIC_INT, RC, HOOK, out, __VA_ARGS__);	\
> +out:									\
> +	RC;								\
>  })
>  
> +#define lsm_for_each_hook(scall, NAME)					\
> +	for (scall = static_calls_table.NAME;				\
> +	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
> +		if (static_key_enabled(&scall->active->key))

This is probably a stupid question, but why use static_key_enabled()
here instead of static_branch_unlikely() as in the call_XXX_macros?

--
paul-moore.com

