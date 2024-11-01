Return-Path: <bpf+bounces-43775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0639B98DE
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 20:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E108F1C21DE5
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 19:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCF21D151F;
	Fri,  1 Nov 2024 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljEmHJVM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F4E1CACF2;
	Fri,  1 Nov 2024 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490383; cv=none; b=AvZ/qczvAzXZOwox3be3d+3OlOILo4c/q2Y6iKbHd4SddFjjmPWhqGvL5qJu+hoCAwmkOgdWQF89kIh53ngAtXGydbxxgz9/mMoIWjy1UgBgIvkUVv5vBF9qIqxdnJrBgE0KgcI3BcPLA2rLBGGK0QPYclEV3so8y4xglf8e/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490383; c=relaxed/simple;
	bh=Q1XJmMNbRTmr+G0p/GjqtphlmLT6K7uAVsxG7/Hx7MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImxvNrPUsrw3x7yVXex2goclBr56Tf7tC7RVBVQvWmviXUg41wosIQcHlXngak22ApZOtajAeJOqHQ7R3t2B0U19pvYLTeRWFfcGJc2aJNYoRx5hlPfbWvrWvcqxLDtk35vAR3dJLH+DonBcJDFcDHXyhGfNZ12gnuQZt/bOeMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljEmHJVM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20e6981ca77so26413785ad.2;
        Fri, 01 Nov 2024 12:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730490381; x=1731095181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo+Yasuw/oRyXv0Io4gB8Pw1IePUj74kOgbZY0y0LoE=;
        b=ljEmHJVMoz/KWyb96BdCCGr5qjJV2JIG0E9HJ6LxGajyz9KCwhztTLc7HNH9WNOCfG
         sTGD5uYLEEn1+0m1MN2kPLTgS/XDYm13UOMgXCvRDF4iNmE9sRQCrZmHH5/HhTvs1tML
         rdn+FRK3EpE+L+XQ/KpD+3Q8f4OgsIZver2Nf2AGOoKqF+pviot2LQ/P454rQGlvfT8o
         1ACB8kXSIfbN6vB9gLuGmdSRGTK+sq6CzxMdfRthPSi+EiNbEAZ28akIeThQLuNZLRaU
         9uogtI1Jua+38RiyuaJ+Gf7CGc85V79YMU7dZRzIJzTUo3BWWTg5XHgpQEbdBtSWbIfI
         TMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490381; x=1731095181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mo+Yasuw/oRyXv0Io4gB8Pw1IePUj74kOgbZY0y0LoE=;
        b=rlf9RL+7ELnqOrbGn5mX2SQBS/q+Fw5+piNZqewcJCbm1bQ6icoNXeoPM1TT94QKQE
         L/ildxXpQrB88NhfvIXDPBG1/umwjTQkmwXuLrI2x8MxItLJSKc7Z3nmP5FqC3o5DfgF
         AGyZX2xCC7YCQHooLeMDKm7XooGwAomrS5pidteNm7DSbSUHgISFy19n/AgZoHPO8rQC
         dhYKkMzMK+KUFeiElamjpJ//dG1thDUaEjwFH0q/Ph9ggwO6fO3icA1gQLLDNIQWW7at
         7zWaYxpF089JG3uqT+DQ+1V1TdlcfnXR5HFN1BEf049t620m8iuYxT4D97V/4lZdUvwE
         T+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUj59ixNRWDtpz4yZ107DvjpFQVblGXjApfIIfZ+vJhTUD8Nx3wqmc+2/DMoAdlxP9Pw9feB1n/wUlCYk92@vger.kernel.org, AJvYcCVQrP1Rsxf/dSXTnFsv5DU0+eT5Z5wEcwDt8nFHJrJ7G4xx1v2lTboT808pCwUNW1cxGHw=@vger.kernel.org, AJvYcCVu53Wqxv7GY4uH0ZO6rZevrYdi/5vp9JGa9uKVdaK4QmYapUrr3NLQXsSw2iLZgu46jvxD0ARl/rZQyQOY8ns26w==@vger.kernel.org, AJvYcCX8GcJO9Qb+UamyPYt+Vg5GL8tYZtTRQD/DvUhPPAWTWF7LT2t9k0AuK/SS/ZlgvKqF6Q4936/TlVFwDzHX3sedUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLEvFEvX2UPXoD3Q5CVRnVzNAiaPIjPhtVlyiZIFgWdvV6Rnaf
	2JA6L16oqf4KBm2T1ZnjtvVIXQLnRdT59j0ID12yhf5CKXXWUY0bTnXYikJFp1o8D4KpgZYqcyl
	idHfZ4XyZryCX1GI8aHbgt0oJdfk=
X-Google-Smtp-Source: AGHT+IG9LKkkHXi5pRokPFdZN6EHwavi1lSDB7YCcE3CLHey6at+eRKQjhdoFNA6jBPtBVtAlIqT+Pg0mMPcCAZkKo0=
X-Received: by 2002:a17:902:c40c:b0:20c:7d4c:64db with SMTP id
 d9443c01a7336-21103c7bfafmr98648865ad.49.1730490381440; Fri, 01 Nov 2024
 12:46:21 -0700 (PDT)
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
 <20241101192937.opf4cbsfaxwixgbm@jpoimboe> <CAEf4Bza6QZt=N8=O7NU3saHpJ_XrXRdGn48gVJMN+kawurNP3g@mail.gmail.com>
In-Reply-To: <CAEf4Bza6QZt=N8=O7NU3saHpJ_XrXRdGn48gVJMN+kawurNP3g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 12:46:09 -0700
Message-ID: <CAEf4BzZvhuUeGYbo1Nesfdx3=-WAkAT2OjSdtE4tfRV7H7PZoQ@mail.gmail.com>
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

On Fri, Nov 1, 2024 at 12:44=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 1, 2024 at 12:29=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.o=
rg> wrote:
> >
> > On Fri, Nov 01, 2024 at 11:34:48AM -0700, Andrii Nakryiko wrote:
> > > 00200000-170ad000 r--p 00000000 07:01 5
> > > 172ac000-498e7000 r-xp 16eac000 07:01 5
> > > 49ae7000-49b8b000 r--p 494e7000 07:01 5
> > > 49d8b000-4a228000 rw-p 4958b000 07:01 5
> > > 4a228000-4c677000 rw-p 00000000 00:00 0
> > > 4c800000-4ca00000 r-xp 49c00000 07:01 5
> > > 4ca00000-4f600000 r-xp 49e00000 07:01 5
> > > 4f600000-5b270000 r-xp 4ca00000 07:01 5
> > >

I should have maybe posted this in this form:

00200000-170ad000 r--p 00000000 07:01 5  /packages/obfuscated_file
172ac000-498e7000 r-xp 16eac000 07:01 5  /packages/obfuscated_file
49ae7000-49b8b000 r--p 494e7000 07:01 5  /packages/obfuscated_file
49d8b000-4a228000 rw-p 4958b000 07:01 5  /packages/obfuscated_file
4a228000-4c677000 rw-p 00000000 00:00 0
4c800000-4ca00000 r-xp 49c00000 07:01 5  /packages/obfuscated_file
4ca00000-4f600000 r-xp 49e00000 07:01 5  /packages/obfuscated_file
4f600000-5b270000 r-xp 4ca00000 07:01 5  /packages/obfuscated_file

Those paths are pointing to the same binary.


> > > Sorry, I'm probably dense and missing something. But from the example
> > > process above, isn't this check violated already? Or it's two
> > > different things? Not sure, honestly.
> >
> > It's hard to tell exactly what's going on, did you strip the file names=
?
>
> Yes, I did, of course. But as I said, they all belong to the same main
> binary of the process.
>
> >
> > The sframe limitation is per file, not per address space.  I assume
> > these are one file:
> >
> > > 172ac000-498e7000 r-xp 16eac000 07:01 5
> >
> > and these are another:
> >
> > > 4c800000-4ca00000 r-xp 49c00000 07:01 5
> > > 4ca00000-4f600000 r-xp 49e00000 07:01 5
> > > 4f600000-5b270000 r-xp 4ca00000 07:01 5
> >
> > Multiple mappings for a single file is fine, as long as they're
> > contiguous.
>
> No all of what I posted above belongs to the same file (except
> "4a228000-4c677000 rw-p 00000000 00:00 0" which doesn't have
> associated file, but I suspect it originally was part of this file, we
> do some tricks with re-mmap()'ing stuff due to huge pages usage).
>
> >
> > > > Actually I just double checked and even the kernel's ELF loader ass=
umes
> > > > that each executable has only a single text start+end address pair.
> > >
> > > See above, very confused by such assumptions, but I'm hoping we are
> > > talking about two different things here.
> >
> > The "contiguous text" thing seems enforced by the kernel for
> > executables.  However it doesn't manage shared libraries, those are
> > mapped by the loader, e.g. /lib64/ld-linux-x86-64.so.2.
> >
> > At a quick glance I can't tell if /lib64/ld-linux-x86-64.so.2 enforces
> > that.
> >
> > > > There's no point in adding complexity to support some hypothetical.=
  I
> > > > can remove the printk though.
> > >
> > > We are talking about fundamental things like format for supporting
> > > frame pointer-less stack trace capture. It will take years to adopt
> > > SFrame everywhere, so I think it's prudent to think a bit ahead beyon=
d
> > > just saying "no real application should need more than 4GB text", IMO=
.
> >
> > I don't think anybody is saying that...
> >
> > --
> > Josh

