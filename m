Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB5664095
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 13:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbjAJMfK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 07:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbjAJMfI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 07:35:08 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B941D79;
        Tue, 10 Jan 2023 04:35:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso5409203wms.0;
        Tue, 10 Jan 2023 04:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3kfVuRltfmokWb+udv2UTvIYgnmu2+AHSzhy59xvOg=;
        b=WMpCisVdoh//jn01v4b5AZrbIa++kWkYBVOUcikGNXG4V1vyqYe4AaRYHaSm+7txLm
         1i7CfV8rHcB6resCTAGq4+3Yda0pU4acPDhaGDMiZ3PkiFFDp1Uixjg2AueIapUCPFM2
         6Ap5mZNSV03dZTGHgtZtM3/cFaOmlSGWgWbZ6zadgSGFb0SO78AUhgKDoq+rRhYIqmOe
         VA8mCuh5kZUueMiaUfD162kBCNqoiMfY9DEZfB8E3JCggLfe+9tYlVOofj0a3ZJaicr6
         phmZGjm/4WPFCXJ/TxviwQGrBQMvrkdTOIkG2v0oECWiTemcTz4AH+KKEBdjZqbUVu9k
         cZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3kfVuRltfmokWb+udv2UTvIYgnmu2+AHSzhy59xvOg=;
        b=3iQqgUUt91Ouu+xIBULDZwCpwOm+ojlwuAZdh9kFgLXobdICx0geHtkPCfMzAQNSsI
         Yb35x5Psr3nj09Rse8HpG42mqJTcQGAqRtnEgBJcmXffxu3t3vaQHFl2cJQ6+MSvSiWh
         xq+4sh3f5Yv/bNhyq5feF1jdyfLO7RcejDPCXqS/kwNwT6xE370bGiMF8YUbJCDDkBcY
         ti2Jwbs/QzpEoQ6/bSAZN4Oq0jvHHCr8a5pQELMlkFUlF/N87x3sRjRBZC1CtC4xOGDV
         wKarpnYR6svrulaOTMuKYClHRHUJR1IUPWtDqSd9EetbXegRWiMRo+9sbKsjatombQOS
         OWmg==
X-Gm-Message-State: AFqh2kru2nSXSbN8DL9BXA8pF0B2sO3E0xbRAWWYwwwRsejIGecpUcOY
        n0xURlP6xEMhhpzy9eKMF78=
X-Google-Smtp-Source: AMrXdXsaxy8avAuuMof4qv+my4xLbaIUaS2ej/Po9lIOSSaGNjEiYfkexu8Olg7eG2rRufmWuR32UA==
X-Received: by 2002:a05:600c:4e04:b0:3d2:381f:2db5 with SMTP id b4-20020a05600c4e0400b003d2381f2db5mr47969230wmq.22.1673354100432;
        Tue, 10 Jan 2023 04:35:00 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c358900b003cffd3c3d6csm16143437wmq.12.2023.01.10.04.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 04:34:59 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 10 Jan 2023 13:34:56 +0100
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v1 0/3] Assume libbpf 1.0 in build
Message-ID: <Y71bcMYQ26eroc2W@krava>
References: <20230109203424.1157561-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109203424.1157561-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 09, 2023 at 12:34:21PM -0800, Ian Rogers wrote:
> libbpf 1.0 was a major change in API. Perf has partially supported
> older libbpf's but an implementation may be:
> ..
>        pr_err("%s: not support, update libbpf\n", __func__);
>        return -ENOTSUP;
> ..
> 
> Rather than build a binary that would fail at runtime it is
> preferrential just to build libbpf statically and link against
> that. The static version is in the kernel tools tree and newer than
> 1.0.
> 
> These patches change the libbpf test to only pass when at least
> version 1.0 is installed, then remove the conditional build and
> feature logic.
> 
> The issue is discussed here:
> https://lore.kernel.org/lkml/20230106151320.619514-1-irogers@google.com/
> 
> Ian Rogers (3):
>   tools build: Pass libbpf feature only if libbpf 1.0+
>   perf build: Remove libbpf pre-1.0 feature tests
>   perf bpf: Remove pre libbpf 1.0 conditional logic
> 
>  tools/build/feature/Makefile                  |  7 --
>  .../feature/test-libbpf-bpf_map_create.c      |  8 ---
>  .../test-libbpf-bpf_object__next_map.c        |  8 ---
>  .../test-libbpf-bpf_object__next_program.c    |  8 ---
>  .../build/feature/test-libbpf-bpf_prog_load.c |  9 ---
>  .../test-libbpf-bpf_program__set_insns.c      |  8 ---
>  .../test-libbpf-btf__load_from_kernel_by_id.c |  8 ---
>  .../build/feature/test-libbpf-btf__raw_data.c |  8 ---
>  tools/build/feature/test-libbpf.c             |  4 ++
>  tools/perf/Makefile.config                    | 37 +----------
>  tools/perf/util/bpf-event.c                   | 66 -------------------
>  tools/perf/util/bpf-loader.c                  | 18 -----
>  tools/perf/util/bpf_counter.c                 | 18 -----
>  13 files changed, 5 insertions(+), 202 deletions(-)

nice, I like that.. I was able to build perf on fedora
with (dynamic) and without (static) libbpf 1.0 

I hope supporting allowing dynamic link just with libbpf 1.0
won't mess up backport world too much.. cc-ing Michael

other than that looks ok to me

Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

also for the 2 dependency patches

thanks,
jirka

>  delete mode 100644 tools/build/feature/test-libbpf-bpf_map_create.c
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_map.c
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_object__next_program.c
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_prog_load.c
>  delete mode 100644 tools/build/feature/test-libbpf-bpf_program__set_insns.c
>  delete mode 100644 tools/build/feature/test-libbpf-btf__load_from_kernel_by_id.c
>  delete mode 100644 tools/build/feature/test-libbpf-btf__raw_data.c
> 
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
