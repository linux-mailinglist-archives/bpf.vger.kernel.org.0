Return-Path: <bpf+bounces-34451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25FF92D8C6
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 21:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC9EB235DB
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 19:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEE8197A62;
	Wed, 10 Jul 2024 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIoPCZQf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D7218FA17
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638439; cv=none; b=A+gJ4p2QMX8YI22hoPPtJbWEkHR1PaHgXbR2X3PIApwOP8D3+6yu1ZGwL14TfR0WVtNBAHZOghKu+faFa7C8SAnqVSJe+JRwIG5I9y7lwDtkQgLd5+n5czon6lJz81KKYFSTtgu5+vYR+2V6pQfrVy8mZmqZ4x5iOk/9Fa+4ORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638439; c=relaxed/simple;
	bh=IZlkT33e0MqSU6WVL+biYa5wPDIibhDwHJUsDWilddo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpyxHM7oRh+g1d08Mf5DFs4hRPxmIZiZkB83BkS2ihU+H1/Xv3RqL/AWl0AfakfYmsuoZZxGt6yvx3cv4tLux3psgGC0CBtFbNyu+3bsKzHyJSRsC7/kNy7f7iFcT+yHx65y3bXd5DCbpvNGUBaQUf9v0pwjkqihyzmyuEuqWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIoPCZQf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7523f0870cso12128266b.3
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720638437; x=1721243237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVkvv/Wf+Lw/2W5Lrv+4HLYQOr/TjnP4amje3ngU8Ic=;
        b=DIoPCZQf0GQCIf7zG30+5c4Zd/ih7HqVPLjgKMm3Q762ae40ZdXFFZYB0jJI/YfnWM
         vKiucnhqRG5mfwBWbvqYbtwx2HTgjQarAkNNLziMUTqWcYBTR8VCMw2Z4g4LInuh7CGs
         mhzxw9aQzDtoRsKWZXJbd7TgN5bjyssTQxQFAoqY5ISIoh8mVU5TvlLJyLYBC8qcd1F3
         XYkV8mFWsfuZmmXO6p8Ci7emP/81HAwoHoI0cLq3zoDTAPoJLoAhstVwqNVIWdyRQ371
         d8ADAs5gdaRdCZ9I3OQhIAdbvNZmMnsHFXTJFRoNg07ZrvXF6Hp12hfU0wNyykY/Oqls
         Jpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720638437; x=1721243237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVkvv/Wf+Lw/2W5Lrv+4HLYQOr/TjnP4amje3ngU8Ic=;
        b=VDHY83xtAITTisgLV/bfZnFOe1nJpwhv0as9Ii6zcM8cWzxbIo+82DhzQRuXy1Kspw
         mprTbPrLRrEnggTV+41VV8q8EOsTZoLklqFOnTjBQ5C1tfbapMIWKEpHrDFq9GVtcM19
         Q8eLgcOca33fINKADmlFUYBD2th41v+4YC6t/m5WOi4gwdD/DV27wxUy05k7LlR/l6m/
         3veplUTAHDPgWmDCLa4FnaxAC/6r5SFacBqTHeflp1qzvYdo2tGRydGlP82Jr2/9Fe2G
         dUOOCeGQE++A08VuPx4YoqO7Q/ycVU4JApru0+8HKD9nGM0rMl1RwmOjlTIWzzb5KEG6
         mYuA==
X-Forwarded-Encrypted: i=1; AJvYcCWsUd9EK1U4Rg3VXePI23jGZAnpvwCjUKpGqs7xG6zN7IdVKnIkFWzmSORaEuMQxJbUeLl4x9mcHJvuJyoTjMONppIA
X-Gm-Message-State: AOJu0YxVl/X8wLqsM1FkVpBzxrRMdI0cYfLQhwAKmDxoTzXMdm6YRyyd
	2F7it9KLIXR6oV2LgWoYKaywzEPh0fmaW+btf77vWYlYnPBVu060G6ROOtStl4gGMBs74xu5aW6
	9rCsd51a04o1k1wpf+oh4G6LPbPM=
X-Google-Smtp-Source: AGHT+IHzAvL80tYLyyJtDSC6dYDN3w6oT3FiAOWx7WvY05js7Sdm7b6bArryOt0DO7zuVuKTMuTcg1s9CyuYjTZBNe4=
X-Received: by 2002:a17:906:30d2:b0:a77:d7f1:42ea with SMTP id
 a640c23a62f3a-a780b70541fmr421133066b.45.1720638436342; Wed, 10 Jul 2024
 12:07:16 -0700 (PDT)
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
 <CAEf4BzZWMNWzk0V2HmG3MV693bNDoBo5ptFE6_fPsRXEH4E75A@mail.gmail.com> <b21d3cc6f95dc4e1241c09a92a1ad45942ce53d0.camel@gmail.com>
In-Reply-To: <b21d3cc6f95dc4e1241c09a92a1ad45942ce53d0.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jul 2024 12:07:04 -0700
Message-ID: <CAADnVQ+DGcYO2L1u1Q6u8rfWVki+9pYMgEk1rGmvM_4vTgpH+w@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 11:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> > > So I wanted to keep the nocsr check a little bit more permissive.
> > >
> > > > Also, instead of doing that extra nocsr offset check in
> > > > do_misc_fixups(), why don't we just reset all no_csr patterns withi=
n a
> > > > subprogram *if we find a single violation*. Compiler shouldn't ever
> > > > emit such code, right? So let's be strict and fallback to not
> > > > recognizing nocsr.

no.

> > > > And then we won't need that extra check in do_misc_fixups() because=
 we
> > > > eagerly unset no_csr flag and will never hit that piece of logic in
> > > > patching.
> > >
> > > I can do that, but the detector pass would have to be two pass:
> > > - on the first pass, find the nocsr_stack_off, add candidate insn mar=
ks;
> > > - on the second pass, remove marks from insns with wrong stack access=
 offset.
> >
> > It's not really a second pass, it's part of normal validation.
> > check_nocsr_stack_contract() will detect this and will do, yes, pass
> > over all instructions of a subprogram to unmark them.
>
> - on the first pass true .nocsr_stack_off is not yet known,
>   so .nocsr_pattern is set optimistically;
> - on the second pass .nocsr_stack_off is already known,
>   so .nocsr_pattern can be removed from spills/fills outside the range;
> - check_nocsr_stack_contract() does not need to scan full sub-program
>   on each violation, it can set a flag disabling nocsr in subprogram info=
.

I really don't like where this discussion is going.
Keep the current algo it's simple enough and matches what the compiler
will generate. Obscure cases of users manually writing such
patterns in asm are out of scope. Do not complicate the verifier for them.

