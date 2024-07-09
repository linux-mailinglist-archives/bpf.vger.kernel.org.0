Return-Path: <bpf+bounces-34234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1C292B99A
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD6C2869B1
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 12:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B4A15958D;
	Tue,  9 Jul 2024 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFPODbWM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E8158DB9
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528581; cv=none; b=WmXSh+NcTed8CW2bY8Pd5njcu7GRcMJ0BagcMtppPiD93AaA6cSAy/Rm2Bl6WBSOHtGcEoHd+2VR+zEmguERfKPv3KKPAjnc2T82lNP0OB3D08Zr0o4wF7Z7w8W77tkkoLQMJq79feG8k94YFC+HDQXMoeJ4ykBBXONZQlOa4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528581; c=relaxed/simple;
	bh=AKmZ4OjkmVTiV01A8IbzmYyO4WTh5o4Hya9czZ/I22Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdv7rua/EKDryJblWIVC4cWtxHpjWzRqBf5lKWS5+brBvSXA5AtSlSXi5PPDbzA22Z7HeSQh7rJWbggN09VGUj/xSSB4WM1KGGJQhkURUCkmEXGfKXakQxPTqvMOng4zjTNM8V+6fmt/Kaw8Q8+7xWGE2/qCTueqHaAEPjVM2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFPODbWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1E6C4AF15
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 12:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720528581;
	bh=AKmZ4OjkmVTiV01A8IbzmYyO4WTh5o4Hya9czZ/I22Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kFPODbWMC+IG22QE/o6r+70HaY/ksElqGRP45OfF1XrmS+ifiQrYMVdAYRA8uX+8x
	 0JA8vBNOUqI/ZntVubRmoOalwYIBeO3BNH8VrfCPov4hQ8kfuLXuafsUNIlPUVvl3I
	 vwqZHgnHuTeLewjZD+mgq2u5YtRzjN/7ItCyxnKPKXWcKLSyT8kkyYo5rSWJs2U9so
	 9eUsY7e+IlNx1SJjBK2pNlpi0Uots+nKOjiPLV9/7wFGBbQm4o595fj2lh1/WXV0U6
	 TexBY4Q5gtZ+bbE6Q3/B3fVNSHCCd2UNxLiDkPiqCdJ4MQ/50j7U7DEH6iItIpp1Uh
	 91PMwjgcFnFWw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so6502670a12.3
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 05:36:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW08BhPH/a6tXsS1F0jGywiFU/DO93gla+hR93fqq+qNpoTJvriSvQ7LYrXAI/YkBWy7SDza/geH4R4b7WoJOOySC9B
X-Gm-Message-State: AOJu0YyViE+GrqHXRq5/y4jmKmr5YGzXwBf+2uChFtGYJWDfAlGdV9eI
	zUtcHm7g1WEw1xTkWdtk4qe3eniHv4wn9dnqAXRGpR8ODhdqusyHZu4sLukz1fw/DLJXEOlxMvx
	iiv8vQ6BZcOfAyIEAxwqF8Ctk+3z5zADLvJNf
X-Google-Smtp-Source: AGHT+IG1Si26Cbx0HslXhLXUGis33dx0vBH3psY0I7515F2klIiqIzevs/8ZpPT5B2p90cvyks9vaWmCfwsgj3a3MS4=
X-Received: by 2002:a05:6402:1941:b0:58b:eb96:81ea with SMTP id
 4fb4d7f45d1cf-594bb085d40mr2171999a12.18.1720528580070; Tue, 09 Jul 2024
 05:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629084331.3807368-5-kpsingh@kernel.org> <f40a3d1bc1cd69442f4524118c3e2956@paul-moore.com>
In-Reply-To: <f40a3d1bc1cd69442f4524118c3e2956@paul-moore.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 9 Jul 2024 14:36:09 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4R-zG8=Xet4v-mf-Dmi_V9cHL7f0EiOEKhnPDxwsqx1Q@mail.gmail.com>
Message-ID: <CACYkzJ4R-zG8=Xet4v-mf-Dmi_V9cHL7f0EiOEKhnPDxwsqx1Q@mail.gmail.com>
Subject: Re: [PATCH v13 4/5] security: Update non standard hooks to use static calls
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -948,10 +948,48 @@ out:                                                                    \
> >       RC;                                                             \
> >  })
> >
> > -#define lsm_for_each_hook(scall, NAME)                                       \
> > -     for (scall = static_calls_table.NAME;                           \
> > -          scall - static_calls_table.NAME < MAX_LSM_COUNT; scall++)  \
> > -             if (static_key_enabled(&scall->active->key))
> > +/*
> > + * Can be used in the context passed to lsm_for_each_hook to get the lsmid of the
> > + * current hook
> > + */
> > +#define current_lsmid() _hook_lsmid
>
> See my comments below about security_getselfattr(), I think we can drop
> the current_lsmid() macro.  If we really must keep it, we need to rename
> it to something else as it clashes too much with the other current_XXX()
> macros/functions which are useful outside of our wacky macros.

call_hook_with_lsmid is a pattern used by quite a few hooks, happy to
update the name.

What do you think about __security_hook_lsm_id().

> > +#define __CALL_HOOK(NUM, HOOK, RC, BLOCK_BEFORE, BLOCK_AFTER, ...)        \
> > +do {                                                                      \
> > +     int __maybe_unused _hook_lsmid;                                      \
> > +                                                                          \
> > +     if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM))) {  \
> > +             _hook_lsmid = static_calls_table.HOOK[NUM].hl->lsmid->id;    \
> > +             BLOCK_BEFORE                                                 \
> > +             RC = static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);   \
> > +             BLOCK_AFTER                                                  \
> > +     }                                                                    \
> > +} while (0);
> > +
> > +#define lsm_for_each_hook(HOOK, RC, BLOCK_AFTER, ...)        \
> > +     LSM_LOOP_UNROLL(__CALL_HOOK, HOOK, RC, ;, BLOCK_AFTER, __VA_ARGS__)
> > +
> > +#define call_hook_with_lsmid(HOOK, LSMID, ...)                               \
> > +({                                                                   \
> > +     __label__ out;                                                  \
> > +     int RC = LSM_RET_DEFAULT(HOOK);                                 \
> > +                                                                     \
> > +     LSM_LOOP_UNROLL(__CALL_HOOK, HOOK, RC,                          \
> > +     /* BLOCK BEFORE INVOCATION */                                   \
> > +     {                                                               \
> > +             if (current_lsmid() != LSMID)                           \
> > +                     continue;                                       \
> > +     },                                                              \
> > +     /* END BLOCK BEFORE INVOCATION */                               \
> > +     /* BLOCK AFTER INVOCATION */                                    \
> > +     {                                                               \
> > +             goto out;                                               \
> > +     },                                                              \
> > +     /* END BLOCK AFTER INVOCATION */                                \
> > +     __VA_ARGS__);                                                   \
> > +out:                                                                 \
> > +     RC;                                                             \
> > +})
> >
> >  /* Security operations */
>
> ...
>
> > @@ -1581,15 +1629,19 @@ int security_sb_set_mnt_opts(struct super_block *sb,
> >                            unsigned long kern_flags,
> >                            unsigned long *set_kern_flags)
> >  {
> > -     struct lsm_static_call *scall;
> >       int rc = mnt_opts ? -EOPNOTSUPP : LSM_RET_DEFAULT(sb_set_mnt_opts);
> >
> > -     lsm_for_each_hook(scall, sb_set_mnt_opts) {
> > -             rc = scall->hl->hook.sb_set_mnt_opts(sb, mnt_opts, kern_flags,
> > -                                           set_kern_flags);
> > -             if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
> > -                     break;
> > -     }
> > +     lsm_for_each_hook(
> > +             sb_set_mnt_opts, rc,
> > +             /* BLOCK AFTER INVOCATION */
> > +             {
> > +                     if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
> > +                             goto out;
> > +             },
> > +             /* END BLOCK AFTER INVOCATION */
> > +             sb, mnt_opts, kern_flags, set_kern_flags);
> > +
> > +out:
> >       return rc;
> >  }
> >  EXPORT_SYMBOL(security_sb_set_mnt_opts);
>
> I know I was the one who asked to implement the static_calls for *all*
> of the LSM functions - thank you for doing that - but I think we can
> all agree that some of the resulting code is pretty awful.  I'm probably
> missing something important, but would an apporach similar to the pseudo
> code below work?

This does not work.

The special macro you are defining does not have the static_call
invocation and if you add that bit it's basically the __CALL_HOOK
macro or __CALL_STATIC_INT, __CALL_STATIC_VOID macro inlined
everywhere, I tried implementing it but it gets very dirty.

>
>   #define call_int_hook_special(HOOK, RC, LABEL, ...) \
>     LSM_LOOP_UNROLL(HOOK##_SPECIAL, RC, HOOK, LABEL, __VA_ARGS__)
>
>   int security_sb_set_mnt_opts(...)
>   {
>       int rc = LSM_RET_DEFAULT(sb_set_mnt_opts);
>
>   #define sb_set_mnt_opts_SPECIAL \
>       do { \
>         if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts)) \
>           goto out; \
>       } while (0)
>
>       rc = call_int_hook_special(sb_set_mnt_opts, rc, out, ...);
>
>   out:
>     return rc;
>   }
>
> > @@ -4040,7 +4099,6 @@ EXPORT_SYMBOL(security_d_instantiate);
> >  int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
> >                        u32 __user *size, u32 flags)
> >  {
> > -     struct lsm_static_call *scall;
> >       struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
> >       u8 __user *base = (u8 __user *)uctx;
> >       u32 entrysize;
> > @@ -4078,31 +4136,42 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
> >        * In the usual case gather all the data from the LSMs.
> >        * In the single case only get the data from the LSM specified.
> >        */
> > -     lsm_for_each_hook(scall, getselfattr) {
> > -             if (single && lctx.id != scall->hl->lsmid->id)
> > -                     continue;
> > -             entrysize = left;
> > -             if (base)
> > -                     uctx = (struct lsm_ctx __user *)(base + total);
> > -             rc = scall->hl->hook.getselfattr(attr, uctx, &entrysize, flags);
> > -             if (rc == -EOPNOTSUPP) {
> > -                     rc = 0;
> > -                     continue;
> > -             }
> > -             if (rc == -E2BIG) {
> > -                     rc = 0;
> > -                     left = 0;
> > -                     toobig = true;
> > -             } else if (rc < 0)
> > -                     return rc;
> > -             else
> > -                     left -= entrysize;
> > +     LSM_LOOP_UNROLL(
> > +             __CALL_HOOK, getselfattr, rc,
> > +             /* BLOCK BEFORE INVOCATION */
> > +             {
> > +                     if (single && lctx.id != current_lsmid())
> > +                             continue;
> > +                     entrysize = left;
> > +                     if (base)
> > +                             uctx = (struct lsm_ctx __user *)(base + total);
> > +             },
> > +             /* END BLOCK BEFORE INVOCATION */
> > +             /* BLOCK AFTER INVOCATION */
> > +             {
> > +                     if (rc == -EOPNOTSUPP) {
> > +                             rc = 0;
> > +                     } else {
> > +                             if (rc == -E2BIG) {
> > +                                     rc = 0;
> > +                                     left = 0;
> > +                                     toobig = true;
> > +                             } else if (rc < 0)
> > +                                     return rc;
> > +                             else
> > +                                     left -= entrysize;
> > +
> > +                             total += entrysize;
> > +                             count += rc;
> > +                             if (single)
> > +                                     goto out;
> > +                     }
> > +             },
> > +             /* END BLOCK AFTER INVOCATION */
> > +             attr, uctx, &entrysize, flags);
> > +
> > +out:
> >
> > -             total += entrysize;
> > -             count += rc;
> > -             if (single)
> > -                     break;
> > -     }
> >       if (put_user(total, size))
> >               return -EFAULT;
> >       if (toobig)
>
> I think we may need to admit defeat with security_getselfattr() and
> leave it as-is, the above is just too ugly to live.  I'd suggest
> adding a comment explaining that it wasn't converted due to complexity
> and the resulting awfulness.
>

I think your position on fixing everything is actually a valid one for
security, which is why I did not contest it.

The security_getselfattr is called very close to the syscall boundary
and the closer to the boundary the call is, the greater control the
attacker has over arguments and the easier it is to mount the attack.
This is why LSM indirect calls are a lucrative target because they
happen fairly early in the transition from user to kernel.
security_getselfattr is literally just in a SYSCALL_DEFINE

From a security perspective we should not leave this open.

- KP

> --
> paul-moore.com

