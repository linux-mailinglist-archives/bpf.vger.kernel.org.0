Return-Path: <bpf+bounces-52407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C891A42BD1
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 19:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460D517A552
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA57144304;
	Mon, 24 Feb 2025 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw830aYa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C85C5B211
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422533; cv=none; b=ArXsibAnPi9+/l+faMX+Oe5HEXZ8nNQslHxyr5nFIDPgByhQZQ1GhI9dqNs+E/Q6HOdRf+0w48uspoLxwzapkpncuMCWep0zTrTXFIla81OMEz3U0mixb3lxY8iZ4PUYz5wyeiv+1fuLv1gnyjh/8bATCtI202MI3qQIdZrxNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422533; c=relaxed/simple;
	bh=lFTK4JO1fQOItvAJbGLm1lx3crl2PO6oYAwJrOjjOIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+/mfs/5YfWoNwsfKfyf5xH82T61FHiYIBpVDZSwWHv4hisaTpb7u+2Chk0pJqOxEfkCGdMF4yvmL6uvhC/JyopBwIe9Y9N7OZZFIf+ku6QppUjazitHGQTsRT//mk7WUPZvVljMGAPhtN7UMLpWztGApN1L8lQ7NKqYAXp3LSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sw830aYa; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so7672257a91.2
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740422531; x=1741027331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRiBIHJgP6nI5gN/Mby01kB5ttTFTyPC+PhC7ewxwRU=;
        b=Sw830aYafC0jbPlqM6TF/NIc+t+6c+YOr4XQDgH0cmxW5uAfUmqwTfRGkmkE4mlGcj
         a+Z1vuEuUM+zrsmX0L/Qe6buPjU1HMqpYpv+wPy1MK75xOUuLagg+aok0TGXv5k1jW9v
         GcYHuO4EE1AXLli1tVpfBXP8o/s41jib0G7bU053eRevyeEZ1BXJiysOJUrt1JZ1jSqL
         55cPd0NQhWJ9QK7+EJPh2COr4rqiRGOfWfyEmMhwYyIoPSAxEOp1pVyMZh6lyEdSddhd
         s20dG0UEllLXAewXsR5LE+MzH6FctGUZVNSCWQw+9kwXtNHYcZQIAV6r4aV4g32AzbJo
         GikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422531; x=1741027331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRiBIHJgP6nI5gN/Mby01kB5ttTFTyPC+PhC7ewxwRU=;
        b=ro0YJ9ovUnXcjEZWGwdUnETcAc2MCQT09Ju1JeMD+/LnIZgJG+02DAeOAGd0RcG5V2
         m1h3p8GYfKbejrbEO5mEIy+aqnOGpErHKy1+JoWlTKSVEiZt8/879w4SBhTWCyn5BxVh
         WNwDBPNEIMCY5lavmq4IKspgJ2fL6UZvD/QE2L2StylMVgL7VEbVrZ04e4iV/IwzGuvl
         LDPfUr/oJJ0k7AJjjC8nHH0qfk5u5W+Gn9gmoce8i/XKMrEu3PDpc9SdXvW2Fr9S1U1W
         fzwllxxyHWFBJ/DTf/0Lgh48uaZhALMZI06/rNXmc4HdcsnYfwA7E31y4QS9zr5u0DKn
         WJVw==
X-Gm-Message-State: AOJu0Yw+/mDf7P5/nCQGH+7dnyumCsd+1c4kvmDTqIfi36MGpWnRL3rb
	8AjswAqbm1gjfWiiVcQcDynXvDEQ5AdnWtltwLrIEhFkJR+VrYVHuEkRBk0bRze6VE0jmPRuyZ6
	oEz0679E8uNe0gFQBIOAPKOs7yOo=
X-Gm-Gg: ASbGncsZBhlUES6xfnN4SRLZ81Lhb+uOUNcamZMmZLkB3nw9xjYDmV9Xl/hkgFQwWL/
	sTfO/wDeosAFIM+ZGoWizZL9J0LiySwQAVbcrMZMGrzN59aKzXnX9OGIY7g7SE9UyOI/i0EkuQm
	JSgIogRrA0n8OmXdiFyjWXX60=
X-Google-Smtp-Source: AGHT+IG8Bs7QtNrpo1s4Af/so1r5b0v3WyUxO+Zau0YznN6s3hl6epICP2VJ5tZ/8WXuQAsf2PTur6csTvWbw0UdacQ=
X-Received: by 2002:a17:90a:d2d0:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-2fe68ad9ef3mr319794a91.8.1740422530778; Mon, 24 Feb 2025
 10:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213164812.2668578-1-yonghong.song@linux.dev>
In-Reply-To: <20250213164812.2668578-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 10:41:58 -0800
X-Gm-Features: AWEUYZlFV6hY0qssOr6dw16Bl8SW2njZkpTq2iGr1MIWuz1uZe2C7q31PtMJf28
Message-ID: <CAEf4Bza-Wz6Tsi=h9hwFg1TGbjsYMBi4BDGEnqtMjSj_GpOFNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Allow pre-ordering for bpf cgroup progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:48=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Currently for bpf progs in a cgroup hierarchy, the effective prog array
> is computed from bottom cgroup to upper cgroups (post-ordering). For
> example, the following cgroup hierarchy
>     root cgroup: p1, p2
>         subcgroup: p3, p4
> have BPF_F_ALLOW_MULTI for both cgroup levels.
> The effective cgroup array ordering looks like
>     p3 p4 p1 p2
> and at run time, progs will execute based on that order.
>
> But in some cases, it is desirable to have root prog executes earlier tha=
n
> children progs (pre-ordering). For example,
>   - prog p1 intends to collect original pkt dest addresses.
>   - prog p3 will modify original pkt dest addresses to a proxy address fo=
r
>     security reason.
> The end result is that prog p1 gets proxy address which is not what it
> wants. Putting p1 to every child cgroup is not desirable either as it
> will duplicate itself in many child cgroups. And this is exactly a use ca=
se
> we are encountering in Meta.
>
> To fix this issue, let us introduce a flag BPF_F_PREORDER. If the flag
> is specified at attachment time, the prog has higher priority and the
> ordering with that flag will be from top to bottom (pre-ordering).
> For example, in the above example,
>     root cgroup: p1, p2
>         subcgroup: p3, p4
> Let us say p2 and p4 are marked with BPF_F_PREORDER. The final
> effective array ordering will be
>     p2 p4 p3 p1
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf-cgroup.h     |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/cgroup.c            | 33 +++++++++++++++++++++++++--------
>  kernel/bpf/syscall.c           |  3 ++-
>  tools/include/uapi/linux/bpf.h |  1 +
>  5 files changed, 30 insertions(+), 9 deletions(-)
>

LGTM, see one suggestion below, but it doesn't change the essence

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 7fc69083e745..9de7adb68294 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -111,6 +111,7 @@ struct bpf_prog_list {
>         struct bpf_prog *prog;
>         struct bpf_cgroup_link *link;
>         struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE];
> +       u32 flags;
>  };
>
>  int cgroup_bpf_inherit(struct cgroup *cgrp);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index fff6cdb8d11a..beac5cdf2d2c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1207,6 +1207,7 @@ enum bpf_perf_event_type {
>  #define BPF_F_BEFORE           (1U << 3)
>  #define BPF_F_AFTER            (1U << 4)
>  #define BPF_F_ID               (1U << 5)
> +#define BPF_F_PREORDER         (1U << 6)
>  #define BPF_F_LINK             BPF_F_LINK /* 1 << 13 */
>
>  /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 46e5db65dbc8..31d33058174c 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -369,7 +369,7 @@ static struct bpf_prog *prog_list_prog(struct bpf_pro=
g_list *pl)
>  /* count number of elements in the list.
>   * it's slow but the list cannot be long
>   */
> -static u32 prog_list_length(struct hlist_head *head)
> +static u32 prog_list_length(struct hlist_head *head, int *preorder_cnt)
>  {
>         struct bpf_prog_list *pl;
>         u32 cnt =3D 0;
> @@ -377,6 +377,8 @@ static u32 prog_list_length(struct hlist_head *head)
>         hlist_for_each_entry(pl, head, node) {
>                 if (!prog_list_prog(pl))
>                         continue;
> +               if (preorder_cnt && (pl->flags & BPF_F_PREORDER))
> +                       (*preorder_cnt)++;
>                 cnt++;
>         }
>         return cnt;
> @@ -400,7 +402,7 @@ static bool hierarchy_allows_attach(struct cgroup *cg=
rp,
>
>                 if (flags & BPF_F_ALLOW_MULTI)
>                         return true;
> -               cnt =3D prog_list_length(&p->bpf.progs[atype]);
> +               cnt =3D prog_list_length(&p->bpf.progs[atype], NULL);
>                 WARN_ON_ONCE(cnt > 1);
>                 if (cnt =3D=3D 1)
>                         return !!(flags & BPF_F_ALLOW_OVERRIDE);
> @@ -423,12 +425,12 @@ static int compute_effective_progs(struct cgroup *c=
grp,
>         struct bpf_prog_array *progs;
>         struct bpf_prog_list *pl;
>         struct cgroup *p =3D cgrp;
> -       int cnt =3D 0;
> +       int i, cnt =3D 0, preorder_cnt =3D 0, fstart, bstart, init_bstart=
;
>
>         /* count number of effective programs by walking parents */
>         do {
>                 if (cnt =3D=3D 0 || (p->bpf.flags[atype] & BPF_F_ALLOW_MU=
LTI))
> -                       cnt +=3D prog_list_length(&p->bpf.progs[atype]);
> +                       cnt +=3D prog_list_length(&p->bpf.progs[atype], &=
preorder_cnt);
>                 p =3D cgroup_parent(p);
>         } while (p);
>
> @@ -439,20 +441,34 @@ static int compute_effective_progs(struct cgroup *c=
grp,
>         /* populate the array with effective progs */
>         cnt =3D 0;
>         p =3D cgrp;
> +       fstart =3D preorder_cnt;
> +       bstart =3D preorder_cnt - 1;
>         do {
>                 if (cnt > 0 && !(p->bpf.flags[atype] & BPF_F_ALLOW_MULTI)=
)
>                         continue;
>
> +               init_bstart =3D bstart;
>                 hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
>                         if (!prog_list_prog(pl))
>                                 continue;
>
> -                       item =3D &progs->items[cnt];
> +                       if (pl->flags & BPF_F_PREORDER) {
> +                               item =3D &progs->items[bstart];
> +                               bstart--;
> +                       } else {
> +                               item =3D &progs->items[fstart];
> +                               fstart++;
> +                       }
>                         item->prog =3D prog_list_prog(pl);
>                         bpf_cgroup_storages_assign(item->cgroup_storage,
>                                                    pl->storage);
>                         cnt++;
>                 }
> +
> +               /* reverse pre-ordering progs at this cgroup level */
> +               for (i =3D 0; i < (init_bstart - bstart)/2; i++)
> +                       swap(progs->items[init_bstart - i], progs->items[=
bstart + 1 + i]);

nit: this is a bit mind-bending to read and verify, let's do it a bit
more bullet-proof way:

for (i =3D bstart + 1, j =3D init_bstart; i < j; i++, j--)
    swap(progs->items[i], progs->items[j]);

?

> +
>         } while ((p =3D cgroup_parent(p)));
>
>         *array =3D progs;
> @@ -663,7 +679,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>                  */
>                 return -EPERM;
>
> -       if (prog_list_length(progs) >=3D BPF_CGROUP_MAX_PROGS)
> +       if (prog_list_length(progs, NULL) >=3D BPF_CGROUP_MAX_PROGS)
>                 return -E2BIG;
>
>         pl =3D find_attach_entry(progs, prog, link, replace_prog,
> @@ -698,6 +714,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>
>         pl->prog =3D prog;
>         pl->link =3D link;
> +       pl->flags =3D flags;
>         bpf_cgroup_storages_assign(pl->storage, storage);
>         cgrp->bpf.flags[atype] =3D saved_flags;
>
> @@ -1073,7 +1090,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>                                                               lockdep_is_=
held(&cgroup_mutex));
>                         total_cnt +=3D bpf_prog_array_length(effective);
>                 } else {
> -                       total_cnt +=3D prog_list_length(&cgrp->bpf.progs[=
atype]);
> +                       total_cnt +=3D prog_list_length(&cgrp->bpf.progs[=
atype], NULL);
>                 }
>         }
>
> @@ -1105,7 +1122,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
>                         u32 id;
>
>                         progs =3D &cgrp->bpf.progs[atype];
> -                       cnt =3D min_t(int, prog_list_length(progs), total=
_cnt);
> +                       cnt =3D min_t(int, prog_list_length(progs, NULL),=
 total_cnt);
>                         i =3D 0;
>                         hlist_for_each_entry(pl, progs, node) {
>                                 prog =3D prog_list_prog(pl);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c420edbfb7c8..18de4d301368 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4168,7 +4168,8 @@ static int bpf_prog_attach_check_attach_type(const =
struct bpf_prog *prog,
>  #define BPF_F_ATTACH_MASK_BASE \
>         (BPF_F_ALLOW_OVERRIDE | \
>          BPF_F_ALLOW_MULTI |    \
> -        BPF_F_REPLACE)
> +        BPF_F_REPLACE |        \
> +        BPF_F_PREORDER)
>
>  #define BPF_F_ATTACH_MASK_MPROG        \
>         (BPF_F_REPLACE |        \
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index fff6cdb8d11a..beac5cdf2d2c 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1207,6 +1207,7 @@ enum bpf_perf_event_type {
>  #define BPF_F_BEFORE           (1U << 3)
>  #define BPF_F_AFTER            (1U << 4)
>  #define BPF_F_ID               (1U << 5)
> +#define BPF_F_PREORDER         (1U << 6)
>  #define BPF_F_LINK             BPF_F_LINK /* 1 << 13 */
>
>  /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
> --
> 2.43.5
>

