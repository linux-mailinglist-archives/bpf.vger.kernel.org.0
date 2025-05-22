Return-Path: <bpf+bounces-58757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09E6AC15A3
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03043ACCEA
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 20:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A5024A07B;
	Thu, 22 May 2025 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODXV/Kq4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC41DDC11
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747946760; cv=none; b=O5Nhie0B30z4fzguLDxfYM482e8KCk/844aM1Ji/pegqu6JZh900e+6azI5BG99lldDWUsZ7T1Hx9U1mVReQEeX1C7eTRkc5tb2kEUeFAptPbVraz+tFi6xQsOZjBbFS9kumeDVKIS5KJneaCnYKvNn0+whZLxbIVHrIOjA1xMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747946760; c=relaxed/simple;
	bh=qDW+xlu8x3RFD5w/WRnZTGP77tuSZJs7wG1AfGb+Qm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ys5Td51Vs+AEnNXd6AdhfUS/Oj12IK3UAzQcbJ0r0J6L0A4kbFMWiRYv9BO1QYxHEzgK9ZDaq3qXi3aPPzUY0l6zWtUhg192mI1Sd1lwNindUqpbCPzvdbSiXbqT6Hly9lTv/q4/Y2oQY64E+PYnVV9Scv1EZTstgDIz/Qz0IJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODXV/Kq4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-310e1f4627aso634253a91.2
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747946758; x=1748551558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qetomtZ3+ILqQ32zatz6INeWk5si/E14it+bRSSdB0M=;
        b=ODXV/Kq4zYXwg+E9vHX/HogSdOkh6tIdQBQNdCrVl5kg3CFWIH7wMSgvnT8s61rB+c
         Jx39jEsPGl+I0YQp5eVyQLJ3vmlMTtEHqLap/EiquE2+EJ9c3wL5rZ2bS7T7laZYFHmT
         8QFv6fyeEdnCucMtS8V2AGEDCfPOoPm+0swHNBj0FOWFTNYdSgB6/tksQYWQAAsXLtVt
         KbKWDRYEofSLzTQA3ugFCvRPde997cOHbq9tflXSX84vxGw43qxi8YGKWJwtXeJYPRLQ
         LZ4bfgGO+ePgYLBeR3XGfHFc8pclinM+Rw9mPZnYiUcKBXTNZjjtOa++lOosPcDNGHWh
         38mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747946758; x=1748551558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qetomtZ3+ILqQ32zatz6INeWk5si/E14it+bRSSdB0M=;
        b=eFaFwAzOASIF9m2f3mAbpaXbXe8HFg/L55L/2PMzT6D8+Q0NoJjgA7sJj3Ju5W5vgg
         pDJPIsfjA5GwqAfsL5kWgpayNQapwhyCviqzSlsHZU7O0rIV0uJZqbEFWih2RrhNk7Kl
         ERM03ijVyanNbZqEKIK0cogfnYRX93wJLKWTO0T8I5A5O8C47TI/yoBj7HmtNHsSmoMy
         17O9HXaKgP+rBqNOKteaDrVSo4nm0iJbs+oVFrZ+XYUfTPen9qMLN/nbkAPzLwKygFHB
         5T6CdOjUzeJr9D7XBsXMZ9Xx1/PTKM+WizUPeX4DxJCyXnqNI4FgmbASWUn72XiJx3ag
         JANg==
X-Gm-Message-State: AOJu0YwkHjLlphS3W5yvU3r+Xxr7nFyGHlTQEDQL/HLtl5b5IbZdpLnB
	tWUGYeT4wbVkP/6HwxSlm3Ai/zLmiNSwS0I1cb2yp7i9Gw8v+D0FBv/80g+rcvclaaN1QWxbqCw
	zPQqfkRYSx0UVDlcN7DLPlJcbgbXHaqfPOvyF36I=
X-Gm-Gg: ASbGncuaTxFt7S5v4LEb29hncinD3rOXh2d6eO7JlxqsJfPkb4FXbp7eAolDD0BLzrn
	ll7NTH0hgs274hgBGpgmHpTqsw2RcDq0vm6x1r7lOXh56oalMjgN7BF+sBFOyJzQhtROH+AHpA3
	g7w+ndb8FPdzCQlWUeInwudrph+YZ6UD0hg3/bse/ziLi0m8WW
X-Google-Smtp-Source: AGHT+IEMWNl0pDIoYWwPf2Kv665dsdAttoianatBZnsS/eCiI3RTvbxeImCLKctqEIkQmU2t2aqW6BKOAMj7tqcY30w=
X-Received: by 2002:a17:90a:c887:b0:2ee:ad18:b309 with SMTP id
 98e67ed59e1d1-30e830ca0b4mr35990596a91.3.1747946758192; Thu, 22 May 2025
 13:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517162720.4077882-1-yonghong.song@linux.dev> <20250517162731.4078451-1-yonghong.song@linux.dev>
In-Reply-To: <20250517162731.4078451-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 May 2025 13:45:46 -0700
X-Gm-Features: AX0GCFv287SpuVZs6e9SbX2CcnTBLC6i5BoKjmdceSwSImebhIa7Z0RxCPISEAs
Message-ID: <CAEf4BzbnSKr9JrdO266cN1tdPDpQKOGRrxn+ZbSX7cM5jVQh2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Implement mprog API on top of
 existing cgroup progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2025 at 9:27=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
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
>  - For attach, BPF_F_BEFORE/BPF_F_AFTER/BPF_F_ID/BPF_F_LINK is supported
>    similar to kernel mprog but with different implementation.
>  - For detach and replace, use the existing implementation.
>  - For attach, detach and replace, the revision for a particular prog
>    list, associated with a particular attach type, will be updated
>    by increasing count by 1.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/uapi/linux/bpf.h       |   7 ++
>  kernel/bpf/cgroup.c            | 195 +++++++++++++++++++++++++++++----
>  kernel/bpf/syscall.c           |  43 +++++---
>  tools/include/uapi/linux/bpf.h |   7 ++
>  4 files changed, 214 insertions(+), 38 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 16e95398c91c..356cd2b185fb 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1794,6 +1794,13 @@ union bpf_attr {
>                                 };
>                                 __u64           expected_revision;
>                         } netkit;
> +                       struct {
> +                               union {
> +                                       __u32   relative_fd;
> +                                       __u32   relative_id;
> +                               };
> +                               __u64           expected_revision;
> +                       } cgroup;
>                 };
>         } link_create;
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 62a1d8deb3dc..78e6fc70b8f9 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -624,6 +624,129 @@ static struct bpf_prog_list *find_attach_entry(stru=
ct hlist_head *progs,
>         return NULL;
>  }
>
> +static struct bpf_link *bpf_get_anchor_link(u32 flags, u32 id_or_fd, enu=
m bpf_prog_type type)
> +{
> +       struct bpf_link *link =3D ERR_PTR(-EINVAL);
> +
> +       if (flags & BPF_F_ID)
> +               link =3D bpf_link_by_id(id_or_fd);
> +       else if (id_or_fd)
> +               link =3D bpf_link_get_from_fd(id_or_fd);
> +       if (IS_ERR(link))
> +               return link;
> +       if (type && link->prog->type !=3D type) {
> +               bpf_link_put(link);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return link;
> +}
> +
> +static struct bpf_prog *bpf_get_anchor_prog(u32 flags, u32 id_or_fd, enu=
m bpf_prog_type type)
> +{
> +       struct bpf_prog *prog =3D ERR_PTR(-EINVAL);
> +
> +       if (flags & BPF_F_ID)
> +               prog =3D bpf_prog_by_id(id_or_fd);
> +       else if (id_or_fd)
> +               prog =3D bpf_prog_get(id_or_fd);
> +       if (IS_ERR(prog))
> +               return prog;
> +       if (type && prog->type !=3D type) {
> +               bpf_prog_put(prog);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return prog;
> +}
> +
> +static struct bpf_prog_list *get_prog_list(struct hlist_head *progs, str=
uct bpf_prog *prog,
> +                                          u32 flags, u32 id_or_fd)
> +{
> +       bool link =3D flags & BPF_F_LINK, id =3D flags & BPF_F_ID;
> +       struct bpf_prog *anchor_prog =3D NULL, *pltmp_prog;
> +       bool preorder =3D flags & BPF_F_PREORDER;
> +       struct bpf_link *anchor_link =3D NULL;
> +       struct bpf_prog_list *pltmp;
> +       int ret =3D -EINVAL;
> +
> +       if (link || id || id_or_fd) {

please, use "is_id" to make it obvious that this is bool, it's very
confusing to see "id || id_or_fd"

same for is_link, please

> +               /* flags must have either BPF_F_BEFORE or BPF_F_AFTER */
> +               if (!(flags & BPF_F_BEFORE) !=3D !!(flags & BPF_F_AFTER))

either/or here means exclusive or inclusive?

if it's inclusive: if (flags & (BPF_F_BEFORE | BPF_F_AFTER)) should be
enough to check that at least one of them is set

if exclusive, below you use a different style of checking (which
arguably is easier to follow), so let's stay consistent


I got to say that my brain broke trying to reason about this pattern:

   if (!(...) !=3D !!(...))

Way too many exclamations/negations, IMO... I'm not sure what sort of
condition we are expressing here?

pw-bot: cr

> +                       return ERR_PTR(-EINVAL);
> +       } else if (!hlist_empty(progs)) {
> +               /* flags cannot have both BPF_F_BEFORE and BPF_F_AFTER */
> +               if ((flags & BPF_F_BEFORE) && (flags & BPF_F_AFTER))
> +                       return ERR_PTR(-EINVAL);

do I understand correctly that neither BEFORE or AFTER might be set,
in which case it must be BPF_F_REPLACE, is that right? Can it happen
that we have neither REPLACE nor BEFORE/AFTER? Asked that below as
well...

> +       }
> +
> +       if (link) {
> +               anchor_link =3D bpf_get_anchor_link(flags, id_or_fd, prog=
->type);
> +               if (IS_ERR(anchor_link))
> +                       return ERR_PTR(PTR_ERR(anchor_link));
> +               anchor_prog =3D anchor_link->prog;
> +       } else if (id || id_or_fd) {
> +               anchor_prog =3D bpf_get_anchor_prog(flags, id_or_fd, prog=
->type);
> +               if (IS_ERR(anchor_prog))
> +                       return ERR_PTR(PTR_ERR(anchor_prog));
> +       }
> +
> +       if (!anchor_prog) {
> +               /* if there is no anchor_prog, then BPF_F_PREORDER doesn'=
t matter
> +                * since either prepend or append to a combined list of p=
rogs will
> +                * end up with correct result.
> +                */
> +               hlist_for_each_entry(pltmp, progs, node) {
> +                       if (flags & BPF_F_BEFORE)
> +                               return pltmp;
> +                       if (pltmp->node.next)
> +                               continue;
> +                       return pltmp;
> +               }
> +               return NULL;
> +       }
> +
> +       hlist_for_each_entry(pltmp, progs, node) {
> +               pltmp_prog =3D pltmp->link ? pltmp->link->link.prog : plt=
mp->prog;
> +               if (pltmp_prog !=3D anchor_prog)
> +                       continue;
> +               if (!!(pltmp->flags & BPF_F_PREORDER) !=3D preorder)
> +                       goto out;

hm... thinking about this a bit more, is it illegal to have the same
BPF program attached as PREORDER and POSTORDER? That seems legit to
me, do we artificially disallow this?

And so my proposal is instead of `goto out;` do `continue;` and write
this loop as searching for an item and then checking whether that item
was found after the loop.

> +               if (anchor_link)
> +                       bpf_link_put(anchor_link);
> +               else
> +                       bpf_prog_put(anchor_prog);

and this duplicated cleanup would be best to avoid, given it's not
just a singular bpf_prog_put()...

> +               return pltmp;
> +       }
> +
> +       ret =3D -ENOENT;
> +out:
> +       if (anchor_link)
> +               bpf_link_put(anchor_link);
> +       else
> +               bpf_prog_put(anchor_prog);
> +       return ERR_PTR(ret);
> +}
> +
> +static int insert_pl_to_hlist(struct bpf_prog_list *pl, struct hlist_hea=
d *progs,
> +                             struct bpf_prog *prog, u32 flags, u32 id_or=
_fd)
> +{
> +       struct bpf_prog_list *pltmp;
> +
> +       pltmp =3D get_prog_list(progs, prog, flags, id_or_fd);
> +       if (IS_ERR(pltmp))
> +               return PTR_ERR(pltmp);
> +
> +       if (!pltmp)
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
> @@ -633,6 +756,8 @@ static struct bpf_prog_list *find_attach_entry(struct=
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
> @@ -640,7 +765,8 @@ static struct bpf_prog_list *find_attach_entry(struct=
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
> @@ -656,6 +782,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>             ((flags & BPF_F_REPLACE) && !(flags & BPF_F_ALLOW_MULTI)))
>                 /* invalid combination */
>                 return -EINVAL;
> +       if ((flags & BPF_F_REPLACE) && (flags & (BPF_F_BEFORE | BPF_F_AFT=
ER)))

but can it be that neither is set?

> +               /* only either replace or insertion with before/after */
> +               return -EINVAL;
>         if (link && (prog || replace_prog))
>                 /* only either link or prog/replace_prog can be specified=
 */
>                 return -EINVAL;

[...]

