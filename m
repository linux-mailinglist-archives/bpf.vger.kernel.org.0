Return-Path: <bpf+bounces-58048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B362AB45AA
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A6F19E3F68
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 20:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1832980C9;
	Mon, 12 May 2025 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmb4t1+G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94BB22FF37
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083113; cv=none; b=gzv1E98wuoz3hwOk0H8EQX5YbKvcB6LnO9xVFiyNaf874AuO3Q5V7XlfVylnRzakWYpcPkEUIDYjAcGaiATUbQVsqkwXr/OzCkYHLLhoEL17z/fjXYpZTD0kgMQtZDfKSPgCQmegV7o5f0NW6zGeIrGNMGpfmH12IwORsU+rXBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083113; c=relaxed/simple;
	bh=kWyTzcrUDQ30Q2JxwhubwycLFcVaVYh8tTQY7OlGK4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNESi1mgkzwlz8u2o+/gwdwhXepY80aYiz+zfxMdlLtYYXJ1wadMpLOCaBwg165XIRZv/AlmqKkAOtkdR/zCDsKybAgUXK1bz32HTra6LHeN0badMQWDN8Vx782TE8YTD81F4foLhqVLsg9jlsMViU9Zy4m+SnxsDZYb5gLIwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nmb4t1+G; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ad2216ef31cso549675266b.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 13:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747083110; x=1747687910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycyNlVrM/Tdxlkoh5zGba1S+M0aoZYv51Pk1SFHUwDo=;
        b=Nmb4t1+GPvr35qbGFBFGSrWyuHC+tx85jqKG04sfINvBJATJ/xpq8mhTBhUwKKl/PT
         67N4eSrPksIfykxK4ZjwJ0F3UIn6hYZVRlrTSBpb3IwLIhmFsEU0SvtdbRwxGq3TjWNG
         ZkOXtM1qxaJnlthcu8B43Tfxpx+0Gws1EFvuJCSrTPHEkUXegbOlj4wAk7vIFgWkWLkc
         25o1fzknch85B9uyh6DO5HRrYq85PuRWw99txVanZzfgr3+jhcgMyZvQqfpasr3YW/ht
         D4bfzMdiCVqjpOx+/cxI1bxwGkrOV2PXXIUVo9XOt/pXSH9S0ZzTEH7twwFgwk7nGh+B
         yuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747083110; x=1747687910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycyNlVrM/Tdxlkoh5zGba1S+M0aoZYv51Pk1SFHUwDo=;
        b=MrUCRPNe2Xbd4LKS6ay98XwcOYIRz0N8Ihbplj7XkQdFgNLBxebJEXovYGuAQl45wi
         yYpLx+7CSaJ4oUVI4hNy4JrA2a5YrKL+TDYW18bhdUbZA1iADwPvMaIy/NjxBuJhbGgk
         pIviyLtPIVnETX+oAmkW6Lae2ofQYci20BZXwFZe2GPdPHg2e76+4QTFVhnadYG2S4uS
         L7rirE97esEOWHjmEkkyYPwFtV/pxdXN+W7E51IdKtJqpL7ENkvYN5C5Agkz6UqOeuyR
         FLPZFttf+lbySOi1vCJgdf4bB9sB9Nwsh0lFEsCr1zmC4BD/3rG8fND1xjkLFc6AB/4d
         cy9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUguXJIYleOdMOVzHwk3B2SyPTtJZy2DHNcWPqbFNelhuPG+oZZmxD3zwq95Drd1DQTJRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPjYcxY0PCM3SwNmzaeRXQuWWbw72+/ym8I0b/STBl2gVZjNyc
	BaiRaWTnJXbIELQbqMgpbX9yoSQtjNpBqKoQwCu2716LZxC0cC+J5dFULyuqt9pGmthAGqfVjSD
	+Lm+tVSx0oCm8dYxMf9h3jLjKAe4=
X-Gm-Gg: ASbGncseb3zZe2yypwwdcFVVrJkJLtInb0j/XXq3WwjUj6vlZ/8B1bIJY2T0DFJ/eqM
	h90p9JVrac7RPZOuLc8sabyRkMlGIgmcDFLe/oWm8rj9/1xKTMJlbDVg9jIg6fVg5P9/mYc5AkL
	lHB4cvn3mrhR8AboRWWFKPlxNUEr87OsrKExSeQcEcgPEGXwFU
X-Google-Smtp-Source: AGHT+IFh9N93edBA21S6yaz4nsNf3A+PAHhEWBHk8jcbz1d3FiiAwkIWrzTddk/uEq6zcnnRBCRWsO+jDrZOTyTrWos=
X-Received: by 2002:a17:906:794c:b0:ad2:5103:3ab with SMTP id
 a640c23a62f3a-ad2510304e3mr554674166b.51.1747083109837; Mon, 12 May 2025
 13:51:49 -0700 (PDT)
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
 <CAADnVQLOjzmhf1d81Nr9n0zXL1hj7CGeG5_8BySuNY0HxYanSg@mail.gmail.com> <CAEf4BzanV6=_HHVVNxC1Vfsg6R7XYPxsCdEqVXsyBvA4zrGzbw@mail.gmail.com>
In-Reply-To: <CAEf4BzanV6=_HHVVNxC1Vfsg6R7XYPxsCdEqVXsyBvA4zrGzbw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 12 May 2025 16:51:13 -0400
X-Gm-Features: AX0GCFsjakX-2vIBPrjnWNqRmRSYIWH1eHlNu9c8qkcsIBzJ4wyLeckuoWZruiU
Message-ID: <CAP01T75+6RsdyWXEQNcvPrZnZmH_Ykga5Km4hOgQShVgS2-rLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping streams
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 9 May 2025 at 17:33, Andrii Nakryiko <andrii.nakryiko@gmail.com> wr=
ote:
>
> On Fri, May 9, 2025 at 11:48=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, May 9, 2025 at 11:31=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Fri, 2025-05-09 at 10:31 -0700, Alexei Starovoitov wrote:
> > >
> > > [...]
> > >
> > > > How about we extend BPF_OBJ_GET_INFO_BY_FD to return stream data?
> > > > Or add a new command ?
> > >
> > > You mean like this:
> > >
> > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linu=
x/bpf.h
> > > index 71d5ac83cf5d..25ac28d11af5 100644
> > > --- a/tools/include/uapi/linux/bpf.h
> > > +++ b/tools/include/uapi/linux/bpf.h
> > > @@ -6610,6 +6610,10 @@ struct bpf_prog_info {
> > >         __u32 verified_insns;
> > >         __u32 attach_btf_obj_id;
> > >         __u32 attach_btf_id;
> > > +       __u32 stdout_len; /* length of the buffer passed in 'stdout' =
*/
> > > +       __u32 stderr_len; /* length of the buffer passed in 'stderr' =
*/
> > > +       __aligned_u64 stdout;
> > > +       __aligned_u64 stderr;
> > >  } __attribute__((aligned(8)));
> > >
> > > And return -EAGAIN if there is more data to read?
> >
> > Exactly.
> > The only concern that all other __aligned_u64 will probably be zero,
> > but kernel will still fill in all other non-pointer fields and
> > that information will be re-populated again and again,
> > so new command might be cleaner.
>
> +1, but I'd allow reading only either stdout or stderr per each
> command invocation to keep things simple API-wise (e.g., which stream
> got EAGAIN, if you asked for both?) I haven't read carefully enough to
> know if we'll allow creating custom streams beyond stderr/stdout, but
> this would scale to that more naturally as well.
>

What's your preference/concerns re: pseudo files in sysfs?
That does seem like it would be simplest for someone using this
(read() on a file vs special BPF syscall).

>
>
> >
> > > Imo, having this in syscall is more convenient for the end users.
> > >
> > > Alternatively, are files in bpffs considered to be stable API?
> > > E.g. having something like /sys/fs/bpf/<prog-id>/std{err,out} .
> >
> > yeah. Ideally the user would just 'cat /sys/.../stdout',
> > but we don't auto create pseudo files when progs are loaded.
> > Maybe we should.
> > 'bpftool prog show' will become 'ls' in some directory.

