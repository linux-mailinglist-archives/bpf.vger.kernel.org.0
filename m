Return-Path: <bpf+bounces-3859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD0E745602
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 09:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AED8280CC6
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 07:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CD8A52;
	Mon,  3 Jul 2023 07:26:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820881E
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 07:26:25 +0000 (UTC)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133DCE79
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 00:26:12 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so1220678241.1
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 00:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688369171; x=1690961171;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AFhL3WX439UF4ApWUsjLXGA8K76NwNV7mdB9JrDSbOs=;
        b=DHzBol8NLJ+48zey6G6sAvkl6ZLmYaukks2MSceVz9eVvrtdUcyJ7mgcYSrSO0hTwW
         2iVMxffzSLK0S2/rPMgLtNkyJjYZUKmqi8+xlyXOlLQjLrlwi/Z83AwdtiZ5b7loS6dA
         9hhK9Sl0KSPoDlNfosKy43Jfeqn3agIJyzOHO9P4eyJIHAmCkk/HpC0YsAiF7G4UnTBv
         q2nXKbdUE9jZeWnadixu10OKXl3xbJWeJZAWfW2I/1enV/ofupc3gmNxVbhB+V+Wt8xe
         aqkGFYTgm1S8qtpKLatDn5ft4qkD7eWDUourxJc5SV8rSaXP0pKTeUIJngzgXv/QvbEM
         ubNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688369171; x=1690961171;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFhL3WX439UF4ApWUsjLXGA8K76NwNV7mdB9JrDSbOs=;
        b=KMhOmKMeuy8plKKwheHV3plgutQih8yv6d4iYGlMwjIr0BvG+ZcuYk6roRS1dFl7yw
         ekh/0zRPqcAP4SoNMZHW9CS51xy1fe0ZzOsCxtutNLxoAdmcfTO5ZF490uatDbJceL9g
         DRHhacXF9nzb2jPnmGDim2Zkow8V/fsQyfFku1bWI1KOsjXGlFGdj44vZFZMh/V+ep0O
         Oa4oimhx4+HjI5sh0kJ/z/iA6v/UQu72BFLpBNBYc3ULOw1BlreoSRSkKnF30iKJdiVw
         LtZqLECFaV7UMmb8UIjxVUg80BEE0pc0BZSTAc3nWp3soElEyBi9J51AbNZ6NqgBeCSv
         XqxQ==
X-Gm-Message-State: ABy/qLajKy+SuLoTOdHRHa14Fk9hr0Ic4NGyuquMIgWJh6qF5mOyoaRZ
	jGSXRiafS84jE5HBImK24iLSjjTNC/1eUzcgJEWugA==
X-Google-Smtp-Source: APBJJlGau/9OizFSeLgMU/K7IoZbflIEWzaM5xflRF3SI1OEFTJw/gCMYBFgMESsm8IteNIYVawKBkXDI8mVc+q8tBM=
X-Received: by 2002:a67:f651:0:b0:443:51a7:b63d with SMTP id
 u17-20020a67f651000000b0044351a7b63dmr4037175vso.23.1688369171044; Mon, 03
 Jul 2023 00:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 3 Jul 2023 12:55:59 +0530
Message-ID: <CA+G9fYt1ZtucYds=p-Z+4sZ+nHMeEAFh2Fbe63VS_03-UsRwBg@mail.gmail.com>
Subject: next: perf: 32-bit: bench/sched-seccomp-notify.c:139:24: error:
 format '%lu' expects argument of type 'long unsigned int', but argument 2 has
 type 'uint64_t'
To: open list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Cc: Andrei Vagin <avagin@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Kees Cook <keescook@chromium.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Following build regressions noticed on Linux next-20230703.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on i386:

  - build/gcc-11-lkftconfig-perf

Regressions found on arm:

  - build/gcc-10-lkftconfig-perf
  - build/gcc-11-lkftconfig-perf

Build error:
=======
bench/sched-seccomp-notify.c: In function 'bench_sched_seccomp_notify':
bench/sched-seccomp-notify.c:139:24: error: format '%lu' expects
argument of type 'long unsigned int', but argument 2 has type
'uint64_t' {aka 'long long unsigned int'} [-Werror=format=]
  139 |   printf("# Executed %lu system calls\n\n",
      |                      ~~^
      |                        |
      |                        long unsigned int
      |                      %llu
  140 |    loops);
      |    ~~~~~
      |    |
      |    uint64_t {aka long long unsigned int}
cc1: all warnings being treated as errors
make[4]: *** [tools/build/Makefile.build:97:
/home/tuxbuild/.cache/tuxmake/builds/1/build/bench/sched-seccomp-notify.o]
Error 1

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230703/testrun/18069798/suite/build/test/gcc-10-lkftconfig-perf/history/


--
Linaro LKFT
https://lkft.linaro.org

