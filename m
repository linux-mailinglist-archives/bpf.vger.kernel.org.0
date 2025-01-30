Return-Path: <bpf+bounces-50123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05C9A230CD
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 16:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2EE3A4EA8
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2D11EBA0D;
	Thu, 30 Jan 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGu1W6Ia"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5331E9B37;
	Thu, 30 Jan 2025 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738249556; cv=none; b=ZSdwI0fayw2TqEedbxxl7ycOYDqRoTXjqSAqdYydxV65HK9KI/HKuAijV71fJet3FOa4KtzW4gR/3YfFkrwlvXWLr3oWx4ZmfZk7nmNDy0zxfdr4/dAX0FIWVyBgcUmnYE5M9lbYho72RQdI2bw36Ha3/agFf0ecS+dy0VgA7e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738249556; c=relaxed/simple;
	bh=UzPOvN+QpHN78UMPLisEGiii/yIhWTrX8w3eeaX30BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDLIEhGT4uoJwNnl4k4HC/SFz8mmJ5dvDHvO3ZJHVchhkdWNPhxaFDwp2yD1YWo1Fjp+OikDrfeLYTdR7o44DzUkl4F72/rZbHkt6u/sD6IFI0p/KvxpIfq+BDoB9k6aCBYClbwgo1qVpqxjjlaWnnC9R+dnpxlfxFMXKtGsNzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGu1W6Ia; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29e70c9dc72so582342fac.0;
        Thu, 30 Jan 2025 07:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738249553; x=1738854353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHLolQsZ2zlhGRc6ypaKnmQFnYcZDwNFc2rA1pE2dUY=;
        b=ZGu1W6IawBe8GzO91xEE3nf2ySt9h+9HVmimhgcBO8Go4vAh7pwJlZwq+R85RbIC8l
         eNJBPcxEprjpmYmiUYE6ZAvlDm3xbXsxdz39wg9WAExz0g7CTh4s5N+l2AujLPnz60xB
         UnL6j9TqlIY9GcqQb/zuGn4Ybundud5Paxezs3LwYX2/nP757+D+7iponpbLfNk4SH/N
         POKfTPTJh/ygi844+p+q0sl/gpVq4sFYQfFHRfJ9ikdEp3zKzeaxsB4xm/qFD4Y0ZKCF
         dsH9p6JmS8uX9HFYpfKcLnQVydVckYZMgOwoY4wh5zOkh/Mj7evJGEMdbxP1UVf/aKRs
         s5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738249553; x=1738854353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHLolQsZ2zlhGRc6ypaKnmQFnYcZDwNFc2rA1pE2dUY=;
        b=Oczd9yJ9Kssvbc7mT92mYJLo5gMmRrmNhOTE6Dc4UEl5mdR0QKCB91LOH9FJW3iRNd
         ktYsMiV+4RnciKMMzN9n0mw0bDJfDUKnbtL3UokGFHb9aTuRWhpm/dwi1TS96T1fXrPS
         ArXyQFETkOVE4bVrjiHGCD0jtFbEOdkj6G4TWumPMHLITTQfMwRnsX3DQW/lUKY1K0MP
         MyKYcWujfnPVuG5i2+hdhZ4/TV4mEsTL3+8brD2Ma3z+nhqrVo7v6cyH3JHQIJ28YZO3
         tPeNeM34dxuAlpfCHSS2zFqGBT92pRa21Wz6oT2VYpKk05o9gdzc96z120Gn5VsLvL2I
         a/RA==
X-Forwarded-Encrypted: i=1; AJvYcCUgNaliIBdtUB/y6DoVKKqSdL5r1i8hw6flNn1kX3866Puc+9wTh0BeusUCYQqEPSfZVN+hIP11gb1J@vger.kernel.org, AJvYcCVDd7uRHTKj2v6GFAM1MYJtRtI8LmpyF4tl/EptaXC3+kJmc11QG1Ji2qIs+tUDlaZETRA=@vger.kernel.org, AJvYcCWbcnICGlRo6BY99FioANvRnhwN1b0iYFZLQd1gFiUx7qNdHuMJzn7m78brcEbBJpmLefHsBipk@vger.kernel.org, AJvYcCX+NJzNy9AoDkNr+Gt6CqSigEenM9tNZ0Fn1+t+cW7gLEdH1Qx7kyIIF50MGTL++Cf3NzelRoK0rc1c6UKPqJCF69lV@vger.kernel.org, AJvYcCXHXQKRnDhsV+D815TniQ8cMAWUz7wYxbuYzV3SnnNdEanLKaHAiAA5tNtfzW57zv8fPlZ92Y/9eHnFIhAT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnfd1DvK2w5TD3N50dO5Ti7kw+wJTREmDSK0HUsyzpJI/5vngK
	nPsmKVx8+Wk5sUImV4Rj4iQp3a9Ebn5C1NOFU0w5lzvF+/XV6TXX7Ehxi+EbbgeigK9G1HGBCRz
	Wq8yk/lZTFXRr6U72QCsEyNcsE5c=
X-Gm-Gg: ASbGncs/D5lDQ6/GnarQQua5kSbV3WC1eypROZciOx5PLe4c6CtRbwGTHV82FfVE97k
	B4synv6S+Jw3exOaW0GTd6YK6LD+c7XNtsk923XMFdOIcIIKjUdqDphM5Ledg+8p/E7O78w/2
X-Google-Smtp-Source: AGHT+IGwWbz4A9cAN6NUern7dANMSvQ3zxnrtwfKoZS9UDwPuqVpZ21D56igh9I6qthewqT7OwDZiANpe+moDbvsPUk=
X-Received: by 2002:a05:6870:17a2:b0:29d:c86b:cdec with SMTP id
 586e51a60fabf-2b32f37097emr5262216fac.29.1738249552982; Thu, 30 Jan 2025
 07:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
 <202501281634.7F398CEA87@keescook> <CAHsH6Gsv3DB0O5oiEDsf2+Go4O1+tnKm-Ab0QPyohKSaroSxxA@mail.gmail.com>
 <Z5s3S5X8FYJDAHfR@krava>
In-Reply-To: <Z5s3S5X8FYJDAHfR@krava>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 30 Jan 2025 07:05:42 -0800
X-Gm-Features: AWEUYZle5Jz5iPcb2yaCal2ANp1nG2oO_se0ysxDSQIB8pXBm9OhyhcKOHe4XPo
Message-ID: <CAHsH6GvsGbZ4a=-oSpD1j8jx11T=Y4SysAtkzAu+H4_Gh7v3Qg@mail.gmail.com>
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without filtering
To: Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>
Cc: luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	mhiramat@kernel.org, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com, 
	john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de, 
	bp@alien8.de, daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com, 
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com, 
	bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 12:24=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Wed, Jan 29, 2025 at 09:27:49AM -0800, Eyal Birger wrote:
> > Hi,
> >
> > Thanks for the review!
> >
> > On Tue, Jan 28, 2025 at 5:41=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > > On Tue, Jan 28, 2025 at 06:58:06AM -0800, Eyal Birger wrote:
> > > > Note: uretprobe isn't supported in i386 and __NR_ia32_rt_tgsigqueue=
info
> > > > uses the same number as __NR_uretprobe so the syscall isn't forced =
in the
> > > > compat bitmap.
> > >
> > > So a 64-bit tracer cannot use uretprobe on a 32-bit process? Also is
> > > uretprobe strictly an x86_64 feature?
> > >
> >
> > My understanding is that they'd be able to do so, but use the int3 trap
> > instead of the uretprobe syscall.
> >
> > > > [...]
> > > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > > index 385d48293a5f..23b594a68bc0 100644
> > > > --- a/kernel/seccomp.c
> > > > +++ b/kernel/seccomp.c
> > > > @@ -734,13 +734,13 @@ seccomp_prepare_user_filter(const char __user=
 *user_filter)
> > > >
> > > >  #ifdef SECCOMP_ARCH_NATIVE
> > > >  /**
> > > > - * seccomp_is_const_allow - check if filter is constant allow with=
 given data
> > > > + * seccomp_is_filter_const_allow - check if filter is constant all=
ow with given data
> > > >   * @fprog: The BPF programs
> > > >   * @sd: The seccomp data to check against, only syscall number and=
 arch
> > > >   *      number are considered constant.
> > > >   */
> > > > -static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> > > > -                                struct seccomp_data *sd)
> > > > +static bool seccomp_is_filter_const_allow(struct sock_fprog_kern *=
fprog,
> > > > +                                       struct seccomp_data *sd)
> > > >  {
> > > >       unsigned int reg_value =3D 0;
> > > >       unsigned int pc;
> > > > @@ -812,6 +812,21 @@ static bool seccomp_is_const_allow(struct sock=
_fprog_kern *fprog,
> > > >       return false;
> > > >  }
> > > >
> > > > +static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
> > > > +                                struct seccomp_data *sd)
> > > > +{
> > > > +#ifdef __NR_uretprobe
> > > > +     if (sd->nr =3D=3D __NR_uretprobe
> > > > +#ifdef SECCOMP_ARCH_COMPAT
> > > > +         && sd->arch !=3D SECCOMP_ARCH_COMPAT
> > > > +#endif
> > >
> > > I don't like this because it's not future-proof enough. __NR_uretprob=
e
> > > may collide with other syscalls at some point.
> >
> > I'm not sure I got this point.
> >
> > > And if __NR_uretprobe_32
> > > is ever implemented, the seccomp logic will be missing. I think this
> > > will work now and in the future:
> > >
> > > #ifdef __NR_uretprobe
> > > # ifdef SECCOMP_ARCH_COMPAT
> > >         if (sd->arch =3D=3D SECCOMP_ARCH_COMPAT) {
> > > #  ifdef __NR_uretprobe_32
> > >                 if (sd->nr =3D=3D __NR_uretprobe_32)
> > >                         return true;
> > > #  endif
> > >         } else
> > > # endif
> > >         if (sd->nr =3D=3D __NR_uretprobe)
> > >                 return true;
> > > #endif
> >
> > I don't know if implementing uretprobe syscall for compat binaries is
> > planned or makes sense - I'd appreciate Jiri's and others opinion on th=
at.
> > That said, I don't mind adding this code for the sake of future proofin=
g.
>
> as Andrii wrote in the other email ATM it's just strictly x86_64,
> but let's future proof it

Thank you. So I'm ok with using the suggestion above, but more on this belo=
w.

>
> AFAIK there was an attempt to do similar on arm but it did not show
> any speed up
>
> >
> > >
> > > Instead of doing a function rename dance, I think you can just stick
> > > the above into seccomp_is_const_allow() after the WARN().
> >
> > My motivation for the renaming dance was that you mentioned we might ad=
d
> > new syscalls to this as well, so I wanted to avoid cluttering the exist=
ing
> > function which seems to be well defined.
> >
> > >
> > > Also please add a KUnit tests to cover this in
> > > tools/testing/selftests/seccomp/seccomp_bpf.c
> >
> > I think this would mean that this test suite would need to run as
> > privileged. Is that Ok? or maybe it'd be better to have a new suite?
> >
> > > With at least these cases combinations below. Check each of:
> > >
> > >         - not using uretprobe passes
> > >         - using uretprobe passes (and validates that uretprobe did wo=
rk)
> > >
> > > in each of the following conditions:
> > >
> > >         - default-allow filter
> > >         - default-block filter
> > >         - filter explicitly blocking __NR_uretprobe and nothing else
> > >         - filter explicitly allowing __NR_uretprobe (and only other
> > >           required syscalls)
> >
> > Ok.
>
> please let me know if I can help in any way with tests

Thanks! Is there a way to partition this work? I'd appreciate the help
if we can find some way of doing so.

>
> >
> > >
> > > Hm, is uretprobe expected to work on mips? Because if so, you'll need=
 to
> > > do something similar to the mode1 checking in the !SECCOMP_ARCH_NATIV=
E
> > > version of seccomp_cache_check_allow().
> >
> > I don't know if uretprobe syscall is expected to run on mips. Personall=
y
> > I'd avoid adding this dead code.

Jiri, what is your take on this one?

> >
> > >
> > > (You can see why I really dislike having policy baked into seccomp!)
> >
> > I definitely understand :)
> >
> > >
> > > > +        )
> > > > +             return true;
> > > > +#endif
> > > > +
> > > > +     return seccomp_is_filter_const_allow(fprog, sd);
> > > > +}
> > > > +
> > > >  static void seccomp_cache_prepare_bitmap(struct seccomp_filter *sf=
ilter,
> > > >                                        void *bitmap, const void *bi=
tmap_prev,
> > > >                                        size_t bitmap_size, int arch=
)
> > > > @@ -1023,6 +1038,9 @@ static inline void seccomp_log(unsigned long =
syscall, long signr, u32 action,
> > > >   */
> > > >  static const int mode1_syscalls[] =3D {
> > > >       __NR_seccomp_read, __NR_seccomp_write, __NR_seccomp_exit, __N=
R_seccomp_sigreturn,
> > > > +#ifdef __NR_uretprobe
> > > > +     __NR_uretprobe,
> > > > +#endif
> > >
> > > It'd be nice to update mode1_syscalls_32 with __NR_uretprobe_32 even
> > > though it doesn't exist. (Is it _never_ planned to be implemented?) B=
ut
> > > then, maybe the chances of a compat mode1 seccomp process running und=
er
> > > uretprobe is vanishingly small.
>
> no plans for __NR_uretprobe_32 at this point

So if we go with the suggestion above, we'll support the theoretical
__NR_uretprobe_32 for filtered seccomp, but not for strict seccomp, and
that's ok because strict seccomp is less common?

Personally I'd prefer to limit the scope of this fix to the problem we
are aware of, and not possible problems should someone decide to reimplemen=
t
uretprobes on different archs in a different way. Especially as this fix ne=
eds
to be backmerged to stable kernels.
So my personal preference would be to avoid __NR_uretprobe_32 in this patch
and deal with it if it ever gets implemented.

Thoughts and advice appreciated,
Eyal.

