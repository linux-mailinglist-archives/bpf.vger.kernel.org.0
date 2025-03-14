Return-Path: <bpf+bounces-54019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF2A60882
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 06:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD78E17F035
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 05:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54314B976;
	Fri, 14 Mar 2025 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T43dQIdq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E356148838
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931711; cv=none; b=Gyb/2xwdKTvsnZT6g23K/u3+xxjkRMAyHqVwF0nI+8X9Lhd/og+t/CHI9qnq8X0ulkOvO3vsf4/7PysNQAGbJlevrxYnrNIOgYv1tTOGZ2200GTQsynHejFLEAVff+mem0rGfqmpQmeE+lsHSR08zc3EM5Je8+tm5OyTHu57nc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931711; c=relaxed/simple;
	bh=urZDD7SqMI1dPeUfSX17Ch/qC8OVmVTVKPjzd7UPYPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOp9CN24/LN9juv675RX9mjy2Uk8RMhS3gjhhjaJeKjh58YFFAsFfvBnA2AvdXK2FAjBYt1tqxE93Q5VVbel2wBTgTaUrESrInFSb1NF7tMFgxetJDs6t6PlJVOQ/DFzgKoyd6Ol5V+Fm5Y597F55oOAk+O9U7SmaEkIBCErYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T43dQIdq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225489a0ae6so107625ad.0
        for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 22:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741931708; x=1742536508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyhsHWhKQvd+JYS7FBXku46dzZupP9OzOBkxq4HnRPc=;
        b=T43dQIdqyp3ytr1kRatF9RVwnfYguJH8eH6Z8hG5m9i5cOottoKMBaATR0yWKSq+34
         qNVZJ6MuekSYZNME0YEHBB5R5OH5oSl3ZzjKTnt8m/moqURrMyYf/ng61i6O89aAnCgT
         A41VwfCIKOhW8FelbyC/Htx8DCErw4vjNyv3WOTK6vVetBkdENBDqwAep00dUdVIXF2T
         q6yU7jJlwhbJobh7poKv6wGkkIXuuzSvWGBPJhDggqvgz06dzNd0O/0OD4BFya7v2/CD
         0YZQWdDGnPUiUqCRGBnU21y54iYhIrN4CxLfTlPn0HBZqtBKUKtGwZkCqk/v+PPRWL9m
         O+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741931708; x=1742536508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyhsHWhKQvd+JYS7FBXku46dzZupP9OzOBkxq4HnRPc=;
        b=B5KsuRyM+cCTurV9YiK2X8sM+YBvYkj4xtCJupjXNjZSJ7XOQ/E3XcL+Ur4H3tbADr
         5T1OBBzf1F8SrJd1qWTBaa7A8e/A8V0clDqtEmN+5Yna7bYnQgkksQqTXWUyFy+h6RK0
         aq6DuR7tLg+G1+5AMqrwlPCn+vtGerQ69uT3VaJPOO/hDGZ50HP79jQbdg30T0omZBFw
         O/jHK/GZDpFT46akWHALZxUxkBQvHNp6QwHtlPMB3AasoCGVdU18fnaXBwholT1cISpM
         YgDzonQEWm+q+YFtDArfwUXsATVTaIjA/kKuotQgpcykCsex0qCDLy3aedfa8ZM/WU+V
         p9ww==
X-Forwarded-Encrypted: i=1; AJvYcCXlK58VYBO/+WdqZA7ZjDZCI7GaDOywNucuO4+/QQ5yHkrofV5sPCqW0bZlDyGQCd37Obc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxROpyaReun8ASJ1v1qDSGIVHN0kZVs8d2ykLloYYqNhhJQ2/q
	X2+R29P1xkCM085td5T1mUi4Sba9PkqlrkAVXRx0Sdf3OI/pOk6Z9o5ZXam8jSpdgafHHyeyaeC
	MDhnz/G359tGkAlcdeyD8GJUJ4b7vnYm7G9MN
X-Gm-Gg: ASbGncsA0ll/1wjwf1dEO7efn4JNcmfmjCnbDnH1XEM7iwBOjtSciw/4FUy8wYqbiBS
	n26uX4280ssocKBa1DZgQwp5Sh4dtjJ7ZVPQWZkN8/eP8Hcnup+vDuO8tDEwFmH1QQQ4hCQH4Ic
	8MpswoYhVU+GbsXSnv6YxNWS463j8=
X-Google-Smtp-Source: AGHT+IEgLWIAjxCjYNH0X+NtNqkuwI/bPH4Uumyk01Hxp41RAM67Lx0FYNOYHRHcAIdc8VeJeEOB7hLlngI/eMqwcbI=
X-Received: by 2002:a17:902:d509:b0:21f:4986:c7d5 with SMTP id
 d9443c01a7336-225de74a016mr2010415ad.8.1741931708229; Thu, 13 Mar 2025
 22:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com> <Z5K712McgLXkN6aR@google.com>
 <CAP-5=fX2n4nCTcSXY9+jU--X010hS9Q-chBWcwEyDzEV05D=FQ@mail.gmail.com>
 <CAP-5=fUHLP-vtktodVuvMEbOd+TfQPPndkajT=WNf3Mc4VEZaA@mail.gmail.com>
 <CAP-5=fV_z+Ev=wDt+QDwx8GTNXNQH30H5KXzaUXQBOG1Mb8hJg@mail.gmail.com> <Z9NbFqaDQMjvYxcc@google.com>
In-Reply-To: <Z9NbFqaDQMjvYxcc@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Mar 2025 22:54:57 -0700
X-Gm-Features: AQ5f1JpmtjskMcZorXzTagF_PQQ_b8arX_0AF-lPzn55eWXEmzSyGiUvOZGlAFk
Message-ID: <CAP-5=fUdXRv512ZFiQKtxouNzN+HgommWGF3Pje1Tcuxg=J78Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
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
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Wed, Mar 12, 2025 at 02:04:30PM -0700, Ian Rogers wrote:
> > On Mon, Feb 10, 2025 at 10:06=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > On Thu, Jan 23, 2025 at 3:36=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > > On Thu, Jan 23, 2025 at 1:59=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > > I like changes up to this in general.  Let me take a look at the
> > > > > patches.
> > >
> > > So it would be nice to make progress with this series given some leve=
l
> > > of happiness, I don't see any actions currently on the patch series a=
s
> > > is. If I may be so bold as to recap the issues that have come up:
> > >
> > > 1) Andi Kleen mentions that dlopen is inferior to linking against
> > > libraries and those libraries aren't a memory overhead if unused.
> > >
> > > I agree but pointed-out the data center use case means that saving
> > > size on binaries can be important to some (me). We've also been tryin=
g
> > > to reduce perf's dependencies for distributions as perf dragging in
> > > say the whole of libLLVM can be annoying for making minimal
> > > distributions that contain perf. Perhaps somebody (Arnaldo?) more
> > > involved with distributions can confirm or deny the distribution
> > > problem, I'm hoping it is self-evident.
> > >
> > > 2) Namhyung Kim was uncomfortable with the code defining
> > > types/constants that were in header files as the two may drift over
> > > time
> > >
> > > I agree but in the same way as a function name is an ABI for dlysym,
> > > the types/constants are too. Yes a header file may change, but in
> > > doing so the ABI has changed and so it would be an incompatible chang=
e
> > > and everything would be broken. We'd need to fix the code for this,
> > > say as we did when libbpf moved to version 1.0, but using a header
> > > file would only weakly guard against this problem. The problem with
> > > including the header files is that then the build either breaks
> > > without the header or we need to support a no linking against a
> > > library and not using dlopen case. I suspect a lot of distributions
> > > wouldn't understand the build subtlety in this, the necessary build
> > > options and things installed, and we'd end up not using things like
> > > libLLVM even when it is known to be a large performance win. I also
> > > hope one day we can move from parsing text out of forked commands, as
> > > it is slower and more brittle, to just directly using libraries.
> > > Making dlopen the fallback (probably with a warning on failure) seems
> > > like the right direction for this except we won't get it if we need t=
o
> > > drag in extra dependency header files for the build to succeed (well
> > > we could have a no library or dlopen option, but then we'd probably
> > > find distributions packaging this and things like perf annotate
> > > getting broken as they don't even know how to dlopen a library).
> > >
> > > 3) Namhyung Kim (and I) also raises that the libcapstone patch can be
> > > smaller by dropping the print_capstone_detail support on x86
> > >
> > > Note, given the similarity between capstone and libLLVM for
> > > disassembly, it is curious that only capstone gives the extra detail.
> > >
> > > I agree. Given the capstone disassembly output will be compromised we
> > > should warn for this, probably in Makefile.config to avoid running
> > > afoul of -Werror. It isn't clear that having a warning is a good move
> > > given the handful of structs needed to support print_capstone_detail.
> > > I'd prefer to keep the structs so that we haven't got a warning that
> > > looks like it needs cleaning up.
> > >
> > > 4) Namhyung Kim raised concerns over #if placement
> > >
> > > Namhyung raised that he'd prefer:
> > > ```
> > > #if HAVE_LIBCAPSTONE_SUPPORT
> > > // lots of code
> > > #else
> > > // lots of code
> > > #endif
> > > ```
> > > rather than the #ifs being inside or around individual functions. I
> > > raised that the large #ifs is a problem in the current code as you
> > > lose context when trying to understand a function. You may look at a
> > > function but not realize it isn't being used because of a #if 10s or
> > > 100s of lines above. Namhyung raised that the large #ifs is closer to
> > > kernel style, I disagreed as I think kernel style is only doing this
> > > when it stubs out a bunch of API functions, not when more context
> > > would be useful. Hopefully as the person writing the patches the styl=
e
> > > choice I've made can be respected.
> > >
> > > 5) Daniel Xu raised issues with the removal of libbfd for Rust
> > > support, as the code implies libbfd C++ demangling is a pre-requisite
> > > of legacy rust symbol demangling
> > >
> > > A separate patch was posted adding Rust v0 symbol demangling with no
> > > libbfd dependency:
> > > https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.c=
om/
> > > The legacy support should work with the non-libbfd demanglers as
> > > that's what we have today. We should really clean up Rust demangling
> > > and have tests. This is blocked on the Rust community responding to:
> > > https://github.com/rust-lang/rust/issues/60705
>
> I think #ifdef placements is not a big deal, but I still don't want to
> pull libcapstone details into the perf tree.
>
> For LLVM, I think you should to build llvm-c-helpers anyway which means
> you still need LLVM headers and don't need to redefine the structures.
>
> Can we do the same for capstone?  I think it's best to use capstone
> headers directly and add a build option to use dlopen().

So I don't disagree. If we have headers but someone wants dlopen,
let's use the headers and let them use dlopen. Unfortunately the way
the build is set up isn't for that. The build assumes either:
1) you have libcapstone and its headers and want to link against it,
2) you don't have libcapstone and support is just removed.

In the changes the options become:
1) unchanged, if you have libcapstone then use the headers and link
against - this is Andi's preferred approach,
2) if you don't have libcapstone dlopen is used with constants derived
from pahole and baked into the sources - much as we do for vmlinux.h
in BPF programs.

One way to achieve what you are asking for is to make the build do:
1) the link against libcapstone approach that needs the headers,
2) the dlopen with capstone.h headers,
but we need a way to build without libcapstone, so we get:
3) possibly dlopen with pahole derived constants - but if we have that
then why do 2?
4) a no support option.

The problem is that if we don't do (3) then (4) will become the no
libcapstone option and frankly people who care will do (1) and so (2)
becomes redundant.
It was intentional doing the changes the way I have so that when you
don't build with libcapstone, were you later to add the library you
would gain support for it. This is with the down side of a small
number of constants being in the code. Potentially these could change
in the header files, but any such change is an ABI breakage and so
unlikely to happen. So I think the way the patches have things set up
is best.

Thanks,
Ian

