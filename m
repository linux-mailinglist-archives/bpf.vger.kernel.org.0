Return-Path: <bpf+bounces-59798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123CCACF8CA
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 22:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4853A52C7
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 20:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBAD27A127;
	Thu,  5 Jun 2025 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPiRwPVT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB22202C3E
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749155421; cv=none; b=KGIRdTi/ZqYJLih/9Yle/Dj5EFCWD7q19E9880udhBrz8F2Me0BxY8xAlWsCGpI3pp2j2+16fuYdNBF0xx4fekxjSzsDiNIYTjK4Shbejukxg1xanvP0me85lYw43Ofkvjf2CNYrJvqS8slf6JvtY1Wc6MtRETEALehO2ptSGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749155421; c=relaxed/simple;
	bh=0/JhifGZgkiissVpQcMiALRc7lMlIcTXWMxUCuYnw/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhfAH9bUzw5IhJk6gx8MmAXcFP+TlhFOXBIOREUgJGgwNIkke62VnY3Oog1eQVXyv/dAsS5cmeYw6CHAmZ0dhNxdrP5cRTZTas+mu6we/x/4+fEyLU7AtyiPsKcsWJvroQN7MsjfY/9Y5G187Zyrq35VY6bGUKFsNo9CNa9UpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPiRwPVT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c9907967so1396860b3a.1
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749155418; x=1749760218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozcYr68uEApKZ2A0plGojw6mIXU/V081khixEXz33uc=;
        b=YPiRwPVTKrD0VVFbDGZsY99SsZhJU7TJ0uRoj/O1aDjSRpp7gYXtPCoZGlTfLCDRk4
         fn7bpLDuhm/WgqK31p3is2TO8M8uO6T4nozikWrE5hFi7peAnZyhA1FdBoNYbTHitfL4
         9knJnK3F6cBT4Kj4XgfOeAhiybx4yU01YJFdKw/4tacWODd38n/+wjBFPbIUFWdOEjlw
         nNU/D0WahUwACAY345J+VTN0zuPA07vfKQGvxmdj+vpGDr3u41DWckSQcVVHQ/cVqkE4
         b6qdto87ARB79YCSLS8KygjYwwuEfm1nVWl8hKEZLEGIlLX/M5tQ6sgtX0xS4ovLG7o4
         3Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749155418; x=1749760218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozcYr68uEApKZ2A0plGojw6mIXU/V081khixEXz33uc=;
        b=Dk6dxzTHXWR9bOX7dratk62Ds7G9m73lJW+H/ARJboVDs6uJt2X3bEMHktyadezgP7
         ezgImROMlgm3a9hSKJlVx3Ln/kPkuvjis4IPZJ90gON40ESJosEtvBtp8MWNvrUuLd/u
         ldlgEQDxz1zay0w9AznRIDBtmexhB/8SgwUBRuhF2b1Xs/0CvWmHQ9eZUpbX68jWkaNK
         XMWjoysHrvLlrm26yxSz40qWCdqrIWg47jqk8Joxe3xQsZ/MlnxynmALImI35VZr9SM4
         4HbJGNqLsTl9WOY7FJtZ/f227UQWdgFoaT/2+MZ3pVgHXpS5DKFpppivWq42q12sef+M
         nTfA==
X-Gm-Message-State: AOJu0YxCuY8Dn+5AYSDQmGjT/BKhS/UWOQwvqsJUx4Q9sQj6pMMuEvil
	gNC0t/g7bmsdLnSJPPe4q5so8xiqyqq+22Y3v0VjljeFC9jGkrOP9ryEenTCrqN4myfOYHxZLpv
	LOOv4xDb/mPJHBp0TMiEICRrwCbVY1ac=
X-Gm-Gg: ASbGncvyjZMjv8kbAbVdBibaEQ/G2qC+t1TwBwoOLd1GqrgVOVIoSPc+kZTyL/XEZlf
	94XBS7CznH+mc9jFX1SXWPrSVl2ZCMhGM9tq5hBG0bWaKBnAexCZTJNuB+d5UKIQ7FVIL1iKtMV
	5GkZvEMUI+nzq90cZlK7HH1tYEbPtZwdOZ/RJM/y9za3ThticO5tulKNa20fo=
X-Google-Smtp-Source: AGHT+IE0OsJafHC8PkKCfC5PxrQlx8v6GaqkxjDfd/2n+UToVJqDAeihNhHzpg1yckukSayIFC+GEE7YEXoYGefaW8k=
X-Received: by 2002:a05:6a00:1142:b0:740:5927:bb8b with SMTP id
 d2e1a72fcca58-74827cfb07fmr1531522b3a.0.1749155418099; Thu, 05 Jun 2025
 13:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530173812.1823479-1-yonghong.song@linux.dev> <20250530173822.1824144-1-yonghong.song@linux.dev>
In-Reply-To: <20250530173822.1824144-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Jun 2025 13:30:06 -0700
X-Gm-Features: AX0GCFt1AMrDzDPB9I4DWcynaZD55i75CmXyoD3Cj6yS_ptdYlo7-EN6mGdU81U
Message-ID: <CAEf4BzZnE4rU7OpW8a4HYAN3=kJBB6j_YysjRHL-77PGstWkDQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/5] bpf: Implement mprog API on top of
 existing cgroup progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 10:38=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
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
>  kernel/bpf/cgroup.c            | 197 +++++++++++++++++++++++++++++----
>  kernel/bpf/syscall.c           |  43 ++++---
>  tools/include/uapi/linux/bpf.h |   7 ++
>  4 files changed, 216 insertions(+), 38 deletions(-)
>

[...]

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 9122c39870bf..bab580df5908 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -658,6 +658,131 @@ static struct bpf_prog_list *find_attach_entry(stru=
ct hlist_head *progs,
>         return NULL;
>  }
>
> +static struct bpf_cgroup_link *bpf_get_anchor_link(u32 flags, u32 id_or_=
fd,
> +                                                  enum bpf_prog_type typ=
e)
> +{
> +       struct bpf_link *link =3D ERR_PTR(-EINVAL);
> +
> +       if (flags & BPF_F_ID)
> +               link =3D bpf_link_by_id(id_or_fd);
> +       else if (id_or_fd)
> +               link =3D bpf_link_get_from_fd(id_or_fd);
> +       if (IS_ERR(link))
> +               return ERR_PTR(PTR_ERR(link));
> +       if (link->type !=3D BPF_LINK_TYPE_CGROUP || link->prog->type !=3D=
 type) {

This check is a bit redundant and incomplete at the same time, so I'm
wondering if it's better to just drop this check?

It's redundant because if link or program is of wrong type, we won't
find it in cgroup's list of links/progs and return -ENOENT.

It's incomplete, because attach_type should be checked together with
prog_type. But again, this doesn't matter because correct prog_type
and incorrect attach_type would result in not finding the anchor link.

So I'm just thinking if it would be just better to not check type here
and let anchor prog/link logic return -ENOENT? WDYT?

> +               bpf_link_put(link);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return container_of(link, struct bpf_cgroup_link, link);
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
> +       if (prog->type !=3D type) {

same as for links above, it would make sense to check attach_type as
well, but it ultimately doesn't matter because user will get
-ENOENT... It's just the inconsistency (-EINVAL if prog_type
mismatches, -ENOENT if attach_type mismatches), that makes we want to
not check this type info here at all...

> +               bpf_prog_put(prog);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return prog;
> +}
> +

[...]

>  #define BPF_PROG_ATTACH_LAST_FIELD expected_revision
>
>  #define BPF_F_ATTACH_MASK_BASE \
> @@ -4215,7 +4234,7 @@ static int bpf_prog_attach(const union bpf_attr *at=
tr)
>         if (bpf_mprog_supported(ptype)) {
>                 if (attr->attach_flags & ~BPF_F_ATTACH_MASK_MPROG)
>                         return -EINVAL;
> -       } else {
> +       } else if (!is_cgroup_prog_type(ptype, 0, false)) {

wouldn't we skip checking flags altogether for cgroup program types?  maybe=
:

if (is_cgroup_prog_type(...)) {
   /* check flags for cgroups */
} else {
   ...
}

would be a safer pattern?

pw-bot: cr

>                 if (attr->attach_flags & ~BPF_F_ATTACH_MASK_BASE)
>                         return -EINVAL;
>                 if (attr->relative_fd ||
> @@ -4243,20 +4262,6 @@ static int bpf_prog_attach(const union bpf_attr *a=
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
> @@ -4265,7 +4270,10 @@ static int bpf_prog_attach(const union bpf_attr *a=
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
> @@ -4295,6 +4303,9 @@ static int bpf_prog_detach(const union bpf_attr *at=
tr)
>                         if (IS_ERR(prog))
>                                 return PTR_ERR(prog);
>                 }
> +       } else if (is_cgroup_prog_type(ptype, 0, false)) {
> +               if (attr->attach_flags || attr->relative_fd)
> +                       return -EINVAL;
>         } else if (attr->attach_flags ||
>                    attr->relative_fd ||
>                    attr->expected_revision) {

[...]

