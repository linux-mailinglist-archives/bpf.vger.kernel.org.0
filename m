Return-Path: <bpf+bounces-43774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 260DE9B98D6
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9316C1F21D03
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541211D0F66;
	Fri,  1 Nov 2024 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv76Q4YQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706AB5D8F0;
	Fri,  1 Nov 2024 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490267; cv=none; b=dqhsGX2BK2Asl/V0FgaIuDZCQqC/ywykN2Adc+RQCjmYSD/YVUZa0OiW+VTJPasmKEL0//u3USTqi/Kt//1/wLSVSJKX2oNxQdYOZpl9rm439Sk2w5BR5LqMrUlgISRFKYg2nz7G32eOp4LZ4J6D6pYyfDGGQjrBzcdH4whsNsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490267; c=relaxed/simple;
	bh=CeTfPr/VWzVwLlG7CAeuNfDRwYaE7utlj0J3Sd72PGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7zRfJsdF2Ue0vHwnY70J/aWzFy1K7r7ZmUc33f+wa6KkGVPoOVvVOz66pjM6/25IdLr+PqVX5OmtxcdiGyMNCe21kjY6e5hly3BbgN5Liv3ZNRYI4jwruaF1BWXMn/VIvrKWeWhQrhgL311LmpDoLZE8D/jyVg1JH+755Qwbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv76Q4YQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-210e5369b7dso24147905ad.3;
        Fri, 01 Nov 2024 12:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730490266; x=1731095066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plTrX740cNSB7x1h9t+sx9ei8+OuSjV8PliWEw3R6sA=;
        b=fv76Q4YQiBlYQwULby3xpR5DcpaOXWWyWdtp6DvFYKT7XiF96quJjiI+N1j0dI2z7P
         Jf6/1vOYpREF+CPxRW2Z5F2iAlZqG7BUoSoPXTqeicoKYris56picwhhNY3SsS0Qy8Ga
         eHpv+D66ngU6BlWLQ+2K3gtsFI5mw40/0P+i23RgEqkDtQ8AJDgnr2iE3PPlNcESfcaq
         d2TfQoOUcDMKo83mrd6oYJV3aPKoLxXFV9Ii81ufe8aG+hDU8tLcpqENSkB+GJHvy01/
         dE44rWJF8+tJB8BuhLEOtBtRqSFWYVdoz9eBVqfP1p1aaeGRJaGffAXSZI/oCUuBjBMV
         JMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490266; x=1731095066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plTrX740cNSB7x1h9t+sx9ei8+OuSjV8PliWEw3R6sA=;
        b=rHs8RisvAzytAKzfERaVMrrf3MD7ui50W6dwyahqc/0yo29CLzoG3+wW/UlsmVMreH
         l0Zw4sRzRh7DqKZMHfaYa/ks9IbrQGWZVHOv8FyY7F5OTUzyxhkvfrSinXLdGniHmxD7
         pUEDmQefdaZhqE2XfbJ3kt0NV8PyiGG0Rgya0RNTzGj5xM2A55u8uIu/fRpk/Aram34h
         f7aK5iRHLyve8jE4gJyk2Gg+5NR220GGl/V+O02ZpQINjompSJ01aPWn0zt862UDDoXM
         EBErIjZkRDw13RA6I5wALu9zW0/bdq/tM6Dhgx+Pc1OqSA1x/YfQLfyku4nyx15bmmbA
         y9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6+EZFzkt68sTQ0E/AuZEKhiO0vCGAfBIwEoYAoE75tRgoHXZZOYnO0VLVo/AUG0b/y5hOHCsfEDCzLgB6@vger.kernel.org, AJvYcCWiJ/pKJQ9cyFMoiacROedx8zrmWQD5FA3eWigrDjGWgOBEdFYo7YeTFCFLjILorHK1Q0Q=@vger.kernel.org, AJvYcCXCrGE/k3TuCqZhHYme0Tg8tno1GtGbyfTPk4zYdBC2d9r5fqp/sTbTzw5s8V92Z1kcccDjdg4Z1ERGBAlN9jVuPg==@vger.kernel.org, AJvYcCXJ5xSdmgS/njhqmARly5XvGIT5vAevvuPSN2GJdScWkaPhju2gJ9OWXs7seAdk0/cjOs8bvCsWURUXRvx9ET1rkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHgGLnrMlHbGkwEaTJokWlTuqaFZx5AzAMRSWDQyzC4tCv7coF
	IMiZ0KN2gBTf4OY/9VOQKlZ5g8dwABTIdZ9GkkDYvOLTpvTfJ5YoQXHVeVfHiV1voegfyRKqmnv
	ZubiZNpS+ATmXcHzjtUhflDTImpY=
X-Google-Smtp-Source: AGHT+IFlDihy3Yozei1OCPCRuKu0esZhrX2AdxlpIZpFeeZkeroxuNQRAqtbz3NLsg2lMusreHCgNaoMvJtnCsAQP0U=
X-Received: by 2002:a17:902:f64c:b0:20b:80e6:bcdf with SMTP id
 d9443c01a7336-2111af53b7cmr68009295ad.23.1730490265649; Fri, 01 Nov 2024
 12:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730150953.git.jpoimboe@kernel.org> <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net> <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
 <20241031230313.ubybve4r7mlbcbuu@jpoimboe> <CAEf4BzaQYqPfe2Qb5n71JVAAD3-1Q7q2+_cnQMQEa43DvV5PCQ@mail.gmail.com>
 <20241101192937.opf4cbsfaxwixgbm@jpoimboe>
In-Reply-To: <20241101192937.opf4cbsfaxwixgbm@jpoimboe>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 12:44:13 -0700
Message-ID: <CAEf4Bza6QZt=N8=O7NU3saHpJ_XrXRdGn48gVJMN+kawurNP3g@mail.gmail.com>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 12:29=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Fri, Nov 01, 2024 at 11:34:48AM -0700, Andrii Nakryiko wrote:
> > 00200000-170ad000 r--p 00000000 07:01 5
> > 172ac000-498e7000 r-xp 16eac000 07:01 5
> > 49ae7000-49b8b000 r--p 494e7000 07:01 5
> > 49d8b000-4a228000 rw-p 4958b000 07:01 5
> > 4a228000-4c677000 rw-p 00000000 00:00 0
> > 4c800000-4ca00000 r-xp 49c00000 07:01 5
> > 4ca00000-4f600000 r-xp 49e00000 07:01 5
> > 4f600000-5b270000 r-xp 4ca00000 07:01 5
> >
> > Sorry, I'm probably dense and missing something. But from the example
> > process above, isn't this check violated already? Or it's two
> > different things? Not sure, honestly.
>
> It's hard to tell exactly what's going on, did you strip the file names?

Yes, I did, of course. But as I said, they all belong to the same main
binary of the process.

>
> The sframe limitation is per file, not per address space.  I assume
> these are one file:
>
> > 172ac000-498e7000 r-xp 16eac000 07:01 5
>
> and these are another:
>
> > 4c800000-4ca00000 r-xp 49c00000 07:01 5
> > 4ca00000-4f600000 r-xp 49e00000 07:01 5
> > 4f600000-5b270000 r-xp 4ca00000 07:01 5
>
> Multiple mappings for a single file is fine, as long as they're
> contiguous.

No all of what I posted above belongs to the same file (except
"4a228000-4c677000 rw-p 00000000 00:00 0" which doesn't have
associated file, but I suspect it originally was part of this file, we
do some tricks with re-mmap()'ing stuff due to huge pages usage).

>
> > > Actually I just double checked and even the kernel's ELF loader assum=
es
> > > that each executable has only a single text start+end address pair.
> >
> > See above, very confused by such assumptions, but I'm hoping we are
> > talking about two different things here.
>
> The "contiguous text" thing seems enforced by the kernel for
> executables.  However it doesn't manage shared libraries, those are
> mapped by the loader, e.g. /lib64/ld-linux-x86-64.so.2.
>
> At a quick glance I can't tell if /lib64/ld-linux-x86-64.so.2 enforces
> that.
>
> > > There's no point in adding complexity to support some hypothetical.  =
I
> > > can remove the printk though.
> >
> > We are talking about fundamental things like format for supporting
> > frame pointer-less stack trace capture. It will take years to adopt
> > SFrame everywhere, so I think it's prudent to think a bit ahead beyond
> > just saying "no real application should need more than 4GB text", IMO.
>
> I don't think anybody is saying that...
>
> --
> Josh

