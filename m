Return-Path: <bpf+bounces-52931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70921A4A685
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3808516C976
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA751DED66;
	Fri, 28 Feb 2025 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLM035EC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4508123F370
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740784264; cv=none; b=drEIZkPGOYYF7DfB3LCd4gVWodzWOpdlSDqWySU//zKYf1grhAWra6p4clJCdqBsAMQJ9ZEPHiBzYXYA08jGXSKjUpOKD6Qfx4GTvljWgiFLnec2y/YGgO/qcMO8mtar5T6nP5uLLKTPseLrp/LTtj9nJ2DMPPW0+uLsevKRAiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740784264; c=relaxed/simple;
	bh=34fodB78wSV2CNz/HIEAE3kbnVrtuLnrVd3gNYbyj2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYCbu4scKTM1waMDAgWPvSwhI+kDLiV4vOPmBphsV8W2lLalvNzHE+dpk6hgI8GQSPMpDk9ZEEjUFsxxVnxM+O2HaRGpu+EdFA3BOC9wat+4a+83yZFEndHF2eu3vDTN18JsyvY3HKqFgkPYOdHbo1OJ7KDgnmzZOZDilNd/swI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLM035EC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2feb9076a1cso3350035a91.0
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 15:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740784262; x=1741389062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKisjdAt8/JiacTyz7UbTqzhxHyoJReWjFgCWGdiQ98=;
        b=DLM035EC1p53dPOeFNfaz+S+7jqKGTuO98bUowxuT6kq1qYcgAQN2ynM5eMkMKWuoe
         tU59b3wAW+QS7agi4u3ReH7mZBROcnMvSEe/j3EPoplVNPgXQ7LCaloYokD/37aiIrdE
         GluUM4iLatmRzdxo+a0YFoREE1w7WfiviY0AWcOlUiMHXIEDw2lBPyEeOwU+3gUgxbbB
         WNb3Q/gSHpbJMZOVKzdDGJezuj7LtnP4icsoCPuAoXbee6HeG+Hoad/BZt4XHgyd+aL9
         wP6tP9qoSuvU9xoN5PQJ05IYSKeXXQVrHUyQV44Ba5T2BlZV281+pBTcjG/3YMkZM56y
         nMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740784262; x=1741389062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKisjdAt8/JiacTyz7UbTqzhxHyoJReWjFgCWGdiQ98=;
        b=uhkAIsYRXzltMNmAfdMXBKTznrqffcq1gD7Qf+0FFZpooLkaX+aui5oMNzNihxmqRf
         7KFVxbTJxVqI/UYRx4aYhrqy3TnqRax+gtNgRU77NBc+SOav6btEuwn1s39qOPQ7l0C2
         EVKqMZALNJQGak0nvcdgq7cXOLyMLTSBtIcy+6JOotj6POAAJAAy7r0HjNiILyNO3gyV
         bXQPgNJFJNQTKYbFjA3wRMOthJsjINku/nUYD5IUgh9g5zVMOijiOEWOBNL7JmvrR4YP
         FAZS/jRnvy+G2mgr+0KXm9OgiCNvHEisi1oP3m2OzB5TF4e5PwvKeI0IoFzVX2z2Ttac
         Le8w==
X-Gm-Message-State: AOJu0YwUc6aruoBv1Rf3Bld8cAiqDLFohyq7V1PwZiZDhM40IsEwX7Du
	Ok4bTtDsuZMalLIIQ3MzWrSgqGIHmabrkza5rYgQm4jknTxNRIRxQU5d/rCBXuHFsKTrmj530uI
	BqaFV2wbV7bNG4V/deZG7YrLDhzvTYA==
X-Gm-Gg: ASbGnctU4oYk8+5ZheAUY5nLn050noa7oyvuQmaur87CGdqRK1QlnGMvTvUDbpNudCj
	an6RCXqqRPDW3AAQS2zKGEV37N174onyZdi/uyoG4uahc46Wo6K1tj0EYigYOcNGhgpzwFHkW0+
	0pQIK6aGdb/aTrbJDZVE/2cfzw+raHiHoG7l30Gv577g==
X-Google-Smtp-Source: AGHT+IHoonLscVLWMH+9fY24Lbg0ZyzW5tx+6ek604bBcAE3Ou6hgDjKk9kjsdOhppW38Cp0zWdAOwhH9RskUMQEESg=
X-Received: by 2002:a17:90a:d605:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2febab744e0mr9629900a91.18.1740784262483; Fri, 28 Feb 2025
 15:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228191220.1488438-1-eddyz87@gmail.com> <CAEf4BzY77xkTjKvNE-T0emQWWMuNN-Z6uq16BWs1Waxzx-i-7w@mail.gmail.com>
 <72b29dccf20ac55e2c1652f9a3ca917719eefdce.camel@gmail.com>
In-Reply-To: <72b29dccf20ac55e2c1652f9a3ca917719eefdce.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Feb 2025 15:10:50 -0800
X-Gm-Features: AQ5f1JoC9CmRyxjYAyhrMeLQdu_DyJjMIeKuUDKA5VtByMz8LxnXWjMLFlSc5ug
Message-ID: <CAEf4BzZEmwQhCSt6quycRKnCzVAQpxDfd4c06uCsk+ZwPqb0jA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] veristat: @files-list.txt notation for
 object files list
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 3:00=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-02-28 at 14:47 -0800, Andrii Nakryiko wrote:
> > On Fri, Feb 28, 2025 at 11:13=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > A few small veristat improvements:
> > > - It is possible to hit command line parameters number limit,
> > >   e.g. when running veristat for all object files generated for
> > >   test_progs. This patch-set adds an option to read objects files lis=
t
> > >   from a file.
> > > - Correct usage of strerror() function.
> > > - Avoid printing log lines to CSV output.
> > >
> >
> > All makes sense, and superficially LGTM, but I'd like Mykyta to take a
> > look when he gets a chance, as he's been working with veristat quite a
> > lot recently.
>
> Thanks. I'll wait for Mykytas comments before sending v2 with -err.
>
> > One thing I wanted to propose/ask. Do you think it would be useful to
> > allow <object>:<program> pattern to be specified to allow picking just
> > one program out of the object file? I normally do `veristat <object>
> > -f<program>` for this, but being able to do `veristat <obj1>:<prog1>
> > <obj2>:<prog2> ...` seems useful, no? (-f<program> would apply to all
> > objects, btw, which isn't a big problem in practice, but still). Oh,
> > and we could allow globbing in `veristat <obj>:<blah*>`.
> >
> > Thoughts?
>
> Tbh I don't remember myself ever needing this, -f was sufficient.
> Every time I used -f, it was to do <object>:<program> for a single progra=
m.
> On the other hand, this looks like a nice generalization.
> This does not seem to be too complicated, so I'd say lets add it,
> the use case will find us eventually.
>
> One thing I do want is multi-threading.
> E.g. it takes about 2 minutes to process all .bpf.o from
> selftests/bpf/cpuv4/, and it can be slashed to 10s of seconds.
> Per-object this should be straightforward.
> Per-program this would need to wait for Mykyta's work on prepare object,
> as far as I understand.
> I can add the per-object version over the weekend if you are ok with
> such granularity.
>

Yeah, I was hoping for bpf_object__prepare() to be used by veristat to
speed up mass-processing. I think it's fine to parallelize, but this
will be awkward with verbose/error logging, so think how you'll handle
that, ok? Ideally we'll parallelize at program level, so you can start
with per-object parallelism, but just anticipate that it will actually
be prepared object + bpf_program eventually. Just write it in the way
that would accommodate that easily, once we have all the pieces in
libbpf.

