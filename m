Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39748664EB1
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 23:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjAJWV7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 17:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjAJWV3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 17:21:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1A92F791
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 14:21:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r8-20020a252b08000000b007b989d5e105so10839411ybr.11
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 14:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sg2Aa5uCHWcDC8jm9J4EAv2OJFGtXnNHMXMT9mO4Gw=;
        b=AW29Ki0ipdxS14sshMxXhqz4FZFcNVmZ3WvoBGdx8Bla7+yjxNrYSNmR1ihsyWRsrf
         X60XFLMewiYm9IGefUm4eEzu+c8CeyIivN4qFu4JpwnYwB3jA2QMO7bOOM3Ko7g1jq8K
         C5RnWXn1KhH66oHffsmy/GqlYcVahiBR3eqjUSNwhLqIpkauqFmAyRmy+3bD+cnZC0dZ
         KFqMPnIG2GLgHMH6PYQiwuTfPPwsF8vA5I0JxA/flSZfhMIfeqXMaRE2xMVljQClk+CN
         NAwV6KvZTl/6ClD/vaGcAe7VaWC8QwAk0u7Hs7wmIUwxTE33GdGdAYSdTQfnpepXNN/1
         khRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sg2Aa5uCHWcDC8jm9J4EAv2OJFGtXnNHMXMT9mO4Gw=;
        b=s4OfmQBsfI9SVhV/oOoBY3JCn5uO8wKSsV45e1eGfHDmMcxSVcftRvVRQUaxC2of85
         2e616CfsMFdbkwZ7LT2XVsm8WmY5SFwtQTJtK0r82FxhnRb7ABhIUdjw+UzHxTin5GEB
         mLAM7pFfba8cbCOyUysW548/co8PV6O397Jv9K8pqZAmI3ZrLBWinU04UWoQCdRWinr+
         JFsQEH4gfb5JSP7bud6kR9jnQlzTewN815HbWMdOLsAC3y1pKRPcdW66yU4gJ/5E+9Ze
         q2y1+yaLbCN6l+VjgKyi9xQ9mzXIb0I7NNWM6TjBz9OVesATSw1Fu++j/8ejICnF7s9X
         I1eg==
X-Gm-Message-State: AFqh2kpaWVv+Ucs+S77MyUgyMyZqX7AOG22XT82Zl4N2y0Wee4v9hqKm
        xsCkGuXvH3V2wNosxHrzVTaIX2RnfcYE
X-Google-Smtp-Source: AMrXdXul//OabQOCLWyx1Luc6Hl+ueTmgO396xd2lzHTTOh6r4Z7uBXUeTt67VSekVDq2442YXd8T9SPuWGF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cebf:c37e:8184:56])
 (user=irogers job=sendgmr) by 2002:a25:449:0:b0:7b6:f8d5:82f4 with SMTP id
 70-20020a250449000000b007b6f8d582f4mr2181307ybe.646.1673389264926; Tue, 10
 Jan 2023 14:21:04 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:20:01 -0800
In-Reply-To: <20230110222003.1591436-1-irogers@google.com>
Message-Id: <20230110222003.1591436-6-irogers@google.com>
Mime-Version: 1.0
References: <20230110222003.1591436-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 5/7] tools lib api: Tweak strbuf allocation size computation
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Qi Liu <liuqi115@huawei.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Xin Gao <gaoxin@cdjrlc.com>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stephane Eranian <eranian@google.com>,
        German Gomez <german.gomez@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
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

alloc_nr gives an estimate of the actual memory behind an allocation
but isn't accurate. Use malloc_usable_size to accurately set the
strbuf alloc, which potentially avoids realloc calls.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/strbuf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/lib/api/strbuf.c b/tools/lib/api/strbuf.c
index eafa2c01f46a..a3d7f96d8b9f 100644
--- a/tools/lib/api/strbuf.c
+++ b/tools/lib/api/strbuf.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <malloc.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -42,7 +43,6 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
 	return res;
 }
 
-#define alloc_nr(x) (((x)+16)*3/2)
 int strbuf_grow(struct strbuf *sb, size_t extra)
 {
 	char *buf;
@@ -54,9 +54,6 @@ int strbuf_grow(struct strbuf *sb, size_t extra)
 	if (nr <= sb->len)
 		return -E2BIG;
 
-	if (alloc_nr(sb->alloc) > nr)
-		nr = alloc_nr(sb->alloc);
-
 	/*
 	 * Note that sb->buf == strbuf_slopbuf if sb->alloc == 0, and it is
 	 * a static variable. Thus we have to avoid passing it to realloc.
@@ -66,10 +63,9 @@ int strbuf_grow(struct strbuf *sb, size_t extra)
 		return -ENOMEM;
 
 	sb->buf = buf;
-	sb->alloc = nr;
+	sb->alloc = malloc_usable_size(buf);
 	return 0;
 }
-#undef alloc_nr
 
 int strbuf_addch(struct strbuf *sb, int c)
 {
-- 
2.39.0.314.g84b9a713c41-goog

