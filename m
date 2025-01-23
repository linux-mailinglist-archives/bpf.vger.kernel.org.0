Return-Path: <bpf+bounces-49622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E106A1AD47
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 00:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873FB167EA4
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 23:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0546A1D5ADE;
	Thu, 23 Jan 2025 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwpz1Nsu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC01CEE8C
	for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737675388; cv=none; b=Vh9o12qrU45hT7BSFYQGW45V+9ICTgNb8gHy37PSTTnRHhOAoLv4oPPqPZqub3JWNJI7Niw7OyF2JVZRoHZ9idqUsXg0oCRmBi6+3/l9PUizxOgyrwxtM2r8AjEXrPeCgXt1CDnmkQzEldbQwTdukoVU0Mt7aSjogKAk0NHhQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737675388; c=relaxed/simple;
	bh=mX+bhjaU4+tyU0YNDvGKwPHDqYwLaTa0D1aykgl1osM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLN+6IIfhnPrRqnbDjtpWY5eD/ikx9czKA1t/Is90fmc32+GfcINuLBRavaEc2cx+7JMe1v0D58OXVklRdPs8MEiuht7AhHtnorTiDRoNO60xCGXGdECAwb9Dntkq60OXBdY6z2JCc/r0QteZP+t2ZzrzoepWdc4h9KnbmlsIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwpz1Nsu; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so37765ab.0
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 15:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737675386; x=1738280186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQWIJTKgmSuU/0hLaYv81afc36/rsOvr4FPywbIsP+o=;
        b=vwpz1Nsu80m6Ip11ikiQSBihMVc2uSlOc+ZsdXtXgxWmGl+s0uW0ptixK0qjOX+ogS
         8p8NaWkR03BKcU1gl8eFRTr5+qVZpFHiFRsoe1BKxuEHqVnQwWcJxt+dMg4p0lNddJKw
         CbD4aI8IOEu/7Tbq188OIKR7dloIUX+4PDOJ88mC1nTQA/r06G3xi2ado7Lf2OuToqDU
         N7/p61dEvGi89czi8ynm4yzq0gEmH9Xe2JLGAOWZQzpPsZWAp1JtJhGyPZFcxMu+GawD
         1qfDIkE6Htmg+xo7YV3oSXyYOuOAOahMM/p4tO0SzpGjXsAWdbQwDY6Gj6w6bvh/1h+s
         AkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737675386; x=1738280186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQWIJTKgmSuU/0hLaYv81afc36/rsOvr4FPywbIsP+o=;
        b=feQXqq5JXUNzJRvWnmeZFAaCAncI4WhqBgywrgVY44VZaGvqbAszT5+CSAHarTUuNj
         8ZtnVcrdRg6QdvfurqXAsAqoqQgizR3VCMNjG+czGS3kkiJlId73XtTNED4YRtnk9n2L
         C0aGNdn7NyLH4CaM0UEk2U91L0kzBBzKdT0599HSqAKxS6pQ7qdzY6NF3rkzPwJto3v1
         4/lqLSWeeW6PrmRL/QY9hUKIryCEWDUrFHnXimEVnnrN3pzFuPvDlfZqHPE4T/ehWViR
         Afxvfpn2j+bQ5ex+VFysbYDguRgmXArI8xCbMCsxiBbZQSwQl2voZNtFB+mmeoTJ+xDu
         6D9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwGjylwCR86w1X6p4uWbjV9uYXjhxmO2/BmncMzTfu/OtcfiVJ+MZzoHrj84EpHpwxSIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0f7ba4rxdAojDGWplsyugBfp/e6bYB5ImcV5TIIXrEoDhaRs
	9IGz4Yvylv9PfthEdveihe1MhMap7NnauZe51TiXWuYzn1D1/OMu+Lqprc8GLUmsu/4D3wfnOmR
	L5U1ZjV2rvaruBjDklpy8u7ytQ+3yDnFCtDyk
X-Gm-Gg: ASbGncu1f0TKxBMRj+tqIwQ4a4G/+oZGw4FhYPMAkTIot6Poq27rb47korKO2/opp4g
	ermlVtQKlZFtSY8L4P/FHbibMgaL3fXSUaRECVWKZqxfV+1YmbgkIvjIsql6VgAgiKXYXx8N/Gk
	Tyx6nmhFVXea7JFg==
X-Google-Smtp-Source: AGHT+IFFEHA8S7Jm/MSuIYwTx+AWwwIIWpO6M06a1I7jCX8Tk9g/h+72gUDoKNlt1oo07ukMe4cZ1nUCIWXHOq77Hk4=
X-Received: by 2002:a05:6e02:2685:b0:3a7:683e:2fb0 with SMTP id
 e9e14a558f8ab-3cfbc90ccc7mr6269445ab.6.1737675385869; Thu, 23 Jan 2025
 15:36:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com> <Z5K712McgLXkN6aR@google.com>
In-Reply-To: <Z5K712McgLXkN6aR@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Jan 2025 15:36:14 -0800
X-Gm-Features: AWEUYZlsArDtt5C7cJjJiyeindS8a6XImZjqfVccO_XajuQQ3sp6lx_PcTyJvBY
Message-ID: <CAP-5=fX2n4nCTcSXY9+jU--X010hS9Q-chBWcwEyDzEV05D=FQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 1:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Jan 21, 2025 at 10:23:15PM -0800, Ian Rogers wrote:
> > Linking against libcapstone and libLLVM can be a significant increase
> > in dependencies and size of memory footprint. For something like `perf
> > record` the disassembler and addr2line functionality won't be
> > used. Support dynamically loading these libraries using dlopen and
> > then calling the appropriate functions found using dlsym.
>
> It's not clear from the description how you would use dlopen/dlsym.
> Based on an offline discussion, you want to leave the current linking
> model as is, and to support dlopen/dlsym when it's NOT detected at
> build-time, right?

Yep. Current behavior is no header file than these options fail, new
behavior is that we try to use dlopen/dlsym and fail if the dlopen
fails.

> For that, you need to carry some definitions of the functions and types
> for the used APIs.  But I'm not sure if it's right to carry them in the
> perf code base.

Right. I mention that here:
https://lore.kernel.org/lkml/CAP-5=3DfUhNuybCU-2_5EgcCwgwXnxvyFMvyhzKe=3DZP=
1bssQwXHw@mail.gmail.com/
For LLVM we need 3 typedefs and 5 #defines, for capstone we need 2
structs and 5 enums (if we #ifdef some x86 only formatting code).

The problem in not carrying those definitions is:
1) if the header file isn't present a build won't support
LLVM/capstone even by dlopen - everything falls through to
objdump/addr2line that have known performance issues;
2) package maintainers either need to spot a warning message to
realize they've done this by having a missing header file (hard to
spot and brittle) or we require the build to fail and people without
capstone.h opt out of the build error with NO_CAPSTONE=3D1 - something
perf developers will probably not like;
3) the LLVM/capstone code needs #ifdefs and __maybe_unused to suppress
compiler warnings, or perhaps we have a minimal version of those
files, leading to extra code complexity.

I believe the approach here is no worse than what we do with vmlinux.h
for BPF code and is robust as depending on dlsym being able to look up
the function names. It is not perfect but I think it is more perfect
and less complex than the alternative.

> >
> > BUILD_NONDISTRO is used to build perf against the license incompatible
> > libbfd and libiberty libraries. As this has been opt-in for nearly 2
> > years, commit dd317df07207 ("perf build: Make binutil libraries opt
> > in"), remove the code to simplify the code base.
>
> This part can be a separate series.

Right, I posted it as a series here:
https://lore.kernel.org/lkml/20250111202851.1075338-1-irogers@google.com/
as mentioned in the v2 notes below. The issue was that Arnaldo pointed
out removing BUILD_NONDISTRO removed disassemble_bpf that had only
been implemented for libbfd. This series adds the LLVM/capstone
definitions built into the symbol__disassemble refactor. Merging that
series would conflict with this series, so I posted everything
together to avoid having series of patches depending upon one another.
I also wanted to check that what is in disasm.c in the end is
reasonable, which I believe it is with significantly reduced
ifdef-ery.

> >
> > The patch series:
> > 1) does some initial clean up;
> > 2) moves the capstone and LLVM code to their own C files,
> > 3) simplifies a little the capstone code;
>
> I like changes up to this in general.  Let me take a look at the
> patches.

Thanks,
Ian
Ian

> Thanks,
> Namhyung

