Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AFC5B53AC
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 07:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiILFxW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 01:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiILFxV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 01:53:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6EC252A3;
        Sun, 11 Sep 2022 22:53:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 65so7624773pfx.0;
        Sun, 11 Sep 2022 22:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=6V7H/cEIprYFtsFgwheCaiJjKxQhc/M9o0PCNmXcjvc=;
        b=IzOO4rCxyFkI4dQ3X5NFgsAQqvmFiSYd6WXo+2XpI6Ry5ko4HEGW68UlDC0+mEpPOI
         CFwCyhQFSHrBY+wzCDucU33voaxBM6kLi82DNX11dLeNBV4wEe1qDM8PAUxvxI9301p5
         mNq8C/lCqqwUoQvinbT1rj6TJxHkb8pRX9mxMgLIUUfv1qkdP5ijCo3Cv9TohpCsx37f
         f5oesjNHxSytyjMumWkoOv9rEhFRmnYg7k0h2gWqsYhPlz0XjnN389Ns2TfYFm9NnkmG
         X3rWfKtMaVog5CzDOc6pOEtfL4qBglvMK2IMP8XnVM+6RnZDhskWpygfbuxggI2FQDra
         bc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=6V7H/cEIprYFtsFgwheCaiJjKxQhc/M9o0PCNmXcjvc=;
        b=TiQ7qU8Jbt1a1bEq4hWQ5v7fji7c/rIQXh5YF6mhoBp+8UfXI0tIbcr2FDE+V194GW
         +BnPCghNzLA7J86zyj2LHh8hqA4vdpw01r/Jjr3lO04fS9KCbwcgHCMXEbH5nV8RggGI
         kYZjyspN89kynsdTf/SxcHdVuOutsKGoAlHJcfqjlVOY/7KjFA70zTd8iwNLsMcsiVyP
         TtND8di9yDfujXbG2GUv4EelbuChVa/XNXyUrm5t8EMqtoK6l8kW2JUD0KWuHKsZznoY
         To9RKcVYWTzcnlEwx8V56aFrN9HCRt6bVPTrUZ0nLLaFy7WFwPCdxyNr2Nw4SVL0Spdt
         zKkA==
X-Gm-Message-State: ACgBeo1FoOf0Bg8OyWcjvLUl+4JMOmN3338jB9dkhCFxfo1mljOpxGcK
        Ckw6hygdYxXK1SqhM54wIug=
X-Google-Smtp-Source: AA6agR6OzHXJORf8riDYYg5/qT4envvqvv1wjq2lkwtYwiKuDEHKIgASWZ9TkQvQSLXxSl2Eq2Qxpw==
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP id b12-20020a056a00114c00b005282c7a6302mr25854146pfm.37.1662961999775;
        Sun, 11 Sep 2022 22:53:19 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:cfe7:8794:a807:6746])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b00176b87a697fsm4882736pls.269.2022.09.11.22.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:53:19 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH 1/4] perf lock contention: Factor out get_symbol_name_offset()
Date:   Sun, 11 Sep 2022 22:53:11 -0700
Message-Id: <20220912055314.744552-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220912055314.744552-1-namhyung@kernel.org>
References: <20220912055314.744552-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's to convert addr to symbol+offset.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 52a6a10a610c..eaba6018da69 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -899,6 +899,23 @@ bool is_lock_function(struct machine *machine, u64 addr)
 	return false;
 }
 
+static int get_symbol_name_offset(struct map *map, struct symbol *sym, u64 ip,
+				  char *buf, int size)
+{
+	u64 offset;
+
+	if (map == NULL || sym == NULL) {
+		buf[0] = '\0';
+		return 0;
+	}
+
+	offset = map->map_ip(map, ip) - sym->start;
+
+	if (offset)
+		return scnprintf(buf, size, "%s+%#lx", sym->name, offset);
+	else
+		return strlcpy(buf, sym->name, size);
+}
 static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sample,
 				  char *buf, int size)
 {
@@ -941,15 +958,8 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 
 		sym = node->ms.sym;
 		if (sym && !is_lock_function(machine, node->ip)) {
-			struct map *map = node->ms.map;
-			u64 offset;
-
-			offset = map->map_ip(map, node->ip) - sym->start;
-
-			if (offset)
-				scnprintf(buf, size, "%s+%#lx", sym->name, offset);
-			else
-				strlcpy(buf, sym->name, size);
+			get_symbol_name_offset(node->ms.map, sym, node->ip,
+					       buf, size);
 			return 0;
 		}
 
-- 
2.37.2.789.g6183377224-goog

