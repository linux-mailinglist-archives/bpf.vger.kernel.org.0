Return-Path: <bpf+bounces-61785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8DEAEC2F9
	for <lists+bpf@lfdr.de>; Sat, 28 Jun 2025 01:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D946E4A63
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1AB29293F;
	Fri, 27 Jun 2025 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVhT3/Mj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D25291C0F
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751066382; cv=none; b=Cmq/AZdqoegKqssOACP5JK+5yP9Rhfnz4hARzw6ivtGU9xLAiU8VQ854em415spl1ZqCIVQxMLURDhuIYGYXYk4TKtrpKs2E61tjJ6GVH/6x3yRg0cEkVUXWTsPvvAzw5MEQ0UpP303PRv8t9ZmLkpoXcxTZTbT4m2Y6Kh1Qk3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751066382; c=relaxed/simple;
	bh=+h1hxYCkkOpnf1H6RQa3KbC3lgE7p4cV1AsfS29x+ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VRqDwuhyTE9mt1lhN/TdVDW9KUBFVPmFFmfQFbJz0iTrH6DgR3EoeMDv/HJ8NUvJM+X75hBy/vFxPqw9Dof9Ybp3omqDoGrp6EGBkz92SZrs01tGwGbi4jZCU+7jKqWh0Uxh+53PrMV4qepCwOPZhw5r1PV8ptycE1HEvYlyPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVhT3/Mj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso218690f8f.1
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 16:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751066379; x=1751671179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBKK8krewJJcn6nP/C2CQzFePSvnZottc6tDd43iiE4=;
        b=iVhT3/Mjpjl+N/ptG8US9JZeVL3mcIIVCU4agBH9ZJVpD1FiKDdlKxGsrrEoEOTlSC
         F1oSqnC7SxsNfUalItIqqLF+9UKEsNRBlS3YyCgk1SqSE/OSiGJbRtqtx5q8DZLmU88m
         RgaambFU397UGg6K/TOAtjZmMn9CmJAB+5ILYXUTZBlkC2X6yvCOYJD3PfAavzqDvMyw
         OXuIeVxH2wfD0cUMO7rwQqcdwQVxr6gNTWF1CIEDydegtcFIgjM4utN+sfyBNUbDe5f8
         Txj7hV/4KVDPmYlJ9iF7yNCC+VQ86+pRAOO+gYoyzV8UelzDAz6enAJEuZd42EXB+NtB
         J4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751066379; x=1751671179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBKK8krewJJcn6nP/C2CQzFePSvnZottc6tDd43iiE4=;
        b=AIvORjtr7OrQKniGCR+6JYJ6WDov5tL+zNerI9QYeuCHrpZudVi409dK5b9lXPWwP3
         balRGJxAgiWqNDUCwvuKofXKsI8zEnIXt8WT3YgW/FjugSeJutjkOFjeZyUWZUFFhRiZ
         7fEqwz3sEcxYRF5dADU3j1xbCxsgJmD4CB4Wi11UkPaArjsQiV2buFbzDrdbQ1ZFSbWh
         7JBmIjuB9NrNKPdRFSvrznx41KNdaGlVZuXRbxNeK6fPy//VXB/FzgFCmF+ZWQMfkCGu
         Qia3ckd375E0wl+RevM9SIumhJolJzCYz4j1ASUZwUQi8ncrvCmsn2o4n8u5GrJr+RNs
         fKkw==
X-Forwarded-Encrypted: i=1; AJvYcCWF79p3w/0H05cM0anu4qcjkgRL8uLEBSEt1gt1Ic7m6CxwJY53dQxSnyrLMmyi2Po941k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJaMUDLQw5n+ZVF36lY+3Cl30322jMDiFIynCyOtRTboTaile
	5ZFH4c+kxlDUHGqWRHtMFkJEdcR7N6N7hQHKX34XHm6/S73znU1rFySDEtQvI4jbScgxGVMIrS4
	s4gtYN3J32cN5VFMITOZL/121pBCqbpk=
X-Gm-Gg: ASbGncslarEErpIz/06Mhc1nGedS/bI5CBw4Lp0otsDcLR9f/YyvZmU73BTZowUIdJp
	DImqrmVW9iFgMv47rGFLqGjRpcm46AegxHThyPZnA0XxqI01JfHYs0FH7JciDBCzN6AHPJRCsil
	6NQlVNQM6upQfmY+dqmwNdOzM8rmxowb+ibcSVjbU3sPfeNZUDmjRHzgi9CLF2uMaO5VSJ3JND
X-Google-Smtp-Source: AGHT+IGFv1uQFExJNDN0K/W+EDLKSDLT5xOQO8K7y2X8gBEZ2GyhxyNUWMac+K9exJE6hCTTPluwQCpsSUIZcpunbSI=
X-Received: by 2002:a05:6000:4186:b0:3a4:dc42:a0ac with SMTP id
 ffacd0b85a97d-3a8ffadf926mr4301607f8f.49.1751066379238; Fri, 27 Jun 2025
 16:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627191221.765921-1-song@kernel.org> <839d4696-fad6-499b-a156-994951ea75c7@linux.dev>
 <CAADnVQL5vQ9e5TMYfUafkzEUU+akgVME=OFtbATeTkL-G8aKLQ@mail.gmail.com>
 <11bd7899-9ffe-48fc-8d0b-94ed3b9532ab@linux.dev> <CAADnVQ++H6qOvU7tYvcxh8NW-kshUPhTCuc=4w4JCZCeu_zcdA@mail.gmail.com>
 <c0b17b50-3d8a-4e63-be6e-d4cd2564a49e@linux.dev> <fbdb8883-cffe-4764-889b-6d00f2058e75@linux.dev>
In-Reply-To: <fbdb8883-cffe-4764-889b-6d00f2058e75@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Jun 2025 16:19:28 -0700
X-Gm-Features: Ac12FXyFqEg_2z1wJ27OkzU3K0KACmZnkPWCuXYGuswceM55zr6yXbkJr0NQw2w
Message-ID: <CAADnVQK=+La10L16PVQHFnw3zMGi3NzTdcj=WXSs1syPttZdzQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Fix cgroup_xattr/read_cgroupfs_xattr
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Jakub Kicinski <kuba@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 3:06=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 6/27/25 2:56 PM, Ihor Solodrai wrote:
> > On 6/27/25 2:38 PM, Alexei Starovoitov wrote:
> >> On Fri, Jun 27, 2025 at 2:36=E2=80=AFPM Ihor Solodrai
> >> <ihor.solodrai@linux.dev> wrote:
> >>>
> >>> On 6/27/25 2:34 PM, Alexei Starovoitov wrote:
> >>>> On Fri, Jun 27, 2025 at 2:19=E2=80=AFPM Ihor Solodrai
> >>>> <ihor.solodrai@linux.dev> wrote:
> >>>>>
> >>>>> On 6/27/25 12:12 PM, Song Liu wrote:
> >>>>>> cgroup_xattr/read_cgroupfs_xattr has two issues:
> >>>>>>
> >>>>>> 1. cgroup_xattr/read_cgroupfs_xattr messes up lo without creating
> >>>>>> a netns
> >>>>>>       first. This causes issue with other tests.
> >>>>>>
> >>>>>>       Fix this by using a different hook (lsm.s/file_open) and not
> >>>>>> messing
> >>>>>>       with lo.
> >>>>>>
> >>>>>> 2. cgroup_xattr/read_cgroupfs_xattr sets up cgroups without proper
> >>>>>>       mount namespaces.
> >>>>>>
> >>>>>>       Fix this by using the existing cgroup helpers. A new helper
> >>>>>>       set_cgroup_xattr() is added to set xattr on cgroup files.
> >>>>>>
> >>>>>> Fixes: f4fba2d6d282 ("selftests/bpf: Add tests for
> >>>>>> bpf_cgroup_read_xattr")
> >>>>>> Reported-by: Alexei Starovoitov <ast@kernel.org>
> >>>>>> Closes: https://lore.kernel.org/bpf/
> >>>>>> CAADnVQ+iqMi2HEj_iH7hsx+XJAsqaMWqSDe4tzcGAnehFWA9Sw@mail.gmail.com=
/
> >>>>>> Signed-off-by: Song Liu <song@kernel.org>
> >>>>>>
> >>>>>> ---
> >>>>>> Changes v1 =3D> v2:
> >>>>>> 1. Add the second fix above.
> >>>>>>
> >>>>>> v1: https://lore.kernel.org/bpf/20250627165831.2979022-1-
> >>>>>> song@kernel.org/
> >>>>>> ---
> >>>>>>     tools/testing/selftests/bpf/cgroup_helpers.c  |  21 ++++
> >>>>>>     tools/testing/selftests/bpf/cgroup_helpers.h  |   4 +
> >>>>>>     .../selftests/bpf/prog_tests/cgroup_xattr.c   | 117 +++
> >>>>>> +--------------
> >>>>>>     .../selftests/bpf/progs/read_cgroupfs_xattr.c |   4 +-
> >>>>>>     4 files changed, 49 insertions(+), 97 deletions(-)
> >>>>>
> >>>>> Hi Song.
> >>>>>
> >>>>> I tried this patch on BPF CI, and it appears it fixes the hanging
> >>>>> failure we've been seeing today on bpf-next and netdev.
> >>>>> I am going to add it to ci/diffs.
> >>>>
> >>>> Applied to bpf-next already.
> >>>
> >>> CI patches apply to all base branches. My understanding is, it's need=
ed
> >>> at least for netdev too.
> >>
> >> How is that possible?
> >>
> >> The offending commit is only in /master and in /for-next branches,
> >> while /for-next is there for linux-next only.
> >
> > I am not sure.
> >
> > I compared CI logs between bpf-next and netdev runs that both were
> > cancelled due to 100min job timeout, and they are very similar.
> >
> > netdev: https://github.com/kernel-patches/bpf/actions/runs/15932863319/
> > job/44946276955
> > bpf-next: https://github.com/kernel-patches/bpf/actions/
> > runs/15934258609/job/44950981852
> >
> > So the root cause is likely the same.
> >
> > And most recent netdev (with this patch applied) is green:
> > https://github.com/kernel-patches/bpf/actions/runs/15936292169
> >
> > CC Jakub
> >
> >
>
> Apparently offending patches were merged by Christian Brauner:
>
> https://github.com/linux-netdev/testing-bpf-ci/commit/13b0cce9e294f8ddf22=
8b9db3e01d76ac29872f2

Yes. We're aware.

re: why netdev CI was failing.
I bet it's bpf-next + net-next auto-merge one.
It's a special ephemeral branch that netdev CI is doing.
It should be green already without CI extra patch,
because bpf-next is green.

