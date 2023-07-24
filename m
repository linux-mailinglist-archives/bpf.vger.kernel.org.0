Return-Path: <bpf+bounces-5750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA6176004D
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 22:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE7F1C20C3E
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 20:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4820D1094E;
	Mon, 24 Jul 2023 20:12:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D4107B8
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 20:12:54 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F6A10C8
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:12:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57059f90cc5so60331487b3.0
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690229572; x=1690834372;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=++qd83SvYx4O+g1mfcaqYz4UeSIRNutVl7jKxeFEywY=;
        b=pjmhJI2UMVSo0ZLkueSW/j/h4CPCqUEQHkXsiBIOVsLlCz7xAxezyPdSi7tryxRfog
         +EnkGX5/jNxb4KJ87EmOK86b7C1swlhBsp6732VqlaX+RSq7zlB7iWlN2B2R6X/qaRci
         zAum1rwT6cCZ5FBNhzodpUe4nNOwLN9aKrzcJIeogtc8Va3ng2W6Yx/B4zqTWDHhyN6d
         Q4QzOqFgFRjRqGYRNOlE3XfRe4mvND2e18Z5NmqUCJGT/iZo3/Vvy02afXUbFbkk8Gth
         DRe516Jy3euJ4KsAii07QamDiuQzdU2p2dM1P52WMY66T0vaX89+Cu+NOu8yXMBow1J3
         LGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229572; x=1690834372;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++qd83SvYx4O+g1mfcaqYz4UeSIRNutVl7jKxeFEywY=;
        b=IiRu0BUKtafG836SsSxZ8NdpFVkM4gSXRZ/B74aWfdbOlkXxfcoTlze8kLG1zGVp2F
         56Mfi8kM1ImNAcWjdwMiQD1X0NR5pGblp4CT/n0RS9FPWiC06kbSxc9nWJV3oJiXewbG
         NHQsytP7y+baBJPsOHNIYKaCq+vlzEzS1pqKz7nsp9HmNYJap/Uanf/7LMbMKRTFsXuF
         Tvy9LMUtd6svB0F191aj4USJmjLXOtHJX4dHyOOofebabKt05H70i9M27Ey5hECOYI9g
         jwMkdMgvKcpx8yCjeAaMhltJAvyQybw3j0UYLVxJiAguMTu8HgTlcnz0IOcSdSgrtPPS
         HJqw==
X-Gm-Message-State: ABy/qLZGpiKgeaRGyVrJrbpMv5j63h3Gg0nDvMLRB/hLobSS5PXW503n
	/nhavydZTF3kI4cgBvsGjTqCRt2+UxRv
X-Google-Smtp-Source: APBJJlEwAq/rZS1ckxZoRCzDTn4+i1Vkf44RQCvwMa2Lq6CVP6f9fOQqpMnxMsHhzBYsRzrTUqd96mIv9LJv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5724:8dc0:46f0:f963])
 (user=irogers job=sendgmr) by 2002:a5b:643:0:b0:c4e:3060:41f9 with SMTP id
 o3-20020a5b0643000000b00c4e306041f9mr78575ybq.9.1690229572729; Mon, 24 Jul
 2023 13:12:52 -0700 (PDT)
Date: Mon, 24 Jul 2023 13:12:43 -0700
Message-Id: <20230724201247.748146-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 0/4] Perf tool LTO support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Carsten Haitzler <carsten.haitzler@arm.com>, 
	Zhengjun Xing <zhengjun.xing@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev
Cc: maskray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a build flag, LTO=3D1, so that perf is built with the -flto
flag. Address some build errors this configuration throws up.

For me on my Debian derived OS, "CC=3Dclang CXX=3Dclang++ LD=3Dld.lld" work=
s
fine. With GCC LTO this fails with:
```
lto-wrapper: warning: using serial compilation of 50 LTRANS jobs
lto-wrapper: note: see the =E2=80=98-flto=E2=80=99 option documentation for=
 more information
/usr/bin/ld: /tmp/ccK8kXAu.ltrans10.ltrans.o:(.data.rel.ro+0x28): undefined=
 reference to `memset_orig'
/usr/bin/ld: /tmp/ccK8kXAu.ltrans10.ltrans.o:(.data.rel.ro+0x40): undefined=
 reference to `__memset'
/usr/bin/ld: /tmp/ccK8kXAu.ltrans10.ltrans.o:(.data.rel+0x28): undefined re=
ference to `memcpy_orig'
/usr/bin/ld: /tmp/ccK8kXAu.ltrans10.ltrans.o:(.data.rel+0x40): undefined re=
ference to `__memcpy'
/usr/bin/ld: /tmp/ccK8kXAu.ltrans44.ltrans.o: in function `test__arch_unwin=
d_sample':
/home/irogers/kernel.org/tools/perf/arch/x86/tests/dwarf-unwind.c:72: undef=
ined reference to `perf_regs_load'
collect2: error: ld returned 1 exit status
```

The issue is that we build multiple .o files in a directory and then
link them into a .o with "ld -r" (cmd_ld_multi). This early link step
appears to trigger GCC to remove the .S file definition of the symbol
and break the later link step (the perf-in.o shows perf_regs_load, for
example, going from the text section to being undefined at the link
step which doesn't happen with clang or without LTO). It is possible
to work around this by taking the final perf link command and adding
the .o files generated from .S back into it, namely:
arch/x86/tests/regs_load.o
bench/mem-memset-x86-64-asm.o
bench/mem-memcpy-x86-64-asm.o

A quick performance check and the performance improvements from LTO
are noticeable:

Non-LTO
```
$ perf bench internals synthesize
 # Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 202.216 usec (+- 0.160 usec)
  Average num. events: 51.000 (+- 0.000)
  Average time per event 3.965 usec
  Average data synthesis took: 230.875 usec (+- 0.285 usec)
  Average num. events: 271.000 (+- 0.000)
  Average time per event 0.852 usec
```

LTO
```
$ perf bench internals synthesize
 # Running 'internals/synthesize' benchmark:
Computing performance of single threaded perf event synthesis by
synthesizing events on the perf process itself:
  Average synthesis took: 104.530 usec (+- 0.074 usec)
  Average num. events: 51.000 (+- 0.000)
  Average time per event 2.050 usec
  Average data synthesis took: 112.660 usec (+- 0.114 usec)
  Average num. events: 273.000 (+- 0.000)
  Average time per event 0.413 usec
```

Ian Rogers (4):
  perf stat: Avoid uninitialized use of perf_stat_config
  perf parse-events: Avoid use uninitialized warning
  perf test: Avoid weak symbol for arch_tests
  perf build: Add LTO build option

 tools/perf/Makefile.config      |  5 +++++
 tools/perf/tests/builtin-test.c | 11 ++++++++++-
 tools/perf/tests/stat.c         |  2 +-
 tools/perf/util/parse-events.c  |  2 +-
 tools/perf/util/stat.c          |  2 +-
 5 files changed, 18 insertions(+), 4 deletions(-)

--=20
2.41.0.487.g6d72f3e995-goog


