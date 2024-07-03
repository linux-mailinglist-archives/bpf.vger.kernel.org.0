Return-Path: <bpf+bounces-33708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FAB924C95
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 02:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FDE1C219CF
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 00:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25647E6;
	Wed,  3 Jul 2024 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt9kvy54"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70C376;
	Wed,  3 Jul 2024 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965188; cv=none; b=GdGFeFWrqU2D6xQDMtQPgTh6yffOdLfe5JhfSHLBOOR0hHug586Mf+47PUzPRjiaF5nrnm/jz780sqBr56ooIy4dfQ6ZYcZC/mQPygNvHAWZAiVgl3EiTPFYKk3EgcWle0ZsFpMY9gs2AKkvJzhfVngWDeGvdtmcy40beUurPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965188; c=relaxed/simple;
	bh=iLySQHSzUBPABd8UEtGLypSLAhlfTYLP6knK4mQMZUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mi/om9N8HoqO6ExqSatnNxa125kxZ8/BZST5+ppM3O+CgiHrt5nQuSkWssZXW+CtBfexGNeVG6yopY27nJFHxDADpoCSKgi5uDgWHGQV/RUKfGwVcCIp9aafNRmNgyhiRuMgcEbl6mf5zeyiueVNVz3MpNcNh3nKtNrGQOCCYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt9kvy54; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70699b6afddso3281272b3a.1;
        Tue, 02 Jul 2024 17:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719965186; x=1720569986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/N9kQ3oCI3jCbzKISRrCZxbj25Bb5h+emAQTUEwDQOk=;
        b=Kt9kvy54jUkY8lkwjv6Q8Vm1K/dduqXmx9fZ7eXE9qqDhGt1d1R6bQ0JkaheVM8HtJ
         M8pxh9pBBvHESS7pPaNV+l76DMFpyiIETCzP+7iyCv/6dmjhisBnkykWooE4vh4K5LSm
         VuQgtnPvMtH2LsiDxnt1iR4IN/xrIDAKWBeNwrH41ArlP0q/E2Ph5gIwcvCQn9W/eRDk
         2WlUIfP8EWvUys2HCEenZjdO3XsgOjZ1ZOK/oBfN+GfAysqyF8rBeRYGakABtfj+FMXx
         QQldd3Ez68ZYLuOVOqq0vzGahiVeD1MyMmffOY4SQBWSePna00xXm1DHyDiwWTKFUnca
         a1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719965186; x=1720569986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/N9kQ3oCI3jCbzKISRrCZxbj25Bb5h+emAQTUEwDQOk=;
        b=I308suFurGWwlxxWzQLcUXZbYYGVaS6QOBvmtxFbE4w38TxwWuln4teCkOzN5g1YfQ
         iPD36zDaNtrgDAx559yDrsFIkekmYcRb7o5TwG/rRA22Bco3dxEsixBkxQ0yYEuugpZW
         45KehInKRJuH2zDI2EpNJzAdcKdgfqKuS46Id0kU07CgLnILzTP1ZHGP9/IPUnJKHBOT
         cdQI7iZQh/iSaY6DYyhy543jZI8yp9zdsDWNTe5RgPW2hG2M+eR34bxOhpjazw5pvrC2
         0/K6xN4aCZ5Pk+ruhipAMA7lBdLeRnRq22giXhsZRJgxL7T9JVwS1KxKIL7YNb8/DRBI
         r/lA==
X-Forwarded-Encrypted: i=1; AJvYcCU3AsyUmGWiiyL28h3U6qkg3ZU+ejmThJvCt1mLlP+Gps8GtHHQ+V8yuj1nnvxYj6m5ZZUwNSoHrxr7x/Zyei9p8ofBdU+hKtgBhk3KeKC2ZY9wdTEToADhbxqaszBTWA9aYtz110wk7xggzXCV4KW1nN0zmFbnLfmBO8jSjar6N0z6o0Ayg9UxIC1snRMqhfVw57y668vMFc1TJhf2K44y61x3RFxC4A==
X-Gm-Message-State: AOJu0Yw9aP4C/NOwxfX9UkIYYHc/RY7NadVrV2cxEzmIOcM1npWQrueh
	Xs0XLynjtNtoc850VmqD4Mhzln3tOhjo9CtVCVdfWVYywK+x1pOaZiMyXfD0XTx1WjvyQrqZ2by
	PSAcl381nozQy4QvUfTjj5Z8kgTw=
X-Google-Smtp-Source: AGHT+IEt2I99EiAmj3hGz/7iKIEOkBWscqSINfAgiYEzd5JTnR+pwhpKuTwdsTPLb+v8l7Q2zGlQHTCRAm1XB3bHhFs=
X-Received: by 2002:a05:6a00:3c8b:b0:705:d8b8:682d with SMTP id
 d2e1a72fcca58-70aaaf2523amr9689557b3a.22.1719965186231; Tue, 02 Jul 2024
 17:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702171858.187562-1-andrii@kernel.org> <20240702233554.slj6kh7dn2mc2w4n@treble>
 <20240702233902.p42gfhhnxo2veemf@treble>
In-Reply-To: <20240702233902.p42gfhhnxo2veemf@treble>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 17:06:14 -0700
Message-ID: <CAEf4BzZ1GexY6uhO2Mwgbd7DgUnpMeTR2R37G5_5vdchQUAvjA@mail.gmail.com>
Subject: Re: [PATCH v2] perf,x86: avoid missing caller address in stack traces
 captured in uprobe
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	x86@kernel.org, mingo@redhat.com, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 4:39=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> On Tue, Jul 02, 2024 at 04:35:56PM -0700, Josh Poimboeuf wrote:
> > On Tue, Jul 02, 2024 at 10:18:58AM -0700, Andrii Nakryiko wrote:
> > > When tracing user functions with uprobe functionality, it's common to
> > > install the probe (e.g., a BPF program) at the first instruction of t=
he
> > > function. This is often going to be `push %rbp` instruction in functi=
on
> > > preamble, which means that within that function frame pointer hasn't
> > > been established yet. This leads to consistently missing an actual
> > > caller of the traced function, because perf_callchain_user() only
> > > records current IP (capturing traced function) and then following fra=
me
> > > pointer chain (which would be caller's frame, containing the address =
of
> > > caller's caller).
> > >
> > > So when we have target_1 -> target_2 -> target_3 call chain and we ar=
e
> > > tracing an entry to target_3, captured stack trace will report
> > > target_1 -> target_3 call chain, which is wrong and confusing.
> > >
> > > This patch proposes a x86-64-specific heuristic to detect `push %rbp`
> > > (`push %ebp` on 32-bit architecture) instruction being traced. Given
> > > entire kernel implementation of user space stack trace capturing work=
s
> > > under assumption that user space code was compiled with frame pointer
> > > register (%rbp/%ebp) preservation, it seems pretty reasonable to use
> > > this instruction as a strong indicator that this is the entry to the
> > > function. In that case, return address is still pointed to by %rsp/%e=
sp,
> > > so we fetch it and add to stack trace before proceeding to unwind the
> > > rest using frame pointer-based logic.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Should it also check for ENDBR64?
> >

Sure, I can add a check for endbr64 as well. endbr64 probably can be
used not just at function entry, is that right? So it might be another
case of false positive (which I think is ok, see below).

> > When compiled with -fcf-protection=3Dbranch, the first instruction of t=
he
> > function will almost always be ENDBR64.  I'm not sure about other
> > distros, but at least Fedora compiles its binaries like that.
>
> BTW, there are some cases (including leaf functions and some stack
> alignment sequences) where a "push %rbp" can happen inside a function.
> Then it would presumably add a bogus trace entry.  Are such false
> positives ok?

I think such cases should be rare. People mostly seem to trace user
function entry/exit, rarely if ever they trace something within the
function, except for USDT cases, where it will be a nop instruction
that they trace.

In general, even with false positives, I think it's overwhelmingly
better to get correct entry stack trace 99.9% of the time, and in the
rest 0.01% cases it's fine having one extra bogus entry (but the rest
should still be correct), which should be easy for humans to recognize
and filter out, if necessary.

>
> --
> Josh

