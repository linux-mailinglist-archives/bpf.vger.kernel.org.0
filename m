Return-Path: <bpf+bounces-35418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0A993A7F4
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57C7B2292F
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D213F452;
	Tue, 23 Jul 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1U4yM83"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90613C691
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764985; cv=none; b=MUUHHX3eL58GeN/hz+hFjQLzwuRk0C2ZaZn4fiKu4oiPs3o6LwO4E6t08T0ETHc6u3c3oWbyoBFa0HOxSsV0tdURjrl5tx3HKK6JWc4YzB5VMwT1qNFIQ2HSC+yggmEWttkLr5ICWfYBoWmx0siqZ4l0fKxuR/P5KlCcjxtbO0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764985; c=relaxed/simple;
	bh=TfZ0tmITQ+pXHYL7+c6TDSEzOU0dGPGaxAe6isLwmrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3yAuj1TzcOXBzPwtToFqMulfNAiGP+xUnnAHcWM/dWspuR4yqD2LD5i8VHRe1xmtGJgHjBXmm3NR7CalIdM7+ScXMXxRlPYPWJZHN+LoB6//0gAJ/Fs+edWPPmWnNmeq16UKYk+UVkNPGI3epmgrIMDiuCCTR8d+dm/pFVK8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1U4yM83; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cb53da06a9so151096a91.0
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721764983; x=1722369783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQFg9+RpPVGjzHGVoUoYv/iKjkLyXwafJCQ52wquyOg=;
        b=O1U4yM83DvDnNTNYccyUIAsh90blYIr4ELfpcALO2fZH/O7OTkLEx/4SiVljIodOcc
         SZg5lftWW51r9GD3XVFDQ7YXKk//50C51BPFO5bCdOJWOaGi/cZGE2pE5jeIbCCRaWWl
         HeAEruz8Ah8BiAypc+FFz83D2u1sGkgn41lvbAd4q3m9ERpaPh1f9JjkA3hTtmS55Czg
         +iJsnCN0xvagyreNHqbw8fUbstHPDqQwK3OacdnS06t9cEDzfAn/iZ4MzwQVHmjZV6KU
         tZ+dSkrZy4MSUfhuVOl2KZQwFDCRz3dEG9dqRnQnYVfkSYpyhjuwkWc3+9VxvIUVIfJG
         xv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721764983; x=1722369783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQFg9+RpPVGjzHGVoUoYv/iKjkLyXwafJCQ52wquyOg=;
        b=RVj+aFGF7oyKy+33wwqW9IHvaxpIJjjuIb3blCIEeYf+4s8fVnMMoyc63/GaXcPbsu
         WZ54Zkkzktnh1+KWPoOAg8XUpBOAbuNkXmhCqyWyaLndMo5uW/dLnq3kDHkzkNnJPnAx
         nDoCLNBSTqnz0YLgMc+1sozc9P8AecVT+Dbx2kAHF1EhMSCNrfIveaf/Fzkvew9nGMWp
         K6YkxxPf1Y1EEAilf70wFksgg2NxF06AqkhG/jKeYhH34Fej1uIUUKDRHsRGdITOpfC5
         OM78Q/HarFOOuEKXUfL7Ca4hNJ1D2LFYXxPsfM4qUBzT/YoyqUIUxSoRnBLkD/CmQ4Ig
         sq+A==
X-Forwarded-Encrypted: i=1; AJvYcCUUlrZgvEFMkmAxmCQFejkQQy1SRGGtZ6YuEq8C+/GuEIowHqT8MzzZKyKFMr7kYVmwUdRjsToIOnlwW9/PoDEOZSZ/
X-Gm-Message-State: AOJu0YyK0r6YFVfqLE0Hbuk9sRl627NGEAc8MR+/dD4wCuhSyxRQw33o
	CcLAG6USRkACcJk61aNBirwjaGLluA9XQSOytQT3T8r8uMboyyMiqFmWtxFf0A65RQVpL9EzlTX
	4tXjVU+a3xKO7SRHsbdV+KPU8+Yc=
X-Google-Smtp-Source: AGHT+IHJP9sZNGtS29uICRYEwjzrv8jC14pvmt5H0S6KkZiZrTC4AswpDOSvJ/Ezm0lzbZmObN2PDL07fzvobM6O6+Y=
X-Received: by 2002:a17:90a:d904:b0:2c9:6aab:67c4 with SMTP id
 98e67ed59e1d1-2cd8cd52d0fmr4899740a91.10.1721764982865; Tue, 23 Jul 2024
 13:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
 <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org>
 <CAADnVQ+F6JKp1e61NC22wt8L9YEVAz9w648GvdV8hUrM3dkDFA@mail.gmail.com>
 <24a6649743528b2c8f44cc5415df32a3020b0951.camel@gmail.com>
 <oNTIdax7aWGJdEgabzTqHzF4r-WTERrV1e1cNaPQMp-UhYUQpozXqkbuAlLBulczr6I99-jM5x3dxv56JJowaYBkm765R9Aa9kyrVuCl_kA=@pm.me>
 <FnnOUuDMmf0SebqA1bb0fQIW4vguOZ-VcAlPnPMnmT2lJYxMMxFAhcgh77px8MsPS5Fr01I0YQxLJClEJTFWHdpaTBVSQhlmsVTcEsNQbV4=@pm.me>
In-Reply-To: <FnnOUuDMmf0SebqA1bb0fQIW4vguOZ-VcAlPnPMnmT2lJYxMMxFAhcgh77px8MsPS5Fr01I0YQxLJClEJTFWHdpaTBVSQhlmsVTcEsNQbV4=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jul 2024 13:02:50 -0700
Message-ID: <CAEf4BzaN7b6N3Qb_hrb-Abq=gbB=fSHho-nx+H3MSvpARXQoWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for test objects
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	patchwork-bot+netdevbpf@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 12:25=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me=
> wrote:
>
> Andrii,
>
> I looked over the v4 of the patch, and apparently I messed it up by
> losing the v1 -> v2 change. So the issue with dump order of %.test.d
> relative to %.test.o files is present on the master branch right now.
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 74f829952..4bcb1d1ce 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -596,7 +596,7 @@ endif
>  # Note: we cd into output directory to ensure embedded BPF object is fou=
nd
>  $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:                      \
>                       $(TRUNNER_TESTS_DIR)/%.c                          \
> -                     $(TRUNNER_OUTPUT)/%.test.d
> +                     | $(TRUNNER_OUTPUT)/%.test.d
>         $$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
>         $(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/=
$$< $$(LDLIBS) -o $$(@F)
>
> I can send this fix together with the condition for the clean targets
> (so [1] can be discarded); or I can submit a separate change. Let me
> know what you'd prefer.

Send it separately, if that fix is good, I'll just apply it as is?

>
>
> I also had a discussion with Eduard off-list, he suggested trying to
> remove explicit %.test.d targets altogether like this:
>
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 05b234248b38..f01dc1cc8af8 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -596,18 +596,12 @@ endif
> >  # Note: we cd into output directory to ensure embedded BPF object is f=
ound
> >  $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:                    \
> >                     $(TRUNNER_TESTS_DIR)/%.c                          \
> > -                   $(TRUNNER_OUTPUT)/%.test.d
> > +                   | $(TRUNNER_BPF_SKELS)                            \
> > +                     $(TRUNNER_BPF_LSKELS)                           \
> > +                     $(TRUNNER_BPF_SKELS_LINKED)

shouldn't we also have a dependency on libbpf.a here as well, then? So
that all the auto-generated headers are autogenerated.

> >       $$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
> >       $(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/=
$$< $$(LDLIBS) -o $$(@F)
> >
> > -$(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.d:             =
         \
> > -                         $(TRUNNER_TESTS_DIR)/%.c                    \
> > -                         $(TRUNNER_EXTRA_HDRS)                       \
> > -                         $(TRUNNER_BPF_SKELS)                        \
> > -                         $(TRUNNER_BPF_LSKELS)                       \
> > -                         $(TRUNNER_BPF_SKELS_LINKED)                 \
> > -                         $$(BPFOBJ) | $(TRUNNER_OUTPUT)
> > -
> >  include $(wildcard $(TRUNNER_TEST_OBJS:.o=3D.d))
> >
> >  $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:                         =
       \
> > --
> > 2.45.2
>
> This works almost as we want it, except for a situation when any
> %.test.d gets deleted (say, due to local branch switch). In such case,
> if one forgets to run `make clean`, there is no dependency of the
> %.test.o on skels, and so they won't be properly updated.
>
> After some discussion, me and Ed concluded that we shouldn't expect
> people to remember to do clean in particular situations, especially if
> consequences are not obvious. So the state after the suggested fixes
> would be good enough.
>

ok

> [1] http://lore.kernel.org/K69Y8OKMLXBWR0dtOfsC4J46-HxeQfvqoFx1CysCm7u19H=
Rx4MB6yAKOFkM6X-KAx2EFuCcCh_9vYWpsgQXnAer8oQ8PMeDEuiRMYECuGH4=3D@pm.me
>
>

