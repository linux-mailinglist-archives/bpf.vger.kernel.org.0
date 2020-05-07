Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413DB1C8DF9
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgEGOKp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgEGOIh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:08:37 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5416BC05BD0A
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 07:08:36 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id x8so5921252qkf.3
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+ot4xu8P2SexJM6MGXYbzzq/GQaqN2BkLb72ro0O34w=;
        b=lVaXZ0mh6FK8Prt7mNxTyIcNt6EFgoSCMlglY8lrSqIasj9pRYsWpcCEztWEsHYepH
         g5HwSqM4GKiXBK4Lil2OEElO+27ehGfV9SxtHiBWHZYCYHtRjfVben1h3D4ESq2wKWs7
         4lCLPZxDH1N31XcmOoo7qSvDFcDJ/AHBCqGKKg6ouvjs3TYuasNXfE324sZNnpQMT9VC
         Ak9hWT/Qxd5dWoPkTB1Gs8JOTJ6LkOMyQiQLHqmHHROwUrqgvBMof3ObRgQyJIPaEpJj
         OCQi6OIPQCLcX8q3h6YpuqQ44j+eISJeXbhrIZZBzRtl218CVoO87VlFmsfoGbX/9IQV
         ayTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+ot4xu8P2SexJM6MGXYbzzq/GQaqN2BkLb72ro0O34w=;
        b=GWYOtKKeNkoHDvy9ZqutovPNY2j3HHekrAHKQrcKSRQFIdVzxvqmmQ6B/yRdQlkV6r
         F8GgrJ+Xelvy2XLK0EKQEOKNJ0zSaJSRBMTo/Tgg1JHWNKd/+9vcu4C5ClJYOzhkbtEM
         m90lcIVhcC8Cy47BI2PgxjF6ax+43kLR2JlKSSd5Du3kHl9ENdh68seDOr1RC1w13gSW
         uMAGjhJ+NLtWGwp8ryi7Lug2xYF5uC1hFnGPNW1G6amcpknfDcTePBjBFNc1cL5DJ/n5
         TxxjuJMYDBMwQG9b6cRyj3uEn/3T4rn5DTiPQh8j7tSeHg1mZnslfyDiuonX2ADyyxhq
         vEfg==
X-Gm-Message-State: AGi0PuZDO+RzFpIXVD2vlkpbr3z8a6QwhROL4Kp8HlFhJ1OlmDsyCvBJ
        E1zacA6kv2NRqXZLPlluUMlNO3SN+irb
X-Google-Smtp-Source: APiQypLSwGFaeQ3jLZNr0eoQmZByLc8kamDR6qEDf34qocQyZvZ+qRw+9vkmNyoQZakPK3lBCHhQ4zRh0Iaq
X-Received: by 2002:ad4:55e7:: with SMTP id bu7mr13866483qvb.88.1588860515414;
 Thu, 07 May 2020 07:08:35 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:02 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-7-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 06/23] perf expr: parse numbers as doubles
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is expected in expr.y and metrics use floating point values such as
x86 broadwell IFetch_Line_Utilization.

Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.l | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 73db6a9ef97e..ceab11bea6f9 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -10,12 +10,12 @@
 char *expr_get_text(yyscan_t yyscanner);
 YYSTYPE *expr_get_lval(yyscan_t yyscanner);
 
-static int __value(YYSTYPE *yylval, char *str, int base, int token)
+static double __value(YYSTYPE *yylval, char *str, int token)
 {
-	u64 num;
+	double num;
 
 	errno = 0;
-	num = strtoull(str, NULL, base);
+	num = strtod(str, NULL);
 	if (errno)
 		return EXPR_ERROR;
 
@@ -23,12 +23,12 @@ static int __value(YYSTYPE *yylval, char *str, int base, int token)
 	return token;
 }
 
-static int value(yyscan_t scanner, int base)
+static int value(yyscan_t scanner)
 {
 	YYSTYPE *yylval = expr_get_lval(scanner);
 	char *text = expr_get_text(scanner);
 
-	return __value(yylval, text, base, NUMBER);
+	return __value(yylval, text, NUMBER);
 }
 
 /*
@@ -81,7 +81,7 @@ static int str(yyscan_t scanner, int token, int runtime)
 }
 %}
 
-number		[0-9]+
+number		[0-9]*\.?[0-9]+
 
 sch		[-,=]
 spec		\\{sch}
@@ -105,7 +105,7 @@ min		{ return MIN; }
 if		{ return IF; }
 else		{ return ELSE; }
 #smt_on		{ return SMT_ON; }
-{number}	{ return value(yyscanner, 10); }
+{number}	{ return value(yyscanner); }
 {symbol}	{ return str(yyscanner, ID, sctx->runtime); }
 "|"		{ return '|'; }
 "^"		{ return '^'; }
-- 
2.26.2.526.g744177e7f7-goog

