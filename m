Return-Path: <bpf+bounces-50013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F4A21625
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 02:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A5D1888B94
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 01:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842D8187FFA;
	Wed, 29 Jan 2025 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQRZ/T15"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B536B14A60A
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738114860; cv=none; b=ni2V3FXyWbNb+yQVj87yZhF3+GqMJ+iK/yaJYoZrhuTKtcHa1mZFudhgZ/Lwv/LvHK0nDmHyimF2OhOv53xcz1QzNYK/DuyQw5Ii4L/WoER7HQ9+v1uQ1KyuN0UgLqnneQXjRUV9NCFFMp1DyQ7zidDkfAniOooj2QBscR4I1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738114860; c=relaxed/simple;
	bh=3IaWesmiWr2cicrwXcF3eLCCczCO762Csg6QxbQA5w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3qj83qD8yyTgQ6eYEH3UZbzMpIasm7Rbgt5sPl8L/BorvOGi+z5VpDf+Nv1LV1YFeAsysMH5WCAlytkUWw6R8i/A7sgwFuNCSErNOISdHuzakkAMIJ/W/4dCuHVUAbRgTgvQuhQllQYblX0LWRTKtvfhC4DMmXs+mGNFyjLNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQRZ/T15; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so193475ab.0
        for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 17:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738114857; x=1738719657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDsy6RSZpz9ow77za79sOYqCvwLqRyj79gdVd/xMSAY=;
        b=RQRZ/T15JG+nd0KF3n2FMbmTJX1oVt2HmeLlxWSsfNdc1hC78s+M+Fk54EdxVxaG0y
         KKmdssyfUX5w1s9WeRNl2gLtSwcEBN5+dyicec2Cka+MlrUrF0pUi5+VuU/A7sMfDGaE
         JeP8bc+CFWkj5Res5UvAu4F98VL/R+RKA76uPJtHwMYTMmKwGKF7mP3RpoCIEto+XV91
         1K9UZXJe/9GW5IbeWXIQzAH17q+rWgYsIXYejvzZbxq/isctWVID+IVTcPqzSJ2s2Op0
         x6JQR1tM3W82SE5zcmFZrCXecYiPr19rvQmxHbixwC2iV6qKPtXna81aYUFeowbB6K65
         yWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738114857; x=1738719657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDsy6RSZpz9ow77za79sOYqCvwLqRyj79gdVd/xMSAY=;
        b=mLouAK/Dew47E4X666aZrLbR3ng2NPizgaIYvWKeajOTzPKhDpzf4R3in2d6AuUuQf
         MTX8S/uN96NIWcfoPoKMaTe/jVeL325xyF+la/ZKMMHv5VMVCzizWxLxIDxleXuiPYRt
         a0XTBtBHdkX4Xivlu7cl+ePXF/pEGyrjm7RiB7Ojyjp5+gEo2sNgBLdqI3TDqPfRBuVq
         ectOTttWeCTOLo/rWlf5SPCw801pDygypNOlpRXfMF5zE3Q35PEK4pdZjmUYPMm5tsm5
         0uUsCQ6D+9SdSWm5I4pwVldVYN09J58inGyCECWN3vqMzR8WBbcR5D3KofA9RcodEUpN
         O1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCX69IAa13s8qdop/fsW65UMqEadTxT1/kOFu7LmDdyrYMG00Pa4cSyWAzDAzqjC9OkHl0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNXM+RKelzB7nA/RIAKyh9juE9H69bydnoMRZmaf6Fay5db3kK
	qn4VacQ2lCsWDNZL1JW17EJM1SuRdOh4Z12484LTPfqI4inA5TxKwdK9JckOG9TATkuSR/wzQre
	5HNa3NKioDrZ70D0MSD5E3UIOm+1zME+YKbvp
X-Gm-Gg: ASbGncs4FLadT075oyWBIoz6dKLyfAnN88NJPSlT5WPQoi+v69wD9Wt2pmFy+TkGghx
	6TtfDPXe1xzf1XDaGF/qL4vLMY0JkqegFdIBw6pZa3wbPPMpUPLDesXS9+7zblEb51WUgpOZ00A
	==
X-Google-Smtp-Source: AGHT+IFtwPircGx0cNqjWjLXFmuseDyJD49YXj0Fjsi0wsyI07WjwQhxx/Ru+LcHanJh3mJtoFcQQlcSOkqFnI4iTpw=
X-Received: by 2002:a05:6e02:1fc3:b0:3cf:c8b9:8826 with SMTP id
 e9e14a558f8ab-3cffeb833fdmr1919285ab.10.1738114856600; Tue, 28 Jan 2025
 17:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com> <20250122174308.350350-14-irogers@google.com>
 <gnwmibvjtwboisw7uv32bdo4ziw4qzgwzvndqg2czpa6vp4olv@44n36ndbwobc>
In-Reply-To: <gnwmibvjtwboisw7uv32bdo4ziw4qzgwzvndqg2czpa6vp4olv@44n36ndbwobc>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Jan 2025 17:40:44 -0800
X-Gm-Features: AWEUYZlLjbLqgBHdACScPUyTzPQSG4bYslu6-GduAeDhlw3y6CZbVRjCdWJ9YaA
Message-ID: <CAP-5=fW9nM9zoQ5SQOq2HQfkougRotm=EBw99cvGDOpD=giK2g@mail.gmail.com>
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

On Tue, Jan 28, 2025 at 4:31=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi Ian,
>
> On Wed, Jan 22, 2025 at 09:43:03AM -0800, Ian Rogers wrote:
> > libbfd is license incompatible with perf and building requires the
> > BUILD_NONDISTRO=3D1 build flag. Remove the code to simplify the code
> > base.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-check.txt |   1 -
> >  tools/perf/Makefile.config              |  38 +---
> >  tools/perf/builtin-check.c              |   1 -
> >  tools/perf/tests/Build                  |   1 -
> >  tools/perf/tests/builtin-test.c         |   1 -
> >  tools/perf/tests/pe-file-parsing.c      | 101 ----------
> >  tools/perf/tests/tests.h                |   1 -
> >  tools/perf/util/demangle-cxx.cpp        |  13 +-
> >  tools/perf/util/disasm_bpf.c            | 166 ----------------
> >  tools/perf/util/srcline.c               | 243 +-----------------------
> >  tools/perf/util/symbol-elf.c            |  86 +--------
> >  tools/perf/util/symbol.c                | 135 -------------
> >  tools/perf/util/symbol.h                |   4 -
> >  13 files changed, 7 insertions(+), 784 deletions(-)
> >  delete mode 100644 tools/perf/tests/pe-file-parsing.c
>
> [..]
>
> I was briefly investigating why the centos build of perf was not
> demangling rust v0 symbols [0]. From looking at the rust issue [1], it
> appears the rust team somehow delivered support for v0 demangling
> through libbfd. The code itself looked a bit odd (relying on cxx
> demangle to run first?), but that's a separate thing.

There is still C++ demangling support by way of cxxabi:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/demangle-cxx.cpp?h=3Dperf-tools-next#n44
that was in libstdc++ (GNU) and libcxx (LLVM) when I looked.

> The centos build does not build with libbfd for the license issues you
> mentioned. So your change probably won't regress any distro use cases.
> But it does remove support for motivated users who don't have
> re-distribution requirements.
>
> But since this patchset came up first in my search, I thought it'd be
> good to mention that someone probably needs to add v0 support to
> tools/perf/util/demangle-rust.c.

So I don't see any libbfd dependencies in demangle-rust.c:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/demangle-rust.c?h=3Dperf-tools-next#n8
Unusually we don't have any tests on the Rust demangling, we do for
Java and OCaml:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/demangle-java-test.c?h=3Dperf-tools-next
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/demangle-ocaml-test.c?h=3Dperf-tools-next

Reading a bit more it seems that previous libiberty was coming to the
rescue by way of C++ demangling. I'll see if I can write a demangler
by way of lex and yacc. If we have a v0 standard one is there any
value in the existing demangler or legacy demangling? It seems this
has been broken for the best part of 5 years.

Thanks,
Ian

> Thanks,
> Daniel
>
>
> [0]: https://doc.rust-lang.org/rustc/symbol-mangling/v0.html
> [1]: https://github.com/rust-lang/rust/issues/60705

