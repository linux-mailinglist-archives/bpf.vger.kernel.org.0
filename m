Return-Path: <bpf+bounces-50052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EF3A22497
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 20:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E129B3A3F0D
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 19:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E61E2606;
	Wed, 29 Jan 2025 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0HmYxwJ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620F197552
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738179376; cv=none; b=bOEJfuq9GzarDKcKf90S+tTyvtZksNxbkg4vGmiSVHCPynUIF7ypDNKYnUP3EsUnMRiHepcCk5MUfxdsu0lShapUR1nEg1bbg/0Kc53cyjjEMx9yIYCSiN1LZw/RyRkEsuspv9uzuVja9ybZcIIdbGya43TY4ANRmihCVbG8OsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738179376; c=relaxed/simple;
	bh=aog1npG7zbwvqSDpQbzTFt1LmdJAZBP9KpuHlfTmsXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuOw74O+gyeHIBMhBarDlz9zEF18NKJ9NrfpjVWZ3pNK0CsMri7mg7j/Iq3zth81Kz8/+ed+zLXLC5tpK1dOOgJMgk/IE8YGA35IRRrbU8haqS0/qU4kgfTz0l6amKbcFstUCpHsNE2eFoUJuvbpTJGsDsoqFPghuClgkUmrktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0HmYxwJ4; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so19195ab.0
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 11:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738179374; x=1738784174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfFH/icuVW98ZGt4CSx3c++Z8r68yk+i5Ztzc10SRjo=;
        b=0HmYxwJ4LOW9bFJKd2cFv7WQuYJsfOZJNlwOs6IdItWZpgvBlJqhHkzQr/g4hXWTRU
         AuWi6m4fH8YkWsT+NFNhX7UcxCm7iC+/xtNreTpArKBeQ3CHVf1NYFSDCXPIXT5YPGdg
         xp22RKdq0fgySY+XEMiKJtupSm0JpQ7/prUw1p005ET1z0+QBjeGWdJUKety7/Nv9c6d
         YMh7zPCao7lyAYELpYxKjYRWgUdio+TiWcv3ISnubJnH+LEqkqFSqAd5eSn2hi26vVjj
         O56/Hh2cw5paVlg5cQlHUo+pxq5n7049eSXecn9TucJ88+KHyvpWPObEsVB+JBsm7xTE
         Ywow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738179374; x=1738784174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfFH/icuVW98ZGt4CSx3c++Z8r68yk+i5Ztzc10SRjo=;
        b=nLS0oBJD1W41AyDHxk+bGt/zuZhJg/ci5r4PXi1EHtLuObv9JXuUBHSTngT6cF2khJ
         NIVM/zIXpm7pxBHwX0Y0jh1TFqiY07RLnpk8+uXo3/mU+/7t+nuGQvAX6tPTLNU29Pez
         oXZySOjtHX122lo/5nE8bOBbST9dVbqxfDNuRXVDSC7Rtk2kXL/UbKqDj+VntJaNtmOv
         ucm3+1kg/BE2P/0ln9QJ4ei9IJ9q5rzMVSe6XdlQSKiP2Lqr8qxFeu2M/jvt4E9oONZH
         7BEj8Aw6yPEsVX47hO2mRb+ISogK7mVFG/zh3o3uNEM4NNinbHROtKmoEDr64e+fc1zL
         VnEw==
X-Forwarded-Encrypted: i=1; AJvYcCWV2U/+GaL0tSSOyaH/d3L/ZtbpQFf//pgoR2M7X8ABKb96Rvf+iehKGNH/BHK9uIy9dMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+up7z1t4FHIhIaPfCrdRkP3M6Sla+ppf58VSt52APaaKiDocr
	2iTYdgdCzBIFqw3DhXI1Y/ATlxcPQyLNMkTwpU4lNd8rDoUcGtFGU9XOcMKnA0CwSPFezkr2v7d
	VEuPv+U9zfn93U3DnOeGac5PhHGKwFYu9gBhK
X-Gm-Gg: ASbGncsdU3zXBj2olh1mRlpkQqydlCkuupeEUGQbezAYQIDy6wjvR5ioLD9dIlZJRg7
	T74P5m6v6DRnPVUVA/O6+UVO+EKRJXvppR/wV5p4AIDSkG4KhsTiDtJQyMybrV/dj/4c0rtvVBM
	OUUjsXoXM6icKC0blSPjGZF4bk
X-Google-Smtp-Source: AGHT+IHyvEbAe7I0uASeZ+x+1BrZI4xyMO5ykKohX5lInnnPkEZRh2gj5blNBgj45TmtVMq4eUjQ2lW7CVyEyBVLIP8=
X-Received: by 2002:a05:6e02:1987:b0:3ce:471b:1ae4 with SMTP id
 e9e14a558f8ab-3d009a2f410mr216695ab.5.1738179373545; Wed, 29 Jan 2025
 11:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com> <20250122174308.350350-14-irogers@google.com>
 <gnwmibvjtwboisw7uv32bdo4ziw4qzgwzvndqg2czpa6vp4olv@44n36ndbwobc>
 <CAP-5=fW9nM9zoQ5SQOq2HQfkougRotm=EBw99cvGDOpD=giK2g@mail.gmail.com> <jgxfnphfo3nzlfipnuuzdlfc4ehbr2tnh2evz3mdhynd6wvrsu@fcz6vrvepybb>
In-Reply-To: <jgxfnphfo3nzlfipnuuzdlfc4ehbr2tnh2evz3mdhynd6wvrsu@fcz6vrvepybb>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Jan 2025 11:36:02 -0800
X-Gm-Features: AWEUYZkc7cnANysO6DBXAQ06kDYu_R25G9BqfZ2LqG1BThHYjZpq_jsx4qaWxvk
Message-ID: <CAP-5=fVcF+F7ST3Ya0_3hXq69ArhZv0gy30U4SPC7Cqih7HAWA@mail.gmail.com>
Subject: Re: [PATCH v3 13/18] perf build: Remove libbfd support
To: Daniel Xu <dxu@dxuuu.xyz>
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
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 8:47=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Tue, Jan 28, 2025 at 05:40:44PM -0800, Ian Rogers wrote:
> > On Tue, Jan 28, 2025 at 4:31=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote=
:
> > >
> > > Hi Ian,
> > >
> > > On Wed, Jan 22, 2025 at 09:43:03AM -0800, Ian Rogers wrote:
> > > > libbfd is license incompatible with perf and building requires the
> > > > BUILD_NONDISTRO=3D1 build flag. Remove the code to simplify the cod=
e
> > > > base.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/Documentation/perf-check.txt |   1 -
> > > >  tools/perf/Makefile.config              |  38 +---
> > > >  tools/perf/builtin-check.c              |   1 -
> > > >  tools/perf/tests/Build                  |   1 -
> > > >  tools/perf/tests/builtin-test.c         |   1 -
> > > >  tools/perf/tests/pe-file-parsing.c      | 101 ----------
> > > >  tools/perf/tests/tests.h                |   1 -
> > > >  tools/perf/util/demangle-cxx.cpp        |  13 +-
> > > >  tools/perf/util/disasm_bpf.c            | 166 ----------------
> > > >  tools/perf/util/srcline.c               | 243 +-------------------=
----
> > > >  tools/perf/util/symbol-elf.c            |  86 +--------
> > > >  tools/perf/util/symbol.c                | 135 -------------
> > > >  tools/perf/util/symbol.h                |   4 -
> > > >  13 files changed, 7 insertions(+), 784 deletions(-)
> > > >  delete mode 100644 tools/perf/tests/pe-file-parsing.c
> > >
> > > [..]
> > >
> > > I was briefly investigating why the centos build of perf was not
> > > demangling rust v0 symbols [0]. From looking at the rust issue [1], i=
t
> > > appears the rust team somehow delivered support for v0 demangling
> > > through libbfd. The code itself looked a bit odd (relying on cxx
> > > demangle to run first?), but that's a separate thing.
> >
> > There is still C++ demangling support by way of cxxabi:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/demangle-cxx.cpp?h=3Dperf-tools-next#n44
> > that was in libstdc++ (GNU) and libcxx (LLVM) when I looked.
> >
> > > The centos build does not build with libbfd for the license issues yo=
u
> > > mentioned. So your change probably won't regress any distro use cases=
.
> > > But it does remove support for motivated users who don't have
> > > re-distribution requirements.
> > >
> > > But since this patchset came up first in my search, I thought it'd be
> > > good to mention that someone probably needs to add v0 support to
> > > tools/perf/util/demangle-rust.c.
> >
> > So I don't see any libbfd dependencies in demangle-rust.c:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/demangle-rust.c?h=3Dperf-tools-next#n8
> > Unusually we don't have any tests on the Rust demangling, we do for
> > Java and OCaml:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/demangle-java-test.c?h=3Dperf-tools-next
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/demangle-ocaml-test.c?h=3Dperf-tools-next
> >
> > Reading a bit more it seems that previous libiberty was coming to the
> > rescue by way of C++ demangling. I'll see if I can write a demangler
> > by way of lex and yacc.
>
> Cool :)

Not by way of lex and yacc, as it seemed overkill, but I sent out:
https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.com/
I only tested with the examples from the doc. If you could take a look.

> > If we have a v0 standard one is there any
> > value in the existing demangler or legacy demangling? It seems this
> > has been broken for the best part of 5 years.
>
> I believe the "legacy" symbol format is still the rust default. So
> probably can't remove that. Looks like there's some desire to change
> that, probably probably not very soon [0].
>
> That probably also explains why nobody reported the breakage - only very
> cool kids are using v0 scheme currently.

Ok. I wasn't sure on the status so I've tried to incorporate the
previous legacy support and the v0 support in my patch.

Thanks,
Ian

> Thanks,
> Daniel
>
>
> [0]: https://github.com/rust-lang/rust/pull/89917

