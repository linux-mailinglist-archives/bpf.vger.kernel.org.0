Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805F35A2CC0
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344877AbiHZQr0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344293AbiHZQqj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:46:39 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C84506E
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:45:43 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x7-20020a170902ec8700b00172eaf25822so1405465plg.12
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=LEHDHxAnksEJke5uXEgC/4fvlBz/SQBsppkh6XDSNgM=;
        b=VOV3ZeQLK7insFX0lmDaq/k7r0x4+Jx+0drlOcZW9Pv6LP/mYzLvuK0V5gHu4IDPNg
         7ScpP6ajmkx53bfkRHgW9E2eOmJonRICOVsrLq7phuLXrvQsXxvCn+Puthlbd0RbbYnS
         zpuYddmMpBGNF/36MnFOzr/XVqqv0mqIiQ7DrweQEyg705qhnfMhxDoIXe+y9LqU/2TH
         ypL7V8lMnlmDV6NGRaelq3C61ouifEjuRGuLYlI9pRk2DoqvtywHxYi0GRIO6RNQBOJ4
         vskiabGPN8iVem8p4lLLKFvfz7Za7a3SyeSXLmXq254dQDpKjmOfkLTri5SUDF4IUI7M
         j56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=LEHDHxAnksEJke5uXEgC/4fvlBz/SQBsppkh6XDSNgM=;
        b=AqAG+96XFNI7NSQutru3ipPOsxd8ipcgxkmV3uSJHuGydvamFJ6FQkBFUjuelJzTik
         9gUyNVv7yfrirIbsOmzjBDTx8mR3Rv7NgMp9fx3TXtTg3bctOAIy2N1T17XTxpyUx9Uz
         nfzDjXaGXlgj9eJgI1/SsID+8nY3Kvr6xsmbM3A9PnJlXcgDwP1yVEigpFIf4sUBpppp
         +JI5Igu0Y28HujGL1pUX/58YyO+9dlfnijZ1U2WZVvQwMC/nYotXu5Ntm1DSkDViYVPF
         WHsKuJWK42fq13e3GsK2RyaAKTbMs8PDGh/97FWk6zUEt/f2Rh37for082PxJoBtXKEu
         bMYw==
X-Gm-Message-State: ACgBeo3SMHL6HoJlC3EPTL0PpZ35FH39OrPGVsLCSCD+rXA2wVjqBZuT
        wS+1/8ihCjxZGyQPu3s3o497ZcY1ceEO
X-Google-Smtp-Source: AA6agR7L6xHhqF8ShRu0uc83vM8zveOXqQ0A0Wg+4L4tk7yuhmGODVT7+yJjTn80JIeNUZ0kDT90cFuI9sjc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a17:90a:bf01:b0:1fb:c6c4:7dfd with SMTP id
 c1-20020a17090abf0100b001fbc6c47dfdmr5118986pjs.134.1661532343199; Fri, 26
 Aug 2022 09:45:43 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:42 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-19-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 18/18] perf build: Enable -Wthread-safety with clang
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If building with clang then enable -Wthread-safety warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c41a090c0652..72dadafdbad9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -19,6 +19,11 @@ detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
+# Enabled Wthread-safety analysis for clang builds.
+ifeq ($(CC_NO_CLANG), 0)
+  CFLAGS += -Wthread-safety
+endif
+
 include $(srctree)/tools/scripts/Makefile.arch
 
 $(call detected_var,SRCARCH)
-- 
2.37.2.672.g94769d06f0-goog

