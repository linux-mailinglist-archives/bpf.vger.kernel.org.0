Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7261568BD76
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 14:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjBFNEc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 08:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBFNEc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 08:04:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CEB468A
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 05:04:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3870460ECE
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 13:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEC5C4339C
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 13:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675688669;
        bh=UBAoFwxNyiGvuTmkAnCVSkkb6F2CDQ/bNw6FesuTT+o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O3qWGV5QCUKyqp3eAhGAf6zkhkzIbuH5mTuxUxIA+CZbGPldY56hUj1JpMTQOLCON
         D1rMJmsvExb7FTSNuXNTUugYXcaGjYIUM95/H7Skd9XTo9h1oHyTgGPDG5D67NCWD6
         GvOk5TIJZM+xrhD5qR5Z7Tv2dqIGF4cXyHUSfSIifnfVWeLjAwdY+9KPtQp5fAd8gc
         Bkj6PHv8WODAR+xUObYYrqX/Z7TMNxwxGulGd9XWQeBBOBZOq6bSzcV1xnVg/7aPbf
         JRmlX3I1BLtq0EYalmIbQZ4vs/46MO5HFaaUovRor7swn+nSoMUqlN0ryArp9S9K0v
         stJn0L4mypENg==
Received: by mail-ej1-f41.google.com with SMTP id hr39so4371055ejc.7
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 05:04:29 -0800 (PST)
X-Gm-Message-State: AO0yUKUauuI0QtDuS8mk+9YJnfLeWku/PFlCxQr33Q6WyfeUa3unTjON
        Zi3r1No9oG1ibvc1fyxvCnziy6TVdjKGRY9vXPY0RQ==
X-Google-Smtp-Source: AK7set+WtPOXiEb/sjnBI4MqokJ9Ocsztf5JzLCxxnGlSfhAuy4unS8NWGeq4sSTl/HrqxqJXYQjJA5TDESveAy88PI=
X-Received: by 2002:a17:906:6c86:b0:87c:c2eb:6dfa with SMTP id
 s6-20020a1709066c8600b0087cc2eb6dfamr6023618ejr.204.1675688667651; Mon, 06
 Feb 2023 05:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20230120000818.1324170-1-kpsingh@kernel.org> <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook>
In-Reply-To: <202301192004.777AEFFE@keescook>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 6 Feb 2023 14:04:16 +0100
X-Gmail-Original-Message-ID: <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
Message-ID: <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
        song@kernel.org, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 5:36 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
> > The indirect calls are not really needed as one knows the addresses of

[...]

> > A static key guards whether an LSM static call is enabled or not,
> > without this static key, for LSM hooks that return an int, the presence
> > of the hook that returns a default value can create side-effects which
> > has resulted in bugs [1].
>
> I think this patch has too many logic changes in it. There are basically
> two things going on here:
>
> - replace list with unrolled calls
> - replace calls with static calls
>
> I see why it was merged, since some of the logic that would be added for
> step 1 would be immediate replaced, but I think it might make things a
> bit more clear.
>
> There is likely a few intermediate steps here too, to rename things,
> etc.

I can try to split this patch, but I am not able to find a decent
slice without duplicating a lot of work which will get squashed in the
end anyways.

>
> > There are some hooks that don't use the call_int_hook and
> > call_void_hook. These hooks are updated to use a new macro called
> > security_for_each_hook where the lsm_callback is directly invoked as an

[...]

> > + * Call the macro M for each LSM hook MAX_LSM_COUNT times.
> > + */
> > +#define LSM_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
>
> I think this should be:
>
> #define LSM_UNROLL(M, ...)      do {                    \
>                 UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__);  \
>         } while (0)
>
> or maybe UNROLL needs the do/while.

UNROLL is used for both declaration and loop unrolling. So I have
split the LSM macros into LSM_UNROLL to LSM_LOOP_UNROLL (which is
surrounded by a do/while) and an LSM_DEFINE_UNROLL which is not.

>
> >
> >  /**
> >   * union security_list_options - Linux Security Module hook function list
> > @@ -1657,21 +1677,48 @@ union security_list_options {
> >       #define LSM_HOOK(RET, DEFAULT, NAME, ...) RET (*NAME)(__VA_ARGS__);
> >       #include "lsm_hook_defs.h"
> >       #undef LSM_HOOK
> > +     void *lsm_callback;
> >  };
> >
> > -struct security_hook_heads {
> > -     #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> > -     #include "lsm_hook_defs.h"
> > +/*
> > + * @key: static call key as defined by STATIC_CALL_KEY
> > + * @trampoline: static call trampoline as defined by STATIC_CALL_TRAMP
> > + * @hl: The security_hook_list as initialized by the owning LSM.

[...]

> > +             struct lsm_static_call NAME[MAX_LSM_COUNT];
> > +     #include <linux/lsm_hook_defs.h>
> >       #undef LSM_HOOK
> >  } __randomize_layout;
> >
> >  /*
> >   * Security module hook list structure.
> >   * For use with generic list macros for common operations.
> > + *
> > + * struct security_hook_list - Contents of a cacheable, mappable object.

[...]

> > -#define LSM_HOOK_INIT(HEAD, HOOK) \
> > -     { .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
> > +#define LSM_HOOK_INIT(NAME, CALLBACK)                        \
> > +     {                                               \
> > +             .scalls = static_calls_table.NAME,      \
> > +             .hook = { .NAME = CALLBACK }            \
> > +     }
> >
> > -extern struct security_hook_heads security_hook_heads;
> >  extern char *lsm_names;
> >
> >  extern void security_add_hooks(struct security_hook_list *hooks, int count,
> > @@ -1756,10 +1805,21 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> >  static inline void security_delete_hooks(struct security_hook_list *hooks,
> >                                               int count)
>
> Hey Paul, can we get rid of CONFIG_SECURITY_SELINUX_DISABLE yet? It's
> been deprecated for years....
>
> >  {
> > -     int i;
> > +     struct lsm_static_call *scalls;
> > +     int i, j;
> > +
> > +     for (i = 0; i < count; i++) {
> > +             scalls = hooks[i].scalls;
> > +             for (j = 0; j < MAX_LSM_COUNT; j++) {
> > +                     if (scalls[j].hl != &hooks[i])
> > +                             continue;
> >
> > -     for (i = 0; i < count; i++)
> > -             hlist_del_rcu(&hooks[i].list);
> > +                     static_key_disable(scalls[j].enabled_key);
> > +                     __static_call_update(scalls[j].key,
> > +                                          scalls[j].trampoline, NULL);
> > +                     scalls[j].hl = NULL;
> > +             }
> > +     }
> >  }
> >  #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> >
> > @@ -1771,5 +1831,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
> >  #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
> >
> >  extern int lsm_inode_alloc(struct inode *inode);
> > +extern struct lsm_static_calls_table static_calls_table __ro_after_init;

[...]

> >
> > +/*
> > + * Define static calls and static keys for each LSM hook.
> > + */
> > +
> > +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)                  \
> > +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),             \
> > +                             *((RET(*)(__VA_ARGS__))NULL));          \
> > +     DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAME, NUM));
>
> Hm, another place where we would benefit from having separated logic for
> "is it built?" and "is it enabled by default?" and we could use
> DEFINE_STATIC_KEY_MAYBE(). But, since we don't, I think we need to use
> DEFINE_STATIC_KEY_TRUE() here or else won't all the calls be
> out-of-line? (i.e. the default compiled state will be NOPs?) If we're
> trying to optimize for having LSMs, I think we should default to inline
> calls. (The machine code in the commit log seems to indicate that they
> are out of line -- it uses jumps.)
>

I should have added it in the commit description, actually we are
optimizing for "hot paths are less likely to have LSM hooks enabled"
(eg. socket_sendmsg). But I do see that there are LSMs that have these
enabled. Maybe we can put this behind a config option, possibly
depending on CONFIG_EXPERT?

> > [...]
> > +#define __CALL_STATIC_VOID(NUM, HOOK, ...)                                   \
> > +     if (static_branch_unlikely(&SECURITY_HOOK_ENABLED_KEY(HOOK, NUM))) { \
> > +             static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);        \
> > +     }
>
> Same here -- I would expect this to be static_branch_likely() or we'll
> get out-of-line branches. Also, IMO, this should be:
>
>         do {
>                 if (...)
>                         static_call(...);
>         } while (0)
>

Note we cannot really omit the semicolon here. We also use the UNROLL
macro for declaring struct members which cannot assume that the MACRO
to UNROLL will be terminated by a semicolon.

>
> > +#define call_void_hook(FUNC, ...)                                 \
> > +     do {                                                      \
> > +             LSM_UNROLL(__CALL_STATIC_VOID, FUNC, __VA_ARGS__) \
> >       } while (0)
>
> With the do/while in LSM_UNROLL, this is more readable.

Agreed, done.

>
> >
> > -#define call_int_hook(FUNC, IRC, ...) ({                     \
> > -     int RC = IRC;                                           \
> > -     do {                                                    \
> > -             struct security_hook_list *P;                   \
> > -                                                             \
> > -             hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> > -                     RC = P->hook.FUNC(__VA_ARGS__);         \
> > -                     if (RC != 0)                            \
> > -                             break;                          \
> > -             }                                               \
> > -     } while (0);                                            \
> > -     RC;                                                     \
> > -})
> > +#define __CALL_STATIC_INT(NUM, R, HOOK, ...)                                 \
> > +     if (static_branch_unlikely(&SECURITY_HOOK_ENABLED_KEY(HOOK, NUM))) { \
> > +             R = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    \
> > +             if (R != 0)                                                  \
> > +                     goto out;                                            \
> > +     }
>
> I would expect the label to be a passed argument, but maybe since it
> never changes, it's fine as-is?

I think passing the label as an argument is cleaner, so I went ahead
and did that.

>
> And again, I'd expect a do/while wrapper, and for it to be s_b_likely.

The problem with the do/while wrapper here again is that UNROLL macros
are terminated by semi-colons which does not work for unrolling struct
member initialization, in particular for the static_calls_table where
it's used to initialize the array.

Now we could do what I suggested in LSM_LOOP_UNROLL and
LSM_DEFINE_UNROLL and push the logic up to UNROLL into:

* UNROLL_LOOP: Which expects a macro that will be surrounded by a
do/while and terminated by a semicolon in the unroll body
* UNROLL_DEFINE (or UNROLL_RAW) where you can pass anything.

What do you think?

>
> > +
> > +#define call_int_hook(FUNC, IRC, ...)                                        \
> > +     ({                                                                   \
> > +             __label__ out;                                               \
> > +             int RC = IRC;                                                \
> > +             do {                                                         \
> > +                     LSM_UNROLL(__CALL_STATIC_INT, RC, FUNC, __VA_ARGS__) \
> > +                                                                          \
> > +             } while (0);                                                 \
>
> Then this becomes:
>
> ({
>         int RC = IRC;
>         LSM_UNROLL(__CALL_STATIC_INT, RC, FUNC, __VA_ARGS__);
> out:
>         RC;
> })
>
> > +#define security_for_each_hook(scall, NAME, expression)                  \
> > +     for (scall = static_calls_table.NAME;                            \
> > +          scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++) { \
> > +             if (!static_key_enabled(scall->enabled_key))             \
> > +                     continue;                                        \
> > +             (expression);                                            \
> > +     }
>
> Why isn't this using static_branch_enabled()? I would expect this to be:

I am guessing you mean static_branch_likely, I tried using
static_branch_likely here and it does not work, the key is now being
visited from a loop counter and the static_branch_likely needs it at
compile time. So one needs to resort to the underlying static_key
implementation. Doing this causes:

./arch/x86/include/asm/jump_label.h:27:20: error: invalid operand for
inline asm constraint 'i'
./arch/x86/include/asm/jump_label.h:27:20: error: invalid operand for
inline asm constraint 'i'

The operand needs to be an immediate operand and needs patching at
runtime. I think it's okay we are already not doing any optimization
here as we still have the indirect call.

TL; DR static_branch_likely  cannot depend on runtime computations

>
> #define security_for_each_hook(scall, NAME)                             \
>         for (scall = static_calls_table.NAME;                           \
>              scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
>                 if (static_branch_likely(scall->enabled_key))

I like this macro, it does make the code easier to read thanks.

>
> >
> >  /* Security operations */
> >
> > @@ -859,7 +924,7 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
> >
> >  int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
> >  {
> > -     struct security_hook_list *hp;
> > +     struct lsm_static_call *scall;
> >       int cap_sys_admin = 1;
> >       int rc;
> >
> > @@ -870,13 +935,13 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
> >        * agree that it should be set it will. If any module
> >        * thinks it should not be set it won't.
> >        */
> > -     hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
> > -             rc = hp->hook.vm_enough_memory(mm, pages);
> > +     security_for_each_hook(scall, vm_enough_memory, ({
> > +             rc = scall->hl->hook.vm_enough_memory(mm, pages);
> >               if (rc <= 0) {
> >                       cap_sys_admin = 0;
> >                       break;
> >               }
> > -     }
> > +     }));
>
> Then these replacements don't look weird. This would just be:
>
>         security_for_each_hook(scall, vm_enough_memory) {
>                 rc = scall->hl->hook.vm_enough_memory(mm, pages);
>                 if (rc <= 0) {
>                         cap_sys_admin = 0;
>                         break;
>                 }
>         }

Agreed, Thanks!

>
> I'm excited to have this. The speed improvements are pretty nice.

Yay!


>
> --
> Kees Cook
