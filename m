Return-Path: <bpf+bounces-6476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1D276A286
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 23:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B5228150F
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 21:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CA51E500;
	Mon, 31 Jul 2023 21:16:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EEE1DDE3;
	Mon, 31 Jul 2023 21:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CDEC433C8;
	Mon, 31 Jul 2023 21:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690838201;
	bh=xcTqF7aOrNrqWKo1l81zdilo1yPMMlcZ5Ml2JwWWdb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRGq3BOfZl80YdgbPrb8M6ohUD9whYS9/PsDu6NVEknEnY3dd4+SKNBze0XeaBZAv
	 7ZeObuIDTBvBEf6U4o0TQabfkPafjWyaLejNGzUPwSGyBNb15aMJkI30oOCF/MUQTN
	 tTX2S4GI3oso1b5Mrl2moGGMWVzc81jJy/8vTTHQQM9eJG/0wzf8DRC6/4RTR4xFkk
	 F8KPx2pqslJIHiHPRKNIdR1TplXa3nrjh2I5Ddlg5GzgVOpH+BOvjgRDngBRdGez94
	 0LV8nAsGA5jwpG7wJqxMTSDp0/0/gjPpK/zWBCMxXI4epT5EJ1hTC7XJA/W+s1Zdaw
	 fPFt4wRcCB4GA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 64F7040096; Mon, 31 Jul 2023 18:16:38 -0300 (-03)
Date: Mon, 31 Jul 2023 18:16:38 -0300
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
	Rob Herring <robh@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH v1 4/6] perf build: Disable fewer flex warnings
Message-ID: <ZMgkthavch7x/z+0@kernel.org>
References: <20230728064917.767761-1-irogers@google.com>
 <20230728064917.767761-5-irogers@google.com>
 <a8833945-3f0a-7651-39ff-a01e7edc2b3a@arm.com>
 <ZMPJym7DnCkFH7aA@kernel.org>
 <ZMPKekDl+g5PeiH8@kernel.org>
 <CAP-5=fX2LOdd_34ysAYYB5zq5tr7dMje35Nw6hrLXTPLsOHoaw@mail.gmail.com>
 <ZMQEfIi/BYwpDIEB@kernel.org>
 <ZMQMQoCtBytgwB4i@kernel.org>
 <CAP-5=fUOD4hgQBmXjQh0HujO_39zQQhv_Wv5oirgAC4N8Ao1nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUOD4hgQBmXjQh0HujO_39zQQhv_Wv5oirgAC4N8Ao1nw@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Fri, Jul 28, 2023 at 12:05:56PM -0700, Ian Rogers escreveu:
> On Fri, Jul 28, 2023, 11:43 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> > > I haven't checked, lemme do it now.

> > It comes directly from flex's m4 files:

> > https://github.com/westes/flex/blob/master/src/c99-flex.skl#L2044

> > So I'll keep the -Wno-misleading-indentation, ok?
 
> Makes sense, yes.

continuing, changed the version check to:

commit f4da4419574536691c6b7843b6c48a3f97240404
Author: Ian Rogers <irogers@google.com>
Date:   Thu Jul 27 23:49:15 2023 -0700

    perf build: Disable fewer flex warnings
    
    If flex is version 2.6.4, reduce the number of flex C warnings
    disabled. Earlier flex versions have all C warnings disabled.
    
    Committer notes:
    
    Added this to the list of ignored warnings to get it building on
    a Fedora 36 machine with flex 2.6.4:
    
      -Wno-misleading-indentation
    
    Noticed when building with:
    
      $ make LLVM=1 -C tools/perf NO_BPF_SKEL=1 DEBUG=1
    
    Take two:
    
    We can't just try to canonicalize flex versions by just removing the
    dots, as we end up with:
    
            2.6.4 >= 2.5.37
    
    becoming:
    
            264 >= 2537
    
    Failing the build on flex 2.5.37, so instead use the back to the past
    added $(call version_ge3,2.6.4,$(FLEX_VERSION)) variant to check for
    that.
    
    Making sure $(FLEX_VERSION) keeps the dots as we may want to use 'sort
    -V' or something nicer when available everywhere.
    
    Signed-off-by: Ian Rogers <irogers@google.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Andrii Nakryiko <andrii@kernel.org>
    Cc: Eduard Zingerman <eddyz87@gmail.com>
    Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Nathan Chancellor <nathan@kernel.org>
    Cc: Nick Desaulniers <ndesaulniers@google.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Rob Herring <robh@kernel.org>
    Cc: Tom Rix <trix@redhat.com>
    Cc: bpf@vger.kernel.org
    Cc: llvm@lists.linux.dev
    Link: https://lore.kernel.org/r/20230728064917.767761-5-irogers@google.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index bb08149179e405ac..ae91e2786f1a4f55 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,3 +1,5 @@
+include $(srctree)/tools/scripts/utilities.mak
+
 perf-y += arm64-frame-pointer-unwind-support.o
 perf-y += addr_location.o
 perf-y += annotate.o
@@ -279,13 +281,11 @@ $(OUTPUT)util/bpf-filter-bison.c $(OUTPUT)util/bpf-filter-bison.h: util/bpf-filt
 	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
 		-o $(OUTPUT)util/bpf-filter-bison.c -p perf_bpf_filter_
 
-FLEX_GE_26 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 26)
-ifeq ($(FLEX_GE_26),1)
-  flex_flags := -Wno-switch-enum -Wno-switch-default -Wno-unused-function -Wno-redundant-decls -Wno-sign-compare -Wno-unused-parameter -Wno-missing-prototypes -Wno-missing-declarations
-  CC_HASNT_MISLEADING_INDENTATION := $(shell echo "int main(void) { return 0 }" | $(CC) -Werror -Wno-misleading-indentation -o /dev/null -xc - 2>&1 | grep -q -- -Wno-misleading-indentation ; echo $$?)
-  ifeq ($(CC_HASNT_MISLEADING_INDENTATION), 1)
-    flex_flags += -Wno-misleading-indentation
-  endif
+FLEX_VERSION := $(shell $(FLEX) --version | cut -d' ' -f2)
+
+FLEX_GE_264 := $(call version_ge3,2.6.4,$(FLEX_VERSION))
+ifeq ($(FLEX_GE_264),1)
+  flex_flags := -Wno-redundant-decls -Wno-switch-default -Wno-unused-function -Wno-misleading-indentation
 else
   flex_flags := -w
 endif

--------------------------------------------------------------------------

with version_ge3 being:

commit aa9e655a4d755c3c75eb3d200d87a3b695f602cf
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Jul 31 16:19:21 2023 -0300

    tools build: Add a 3-component greater or equal version comparator
    
    The next cset needs to compare if a flex version is greater or equal
    than another, but since there is no canonical, generally available way
    to compare versions in the command line (sort -V, yeah, but...), just
    use awk to canonicalize the versions like is also done in
    scripts/rust_is_available.sh.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/scripts/utilities.mak b/tools/scripts/utilities.mak
index 172e47273b5d995a..568a6541ecf98075 100644
--- a/tools/scripts/utilities.mak
+++ b/tools/scripts/utilities.mak
@@ -177,3 +177,13 @@ $(if $($(1)),$(call _ge_attempt,$($(1)),$(1)),$(call _ge_attempt,$(2)))
 endef
 _ge_attempt = $(or $(get-executable),$(call _gea_err,$(2)))
 _gea_err  = $(if $(1),$(error Please set '$(1)' appropriately))
+
+# version-ge3
+#
+# Usage $(call version_ge3,2.6.4,$(FLEX_VERSION))
+#
+# To compare if a 3 component version is greater or equal to anoter, first use
+# was to check the flex version to see if we can use compiler warnings as
+# errors for one of the cases flex generates code C compilers complains about.
+#
+version_ge3 = $(shell awk -F'.' '{ printf("%d\n", (10000000 * $$1 + 10000 * $$2 + $$3) >= (10000000 * $$4 + 10000 * $$5 + $$6)) }' <<< "$(1).$(2)")



