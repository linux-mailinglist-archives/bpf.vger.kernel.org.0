Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07CA6DA461
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 23:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbjDFVG3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 17:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbjDFVGV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 17:06:21 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A4A260;
        Thu,  6 Apr 2023 14:06:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id le6so38592767plb.12;
        Thu, 06 Apr 2023 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815180; x=1683407180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBFoBGUsZtlCcm49brE9d8NiEeIvmudl2UdEa0t2qso=;
        b=agxBXqMPB/e8EYldOhlAOsV8F6tqYhE7pZcY/TWW31wuXDzifZpFbENCmm7aHmI0g3
         gxAi/X2i7e7RmvfDBhvBgIppvqNxNAwLrREkDWokcirragWlNN+C2sT36H+FQrHDKBnM
         oK0JZ+HhWP93N3b4NPBsnIZ9Ri6XSNC6OzRAqwQwn15XdBLhy95A8Ce1ffohCJLTIhd4
         aiiAKTgJYQ4ZnFlR6hqVIVsKb8JHsJCgI47EvKjR1Hu1UlJKydniagF4DGeoUvyp+cr1
         V/iB5lZ9BHtzjIJS6UXAPDQ970wjqTN9oShZY7oR4IMqwSK66rDfwfJte27A1xyLynDt
         nGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815180; x=1683407180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBFoBGUsZtlCcm49brE9d8NiEeIvmudl2UdEa0t2qso=;
        b=fmKiWTn0lror1qA0/0UBUYhcax7t0GyTWj8aXXUCiMdu8sGzQj4UYE51El5sY7JRqi
         Cm6wnBQwXmEJU07dbpb82GqeYNtjrLUxChuA+PzeRy0fUtnHgywkS4N58jEqt5/5yaum
         KI66W2FOnll4iKhMIi/Ap9fMmtUFVYsih9NnulWKDB3b94zXMaUhFS8avURdkGEWz/xw
         FeEFEcnUuTW1USPjwAFd2stQDe9g56qiKNFWlCgctmu+lWA0ggQrnajxi/JVEHZyE889
         AJiHLxqxcl1bbG/nXSyCfMMLL5VWBn2kWl7gypiGDb83oWzhROVEbH3nx+eG36T+KYXV
         96Lg==
X-Gm-Message-State: AAQBX9f5aISsjc2A9e6ALtCakV2DyXMYkIlb2L+uYnHQmfGiaE4hHAhb
        rm71osooHNzuf7clFFJ3LZg=
X-Google-Smtp-Source: AKy350Ze+6gZk1BaxaSYW8bkYftz9rPkwzzOL2VoXpz5toX8VbJiZko1fPZvg8bpc2UXwiWvr/nYsg==
X-Received: by 2002:a17:902:e1c1:b0:1a1:ad52:4060 with SMTP id t1-20020a170902e1c100b001a1ad524060mr438506pla.20.1680815180302;
        Thu, 06 Apr 2023 14:06:20 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3301:38fe:e39e:3d51])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902868500b001a0667822c8sm1777837plo.94.2023.04.06.14.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:06:19 -0700 (PDT)
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
Subject: [PATCH 5/7] perf lock contention: Update total/bad stats for hidden entries
Date:   Thu,  6 Apr 2023 14:06:09 -0700
Message-Id: <20230406210611.1622492-6-namhyung@kernel.org>
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

When -E option is used, it only prints the given number of entries but
the event stat at the end should have the numbers for entire entries.

Likewise, -S option will hide entries that don't have the named
function in the callstack.  Also update event stat for them.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c             | 11 +++++++++++
 tools/perf/util/bpf_lock_contention.c |  4 +++-
 tools/perf/util/lock-contention.h     |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 01b318d6c80a..7742fa255c44 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1726,6 +1726,17 @@ static void print_contention_result(struct lock_contention *con)
 			break;
 	}
 
+	if (print_nr_entries) {
+		/* update the total/bad stats */
+		while ((st = pop_from_result())) {
+			total += use_bpf ? st->nr_contended : 1;
+			if (st->broken)
+				bad++;
+		}
+	}
+	/* some entries are collected but hidden by the callstack filter */
+	total += con->nr_filtered;
+
 	if (use_bpf)
 		print_bpf_events(total, &con->fails);
 	else
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 0071058ac3d2..ea4f697d2a9f 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -299,8 +299,10 @@ int lock_contention_read(struct lock_contention *con)
 		if (con->save_callstack) {
 			bpf_map_lookup_elem(stack, &key.stack_id, stack_trace);
 
-			if (!match_callstack_filter(machine, stack_trace))
+			if (!match_callstack_filter(machine, stack_trace)) {
+				con->nr_filtered += data.count;
 				goto next;
+			}
 		}
 
 		switch (con->aggr_mode) {
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 3ed1cad370fc..fa16532c971c 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -141,6 +141,7 @@ struct lock_contention {
 	int stack_skip;
 	int aggr_mode;
 	int owner;
+	int nr_filtered;
 	bool save_callstack;
 };
 
-- 
2.40.0.577.gac1e443424-goog

