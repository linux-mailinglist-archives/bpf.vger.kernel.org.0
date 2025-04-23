Return-Path: <bpf+bounces-56549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAD0A99BF3
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 01:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5C55A3939
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 23:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7C4238C1E;
	Wed, 23 Apr 2025 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaAqgstQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D121FF28
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745450411; cv=none; b=LogY2SrAlT7GBfCR3Uw4lYgCfogXhIJGz/nZoWsciqvvN1ERTgmWRyrkjrfx9ehOIbi06yM1LcUSg+h2uU31K/+LCCHdgO5LLfO60/HRhIVL89wiR5JVCM5gD7PssGgD/i1Pw6uzVwb9/C1E+QimHd2ELkM6IQ1dPRXmRGXcxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745450411; c=relaxed/simple;
	bh=2XTSO7PmfBoEake56h3VpQ/8z4JRR7awF2DP5QAkDuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4fxJyAePlLb9AloWfOY71144BIhnNxMWtUQ+/AKSJdOwrk55Kd3Gz+U1naPlqr0zePf5t3BnXTTEXYxffMfrgoiAUH9a3bEcdNcy0KoePP8Dukshi8X1/Q9yB5zE9JaX02GyHRB+JTW634gzx3J4vXIN3uQ0Eu85HHLQsTtcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaAqgstQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3035858c687so320626a91.2
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 16:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745450409; x=1746055209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ty9Mtg3VTgKJttbTGCZR6/ZBmXFTzdOvBGJUJSvKGqk=;
        b=DaAqgstQSRIx9KTAnn4MhisDTSQDdKNoq1oKWLNdQAj/bNK1iE4b8eoenIw1cWtLcC
         yELHzfvyx9up6QdeFYlmYefRCeiyIkjQ+JswKMVY7/IN+df4mbKb7Wb2cz2t9Cl/fuZF
         fkGGWTbMy00umkNJTYfdotvb9uFrzwGMIfnqfZ8rI6j6LuF4Ngz9dpFaG0wuJ81HW5V1
         bEc6IKnocY7/l2GkoSCbL8szRZVtJsv7ZEmNI2t8bhHhjPWbAbJdekAsm6OWI3U/yOGg
         SJnV80gYO5QvC8ilo4COXXnHZ2K9FlicvfJd8dJ63G7RCxvbF0/PgnmwWjTvqOK7iiCk
         LGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745450409; x=1746055209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ty9Mtg3VTgKJttbTGCZR6/ZBmXFTzdOvBGJUJSvKGqk=;
        b=E2crkkTI7rspLzoPgV2j8vmK5fRQxoxb9kEXJOhkQoJ3pRm3SlhXe+EXU5Z2bqiQG7
         lNRZiGhADPz2oLriS5ulGY9HPypM07+LQk/N8Xn+4Ry2N8dmeHg/sEIfpX1TjNCcgzm1
         MbooNcU/wf7X7e2+VmWaQ64xuAZHq7gX+dfSTUAp29hAdNge2GOXuEVwhxiKC+BgMLK5
         D0pABVPFkD3PTFSH+4funpJP0V7fchebLqgW90OTtUrnKoosDzN8Q5Zuw2JKJDgmbS4g
         s7nLUkZ9wf9NIf+oP5jKSu7k9s0w9yxt6+ROItDQEIAVC1HTkNdkMNq3HRV/zKvrJ4xW
         MeSg==
X-Gm-Message-State: AOJu0YxyfOKpflLSAfJmix2May6TZLnmn9eYVsD4dj5S84M9B6RrE4YU
	hCutNCDVsmVNFQBQPw5WglB3k0kki47KONXnkIsRgPplHnszkW54aOT+/jwnIdVo1ORxzQUBozi
	hTtcN+rQioSuJsld8K52kgd+l8DY=
X-Gm-Gg: ASbGnctof7mjtIeAZ9VzaYYL+M/Selb8s+cHGA+GqdqfuaRAlPTRGKVlJSkJwKoUkS+
	1TGFDwMY3obzroyxcipUC0G2xOEtr22P88tvJJUAK66Njna9OGQeyctwDKkEYNhXvLCj8YBOWbu
	wqhyPV4kNqgBDfYIqgM58nfyln1puoMAGiMugO0Q==
X-Google-Smtp-Source: AGHT+IGE5fajrfNpOU9l8UU420xH2+WEP01fEsxbHvsjIAeIKVdfoshVRtGhCZQNWjcF2kx4Wq8scfpn6w49em26W7s=
X-Received: by 2002:a17:90b:2f4f:b0:2ee:cded:9ac7 with SMTP id
 98e67ed59e1d1-309ed2859a5mr775369a91.20.1745450408930; Wed, 23 Apr 2025
 16:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411011523.1838771-1-yonghong.song@linux.dev> <20250411011533.1839631-1-yonghong.song@linux.dev>
In-Reply-To: <20250411011533.1839631-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Apr 2025 16:19:54 -0700
X-Gm-Features: ATxdqUHFr56vvpY_78SjLV2HHh8bubeUDTqkSlYzbUW4KlRa2rhQv4kqcYUo7M4
Message-ID: <CAEf4BzbY9nZk32hoA7UNjfPVeMWzLh8FyVhG2rChoje0wyxxKw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: Implement mprog API on top of
 existing cgroup progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 6:15=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
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
>  kernel/bpf/cgroup.c            | 151 ++++++++++++++++++++++++++++-----
>  kernel/bpf/syscall.c           |  58 ++++++++-----
>  tools/include/uapi/linux/bpf.h |   7 ++
>  4 files changed, 181 insertions(+), 42 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 71d5ac83cf5d..a5c7992e8f7c 100644
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
> index 84f58f3d028a..ffd455051131 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -624,6 +624,90 @@ static struct bpf_prog_list *find_attach_entry(struc=
t hlist_head *progs,
>         return NULL;
>  }
>
> +static struct bpf_prog *get_cmp_prog(struct hlist_head *progs, struct bp=
f_prog *prog,
> +                                    u32 flags, u32 id_or_fd, struct bpf_=
prog_list **ppltmp)
> +{
> +       struct bpf_prog *cmp_prog =3D NULL, *pltmp_prog;
> +       bool preorder =3D !!(flags & BPF_F_PREORDER);

nit: !!() pattern is not necessary when assigning to bool and is just
a visual and cognitive noise

> +       struct bpf_prog_list *pltmp;
> +       bool id =3D flags & BPF_F_ID;
> +       bool found;
> +
> +       if (id || id_or_fd) {

let's invert the condition and exit early? also I find "id" as a bool
very confusing, I think it's fine to just open-coded it in two places
you actually check for BPF_F_ID flag.

But also, isn't this `if (id)` part redundant? Would just `if
(id_or_fd)` be enough?


> +               /* flags must have BPF_F_BEFORE or BPF_F_AFTER */
> +               if (!(flags & (BPF_F_BEFORE | BPF_F_AFTER)))
> +                       return ERR_PTR(-EINVAL);
> +
> +               if (id)
> +                       cmp_prog =3D bpf_prog_by_id(id_or_fd);
> +               else
> +                       cmp_prog =3D bpf_prog_get(id_or_fd);

how about we use "anchor" terminology here? So this would be "anchor
program" or anchor_prog?

> +               if (IS_ERR(cmp_prog))
> +                       return cmp_prog;
> +               if (cmp_prog->type !=3D prog->type)

bpf_prog_put?

pw-bot: cr

> +                       return ERR_PTR(-EINVAL);
> +
> +               found =3D false;
> +               hlist_for_each_entry(pltmp, progs, node) {
> +                       pltmp_prog =3D pltmp->link ? pltmp->link->link.pr=
og : pltmp->prog;
> +                       if (pltmp_prog =3D=3D cmp_prog) {

try keeping nesting minimal:

if (pltmp_prog !=3D cmp_prog)
    continue;

> +                               if (!!(pltmp->flags & BPF_F_PREORDER) !=
=3D preorder)
> +                                       return ERR_PTR(-EINVAL);
> +                               found =3D true;
> +                               *ppltmp =3D pltmp;

we don't need found flag if we set ppltmp to NULL before loop, and to
non-NULL if we find the match

> +                               break;
> +                       }
> +               }
> +               if (!found)

bpf_prog_put(cmp_prog)

> +                       return ERR_PTR(-ENOENT);
> +       }
> +
> +       return cmp_prog;
> +}
> +
> +static int insert_pl_to_hlist(struct bpf_prog_list *pl, struct hlist_hea=
d *progs,
> +                             struct bpf_prog *prog, u32 flags, u32 id_or=
_fd)
> +{
> +       struct hlist_node *last, *last_node =3D NULL;
> +       struct bpf_prog_list *pltmp =3D NULL;
> +       struct bpf_prog *cmp_prog;
> +
> +       /* flags cannot have both BPF_F_BEFORE and BPF_F_AFTER */
> +       if ((flags & BPF_F_BEFORE) && (flags & BPF_F_AFTER))
> +               return -EINVAL;
> +
> +       cmp_prog =3D get_cmp_prog(progs, prog, flags, id_or_fd, &pltmp);

why get_cmp_prog can't return this last_node if we have BPF_F_AFTER
with no id/fd specified? Then you wouldn't have to special-case
appending (same for prepending, actually)?

> +       if (IS_ERR(cmp_prog))
> +               return PTR_ERR(cmp_prog);
> +
> +       if (hlist_empty(progs)) {
> +               hlist_add_head(&pl->node, progs);
> +       } else {
> +               hlist_for_each(last, progs) {
> +                       if (last->next)
> +                               continue;
> +                       last_node =3D last;
> +                       break;
> +               }
> +
> +               if (!cmp_prog) {
> +                       if (flags & BPF_F_BEFORE)
> +                               hlist_add_head(&pl->node, progs);
> +                       else
> +                               hlist_add_behind(&pl->node, last_node);
> +               } else {
> +                       if (flags & BPF_F_BEFORE)
> +                               hlist_add_before(&pl->node, &pltmp->node)=
;
> +                       else if (flags & BPF_F_AFTER)
> +                               hlist_add_behind(&pl->node, &pltmp->node)=
;
> +                       else
> +                               hlist_add_behind(&pl->node, last_node);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * __cgroup_bpf_attach() - Attach the program or the link to a cgroup, a=
nd
>   *                         propagate the change to descendants
> @@ -633,6 +717,8 @@ static struct bpf_prog_list *find_attach_entry(struct=
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
> @@ -640,7 +726,8 @@ static struct bpf_prog_list *find_attach_entry(struct=
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
> @@ -656,6 +743,9 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
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
> @@ -663,9 +753,12 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>                 /* replace_prog implies BPF_F_REPLACE, and vice versa */
>                 return -EINVAL;
>
> +
>         atype =3D bpf_cgroup_atype_find(type, new_prog->aux->attach_btf_i=
d);
>         if (atype < 0)
>                 return -EINVAL;
> +       if (revision && revision !=3D atomic64_read(&cgrp->bpf.revisions[=
atype]))

this is happening under lock, no need for atomic operations

> +               return -ESTALE;
>
>         progs =3D &cgrp->bpf.progs[atype];
>

[...]

> @@ -1063,6 +1161,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>         struct bpf_prog_array *effective;
>         int cnt, ret =3D 0, i;
>         int total_cnt =3D 0;
> +       u64 revision =3D 0;
>         u32 flags;
>
>         if (effective_query && prog_attach_flags)
> @@ -1100,6 +1199,10 @@ static int __cgroup_bpf_query(struct cgroup *cgrp,=
 const union bpf_attr *attr,
>                 return -EFAULT;
>         if (copy_to_user(&uattr->query.prog_cnt, &total_cnt, sizeof(total=
_cnt)))
>                 return -EFAULT;
> +       if (!effective_query && from_atype =3D=3D to_atype)
> +               revision =3D atomic64_read(&cgrp->bpf.revisions[from_atyp=
e]);

even here we hold cgroup_mutex

> +       if (copy_to_user(&uattr->query.revision, &revision, sizeof(revisi=
on)))
> +               return -EFAULT;
>         if (attr->query.prog_cnt =3D=3D 0 || !prog_ids || !total_cnt)
>                 /* return early if user requested only program count + fl=
ags */
>                 return 0;

[...]

> @@ -1336,7 +1441,9 @@ int cgroup_bpf_link_attach(const union bpf_attr *at=
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
> index 9794446bc8c6..48cf855f949f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4183,6 +4183,23 @@ static int bpf_prog_attach_check_attach_type(const=
 struct bpf_prog *prog,
>         }
>  }
>
> +static bool bpf_cgroup_prog_attached(enum bpf_prog_type ptype)

I find this "attached" naming misleading. I think the name should call
out that we are just checking if program type is cgroup-attaching, so
maybe something like "is_cgroup_prog_type", or something along those
lines?


But for LSM we need to look at expected_attach_type to be
BPF_LSM_CGROUP, so maybe pass both prog type and expected attach type?

> +{
> +       switch (ptype) {
> +       case BPF_PROG_TYPE_CGROUP_DEVICE:
> +       case BPF_PROG_TYPE_CGROUP_SKB:
> +       case BPF_PROG_TYPE_CGROUP_SOCK:
> +       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> +       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> +       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> +       case BPF_PROG_TYPE_SOCK_OPS:
> +       case BPF_PROG_TYPE_LSM:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +

[...]

