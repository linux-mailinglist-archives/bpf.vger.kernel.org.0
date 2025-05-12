Return-Path: <bpf+bounces-58055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AD3AB4694
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 23:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D658C480F
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 21:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF40F13CF9C;
	Mon, 12 May 2025 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff+svh/l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2F17A2E8
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747085745; cv=none; b=pu/snULv0vNLjlBMX6tvx7fP5mTX5S7F94kotSPET1QCtY/1XP4bnVb7dyrsmEKrCZENNpJKYRi2HW0SXrMe3lJDQJcXkM4ALsvjw1uG4CkPEXUKig5PKFiC9zmyvFjiFPbNvt4tWH0rjuPHGWrcLpak/+XMp5fuRYCDtdAJLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747085745; c=relaxed/simple;
	bh=Lp5tHzlvC4xiFFx2gOL6pZ3x2NRhtog5qH/Z0oEBmD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3hNZH3uPXBuVbFEDoFA0/v7yabV1srSzbX7Q+ex571XMQgNLOC4BSFVevaEZBVMt0o8dI+WmGOBT/Bws+01xnjNlROMRReNWs8L+h4Be+OLCCcusdfEetOYDZ6TcX7ONP4i6Gy+Ig0cfPWGwllyrrE68h2j+uRy9v/r4nMPp38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ff+svh/l; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7423fb98cb1so3137202b3a.3
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747085743; x=1747690543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBfQ8+7ow1MneNzL30mYznfNG6lVGEEKWGWyM08neck=;
        b=ff+svh/lEIco7eip824yAUbBGTuk0uAMf3m1KyspoKzpYhiOL9maiaAGvyxOP+2NS+
         bJArPblk1OfJDSqut91A17WmNWaHsW/X4B79Z1YYz3hVRAN69haWoN3vJ1RL1p473IBI
         9UvgPXz5Rkt1utsVfjt4SjuSx72DvkQiN2tByJr0czv4rF6qXv7YKpZrf2DmU1dZ+wy2
         bxH8daEJ9t5UzQgCyyaBaYxm4IVvenqkTX6rNYM1M+F8Sx5mjCWWOxFV/zDI9+qfoFn4
         l+jmjhOMcQqN+rKig57kdTsqcop+oIDneyHk2TXQKr1e6Q3ngLSmlJfBhqipyrryocB0
         qDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747085743; x=1747690543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBfQ8+7ow1MneNzL30mYznfNG6lVGEEKWGWyM08neck=;
        b=FckPqJ5mvrVlPkHLd4i5843TzFjDQX+ujl5u4vzTV0nGDVAxlNn0RgIrB++JOLsXwl
         3wCD2TsO3U5Q4zqfo9kcc7EmQPXUzbtoMYxoEbKfajtzaRCHiHQ4dniz7UP6NpAZkYmC
         xMUs39DvRakk7qeMQk3Zxc1yQ9MfbG6UN8EQtm+Ik0/03Fl6exnFNJUbPuM2yYailTbM
         mnZDeStW3IvWK+diSzmX1AxJgtAAWHeYWaj4rYPYQ+O1AUl/cy+8RRXlnZCpz2GLas1o
         P41xpnRTgFVUjc5psrRRUtKRE6G/vZM399aX+lKABiqCPS+3SMiO/3lc56yUSKQpvDDJ
         pTaA==
X-Forwarded-Encrypted: i=1; AJvYcCXeKVnXQM6/hDF9fNUUP2COIkvAfFZzAdjjrRp0F+nP+18qd7Qm94vYVwqKdAndCec9IFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvAQt9N4wv5E9/x3QIKbag/PCOU0YHoLgUv/mn8icmM6fq+5N7
	HPKzVtrVs44w25x7kdEUZonok6jRkvt4/MPl6+geGIu4frIbOKWOpsvamIVSRDqNPyeJu4aWj1M
	9Hw+Knof3YwHDElCKaZYyDHbaLas=
X-Gm-Gg: ASbGnctlD3Z588Gk3iwnLEdSgT5wuHNTgCnamk0XME4cqwT5uK0fwldqh8H1ZvNX/+Z
	N3VPBOdM7Nkef8KV+Ng7AHHnzi45svqms2C6mEnerPsbxJZCbKJ2sWaSuzfYbLMtIICjWJ0uSg6
	ZIPQrDs5s/Y3JFQRflooUJ1PjqS+3tNLcxEYsgEr6uC9mmCTgH
X-Google-Smtp-Source: AGHT+IFlazh6E6p8FebVovYy8VMwQLDd0w83+h7b+qCkFnMZesymS+PX+k4FbqiZ66MoWX7i60jO+tReUhEMzphgf10=
X-Received: by 2002:a17:90b:3908:b0:2fe:99cf:f566 with SMTP id
 98e67ed59e1d1-30c3cefe5cfmr22894454a91.13.1747085743015; Mon, 12 May 2025
 14:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-11-memxor@gmail.com>
 <04332abfa1e08376c10c2830373638d545fba180.camel@gmail.com>
 <CAADnVQKN2S=yb_7NUO8bsu+7CxnaGyTML6gKcPS61EnCZtvG5g@mail.gmail.com>
 <9f417b403ef541af5bc8497897e4fbf88bd4023f.camel@gmail.com>
 <CAADnVQLOjzmhf1d81Nr9n0zXL1hj7CGeG5_8BySuNY0HxYanSg@mail.gmail.com>
 <CAEf4BzanV6=_HHVVNxC1Vfsg6R7XYPxsCdEqVXsyBvA4zrGzbw@mail.gmail.com> <CAP01T75+6RsdyWXEQNcvPrZnZmH_Ykga5Km4hOgQShVgS2-rLQ@mail.gmail.com>
In-Reply-To: <CAP01T75+6RsdyWXEQNcvPrZnZmH_Ykga5Km4hOgQShVgS2-rLQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 May 2025 14:35:29 -0700
X-Gm-Features: AX0GCFvfZUhZxCqDkVmcPdbyxOe1OrroGmgJcvc2hqhRj4pN2DIQV29vFB5tKq0
Message-ID: <CAEf4BzbLR-vhq6_g9DOj6AhkpGOXCNE_88APKAmqieEDqzEnhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping streams
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 1:51=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 9 May 2025 at 17:33, Andrii Nakryiko <andrii.nakryiko@gmail.com> =
wrote:
> >
> > On Fri, May 9, 2025 at 11:48=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, May 9, 2025 at 11:31=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > > On Fri, 2025-05-09 at 10:31 -0700, Alexei Starovoitov wrote:
> > > >
> > > > [...]
> > > >
> > > > > How about we extend BPF_OBJ_GET_INFO_BY_FD to return stream data?
> > > > > Or add a new command ?
> > > >
> > > > You mean like this:
> > > >
> > > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/li=
nux/bpf.h
> > > > index 71d5ac83cf5d..25ac28d11af5 100644
> > > > --- a/tools/include/uapi/linux/bpf.h
> > > > +++ b/tools/include/uapi/linux/bpf.h
> > > > @@ -6610,6 +6610,10 @@ struct bpf_prog_info {
> > > >         __u32 verified_insns;
> > > >         __u32 attach_btf_obj_id;
> > > >         __u32 attach_btf_id;
> > > > +       __u32 stdout_len; /* length of the buffer passed in 'stdout=
' */
> > > > +       __u32 stderr_len; /* length of the buffer passed in 'stderr=
' */
> > > > +       __aligned_u64 stdout;
> > > > +       __aligned_u64 stderr;
> > > >  } __attribute__((aligned(8)));
> > > >
> > > > And return -EAGAIN if there is more data to read?
> > >
> > > Exactly.
> > > The only concern that all other __aligned_u64 will probably be zero,
> > > but kernel will still fill in all other non-pointer fields and
> > > that information will be re-populated again and again,
> > > so new command might be cleaner.
> >
> > +1, but I'd allow reading only either stdout or stderr per each
> > command invocation to keep things simple API-wise (e.g., which stream
> > got EAGAIN, if you asked for both?) I haven't read carefully enough to
> > know if we'll allow creating custom streams beyond stderr/stdout, but
> > this would scale to that more naturally as well.
> >
>
> What's your preference/concerns re: pseudo files in sysfs?
> That does seem like it would be simplest for someone using this
> (read() on a file vs special BPF syscall).

sysfs approach seems fine to me, not sure I have any concerns

>
> >
> >
> > >
> > > > Imo, having this in syscall is more convenient for the end users.
> > > >
> > > > Alternatively, are files in bpffs considered to be stable API?
> > > > E.g. having something like /sys/fs/bpf/<prog-id>/std{err,out} .
> > >
> > > yeah. Ideally the user would just 'cat /sys/.../stdout',
> > > but we don't auto create pseudo files when progs are loaded.
> > > Maybe we should.
> > > 'bpftool prog show' will become 'ls' in some directory.

