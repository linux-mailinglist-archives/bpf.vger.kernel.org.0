Return-Path: <bpf+bounces-33725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52E924F9D
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 05:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4461F26DE0
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 03:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC9917BB6;
	Wed,  3 Jul 2024 03:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OASLjKx1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E71510A1F;
	Wed,  3 Jul 2024 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977722; cv=none; b=jYdIvEYC8Km6560KYUbhenag7bxvnyMUQN+dH8bHCf71/wYUCWhTsVkEB3u51hDuHIFpDdb75l1VDGtSCgAoEbEa7ak1u1nSGLFMHpEFpYu18WYdvkuVbF4XvdLjBHtx1QSJoTJ0JZB2wbd4tByPhOEtrIL14EaBIg1c+vjThzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977722; c=relaxed/simple;
	bh=alDW/5WRTsnQvPoIKEAj39FCtHeT0wPGDtOjyOtERHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z53H0ZLLSD6ktaZGx92nSSCfvMSY7rpRD7XgUND46QXHDZTB2ixejHi3Np/VozcSSaX1saSoSHfI+zHz0Gua4R+9VUTSYHjHrwYcrJmt2Pd0kkmr+KuQXK2X1djjKaWkQLB4ydBixIiPHE5GWJve5g1yCsGsd9i/bsnTOAHO398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OASLjKx1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7066a3229f4so3253711b3a.2;
        Tue, 02 Jul 2024 20:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719977721; x=1720582521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0OSZ5JJ3cRcJxK0FWpvSgsBkGlhmq63+yMgRkflksk=;
        b=OASLjKx1MK5i9ELYo8t8PnW5Q7k00bXmd/+huQlbOiURQCAIy3lldGLrx+X2gLDFqq
         v8BVBi9ec7T4MpVNsT45aN6zLhItMLtW++UIvNoH57NDPdpBMiYdkbEKgjeiBH4ueitT
         IfeYjBI8nMCLAs33s7kNFUUR3yhMQGn8ces6C30gBF/DTPEdrH7tJBUwQmVQ/VpDEDdm
         buC0EK8T/8kfLRgiTHV75scAuX4eGVtdsEEIcBczeD3k1QfE3Suw3X+t+TgofUvNovLx
         6mdrGmjkh8uU+HZSF4I3BoA3DeeBXGMXDULWx3SSrfOkmk8YQRpY6ShmsFR6FwvAQUMz
         YMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719977721; x=1720582521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0OSZ5JJ3cRcJxK0FWpvSgsBkGlhmq63+yMgRkflksk=;
        b=caHJN4wkx8MF5mWoj9tPoil2cH65xKGYrmlschgjwo/Oe3ETLfoW0VrHPWGKFcbYhi
         SuAwuHVL23OnIs6iVMka8+PfS1idwFMTYDpro3V6VEEpC64r37y9to032sXwq39l+KDt
         pjfMstc1df4wWNnkB81/iDWEXuIyRT7+Ph+rpW5hL2l/jLRUHZd76idEqQOnAw3+9hG7
         cMzOH+aL+DNQPAKhdRDQyebMSDleZwxOOM+Id6KNTfYwgRoz0+PinJdfTSx7uasU43gO
         0dxsmyBKKEjOuqbZkL6MQQmYdqW5c4EHrIesdP+Ltkhv36SSDyL5qxHqZQTATEMADNB+
         udgw==
X-Forwarded-Encrypted: i=1; AJvYcCUvlXKcEF7eFBrPrP7P7LVfpLMViiod0HJwiu/x5yTtG/UHMJcI07NCUjb3QbMTvK5kVKn0j10L4856j1u/P6KSULhEce/zFGi0NNeY93qKBndZgTK4vpcBvYBOKpW0hWFHGhZUiDGzMxCXAkngNVSdZrhmFPqP5A1anksjFM+QGy9F+iVXARujzLO5nrxGZY559q6Sdtxnj4E93HhRNM1Tz1zYEJcCdg==
X-Gm-Message-State: AOJu0YwvB5oppPriMbWcDQA8Z1dJryPBB7LSU+4WV5bkOixNrA9CSgZY
	m2LdiZuxe1luhyAaI/J1xrdolOlSEHQLDfbLjbS8KDn3Nwi1peYZYSlPZRjnVr5GNso6JbZs6rK
	DJXelt9ttGEIYd22qUZeEZ5i+0Z5vUKdx
X-Google-Smtp-Source: AGHT+IEvXhl7/THETxftoNv1+QEaIpTlrmxZjQ5Jl1zLbDAXsZxlBu4DIpOCs3GNgARkdzzKCjvFzBRweyzktSXtPgQ=
X-Received: by 2002:a05:6a00:4fcf:b0:706:6af8:e088 with SMTP id
 d2e1a72fcca58-70aaad2975bmr9987422b3a.3.1719977720721; Tue, 02 Jul 2024
 20:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702171858.187562-1-andrii@kernel.org> <20240702233554.slj6kh7dn2mc2w4n@treble>
 <20240702233902.p42gfhhnxo2veemf@treble> <CAEf4BzZ1GexY6uhO2Mwgbd7DgUnpMeTR2R37G5_5vdchQUAvjA@mail.gmail.com>
 <20240703011153.jfg6jakxaiedyrom@treble>
In-Reply-To: <20240703011153.jfg6jakxaiedyrom@treble>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 20:35:08 -0700
Message-ID: <CAEf4BzbzsKLtzPUOhby0ZOM3FskE0q4bYx-o5bB4P=dVBVPSNw@mail.gmail.com>
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

On Tue, Jul 2, 2024 at 6:11=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> On Tue, Jul 02, 2024 at 05:06:14PM -0700, Andrii Nakryiko wrote:
> > > > Should it also check for ENDBR64?
> > > >
> >
> > Sure, I can add a check for endbr64 as well. endbr64 probably can be
> > used not just at function entry, is that right? So it might be another
> > case of false positive (which I think is ok, see below).
>
> Yeah, at least theoretically they could happen in the middle of a
> function for implementing C switch jump tables.
>
> > > > When compiled with -fcf-protection=3Dbranch, the first instruction =
of the
> > > > function will almost always be ENDBR64.  I'm not sure about other
> > > > distros, but at least Fedora compiles its binaries like that.
> > >
> > > BTW, there are some cases (including leaf functions and some stack
> > > alignment sequences) where a "push %rbp" can happen inside a function=
.
> > > Then it would presumably add a bogus trace entry.  Are such false
> > > positives ok?
> >
> > I think such cases should be rare. People mostly seem to trace user
> > function entry/exit, rarely if ever they trace something within the
> > function, except for USDT cases, where it will be a nop instruction
> > that they trace.
> >
> > In general, even with false positives, I think it's overwhelmingly
> > better to get correct entry stack trace 99.9% of the time, and in the
> > rest 0.01% cases it's fine having one extra bogus entry (but the rest
> > should still be correct), which should be easy for humans to recognize
> > and filter out, if necessary.
>
> Agreed, this is a definite improvement overall.

Cool, I'll incorporate that into v3 and send it soon.

>
> BTW, soon there will be support for sframes instead of frame pointers,
> at which point these checks should only be done for the frame pointer
> case.

Nice, this is one of the reasons I've been thinking about asynchronous
stack trace capture in BPF (see [0] from recent LSF/MM).

Few questions, while we are at it. Does it mean that
perf_callchain_user() will support working from sleepable context and
will wait for data to be paged in? Is anyone already working on this?
Any pointers?

 [0] https://docs.google.com/presentation/d/1k10-HtK7pP5CMMa86dDCdLW55fHOut=
4co3Zs5akk0t4

>
> --
> Josh

