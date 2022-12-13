Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB25A64C09D
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 00:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbiLMX1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 18:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiLMX1c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 18:27:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F6126AEA
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:27:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f11-20020a5b01cb000000b0070374b66537so18672477ybp.14
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4KcsU/b3XyH2KQ+Ac23wDexbNZ59qO2HtUAGBc5g3Tc=;
        b=YVUOxAG2O4vexzafaKXiqxFFq6XVXzwPJABTGqUVVbEO9apyo7c/MsJRdgasjmAOpn
         px3ls4XPbyNqxVp2FxeVFfhvR/RSSY0c0A7dpd267nqfHdSr8ATTYXNxVhUx+UFadA9v
         8gBH/HDiTN26ymg8IoNZTUnKQYjwBM1iLgXqISO8HS+d/7lZW8hfu012CgiKRwFM85oc
         A/Kt/oFb9yD39482tBKuQAwP299lhwt6kxTPuBOwu9ckvzJllGkPvxHodK+j8iQ+KoAQ
         ICf00f6PzpWGIWBKySR4+xb5XTL/wG622Fw670ZKbKSye5v59hTvDxMqVeoUepsaddp6
         RpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KcsU/b3XyH2KQ+Ac23wDexbNZ59qO2HtUAGBc5g3Tc=;
        b=AUcFu9MpTJvCVo/7JVqRCBgL084z58/r//udIVoiUMdi1Zpt/gQ9JqLx4CViR9jRpk
         YFu+tKhQ6f3s5Wdo0RWM44Ip3tH/rTI+WXoCPICdcVUfhEVhpaVA3BFafyXh8NGwOurJ
         nc+k+RkfFdP+yh4bnXfWDW+2fTWtLxqFuNwHG3wcMqkx6+2GQeBRxrBcTlRRmzZx0riE
         ebHg8ODN69f9a5KE2PIjARGGniWSI66gHFwSVzwrStXdCQQsQ4L9Ii2eP4IAhpIIV2lD
         t1dellidU9atezwDm7uBWsppsoAfd0OpLDcSNUq7dMicDG4TwMkz+AcNGVRQU3KG0ZzN
         A9JA==
X-Gm-Message-State: ANoB5plJfVtPJBCbK1bBH/KiAMb17yiJm3LVYprGHyUurSvq1PqyUcF1
        99IwslPokp7X/zI08E21dHV7v7CI92dC
X-Google-Smtp-Source: AA0mqf7lGZZ4v31cMvNVbWsuRcdcUu/G5Qr1dJkHBTXk6p+od9IpIkYZyFFTc5zjUM888sTF5CpaDWTtO2s5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6268:b448:f7f4:4c2])
 (user=irogers job=sendgmr) by 2002:a05:690c:a01:b0:3b2:cbaa:6f2a with SMTP id
 cg1-20020a05690c0a0100b003b2cbaa6f2amr2927724ywb.500.1670974051035; Tue, 13
 Dec 2022 15:27:31 -0800 (PST)
Date:   Tue, 13 Dec 2022 15:26:49 -0800
In-Reply-To: <20221213232651.1269909-1-irogers@google.com>
Message-Id: <20221213232651.1269909-4-irogers@google.com>
Mime-Version: 1.0
References: <20221213232651.1269909-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 3/5] libtraceevent: Increase libtraceevent logging when verbose
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libtraceevent has added more levels of debug printout and with changes
like:
https://lore.kernel.org/linux-trace-devel/20210507095022.1079364-3-tz.stoyanov@gmail.com
previously generated output like "registering plugin" is no longer
displayed. This change makes it so that if perf's verbose debug output
is enabled then the debug and info libtraceevent messages can be
displayed.
The code is conditionally enabled based on the libtraceevent version as
discussed in the RFC:
https://lore.kernel.org/lkml/20210610060643.595673-1-irogers@google.com/

Based on previously reverted change:
https://lore.kernel.org/linux-perf-users/20210923001024.550263-4-irogers@google.com/
that was reverted due to -Itools/lib being in CFLAGS meaning the
traceevent headers couldn't be properly used from the system.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 65e6c22f38e4..cd575460818f 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -22,6 +22,7 @@
 #include "ui/helpline.h"
 #include "ui/ui.h"
 #include "util/parse-sublevel-options.h"
+#include "util/trace-event.h"
 
 #include <linux/ctype.h>
 
@@ -228,6 +229,15 @@ int perf_debug_option(const char *str)
 	/* Allow only verbose value in range (0, 10), otherwise set 0. */
 	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
 
+#if MAKE_LIBTRACEEVENT_VERSION(1, 3, 0) <= LIBTRACEEVENT_VERSION
+	if (verbose == 1)
+		tep_set_loglevel(TEP_LOG_INFO);
+	else if (verbose == 2)
+		tep_set_loglevel(TEP_LOG_DEBUG);
+	else if (verbose >= 3)
+		tep_set_loglevel(TEP_LOG_ALL);
+#endif
+
 	return 0;
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

