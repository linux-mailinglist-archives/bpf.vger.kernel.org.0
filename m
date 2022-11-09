Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202DD6232FA
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKISvF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKISui (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:50:38 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7370222502
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:50:33 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-367f94b9b16so170194167b3.11
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lT5QMmKiixUc4hOkx2B5agh6ifSSv8GoT3OYojEFayc=;
        b=J5iBygppWMyynh3fjd0h1zimuLLVXPLRICNwzhaTkhTCHnJ60j86AFaw/f1brpqElJ
         OEnHLiYHfWemhwcN5jxIbJxJOEmbZB1bZu6qV+GB3URAJAroxMSJsNboaLLx75pLWFY4
         NnLVvhzppfjD2+S4VNkt8wChsyw5+8/Bhz+kEOKVTu6SG4VAHP9zNdmUfTPO4bG1luwk
         CBFaCLcPIZfEBdeRvmSItRq/n4SZckWr3K3IX24HNN+IEsR3wCx5ZpZHzBE2sogc5wRf
         vs2/QeeLSCSvXEaexqvlkFi8GhQp2CBE/eieS1MsnzxjxRc5C6uVIQGMCmWg4Yvx/WTL
         7qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lT5QMmKiixUc4hOkx2B5agh6ifSSv8GoT3OYojEFayc=;
        b=yFNDjAb5x0KPBAcxjLbE2/Gc5Qo08EWb+e+cwfuKTbk/yGP5gmBwSVYT4pLrh10AYd
         5ikvWFADbBKBtcdaqJHZ5TtQOoyoI5XlGnUbviJlsvyVitgf1hCC6vQDYzmmH49eUnlF
         fYDF2gH87F/MAgmNVGr0RwPVhnhe6uhrY+8hNOlkZxcfUqWhp1nEvIWpTsMRJMx8TlHO
         0k7NJTkeHcxUdHo+npR/CSK0VgnF+paQ4DCayPb78VYllXVmrpefnl4WulL/Y5ff3f7s
         ZiuXDPI70NpeWC0i14nDnlqtauidM/nkQ8IvZ3RczmZPoL8tOYsyalUSFyVldNg4DMTm
         kbrA==
X-Gm-Message-State: ACrzQf2659h8aJC8gFCqSGJTguVhieyngzexg8jkib3Mk1RxQ+ubk4wd
        9D9S51AeDpUfmIu2k3Vjmc8wFgTyem1F
X-Google-Smtp-Source: AMsMyM4N/f2ycS6qQcmparzQwYVX6dleyP6/S0ma7Cd+HCsCnLDoZE6zuY8W1FFoHP1q5N61W1lqeBMzgilI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a25:af12:0:b0:6cb:b5d7:d64d with SMTP id
 a18-20020a25af12000000b006cbb5d7d64dmr60679393ybh.510.1668019832763; Wed, 09
 Nov 2022 10:50:32 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:08 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-9-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 08/14] tools lib perf: Add missing install headers
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

Headers necessary for the perf build. Note, internal headers are also
installed as these are necessary for the build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Makefile | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 21df023a2103..1badc0a04676 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -189,13 +189,21 @@ install_lib: libs
 
 install_headers:
 	$(call QUIET_INSTALL, headers) \
+		$(call do_install,include/perf/bpf_perf.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/core.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/cpumap.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/threadmap.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/evlist.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/evsel.h,$(prefix)/include/perf,644); \
 		$(call do_install,include/perf/event.h,$(prefix)/include/perf,644); \
-		$(call do_install,include/perf/mmap.h,$(prefix)/include/perf,644);
+		$(call do_install,include/perf/mmap.h,$(prefix)/include/perf,644); \
+		$(call do_install,include/internal/cpumap.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/evlist.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/evsel.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/lib.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/mmap.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/threadmap.h,$(prefix)/include/internal,644); \
+		$(call do_install,include/internal/xyarray.h,$(prefix)/include/internal,644);
 
 install_pkgconfig: $(LIBPERF_PC)
 	$(call QUIET_INSTALL, $(LIBPERF_PC)) \
-- 
2.38.1.431.g37b22c650d-goog

