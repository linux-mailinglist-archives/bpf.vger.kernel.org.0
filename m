Return-Path: <bpf+bounces-75509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66228C87757
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9C744E40FC
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287E32F0676;
	Tue, 25 Nov 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkKNglA1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE7E232785
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764113181; cv=none; b=IBLRenM92Fh/MqRjSd3+KFCpZynTgpACej/Mk+zJl5WL/VjMxgiZNk68QWvfwYNY9z8enNyOqg20tIbZx36+SfRC6rMgvlR0+hGRgDMMW2ZyHLBhvYMj0QMwI09qxj685Ujpbwq2VVghayZsMiX2SnLMxFheC1VMg2gpyQD5ZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764113181; c=relaxed/simple;
	bh=siFQ1bf0s/fpNy34d93TDtRfWB2PuZZkA0RO/cP3mWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMHOEdOBClhV/cnKeR2HXhz5AZNljnz1422s0jRuwMgfBWre5u/4wzwFPygljAXHxNB+Vdtk+riKPvIqSEASjBM/DkYMoG3xlIVTyviu+/CFbi4xCzHOz1n6U0QmzoLxo+p8Wk8oiDiwU4lxfomprBOsnlsohgpKr/SuEK06lhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkKNglA1; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-642f3bab0c8so4390550d50.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 15:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764113179; x=1764717979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elr8aIjn47xOg/+VM5F97jLdZTnycMz0MA5pcIR09Z0=;
        b=fkKNglA1mZm5bbjWIsgLOjBFVr1fHDQ8TPNXs0mmnO+SAZIspk2baYKlwUsr+E9QoC
         4qZHy9f056pVimKfoJ8+NYYiX7IukHhnjwgdOCqJMkUqGIksysQeb33LmPXyiIeROEdR
         zUZKlMcTOoTdD4d8ZsZ1HKHEsVsthC5XR2fCG8dKWWmNfEPpu2ffARlak0YJ/PApGZGc
         I7c/LpamIJ5DriJDXM8wgfGq4usSNM9WNJjhyUIgbrmwm1QfuI9vvb4Cg8P6k2E6ev3D
         T4kpM9G+3plBp+ru0IfSE0LalOVL9a+GV9P4C5/HjGjjoZ+qwMeRVk0eoAvxDmxvIk9x
         5Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764113179; x=1764717979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=elr8aIjn47xOg/+VM5F97jLdZTnycMz0MA5pcIR09Z0=;
        b=OekPdzQI2QU/hddp4irJu7FN31f4iEQqq5g3HnCmIb7nxN/nTlCtNhCeePR06C4BLS
         3lVPRIu8b97VRhBqJxKaT2ad93WMx1lYRmX+oaHQ4QTZYv4TzuVakaAcuWVso50mXXcX
         CWqKcV/K0zfLbeFWBu3bo0sPIInk0kCpnVqrXZpFUMBfklU+narmBIsr8zjJ6xyrBXh3
         qDUqy/67iWuPes0LO9xZpIf+YyksRY6nk8XRObvhdJJLR60fARfpeFe0wDSkTmGa+zDj
         bmSczmxBO5Vb+IxLwPqt1SHSuq3oPlr4La8PQYCYJyUCBNm5/2P3ByTFkbrbJp6/WIhv
         2fbA==
X-Forwarded-Encrypted: i=1; AJvYcCXikZbC+b6SbYlbisr0oandAKInZtWcxCJLHrV1l11VxFEKduJ7HOLQTL32OxxbbRELd9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxObyVB5ZTJVR3xog+Fot3qihgN/rmeSPmnyJ9QPkQL0kqbD/pq
	2gEvZE1bNXRCQxQQV823N19MmthujZExfc6LEzJaAsf8qR/U5pLgAIEmjVjPfCE8U1wI4hwO/+c
	DQE/ik1PSRCnphw/JEQoOdRxW/Vmr9Es=
X-Gm-Gg: ASbGncv2oiMO5tpG8fF5S1mPlpkCeAQlfLXmboV2m1wT58BGOmd59qchbgQCM6z9TcZ
	rmgFrlJFufv+o1Ag8hkSjqZmCpQETEwKe7xWs2Gjzp9VFkVnp9tkxX01UxCChuv2YXfpHkyhao4
	5cuK02EDBNLlbNjk7dxUxRhzrnLGPMTTiVoVBMHnv+hWIN44SPql+MPlKq6Jd92dBRYXs3DLv+b
	Y6UucgjF5zBOfLjnmUBXzWGqb1yWNMh8516KamRc4OLlg7LsRxmEkc+AHCTcNj+NwAmB6c=
X-Google-Smtp-Source: AGHT+IE3eCaRjYpZKUWkOF6wFH9GEckxUjQVdkjJcXz+POjmJS+rY4/6g1wD4JITBMKqhJ+TwKhAOsBetH3+KVItBTA=
X-Received: by 2002:a05:690e:2513:20b0:641:f5bc:696c with SMTP id
 956f58d0204a3-64302aed76fmr9794391d50.72.1764113178814; Tue, 25 Nov 2025
 15:26:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1d2d1968.47cd3.19ab9528e94.Coremail.kaiyanm@hust.edu.cn>
 <CAMB2axMgCapnYS4Qr-PVm6FjPCkF3bi-LNtV5EpFLVtAs_JNGA@mail.gmail.com> <CAADnVQ+fDin56GSBaANBf0P+xiQYGWgcDZFT=2OnRKhCa04Kdg@mail.gmail.com>
In-Reply-To: <CAADnVQ+fDin56GSBaANBf0P+xiQYGWgcDZFT=2OnRKhCa04Kdg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 25 Nov 2025 15:26:07 -0800
X-Gm-Features: AWmQ_bkGzF6DqeF-pRR9byVwQSClubRQ5N0sN21PCqUsMvH7jV8lxEqBiuGj_m4
Message-ID: <CAMB2axOHy5FQm4ZvoT6tFOp9jACUh2MZOXsup4TUm1ZL485=fA@mail.gmail.com>
Subject: Re: bpf: Race condition in inode local storage leads to use-after-free
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yinhao Hu <dddddd@hust.edu.cn>, dzm91@hust.edu.cn, 
	hust-os-kernel-patches@googlegroups.com, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:17=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 25, 2025 at 3:06=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > On Mon, Nov 24, 2025 at 8:43=E2=80=AFPM =E6=A2=85=E5=BC=80=E5=BD=A6 <ka=
iyanm@hust.edu.cn> wrote:
> > >
> > > A use-after-free vulnerability was discovered in the `bpf_inode_stora=
ge_get` helper function. This flaw is caused by a race condition between th=
e destruction of the anonymous inode that backs the map of type `BPF_MAP_TY=
PE_INODE_STORAGE` and the execution of a BPF program that attempts to acces=
s that inode.
> > >
> > > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> > >
> > > ## Root Cause
> > >
> > > The use-after-free occurs due to improper lifecycle management of the=
 anonymous inode associated with a `BPF_MAP_TYPE_INODE_STORAGE` map. The pr=
oblem could be triggered through a race condition:
> > >
> > > 1.  A BPF program creates a map of type `BPF_MAP_TYPE_INODE_STORAGE`.=
 The kernel allocates a file descriptor and an associated anonymous `inode`=
 to serve as the backing storage.
> > > 2.  A BPF LSM program is loaded and attached to an LSM hook `bpf_lsm_=
file_alloc_security`. This program holds a reference to the `inode_storage`=
 map.
> > > 3.  The process that created the map exits, causing the kernel to clo=
se its file descriptor. This decrements the reference count on the `inode`.=
 When the reference count drops to zero, the `inode` is freed.
> > > 4.  When another process trys to create the map, the LSM hook is trig=
gered, causing the attached BPF program to execute.
> > > 5.  The BPF program calls `bpf_inode_storage_get()`, passing a pointe=
r to the now-freed `inode`. The function attempts to access fields within t=
his freed memory region, leading to a use-after-free.
> > >
> > > The fundamental problem is that the BPF program's reference to the `b=
pf_map` does not translate to a reference on the underlying `inode`. This a=
llows the `inode` to be destroyed while it is still potentially in use by a=
n active BPF program. The comment in the `bpf_inode_storage_get` function, =
`/* This helper must only called from where the inode is guaranteed to have=
 a refcount and cannot be freed. */`, highlights this exact requirement, wh=
ich is violated by the race condition.
> >
> > Thanks for reporting. I found the root cause here a bit hard to
> > follow, so I also ran your POC on a VM with bpf-next kernel and
> > confirmed the kernel did panic.
> >
> > However, the bug seems to me to be an uninitialized file->f_inode
> > being passed to bpf_inode_storage_get() in
> > bpf_lsm_file_alloc_security.
>
> Thanks for the analysis.
> That's not the first such problematic lsm hook.
> Let's just add it to bpf_lsm_disabled_hooks[].

Got it. Will send a patch disabling bpf_lsm_file_alloc_security.

