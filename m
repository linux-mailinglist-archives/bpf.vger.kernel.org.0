Return-Path: <bpf+bounces-46173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 558099E5E38
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 19:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39E9188401F
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B48227B8F;
	Thu,  5 Dec 2024 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRHtQjIf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153421C17A
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423104; cv=none; b=ihLWbRJ809Iajac1VuWXEGWTCsH4g/g8Ag/ezwwKBQoI7OnqpemlItyl05wmjBLoiMkNHcQODzxWo8M2MlskFjWNJ8aZ0Pja+N0dkp87WxSdEfaLxXFgqq6tR45Oht0C21AV0d5vY+NNtyTAb6q/pMXSSLhJwbN4fOBX0NYrV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423104; c=relaxed/simple;
	bh=1vPEmcvdbcdsAdBWzu4atYoIQLBaWaId6WNCFM9uyQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQq0Yy/oAN3zJjaNiwqrg1RF0TnCx0z3iPRHa2x8Z5hwBMu3HBzJBqKG6b4VC+1CTZY7qBJs4lLU9qaHpv/zjy4XNwCLFui6XgM6vFGn/G+cdr15h60a8yrZAD1UlQMTV7en5VE4z6Zm9cs2QQXeCnWIEsZi94/9Xb3374u/3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRHtQjIf; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd17f2312bso819785a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 10:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733423103; x=1734027903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eXjSAbxp0LJTjweZzRLOm6N8exqTKXfY3gE0SISpag=;
        b=JRHtQjIfyt1ZY/r5kkZK5p49u7dQD9vUmtlCoP5Azf72J3S/cPOKoyoDvpEESaDExu
         MftcKNoltTJ5+wKweW1KIBcHD7xhlLDFkm3tVB2tVXnZRufyi8ElKDZpISzQpyM0Qmks
         rE3RVBk+qNxqqgJ9nTt3xe9EMx2XP4u9A8xBS35X85vMlKDDTfJ1vsD5HLohVV9hU4ns
         fqoiEq9KprRV6rwI/7Y5LIURftrMrjf/4vb1V116PM1N48SCLgDVn5k+Kd/otHi4a7eE
         HPUpS2Gxw9e3CZulqW6fjKzVSqU0vsVSVFIpp4hXM16bmKomaOhVvzLFCNigZ/znZ0Rw
         3P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733423103; x=1734027903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2eXjSAbxp0LJTjweZzRLOm6N8exqTKXfY3gE0SISpag=;
        b=DQUj4626fdCQgpA7nbvr8GdJD8KaMFi/v8mViQV3TT2CDDcABBHKuD7ilXdJzB9NIO
         1DxeHIerB8BEAyr3m4dylb9GoI5IJs0nRzAoTr5Os8GqsPuEuwR9ApL2GtTmTA/hdbqp
         cLPbEzKKWAZ4LeIrPXTVMUfkroiUOZ3lNOHAXlRhAgakjpu/WkG2IJB1/PSLSk5WO+xR
         fHmh+KhEWH4RMxlv8Yx4YgV4oWZANKGK7NUcIiev3hOjnFtzgF6qcHuS6FGSI+RWdq0m
         eCImsPjEGj4v2MTypn9jIt60aM6j4fbSlL3J+L/fGOB+nje0FRYsdB/TiTxeW/5HbmLX
         He7g==
X-Gm-Message-State: AOJu0YzFIwhTlWJXdWMlgyvzpr1EEEbzc5EeSW9Wqhqbwq/CNsCIO2OE
	+JwyoP46IgG4AX2E6BW3nPzRJIc/vt1tjyCmvg9xtGhgyak66Znf4fdLAbtnL7X7G3/14MOBSMg
	nW+Vw8N8Vl5Z7Oxu1Mooyw02hNI4=
X-Gm-Gg: ASbGncsDAWU7XR9GlVGSvZp76xkODeNbA/Hcfnf+CQykxfEK535DCbvl8OFtn1ObmAF
	7cmhD7U31YmaF5xlaCM7D3kspaR1SP38OuPANFsxzon6g/O4=
X-Google-Smtp-Source: AGHT+IFs7dKfE4njCF/JfGOyo6dl5VGpi/6vvzDxa5R79morR7Vfw965uD20RDPwFGkP5x+SCuf4ygMXYdwBLdTe86I=
X-Received: by 2002:a17:90b:2ccd:b0:2ee:45fd:34ee with SMTP id
 98e67ed59e1d1-2ef6ab29c3emr195333a91.37.1733423102817; Thu, 05 Dec 2024
 10:25:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzbZoq1pwq1CZShVzWELC0=eJycFvqPuDXOFEcyu9zYUpA@mail.gmail.com>
 <20241205172318.3481555-1-ajor@meta.com>
In-Reply-To: <20241205172318.3481555-1-ajor@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Dec 2024 10:24:49 -0800
Message-ID: <CAEf4BzY_0NjzkB1ftnjVHB47bvYKXCn1uQikCGGSkt_cc2rFfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] libbpf: Extend linker API to support
 in-memory ELF files
To: Alastair Robertson <ajor@meta.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:23=E2=80=AFAM Alastair Robertson <ajor@meta.com> w=
rote:
>
> > >  {
> > > -       struct src_obj obj =3D3D {};
> > > -       int err =3D3D 0, fd;
> > > +       int fd, ret;
> > >
> > > -       if (!OPTS_VALID(opts, bpf_linker_file_opts))
> > > -               return libbpf_err(-EINVAL);
> > > +       LIBBPF_OPTS(bpf_linker_file_opts, opts);
> >
> > this is a variable declaration, no empty lines between variable declara=
tion=3D
> > s
>
> I'd originally written it without the extra empty line but got complaints=
 from
> checkpatch.pl. Is it ok to just ignore its warnings?
>

yep, if they are unreasonable :) checkpatch.pl is a guidance, not the
final authority

>
> > > +int bpf_linker__add_buf(struct bpf_linker *linker, const char *name,
> >
> > why is the buffer name passed as an argument instead of through
> > opts.filename? let's keep it simple and consistent
> >
> > and if user didn't care to pass opts.filename, just do some
> > "mem:%p+%zu", buf, buf_sz thing
>
> Just because memfd_create() requires a filename so I was treating it as a
> required argument for this function too. Happy to change it to this
> suggestion though.

but memfd_create() is an internal implementation detail, so let's not
leak that into public API

>
> All other comments make sense and I'll address them in the next patch.

