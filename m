Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7FE620A49
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiKHHgn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiKHHg2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:36:28 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC718E18
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:36:26 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-368994f4bc0so129230267b3.14
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fypXC5s+GJmcY7CDMLyT+XFtNB7Xjp9TotzTIy3WOeg=;
        b=RFQfsHnIDHpWmCnVp7oWB/dlG/LSle5NsakxQiW831EphqfLIO67hShWTaPkaY7wfR
         STd+zApFgJEbyUvLuxvD4EXb/kL+iGirFD8ucU9AMzwV4ihlBrZXlnz5cjvAfw+a3nBA
         Je3YTYoxRrQYmHiUxjvPkx3oUXC6f2wirLFG1hMM5LPMlqV0lMe2/Bo2VW8WzpbU2l6W
         RMBKIMPMQt1CfBX/oBOFE38EBMoD7mJlw9kyQxNBo2Ll91Ie7BQ2Qc5x4XzeVHdtPK2k
         SG/m69f1Fm3xjgJavEJ3OUSWeVo2eiybuK/Nem1AyhZNQ7xScIqszLV6xxZEs+U4o4Cx
         kEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fypXC5s+GJmcY7CDMLyT+XFtNB7Xjp9TotzTIy3WOeg=;
        b=B2BegKLJ0xCJT68X4zKzpgFIhgXhZIimkCHTh3aT+RczPmWCTUCRYu/EoXwAnjN3Va
         GWZSKRfI3oElM+NpFu08WAMjZuCGACg3GITerNe5r8+GyrDv0kZmWanDVUUg3251qQLD
         Ggo9GKxNbJd1PIWILe7xGe56BkTz8H94qcyStPfZxSSTlPwJXibKrxiaWPH45GC2gAVx
         nhpJbax8qb86hsTiaCTvAn8Qokx/OXFgpYcnWi2Gnj7sjkU8T1uBPKsAjLoMj4E8KJ/1
         y9gihtTrknRhyaxCWFl1maaCbsMWfph1G9gJVP3sQnU0g4JVECDZsVB8e7T2fMKof94v
         BJzA==
X-Gm-Message-State: ANoB5plN1hE11S5WXy6msHNphtvWkrWxbWJgRVzH6urOVOCaCZ0Md94B
        hrzJ7FJH0+g1AN5JY0fQ+9OUWp55siar
X-Google-Smtp-Source: AA0mqf4jETz2UWVRQXlwt7m55hk/+EqfiUxjrjtBdYvgwGZRi4Ta5w6Wbs4sawPtIEv0aQSnkXr8qLhRKDJO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a25:c011:0:b0:6d0:ee14:6287 with SMTP id
 c17-20020a25c011000000b006d0ee146287mr15020385ybf.622.1667892985905; Mon, 07
 Nov 2022 23:36:25 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:11 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-8-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 07/14] tools lib api: Add missing install headers
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

Headers necessary for the perf build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 6629d0fd0130..3e5ef1e0e890 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -103,7 +103,10 @@ install_headers:
 	$(call QUIET_INSTALL, headers) \
 		$(call do_install,cpu.h,$(prefix)/include/api,644); \
 		$(call do_install,debug.h,$(prefix)/include/api,644); \
-		$(call do_install,io.h,$(prefix)/include/api,644);
+		$(call do_install,io.h,$(prefix)/include/api,644); \
+		$(call do_install,fd/array.h,$(prefix)/include/api/fd,644); \
+		$(call do_install,fs/fs.h,$(prefix)/include/api/fs,644);
+		$(call do_install,fs/tracing_path.h,$(prefix)/include/api/fs,644);
 
 install: install_lib install_headers
 
-- 
2.38.1.431.g37b22c650d-goog

