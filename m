Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8D96DA45B
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 23:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbjDFVGS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 17:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjDFVGR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 17:06:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427CF7695;
        Thu,  6 Apr 2023 14:06:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso41834170pjb.3;
        Thu, 06 Apr 2023 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815176; x=1683407176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQHjim2b0yMTMa0pJ6UBA3m+CHWny/YWANmbBtZt/VM=;
        b=VJC8IjaH64njjW79hVKy3WUlQE+qs67A8DgvPgWdg+fdPxoCQL8sTRdBSOwtiiJlw1
         NSccr1HtapFBT5boikl6arLPOKUBtD8i6HHSN5Aq4n0JBq8INbKGx+IaL5G5lUst87a2
         6EYfPaN+smv1uCm7n4AftMapRl4qwE3VuO80+hsJiQN73Rkx22tUEyfMirf9td+/oxXd
         DIiMGWvsplboqLPbaujoN280Dm2GYLMlUni5904K+n0BQLIAturPR/Jpc+0fzWEqhTZt
         iTs/YASBsrLbFcFfisVXXd06RlWSzl820JK7wyXmJe2zuYo4uoEvR3zfIyQWm/24kNdV
         Ss/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815176; x=1683407176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQHjim2b0yMTMa0pJ6UBA3m+CHWny/YWANmbBtZt/VM=;
        b=dIcNPBwLFctdfCNHdJ5bgrOrGX0JFBdt3Jx7Spj9MVjv5lnnWXEM8L1omy7fSZRcHD
         N+En6Gb0Cq+D63vdQqyRBuRm00/7sbIlTR8GAqsweR+4bUSsQeHKD9xI4Qkh6XTrhjV8
         yAxI/FTVuaejKpurMu5Fy8F/jGbzhMMmzvH/od937DcRKdMFcY6YUos4Ic4VOiRt7elt
         aGtiwGW2oNn8C4+w1mP2Guc5qgAfu7YmgNAbR+RgWvjMeJRqIGBHFt8If1TPQyCQKlVN
         COQxhnf6nLBcr6vShl6lUMCjqEjZ3h7idNRtfjrbS6UOak6uRth4Yi9z4LnT8PHdlFwJ
         d8Ow==
X-Gm-Message-State: AAQBX9dV3oQM4NZKXVGAxkNLW5lgCPCCBR60HJvBm33roGFMNEZ1Iv4F
        4/37j7hZRbVGrF0ulDi5VZcslDu5SbI=
X-Google-Smtp-Source: AKy350bkl6KvaHqRNVvsSFqVI3904a3o+yyENiSBlqxPNU+GN5i85yZhFAWLOSogZJ8Ue/5/Y1MnlA==
X-Received: by 2002:a17:902:da8d:b0:19d:af20:3fe8 with SMTP id j13-20020a170902da8d00b0019daf203fe8mr639149plx.21.1680815175598;
        Thu, 06 Apr 2023 14:06:15 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3301:38fe:e39e:3d51])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902868500b001a0667822c8sm1777837plo.94.2023.04.06.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:06:15 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 1/7] perf lock contention: Simplify parse_lock_type()
Date:   Thu,  6 Apr 2023 14:06:05 -0700
Message-Id: <20230406210611.1622492-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230406210611.1622492-1-namhyung@kernel.org>
References: <20230406210611.1622492-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The get_type_flag() should check both str and name fields in the
lock_type_table so that it can find the appropriate flag without retrying
with ':R' or ':W' suffix from the caller.

Also fix a typo in the rt-mutex.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 43 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 32ec58fb80e4..695ce6bd64f7 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1557,7 +1557,7 @@ static const struct {
 	{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W",	"rwlock" },
 	{ LCB_F_READ,			"rwsem:R",	"rwsem" },
 	{ LCB_F_WRITE,			"rwsem:W",	"rwsem" },
-	{ LCB_F_RT,			"rt=mutex",	"rt-mutex" },
+	{ LCB_F_RT,			"rt-mutex",	"rt-mutex" },
 	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R",	"rwlock-rt" },
 	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W",	"rwlock-rt" },
 	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"percpu-rwsem" },
@@ -1596,6 +1596,10 @@ static unsigned int get_type_flag(const char *str)
 		if (!strcmp(lock_type_table[i].name, str))
 			return lock_type_table[i].flags;
 	}
+	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+		if (!strcmp(lock_type_table[i].str, str))
+			return lock_type_table[i].flags;
+	}
 	return UINT_MAX;
 }
 
@@ -2121,46 +2125,15 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 		unsigned int flags = get_type_flag(tok);
 
 		if (flags == -1U) {
-			char buf[32];
-
-			if (strchr(tok, ':'))
-			    continue;
-
-			/* try :R and :W suffixes for rwlock, rwsem, ... */
-			scnprintf(buf, sizeof(buf), "%s:R", tok);
-			flags = get_type_flag(buf);
-			if (flags != UINT_MAX) {
-				if (!add_lock_type(flags)) {
-					ret = -1;
-					break;
-				}
-			}
-
-			scnprintf(buf, sizeof(buf), "%s:W", tok);
-			flags = get_type_flag(buf);
-			if (flags != UINT_MAX) {
-				if (!add_lock_type(flags)) {
-					ret = -1;
-					break;
-				}
-			}
-			continue;
+			pr_err("Unknown lock flags: %s\n", tok);
+			ret = -1;
+			break;
 		}
 
 		if (!add_lock_type(flags)) {
 			ret = -1;
 			break;
 		}
-
-		if (!strcmp(tok, "mutex")) {
-			flags = get_type_flag("mutex-spin");
-			if (flags != UINT_MAX) {
-				if (!add_lock_type(flags)) {
-					ret = -1;
-					break;
-				}
-			}
-		}
 	}
 
 	free(s);
-- 
2.40.0.577.gac1e443424-goog

