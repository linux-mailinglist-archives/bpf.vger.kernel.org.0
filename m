Return-Path: <bpf+bounces-60194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65FAD3DE6
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535723A76F4
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C42367C3;
	Tue, 10 Jun 2025 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anodAg2o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BE233D92
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570423; cv=none; b=oen7h0MwDdQzVcfkYUm7O9ky+ZqsbyTazrqSg+WKs7zGm2dZQYV6hQfpYsBpvUyPEaYizSCt0kFQm0ctQNccqgp9njdr6UD52LaFbOm2Fu9lm3waPazyKMJjZkPhZNaFZrgSFrKu9ASKNokhS7eFATlNUIFE8V4/JZUXRKNz5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570423; c=relaxed/simple;
	bh=kPpiEw38zitY6TzHBuzRNaZFSsqqA0dW/CraEhfn558=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJJhPVPeeYWW2FpzSncRhvxu+MLbFM3dnTn6BMbLwpiwCjBIyu+lOyeQUbH1YtjzdGx895e/wOvy6Cho7rd/xDbUXQ4+sJ/tChY72pmYRonG4POsbwidqcBlOA9pe3yFOX2IixwZfBUKYZnxcbSpsImr5Lb6tSu+qwXfwLU2Zqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anodAg2o; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c2c762a89so3896984a12.0
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749570421; x=1750175221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W53mUs2Tz6luDWajDKeckwa62P3pKbFiABU7JrlzldI=;
        b=anodAg2oIUcoE49RrQ88O3wIDvpumBcPzePeYCJt57xKEZQBGSshZwR1JDjyG0DkZO
         vZUoU6DSMdWsEXhg16/pihYV3I7y9iokhmYJ4FhECj4eq1OWM8lYsO9oSAQzaenDjYCR
         sD1U6p8baVX3g4ZLx+09nLzdHf1KJFfSd5ZzaHTL6Q+UZqRjo+7GkV1QkrGYuCCTOI0H
         JCWG/Au5dFmg/+R8pH0JI96vyE8FKgYgUtSwfFVru8KLxkLdFveI0ZrX85o2fyBGIzhJ
         CwRvn4iNhRfien2+qKM0MzDZJTHE0lBRN/b3Kl4lXsRetAdSrQlSCdd99JuZlsc/bnZB
         zZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749570421; x=1750175221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W53mUs2Tz6luDWajDKeckwa62P3pKbFiABU7JrlzldI=;
        b=qG7Sgw+j5D+L/6WsRSIC9T8rZrkfFvMGFnJPjPxVEb3DwYDWIDKg8g05MEWCja0zP2
         P7Z2PoICbtkKYuaKyeHX3dQiVDQwoCb9cEv8qu4v5Z0ZFH35Y+kQcFqXSbbzSI+o2yEL
         VIJ9bIQqFtHaapG0vEsm0m15231CaN60ozMpwOCsIUnvDE6Yx/WyYIEIaDkHfsr/GquW
         vVYwgkiZ6pCCoHM4Y6ztCSYF8tjxrdk4FeejZvSaKhnxP/R1MORg1JfjjRZMYDVS3Jd7
         aqqAypm5AP6AWOkNeEOW1kusqQDTCm/RfoH0SrPk00KncmqYDvfjBANtZYkv028oFSEV
         KXVw==
X-Gm-Message-State: AOJu0YwugqTCx6VWC/O8B8Uwd9QLlYUWAeUVKP9FZysWEL5HrXJ2LLuq
	1261Dc629HRHvcGibFrTWVIU9k4ULZkXVF82NAPZVoxTrjtfUyAFeUcjCS4QE7NDEqoxWSW+pxW
	ognqe+iW/lToK1z2D1i3HSDnTlRQZ7dA=
X-Gm-Gg: ASbGncv/9tKlP8h37sHd7Omt166/kzzX3+cVTv9lpn2wiHq8Vk69bpD7+72MsiPB4b6
	TSKx84uc9jYwrEzO9EUu+YTr5DthgXTz+K6ynf5HvTyxSGtkcgu6HrUlSFTRYB36CzXb15Rwtfj
	IgcnHAB+HZ0OriP1psXiQx5G6fL4x+63uq3fxs6zUI/X/1A5AElAWYJucZ2Js=
X-Google-Smtp-Source: AGHT+IEH8qBMhc/Q0W/h2Yrf6BZtixlnP3ncNrQzV76GFlOf53rI5h8KyoFymZx1is3nlXSN2R9+LH5OHuKg2hPvjE4=
X-Received: by 2002:a17:90b:184e:b0:313:3f33:6b95 with SMTP id
 98e67ed59e1d1-313af1b26bfmr96323a91.16.1749570420892; Tue, 10 Jun 2025
 08:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606163131.2428225-1-yonghong.song@linux.dev>
 <20250606163141.2428937-1-yonghong.song@linux.dev> <CAEf4BzZjbJBpHE0eguipWgh8KWHG4Jh1jOORjMwsr7pVZ=qa6A@mail.gmail.com>
 <5ed5f8ad-4493-4dba-aa24-ad314d527c2e@linux.dev>
In-Reply-To: <5ed5f8ad-4493-4dba-aa24-ad314d527c2e@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Jun 2025 08:46:47 -0700
X-Gm-Features: AX0GCFukt-Nf0bNzo72c9wMiWeRfYFcbKSWCjg16pliSyQf8XrAgSlBduzFjuE0
Message-ID: <CAEf4BzYPh7p2cJgy7dzZDiOoTyHwRkN7khZaBhduteTksiaoCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Implement mprog API on top of
 existing cgroup progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 6:20=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 6/9/25 4:35 PM, Andrii Nakryiko wrote:
> > On Fri, Jun 6, 2025 at 9:31=E2=80=AFAM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >> Current cgroup prog ordering is appending at attachment time. This is =
not
> >> ideal. In some cases, users want specific ordering at a particular cgr=
oup
> >> level. To address this, the existing mprog API seems an ideal solution=
 with
> >> supporting BPF_F_BEFORE and BPF_F_AFTER flags.
> >>
> >> But there are a few obstacles to directly use kernel mprog interface.
> >> Currently cgroup bpf progs already support prog attach/detach/replace
> >> and link-based attach/detach/replace. For example, in struct
> >> bpf_prog_array_item, the cgroup_storage field needs to be together
> >> with bpf prog. But the mprog API struct bpf_mprog_fp only has bpf_prog
> >> as the member, which makes it difficult to use kernel mprog interface.
> >>
> >> In another case, the current cgroup prog detach tries to use the
> >> same flag as in attach. This is different from mprog kernel interface
> >> which uses flags passed from user space.
> >>
> >> So to avoid modifying existing behavior, I made the following changes =
to
> >> support mprog API for cgroup progs:
> >>   - The support is for prog list at cgroup level. Cross-level prog lis=
t
> >>     (a.k.a. effective prog list) is not supported.
> >>   - Previously, BPF_F_PREORDER is supported only for prog attach, now
> >>     BPF_F_PREORDER is also supported by link-based attach.
> >>   - For attach, BPF_F_BEFORE/BPF_F_AFTER/BPF_F_ID/BPF_F_LINK is suppor=
ted
> >>     similar to kernel mprog but with different implementation.
> >>   - For detach and replace, use the existing implementation.
> >>   - For attach, detach and replace, the revision for a particular prog
> >>     list, associated with a particular attach type, will be updated
> >>     by increasing count by 1.
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   include/uapi/linux/bpf.h       |   7 ++
> >>   kernel/bpf/cgroup.c            | 188 +++++++++++++++++++++++++++++--=
--
> >>   kernel/bpf/syscall.c           |  44 +++++---
> >>   tools/include/uapi/linux/bpf.h |   7 ++
> >>   4 files changed, 209 insertions(+), 37 deletions(-)
> >>

[...]

> >
> >> +
> >> +       return link;
> >> +}
> >> +
> > [...]
> >
> >> +       if (is_link) {
> >> +               anchor_link =3D bpf_get_anchor_link(flags, id_or_fd);
> >> +               if (IS_ERR(anchor_link))
> >> +                       return ERR_PTR(PTR_ERR(anchor_link));
> >> +       } else if (is_id || id_or_fd) {
> > this can be just `else {` with no conditions, no? Basically, if
> > BPF_F_LINK -- fetch link, otherwise assume program. Or am I missing
> > something? I didn't touch this part, but maybe we can simplify this a
> > bit in the follow up?
>
> I followed the function bpf_mprog_tuple_relative() in mprog.c.
> It has
>
>         if (link)
>                 return bpf_mprog_link(tuple, id_or_fd, flags, type);
>         /* If no relevant flag is set and no id_or_fd was passed, then
>          * tuple link/prog is just NULLed. This is the case when before/
>          * after selects first/last position without passing fd.
>          */
>         if (!id && !id_or_fd)
>                 return 0;
>         return bpf_mprog_prog(tuple, id_or_fd, flags, type);
>
> So check anchor_prog only if 'id || id_or_fd'.
>

ah, ok, let's keep it then

> >
> >> +               anchor_prog =3D bpf_get_anchor_prog(flags, id_or_fd);
> >> +               if (IS_ERR(anchor_prog))
> >> +                       return ERR_PTR(PTR_ERR(anchor_prog));
> >> +       }
> >> +
> > [...]

[...]

