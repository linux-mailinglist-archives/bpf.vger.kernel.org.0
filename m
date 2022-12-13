Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5064C09B
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 00:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiLMX1e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 18:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbiLMX1Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 18:27:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108AF19C1F
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:27:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y66-20020a25c845000000b00733b5049b6fso713316ybf.3
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nto1ePcvoNdo0gJd4FRIsAa3aTl5xw4C0we0lXrYi4o=;
        b=oaxFlW2ge9haPbT6hCAVVmPuTox9DW+MdJNbZ0iwTokh/4XBkQYtfdusDGVsroQCBm
         9cjRzTm2cTtoTugbzyCsz2kAHTjET5PTm0Qk0Vytd93WKj/92dwBthyYMEWpJ4MTqXXZ
         Kgspw5ZoKtAmQTgags/2mTbzHSF1im/xe5z7xwqmMxY+MpgtR2QCiepGpC+pSAjeR62r
         af+wkR/DSxLYLJ6v8UzQYo8yEedKseMcvnt7JbQHB+veoq0VjssEp6Vl9Tr9PuxO2F17
         A3OnHm0NqQzzvD7NNSu2YgWdnWtZRBASIIw6rkBU4yPgO0G6Iw9CrmSsI4xx9udJ5Lje
         3Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nto1ePcvoNdo0gJd4FRIsAa3aTl5xw4C0we0lXrYi4o=;
        b=eY0lAeu9SoL3EcwPccFQrEGTbVaIg65Tn+bgLnlVzf9FUd8Q9uB30P8kbzY8mVSSfC
         PXOjJDIbFAxHBciUuhY8x1XgRNES4XScmVeWrMKI9dKbqU8OZ0/y4l3Ka7oG6vUfdJJQ
         B905r2rDGs21Kuh8tPZv4O9nNivnVONaeuDs+fmPi92ofvzo0LkBVx0yZTzLPz/WN0ej
         qKrIl2WyFqWED9C2vgIAeTSTKdqjapjH4WbgtyUhA5Ie9ywcEpo+eDpgY8yuND+yW2vh
         6NlgQju7/7+YNRmnVB3KDFsDDSSwSTE6KCYNv/mdTXPebKISDjj/2eMS45v4TQdpkG8D
         Mpaw==
X-Gm-Message-State: ANoB5pl3uuCl6BVwu6NQytpRxXtZCXUUne+nHxIQq2xfQpB1Cw1AKJas
        Ecp2h3NTRnh2MHC0ePhp8bBRGwg852oW
X-Google-Smtp-Source: AA0mqf7zKBCVtwi4aB0KEabefvL0KR/RBin8ahJp49ddNoCoU3ThDFo9mNYaPbpMu1R7lGgciCKfGEWA/gYy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6268:b448:f7f4:4c2])
 (user=irogers job=sendgmr) by 2002:a5b:f42:0:b0:6fd:e4ef:5b1d with SMTP id
 y2-20020a5b0f42000000b006fde4ef5b1dmr25692919ybr.99.1670974043252; Tue, 13
 Dec 2022 15:27:23 -0800 (PST)
Date:   Tue, 13 Dec 2022 15:26:48 -0800
In-Reply-To: <20221213232651.1269909-1-irogers@google.com>
Message-Id: <20221213232651.1269909-3-irogers@google.com>
Mime-Version: 1.0
References: <20221213232651.1269909-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 2/5] perf trace-event: Add libtraceevent version tools to header
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Timothy Hayes <timothy.hayes@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        shaomin Deng <dengshaomin@cdjrlc.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
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

Allow comparisons like:
\#if MAKE_LIBTRACEEVENT_VERSION(1, 3, 0) <= LIBTRACEEVENT_VERSION

Based on previously reverted:
https://lore.kernel.org/linux-perf-users/20210923001024.550263-4-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/trace-event.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index add6c5d9531c..1fbf4c3f8809 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -6,6 +6,19 @@
 #include <stdio.h>
 #include <linux/types.h>
 
+#ifdef HAVE_LIBTRACEEVENT
+#include <traceevent/event-parse.h>
+#endif
+
+#define MAKE_LIBTRACEEVENT_VERSION(a, b, c) ((a)*255*255+(b)*255+(c))
+#ifndef LIBTRACEEVENT_VERSION
+/*
+ * If LIBTRACEEVENT_VERSION wasn't computed then set to version 1.1.0 that
+ * previously shipped with the Linux kernel tools.
+ */
+#define LIBTRACEEVENT_VERSION MAKE_LIBTRACEEVENT_VERSION(1, 1, 0)
+#endif
+
 struct evlist;
 struct machine;
 struct perf_sample;
-- 
2.39.0.314.g84b9a713c41-goog

