Return-Path: <bpf+bounces-65477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF79B23C3A
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 01:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C600F2A6FF5
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 23:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF762D73BB;
	Tue, 12 Aug 2025 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFOTbLwN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C9227B8E
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755040828; cv=none; b=KNmFMuDBzV+WhMLEZnfQWktf0SL7PeBl6RMZpY/iGDw3Khs7QhKv4RnxVyKXvVN4S0vK49+MW+v2UsU5SOG+7/tqlWd+kUB3xUTk95X7Veeo/Spp+VwoRqtzc8jReLYxJfHLhTeoMs4WzfiRllHNCKJN+D+G66+t9xSotCVv1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755040828; c=relaxed/simple;
	bh=ru778vtJc1ejwHIhN+76m9gc/S5uvywF9eZQW+mvFvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8QFC9416ahqLiUDU5IBEQWfsNlQkP7YLCDCANX7KPnuLKKO2QMTL7BSrrI9FWFg059HV+Bdvvc95tfXyT6wTpbkgn8KngP275ygaegy/fecBHLopuR+pJ5IP3DmZX9cRbLZvn9ZmSO5Q6jG2KXcxAVfZJFmg9k/XpS9EJtCogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFOTbLwN; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4704f70c4aso315707a12.0
        for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755040826; x=1755645626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X13FAH2uqQBq9ImmbTEYgGSs136oV1zfUuWmNvxPYF4=;
        b=ZFOTbLwNs7Gw0fLhP0jTYVswqjMOdBpYiOXR1PAn3SueSXxPNTPcXqvPrG86qR80NZ
         X0YBnC3897YH5AJzRFR4EXRkA7R6+npa3T2xvuTKzay+vS2NoWRqPTCWAWx0F9GHTRDO
         ACfyYRWz9RAbFjy4T+9JjhN+eCj+2YxrmtKeQ+4TtyCK/y5KvucIVEKy8l/dezKXHO8d
         yxbKzUVf5A8T9e+Pkec2f5jxx8zkUTSNzxB7ZF0Cdz0umFB2A0FAa1glnEUi2skmuktP
         dTE3ORjYIQJB+olmtehCNkiB6tt79Vgk//+83UuS8m73bB4g0bp84zRnX8sc2vdgeGbl
         letA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755040826; x=1755645626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X13FAH2uqQBq9ImmbTEYgGSs136oV1zfUuWmNvxPYF4=;
        b=Q2qIjRi6SBqezsa89Eo9FyCyCJ9DJGO9YOry46gCK8Jq65HDSgAmUDyjU3rshZACjc
         nqKMQ9hE+BUSHcXn86t6tl+jaQOjCLohm+ngOGacpr/Y7Ni/7uqPd2YJQ9I6YNmz2PcA
         uxC3MYnmRli8EuTbTlbvsHSMKuwdx5J2QkrAkmlVVPxaNdHz3TOHzZprln+qA3lbFCby
         P1RdL1BJKYfsPSABkWSJtf2k+tYMX4sVdvRSG+Gzki+alEY6FecJIgsSIgOUABRaba85
         OmBM12PdGUtXjEopFY6wQYtGfX527FYHk70fYsyUIJQWY74CG6IwnYuxB63/z0gyEmk0
         qbjA==
X-Gm-Message-State: AOJu0Yy94hq423wF+eijdIsG14fpNb76tdjsfQiCVx3o2+oJCvtJp4bK
	yrytHn6UjqpBavWVgj0IU2asshe0vcODhei+edu8qrreRyHWPASWZ+i6uhbQ9VzYXrlgaiAHXUh
	F5xMvLHh8k4F5Ooqe/m2+/bLw/Mfd1Qw=
X-Gm-Gg: ASbGnct1zl2zoVtz+S+ewn1JpYRM3jSdq3iu+3VbaxKTyaM968QPqh8f3SszjSYgVAV
	TUsghix9ZNEMn01j0eUBNH2P2NkH1QcOACPJfPptSyusJzgKRIqfgrvy8SEFeC+52H8w//islQV
	jGWFMmfOH3WEj7irRESGSt9HBtZtiVFndsC6sF3T8CWzItbzc1ENuQXfmzf2fOcb+2aVm5Gm6d2
	xI9GFr3CTHcjkHXbpvd73E=
X-Google-Smtp-Source: AGHT+IGkz4zAP1gilgKDFd5dyiKvQ9DzcDuq5r6bz1yI8jV7GBqPJ4YUitxA4BJOmVRipc/wZKzHmWlCQqaXWABewrg=
X-Received: by 2002:a17:902:cec8:b0:234:9dce:74e3 with SMTP id
 d9443c01a7336-2430e924b0fmr4648255ad.2.1755040826417; Tue, 12 Aug 2025
 16:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811195901.1651800-1-memxor@gmail.com> <20250811195901.1651800-2-memxor@gmail.com>
In-Reply-To: <20250811195901.1651800-2-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Aug 2025 16:20:10 -0700
X-Gm-Features: Ac12FXzwxkoBIdSzphKlJr4R-P6SIELgjCwfSX74D1GZn-vDAwWDLmvg5ThFRb8
Message-ID: <CAEf4BzY6kEGAOpo6-DivyROL5Ma61Niun6X3ic76_jFoZ8DGZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Do not limit bpf_cgroup_from_id to
 current's namespace
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, tj@kernel.org, Dan Schatzberg <dschatzberg@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 12:59=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The bpf_cgroup_from_id kfunc relies on cgroup_get_from_id to obtain the
> cgroup corresponding to a given cgroup ID. This helper can be called in
> a lot of contexts where the current thread can be random. A recent
> example was its use in sched_ext's ops.tick(), to obtain the root cgroup
> pointer. Since the current task can be whatever random user space task
> preempted by the timer tick, this makes the behavior of the helper
> unreliable.
>
> Resolve this by refactoring cgroup_get_from_id to take a parameter to
> elide the cgroup_is_descendant check when root_cgns parameter is set to
> true.
>
> There is no compatibility breakage here, since changing the namespace
> against which the lookup is being done to the root cgroup namespace only
> permits a wider set of lookups to succeed now. The cgroup IDs across
> namespaces are globally unique, and thus don't need to be retranslated.
>
> Reported-by: Dan Schatzberg <dschatzberg@meta.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/cgroup.h   | 2 +-
>  kernel/bpf/cgroup_iter.c | 2 +-
>  kernel/bpf/helpers.c     | 2 +-
>  kernel/cgroup/cgroup.c   | 7 ++++++-

hmm... I see mm/memcontrol.c and block/blk-cgroup-fc-appid.c using
this function as well, but you didn't update them, so under some
kernel config this will break?

but I'm also wondering if it wouldn't be cleaner to keep
cgroup_get_from_id() as is, and add __cgroup_get_from_id(u64 id) that
would not perform a cgroup_is_descendant() check. BPF helpers that
don't need this root descendancy would call __cgroup_get_from_id()
directly, while cgroup_get_from_id() would use __cgroup_get_from_id()
first, and then (if successful) would perform addition root_cgrp
check?


>  4 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index b18fb5fcb38e..da757a496fbe 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -650,7 +650,7 @@ static inline void cgroup_kthread_ready(void)
>  }
>
>  void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
> -struct cgroup *cgroup_get_from_id(u64 id);
> +struct cgroup *cgroup_get_from_id(u64 id, bool root_cgns);
>  #else /* !CONFIG_CGROUPS */
>
>  struct cgroup_subsys_state;
> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> index f04a468cf6a7..49234d035583 100644
> --- a/kernel/bpf/cgroup_iter.c
> +++ b/kernel/bpf/cgroup_iter.c
> @@ -212,7 +212,7 @@ static int bpf_iter_attach_cgroup(struct bpf_prog *pr=
og,
>         if (fd)
>                 cgrp =3D cgroup_v1v2_get_from_fd(fd);
>         else if (id)
> -               cgrp =3D cgroup_get_from_id(id);
> +               cgrp =3D cgroup_get_from_id(id, false);
>         else /* walk the entire hierarchy by default. */
>                 cgrp =3D cgroup_get_from_path("/");
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6b4877e85a68..12466103917f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2537,7 +2537,7 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 c=
gid)
>  {
>         struct cgroup *cgrp;
>
> -       cgrp =3D cgroup_get_from_id(cgid);
> +       cgrp =3D cgroup_get_from_id(cgid, true);
>         if (IS_ERR(cgrp))
>                 return NULL;
>         return cgrp;
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 312c6a8b55bb..b490e1e0d2c4 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6345,10 +6345,11 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf=
, size_t buflen)
>  /*
>   * cgroup_get_from_id : get the cgroup associated with cgroup id
>   * @id: cgroup id
> + * @root_cgns: Select root cgroup namespace instead of current's.
>   * On success return the cgrp or ERR_PTR on failure
>   * Only cgroups within current task's cgroup NS are valid.
>   */
> -struct cgroup *cgroup_get_from_id(u64 id)
> +struct cgroup *cgroup_get_from_id(u64 id, bool root_cgns)
>  {
>         struct kernfs_node *kn;
>         struct cgroup *cgrp, *root_cgrp;
> @@ -6374,6 +6375,10 @@ struct cgroup *cgroup_get_from_id(u64 id)
>         if (!cgrp)
>                 return ERR_PTR(-ENOENT);
>
> +       /* We don't need to namespace this operation against current. */
> +       if (root_cgns)
> +               return cgrp;
> +
>         root_cgrp =3D current_cgns_cgroup_dfl();
>         if (!cgroup_is_descendant(cgrp, root_cgrp)) {
>                 cgroup_put(cgrp);
> --
> 2.47.3
>

