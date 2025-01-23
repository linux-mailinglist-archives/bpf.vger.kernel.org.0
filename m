Return-Path: <bpf+bounces-49612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C5AA1ABDD
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 22:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173813A8DA5
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 21:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1935F1CAA63;
	Thu, 23 Jan 2025 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRuf8/vC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008AB1C5D4F
	for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737667498; cv=none; b=j7s6mCI21JPFk5yNYm5IIyF2iN3bUSQ4bVplx5ZQszA+geHtbZaCor60QhyLZUZv66viHiYjV2/0YYhCLe8RnQ8aWohJ6O5ABa1tQrGRpylHenH/Cf6rRPv05GgcfOUVRndX9qN4DkiZlM333+NPD7bicOfsEc52Ya5MRvuwnl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737667498; c=relaxed/simple;
	bh=M5BXGpgwMCnIFqEQNLncr323vXpk/UyBJI1PvRa54rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KIAMa/M9sxkbT4wa2aiKudfll1ajv8oEYzHZvIgQZMiFJSovKzd+I08y8uzQ8HPl7JYGD+i2V91M+ZzOIreJI0vzdwiN8sb/0VG6tm2zK/wFLvhG2z2aU2WKW3uuvE8CRo5T7yAx8iTzMjY0cRXED241PQqPKnABJ1lONJrHtCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRuf8/vC; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so26615ab.0
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 13:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737667496; x=1738272296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5BXGpgwMCnIFqEQNLncr323vXpk/UyBJI1PvRa54rE=;
        b=qRuf8/vC4Bjo1ZwXnPU5QjdS06O1FH5w/rPa/tgSl/fyy/mICi2d32rmLDAq6Qkj2/
         R6tN8SmpAbyWju6W7oANfyP+FG1QszCNhoOJLqmQ64gDfk3E+gaHLR4UF2rwTBfCDddu
         INdCT4ESByao8/czyH7ThIplHmKIXuenAXdIUyrbLehbwoz4FBDU767SJhrUWPPkWCrJ
         XWsbNDOAA6CwWu4NBXOQxRDt9TQmEKaYgylh1LU7U/G3MjWXI0yrC34gy0ySA47BtZwh
         TT1TwFBIUgxBn6PoIT7qMvB466WzFGofzz+JsHWfvtJSkgY5OqM50gcnqH2mhRPy7IFE
         PwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737667496; x=1738272296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5BXGpgwMCnIFqEQNLncr323vXpk/UyBJI1PvRa54rE=;
        b=n9fv6DoMp3wO0Ao+esxoy72Rz6Fm+tKC0x9NH/S15Yn2pVUmTPTbiFLHU99ahZGosd
         JgL5xkdmlORhOiD8fZQJsgjM2J9XnTg+pT0isMGiKUb2iOpzS6XVBGpkIG83FaeFL9LY
         nSwCNyMm60E/An5aiQPqsB55fyqgomTHtNFDuDwnFnnDTmUuooE8HKRRSpgBtTwd6p/D
         CIzEwgw/OMGXb4kq5Vgwn3TIG3XhvgQf7enIvlTkwaw9rKYFfA8WqygC5A0hEesi7Nme
         tdo/Z2OS8ysPXz7eRWvzandsChLvpM/FgR1aNnKUxhp5HtGQB8h1SENvD/crXWH+begJ
         4FMA==
X-Forwarded-Encrypted: i=1; AJvYcCWrx2nLKL8IATBtXk34pPtbgH6C7q8ZD/xI5G4m1mSPTZR/bs1HKA1laCdJW5Cw38dFw2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLJcDfOxId6yx8M9D3tcWkjSqS23qwR0I/NWx7wTyyVHkPWm6b
	S0WCqLUQu6WAFJ1ZSPnaSDF+zD2wanDVPXAOI3KWVQ8GQprSmP9autGKJ9XL7r92fBj4qeR6T+C
	q6fm5D9BlZEzV/rFcpmY2R8Tyy9zfi95IIBeQ
X-Gm-Gg: ASbGnctw6i9GtYNGutuJ76qlR5q/kC+VqTKm3w8+zCdqqsC02Iy3hxF8O2B3G9wBdzY
	Pql1fJclT60pWFRWeWVehtKHK8z0tmi6pWD5MJ550NDBr5wpJ2ddQmkXcP0oMlmqOrmOUX1YgC3
	mPBWovUvi9bBm3GA==
X-Google-Smtp-Source: AGHT+IGwvofrtUyEuSwOuV3OUTAsv9p7IO9zxK0RoTXVD1YmkrPrc9vYfh/5phhlnpuNXd8qGJMfJHgAwe0IUpnUZuM=
X-Received: by 2002:a92:da09:0:b0:3cf:c1af:99f with SMTP id
 e9e14a558f8ab-3cfc1af0b2bmr2536455ab.24.1737667495808; Thu, 23 Jan 2025
 13:24:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com> <Z5EM24qWVQF2VdI8@tassilo>
 <CAP-5=fW6ZWf6jF3Xnike81S9s_5tZ9w4DS8=8Ff1Ve87O32_Sg@mail.gmail.com> <Z5KILXC9-dN4Vo1o@tassilo>
In-Reply-To: <Z5KILXC9-dN4Vo1o@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Jan 2025 13:24:44 -0800
X-Gm-Features: AWEUYZm6s3k1Q3-4dxuPxZe5_z1NgGEQjOMpv31v0pNOZT3BbLBoJ2mkb87R2IA
Message-ID: <CAP-5=fW5xmir_26CrQN50TWkzab3GueUvne4VWhWhqc82p6LvA@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 10:19=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> > In certain scenarios, like data centers, it can be useful to
> > statically link all your dependencies to avoid dll hell.
>
> Yes but it won't be loaded into memory if not used. Executable
> loading is all lazy. Maybe look a page fault trace for loading
> perf if you don't believe me.
>
> So you're trying to optimize disk space here?
>
> I didn't see that in the cover letter.

For me yes, for distributions it is dependencies. This is already in
the v3 message:
https://lore.kernel.org/lkml/20250122174308.350350-1-irogers@google.com/

> It doesn't seem like a very good reason for such an intrusive patch kit.

The capstone and LLVM code is preexisting. Moving the capstone/llvm
code to their own files isn't dependent on dlopen, it does make it
nicer to have a single place we're doing dlopen. The change to shim
the capstone/LLVM calls looks like this:
https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/too=
ls/perf/util/llvm.c#L160-L182
That is a shim is introduced that either calls through to the function
if we're linking against libcapstone/llvm or does the dlsym. There are
7 such functions in the LLVM code. I don't think shimming 7 functions
is at the scale of hugely intrusive.

> If it's a serious concern maybe investigate an executable compressor?

Perhaps just have a squashfs partition.

Fwiw, excluding dependencies I think compression on the events is a
good solution. Convert json events/metrics to a sysfs file with the
cpuid in the path, add the compressed file to the binary as data, find
"json" events by iterating the directories in the compressed file,
etc. A single filesystem approach to event lookup can mean we do some
kind of unionfs style lookup of events, which could support users
adding their own events/metrics in a directory. Zip doesn't support
compressing across files, which is something of a requirement here,
other formats do but it's a case of optimizing for some kind of
libarchive sweet spot. The opportunity here is that about 70% of the
binary is event encodings, a compressed file is about 30% of the
current binary size, so we could reduce the binary size by about 40%.

> > The X86
> > disassembler alone in libllvm is of a size comparable to the perf tool
>
> I agree that LLVM is a serious bloat and DLL hell concern, but I don't th=
ink
> dlopen is the answer here.

Agreed, but it's where the code is at. addr2line command or use LLVM
for some performance. I think having an inbuilt solution would be best
longer term - we spend energy trying to parse and understand text
output from tools/libraries when the information is just sitting there
in the instruction encoding. Such a solution would be brittle for
things like new dwarf information, so we may want to have fallbacks
like LLVM but having a loosely coupled dependency using dlopen feels
preferable there, to aid package maintainers.

Thanks,
Ian

