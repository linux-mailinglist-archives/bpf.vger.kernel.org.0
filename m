Return-Path: <bpf+bounces-58357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CB4AB90E9
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 22:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A661F5056A1
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 20:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0E29CB2F;
	Thu, 15 May 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQzVsxEQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464C29C34A
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747341548; cv=none; b=Vaysl7MuQv2LxcdUopI0uLoKVr6e9QtJOgUezq+RuSJvwycllC+OuXN9P8dEAKTu3WHUX0rqtFKGHq1sjB7llmzVMRiDH5xcCX8CQRe5Cg0g07DfS6goNmhdcbD304Xl+KT8mZIKW2i/2smUnctTzwM2c1j6akP0GKTaSGweE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747341548; c=relaxed/simple;
	bh=io3cxHoG89M5TIol9DjasL28jMLFbtTw3u9Lqruad5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeJ4qDBRktdKbeJrX1QSueVTOo8S0o6hpbWeSETCL1qS4LRU3DfCXEivzMzeG2cHgooFz8QqIPWo7ezAfSvXEC724mI2snpXsQ8HzdFgJvVnholvvaCe4A8AbpqiwTIJyggaXPWBnmQU7qoIzqVGuS2VuZzIPzOHWdCNGfFxxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQzVsxEQ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3081fe5987eso1273768a91.3
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747341545; x=1747946345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJ70Uwn1EUIgYj8p/Di66UkSyzDqVpefRhJGD8YpFQc=;
        b=ZQzVsxEQrpwJKxsWWHzJ58VRtbbx7Y7wwp9QwEFQuZRnZwzSwsYjroHdcsdCOQBh0f
         I+PIBnOOoWEqVTwYUdt5Y0w/N98hWNVT05mRnvdNIU41nRXuyvxRQl1Yxs7YftlOOWla
         N2JknpcTJ7ke6ZS4CABaKQ7AmxI2qaoa6o5WScw8AzOVLUopx+uPsfUrZzeBv25YRz2u
         s1yktX8qRDMi42+x2h0ZlEfwULXrrbZOAFVNOHTSMHR27S3GfxMmdWhPJKuev6zoAksO
         QWW0V+u9F0GM7pkujkmL7AYBP9zQGGwT9FTf17B6QEphiqmGZssnyrYANaypXu5GhXLv
         AuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747341545; x=1747946345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJ70Uwn1EUIgYj8p/Di66UkSyzDqVpefRhJGD8YpFQc=;
        b=xFGv0JizAPJFe1yAqXVMjRTvdn4Gpngmi7rkOi1qAUcnS1mNW6586ZchTi3nt9Fo+r
         4sjy9N5Gx0htlYZmzkYvSnqwzteujFmO4Vnj3P34IIRkV0l6IiqtZHY4WAkjKCc23t74
         EutTWDmz4bOInB33iPDM8EUh3/wSsIf3L34tgriPy61WZLW6FedwiFj7lud+WH91n6y+
         Hog4bYpjiwv514Ye42csL/3k5iri0dq7psbTde9VJiJxYozr+a+BofXPH8/QQnhXKcXt
         dah63k1K2VF5E8KpDh8d7uH9YaKrgIyH1XxBQnAukIFlZLh0WKt6KooijcU7+IsWLwA+
         TANA==
X-Gm-Message-State: AOJu0Yw3730C9vdYDbyIVhSZEiV6/z9V95HBJB5kFgb882uzRMl7zMkw
	iGgTq4PW1zyzoEm8A+6cGwXVcPVbKX/kPI6baHJ4cQ1Pk8cxQYg/Hkbc6wgY0qVSOq5AzNZrnwa
	7N8+Q50nWrOxeZsFdJB+5IDhiJMQW/p0=
X-Gm-Gg: ASbGnct1GgQRiuVYG7SUsTGVhGg//AhksBd0nS8gsDIyOzo2WZdbXhN6bVYWhQb8CqD
	PysoyH9YRbCQvBYMPGdy/KYVFUAx2mwIF1jdppOBz2cyltMc4xfuIRpjGev53qkshIAD6KF8nhF
	LFk2RZJBorPcKs0QqU77/3hdZHQxjoblX7mPFr1E7/MzyR/PSX
X-Google-Smtp-Source: AGHT+IEbuAB8UCOcectDsdYIM6KFnR5eMcjq7PmeeycAPLGvCzZD77ym0dg1F49z7ma7++GleK/cZNSCYugwqx1UNvs=
X-Received: by 2002:a17:90b:4a8d:b0:30a:b93e:381b with SMTP id
 98e67ed59e1d1-30e7d5bcf2emr876704a91.35.1747341544943; Thu, 15 May 2025
 13:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508223524.487875-1-yonghong.song@linux.dev> <20250508223534.488607-1-yonghong.song@linux.dev>
In-Reply-To: <20250508223534.488607-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 13:38:52 -0700
X-Gm-Features: AX0GCFu1WSgOm1ZYNlE9rZEKkF5dPWknlvoe24ICzxbLaxnm4_ifuCeVq4QN1lI
Message-ID: <CAEf4BzZc4fqF2Ez3f1HuMt6xL6PYC6U3iOqgb53BQmkmH5rLWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Implement mprog API on top of
 existing cgroup progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 3:35=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Current cgroup prog ordering is appending at attachment time. This is not
> ideal. In some cases, users want specific ordering at a particular cgroup
> level. To address this, the existing mprog API seems an ideal solution wi=
th
> supporting BPF_F_BEFORE and BPF_F_AFTER flags.
>
> But there are a few obstacles to directly use kernel mprog interface.
> Currently cgroup bpf progs already support prog attach/detach/replace
> and link-based attach/detach/replace. For example, in struct
> bpf_prog_array_item, the cgroup_storage field needs to be together
> with bpf prog. But the mprog API struct bpf_mprog_fp only has bpf_prog
> as the member, which makes it difficult to use kernel mprog interface.
>
> In another case, the current cgroup prog detach tries to use the
> same flag as in attach. This is different from mprog kernel interface
> which uses flags passed from user space.
>
> So to avoid modifying existing behavior, I made the following changes to
> support mprog API for cgroup progs:
>  - The support is for prog list at cgroup level. Cross-level prog list
>    (a.k.a. effective prog list) is not supported.
>  - Previously, BPF_F_PREORDER is supported only for prog attach, now
>    BPF_F_PREORDER is also supported by link-based attach.
>  - For attach, BPF_F_BEFORE/BPF_F_AFTER/BPF_F_ID is supported similar to
>    kernel mprog but with different implementation.
>  - For detach and replace, use the existing implementation.
>  - For attach, detach and replace, the revision for a particular prog
>    list, associated with a particular attach type, will be updated
>    by increasing count by 1.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/uapi/linux/bpf.h       |   7 ++
>  kernel/bpf/cgroup.c            | 144 ++++++++++++++++++++++++++++-----
>  kernel/bpf/syscall.c           |  44 ++++++----
>  tools/include/uapi/linux/bpf.h |   7 ++
>  4 files changed, 165 insertions(+), 37 deletions(-)
>

[...]

> +       if (!anchor_prog) {
> +               hlist_for_each_entry(pltmp, progs, node) {
> +                       if ((flags & BPF_F_BEFORE) && *ppltmp)
> +                               break;
> +                       *ppltmp =3D pltmp;

This is be correct, but it's less obvious why because of all the
loops, breaks, and NULL anchor prog. The idea here is to find the very
first pl for BPF_F_BEFORE or the very last for BPF_F_AFTER, right? So
wouldn't this be more obviously correct:

hlist_for_each_entry(pltmp, progs, node) {
    if (flags & BPF_F_BEFORE) {
        *ppltmp =3D pltmp;
        return NULL;
    }
    *ppltmp =3D pltmp;
}
return NULL;


I.e., once you know the result, just return as early as possible and
don't require tracing through the rest of code just to eventually
return all the same (but now somewhat disguised) values.


Though see my point about anchor_prog below, which will simplify this
to just `return pltmp;`


I'd also add a comment that if there is no anchor_prog, then
BPF_F_PREORDER doesn't matter because we either prepend or append to a
combined list of progs and end up with correct result

> +               }
> +       }  else {
> +               hlist_for_each_entry(pltmp, progs, node) {
> +                       pltmp_prog =3D pltmp->link ? pltmp->link->link.pr=
og : pltmp->prog;
> +                       if (pltmp_prog !=3D anchor_prog)
> +                               continue;
> +                       if (!!(pltmp->flags & BPF_F_PREORDER) !=3D preord=
er)
> +                               goto out;
> +                       *ppltmp =3D pltmp;
> +                       break;
> +               }
> +               if (!*ppltmp) {
> +                       ret =3D -ENOENT;
> +                       goto out;
> +               }
> +       }
> +
> +       return anchor_prog;
> +
> +out:
> +       bpf_prog_put(anchor_prog);
> +       return ERR_PTR(ret);
> +}
> +
> +static int insert_pl_to_hlist(struct bpf_prog_list *pl, struct hlist_hea=
d *progs,
> +                             struct bpf_prog *prog, u32 flags, u32 id_or=
_fd)
> +{
> +       struct bpf_prog_list *pltmp =3D NULL;
> +       struct bpf_prog *anchor_prog;
> +
> +       /* flags cannot have both BPF_F_BEFORE and BPF_F_AFTER */
> +       if ((flags & BPF_F_BEFORE) && (flags & BPF_F_AFTER))
> +               return -EINVAL;

I think this should be handled by get_anchor_prog(), both BPF_F_AFTER
and BPF_F_BEFORE will just result in no valid anchor program and we'll
error out below

> +
> +       anchor_prog =3D get_anchor_prog(progs, prog, flags, id_or_fd, &pl=
tmp);
> +       if (IS_ERR(anchor_prog))
> +               return PTR_ERR(anchor_prog);

it's confusing that we return anchor_prog but actually never use it,
no? wouldn't it make more sense to just return struct bpf_prog_list *
for an anchor then?

> +
> +       if (hlist_empty(progs))
> +               hlist_add_head(&pl->node, progs);
> +       else if (flags & BPF_F_BEFORE)
> +               hlist_add_before(&pl->node, &pltmp->node);
> +       else
> +               hlist_add_behind(&pl->node, &pltmp->node);
> +
> +       return 0;
> +}
> +
>  /**
>   * __cgroup_bpf_attach() - Attach the program or the link to a cgroup, a=
nd
>   *                         propagate the change to descendants
> @@ -633,6 +710,8 @@ static struct bpf_prog_list *find_attach_entry(struct=
 hlist_head *progs,
>   * @replace_prog: Previously attached program to replace if BPF_F_REPLAC=
E is set
>   * @type: Type of attach operation
>   * @flags: Option flags
> + * @id_or_fd: Relative prog id or fd
> + * @revision: bpf_prog_list revision
>   *
>   * Exactly one of @prog or @link can be non-null.
>   * Must be called with cgroup_mutex held.
> @@ -640,7 +719,8 @@ static struct bpf_prog_list *find_attach_entry(struct=
 hlist_head *progs,
>  static int __cgroup_bpf_attach(struct cgroup *cgrp,
>                                struct bpf_prog *prog, struct bpf_prog *re=
place_prog,
>                                struct bpf_cgroup_link *link,
> -                              enum bpf_attach_type type, u32 flags)
> +                              enum bpf_attach_type type, u32 flags, u32 =
id_or_fd,
> +                              u64 revision)
>  {
>         u32 saved_flags =3D (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_=
MULTI));
>         struct bpf_prog *old_prog =3D NULL;
> @@ -656,6 +736,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>             ((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI)))
>                 /* invalid combination */
>                 return -EINVAL;
> +       if ((flags & BPF_F_REPLACE) && (flags & (BPF_F_BEFORE | BPF_F_AFT=
ER)))
> +               /* only either replace or insertion with before/after */
> +               return -EINVAL;
>         if (link && (prog || replace_prog))
>                 /* only either link or prog/replace_prog can be specified=
 */
>                 return -EINVAL;
> @@ -663,9 +746,12 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>                 /* replace_prog implies BPF_F_REPLACE, and vice versa */
>                 return -EINVAL;
>
> +

nit: unnecessary empty line?

>         atype =3D bpf_cgroup_atype_find(type, new_prog->aux->attach_btf_i=
d);
>         if (atype < 0)
>                 return -EINVAL;
> +       if (revision && revision !=3D cgrp->bpf.revisions[atype])
> +               return -ESTALE;
>
>         progs =3D &cgrp->bpf.progs[atype];
>

[...]

> @@ -1312,7 +1409,8 @@ int cgroup_bpf_link_attach(const union bpf_attr *at=
tr, struct bpf_prog *prog)
>         struct cgroup *cgrp;
>         int err;
>
> -       if (attr->link_create.flags)
> +       if (attr->link_create.flags &&
> +           (attr->link_create.flags & (~(BPF_F_ID | BPF_F_BEFORE | BPF_F=
_AFTER | BPF_F_PREORDER))))

why the `attr->link_create.flags &&` check, seems unnecessary


also looking at BPF_F_ATTACH_MASK_MPROG, not allowing BPF_F_REPLACE
makes sense, but BPF_F_LINK makes sense for ordering, no?

>                 return -EINVAL;
>
>         cgrp =3D cgroup_get_from_fd(attr->link_create.target_fd);
> @@ -1336,7 +1434,9 @@ int cgroup_bpf_link_attach(const union bpf_attr *at=
tr, struct bpf_prog *prog)
>         }
>
>         err =3D cgroup_bpf_attach(cgrp, NULL, NULL, link,
> -                               link->type, BPF_F_ALLOW_MULTI);
> +                               link->type, BPF_F_ALLOW_MULTI | attr->lin=
k_create.flags,
> +                               attr->link_create.cgroup.relative_fd,
> +                               attr->link_create.cgroup.expected_revisio=
n);
>         if (err) {
>                 bpf_link_cleanup(&link_primer);
>                 goto out_put_cgroup;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index df33d19c5c3b..58ea3c38eabb 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4184,6 +4184,25 @@ static int bpf_prog_attach_check_attach_type(const=
 struct bpf_prog *prog,
>         }
>  }
>
> +static bool is_cgroup_prog_type(enum bpf_prog_type ptype, enum bpf_attac=
h_type atype,
> +                               bool check_atype)
> +{
> +       switch (ptype) {
> +       case BPF_PROG_TYPE_CGROUP_DEVICE:
> +       case BPF_PROG_TYPE_CGROUP_SKB:
> +       case BPF_PROG_TYPE_CGROUP_SOCK:
> +       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> +       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> +       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> +       case BPF_PROG_TYPE_SOCK_OPS:
> +               return true;
> +       case BPF_PROG_TYPE_LSM:
> +               return check_atype ? atype =3D=3D BPF_LSM_CGROUP : true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  #define BPF_PROG_ATTACH_LAST_FIELD expected_revision
>
>  #define BPF_F_ATTACH_MASK_BASE \
> @@ -4214,6 +4233,9 @@ static int bpf_prog_attach(const union bpf_attr *at=
tr)
>         if (bpf_mprog_supported(ptype)) {
>                 if (attr->attach_flags & ~BPF_F_ATTACH_MASK_MPROG)
>                         return -EINVAL;
> +       } else if (is_cgroup_prog_type(ptype, 0, false)) {
> +               if (attr->attach_flags & BPF_F_LINK)
> +                       return -EINVAL;

Why disable BPF_F_LINK? It's just a matter of using FD/ID for link vs
program to specify the place to attach. It doesn't mean that we need
to attach through BPF link interface. Or am I misremembering?

>         } else {
>                 if (attr->attach_flags & ~BPF_F_ATTACH_MASK_BASE)
>                         return -EINVAL;
> @@ -4242,20 +4264,6 @@ static int bpf_prog_attach(const union bpf_attr *a=
ttr)
>         case BPF_PROG_TYPE_FLOW_DISSECTOR:
>                 ret =3D netns_bpf_prog_attach(attr, prog);
>                 break;
> -       case BPF_PROG_TYPE_CGROUP_DEVICE:
> -       case BPF_PROG_TYPE_CGROUP_SKB:
> -       case BPF_PROG_TYPE_CGROUP_SOCK:
> -       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> -       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> -       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> -       case BPF_PROG_TYPE_SOCK_OPS:
> -       case BPF_PROG_TYPE_LSM:
> -               if (ptype =3D=3D BPF_PROG_TYPE_LSM &&
> -                   prog->expected_attach_type !=3D BPF_LSM_CGROUP)
> -                       ret =3D -EINVAL;
> -               else
> -                       ret =3D cgroup_bpf_prog_attach(attr, ptype, prog)=
;
> -               break;
>         case BPF_PROG_TYPE_SCHED_CLS:
>                 if (attr->attach_type =3D=3D BPF_TCX_INGRESS ||
>                     attr->attach_type =3D=3D BPF_TCX_EGRESS)
> @@ -4264,7 +4272,10 @@ static int bpf_prog_attach(const union bpf_attr *a=
ttr)
>                         ret =3D netkit_prog_attach(attr, prog);
>                 break;
>         default:
> -               ret =3D -EINVAL;
> +               if (!is_cgroup_prog_type(ptype, prog->expected_attach_typ=
e, true))
> +                       ret =3D -EINVAL;
> +               else
> +                       ret =3D cgroup_bpf_prog_attach(attr, ptype, prog)=
;
>         }
>
>         if (ret)

[...]

