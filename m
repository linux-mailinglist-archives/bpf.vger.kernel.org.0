Return-Path: <bpf+bounces-3536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D13A73F38B
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 06:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1362807B1
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 04:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5604A2A;
	Tue, 27 Jun 2023 04:35:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FD44A23
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 04:35:53 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB342139
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-564fb1018bcso58081777b3.0
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 21:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840547; x=1690432547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xtK5HWFrotXOQTFAtNsXMiJLnjczB0bKaJqMYYAdAw=;
        b=dq8Z6/zkvj5AhkzyvCcePMaY/4TJVw6FKcFL0Grg7cTDpD7U97mANBasuEHRqq5E6J
         CeQG3laHxYsRQCw3jJIaAi640DkEL7fgTvW22VJ8WDVgEl+4NX2s598D87gax6gGuSoB
         5hMicurS2TR9HLtZr0Wd1+mVC7zxtAjFXsaOKbM0in3upafjoLIvGDv/bWUYVrx7xhKU
         cqHeiQZ1IEWQgkzY5fGck0b2h+bdXDUYdfXp4LE7J8DEVN8XccrdNwldcj6O43u/1TpF
         Z9PZyLuTNMg27UDpArpdutfeETdpMIdn7hEG+m84SMTDXzgW2+FoZUTV0XQUDCUMEpna
         RnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840547; x=1690432547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/xtK5HWFrotXOQTFAtNsXMiJLnjczB0bKaJqMYYAdAw=;
        b=bVGo44KT3SVUy8uwrid/++jXtaQLEOS6oJgegj4fwsuobYA+Xzow/DAR7WlQedA4aC
         KhuPspA25qkaynz+ZL4LQdUDh8R/ITosHygHZCm2z2Gc8QJ7mpCFGT5J3+JGJrYUv8dI
         knDwJD2pBk7oL0adLiB+/D3ZOjjjeKybaF2Djk4wIf6krOEJ2qAOhFz8/6WJnF34BoWW
         DWloljx+7vwxkMafF+fCwIfBTQoOb7ueltk7SQrrE5R0u8o/T7f/ai/+Vgvip0hJ+8TT
         4Qpgt322KYDLJrUwDeqSV4FDYWpR4cqywcqb18sLNE0FpVDJMKOGhks/Mr99cc+4mejr
         NCBg==
X-Gm-Message-State: AC+VfDwMFSKtnhVOK5xvFBYxOgToc/UyfEgjidkAJ2X9JQYOoA6Rj1aN
	E+IlqJvJXZhwW+UoPF8Cc4rIcydZJSB8
X-Google-Smtp-Source: ACHHUZ7GCRaJQ8Zjv8j32ZTbpzp8/lqeBYs2D+DAkuQ/ELDVxl53n8Ud2bKcAn8g+26DHXYGmXXZ/pEJnOgt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a81:b344:0:b0:56d:25f3:f940 with SMTP id
 r65-20020a81b344000000b0056d25f3f940mr13876270ywh.10.1687840547041; Mon, 26
 Jun 2023 21:35:47 -0700 (PDT)
Date: Mon, 26 Jun 2023 21:34:58 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 13/13] perf parse-events: Remove ABORT_ON
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prefer informative messages rather than none with ABORT_ON. Document
one failure mode and add an error message for another.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 844646752462..454577f7aff6 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -22,12 +22,6 @@
 
 void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, char const *msg);
 
-#define ABORT_ON(val) \
-do { \
-	if (val) \
-		YYABORT; \
-} while (0)
-
 #define PE_ABORT(val) \
 do { \
 	if (val == -ENOMEM) \
@@ -618,7 +612,9 @@ PE_RAW opt_event_config
 		YYNOMEM;
 	errno = 0;
 	num = strtoull($1 + 1, NULL, 16);
-	ABORT_ON(errno);
+	/* Given the lexer will only give [a-fA-F0-9]+ a failure here should be impossible. */
+	if (errno)
+		YYABORT;
 	free($1);
 	err = parse_events_add_numeric(_parse_state, list, PERF_TYPE_RAW, num, $2,
 				       /*wildcard=*/false);
@@ -978,7 +974,17 @@ PE_VALUE PE_ARRAY_RANGE PE_VALUE
 {
 	struct parse_events_array array;
 
-	ABORT_ON($3 < $1);
+	if ($3 < $1) {
+		struct parse_events_state *parse_state = _parse_state;
+		struct parse_events_error *error = parse_state->error;
+		char *err_str;
+
+		if (asprintf(&err_str, "Expected '%ld' to be less-than '%ld'", $3, $1) < 0)
+			err_str = NULL;
+
+		parse_events_error__handle(error, @1.first_column, err_str, NULL);
+		YYABORT;
+	}
 	array.nr_ranges = 1;
 	array.ranges = malloc(sizeof(array.ranges[0]));
 	if (!array.ranges)
-- 
2.41.0.162.gfafddb0af9-goog


