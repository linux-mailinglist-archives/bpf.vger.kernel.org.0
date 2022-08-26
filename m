Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE165A2CA5
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344729AbiHZQpv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344740AbiHZQpS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:45:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E7DE1924
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:44:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33daeaa6b8eso33373367b3.7
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=qbxmvtg31vAuyTVNdQtLAo3hOGlbGiTSIFXCXMg0luQ=;
        b=YiNeHiEQB7ZT+byLDsP6gzhAxj4qOcjGxn/TRpfE7J5uDFuiRDDfDWXwSNYZMf71ii
         A042tDGS3mpdCbthoHOppHcp8csVsnoDFYj8uc6vICZfkDKq6ExaozYty4czWI7Od2rm
         rqqyt4D2tilfzdIguqYFmEmgMQUSCyrZllDJTNi1x6gPLiUh8K3O6SXJ6cPf3yMWidsQ
         IITf4xjJM6BQNoO8wUGCfIeOHnAxA4zzC9sC3gH0blsa/anyMgCupQSLxprb9f+dw9kP
         H8qSSU3Gwc46qrepxa0bpb552AkXWP7nh6/fTVf57pE2JAc0X2yzdujYaGSYq+iMD4No
         Ev3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=qbxmvtg31vAuyTVNdQtLAo3hOGlbGiTSIFXCXMg0luQ=;
        b=EJ5GlSoi/unIPMIKi8EpQic7Xh0tGTeybJzUMGqv52aNHBOdB17mk7meiYtF2vMyXg
         fOnsbrDRjR+VJztcjdVnSyKwjJZbeXw4HqsdAGFd//ExBbleECzLGRJCYqplz1hzVuXU
         RzOhV6hF0M77jyH14+vBMmPnjQO0PffNChXZ+s7QZ7U2Nq1GhwsCvpboPittRdD/FjTP
         RC4pDKuyQXBjDvaf0EC4DeQ9pLJlx17Hv6hEjABhrOqu7eJyEMTFD1auN6pR/XVCxo90
         qdjxaqtczmmlkCx832Y8z58VRa9ccxc4Wgkdi7E6nXxDUP8Z9bclLRVqk1NRET/ueq/R
         HVaw==
X-Gm-Message-State: ACgBeo1vqsRl23Dd8CtCdY3d1QiV4yR6rA16iHJhwEJ99GsF8wo+6vKR
        H3U+75lh8cwsFdpVaWpU0lFZR6CrnGji
X-Google-Smtp-Source: AA6agR6GfpMi/GILI+QpU1U4bPsd6a35OdbU6xCyVP9TE8SbGO9dQ/L4McelKKt6Ipqvg8tKYdc1sXGi3MSG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a25:198b:0:b0:690:65bb:9416 with SMTP id
 133-20020a25198b000000b0069065bb9416mr510164ybz.142.1661532272130; Fri, 26
 Aug 2022 09:44:32 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:34 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-11-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 10/18] perf mmap: Remove unnecessary pthread.h include
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The comment says it is for cpu_set_t which isn't used in the header.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mmap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index cd8b0777473b..cd4ccec7f361 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -9,7 +9,6 @@
 #include <linux/bitops.h>
 #include <perf/cpumap.h>
 #include <stdbool.h>
-#include <pthread.h> // for cpu_set_t
 #ifdef HAVE_AIO_SUPPORT
 #include <aio.h>
 #endif
-- 
2.37.2.672.g94769d06f0-goog

