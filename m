Return-Path: <bpf+bounces-17109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2844C809BA0
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 06:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDBC1F21350
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 05:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9675681;
	Fri,  8 Dec 2023 05:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRVHqwbC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BD0523B;
	Fri,  8 Dec 2023 05:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351DBC433CB;
	Fri,  8 Dec 2023 05:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702012649;
	bh=hRWbP7/xJGbm5NF7uXfhaVnWOsOWa1f9qdHFS+DBVzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uRVHqwbCELIzfEftwQCjXNkbDnJqNjFnjxfM9kj8R/GO8Q6F039rnVwisIh+rw/pS
	 0pMLgvXhnSC+a+POPoF0UsG2sVGp7Mf4O4lAm76Hxtxlt51P3HVFyh3+TvYo1PqaJj
	 KtWzY8BG+dJSTKxL3yQZBojKYdSdQoh067zuZ+H2Ck3KVbbCWr0pbM18RlQeDT5vsY
	 rv6xTcRQNsC2QgYeQ2ygqyAHqz1WWgNLw/w0Oj3dgveqHLwXSnhYXbjplvSEMwU5dN
	 Eg/joHxcbKQmZg/KJtSaq4VNYkV9mM8NuTBptFnuH6RgdpxhTkvgVME20i2In+xJ+R
	 4hlWRa2ib5tOA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50c0f6b1015so1808434e87.3;
        Thu, 07 Dec 2023 21:17:29 -0800 (PST)
X-Gm-Message-State: AOJu0YwVZqZTH8EW8uHcJP4DuD/zfX4jmZ0jIBEeXCHSOLUUByUk3h8a
	FCJkRLrOIM6eqaeXwSK3eStV3rimrGJ1io09q8k=
X-Google-Smtp-Source: AGHT+IHhtf5M0C/Qw6yEOPkHWeNfJyuSWqXtrSsQHv9+RaQk6TESdkOAcIfCcITP00Mel3wpKINLoROlUIx6vRFmA9I=
X-Received: by 2002:a05:6512:3b06:b0:50c:20f3:e7cd with SMTP id
 f6-20020a0565123b0600b0050c20f3e7cdmr1033075lfv.18.1702012647390; Thu, 07 Dec
 2023 21:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZW+KYViDT3HWtKI1@CMGLRV3> <CACYkzJ5iyiUi_3r439ZMRnjM2f9Wd0XYoGJYQY=aXJ4QmX7e-A@mail.gmail.com>
 <ZXJViQDsdj7Bg4e9@CMGLRV3> <CAPhsuW6dib__mB8RJUPQGz_f+NLKmdVE3HsZ1JTy6_Ga7ysViw@mail.gmail.com>
 <ZXJhbHpIC3zHIYXs@CMGLRV3>
In-Reply-To: <ZXJhbHpIC3zHIYXs@CMGLRV3>
From: Song Liu <song@kernel.org>
Date: Thu, 7 Dec 2023 21:17:15 -0800
X-Gmail-Original-Message-ID: <CAPhsuW75dNUW_ssWxsUjwnuV1W9QjX5nMEw0jwWrjG4wvYQu6w@mail.gmail.com>
Message-ID: <CAPhsuW75dNUW_ssWxsUjwnuV1W9QjX5nMEw0jwWrjG4wvYQu6w@mail.gmail.com>
Subject: Re: BPF LSM prevent program unload
To: Frederick Lawler <fred@cloudflare.com>
Cc: KP Singh <kpsingh@kernel.org>, revest@chromium.org, jackmanb@chromium.org, 
	bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	laoar.shao@gmail.com, casey@schaufler-ca.com, 
	penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frederick,

On Thu, Dec 7, 2023 at 4:21=E2=80=AFPM Frederick Lawler <fred@cloudflare.co=
m> wrote:
>
> On Thu, Dec 07, 2023 at 03:42:49PM -0800, Song Liu wrote:
> > Hi Frederick,
> >
> > On Thu, Dec 7, 2023 at 3:30=E2=80=AFPM Frederick Lawler <fred@cloudflar=
e.com> wrote:
> > >
[...]
> > Trying to understand the solution here. Does load-policies add multiple
> > policies to stop different ways to unload the LSM BPF program (unpin,
> > umount, etc.)? So the only way to unload these policies is reboot. If t=
his
> > is the case, could you please share the list of hooks needed to achieve=
 a
> > secure result?
>
> ./load-policies loads multiple BPF object files (policy) each containing
> N programs. Then for each program, pin it to the bpffs and terminate.
> There's more there for atomic loads etc... but not relevant
> for answering the question. For this hack, I created a bpf object file
> with two programs:
>
>         - lsm/sb_umount
>         - lsm/inode_unlink

Thanks for the information. This seems easy enough.

> More could be added to this list as necessary depending on finding other
> ways to unload. I've only found the filesystem to be the most consistent
> way so far. libbpf's unpin functions seem to be also trapped by the
> inode_unlink program, but more exploration syscalls is on my
> TODO list.
>
> And added the object file along with the rest to load in.
>
> > If the list is really long, we should probably add an option to
> > permanently load and attach a program (until reboot).
>
> This is an interesting thought as well. I think that would fall under
> idea (5) [1]. But the list isn't that long, and lonterm, I'd like the loa=
der

Agreed this falls under idea (5).

> to have permission to load/unload BPF LSM progs. But, this won't help fol=
ks that
> leverage BPF's skeleton loading methods and users that rely on anon
> inodes tied to the task. I think KP offered some ideas there [2].

Thanks,
Song

