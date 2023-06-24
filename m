Return-Path: <bpf+bounces-3335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2455A73C560
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 02:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CE9281E8E
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 00:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B229A384;
	Sat, 24 Jun 2023 00:41:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E2378
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 00:41:29 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2D82D5D;
	Fri, 23 Jun 2023 17:41:21 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-bc43a73ab22so1994727276.0;
        Fri, 23 Jun 2023 17:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687567280; x=1690159280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/FuRD6bejRQah/PpTEFj6gbgQmoOAaWot6r6iD99aY=;
        b=hQq7aeF5Bney3E8au7auP5e0GtRHzkuIYwPY95XndGoyDz5yIECSkFTELRG5Lzd5w2
         tFpYDyIg1V5AwMmIQwg1tgEJ28AnIuyzNM9K2P4FUCQkCxXXdSiXJZWbQUkVwDpBHvVW
         2Yfh04By453RagiLzRaj7QyUt7TyzSL8z9rYxh2A3Ytz0kk63EN7JCZGZkMPN7PAC8pc
         eFqn1iCTAdEcb9Ub+Z+rBdR2nAoQ5R/L9uRCbsZBMB87WaZKW8oe+kfOEd034epc1mki
         3St53nIoEbsjBZ63JWXw1bK5PKckFWkzUQR8dtdcdSzK5IfCvgiD1KxGVK6nAcU9hPJt
         //ew==
X-Gm-Message-State: AC+VfDyR/a0KFKXdhuujMPOv5FlE3EyurmGKp8fq3l+dLR1Nutui7Qbt
	o9c3KBM/AW3SAKMEnwmZzR37J5eD8MAg44hk41YE2JSeA6Q=
X-Google-Smtp-Source: ACHHUZ5v2gjWGDGfcaukxYQKOY1iZOInR8MeFqHIgmHe//PaN8SFd/JN9VvhS5X5qdOwvPXcEhFAuVB2cVwiNdDdDps=
X-Received: by 2002:a25:e751:0:b0:bac:fc30:3913 with SMTP id
 e78-20020a25e751000000b00bacfc303913mr21471004ybh.21.1687567280546; Fri, 23
 Jun 2023 17:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230623041405.4039475-1-irogers@google.com>
In-Reply-To: <20230623041405.4039475-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 23 Jun 2023 17:41:09 -0700
Message-ID: <CAM9d7ch9MfCS02+-4FRDvrDVDK+f8qtqYr5m0abegg9PXJncHQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Bring back vmlinux.h generation
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 9:14=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
> satisfy libbpf 'runqueue' type verification") inadvertently created a
> declaration of 'struct rq' that conflicted with a generated
> vmlinux.h's:
>
> ```
> util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
> struct rq {};
>        ^
> /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous definit=
ion is here
> struct rq {
>        ^
> 1 error generated.
> ```
>
> Fix the issue by moving the declaration to vmlinux.h. So this can't
> happen again, bring back build support for generating vmlinux.h then
> add build tests.
>
> v4. Rebase and add Namhyung and Jiri's acked-by.
> v3. Address Namhyung's comments on filtering ELF files with readelf.
> v2. Rebase on perf-tools-next. Add Andrii's acked-by. Add patch to
>     filter out kernels that lack a .BTF section and cause the build to
>     break.
>
> Ian Rogers (4):
>   perf build: Add ability to build with a generated vmlinux.h
>   perf bpf: Move the declaration of struct rq
>   perf test: Add build tests for BUILD_BPF_SKEL
>   perf build: Filter out BTF sources without a .BTF section

Thanks,  I'll take them with the following change.

Namhyung


---
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b1e62a621f92..90f0eaf179fd 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -132,6 +132,8 @@ include ../scripts/utilities.mak
 # Define EXTRA_TESTS to enable building extra tests useful mainly to perf
 # developers, such as:
 #      x86 instruction decoder - new instructions test
+#
+# Define GEN_VMLINUX_H to generate vmlinux.h from the BTF.

 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL

