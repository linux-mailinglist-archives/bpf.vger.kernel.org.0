Return-Path: <bpf+bounces-73060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0F9C21B27
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 19:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 271314F6E94
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 18:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EE21DB127;
	Thu, 30 Oct 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB2E6JPY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD2E1DD525
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847429; cv=none; b=fbs6FD63EKj2HXT47pe/xV2laLLGGihu6Q5NBwD+LkFdIxS1A3spR6UiOLooe2wWTkjSMckNHq+c0N4jDpIxkdiHMBy2F/0CqdR2rpLrX6rhVs+XE5+gBDXDz9AxA+yfInBroEhWe3CyJ1RQ9KuWSLG8aP4PjvOJZ9v2jFmuQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847429; c=relaxed/simple;
	bh=d5pYIM+DlvI/eeXCbPFua+nftpLWGhp6JWVLglPWRyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWn00eJanlsKfsQAXzPBH6ksNYBP9wgp/bATlihi/c92W1btZOhysaVTeE+UFi1rhicpRQnLc6+ErwuPH6HhbRAWtLOEwU9vOS9W6J8LMC2Wicmd7i6+Red/dhsE56t0dhUJXuZEC22T2V4QLXVWOpWz45QdQI9L3rHYYRPl7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB2E6JPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14FEC113D0
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 18:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761847429;
	bh=d5pYIM+DlvI/eeXCbPFua+nftpLWGhp6JWVLglPWRyo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EB2E6JPY+WdW8RaGhmAKFHCCMbUYd+AvswVRSYtCWaxjALV3kRX8um2H0bn+1ULRR
	 mQwmifGKoWBSPD+l+D4im46/lWjuRbyWJkHUDN2OWzsF0Dsd/bKTuvD9elbeGetj0+
	 vaBER1wLAkt3LpJQGzFSfJOBY+VHMPDgevTWqU9E2FEFCHLDwSK9ImaDj9sstZxWV7
	 S4C24z04fioOacHGP3aB4PjMiYVj0xrxgWGXUYtHk8P+fbpI8OHZzgg6wX10vJgmhI
	 8RQTFf6e08m7ShCUepiFzIVO1pPe6YHdPAdI/J0/7E76rzihNk9s82Tlls8kEmB77H
	 HRGD5olUT5N3g==
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87fbc6d98a9so11376476d6.2
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 11:03:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdrStC6itN1PcUJ/cb6xuVFw/U01pV6K7DfHk57fodc8+Y0+n+ACHGFI4EnB81WHRPN+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8HD7Yy8oAF7OpmbZQgT1YtYKLw/2gle+bl2xyIxx1r5zqEBt
	fRIn1m5jZb8GPLyN801qOjmt2w/ijZzwxeZJAbhq4nYOI74vu40DZIG6a4GJD9DKr3k1v1liL/E
	v+W13ocOYzab/+jlx2mvT1xo+aoNp1F8=
X-Google-Smtp-Source: AGHT+IHhsYhWatkhUtR9Thi3jups/Zf6twLHgbotCak5ADv4q6trdZ9jUiXcieO2Ocfd/pZQOSvORcXRaoUyXxEzlH0=
X-Received: by 2002:ad4:5cad:0:b0:880:2582:b7b5 with SMTP id
 6a1803df08f44-8802f2f3cc5mr7911166d6.23.1761847427883; Thu, 30 Oct 2025
 11:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <CAHzjS_sLqPZFqsGXB+wVzRE=Z9sQ-ZFMjy8T__50D4z44yqctg@mail.gmail.com>
 <87zf98xq20.fsf@linux.dev>
In-Reply-To: <87zf98xq20.fsf@linux.dev>
From: Song Liu <song@kernel.org>
Date: Thu, 30 Oct 2025 11:03:36 -0700
X-Gmail-Original-Message-ID: <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
X-Gm-Features: AWmQ_bmwqDpuhyP64DRlFdaSqpW8LEt5_ngM2TCJT1ee3IRNDHD_d8LbTVxeNBg
Message-ID: <CAHzjS_tnmSPy_cqCUHiLGt8Ouf079wQBQkostqJqfyKcJZPXLA@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Song Liu <song@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:22=E2=80=AFAM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Song Liu <song@kernel.org> writes:
>
> > On Mon, Oct 27, 2025 at 4:17=E2=80=AFPM Roman Gushchin <roman.gushchin@=
linux.dev> wrote:
> > [...]
> >>  struct bpf_struct_ops_value {
> >>         struct bpf_struct_ops_common_value common;
> >> @@ -1359,6 +1360,18 @@ int bpf_struct_ops_link_create(union bpf_attr *=
attr)
> >>         }
> >>         bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_stru=
ct_ops_map_lops, NULL,
> >>                       attr->link_create.attach_type);
> >> +#ifdef CONFIG_CGROUPS
> >> +       if (attr->link_create.cgroup.relative_fd) {
> >> +               struct cgroup *cgrp;
> >> +
> >> +               cgrp =3D cgroup_get_from_fd(attr->link_create.cgroup.r=
elative_fd);
> >
> > We should use "target_fd" here, not relative_fd.
> >
> > Also, 0 is a valid fd, so we cannot use target_fd =3D=3D 0 to attach to
> > global memcg.
>
> Yep, but then we need somehow signal there is a cgroup fd passed,
> so that struct ops'es which are not attached to cgroups keep working
> as previously. And we can't use link_create.attach_type.
>
> Should I use link_create.flags? E.g. something like add new flag
>
> @@ -1224,6 +1224,7 @@ enum bpf_perf_event_type {
>  #define BPF_F_AFTER            (1U << 4)
>  #define BPF_F_ID               (1U << 5)
>  #define BPF_F_PREORDER         (1U << 6)
> +#define BPF_F_CGROUP           (1U << 7)
>  #define BPF_F_LINK             BPF_F_LINK /* 1 << 13 */
>
>  /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
>
> and then do something like this:
>
> int bpf_struct_ops_link_create(union bpf_attr *attr)
> {
>         <...>
>         if (attr->link_create.flags & BPF_F_CGROUP) {
>                 struct cgroup *cgrp;
>
>                 cgrp =3D cgroup_get_from_fd(attr->link_create.target_fd);
>                 if (IS_ERR(cgrp)) {
>                         err =3D PTR_ERR(cgrp);
>                         goto err_out;
>                 }
>
>                 link->cgroup_id =3D cgroup_id(cgrp);
>                 cgroup_put(cgrp);
>         }
>
> Does it sound right?

I believe adding a flag (BPF_F_CGROUP or some other name), is the
right solution for this.

OTOH, I am not sure whether we want to add cgroup fd/id to the
bpf link. I personally prefer the model used by TCP congestion
control: the link attaches the struct_ops to a global list, then each
user picks a struct_ops from the list. But I do agree this might be
an overkill for cgroup use cases.

Thanks,
Song

