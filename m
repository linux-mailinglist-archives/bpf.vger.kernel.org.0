Return-Path: <bpf+bounces-6202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE38766EF0
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E8E282783
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1844B13AE3;
	Fri, 28 Jul 2023 13:59:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D244813ACA;
	Fri, 28 Jul 2023 13:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E58DC433C7;
	Fri, 28 Jul 2023 13:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690552781;
	bh=F3dxrjgbvuK9UxFq0YQioOFyWmM5w9lhpsGUFhh3HYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TDhAXHeNYDqPzWDzPF1GiG62aQfnHSgcNXvP2CDN7AzMswajRDbm6xRFrxzZ2ypOp
	 x+Do7ECw8mF4tVlDeZR5OqLgLOwxhZc4SD7GDvOhPfDnQYZ+aK0isbgAbx6VIWupx+
	 xtYgOEV6br6tMzhLdYKtwLM9UFvNGSYs7d/CvHSGE6Ovrp7V07LVd922j5k0wrjemp
	 /TNzXdnh9IkQ6DjYB+jSMJV2CLhQs2vjeacVpPBfK8Bzg+sIT+tA/eYQkbv1ZIPPh0
	 ILykb1OWtw64yZ6WMxK1wW9torVkaPbwBlry4m1Vpj+p2aRFQwmARgz1oKMaq5t2Xl
	 q0xARtSekqIfQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 48D0C40096; Fri, 28 Jul 2023 10:59:38 -0300 (-03)
Date: Fri, 28 Jul 2023 10:59:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <ZMPJym7DnCkFH7aA@kernel.org>
References: <20230728064917.767761-1-irogers@google.com>
 <20230728064917.767761-5-irogers@google.com>
 <a8833945-3f0a-7651-39ff-a01e7edc2b3a@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8833945-3f0a-7651-39ff-a01e7edc2b3a@arm.com>
X-Url: http://acmel.wordpress.com

Em Fri, Jul 28, 2023 at 09:50:59AM +0100, James Clark escreveu:
> 
> 
> On 28/07/2023 07:49, Ian Rogers wrote:
> > If flex is version 2.6.4, reduce the number of flex C warnings
> > disabled. Earlier flex versions have all C warnings disabled.
> 
> Hi Ian,
> 
> I get a build error with either this one or the bison warning change:
> 
>   $ make LLVM=1 -C tools/perf NO_BPF_SKEL=1 DEBUG=1
> 
>   util/pmu-bison.c:855:9: error: variable 'perf_pmu_nerrs' set but not
> used [-Werror,-Wunused-but-set-variable]
>     int yynerrs = 0;
> 
> I tried a clean build which normally fixes these kind of bison errors.
> Let me know if you need any version info.

Trying to build it with the command line above I get:

  CC      util/expr.o
  CC      util/parse-events.o
  CC      util/parse-events-flex.o
util/parse-events-flex.c:7503:13: error: misleading indentation; statement is not part of the previous 'if' [-Werror,-Wmisleading-indentation]
            if ( ! yyg->yy_state_buf )
            ^
util/parse-events-flex.c:7501:9: note: previous statement is here
        if ( ! yyg->yy_state_buf )
        ^
1 error generated.
make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:97: util/parse-events-flex.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  LD      util/scripting-engines/perf-in.o
make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:140: util] Error 2
make[2]: *** [Makefile.perf:682: perf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      pmu-events/pmu-events.o
  LD      pmu-events/pmu-events-in.o
make[1]: *** [Makefile.perf:242: sub-make] Error 2
make: *** [Makefile:70: all] Error 2

⬢[acme@toolbox perf-tools-next]$ clang --version
clang version 14.0.5 (Fedora 14.0.5-2.fc36)
Target: x86_64-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
⬢[acme@toolbox perf-tools-next]$

