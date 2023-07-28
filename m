Return-Path: <bpf+bounces-6259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B54C7675BC
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 20:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C7651C2157E
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C929A156C5;
	Fri, 28 Jul 2023 18:43:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0DB1426E;
	Fri, 28 Jul 2023 18:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95535C433C7;
	Fri, 28 Jul 2023 18:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690569796;
	bh=EtSfBpi27VvgA4ooHcYUqNF5uegw1JHfetF61N9a7HQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPG1l3xH1ifeG6nhuOiFu05xMcBxSGuWRwPUrh+Bm9KyctZ30P3wuw5Id1XXMksEE
	 Zl/qm8Qnc8BNtkx/1HPlt1ZbQtYXI16Ay8ILYVzEBlC6lsGDcDHZSppyl2kN+vfk32
	 rUbUfZHt+FAe3adEZHdQqB3vnV+gseOSPZyc7aF/fMAIXQ6/9WASxu9QRh1SP6bFGY
	 +toq7o+GxDROIm/8cSot0XyXUzy5CJMY9/DDWs2eE+7Oijp47bHC7gzZiNO8fxhEuC
	 WayJTloYrIp3+kdAhpenXfRufIA5L/wurp7eUwXk+GrfRY9d5DRSGy7AVknzMgE0zt
	 p5qzC56zCUpOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 6EF2E40096; Fri, 28 Jul 2023 15:43:14 -0300 (-03)
Date: Fri, 28 Jul 2023 15:43:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Kan Liang <kan.liang@linux.intel.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v1 4/6] perf build: Disable fewer flex warnings
Message-ID: <ZMQMQoCtBytgwB4i@kernel.org>
References: <20230728064917.767761-1-irogers@google.com>
 <20230728064917.767761-5-irogers@google.com>
 <a8833945-3f0a-7651-39ff-a01e7edc2b3a@arm.com>
 <ZMPJym7DnCkFH7aA@kernel.org>
 <ZMPKekDl+g5PeiH8@kernel.org>
 <CAP-5=fX2LOdd_34ysAYYB5zq5tr7dMje35Nw6hrLXTPLsOHoaw@mail.gmail.com>
 <ZMQEfIi/BYwpDIEB@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMQEfIi/BYwpDIEB@kernel.org>
X-Url: http://acmel.wordpress.com

Em Fri, Jul 28, 2023 at 03:10:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Jul 28, 2023 at 08:26:54AM -0700, Ian Rogers escreveu:
> > On Fri, Jul 28, 2023 at 7:02 AM Arnaldo Carvalho de Melo
> > > I added this to the patch to get it moving:
> > >
> > > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> > > ⬢[acme@toolbox perf-tools-next]$ git diff
> > > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > > index 32239c4b0393c319..afa93eff495811cf 100644
> > > --- a/tools/perf/util/Build
> > > +++ b/tools/perf/util/Build
> > > @@ -281,7 +281,7 @@ $(OUTPUT)util/bpf-filter-bison.c $(OUTPUT)util/bpf-filter-bison.h: util/bpf-filt
> > >
> > >  FLEX_GE_264 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 264)
> > >  ifeq ($(FLEX_GE_264),1)
> > > -  flex_flags := -Wno-redundant-decls -Wno-switch-default -Wno-unused-function
> > > +  flex_flags := -Wno-redundant-decls -Wno-switch-default -Wno-unused-function -Wno-misleading-indentation
> > >  else
> > >    flex_flags := -w
> > >  endif
> > > ⬢[acme@toolbox perf-tools-next]$
> > >
> > >
> > > > 1 error generated.
> > > > make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: util/parse-events-flex.o] Error 1
> > > > make[4]: *** Waiting for unfinished jobs....
> > > >   LD      util/scripting-engines/perf-in.o
> > > > make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:140: util] Error 2
> > > > make[2]: *** [Makefile.perf:682: perf-in.o] Error 2
> > > > make[2]: *** Waiting for unfinished jobs....
> > > >   CC      pmu-events/pmu-events.o
> > > >   LD      pmu-events/pmu-events-in.o
> > > > make[1]: *** [Makefile.perf:242: sub-make] Error 2
> > > > make: *** [Makefile:70: all] Error 2
> > > >
> > > > ⬢[acme@toolbox perf-tools-next]$ clang --version
> > > > clang version 14.0.5 (Fedora 14.0.5-2.fc36)
> > > > Target: x86_64-redhat-linux-gnu
> > > > Thread model: posix
> > > > InstalledDir: /usr/bin
> > > > ⬢[acme@toolbox perf-tools-next]$
> > 
> > Thanks James/Arnaldo, I was trying to be aggressive in having more
> > flags, but it seems too aggressive. We should probably bring back the
> > logic to make this flag only added if it is supported:
> >   CC_HASNT_MISLEADING_INDENTATION := $(shell echo "int main(void) {
> > return 0 }" | $(CC) -Werror -Wno-misleading-indentation -o /dev/null
> > -xc - 2>&1 | grep -q -- -Wno-misleading-indentation ; echo $$?)
> >   ifeq ($(CC_HASNT_MISLEADING_INDENTATION), 1)
> >     flex_flags += -Wno-misleading-indentation
> >   endif
> > Arnaldo, is the misleading indentation in the bison generated code or
> > something copy-pasted from the parse-events.l ? If the latter we may
> > be able to fix the .l file to keep the warning.
> 
> I haven't checked, lemme do it now.

It comes directly from flex's m4 files:

https://github.com/westes/flex/blob/master/src/c99-flex.skl#L2044

So I'll keep the -Wno-misleading-indentation, ok?

- Arnaldo

