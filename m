Return-Path: <bpf+bounces-58360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57741AB9129
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 23:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5861AA06146
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42BB1E7C03;
	Thu, 15 May 2025 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQZrwFaK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CACC4174A
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343165; cv=none; b=bx45KxbLvUIEbLAR8ojqtdblvYVgOi/84Tw2WriadaQFBtgnuf0tlEx9TUPjYfsMTXsmnp9JcXBUG5psbhozubuh6Grj9yHSYURPLlX0MTbdlQir9OoZPYkEwX8XTG8LD7ZpB5N8RCHZeDZDDsF6vT5DJfBAYOaGxK/zvIL18Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343165; c=relaxed/simple;
	bh=QuPvng0CbS80nx0UsiUEiS9x/NBCfTIC33d5x99HnJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnlNQD5nVnqXRBYx0S+A6BkVSHOXFjFayde2VcS9+50hMcOsERjNBWOeGBll3WSlcXOU+N04yiQZ7vT/DHvk3dLLWUqrUnnLzFhwzmYuRLJrYUUkFqJZx9SpmT6ViW+NFrMbmaD+c+AKcaWKB6aJ9NEQnLet/5qDFi8mnxrNU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQZrwFaK; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30c3a038acfso1751100a91.3
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 14:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747343163; x=1747947963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVf9uLlDVZ3IIp2SNUCTE31XRHhJJq0Mx+V+SmxHIko=;
        b=VQZrwFaKDQwqFxHwveCPA4PL2mz+476kmmxiV+9hyXiWzHZ8p+Rr6S/NJsIT63M6AL
         LLuA7fLVdlvlQwzAFBU4LaEbiByH8TrreZ5Dr/kO9ABdDDx8y34c5hiM818ugQzvc4uI
         WsgpA+Pp5inqbJwBotRsYpc6J3dlcgGWCQbpjX7hXt7TBZTxdwaXr9UQYm++2+GQUV47
         HtUjamqXMAGz2BTlBJnkiuOc2HQWhHBUKpbKj0QdCH5UKWAEz3n/wK8Q0nbcYbpRheXt
         HCbzETPTRS7hTEZnJX54tcEq9I4Q+MO8fIHlu7X99ckJgD7R3+uJsMnsREx2ckJdPv5t
         DTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747343163; x=1747947963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVf9uLlDVZ3IIp2SNUCTE31XRHhJJq0Mx+V+SmxHIko=;
        b=a84I6/w4E2CwQmQFbpVBFDs83tiQpqPh1vQgb72q5AlCY/ei44R7RJaX1ER9fBycrL
         /rj4PeTs2nCVdNbA0pYLmFU3kTP0v5snL5O8TvJP6jcPQV0FCY49GcUlxCk0KrLqkg7q
         fGJWntAGt41U/7BJ0Zm/NBCLOLmMxCw2unegGQSSY7DAtPmbR64KTVvDS7u1jZzzQXG9
         kl9aK1VjbLQhziChCW4E7LOxgW+Xr3OWRoHAmtYZhRPy5UOpt31xvzJYG2Ba/MgV3uGG
         OjdYXjyUZWAbH767+AEaM+Ff4R8f4zz4NAe9k/37C0GE5T8mxrXf+ghqj9boqyLwGfJB
         F4tw==
X-Gm-Message-State: AOJu0Yya+kG3CAUAVkgyV1e7jFrgmZ0qpBGOW/UpsqAO3tws6pOoBOtp
	X0fbySPjkJq1pKxX11pCtAW72ICEojQRuHj4afC/kynf0dNHBwXr2p0sVKc4u626mznk8DScggw
	xDRpSo9csZnfLDJEvMU2Kur8QZAElEHg=
X-Gm-Gg: ASbGncvUZOtimq73K1mOcuSj18HQQ68ayaIhHNYmph6eUFZHmdig1G7Ue55i0YGDLQ9
	cKNrvFpQTgTk+rJ+NgkMs9nr319WCuBKtzhWVUFCOFjs1JJbmECa5WG2KFRc64C+GZLdWfnQpyh
	guVzXqgpwSRaYsv5fDmsATIz4dUmV258PCf8x3/Sy+KIJ/mrlR
X-Google-Smtp-Source: AGHT+IFR8vbrG0nNYLdhXSxGDMYQF5TsjFhyL0z6BMKp9PT7HPoOGcO/KA2YBOTjwXXaKfRiHIpirEK6V1P0t6AOvds=
X-Received: by 2002:a17:90b:574c:b0:308:7270:d6ea with SMTP id
 98e67ed59e1d1-30e7d5b7b41mr1097641a91.30.1747343162592; Thu, 15 May 2025
 14:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508223524.487875-1-yonghong.song@linux.dev>
 <20250508223534.488607-1-yonghong.song@linux.dev> <CAEf4BzZc4fqF2Ez3f1HuMt6xL6PYC6U3iOqgb53BQmkmH5rLWg@mail.gmail.com>
In-Reply-To: <CAEf4BzZc4fqF2Ez3f1HuMt6xL6PYC6U3iOqgb53BQmkmH5rLWg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 May 2025 14:05:50 -0700
X-Gm-Features: AX0GCFvsoyWEIXPqLKvGVG6vh6w8DEr17CWT49sYAcYsDrKKst6QqvsJ7Mf3brY
Message-ID: <CAEf4BzaEKFJ08bJEvnEV-qbf-ZD7VnZuF35N7dp1646tYWrPtw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Implement mprog API on top of
 existing cgroup progs
To: Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 1:38=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 8, 2025 at 3:35=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
> >
> > Current cgroup prog ordering is appending at attachment time. This is n=
ot
> > ideal. In some cases, users want specific ordering at a particular cgro=
up
> > level. To address this, the existing mprog API seems an ideal solution =
with
> > supporting BPF_F_BEFORE and BPF_F_AFTER flags.
> >
> > But there are a few obstacles to directly use kernel mprog interface.
> > Currently cgroup bpf progs already support prog attach/detach/replace
> > and link-based attach/detach/replace. For example, in struct
> > bpf_prog_array_item, the cgroup_storage field needs to be together
> > with bpf prog. But the mprog API struct bpf_mprog_fp only has bpf_prog
> > as the member, which makes it difficult to use kernel mprog interface.
> >
> > In another case, the current cgroup prog detach tries to use the
> > same flag as in attach. This is different from mprog kernel interface
> > which uses flags passed from user space.
> >
> > So to avoid modifying existing behavior, I made the following changes t=
o
> > support mprog API for cgroup progs:
> >  - The support is for prog list at cgroup level. Cross-level prog list
> >    (a.k.a. effective prog list) is not supported.
> >  - Previously, BPF_F_PREORDER is supported only for prog attach, now
> >    BPF_F_PREORDER is also supported by link-based attach.
> >  - For attach, BPF_F_BEFORE/BPF_F_AFTER/BPF_F_ID is supported similar t=
o
> >    kernel mprog but with different implementation.
> >  - For detach and replace, use the existing implementation.
> >  - For attach, detach and replace, the revision for a particular prog
> >    list, associated with a particular attach type, will be updated
> >    by increasing count by 1.
> >
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >  include/uapi/linux/bpf.h       |   7 ++
> >  kernel/bpf/cgroup.c            | 144 ++++++++++++++++++++++++++++-----
> >  kernel/bpf/syscall.c           |  44 ++++++----
> >  tools/include/uapi/linux/bpf.h |   7 ++
> >  4 files changed, 165 insertions(+), 37 deletions(-)
> >
>
> [...]
>
> > +       if (!anchor_prog) {
> > +               hlist_for_each_entry(pltmp, progs, node) {
> > +                       if ((flags & BPF_F_BEFORE) && *ppltmp)
> > +                               break;
> > +                       *ppltmp =3D pltmp;
>
> This is be correct, but it's less obvious why because of all the
> loops, breaks, and NULL anchor prog. The idea here is to find the very
> first pl for BPF_F_BEFORE or the very last for BPF_F_AFTER, right? So
> wouldn't this be more obviously correct:
>
> hlist_for_each_entry(pltmp, progs, node) {
>     if (flags & BPF_F_BEFORE) {
>         *ppltmp =3D pltmp;
>         return NULL;
>     }
>     *ppltmp =3D pltmp;
> }
> return NULL;
>
>
> I.e., once you know the result, just return as early as possible and
> don't require tracing through the rest of code just to eventually
> return all the same (but now somewhat disguised) values.
>
>
> Though see my point about anchor_prog below, which will simplify this
> to just `return pltmp;`
>
>
> I'd also add a comment that if there is no anchor_prog, then
> BPF_F_PREORDER doesn't matter because we either prepend or append to a
> combined list of progs and end up with correct result
>
> > +               }
> > +       }  else {
> > +               hlist_for_each_entry(pltmp, progs, node) {
> > +                       pltmp_prog =3D pltmp->link ? pltmp->link->link.=
prog : pltmp->prog;
> > +                       if (pltmp_prog !=3D anchor_prog)
> > +                               continue;
> > +                       if (!!(pltmp->flags & BPF_F_PREORDER) !=3D preo=
rder)
> > +                               goto out;
> > +                       *ppltmp =3D pltmp;
> > +                       break;
> > +               }
> > +               if (!*ppltmp) {
> > +                       ret =3D -ENOENT;
> > +                       goto out;
> > +               }
> > +       }
> > +
> > +       return anchor_prog;
> > +
> > +out:
> > +       bpf_prog_put(anchor_prog);
> > +       return ERR_PTR(ret);
> > +}
> > +
> > +static int insert_pl_to_hlist(struct bpf_prog_list *pl, struct hlist_h=
ead *progs,
> > +                             struct bpf_prog *prog, u32 flags, u32 id_=
or_fd)
> > +{
> > +       struct bpf_prog_list *pltmp =3D NULL;
> > +       struct bpf_prog *anchor_prog;
> > +
> > +       /* flags cannot have both BPF_F_BEFORE and BPF_F_AFTER */
> > +       if ((flags & BPF_F_BEFORE) && (flags & BPF_F_AFTER))
> > +               return -EINVAL;
>
> I think this should be handled by get_anchor_prog(), both BPF_F_AFTER
> and BPF_F_BEFORE will just result in no valid anchor program and we'll
> error out below

Oh, I just randomly realized that there is a special case that I think
is allowed by Daniel's mprog implementation, and it might be important
for some users. If both BPF_F_BEFORE and BPF_F_AFTER are specified and
there is no ID/FD, then this combination would succeed if and only if
the currently attached list of progs is empty. Check
bpf_mprog_attach() and how it handles BPF_F_BEFORE and BPF_F_AFTER
completely independently calculating tidx. If tidx ends up being
consistent (which should be -1 for empty list), then that's where the
prog/link is inserted (-1 result in prepending into an empty list).


Daniel, can you please double check and generally take a look at this
patch set, given you have the most detailed knowledge of mprog
interface? Thanks!

>
> > +
> > +       anchor_prog =3D get_anchor_prog(progs, prog, flags, id_or_fd, &=
pltmp);
> > +       if (IS_ERR(anchor_prog))
> > +               return PTR_ERR(anchor_prog);
>
> it's confusing that we return anchor_prog but actually never use it,
> no? wouldn't it make more sense to just return struct bpf_prog_list *
> for an anchor then?
>
> > +
> > +       if (hlist_empty(progs))
> > +               hlist_add_head(&pl->node, progs);
> > +       else if (flags & BPF_F_BEFORE)
> > +               hlist_add_before(&pl->node, &pltmp->node);
> > +       else
> > +               hlist_add_behind(&pl->node, &pltmp->node);
> > +
> > +       return 0;
> > +}
> > +
> >  /**
> >   * __cgroup_bpf_attach() - Attach the program or the link to a cgroup,=
 and
> >   *                         propagate the change to descendants
> > @@ -633,6 +710,8 @@ static struct bpf_prog_list *find_attach_entry(stru=
ct hlist_head *progs,
> >   * @replace_prog: Previously attached program to replace if BPF_F_REPL=
ACE is set
> >   * @type: Type of attach operation
> >   * @flags: Option flags
> > + * @id_or_fd: Relative prog id or fd
> > + * @revision: bpf_prog_list revision
> >   *
> >   * Exactly one of @prog or @link can be non-null.
> >   * Must be called with cgroup_mutex held.
> > @@ -640,7 +719,8 @@ static struct bpf_prog_list *find_attach_entry(stru=
ct hlist_head *progs,
> >  static int __cgroup_bpf_attach(struct cgroup *cgrp,
> >                                struct bpf_prog *prog, struct bpf_prog *=
replace_prog,
> >                                struct bpf_cgroup_link *link,
> > -                              enum bpf_attach_type type, u32 flags)
> > +                              enum bpf_attach_type type, u32 flags, u3=
2 id_or_fd,
> > +                              u64 revision)
> >  {
> >         u32 saved_flags =3D (flags & (BPF_F_ALLOW_OVERRIDE | BPF_F_ALLO=
W_MULTI));
> >         struct bpf_prog *old_prog =3D NULL;
> > @@ -656,6 +736,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
> >             ((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI)))
> >                 /* invalid combination */
> >                 return -EINVAL;
> > +       if ((flags & BPF_F_REPLACE) && (flags & (BPF_F_BEFORE | BPF_F_A=
FTER)))
> > +               /* only either replace or insertion with before/after *=
/
> > +               return -EINVAL;
> >         if (link && (prog || replace_prog))
> >                 /* only either link or prog/replace_prog can be specifi=
ed */
> >                 return -EINVAL;
> > @@ -663,9 +746,12 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp=
,
> >                 /* replace_prog implies BPF_F_REPLACE, and vice versa *=
/
> >                 return -EINVAL;
> >
> > +
>
> nit: unnecessary empty line?
>
> >         atype =3D bpf_cgroup_atype_find(type, new_prog->aux->attach_btf=
_id);
> >         if (atype < 0)
> >                 return -EINVAL;
> > +       if (revision && revision !=3D cgrp->bpf.revisions[atype])
> > +               return -ESTALE;
> >
> >         progs =3D &cgrp->bpf.progs[atype];
> >
>
> [...]
>
> > @@ -1312,7 +1409,8 @@ int cgroup_bpf_link_attach(const union bpf_attr *=
attr, struct bpf_prog *prog)
> >         struct cgroup *cgrp;
> >         int err;
> >
> > -       if (attr->link_create.flags)
> > +       if (attr->link_create.flags &&
> > +           (attr->link_create.flags & (~(BPF_F_ID | BPF_F_BEFORE | BPF=
_F_AFTER | BPF_F_PREORDER))))
>
> why the `attr->link_create.flags &&` check, seems unnecessary
>
>
> also looking at BPF_F_ATTACH_MASK_MPROG, not allowing BPF_F_REPLACE
> makes sense, but BPF_F_LINK makes sense for ordering, no?
>
> >                 return -EINVAL;
> >
> >         cgrp =3D cgroup_get_from_fd(attr->link_create.target_fd);
> > @@ -1336,7 +1434,9 @@ int cgroup_bpf_link_attach(const union bpf_attr *=
attr, struct bpf_prog *prog)
> >         }
> >
> >         err =3D cgroup_bpf_attach(cgrp, NULL, NULL, link,
> > -                               link->type, BPF_F_ALLOW_MULTI);
> > +                               link->type, BPF_F_ALLOW_MULTI | attr->l=
ink_create.flags,
> > +                               attr->link_create.cgroup.relative_fd,
> > +                               attr->link_create.cgroup.expected_revis=
ion);
> >         if (err) {
> >                 bpf_link_cleanup(&link_primer);
> >                 goto out_put_cgroup;
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index df33d19c5c3b..58ea3c38eabb 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -4184,6 +4184,25 @@ static int bpf_prog_attach_check_attach_type(con=
st struct bpf_prog *prog,
> >         }
> >  }
> >
> > +static bool is_cgroup_prog_type(enum bpf_prog_type ptype, enum bpf_att=
ach_type atype,
> > +                               bool check_atype)
> > +{
> > +       switch (ptype) {
> > +       case BPF_PROG_TYPE_CGROUP_DEVICE:
> > +       case BPF_PROG_TYPE_CGROUP_SKB:
> > +       case BPF_PROG_TYPE_CGROUP_SOCK:
> > +       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> > +       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> > +       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> > +       case BPF_PROG_TYPE_SOCK_OPS:
> > +               return true;
> > +       case BPF_PROG_TYPE_LSM:
> > +               return check_atype ? atype =3D=3D BPF_LSM_CGROUP : true=
;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> >  #define BPF_PROG_ATTACH_LAST_FIELD expected_revision
> >
> >  #define BPF_F_ATTACH_MASK_BASE \
> > @@ -4214,6 +4233,9 @@ static int bpf_prog_attach(const union bpf_attr *=
attr)
> >         if (bpf_mprog_supported(ptype)) {
> >                 if (attr->attach_flags & ~BPF_F_ATTACH_MASK_MPROG)
> >                         return -EINVAL;
> > +       } else if (is_cgroup_prog_type(ptype, 0, false)) {
> > +               if (attr->attach_flags & BPF_F_LINK)
> > +                       return -EINVAL;
>
> Why disable BPF_F_LINK? It's just a matter of using FD/ID for link vs
> program to specify the place to attach. It doesn't mean that we need
> to attach through BPF link interface. Or am I misremembering?
>
> >         } else {
> >                 if (attr->attach_flags & ~BPF_F_ATTACH_MASK_BASE)
> >                         return -EINVAL;
> > @@ -4242,20 +4264,6 @@ static int bpf_prog_attach(const union bpf_attr =
*attr)
> >         case BPF_PROG_TYPE_FLOW_DISSECTOR:
> >                 ret =3D netns_bpf_prog_attach(attr, prog);
> >                 break;
> > -       case BPF_PROG_TYPE_CGROUP_DEVICE:
> > -       case BPF_PROG_TYPE_CGROUP_SKB:
> > -       case BPF_PROG_TYPE_CGROUP_SOCK:
> > -       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> > -       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> > -       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> > -       case BPF_PROG_TYPE_SOCK_OPS:
> > -       case BPF_PROG_TYPE_LSM:
> > -               if (ptype =3D=3D BPF_PROG_TYPE_LSM &&
> > -                   prog->expected_attach_type !=3D BPF_LSM_CGROUP)
> > -                       ret =3D -EINVAL;
> > -               else
> > -                       ret =3D cgroup_bpf_prog_attach(attr, ptype, pro=
g);
> > -               break;
> >         case BPF_PROG_TYPE_SCHED_CLS:
> >                 if (attr->attach_type =3D=3D BPF_TCX_INGRESS ||
> >                     attr->attach_type =3D=3D BPF_TCX_EGRESS)
> > @@ -4264,7 +4272,10 @@ static int bpf_prog_attach(const union bpf_attr =
*attr)
> >                         ret =3D netkit_prog_attach(attr, prog);
> >                 break;
> >         default:
> > -               ret =3D -EINVAL;
> > +               if (!is_cgroup_prog_type(ptype, prog->expected_attach_t=
ype, true))
> > +                       ret =3D -EINVAL;
> > +               else
> > +                       ret =3D cgroup_bpf_prog_attach(attr, ptype, pro=
g);
> >         }
> >
> >         if (ret)
>
> [...]

