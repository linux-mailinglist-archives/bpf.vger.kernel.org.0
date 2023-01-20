Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DCE674AEB
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 05:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjATEli (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 23:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjATElF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 23:41:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D753C9261
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 20:36:57 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jl3so4309128plb.8
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 20:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHATFx2SmYMjo2w8+zUa+b09Xd/3s9Ck86DqU4qbf7Y=;
        b=ZWB65/RGz/nNeBSJCiCApP5V5REMw3cpIsZEhbWxvBo4yszJzPGsH2HaYurNtY2XXf
         b3rULwLToe8B6T1/xkGc8uMTgm4kSEfWgExUlgsEUdO5rLMBDrdChjSVQ9UxRBiujCLy
         F8fO5yFBNChit0I4EQDL/BrMvBQ5CRfOwotwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHATFx2SmYMjo2w8+zUa+b09Xd/3s9Ck86DqU4qbf7Y=;
        b=kjrIS1QJcZOIyOmc6TUzh2Avo+UM5YDq8mMHThLG7zjykep2dbjED2CWxKHQdQ5ZI3
         XDAa9hcN9HKAZijyZFlKWt8Uj/IWcLvNheFmU6TpM4NZbIEJBMjazyoHNww2Aj4Skzej
         9MUXDxIfYmhDqSoLJb2F2G9Dc7lB6QXzMjCEpqRs9KfMfnOSF15Di6ekLy+u76I0Lbbd
         RLi0gKCHTE2UVvAj/zKZbLLAYPtO9jDp7rIUFYmEtrKdkV+GzB3PbGDBzTp5nczzDukP
         A++dBl2FMGtsK741qnLzVEJxJaCXKxS+rHkFxpUjbn3TdT2EV8mFK7/wOkUDsGzqVrCx
         WOVA==
X-Gm-Message-State: AFqh2kpLHO+oNmnE6SjPVzfKqe5rFh6UBAICLAFi8BObjKxfrw9kV8Z6
        Q7hW97RfJ6FKQsW6cO5NkgeurQ==
X-Google-Smtp-Source: AMrXdXubhLnhfMfWKcnr4V2wBFqQn9VMbpfomT2NAPnWld1SfeQQlwVJkvSg+E6VWjtGrMowl5v78Q==
X-Received: by 2002:a17:90b:1992:b0:229:989e:71d5 with SMTP id mv18-20020a17090b199200b00229989e71d5mr13352423pjb.6.1674189405183;
        Thu, 19 Jan 2023 20:36:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mm17-20020a17090b359100b002298adf6edcsm481373pjb.13.2023.01.19.20.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 20:36:44 -0800 (PST)
Date:   Thu, 19 Jan 2023 20:36:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
        song@kernel.org, revest@chromium.org
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
Message-ID: <202301192004.777AEFFE@keescook>
References: <20230120000818.1324170-1-kpsingh@kernel.org>
 <20230120000818.1324170-4-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120000818.1324170-4-kpsingh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
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

I think this patch has too many logic changes in it. There are basically
two things going on here:

- replace list with unrolled calls
- replace calls with static calls

I see why it was merged, since some of the logic that would be added for
step 1 would be immediate replaced, but I think it might make things a
bit more clear.

There is likely a few intermediate steps here too, to rename things,
etc.

> There are some hooks that don't use the call_int_hook and
> call_void_hook. These hooks are updated to use a new macro called
> security_for_each_hook where the lsm_callback is directly invoked as an
> indirect call. Currently, there are no performance sensitive hooks that
> use the security_for_each_hook macro. However, if, some performance
> sensitive hooks are discovered, these can be updated to use
> static calls with loop unrolling as well using a custom macro.
> 
> [1] https://lore.kernel.org/linux-security-module/20220609234601.2026362-1-kpsingh@kernel.org/
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/lsm_hooks.h |  83 +++++++++++++--
>  security/security.c       | 216 ++++++++++++++++++++++++--------------
>  2 files changed, 211 insertions(+), 88 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 0a5ba81f7367..c82d15a4ef50 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -28,6 +28,26 @@
>  #include <linux/security.h>
>  #include <linux/init.h>
>  #include <linux/rculist.h>
> +#include <linux/static_call.h>
> +#include <linux/unroll.h>
> +#include <linux/jump_label.h>
> +
> +/* Include the generated MAX_LSM_COUNT */
> +#include <generated/lsm_count.h>
> +
> +#define SECURITY_HOOK_ENABLED_KEY(HOOK, IDX) security_enabled_key_##HOOK##_##IDX
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
> +#define LSM_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)

I think this should be:

#define LSM_UNROLL(M, ...)	do {			\
		UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__);	\
	} while (0)

or maybe UNROLL needs the do/while.

>  
>  /**
>   * union security_list_options - Linux Security Module hook function list
> @@ -1657,21 +1677,48 @@ union security_list_options {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
>  	#include "lsm_hook_defs.h"
>  	#undef LSM_HOOK
> +	void *lsm_callback;
>  };
>  
> -struct security_hook_heads {
> -	#define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> -	#include "lsm_hook_defs.h"
> +/*
> + * @key: static call key as defined by STATIC_CALL_KEY
> + * @trampoline: static call trampoline as defined by STATIC_CALL_TRAMP
> + * @hl: The security_hook_list as initialized by the owning LSM.
> + * @enabled_key: Enabled when the static call has an LSM hook associated.
> + */
> +struct lsm_static_call {
> +	struct static_call_key *key;
> +	void *trampoline;
> +	struct security_hook_list *hl;
> +	struct static_key *enabled_key;
> +};
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
>  /*
>   * Security module hook list structure.
>   * For use with generic list macros for common operations.
> + *
> + * struct security_hook_list - Contents of a cacheable, mappable object.
> + * @scalls: The beginning of the array of static calls assigned to this hook.
> + * @hook: The callback for the hook.
> + * @lsm: The name of the lsm that owns this hook.
>   */
>  struct security_hook_list {
> -	struct hlist_node		list;
> -	struct hlist_head		*head;
> +	struct lsm_static_call	*scalls;
>  	union security_list_options	hook;
>  	const char			*lsm;
>  } __randomize_layout;
> @@ -1701,10 +1748,12 @@ struct lsm_blob_sizes {
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
>  
> -extern struct security_hook_heads security_hook_heads;
>  extern char *lsm_names;
>  
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
> @@ -1756,10 +1805,21 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  static inline void security_delete_hooks(struct security_hook_list *hooks,
>  						int count)

Hey Paul, can we get rid of CONFIG_SECURITY_SELINUX_DISABLE yet? It's
been deprecated for years....

>  {
> -	int i;
> +	struct lsm_static_call *scalls;
> +	int i, j;
> +
> +	for (i = 0; i < count; i++) {
> +		scalls = hooks[i].scalls;
> +		for (j = 0; j < MAX_LSM_COUNT; j++) {
> +			if (scalls[j].hl != &hooks[i])
> +				continue;
>  
> -	for (i = 0; i < count; i++)
> -		hlist_del_rcu(&hooks[i].list);
> +			static_key_disable(scalls[j].enabled_key);
> +			__static_call_update(scalls[j].key,
> +					     scalls[j].trampoline, NULL);
> +			scalls[j].hl = NULL;
> +		}
> +	}
>  }
>  #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
>  
> @@ -1771,5 +1831,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>  #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
>  
>  extern int lsm_inode_alloc(struct inode *inode);
> +extern struct lsm_static_calls_table static_calls_table __ro_after_init;
>  
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/security.c b/security/security.c
> index d1571900a8c7..e54d5ba187d1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -29,6 +29,8 @@
>  #include <linux/string.h>
>  #include <linux/msg.h>
>  #include <net/flow.h>
> +#include <linux/static_call.h>
> +#include <linux/jump_label.h>
>  
>  #define MAX_LSM_EVM_XATTR	2
>  
> @@ -74,7 +76,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
>  
>  static struct kmem_cache *lsm_file_cache;
> @@ -93,6 +94,43 @@ static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
>  static __initdata struct lsm_info **ordered_lsms;
>  static __initdata struct lsm_info *exclusive;
>  
> +/*
> + * Define static calls and static keys for each LSM hook.
> + */
> +
> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)			\
> +	DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),		\
> +				*((RET(*)(__VA_ARGS__))NULL));		\
> +	DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAME, NUM));

Hm, another place where we would benefit from having separated logic for
"is it built?" and "is it enabled by default?" and we could use
DEFINE_STATIC_KEY_MAYBE(). But, since we don't, I think we need to use
DEFINE_STATIC_KEY_TRUE() here or else won't all the calls be
out-of-line? (i.e. the default compiled state will be NOPs?) If we're
trying to optimize for having LSMs, I think we should default to inline
calls. (The machine code in the commit log seems to indicate that they
are out of line -- it uses jumps.)

> [...]
> +#define __CALL_STATIC_VOID(NUM, HOOK, ...)                                   \
> +	if (static_branch_unlikely(&SECURITY_HOOK_ENABLED_KEY(HOOK, NUM))) { \
> +		static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);        \
> +	}

Same here -- I would expect this to be static_branch_likely() or we'll
get out-of-line branches. Also, IMO, this should be:

	do {
		if (...)
			static_call(...);
	} while (0)


> +#define call_void_hook(FUNC, ...)                                 \
> +	do {                                                      \
> +		LSM_UNROLL(__CALL_STATIC_VOID, FUNC, __VA_ARGS__) \
>  	} while (0)

With the do/while in LSM_UNROLL, this is more readable.

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
> -})
> +#define __CALL_STATIC_INT(NUM, R, HOOK, ...)                                 \
> +	if (static_branch_unlikely(&SECURITY_HOOK_ENABLED_KEY(HOOK, NUM))) { \
> +		R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
> +		if (R != 0)                                                  \
> +			goto out;                                            \
> +	}

I would expect the label to be a passed argument, but maybe since it
never changes, it's fine as-is?

And again, I'd expect a do/while wrapper, and for it to be s_b_likely.

> +
> +#define call_int_hook(FUNC, IRC, ...)                                        \
> +	({                                                                   \
> +		__label__ out;                                               \
> +		int RC = IRC;                                                \
> +		do {                                                         \
> +			LSM_UNROLL(__CALL_STATIC_INT, RC, FUNC, __VA_ARGS__) \
> +									     \
> +		} while (0);                                                 \

Then this becomes:

({
	int RC = IRC;
	LSM_UNROLL(__CALL_STATIC_INT, RC, FUNC, __VA_ARGS__);
out:
	RC;
})

> +#define security_for_each_hook(scall, NAME, expression)                  \
> +	for (scall = static_calls_table.NAME;                            \
> +	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++) { \
> +		if (!static_key_enabled(scall->enabled_key))             \
> +			continue;                                        \
> +		(expression);                                            \
> +	}

Why isn't this using static_branch_enabled()? I would expect this to be:

#define security_for_each_hook(scall, NAME)				\
	for (scall = static_calls_table.NAME;                           \
	     scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)	\
		if (static_branch_likely(scall->enabled_key))

>  
>  /* Security operations */
>  
> @@ -859,7 +924,7 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
>  
>  int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  {
> -	struct security_hook_list *hp;
> +	struct lsm_static_call *scall;
>  	int cap_sys_admin = 1;
>  	int rc;
>  
> @@ -870,13 +935,13 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  	 * agree that it should be set it will. If any module
>  	 * thinks it should not be set it won't.
>  	 */
> -	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
> -		rc = hp->hook.vm_enough_memory(mm, pages);
> +	security_for_each_hook(scall, vm_enough_memory, ({
> +		rc = scall->hl->hook.vm_enough_memory(mm, pages);
>  		if (rc <= 0) {
>  			cap_sys_admin = 0;
>  			break;
>  		}
> -	}
> +	}));

Then these replacements don't look weird. This would just be:

	security_for_each_hook(scall, vm_enough_memory) {
		rc = scall->hl->hook.vm_enough_memory(mm, pages);
  		if (rc <= 0) {
  			cap_sys_admin = 0;
  			break;
  		}
	}

I'm excited to have this. The speed improvements are pretty nice.

-- 
Kees Cook
