Return-Path: <bpf+bounces-27929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC68B3A57
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 16:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9B91F2488C
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C228A14883E;
	Fri, 26 Apr 2024 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2qB74Pv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEF13D2A7
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142853; cv=none; b=uWt+Em41Rm7RigoGn9Xb0x4SLDYz/ihTeKLpIy+fuIPvswtRfWoAPHXwv5goscbNAZPzAAYcurpc+S7bNaM9DZ61ODVxvJWWmM65c8q2HdQ1YCUdszbTcPnJEn2WeMbkfjQgEZHdny1iq32880M/9U3jBIX0dDwuMs5aspmLbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142853; c=relaxed/simple;
	bh=nTUusPkjCwn42ZO0qL6kybe1/ca0i8OoJtbtdnDweRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYCJuOmNz9QISMV7TMuyaIeng8a5uZ24+zW59q8LVR9SPwvKjpgT9t2+nbcWazNvWnG5Tibu/FCU7e3ih+VMs6pevtthKMSOoDbcnZ9YlMDuVZb2DjCLhWHJWs0y0oTVt4UrFa5kkmdZN3csnw/CM9QjhzmF0y8+/1UbZjJtlCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2qB74Pv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34af8b880e8so1440335f8f.0
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714142849; x=1714747649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79mj8aqU9m+90YLb8/ct35J+/ooGSCtVtR0NRll9Lng=;
        b=j2qB74PvpCCL5WTchLk2QyLBnr1KbR3Cd6XLSo9pRwgAa7ya0TqNGPqobjo2Olrk2l
         ycRCB3dkHFxR8ifnK80snCDTUC/KFtrjZ5lwVGKe35LwBtodoNTQWG6afxW63rYg1TtA
         yVxO8SFmCUq+gWUqJEE89O7WsWksqyTlYZgOykMynUa5jJvLa0aaNs7tW2UMTPL6kEA1
         dNi/dcgsuUJrGoVIpqqWYRbFXK5KYUggDamS/FQEMPj/N3m3doCvHNLJ+tkg2t29BBop
         51VRjzYXQUUS8I4NK6IF7gbbEQ/37VdofQp6zWUtzSYWqp6MqSgZnohdfnQgHzYbRvwT
         bCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714142849; x=1714747649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79mj8aqU9m+90YLb8/ct35J+/ooGSCtVtR0NRll9Lng=;
        b=OZ0AYjsOoGjR/jCAsNwAvuWbV0AeSjsjM9fF1cscV7qK8zWKR2hzsWIbCe4BsD5VO3
         Bx7gpsjGHO08jOUiUCD7Dzak+lY5hDaqskEG4BEgsQ/KbaSrF0aHnjBfB14tgXj1z72G
         Z5EyDJfLe6+gOiZljnQTnIf95oqbge+DH3TUrExzePXO3I4E7NzIIJ2lp6O+6D3u1N2S
         qQPsI1hWFg+ycdNbXVAFGREZbn+ws7A2EZrldDrD4rnbb0AdykSBS04+k0nqV9S8I0Jr
         7gNi2awwsmnCqQoY7gynDVrcyzDWfKUqBdIWxECcJ9snegle9QV/uRNWQld6Hx8G1pN/
         xO8w==
X-Forwarded-Encrypted: i=1; AJvYcCWOczYykRoIoWLDy3rCJ9puljPmC52EPRD9rXD9qsZ2FihP/OTp8z6uMBaOSolb/yVpVfPF+ziduipZvSuA68h73VXf
X-Gm-Message-State: AOJu0Yw0BvenGqYkIV6Tuv2bYoyb4UmC7xVutqn8m1VqYYSRwMR+Cx7c
	BStxsGMbQXuQl5kP3sdMfQTvF+HOpXQcLi04tLEztPvxS7MT6Yxz5/C/HV/nyCiwqz6ig4qYIHg
	2PcVRz5bgABBjuzBnRvYsB7OoYBo=
X-Google-Smtp-Source: AGHT+IHIiiww2NdjEopf0LTsPm/LXOTqFV0H0C43KX9DEeAU+SiHBwtirXOVn8vRSZZBYZ5E8aCiA+bXEkQmFTgXJGc=
X-Received: by 2002:a05:6000:1374:b0:34c:348:cd0d with SMTP id
 q20-20020a056000137400b0034c0348cd0dmr3038618wrz.3.1714142848926; Fri, 26 Apr
 2024 07:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424084141.31298-1-jose.marchesi@oracle.com>
 <744420fb-4b2b-44c8-9e35-1ffd9f086fd9@linux.dev> <87v8465u8p.fsf@oracle.com>
 <CAADnVQJzLzrxtHeVcpNBtb-rnwWfApFEy_kv7LzWDee4pH1ezQ@mail.gmail.com>
 <87a5lh4o7r.fsf@oracle.com> <CAADnVQJJtNc=kqPby5bckOHzUFzdn_mD57c=0U7iyD23yrpKCQ@mail.gmail.com>
 <87wmok1903.fsf@oracle.com>
In-Reply-To: <87wmok1903.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Apr 2024 07:47:17 -0700
Message-ID: <CAADnVQJnQL+wLa5S6QnxSa47DK--uB5bgu8qNPcNW3sBZ6ukdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add a few more options for GCC_BPF in selftests/bpf/Makefile
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, Manu Bretelle <chantra@meta.com>, 
	Mykola Lysenko <mykolal@meta.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>, David Faust <david.faust@oracle.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, indu.bhagat@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 7:41=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > On Thu, Apr 25, 2024 at 5:32=E2=80=AFAM Jose E. Marchesi
> > <jose.marchesi@oracle.com> wrote:
> >>
> >>
> >> > On Wed, Apr 24, 2024 at 2:30=E2=80=AFPM Jose E. Marchesi
> >> > <jose.marchesi@oracle.com> wrote:
> >> >>
> >> >>
> >> >> Hi Yonghong.
> >> >>
> >> >> > On 4/24/24 1:41 AM, Jose E. Marchesi wrote:
> >> >> >> This little patch modifies selftests/bpf/Makefile so it passes t=
he
> >> >> >> following extra options when invoking gcc-bpf:
> >> >> >>
> >> >> >>   -gbtf
> >> >> >>     This makes GCC to emit BTF debug info in .BTF and .BTF.ext.
> >> >> >
> >> >> > Could we do if '-g' is specified, for bpf program,
> >> >> > btf will be automatically generated?
> >> >>
> >> >> Hmm, in principle I wouldn't oppose for -g to mean -gbtf instead of
> >> >> -gdwarf.  DWARF can always be generated by using -gdwarf.
> >> >>
> >> >> Faust, Indu, WDYT?
> >> >>
> >> >> >>
> >> >> >>   -mco-re
> >> >> >>     This tells GCC to generate CO-RE relocations in .BTF.ext.
> >> >> >
> >> >> > Can we make this default? That is, remove -mco-re option. I
> >> >> > can imagine for any serious bpf program, co-re is a must.
> >> >>
> >> >> CO-RE depends on BTF.  So I understand the above as making -mco-re =
the
> >> >> default if BTF is generated, i.e. if -gbtf (or -g with the modifica=
tion
> >> >> above) are specified.  Isn't that what clang does?  Am I interpreti=
ng
> >> >> correctly?
> >> >>
> >> >> >>
> >> >> >>   -masm=3Dpseudoc
> >> >> >>     This tells GCC to emit BPF assembler using the pseudo-c synt=
ax.
> >> >> >
> >> >> > Can we make it the other way round such that -masm=3Dpseudoc is
> >> >> > the default? You can have an option e.g., -masm=3Dnon-pseudoc,
> >> >> > for the other format?
> >> >>
> >> >> We could add a configure-time build option:
> >> >>
> >> >>   --with-bpf-default-asm-syntax=3D{pseudoc,normal}
> >> >>
> >> >> so that GCC can be built to use whatever selected syntax as default=
.
> >> >> Distros and people can then decide what to do.
> >> >
> >> > distros just ship stuff.
> >> > It's our job to pick good defaults.
> >>
> >> Yeah it was a rather dumb idea that would only complicate things for n=
o
> >> good reason.
> >>
> >> The unfortunate fact is that at this point the kernel headers that
> >> almost all BPF programs use contain pseudo-C inline assembly and havin=
g
> >> the toolchain using the conventional assembly syntax by default would
> >> force users to specify the command-line option explicitly, which is a
> >> great PITA.  So I guess this is one of these situations where the wors=
e
> >> option is indeed the best default, in practical terms.
> >>
> >> So ok, as much as it sucks we will make -masm=3Dpseudoc the default in=
 GCC
> >> for the sake of practicality.
> >>
> >> > I agree with Yonghong that -g should imply -gbtf for bpf target
> >> > and -mco-re doesn't need to be a flag at all.
> >>
> >> We like the idea of -g implying -gbtf rather than -gdwarf for the BPF
> >> target.  It makes sense.  Faust is already working on it.
> >>
> >> As for -mco-re, it is already the default with -gbtf, and now it will =
be
> >> the default for -g.
> >>
> >> > Compiler should do it when it sees those special attributes in C cod=
e.
> >> > -masm=3Dpseudoc is a good default as well, since that's what
> >> > everyone in bpf community is used to.
> >>
> >> We will try to get all the changes above upstream before GCC 14 gets
> >> branched, which shall happen any day now.  Once they are in GCC the on=
ly
> >> extra option to be added to GCC_BPF_BUILD_RULE will be -g.  Will send =
an
> >> updated patch then.
> >
> > Awesome. This is all great to hear.
>
> The GCC 14 release branch was created today, but we managed to get the
> changes for -g and default to pseudo-C just in time.

Nice. Pls let us know when mirrors/packages are ready, so we teach CI
to start using gcc-bpf.

