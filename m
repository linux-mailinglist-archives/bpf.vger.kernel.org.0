Return-Path: <bpf+bounces-69791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B810BBA1ED7
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 01:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D21B625ED9
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 23:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA9E2ECD01;
	Thu, 25 Sep 2025 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3gMf2gc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FEB2EB5CB
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841666; cv=none; b=hrQUTsVJApQ2uX5SE5WoCnB236SrTSQMyjc8BnY+3bRZJjXDku/gfnmhWSfu6JjIHigmw9OuLkSGyqD5NFc9nyrMukoRKsxgJyVOrmrI5q+sED3Z17hx2KeZaiI5iL9gP8kRnuSVczrC35hR9hlqpUwdUCYWED63mlnGAPK5rJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841666; c=relaxed/simple;
	bh=1O/3QW9Bo8enlcammiBNt10RN7XU2tCfL0QONEK69Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyFR+QCC/iVnbuznxMqrL4S80dS8qRS5N4qFkg2Pkw7v6eeii8/gD0SNq5+S41oL9dyvQoLAvdAe1OW7x2ym+K+xxqz5P1G0WVR99DxNQEiC3mj/Y1qIWX8hagRZxwrSCddAP4LIjio7nM49oeLa7Xvgw+ri0Syx+iWZcneG0IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3gMf2gc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2570bf605b1so17056105ad.2
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758841664; x=1759446464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O/3QW9Bo8enlcammiBNt10RN7XU2tCfL0QONEK69Yg=;
        b=V3gMf2gceZ/qwZkzGLEJaSKfjmrMz2xBthsMhLB1Z/b2uxS3+WdRnm0QEmHXkPMtGS
         SdYWNsyqDYBj2BxKXFuykYi6eGTSb5G4cmWSk/EVCdHhZExeyR0e5x0XunyDhZwI32sy
         F2SB1CukMCH4VRd3i9j3M+u7KHETUFxz8P6FVdKzAaV/GdNjMhqEhXD35zj5ER00DNEW
         Cy+agiHKVfR4RLCqk19BOxkIIpmFXMppL0VeNUPoCdfWcBbFJ7hB9M1TGd3WFU1j9x7j
         3rFK2uSCvDaifXfc/Xbz7iqKtuu2ByzYxQwFvv1kczaoxUG6m05ncGakeW1eumW5yCzg
         p1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841664; x=1759446464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O/3QW9Bo8enlcammiBNt10RN7XU2tCfL0QONEK69Yg=;
        b=Fc4HCVpw7hh757oObja4wwfXS8o/A61+dfw5wmHhc04WfMiAoincCSvySJON0s2qvb
         qoAE4QHi96+JWYk5u88iGd/LUV46ccFwzzTS8wzPF/Ycyw5rqRRLyZCONgkWtuut8AoJ
         oPms8NG1di26Nw/E00oHuhEE5K1T1J2emCB8Z7L8I/jMlMNDlHUfAjGVlAyeJi2ai9Ns
         uNW8Knfws54zimb44eGYIa/jSMjQIlVanYYua7/AHljegwSkmWBpi7hdph8/3PIk5JI6
         zvsUd+NMIO8YQtCdpW+qES++IoV52DRvaYhnh3OEAE5fLvABSaK/tzbua36SXLdsyn+Q
         k9og==
X-Forwarded-Encrypted: i=1; AJvYcCUt8Y3vb++OFZhoPhNbK3E3P8MJtz5B2rl8rGelJ0Y06+618eNrn6crpVMY+JMmx3Ce6FY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/1JEKJ9geL2S6U/NW6juwUE3OgrOmvjemo4NZoCcoWCMOCeaP
	DlCsaIAhZet3ZY+Gw04RNGcl6OCPPdeLlg71B0tx0xNL5vPL1+yaGCfCtnO3HqI4Dp7FfJJAjO2
	6rHCLECB+DOWHe0Jaa5cPyzuZrqYleeQ=
X-Gm-Gg: ASbGnctw9GblNIRgOz1nK0B6RPTrDY2UQeTRu1rYKSd46xfr9OjrlD6tD4GgmkTdoU1
	T3YrByBz3RiANbkwNpBoy03daM/Ko+QFDJXo4a3DkSUScoQVdBsF/5WIpxdlOdRG1x7VZY6F5IB
	x3doyutG0Q3YvDWK9uRzc92TktxvhRNxFlCT5eUNeZLWhhQho2XSlsYUUcCwJgVtmHvx5XybsV8
	z3o5EIC8LkIf+aWdwfaTSM=
X-Google-Smtp-Source: AGHT+IEH5cefaUkqKIf2ymoWpciMaPkvwaRrN3bUmRLSiEMn3NZ0VhbVW6Zdg4yuXstIds2Efuuiqw0hY1HoR/Yv4Fw=
X-Received: by 2002:a17:903:2c0d:b0:275:27ab:f6c4 with SMTP id
 d9443c01a7336-27ed4a315b5mr58511205ad.33.1758841664495; Thu, 25 Sep 2025
 16:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-2-ihor.solodrai@linux.dev> <CAADnVQLvuubey0A0Fk=bzN-=JG2UUQHRqBijZpuvqMQ+xy4W4g@mail.gmail.com>
 <6a6403ec-166a-4d48-8bf5-f43ae1759e5f@linux.dev> <CAEf4BzbYXADoUge5C7zhzZAEDESE7YJFwW_jO4-F5L3j-bwPMw@mail.gmail.com>
 <CAADnVQL+28vPquMgw+hZMT1P6NkE5jLUXf=HDNj65N9np1rgfw@mail.gmail.com>
 <CAEf4BzYm=dTqT=Aj-=Jg=n8AtcxZL1CiQiY5mVbUNA-pesz=sQ@mail.gmail.com> <CAP01T74_ZfQtHTsBmjNsGnuB4TeTTqqw2BOb8=3od6znS8XtQg@mail.gmail.com>
In-Reply-To: <CAP01T74_ZfQtHTsBmjNsGnuB4TeTTqqw2BOb8=3od6znS8XtQg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 16:07:30 -0700
X-Gm-Features: AS18NWCTAJb9fEnMfMCNx4DEDOxdjvv0SIXpwgoyHl12LxtlFRKXxY_taxwKBoM
Message-ID: <CAEf4BzY1g1svHDfQu8UmauTerWLMEk=OMWKO-f9HSe7tfB1arA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Eduard <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	dwarves <dwarves@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 3:58=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 26 Sept 2025 at 00:54, Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Sep 25, 2025 at 12:35=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Sep 25, 2025 at 6:23=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > I do see the benefit of having the generic "KF_MAGIC_ARG(s)" flag o=
n
> > > > the kernel side of things and having access to full BTF information
> > > > for parameters to let verifier know what specific kind of magic
> > > > argument that kfunc has, though. So as an alternative, maybe we can
> > > > create both a kfunc definition *meant for BPF programs* (i.e., with=
out
> > > > magic argument(s)), and then have a full original definition (produ=
ced
> > > > by pahole, it will need to understand KF_MAGIC_ARGS anyways) with f=
ull
> > > > type information *for internal BPF verifier needs*. I don't know
> > > > what's the best way to do that, maybe just a special ".magic" suffi=
x,
> > > > just to let the verifier easily find that? On the kernel side, if
> > > > kfunc has BPF_MAGIC_ARGS kflag we just look up "my_fancy_kfunc.magi=
c"
> > > > FUNC definition?
> > >
> > > Interesting idea. Maybe to simplify backward compat the pahole can
> > > emit two BTFs: kfunc_foo(args), kfunc_foo_impl(args, void *aux)
> > > into vmlinux BTF.
> > > bpftool will emit both in vmlinux.h and bpf side doesn't need to chan=
ge.
> > > libbpf doesn't need to change either.
> > > The verifier would need a special check to resolve two kfunc BTFs
> > > name into one kallsym name, since both kfuncs is one actual function
> > > on the kernel.
> > > bpf_wq_set_callback_impl() definition doesn't change. Only:
> > > -BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
> > > +BTF_ID_FLAGS(func, bpf_wq_set_callback_impl, KF_PROG_ARG)
> > >
> > > and the verifier can check that the last arg is aux__prog when
> > > KF_PROG_ARG is specified.
> > >
> > > The runtime performance will be slightly better too, since
> > > no need for wrappers like:
> > >
> > > +__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> > > + int (callback_fn)(void *map, int *key, void *value),
> > > + unsigned int flags,
> > > + void *aux__prog)
> > > +{
> > > + return bpf_wq_set_callback(wq, callback_fn, flags, aux__prog);
> > > +}
> > >
> > > It's just one jmpl insn, but still.
> >
> > So basically xxx_impl() will be a phantom function that verifier will
> > recognize and it will need to have corresponding xxx() kfunc with
> > corresponding KF_PROG_ARG for everything to work. Makes sense.
> >
> > Two notes:
> >
> > a) KF flag would need to be more generically named, because we'll have
> > other implicit arguments (like those for bpf_obj_new_impl, for
> > example), which will be distinguished based on their BTF type
> >
> > b) bpf_stream_vprintk() throws a bit of a wrench into all this because
> > it doesn't follow _impl naming convention. Any suggestions on how to
> > deal with that?
>
> We can probably do a compat break for this kfunc alone for now, it's
> not been a long time since it's been out (1 release) not much adoption
> yet.

Ideally there would be 0 releases with that name :) it's just
tantalizing that we can s/bpf_stream_vprintk/bpf_stream_vprintk_impl/
in like 8 places and avoid this altogether, but it is so late in the
release that I suspect no one will want to do this last minute "fix".

> And then double down on this convention going forward.
>
> >

