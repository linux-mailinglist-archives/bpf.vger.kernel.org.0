Return-Path: <bpf+bounces-34453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF992D8EE
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 21:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FD31C214C7
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D54198836;
	Wed, 10 Jul 2024 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jakcpN5o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA9198831
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639048; cv=none; b=pRbxQ8WiPIi/uGKytYH4nYO+p7ZgO4sZlnzzkd3i7IFpdjAfwUXPLPzZGG0rYAYO1nyYf0XLpPefOwqsBnJZbbvXJfo1bsQufRAaIRO14hEnsKAwTS0OXw2DEQtR29mujJ5+GmSBNSpoHOwdeXD3YoHllMEeWc4b7erOz0jJ7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639048; c=relaxed/simple;
	bh=b63/QGoWxc5utURScfO+1habKVkLzg2F/m21BZ/G7Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkxDHCpvbGo7bI39wUh/xaivTDFVnfRtSeg8M0lZ8jpiOFLqQa2rVl+e9cOOFvlryicIq9io/AdMpAhdseXzfA9p4/YskaYfLNhmSl09MVNUyFow46bWTr+/s/v9DGQd2g4bkwGB0PcEXDHUGQWup3xXGkXVWdJ3afNF2QUja90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jakcpN5o; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-75c3afd7a50so42657a12.2
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720639047; x=1721243847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2UcnBp2aJs6c1V5t45xJMKwTSOqzBIXNBUejs0eHdI=;
        b=jakcpN5oHJ+TrdWZi26NddxkW6gQMA9s4gB7Rh65/UFTk7SaXqt594WF0ggaPbrq3Z
         x18mm7Q/kmdOvn/Ym3so8xMv+KtQLs61bSnBjUBTcY9NqDfecdIO1UZXlBjc53R3bUSz
         iutTjKZExA0K28d2elNr/Dls9dbPiu75Aiim3O7O2RMJPZlTC1hjBG9KgcOuhLJ3s8Vf
         IA7OuLvlPZ3tkOOWCTVMqwmekRWFdi1ZMM1vK3nMqWGOqR+drC19W/jb3F0SZuN95R97
         yEgkWo5MM8Ki2MVKvfr+d/Jc/i4+03CTDPOlGy/KWMLGySl3ZlWNLR72dWppyEp8aa5d
         6IyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720639047; x=1721243847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2UcnBp2aJs6c1V5t45xJMKwTSOqzBIXNBUejs0eHdI=;
        b=ktjODDB10dJPsGFBjALyEw/PGpr0UKmRzqDn5lMdPijfJ8cLPNSswZMD/RiTwnaWJa
         KVJ/VKdCVRqXfv2xacaESCt/dECWNHyeMLoVTGWT0ni9xxNk3sYmFrnKaA9loApAUF07
         GldHU/BU5xuBO/uthSA+HB5KuhZxQf1Ae87lQk0kRVaCAskq2VBIlOzn/Nw4peRV15UQ
         ohAoTgs9tTfejItYyPKx2kuVWKqWNpx7NyQX7a+McVrQ+KhMzPWaZCwW8bhTGifHLsf7
         nFNgDCQnARHjYVZ9QXas0otm+3lMn9XqnhjNX9d09B4SJjuu3bCmaF9MWAaG3Vh4lcsB
         J5ug==
X-Forwarded-Encrypted: i=1; AJvYcCVvCm9AzkEJUIfG0ghHMJ9XLeGvg3YCfJlPb+WXk59Q11gzaYdJhYX2TuVVn6TdhEU/gCaeUGVqvdj7N68UW3QMmXh0
X-Gm-Message-State: AOJu0YyBfr+Ol5OAXfqX7JsVTjGWVDZZp3VTeodI3X+rPNf9OiVlvyLn
	+xRdsaqqkp7ETzxqMLfcIHBQnN/qjMXCfCFoI85df7FV7iWQtg/2u675EUm9OYxrE+IptFRJDB3
	A+IOe8Fx1LnwNwbFiaHj8J954QP8sbw==
X-Google-Smtp-Source: AGHT+IEpW1eAEgE1d+19/Vy13YC510m6pnxLvkJO+TIZ8FXXBtzZ9/7N4TomCCopQFRk6zTBUiC2/eq/2Fpo30g2CGs=
X-Received: by 2002:a05:6a20:43a1:b0:1c3:a63a:cefc with SMTP id
 adf61e73a8af0-1c3a63ad21bmr3096845637.11.1720639046812; Wed, 10 Jul 2024
 12:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com> <20240704102402.1644916-3-eddyz87@gmail.com>
 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com>
 <7ec55e40e50fd432ba2c5d344c4927ed3a5ab953.camel@gmail.com>
 <CAEf4BzY00fv1+13rZHb+5YHdXcwPzYjNDnN3Rq0-o+cwSB=JFw@mail.gmail.com>
 <de4ed737e56fc6288031191509acc590446f4d24.camel@gmail.com>
 <CAEf4BzajkXm0_8H3bA4RaYLvK19sz5OeQL0HFWgRGgKKERbrkA@mail.gmail.com>
 <44bbdf47feb182fce4857e1b38fedb8fc95db3e7.camel@gmail.com>
 <CAEf4BzZWMNWzk0V2HmG3MV693bNDoBo5ptFE6_fPsRXEH4E75A@mail.gmail.com>
 <b21d3cc6f95dc4e1241c09a92a1ad45942ce53d0.camel@gmail.com> <CAADnVQ+DGcYO2L1u1Q6u8rfWVki+9pYMgEk1rGmvM_4vTgpH+w@mail.gmail.com>
In-Reply-To: <CAADnVQ+DGcYO2L1u1Q6u8rfWVki+9pYMgEk1rGmvM_4vTgpH+w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 12:17:13 -0700
Message-ID: <CAEf4BzaKMpLuNdJ0UkACcaiYGY1Yq4zYbaE2-kP51xavBYihew@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:07=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jul 10, 2024 at 11:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >
> > > > So I wanted to keep the nocsr check a little bit more permissive.
> > > >
> > > > > Also, instead of doing that extra nocsr offset check in
> > > > > do_misc_fixups(), why don't we just reset all no_csr patterns wit=
hin a
> > > > > subprogram *if we find a single violation*. Compiler shouldn't ev=
er
> > > > > emit such code, right? So let's be strict and fallback to not
> > > > > recognizing nocsr.
>
> no.

I agree with your arguments.

>
> > > > > And then we won't need that extra check in do_misc_fixups() becau=
se we
> > > > > eagerly unset no_csr flag and will never hit that piece of logic =
in
> > > > > patching.
> > > >
> > > > I can do that, but the detector pass would have to be two pass:
> > > > - on the first pass, find the nocsr_stack_off, add candidate insn m=
arks;
> > > > - on the second pass, remove marks from insns with wrong stack acce=
ss offset.
> > >
> > > It's not really a second pass, it's part of normal validation.
> > > check_nocsr_stack_contract() will detect this and will do, yes, pass
> > > over all instructions of a subprogram to unmark them.
> >
> > - on the first pass true .nocsr_stack_off is not yet known,
> >   so .nocsr_pattern is set optimistically;
> > - on the second pass .nocsr_stack_off is already known,
> >   so .nocsr_pattern can be removed from spills/fills outside the range;
> > - check_nocsr_stack_contract() does not need to scan full sub-program
> >   on each violation, it can set a flag disabling nocsr in subprogram in=
fo.
>
> I really don't like where this discussion is going.
> Keep the current algo it's simple enough and matches what the compiler
> will generate. Obscure cases of users manually writing such
> patterns in asm are out of scope. Do not complicate the verifier for them=
.

That's what I'm pushing for as well.

