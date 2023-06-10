Return-Path: <bpf+bounces-2340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C079B72AF68
	for <lists+bpf@lfdr.de>; Sun, 11 Jun 2023 00:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B88281407
	for <lists+bpf@lfdr.de>; Sat, 10 Jun 2023 22:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4999F209A4;
	Sat, 10 Jun 2023 22:14:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB81801F
	for <bpf@vger.kernel.org>; Sat, 10 Jun 2023 22:14:31 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1466535A9;
	Sat, 10 Jun 2023 15:14:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7e7fc9fe6so29986385e9.3;
        Sat, 10 Jun 2023 15:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686435267; x=1689027267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2K/vXSH1Ru9AaenLQ5OAeVVoA6HlojAGRwcG2Pghjc=;
        b=SGn5PIik8gN8dqE4k/E+IsJtqnyqDxb95wJKsl121SuxxSvea6ULwN8lU1NQgJM5q/
         pARoJYhuzw/fL5YrZvYvGyycKPUPMqbz6bGf6200C+eCThOwLMtClp0QJVPnWayNb+9h
         LFXJ3KX9dBayCjdiLtpgEmqBBscxvetE0NsdrHSISMKWTWcoY7rUTeK2fp1xJHq8RrMM
         45jXAXi6kNCEG57HvxtzvmRGcq93JHeM1PcaGhSkPxjqnUyFYoBtuYb+gUCvWlmOyxym
         DLpGmhwVaSryTBlQ7pyjzZcdf3IYbWx6ejRxPVr9LGRlcDexixKIWV2U3I9PEhjx5a57
         +2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686435267; x=1689027267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2K/vXSH1Ru9AaenLQ5OAeVVoA6HlojAGRwcG2Pghjc=;
        b=eYcAKMNqu/l9lwj4kQCPaRhWQmbXrfOYFwdbdl/5K1t5IQvXbEQbUEtIo4FUr52trw
         EdNjTSIFP06iFEOHU0wQIiL8wGKWjZvDkC4k1SIrQqWCoBMXhEh0xy7QvhyZbIuAVxbT
         6+h7IRCDqYEq7EmHAoOpXxV4t9pR6ygtk1LSfiqirMR8UloHk0yPKrtgW7NWejF8v/2r
         gewrC6kmi2O2RX9Pk2Kgqx4uOcV72UJ86xbYbbUyvGS8JlZtzXWOntrjrvKEbx9p+5Of
         jFe1661m4DnrXZfEZU00G9m+KJ9T0E0vyvCC5z9FlOvJ0R9N0H19DYyVhbT5ZgCTc1G+
         3fmQ==
X-Gm-Message-State: AC+VfDxWQnXQaQZed4pH2VCbSTcPdMFjVJLhKzKolZ+DWFH4zX874MEo
	Qcx4u3THefydAychCO6cPDw=
X-Google-Smtp-Source: ACHHUZ5eWA+QdMw7r2dwC1sGRE7jCl/a51OBoeOdvayFX/bkMTA6R/FI2DHP43FwKQ8kzRfloO/vQQ==
X-Received: by 2002:a7b:c84c:0:b0:3f6:76e:604b with SMTP id c12-20020a7bc84c000000b003f6076e604bmr4180596wml.0.1686435267228;
        Sat, 10 Jun 2023 15:14:27 -0700 (PDT)
Received: from krava ([213.235.133.42])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003f7f1b3aff1sm6742250wmi.26.2023.06.10.15.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 15:14:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 11 Jun 2023 00:14:23 +0200
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Bring back vmlinux.h generation
Message-ID: <ZIT1v4oUKJreqd/I@krava>
References: <20230609043240.43890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609043240.43890-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 08, 2023 at 09:32:36PM -0700, Ian Rogers wrote:
> Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
> satisfy libbpf 'runqueue' type verification") inadvertently created a
> declaration of 'struct rq' that conflicted with a generated
> vmlinux.h's:
> 
> ```
> util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
> struct rq {};
>        ^
> /tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous definition is here
> struct rq {
>        ^
> 1 error generated.
> ```
> 
> Fix the issue by moving the declaration to vmlinux.h. So this can't
> happen again, bring back build support for generating vmlinux.h then
> add build tests.
> 
> v3. Address Namhyung's comments on filtering ELF files with readelf.

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> v2. Rebase on perf-tools-next. Add Andrii's acked-by. Add patch to
>     filter out kernels that lack a .BTF section and cause the build to
>     break.
> 
> Ian Rogers (4):
>   perf build: Add ability to build with a generated vmlinux.h
>   perf bpf: Move the declaration of struct rq
>   perf test: Add build tests for BUILD_BPF_SKEL
>   perf build: Filter out BTF sources without a .BTF section
> 
>  tools/perf/Makefile.config                    |  4 ++
>  tools/perf/Makefile.perf                      | 39 ++++++++++++++++++-
>  tools/perf/tests/make                         |  4 ++
>  tools/perf/util/bpf_skel/.gitignore           |  1 +
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  2 -
>  .../util/bpf_skel/{ => vmlinux}/vmlinux.h     | 10 +++++
>  6 files changed, 57 insertions(+), 3 deletions(-)
>  rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)
> 
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

