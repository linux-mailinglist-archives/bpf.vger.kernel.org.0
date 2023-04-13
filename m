Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF45B6E0325
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 02:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjDMAXh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 20:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDMAXc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 20:23:32 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EE713D;
        Wed, 12 Apr 2023 17:23:30 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v7so12227483ybi.0;
        Wed, 12 Apr 2023 17:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681345410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMml+0yDt+eSbzRoA/n12amRIXQAb5pcI4gqTb5DuLQ=;
        b=WzoHk+sfmC2MNoGQSog9BAx3Cn2gVsSqg9Xbk6HYCpgPWYfxursH7aGw76zjRdAeNN
         KBjdX6apKzc46EFCACAmOxoR/RTcre2vy/HIgruV+WZPuvCcYa3SXPI8ysOIvWttamFS
         TejndWJatsPMmyCWoDzwIGZ2jbKo3qlQ+KaA0t82l1eTG+phxDI06D+NHkFmUQxP2xyr
         aK6EzpYlbe7N2Of9reVzkh2wKp68OMjEYH/uM65olBkztnDYYeLqp2RnJaEAfTcBHkCl
         cX9KyR8oGB0A3LUWBqBmXp+v7Jbfk33FuUnCW6NYiBZIwukxBEhxdkVnN8Dws4PPik5x
         9EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681345410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMml+0yDt+eSbzRoA/n12amRIXQAb5pcI4gqTb5DuLQ=;
        b=bocqwr78/WcJllw0cMNTa/QLlodw7QL6BOV7ZgRWYWLQANNM+YCUcSAg6ByZ6pw3UO
         Murd8q/qbN1+Hyz7tzHbwFlGq+dLZ7jqgu7dMgqfvoEhkDFGNH8GdNHdUFx/qHJ7EoL7
         Aai2UxHouFLwM4E59i+gLAeq4/Q9g6R61AEwh8PUqXlsPoOl9bYZar2dHdbhgUTScE+i
         WAnDJ52d4tKpRV9hDmyL+fJ0eaTLF3TXmoMi0jvmfF/81dFpLvb++rGj2p343+pwjZUi
         3GNUipN71nAoyvPMpvRMLI/3+3fWHPQFXJYECDI6xd0tBA3IoARe2zEG30Xdz3RuR7Si
         LzDA==
X-Gm-Message-State: AAQBX9czxeyN9pqYPyT6D5F57yhKS8AF6c3i+bweTZS8/rCUHluLxwPW
        SRrnsRz15Dd/LnzNQ9AxvnZTUuzWLXZvIv3aafo=
X-Google-Smtp-Source: AKy350a2tiBtoaenWwrnSkFGsluIWUIKJ2Y6+dR4lgQ73OyE3IiCYbXkBhQ88U/AYWGCytSHKmXdQ4PHXe/mHz2wYCE=
X-Received: by 2002:a25:cfce:0:b0:b33:531b:3dd4 with SMTP id
 f197-20020a25cfce000000b00b33531b3dd4mr224833ybg.1.1681345409641; Wed, 12 Apr
 2023 17:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230412043300.360803-1-andrii@kernel.org> <20230412043300.360803-5-andrii@kernel.org>
 <6436f67a.a70a0220.58151.7529@mx.google.com>
In-Reply-To: <6436f67a.a70a0220.58151.7529@mx.google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 17:23:15 -0700
Message-ID: <CAEf4BzY3dGSfeOr28Us3m1gbu2qK-QGSzke4AuUHzahCQX2rOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: implement bpf_map_create_security
 LSM hook
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        paul@paul-moore.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 11:20=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Tue, Apr 11, 2023 at 09:32:56PM -0700, Andrii Nakryiko wrote:
> > Add new LSM hook, bpf_map_create_security, that allows custom LSM
> > security policies controlling BPF map creation permissions granularly
> > and precisely.
>
> Naming nit-pick: the hook name doesn't need the "_security" suffix, if I'=
m
> reading this correctly. The LSM hooks with that are really around the
> allocation/initialization of LSM-specific memory (i.e. attach
> LSM-specific allocation to an inode, etc).

Ah, I didn't know about this convention. I though that _security is
preferred way, as we have a bunch more BPF-related hooks with this
naming pattern (bpf_map_free_security, bpf_prog_free_security).

>
> The hook looks like it's "only" policy, so it can just be called
> "bpf_map_create".

Yep, I'll drop _security suffix, no need to add to confusion.


>
> > This new LSM hook allows to implement both LSM policy that could enforc=
e
> > more granular and restrictive decisions about which processes can creat=
e
> > which BPF maps, by rejecting BPF map creation based on passed in
> > bpf_attr attributes. But also it allows to bypass CAP_BPF and
> > CAP_NET_ADMIN restrictions, normally enforced by kernel, for
> > applications that LSM policy deems trusted. Trustworthiness
> > determination of the process/user/cgroup/etc is left up to custom LSM
> > hook implementation and will dependon particular production setup of
> > each individual use case.
>
> As Paul mentioned, we need to give a careful examination of the access
> control logic here. BPF is not deal with POSIX or DAC rules, so I think
> there isn't a problem being flexible here, but it would be nice to find
> a way to make this be "default reject" via capabilities that doesn't
> differ much from the way things happen normally in the LSM (so that it
> can be successfully reasoned about without need to consider BPF-specific
> "special cases").

It is definitely not my intent to create unnecessary special casing
here. I think it does "default reject" (modulo cases when one doesn't
require extra permissions already), see below, but if I missed
anything, please do point out.

>
> > If LSM policy wants to rely on default kernel logic, it can return
> > 0 to delegate back to kernel. If it returns >0 return code,
> > kernel will bypass its normal checks. This way it's possible to perform
> > a delegation of trust (specifically for BPF map creation) from
> > privileged LSM custom policy implementation to unprivileged user
> > process, verifier and trusted by custom LSM policy.
>
> At the least, I think the language of "bypass" is going to cause a not
> of friction. :) We make to make sure this fails safe -- if there is no
> loaded policy, capable() needs to remain the back-stop.

I was under the impression that that's how it works already. These
hooks use call_int_hook() helper and specify 0 as default. If no LSM
hook is installed, the returned result will stay 0, which will fall
through to normal kernel checks we have.

When you say "make sure this fails safe", do you mean to just double
check this semantics, or some extra code and checks that I should add
to make sure this works as expected?


>
> > Such model allows flexible and secure-by-default approach where user
> > processes that need to use BPF features (BPF map creation, in this case=
)
> > are left unprivileged with no CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON, etc.
> > capabilities, but specific exceptions are implemented (usually in
> > a centralized server fleet-wide fashion) for trusted
> > processes/containers/users, allowing them to manipulate BPF facilities,
> > as long as they are allowed and known apriori.
>
> if (!unprivileged_allowed(...) && !capable(...))
>         return -EPERM;
>
> and uprivileged_allowed() is looking at the sysctl and LSM policy.

make sense, I'll refactor all this to have this more recognizable
"shape" to make the intent clearer, thanks

>
> >
> > This patch implements first required part for full-fledged BPF usage:
> > map creation. The other one, BPF program load, will be addressed in
> > follow up patches.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/lsm_hooks.h     | 12 ++++++++++++
> >  include/linux/security.h      |  6 ++++++
> >  kernel/bpf/bpf_lsm.c          |  1 +
> >  kernel/bpf/syscall.c          | 19 ++++++++++++++++---
> >  security/security.c           |  4 ++++
> >  6 files changed, 40 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> > index 094b76dc7164..b4fe9ed7021a 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -396,6 +396,7 @@ LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void =
*lsmrule)
> >  LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size=
)
> >  LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
> >  LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
> > +LSM_HOOK(int, 0, bpf_map_create_security, const union bpf_attr *attr)
> >  LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
> >  LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *ma=
p)
> >  LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 6e156d2acffc..42bf7c0aa4d8 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -1598,6 +1598,18 @@
> >   *   @prog: bpf prog that userspace want to use.
> >   *   Return 0 if permission is granted.
> >   *
> > + * @bpf_map_create_security:
> > + *   Do a check to determine permission to create requested BPF map.
> > + *   Implementation can override kernel capabilities checks according =
to
> > + *   the rules below:
> > + *     - 0 should be returned to delegate permission checks to other
> > + *       installed LSM callbacks and/or hard-wired kernel logic, which
> > + *       would enforce CAP_BPF/CAP_NET_ADMIN capabilities;
> > + *     - reject BPF map creation by returning -EPERM or any other
> > + *       negative error code;
> > + *     - allow BPF map creation, overriding kernel checks, by returnin=
g
> > + *       a positive result.
> > + *
> >   * @bpf_map_alloc_security:
> >   *   Initialize the security field inside bpf map.
> >   *   Return 0 on success, error on failure.
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 5984d0d550b4..e5374fe92ef6 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -2023,6 +2023,7 @@ struct bpf_prog_aux;
> >  extern int security_bpf(int cmd, union bpf_attr *attr, unsigned int si=
ze);
> >  extern int security_bpf_map(struct bpf_map *map, fmode_t fmode);
> >  extern int security_bpf_prog(struct bpf_prog *prog);
> > +extern int security_bpf_map_create(const union bpf_attr *attr);
> >  extern int security_bpf_map_alloc(struct bpf_map *map);
> >  extern void security_bpf_map_free(struct bpf_map *map);
> >  extern int security_bpf_prog_alloc(struct bpf_prog_aux *aux);
> > @@ -2044,6 +2045,11 @@ static inline int security_bpf_prog(struct bpf_p=
rog *prog)
> >       return 0;
> >  }
> >
> > +static inline int security_bpf_map_create(const union bpf_attr *attr)
> > +{
> > +     return 0;
> > +}
>
> I would expect this to be something like:
>
>         return sysctl_unprivileged_bpf_disabled ? -EPERM : 0;

So I'd need to duplicate this check in two places: default
security_bpf_map_create implemented if !CONFIG_SECURITY &&
!CONFIG_BPF_SYSCALL and the actual one when both are defined. Do you
think it's worth it to duplicate this check instead of having it
checked (or skipped if LSM hook allows it) explicitly in map_create()
in kernel/bpf/syscall.c?

I personally find it harder to keep track of overall logic if it's
spread like this, as sysctl_unprivileged_bpf_disabled is not really
LSM-related.

>
> > +
> >  static inline int security_bpf_map_alloc(struct bpf_map *map)
> >  {
> >       return 0;
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index e14c822f8911..931d4dda5dac 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -260,6 +260,7 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const =
struct bpf_prog *prog)
> >  BTF_SET_START(sleepable_lsm_hooks)
> >  BTF_ID(func, bpf_lsm_bpf)
> >  BTF_ID(func, bpf_lsm_bpf_map)
> > +BTF_ID(func, bpf_lsm_bpf_map_create_security)
> >  BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
> >  BTF_ID(func, bpf_lsm_bpf_map_free_security)
> >  BTF_ID(func, bpf_lsm_bpf_prog)
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index cbea4999e92f..7d1165814efc 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -980,7 +980,7 @@ int map_check_no_btf(const struct bpf_map *map,
> >  }
> >
> >  static int map_check_btf(struct bpf_map *map, const struct btf *btf,
> > -                      u32 btf_key_id, u32 btf_value_id)
> > +                      u32 btf_key_id, u32 btf_value_id, bool priv_chec=
ked)
> >  {
> >       const struct btf_type *key_type, *value_type;
> >       u32 key_size, value_size;
> > @@ -1008,7 +1008,7 @@ static int map_check_btf(struct bpf_map *map, con=
st struct btf *btf,
> >       if (!IS_ERR_OR_NULL(map->record)) {
> >               int i;
> >
> > -             if (!bpf_capable()) {
> > +             if (!priv_checked && !bpf_capable()) {
> >                       ret =3D -EPERM;
> >                       goto free_map_tab;
> >               }
> > @@ -1097,10 +1097,12 @@ static int map_create(union bpf_attr *attr)
> >       int numa_node =3D bpf_map_attr_numa_node(attr);
> >       u32 map_type =3D attr->map_type;
> >       struct btf_field_offs *foffs;
> > +     bool priv_checked =3D false;
> >       struct bpf_map *map;
> >       int f_flags;
> >       int err;
> >
> > +     /* sanity checks */
> >       err =3D CHECK_ATTR(BPF_MAP_CREATE);
> >       if (err)
> >               return -EINVAL;
> > @@ -1145,6 +1147,15 @@ static int map_create(union bpf_attr *attr)
> >       if (!ops->map_mem_usage)
> >               return -EINVAL;
> >
> > +     /* security checks */
> > +     err =3D security_bpf_map_create(attr);
> > +     if (err < 0)
> > +             return err;
> > +     if (err > 0) {
> > +             priv_checked =3D true;
> > +             goto skip_priv_checks;
> > +     }
>
> I think we can refactor this to avoid the concept of "skipping" checks.

Yep, makes sense, will do

>
> Also, I think passing "priv_checked" is kind of confusing -- I feel like
> access control should either be centralized or in each individual
> function. Why is there a need to split this up?

Yeah, I hate this bit. There is this extra bpf_capable() check much
later on only if a particular BPF map happens to have custom
user-defined extra features (like spin lock and stuff like this).
There is no way to know this upfront without doing lots of preparatory
work. So there has to be something to let that later code say that
it's ok to use this advanced feature.

I'm actually thinking to have a bool flag on struct bpf_map itself  to
record whether BPF map is considered to be "privileged", and thus any
other advanced features like that won't have to do bpf_capable()
check, they will be just checking this recorded bool. We have a
similar approach for BPF programs, where we remember during
verification whether a BPF program had CAP_BPF, which influences which
features are allowed for it.

This will be a bit cleaner, I think.

>
> > +
> >       /* Intent here is for unprivileged_bpf_disabled to block key obje=
ct
> >        * creation commands for unprivileged users; other actions depend
> >        * of fd availability and access to bpffs, so are dependent on
> > @@ -1203,6 +1214,8 @@ static int map_create(union bpf_attr *attr)
> >               return -EPERM;
> >       }
> >
> > +skip_priv_checks:
> > +     /* create and init map */
> >       map =3D ops->map_alloc(attr);
> >       if (IS_ERR(map))
> >               return PTR_ERR(map);
> > @@ -1243,7 +1256,7 @@ static int map_create(union bpf_attr *attr)
> >
> >               if (attr->btf_value_type_id) {
> >                       err =3D map_check_btf(map, btf, attr->btf_key_typ=
e_id,
> > -                                         attr->btf_value_type_id);
> > +                                         attr->btf_value_type_id, priv=
_checked);
> >                       if (err)
> >                               goto free_map;
> >               }
> > diff --git a/security/security.c b/security/security.c
> > index cf6cc576736f..f9b885680966 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2682,6 +2682,10 @@ int security_bpf_prog(struct bpf_prog *prog)
> >  {
> >       return call_int_hook(bpf_prog, 0, prog);
> >  }
> > +int security_bpf_map_create(const union bpf_attr *attr)
> > +{
> > +     return call_int_hook(bpf_map_create_security, 0, attr);
>
> And the default return value here wouldn't be 0, but:
>
>         sysctl_unprivileged_bpf_disabled ?  -EPERM : 0

replied above, I do find that hiding sysctl_unprivileged_bpf_disabled
handling so deep make following the overall flow more confusing


>
> > +}
> >  int security_bpf_map_alloc(struct bpf_map *map)
> >  {
> >       return call_int_hook(bpf_map_alloc_security, 0, map);
> > --
> > 2.34.1
> >
>
> --
> Kees Cook
