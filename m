Return-Path: <bpf+bounces-34403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665CC92D4E3
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 17:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDC0285D9C
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6259D19414B;
	Wed, 10 Jul 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt78dl+k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B319413C
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625024; cv=none; b=lJZX23o95nNj1Qev3taaeMQQ1TKvQuLS/sLWD0VpUo2HqrtppOlmDZta8r0xj3Vd1AokUfw9uiVFhuTGgCTjDPCQvsHqqOaOgsfEf5B2K7FWNjvf7T+qAEP3f/IkItB3eaONmI/avTB5E9p/co75vnH6iXAgAsRzybHdFBHkcfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625024; c=relaxed/simple;
	bh=bR81X92JfrmOFHntXRCjQ7NyQl5DgXfPHg69IjofmzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1OL7tc70xtn6FFrXbW9Cp9G6rym6KaPw3XpSFqUVzDPq+5sacaKK+sGqutjSBQu534SItryyp7e8xXu7rkR19AKi57hNbop7TzUqZZFubNEGF7WYWVi5tWafyyR2il7jxe4SDDuqcyuh5QYhFweMn3LGQbE5DKhg0NvQdV2xas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt78dl+k; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso652567666b.2
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720625022; x=1721229822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8uDT3KBj1hQn5t0Z7RqHiV3y1ABEDmts+2V4cjrWiE=;
        b=Jt78dl+k13gqf55t3wJPiK/vYcmbUYNwnPUSqJUtpPopiDy7M4baP+7kGkwy/b0/NJ
         WVNQGAiwu+fIjConZx4tqhTp3H2njyGfNCnXIawmrxTNpRY6WWp88uqZrsJirNmDd2sx
         uJT1M0/hd2aa9RbpoO0xewp0+UvhFMqvGBRPh5O1SxIQgBpaMMkbvGfuvaCsmpeieYHv
         xWD+kT8oEjMrdmyHm0YudVcUJDSt3oDNUalxe+rGzHk59uGvp9zAYwIUpQnZgemAZWSe
         t+viRP/oYwQRdQ0z3B+oSlEzkj4UhUQrlW0Z4d5I7Jqz1VEAzZnYSu3pWtPycOpmbeV4
         6KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625022; x=1721229822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8uDT3KBj1hQn5t0Z7RqHiV3y1ABEDmts+2V4cjrWiE=;
        b=IIyQrn+qSIvclpbEcgfE7vDoMND5rPoAG9oUNX7Kmrd+xijyYhTOj+7d4GphN3OJcy
         wGphgVADcVwjcMII5UmfmfzEMJWk56F2Bl1++oSbLlPGADFuJdankvyo1uRplYiO0yeA
         fRtUAMbUTdA1IhDX0RJLXL5m/DAoKeG1KT8SpFd8NV0AheLKvYvgUj/hy8Cljx4BwdkJ
         gRxvZOqT4AVvsQpRepAQroOy3KXVfouhDkw4mWuA32vOu2Y4wYrm03mnI6jcaK9kPLfG
         Ou/hnHTUvTrmBbqu2ylszvbMqu5HUXBUUVsaSMG2BIvpz8UHjooCeKhq7YXrLPjBlM54
         S61w==
X-Gm-Message-State: AOJu0YwdntWXs86in9yrj/3RcnSOXsc4UW4BFX8QqQsc4gXHvW8sLpX1
	KKq5ebj+mo0CGS/Vrp2oZuQPXYTpL5K3pemZ3c7Yy0yNLqRMZ4EaxbXhWl/xDVG0BtG+QUwl339
	9a2cblAHr9a2tS96yu+nIhoU7Zw4=
X-Google-Smtp-Source: AGHT+IHaTlXUKU2o/KMYgpx1KILO3cT4kzAh32Swph/9yHJN8z6TQOLMQ34NEM/dFjDu26lRIHjaNGfTWby76oOjueU=
X-Received: by 2002:a17:907:2d23:b0:a6f:668b:3442 with SMTP id
 a640c23a62f3a-a780b89ea43mr389149366b.77.1720625021395; Wed, 10 Jul 2024
 08:23:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com> <20240704102402.1644916-3-eddyz87@gmail.com>
 <CAEf4BzaC--u8egj_JXrR4VoedeFdX3W=sKZt1aO9+ed44tQxWw@mail.gmail.com> <e11a67d2f4181eb31a4e7e10333b237715a975cb.camel@gmail.com>
In-Reply-To: <e11a67d2f4181eb31a4e7e10333b237715a975cb.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jul 2024 08:23:25 -0700
Message-ID: <CAEf4Bzak=L2AYQEz7ErQm2JkTS1YTy4_nHAs7Mwkk+gEV5rfbg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 2/9] bpf: no_caller_saved_registers attribute
 for helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, puranjay@kernel.org, jose.marchesi@oracle.com, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 2:46=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-07-09 at 16:42 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index 2b54e25d2364..735ae0901b3d 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -585,6 +585,15 @@ struct bpf_insn_aux_data {
> > >          * accepts callback function as a parameter.
> > >          */
> > >         bool calls_callback;
> > > +       /* true if STX or LDX instruction is a part of a spill/fill
> > > +        * pattern for a no_caller_saved_registers call.
> > > +        */
> > > +       u8 nocsr_pattern:1;
> > > +       /* for CALL instructions, a number of spill/fill pairs in the
> > > +        * no_caller_saved_registers pattern.
> > > +        */
> > > +       u8 nocsr_spills_num:3;
> >
> > despite bitfields this will extend bpf_insn_aux_data by 8 bytes. there
> > are 2 bytes of padding after alu_state, let's put this there.
> >
> > And let's not add bitfields unless absolutely necessary (this can be
> > always done later).
>
> Unfortunately the bitfields are still necessary, here is pahole output
> after moving fields and removing bitfields:

yep, if it's needed it's needed. My slightly older kernel has
alu_state at offset 61, so seems like we already added something
meanwhile.

>
> struct bpf_insn_aux_data {
>         ...
>         u8                         alu_state;            /*    62     1 *=
/
>         u8                         nocsr_pattern;        /*    63     1 *=
/
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         u8                         nocsr_spills_num;     /*    64     1 *=
/
>
>         /* XXX 3 bytes hole, try to pack */
>
>         unsigned int               orig_idx;             /*    68     4 *=
/
>         ...
>
>         /* size: 80, cachelines: 2, members: 20 */
>         /* sum members: 73, holes: 1, sum holes: 3 */
>         /* padding: 4 */
>         /* last cacheline: 16 bytes */
> };
>
> While with bitfields:
>
>         /* size: 72, cachelines: 2, members: 20 */
>
> [...]

