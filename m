Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C166449EF
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 18:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiLFRIJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 12:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiLFRHn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 12:07:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6329F7D;
        Tue,  6 Dec 2022 09:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B82AC617E6;
        Tue,  6 Dec 2022 17:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA58BC433C1;
        Tue,  6 Dec 2022 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670346457;
        bh=lEuyI5w1R//aNy3kUfU54WqWhb7jdLiS6Jm+x6fdCpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAj3KbZ6M5+yZtlniUu5znjr/2J4BP5YT65Uxi+k2RssB1p89+y+Dmh2DxBfUoaNz
         QxvTT7RUadm9mjDagmjK63hwSoIMUr7ljndtRkNZ/kLDJnQ6MI75Wu9DL0qblDdCop
         8H4pXAVWYxsGWKfYamRHHakps7KamXBJJMstCd+jVK9nvHhz/TwcUsHBGEd67FvNFX
         vodMCFJqDDRbwW4NdlCFqUkQUnNwDwdxLb/Eonivt0o1fLwi4MMBbly9UoD1MviAzW
         bdNK2zibpcNDd9ehNfKrXLKw0zD3pDqy1S/Jl+/ALowz2V1rR4qZnI146znhTt4kHC
         INAqv4BEqDB2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D684A40404; Tue,  6 Dec 2022 14:07:32 -0300 (-03)
Date:   Tue, 6 Dec 2022 14:07:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
Message-ID: <Y4921D+36UGdhK92@kernel.org>
References: <20221205225940.3079667-1-irogers@google.com>
 <20221205225940.3079667-3-irogers@google.com>
 <Y49qiCIiyaehEOaG@kernel.org>
 <Y49rvLO2RnJBBNL/@kernel.org>
 <Y49skYa5VYPMU+RF@kernel.org>
 <Y49uKfzfCoZ1ok62@kernel.org>
 <Y49vx0v6Z7EiR8jr@kernel.org>
 <Y49wxSIK7dJ7iTDg@kernel.org>
 <Y491d1wEW4TfUi5f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y491d1wEW4TfUi5f@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 06, 2022 at 02:01:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 06, 2022 at 01:41:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> >  Now to look at the BUILD_BPF_SKEL=1 kaboom:
> > 
> >  [acme@quaco perf]$ alias m
> > alias m='rm -rf ~/libexec/perf-core/ ; make -k NO_LIBTRACEEVENT=1 BUILD_BPF_SKEL=1 O=/tmp/build/perf -C tools/perf install-bin && perf test python'
> > [acme@quaco perf]$ m
> > make: Entering directory '/home/acme/git/perf/tools/perf'
> >   BUILD:   Doing 'make -j8' parallel build
> >   <SNIP>
> > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `add_work':
> > /home/acme/git/perf/tools/perf/util/bpf_kwork.c:285: undefined reference to `perf_kwork_add_work'
> > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `lock_contention_read':

For that bpf_kwork.c see below. Now to see why the python binding is not
building, I guess is unrelated and you have some other outstanding
patch?

[acme@quaco perf]$ git diff
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 255bc751d19452f2..c97093f47c990b45 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -153,8 +153,12 @@ perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
-perf-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_lock_contention.o
+
+ifeq ($(CONFIG_TRACEEVENT),y)
+  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork.o
+endif
+
 perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
 perf-$(CONFIG_LIBELF) += symbol-elf.o
 perf-$(CONFIG_LIBELF) += probe-file.o
[acme@quaco perf]$ m
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' differs from latest version at 'arch/arm64/include/asm/cputype.h'
diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
Makefile.config:1138: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

  INSTALL libsubcmd_headers
  INSTALL libapi_headers
  INSTALL libsymbol_headers
  INSTALL libperf_headers
  GEN     /tmp/build/perf/python/perf.so
  INSTALL libbpf_headers
  INSTALL binaries
  INSTALL tests
  INSTALL perf-read-vdso32
  INSTALL libexec
  INSTALL bpf-examples
  INSTALL perf-archive
  INSTALL perf-iostat
  INSTALL strace/groups
  INSTALL perl-scripts
  INSTALL python-scripts
  INSTALL dlfilters
  INSTALL perf_completion-script
  INSTALL perf-tip
make: Leaving directory '/home/acme/git/perf/tools/perf'
 14: 'import perf' in python                                         : FAILED!
[acme@quaco perf]$

