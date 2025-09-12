Return-Path: <bpf+bounces-68240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78805B54FB9
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 15:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759051885D54
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC430E847;
	Fri, 12 Sep 2025 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDSjqNER"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889C0303C80
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684189; cv=none; b=KhdmjTqfPK73otYrGZb2k3thZIve28FVMrNEpWMgAp7hOfvrd/ui3b69RMbuMLckeE16/G/MQ1D2X6jVeXSIGTIFgX5dPouV2SQC/32dhTMsZfpbEvo2dHTyae7oKZKg8fkU0DPKzMEnGOAXVB4cTEq7GncojMSL+cWv/c1e1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684189; c=relaxed/simple;
	bh=jxb95qOE2mXF19IXGEpad3j8R8SzT12JNa1YscswO98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsO/lKTwQwWwgdrWvKhAeFDSNLcvcUnch4IwRP7RAvLz8MIny1TT6vYvzwnn3X1ZuhsKChNo+gTqhKSW3EDAPjDHYQj/cfxSaz+1TW9vjagOEatZSAh7orxL8s/srlbGnC7ODgCsQTsW1N0VABWC9aMuHn5I7xoZRrmO3USsy+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDSjqNER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A894C4CEFF
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 13:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757684189;
	bh=jxb95qOE2mXF19IXGEpad3j8R8SzT12JNa1YscswO98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WDSjqNERLXSIZ2PDePVCYCmuJz+04AYgU2cDsHJ5P/BV8oJZ3/A11EH7IIqODAd/B
	 JLoneG9QApj4dQ5Lb61/ss+zPMLQnGkqqDy9kP3Em4rVhgDBN4BB9gLm5XDiEOYbyZ
	 Gu2Ni3iX3xd/R1226TlncHDAcVx2+ROhPYqxB4eBXuWidqWSbU68WiCRtpP/Cmp21p
	 4RbUnEL/bD4r2owJrXYgHoHIcSyyoX68G1sfqH/ZdXzHwZ1GKRjf9/FQkGQsL+N+3c
	 vX7j2BNBqWhGPbcEk5/BYlSKNp82GR+tSubj7UKemc92LfMWdlPEvFfd4T7bOX8odV
	 K85YdEq+d0f+A==
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dfb6cadf3so17398595e9.2
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 06:36:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YyTp8gZlAnALArIzEzjMhE1OrYqKge1ECwe15eZ7rgtDyXsldr0
	mfZFVl9jNJH6du0VCmaBBDZJeFiqnbBgVrMIYY/rCPrxvxbsHroaefGLkseMNCAwAYiSLHKDv8+
	yaW51RhDtj1G9QqkwyLMo6H67/2kQ8gLNU0qmJb0c
X-Google-Smtp-Source: AGHT+IHexEguqXBinyBUy240Clj6Yjn2D+B3OU7jb9SSIhbcbMvjkwy89a4OJREtT69L9Gd9chSzVBxoNN20+qPEQlQ=
X-Received: by 2002:a05:6000:22c1:b0:3e4:7de4:8b9c with SMTP id
 ffacd0b85a97d-3e7657986ccmr2765314f8f.24.1757684187510; Fri, 12 Sep 2025
 06:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813205526.2992911-1-kpsingh@kernel.org> <20250813205526.2992911-7-kpsingh@kernel.org>
 <CAEf4BzaXA9R4_tJtA6jsVc3im9LJWhzRGQoVyGjFnH89ohZbcw@mail.gmail.com>
In-Reply-To: <CAEf4BzaXA9R4_tJtA6jsVc3im9LJWhzRGQoVyGjFnH89ohZbcw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 12 Sep 2025 15:36:16 +0200
X-Gmail-Original-Message-ID: <CACYkzJ51Nsig1-cg4-5FHcrcG-5W=+zcS9ZeWyYMTPbugCHFPQ@mail.gmail.com>
X-Gm-Features: AS18NWDG7AAxfn7xnpcLLFBpmGX3IUjOCSZ2Ui_XXyyclWvG4yj2fIBfJJLiMMg
Message-ID: <CACYkzJ51Nsig1-cg4-5FHcrcG-5W=+zcS9ZeWyYMTPbugCHFPQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 8:46=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 13, 2025 at 1:55=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> > Currently only array maps are supported, but the implementation can be
> > extended for other maps and objects. The hash is memoized only for
> > exclusive and frozen maps as their content is stable until the exclusiv=
e
> > program modifies the map.
> >
> > This is required  for BPF signing, enabling a trusted loader program to
> > verify a map's integrity. The loader retrieves
> > the map's runtime hash from the kernel and compares it against an
> > expected hash computed at build time.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  include/linux/bpf.h                           |  3 +++
> >  include/uapi/linux/bpf.h                      |  2 ++
> >  kernel/bpf/arraymap.c                         | 13 +++++++++++
> >  kernel/bpf/syscall.c                          | 23 +++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h                |  2 ++
> >  .../selftests/bpf/progs/verifier_map_ptr.c    |  7 ++++--
> >  6 files changed, 48 insertions(+), 2 deletions(-)
> >
>
> [...]
>
> >  struct bpf_btf_info {
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/too=
ls/testing/selftests/bpf/progs/verifier_map_ptr.c
> > index 11a079145966..e2767d27d8aa 100644
> > --- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> > +++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> > @@ -70,10 +70,13 @@ __naked void bpf_map_ptr_write_rejected(void)
> >         : __clobber_all);
> >  }
> >
> > +/* The first element of struct bpf_map is a SHA256 hash of 32 bytes, a=
ccessing
> > + * into this array is valid. The opts field is now at offset 33.
> > + */
>
> Does hash have to be at the beginning of struct bpf_map? why not just
> put it at the end and not have to adjust any tests?.. (which now will
> fail on older kernel for no good reason, unless I miss something)

It has to be on the top, see the explanation / the code we generate
for verifying the hash it reads from the const_ptr_to_map.

-  KP

>
>
> >  SEC("socket")
> >  __description("bpf_map_ptr: read non-existent field rejected")
> >  __failure
> > -__msg("cannot access ptr member ops with moff 0 in struct bpf_map with=
 off 1 size 4")
> > +__msg("cannot access ptr member ops with moff 32 in struct bpf_map wit=
h off 33 size 4")
> >  __failure_unpriv
> >  __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN"=
)
> >  __flag(BPF_F_ANY_ALIGNMENT)
> > @@ -82,7 +85,7 @@ __naked void read_non_existent_field_rejected(void)
> >         asm volatile ("                                 \
> >         r6 =3D 0;                                         \
> >         r1 =3D %[map_array_48b] ll;                       \
> > -       r6 =3D *(u32*)(r1 + 1);                           \
> > +       r6 =3D *(u32*)(r1 + 33);                          \
> >         r0 =3D 1;                                         \
> >         exit;                                           \
> >  "      :
> > --
> > 2.43.0
> >

