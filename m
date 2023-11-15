Return-Path: <bpf+bounces-15124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258ED7ECCCA
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 20:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D969C1F26443
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 19:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B41C41A84;
	Wed, 15 Nov 2023 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J/lgWwOX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC24241238;
	Wed, 15 Nov 2023 19:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A83C433C8;
	Wed, 15 Nov 2023 19:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700076744;
	bh=1vggK7mVspav3/P3O1C5gNAMWQ7UNzapoocGa8Nq26s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/lgWwOXuKtdzXbkQ4+caO860LPyZ/FR/sZc9VLpx9vfO6sShbKd8xCybeBa+Q5tG
	 VSuisKjRp7DKIeXHxWuWwervM/VJjndyYwAEYrP2Nf2JQ6Wk7J9il+hJJQ3gnK3vsH
	 VYzB7fX3ZzI8O8ZkhHSoHXQWTOVeh3/DnffLgLy4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 389/550] perf parse-events: Remove ABORT_ON
Date: Wed, 15 Nov 2023 14:16:13 -0500
Message-ID: <20231115191627.807355002@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 4c11adff675652759a0f0ad2194f4646b5463a42 ]

Prefer informative messages rather than none with ABORT_ON. Document
one failure mode and add an error message for another.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20230627181030.95608-14-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: ede72dca45b1 ("perf parse-events: Fix tracepoint name memory leak")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/parse-events.y | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 1393c39ebf330..24c9af561cf9d 100644
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
2.42.0




