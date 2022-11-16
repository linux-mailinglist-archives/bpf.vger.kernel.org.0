Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577E162B3D9
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 08:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKPHWR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 02:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKPHWR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 02:22:17 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE743A1AB
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 23:22:15 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-377a1db4307so154697557b3.1
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 23:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VVBCM8+4ewIYbqSIURDFLLj3mOBnhhjT5+m4tbboLyQ=;
        b=T2CTy0cXc+GbTTmMdiCb9Zgs01lpkfqGh1mujEL0GETIM00jpRJOTM9isl/57BYYpO
         am7/2xYPhQGL51IQmeSydcgTMgOaCbBe/iWEF/1QaNs4uMmDGOjEvr6tThLTBP3xiTiu
         qHPrsTyARDCHIwmhf8qzvhgHN23WAFC155FXfQcUEMwQV117ZtFFqH+O50YFhgh70Lma
         P1Jyk6OLy9hgpbPJwnr+QQng0IkyDGXVKgZgY8bk5ZQGLHQ6yXAPN9Ft9qPzLO7+v4EV
         GNSDYjSHCj6mSU/5ZwuQxW88YpPNfWX0MEcWIElm4vIJpR4TkovIKaI5bhMOUMYLpEAD
         QKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVBCM8+4ewIYbqSIURDFLLj3mOBnhhjT5+m4tbboLyQ=;
        b=FJEjhZpp0izXF97jXjVC26k/OxMjigvgHhODK583HjXPOVZUmwLLFXMGnqcl3Sb7js
         2gUbRT3nklacb+qdhNnc2UguraHA+23Q5xsObcH7IjEglW27ym/BMaaF+2VCC98ZyOmJ
         /aXLMJ2K1T3Di94Ij2UJjqz++vu1dUVWBucmyiutAgSOP0sV1J3bYISsIOrEYaTlGiRf
         +ODWi0ccmlFQ7j7LWM8TkLj5hrxbUj9RWmE+98XcTkL7NCDEbtAw62s4IWes1YNVrcBA
         OcXyO7uB2DJmMgxQaIy7NgJ1cQ0tcSztbUq1USZyDtCbSqcXxwAQ93D5hMhyXqvItjcM
         tsOQ==
X-Gm-Message-State: ANoB5pkn+DZkerlY3KmHH46nS/KJIyaEKXg8sL/jPl+Qt2offO1AQop6
        cvkEs5cuMo63PCVZw3QMn+OUKaw5IpZa
X-Google-Smtp-Source: AA0mqf4pIXOLejh00a4sx9JINJstuwQskCv32hgKgt29OuWehxer6qcT4BwlWPt2AFedMoyAfDHNiWoMQG9r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf0f:58f3:342e:c1ec])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c4:b0:6ca:1f22:2bed with SMTP
 id w4-20020a05690210c400b006ca1f222bedmr19587576ybu.462.1668583335191; Tue,
 15 Nov 2022 23:22:15 -0800 (PST)
Date:   Tue, 15 Nov 2022 23:22:10 -0800
Message-Id: <20221116072211.2837834-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 0/1] Fix perf tools/lib includes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch replaces the last on kernel/git/acme/linux.git branch
perf/tools-libs-includes and fixes the race issue by using the prepare
dependency. pmu-events.c needs this dependency too, as the header
files it includes also include libperf - using perpare as a dependency
rather than $(LIBPERF) is more consistent with the rest of the makefile.

Ian Rogers (1):
  perf build: Use tools/lib headers from install path

 tools/perf/Makefile.config |  2 --
 tools/perf/Makefile.perf   | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

