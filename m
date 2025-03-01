Return-Path: <bpf+bounces-52947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A322A4A713
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 01:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201C71735EF
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F83217BB6;
	Sat,  1 Mar 2025 00:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3Bkb1oP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5922EE4;
	Sat,  1 Mar 2025 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740789461; cv=none; b=t0ZmMZce8bXpDnDoewDBi7TAHZF/kimq6wKbJjCw/pjiEUy++RcdA3dQGCnIlJs2x/L/5nNBfRuXOtJdcLd9Zf3amkzr/hRZL6bEcHOJH3U7zOP2f4Lbq1Q3bGv9XwgEMtXQ7g+FWzD1hXdBfS2+vS/XuGd1vbE8DxU+CMYuXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740789461; c=relaxed/simple;
	bh=jwfc1ahgCiuzX7wkEu5HLzWqIBHpgdtoIiFrmHSt8/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qh0MI5xRXfJP3kUsWC9VW9yDL28HBhOyNJPqIlW0QbTPVF+9aSEBCvOO4K4xNDAquB7V1sm8A60+lnp6EPwW0hbPWaIakdn5Havn0JNwLsG4YdwmJDqSTfjBJ0kFiD5Z1+Ng1QPOnd7v9iexjfB+3k/pxeHHa2z2wm2SF7/w8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3Bkb1oP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B95C4CEE7;
	Sat,  1 Mar 2025 00:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740789461;
	bh=jwfc1ahgCiuzX7wkEu5HLzWqIBHpgdtoIiFrmHSt8/s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C3Bkb1oP8uqqMvX/ckArxbGIfZ8FywegE9C0lfYY9zPtWyff5LmUA7XsVzqS2dE2u
	 ry7m1s+d7yPr/D5/fbw+i81XvmyzmuRTaYhf30Bv/XkzBCdv057EqrlakZlrP3ZHSi
	 WqbUhe5bNZG7eyZKlbXD7XTwUUd7zbVJMFBVUtC9fkvrAVLkn8BRSHOesUUL8jhyCh
	 aaYK5X56L1i3AdLABEqxog3HRrn1e1+D/KCtO56oNS/ifHrGMiP+Q82nk6b8qLLedm
	 8foNToR4b5dGvZispxL5aijpJlAnUeeQIZt8UTY5Bo+LEl+NAdQyx/2gAs8OqqXKmp
	 xHPVCbIMLjQ+g==
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d2b3811513so11712505ab.1;
        Fri, 28 Feb 2025 16:37:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+5Qqs0B79Q0niGY8JONPuk46Y9bTmLhCNVDpcNYQX6CErj7mKN60O8fAFNAM1bLCPC9E=@vger.kernel.org, AJvYcCWBj1QL8ziINBbn6KSmyRuZGs5FmFLJmcPHWenTOp1Nt9+vujqBvIbeIp01zQX1+HGn0IV2E416x31lfhV3@vger.kernel.org, AJvYcCX5IWIlORUjNiMJ+kdXGjLEm3Orjnhc3BCcryCYBMvBbErwg2xSdwRJB30wqrCt6Sp1LaWkL7Y6Zw==@vger.kernel.org, AJvYcCXoDQQmldPSaVNoth8URxGxNKkn91idRenGJeQgPsUhr+ejLmVNP8ubailWy1uOSer0LYMlqv5wPxpx8CL7yOzyNkLeEPE8@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDdnos9gVvzg/4+vWnQRwfnALxzQ1/buEmes+Gbn8faQKEKTF
	tsC72Sr/ZRtdVmAPe7m5ZNv8b0OQvXsFOmesOMFVdVMOcZ17wRSaVDk6ShsrtB/8sVaoRotSITH
	wbx8aa3FQylClM5xYBDRmyP9+7I8=
X-Google-Smtp-Source: AGHT+IEvAO8t6XcTK7ehgVX1Cb5AI/CSDL/k9ZfYTeArTEPsP00ZZVVzFUSsiBhttHJf01azIqdBs3Jb+2eedTxZHVA=
X-Received: by 2002:a05:6e02:1a09:b0:3d1:84ad:165e with SMTP id
 e9e14a558f8ab-3d3dd2d3a29mr102153535ab.7.1740789460403; Fri, 28 Feb 2025
 16:37:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228165322.3121535-1-bboscaccy@linux.microsoft.com> <20250228165322.3121535-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250228165322.3121535-2-bboscaccy@linux.microsoft.com>
From: Song Liu <song@kernel.org>
Date: Fri, 28 Feb 2025 16:37:29 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4bsiD56PivQRLs6jrWGpiWt+4vfcdQ4YA-KWONxLYv9g@mail.gmail.com>
X-Gm-Features: AQ5f1JpfUDxDNGOOtYDiDeO6Tz4qbi76Krj7-XIzmH3zU3hT980dijVDfbDRf_Q
Message-ID: <CAPhsuW4bsiD56PivQRLs6jrWGpiWt+4vfcdQ4YA-KWONxLYv9g@mail.gmail.com>
Subject: Re: [PATCH 1/1] security: Propagate caller information in bpf hooks
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 8:53=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Certain bpf syscall subcommands are available for usage from both
> userspace and the kernel. LSM modules or eBPF gatekeeper programs may
> need to take a different course of action depending on whether or not
> a BPF syscall originated from the kernel or userspace.
>
> Additionally, some of the bpf_attr struct fields contain pointers to
> arbitrary memory. Currently the functionality to determine whether or
> not a pointer refers to kernel memory or userspace memory is exposed
> to the bpf verifier, but that information is missing from various LSM
> hooks.
>
> Here we augment the LSM hooks to provide this data, by simply passing
> a boolean flag indicating whether or not the call originated in the
> kernel, in any hook that contains a bpf_attr struct that corresponds
> to a subcommand that may be called from the kernel.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  include/linux/lsm_hook_defs.h |  6 +++---
>  include/linux/security.h      | 12 ++++++------
>  kernel/bpf/syscall.c          | 10 +++++-----
>  security/security.c           | 17 ++++++++++-------
>  security/selinux/hooks.c      |  6 +++---
>  5 files changed, 27 insertions(+), 24 deletions(-)

tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
has a BPF program for security_bpf(), please also update it.

>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index e2f1ce37c41ef..25f4e74c173be 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -426,14 +426,14 @@ LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void =
*lsmrule)
>  #endif /* CONFIG_AUDIT */
>
>  #ifdef CONFIG_BPF_SYSCALL
> -LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
> +LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, bool is_kernel, uns=
igned int size)

I think we should add is_kernel to the end of the argument list. This will =
cause
fewer issues for existing users.

Thanks,
Song

