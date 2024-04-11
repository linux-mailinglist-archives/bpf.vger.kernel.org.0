Return-Path: <bpf+bounces-26464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0B98A04D8
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 02:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC361F24544
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 00:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329418BEE;
	Thu, 11 Apr 2024 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eshBCA+0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8F13201
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712795920; cv=none; b=keWaH5k8zQ8DjV+BxOSowrxCqGTRbbXjjgw/GohVV0gspRrbKx9D1oZj16LxFPH5luj0cDcTZ0NFutIZ61GHwmgpRScyu+UmlxBG9OmO8+W7PLDzwfblYSmIPJn9FWugA4gbYiY3PLurI4l0ihvlBK7X2HCLBV9a1lad4ghUB/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712795920; c=relaxed/simple;
	bh=xfByhxGSZPHYk57/68I+sENbrgCfz+Z9gVHvNYodlis=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=q0l53l8aM/gd4Kao9ahOkum+XUXE9KlmZ1CEwyItjq4dZaxkNTlLEvT0NsXF775phQpcu5ayJwrTpksujxzFWwmHL6Hyev8Lf+5/lYTdWvvObcqOL1ErjO47gJd/ywP5SMkl5njSp/TQnO08VOan3+p4Uo/009jO5xceqffqmSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eshBCA+0; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78d5e80bc42so361907785a.0
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 17:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712795917; x=1713400717; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RPX96ZNDhuWGsa5rAJ3iw0YJfisfICCbql0pYn3u5YY=;
        b=eshBCA+07WIvVnP/Z3AAGM5BxYVHi1u0jkRLQna4maiqzkNStjO+fLhsE6oLFfI1xc
         wBW4LezI0ejabqheOTQ4Nc5CTGjIaY0dSC2X6gx9/mg/Ark+nVgKrZrZViMIngCyRqKz
         k4gSakqVhaKYP7hXHcjM4s1J3bqAKkTM2DWMtpLYjqGOdRv99KCthu+F/02U1vaeGE4W
         ZM+4G1ep61VDRGZ157jbbgLtgdv1OkkUzz5xZQPba+gLyQKCLHRUk7oekzo6ExC763pS
         tqANqOb3ayKYKh1nnVezmUqD1LrmdPutxJheUvWGvd6zv66soJR+3Jbsb9AAHrf9yjn8
         d6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712795917; x=1713400717;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPX96ZNDhuWGsa5rAJ3iw0YJfisfICCbql0pYn3u5YY=;
        b=wKZpkLelsQd9SvLfvDuY+Vakqb2e6ZS89wK+885wwDU+n7m6GiQuEQuzAMDOABXNpy
         t5fU5FgpdrcAiBngspih0jioW02O8bp+F41/QVNsFvRFPLoUZVCHCQq7Ki3+4OXPer2y
         T0sNeXbo37o9pGITNFQi4jkw09019AS2/SEPzOFJUrj1ol9IgWufa+kl+2e7Z6FnkR/u
         7fkys/c9Jd0CDIZRnIY5I2EBtKpms9YzktPQCYJ8Qfh7mxs86U5YHTu5EdYaZBG/Kkk+
         D/HMi07VOUiV+aGAgC1YLAkCNfF4LUNpXUWvrHzZmDZY+0ioOyZSPG13p0KlNfyRxHtD
         bbZA==
X-Forwarded-Encrypted: i=1; AJvYcCXieJ9Fw1BXrYCh4wk0f4n8E3rIol9Yz3rJMY/B0gViA7eQo7rYfuNrhLa4xzy8QUrS+CEXAZb+4CNJT/0UjJqXZRoK
X-Gm-Message-State: AOJu0Yz7Pg8K5f9Rinwl+xicjRuJ2sWsrIh3ZYs97B3WGnalWUCD59So
	6ClieuyYKmaoHxYafriKmPNHyltIOwrlmcdg4qn/h9PdTPujjHucegCqHISSaA==
X-Google-Smtp-Source: AGHT+IFZk9jV6HWOSfYfFPndAyK/OuIye90XX09KufepxQhdyDOcvTYA8UkLyVR9CrirRlKYQ/mr3Q==
X-Received: by 2002:a05:620a:1208:b0:78b:eb13:8912 with SMTP id u8-20020a05620a120800b0078beb138912mr4227406qkj.35.1712795917044;
        Wed, 10 Apr 2024 17:38:37 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x18-20020a05620a14b200b0078be30219d3sm275302qkj.74.2024.04.10.17.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:38:36 -0700 (PDT)
Date: Wed, 10 Apr 2024 20:38:35 -0400
Message-ID: <a6689b0b5564461b829a18379eb3e83f@paul-moore.com>
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
To: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org, daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com, andrii@kernel.org, kpsingh@kernel.org
Subject: Re: [PATCH v9 3/4] security: Replace indirect LSM hook calls with  static calls
References: <20240207124918.3498756-4-kpsingh@kernel.org>
In-Reply-To: <20240207124918.3498756-4-kpsingh@kernel.org>

On Feb  7, 2024 KP Singh <kpsingh@kernel.org> wrote:
> 
> LSM hooks are currently invoked from a linked list as indirect calls
> which are invoked using retpolines as a mitigation for speculative
> attacks (Branch History / Target injection) and add extra overhead which
> is especially bad in kernel hot paths:
> 
> security_file_ioctl:
>    0xffffffff814f0320 <+0>:	endbr64
>    0xffffffff814f0324 <+4>:	push   %rbp
>    0xffffffff814f0325 <+5>:	push   %r15
>    0xffffffff814f0327 <+7>:	push   %r14
>    0xffffffff814f0329 <+9>:	push   %rbx
>    0xffffffff814f032a <+10>:	mov    %rdx,%rbx
>    0xffffffff814f032d <+13>:	mov    %esi,%ebp
>    0xffffffff814f032f <+15>:	mov    %rdi,%r14
>    0xffffffff814f0332 <+18>:	mov    $0xffffffff834a7030,%r15
>    0xffffffff814f0339 <+25>:	mov    (%r15),%r15
>    0xffffffff814f033c <+28>:	test   %r15,%r15
>    0xffffffff814f033f <+31>:	je     0xffffffff814f0358 <security_file_ioctl+56>
>    0xffffffff814f0341 <+33>:	mov    0x18(%r15),%r11
>    0xffffffff814f0345 <+37>:	mov    %r14,%rdi
>    0xffffffff814f0348 <+40>:	mov    %ebp,%esi
>    0xffffffff814f034a <+42>:	mov    %rbx,%rdx
> 
>    0xffffffff814f034d <+45>:	call   0xffffffff81f742e0 <__x86_indirect_thunk_array+352>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>     Indirect calls that use retpolines leading to overhead, not just due
>     to extra instruction but also branch misses.
> 
>    0xffffffff814f0352 <+50>:	test   %eax,%eax
>    0xffffffff814f0354 <+52>:	je     0xffffffff814f0339 <security_file_ioctl+25>
>    0xffffffff814f0356 <+54>:	jmp    0xffffffff814f035a <security_file_ioctl+58>
>    0xffffffff814f0358 <+56>:	xor    %eax,%eax
>    0xffffffff814f035a <+58>:	pop    %rbx
>    0xffffffff814f035b <+59>:	pop    %r14
>    0xffffffff814f035d <+61>:	pop    %r15
>    0xffffffff814f035f <+63>:	pop    %rbp
>    0xffffffff814f0360 <+64>:	jmp    0xffffffff81f747c4 <__x86_return_thunk>

Generally I fix these up, but since there are quite a few long-ish lines
in the description, and a respin is probably a good idea to reduce the
merge fuzz, it would be good if you could manage the line lengths a bit
better.  Aim to have the no wrapped lines in the commit description when
you run 'git log' on a 80-char wide terminal.  I'm guessing that
(re)formatting the assembly to something like this will solve most of
the problems:

  0xff...0360: jmp       0xff...47c4 <__x86_return_thunk>

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
> 
> With the hook now exposed as a static call, one can see that the
> retpolines are no longer there and the LSM callbacks are invoked
> directly:
> 
> security_file_ioctl:
>    0xffffffff818f0ca0 <+0>:	endbr64
>    0xffffffff818f0ca4 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xffffffff818f0ca9 <+9>:	push   %rbp
>    0xffffffff818f0caa <+10>:	push   %r14
>    0xffffffff818f0cac <+12>:	push   %rbx
>    0xffffffff818f0cad <+13>:	mov    %rdx,%rbx
>    0xffffffff818f0cb0 <+16>:	mov    %esi,%ebp
>    0xffffffff818f0cb2 <+18>:	mov    %rdi,%r14
>    0xffffffff818f0cb5 <+21>:	jmp    0xffffffff818f0cc7 <security_file_ioctl+39>
>   				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    Static key enabled for SELinux
> 
>    0xffffffff818f0cb7 <+23>:	jmp    0xffffffff818f0cde <security_file_ioctl+62>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>    Static key enabled for BPF LSM. This is something that is changed to
>    default to false to avoid the existing side effect issues of BPF LSM
>    [1] in a subsequent patch.
> 
>    0xffffffff818f0cb9 <+25>:	xor    %eax,%eax
>    0xffffffff818f0cbb <+27>:	xchg   %ax,%ax
>    0xffffffff818f0cbd <+29>:	pop    %rbx
>    0xffffffff818f0cbe <+30>:	pop    %r14
>    0xffffffff818f0cc0 <+32>:	pop    %rbp
>    0xffffffff818f0cc1 <+33>:	cs jmp 0xffffffff82c00000 <__x86_return_thunk>
>    0xffffffff818f0cc7 <+39>:	endbr64
>    0xffffffff818f0ccb <+43>:	mov    %r14,%rdi
>    0xffffffff818f0cce <+46>:	mov    %ebp,%esi
>    0xffffffff818f0cd0 <+48>:	mov    %rbx,%rdx
>    0xffffffff818f0cd3 <+51>:	call   0xffffffff81903230 <selinux_file_ioctl>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    Direct call to SELinux.
> 
>    0xffffffff818f0cd8 <+56>:	test   %eax,%eax
>    0xffffffff818f0cda <+58>:	jne    0xffffffff818f0cbd <security_file_ioctl+29>
>    0xffffffff818f0cdc <+60>:	jmp    0xffffffff818f0cb7 <security_file_ioctl+23>
>    0xffffffff818f0cde <+62>:	endbr64
>    0xffffffff818f0ce2 <+66>:	mov    %r14,%rdi
>    0xffffffff818f0ce5 <+69>:	mov    %ebp,%esi
>    0xffffffff818f0ce7 <+71>:	mov    %rbx,%rdx
>    0xffffffff818f0cea <+74>:	call   0xffffffff8141e220 <bpf_lsm_file_ioctl>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    Direct call to BPF LSM.
> 
>    0xffffffff818f0cef <+79>:	test   %eax,%eax
>    0xffffffff818f0cf1 <+81>:	jne    0xffffffff818f0cbd <security_file_ioctl+29>
>    0xffffffff818f0cf3 <+83>:	jmp    0xffffffff818f0cb9 <security_file_ioctl+25>
>    0xffffffff818f0cf5 <+85>:	endbr64
>    0xffffffff818f0cf9 <+89>:	mov    %r14,%rdi
>    0xffffffff818f0cfc <+92>:	mov    %ebp,%esi
>    0xffffffff818f0cfe <+94>:	mov    %rbx,%rdx
>    0xffffffff818f0d01 <+97>:	pop    %rbx
>    0xffffffff818f0d02 <+98>:	pop    %r14
>    0xffffffff818f0d04 <+100>:	pop    %rbp
>    0xffffffff818f0d05 <+101>:	ret
>    0xffffffff818f0d06 <+102>:	int3
>    0xffffffff818f0d07 <+103>:	int3
>    0xffffffff818f0d08 <+104>:	int3
>    0xffffffff818f0d09 <+105>:	int3
> 
> While this patch uses static_branch_unlikely indicating that an LSM hook
> is likely to be not present, a subsequent makes it configurable.

I believe the comment above needs to be updated.

> In most
> cases this is still a better choice as even when an LSM with one hook is
> added, empty slots are created for all LSM hooks (especially when many
> LSMs that do not initialize most hooks are present on the system).
> 
> There are some hooks that don't use the call_int_hook and
> call_void_hook. These hooks are updated to use a new macro called
> security_for_each_hook where the lsm_callback is directly invoked as an
> indirect call. Currently, there are no performance sensitive hooks that
> use the security_for_each_hook macro. However, if, some performance
> sensitive hooks are discovered, these can be updated to use static calls
> with loop unrolling as well using a custom macro.

The security_for_each_hook() macro is not present in this patch.

Beyond that, let's find a way to use static calls in the LSM hooks
which don't use the call_{int,void}_hook() macros.  If we're going to do
this to help close some attack vectors, let's make sure we do the
conversion everywhere.

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
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/lsm_hooks.h |  70 +++++++++--
>  security/security.c       | 244 ++++++++++++++++++++++++--------------
>  2 files changed, 216 insertions(+), 98 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a2ade0ffe9e7..ba63d8b54448 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -30,16 +30,63 @@
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
>  
>  union security_list_options {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
>  	#include "lsm_hook_defs.h"
>  	#undef LSM_HOOK
> +	void *lsm_callback;
>  };

It took me a little while to figure out what you were doing with the
lsm_callback field above, can we get rid of the "callback" bit and go
with something to indicate this is a generic function address?  How
about "lsm_func_addr" or similar (bikeshedding, I know ...)?

I'd also like to see a one line comment in there too.

> -struct security_hook_heads {
> -	#define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> -	#include "lsm_hook_defs.h"
> +/*
> + * @key: static call key as defined by STATIC_CALL_KEY
> + * @trampoline: static call trampoline as defined by STATIC_CALL_TRAMP
> + * @hl: The security_hook_list as initialized by the owning LSM.
> + * @active: Enabled when the static call has an LSM hook associated.
> + */
> +struct lsm_static_call {
> +	struct static_call_key *key;
> +	void *trampoline;
> +	struct security_hook_list *hl;
> +	/* this needs to be true or false based on what the key defaults to */

Isn't this "true or false based on if @hl is valid or not"?

> +	struct static_key_false *active;
> +} __randomize_layout;
> +
> +/*
> + * Table of the static calls for each LSM hook.
> + * Once the LSMs are initialized, their callbacks will be copied to these
> + * tables such that the calls are filled backwards (from last to first).
> + * This way, we can jump directly to the first used static call, and execute
> + * all of them after. This essentially makes the entry point
> + * dynamic to adapt the number of static calls to the number of callbacks.
> + */
> +struct lsm_static_calls_table {
> +	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> +		struct lsm_static_call NAME[MAX_LSM_COUNT];
> +	#include <linux/lsm_hook_defs.h>
>  	#undef LSM_HOOK
>  } __randomize_layout;
>  
> @@ -58,10 +105,14 @@ struct lsm_id {
>  /*
>   * Security module hook list structure.
>   * For use with generic list macros for common operations.
> + *
> + * struct security_hook_list - Contents of a cacheable, mappable object.

The comment above looks odd ... can you explain this a bit more and what
your intention was with that line?

> + * @scalls: The beginning of the array of static calls assigned to this hook.
> + * @hook: The callback for the hook.
> + * @lsm: The name of the lsm that owns this hook.
>   */
>  struct security_hook_list {
> -	struct hlist_node		list;
> -	struct hlist_head		*head;
> +	struct lsm_static_call	*scalls;
>  	union security_list_options	hook;
>  	const struct lsm_id		*lsmid;
>  } __randomize_layout;
> @@ -110,10 +161,12 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
>   * care of the common case and reduces the amount of
>   * text involved.
>   */
> -#define LSM_HOOK_INIT(HEAD, HOOK) \
> -	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
> +#define LSM_HOOK_INIT(NAME, CALLBACK)			\
> +	{						\
> +		.scalls = static_calls_table.NAME,	\
> +		.hook = { .NAME = CALLBACK }		\
> +	}

Unless there is something that I'm missing, please just stick with the
existing "HOOK" name instead of "CALLBACK".

> -extern struct security_hook_heads security_hook_heads;
>  extern char *lsm_names;
>  
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
> @@ -151,5 +204,6 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  		__aligned(sizeof(unsigned long))
>  
>  extern int lsm_inode_alloc(struct inode *inode);
> +extern struct lsm_static_calls_table static_calls_table __ro_after_init;
>  
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/security.c b/security/security.c
> index 3aaad75c9ce8..e05d2157c95a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -30,6 +30,8 @@
>  #include <linux/string.h>
>  #include <linux/msg.h>
>  #include <net/flow.h>
> +#include <linux/static_call.h>
> +#include <linux/jump_label.h>
>  
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> @@ -91,7 +93,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -struct security_hook_heads security_hook_heads __ro_after_init;
>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
>  
>  static struct kmem_cache *lsm_file_cache;
> @@ -110,6 +111,51 @@ static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
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
> +
> +/*
> + * Initialise a table of static calls for each LSM hook.
> + * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CALL_KEY)
> + * and a trampoline (STATIC_CALL_TRAMP) which are used to call
> + * __static_call_update when updating the static call.
> + */
> +struct lsm_static_calls_table static_calls_table __ro_after_init = {
> +#define INIT_LSM_STATIC_CALL(NUM, NAME)					\
> +	(struct lsm_static_call) {					\
> +		.key = &STATIC_CALL_KEY(LSM_STATIC_CALL(NAME, NUM)),	\
> +		.trampoline = LSM_HOOK_TRAMP(NAME, NUM),		\
> +		.active = &SECURITY_HOOK_ACTIVE_KEY(NAME, NUM),		\
> +	},
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
> +	.NAME = {							\
> +		LSM_DEFINE_UNROLL(INIT_LSM_STATIC_CALL, NAME)		\
> +	},
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +#undef INIT_LSM_STATIC_CALL
> +};
> +
>  static __initdata bool debug;
>  #define init_debug(...)						\
>  	do {							\
> @@ -170,7 +216,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
>  	if (exists_ordered_lsm(lsm))
>  		return;
>  
> -	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
> +	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM static calls!?\n", from))
>  		return;
>  
>  	/* Enable this LSM, if it is not already set. */
> @@ -349,6 +395,25 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>  	kfree(sep);
>  }
>  
> +static void __init lsm_static_call_init(struct security_hook_list *hl)
> +{
> +	struct lsm_static_call *scall = hl->scalls;
> +	int i;
> +
> +	for (i = 0; i < MAX_LSM_COUNT; i++) {
> +		/* Update the first static call that is not used yet */
> +		if (!scall->hl) {
> +			__static_call_update(scall->key, scall->trampoline,
> +					     hl->hook.lsm_callback);
> +			scall->hl = hl;
> +			static_branch_enable(scall->active);
> +			return;
> +		}
> +		scall++;
> +	}
> +	panic("%s - Ran out of static slots.\n", __func__);
> +}
> +
>  static void __init lsm_early_cred(struct cred *cred);
>  static void __init lsm_early_task(struct task_struct *task);
>  
> @@ -428,11 +493,6 @@ int __init early_security_init(void)
>  {
>  	struct lsm_info *lsm;
>  
> -#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> -	INIT_HLIST_HEAD(&security_hook_heads.NAME);
> -#include "linux/lsm_hook_defs.h"
> -#undef LSM_HOOK
> -
>  	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
>  		if (!lsm->enabled)
>  			lsm->enabled = &lsm_enabled_true;
> @@ -560,7 +620,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  
>  	for (i = 0; i < count; i++) {
>  		hooks[i].lsmid = lsmid;
> -		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
> +		lsm_static_call_init(&hooks[i]);
>  	}
>  
>  	/*
> @@ -846,29 +906,41 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
>   * call_int_hook:
>   *	This is a hook that returns a value.
>   */
> +#define __CALL_STATIC_VOID(NUM, HOOK, ...)				     \
> +do {									     \
> +	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {    \

I'm not a fan of the likely()/unlikely() style markings/macros in cases
like this as it can vary tremendously.  Drop the likely()/unlikely()
checks and just do a static_call().

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
> +#define call_void_hook(FUNC, ...)                                 \
> +	do {                                                      \
> +		LSM_LOOP_UNROLL(__CALL_STATIC_VOID, FUNC, __VA_ARGS__); \
>  	} while (0)
>  
> -#define call_int_hook(FUNC, IRC, ...) ({			\
> -	int RC = IRC;						\
> -	do {							\
> -		struct security_hook_list *P;			\
> -								\
> -		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> -			RC = P->hook.FUNC(__VA_ARGS__);		\
> -			if (RC != 0)				\
> -				break;				\
> -		}						\
> -	} while (0);						\
> -	RC;							\
> +#define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)			     \
> +do {									     \
> +	if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \

See my comments in the void sister function.

> +		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
> +		if (R != 0)						     \
> +			goto LABEL;					     \
> +	}								     \
> +} while (0);
> +
> +#define call_int_hook(FUNC, IRC, ...)					\
> +({									\
> +	__label__ out;							\
> +	int RC = IRC;							\
> +	LSM_LOOP_UNROLL(__CALL_STATIC_INT, RC, FUNC, out, __VA_ARGS__);	\
> +out:									\
> +	RC;								\
>  })
>  
> +#define lsm_for_each_hook(scall, NAME)					\
> +	for (scall = static_calls_table.NAME;				\
> +	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
> +		if (static_key_enabled(&scall->active->key))
> +
>  /* Security operations */
>  

--
paul-moore.com

