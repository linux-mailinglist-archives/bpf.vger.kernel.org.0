Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FF1217A0F
	for <lists+bpf@lfdr.de>; Tue,  7 Jul 2020 23:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgGGVOz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jul 2020 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgGGVOy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jul 2020 17:14:54 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8213DC08C5DC
        for <bpf@vger.kernel.org>; Tue,  7 Jul 2020 14:14:54 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i3so23260583qkf.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2020 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bZmyhAdgaKUq3ObPHZGaFsLGtyML3TDUUaEu5ftDn5s=;
        b=NpttPX4lE/KU7Nm0bJYE/p4jYzLQMfv+GHpHKNOzf6UyPqa0Gp4+76X3XGeuO+SXTV
         nxXA/QOjtZHr8zrC18uOgoYZPubDfwhPRExz7mV1sSv/WCDVk7rSil8JAKB82C3+PuX/
         9PA6gy1V4MjX5usNyjtpTu8Ri0XzAEs/n6bkMZizqZtcIrCsTLio07SKKLIygBOPy8B3
         yU/R2xvDU9Own06aGUtf9wIQtXBICRWwf/gWlmgMcy/4QfzQJ9zZclq/xmahiZEmhQqE
         Von6X666O+hyizXf2P7+qN4Ufq6EwWt0d9nz8HKmBL2eGXdFpKA2bQH+jmHDAdvaJtTS
         63SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bZmyhAdgaKUq3ObPHZGaFsLGtyML3TDUUaEu5ftDn5s=;
        b=Vph84rBZlBFoScmU00kI/4ozbSVbs0nW2BgQZJmTXcMr0iYQ0XoiT0kI5elU88Do8+
         BFAEghRvkyaINawPlOGoZ1vGJEwsnren/wvpaLNM3RQFE80NRiQ7uDs+iRVr5u6IPiED
         lUk17euf4WjSaIAcJZtKbXzeIEcrxIL6fAWv0RsSnKDJfFH5n+7AeqHI21Binez/InRv
         f5F+DI7ULm1it75b0dUQ5bcUC5TWW8vzj/WzJEOqaNC6j7nx1n29A2yiEppyIBLIM7ve
         P3E7vUDQjYxVfj2HX7wf/Fnr0PZgrv2vkpxFJgv1Nx78C//H4hmhZkAjq7JFr13lVJwS
         T8CQ==
X-Gm-Message-State: AOAM531yLDT8jWE9tgugbjftIjfKxkos6ZmKq9CU44kveuihpoA3/XR/
        ccUs2OFB2Uqv91suAmHcvuK0yREEjUWr
X-Google-Smtp-Source: ABdhPJz11nAFayeFkeDlsq5u5viuPaf3vPkR1JHcLuMxQm3bAygcsTZwF4wZeLIxLQEz07pF9vLNjfqglMvx
X-Received: by 2002:ad4:4c09:: with SMTP id bz9mr20609878qvb.210.1594156493566;
 Tue, 07 Jul 2020 14:14:53 -0700 (PDT)
Date:   Tue,  7 Jul 2020 14:14:49 -0700
Message-Id: <20200707211449.3868944-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH] perf parse-events: report bpf errors
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Setting the parse_events_error directly doesn't increment num_errors
causing the error message not to be displayed. Use the
parse_events__handle_error function that sets num_errors and handle
multiple errors.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 38 ++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c4906a6a9f1a..e88e4c7a2a9a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -767,8 +767,8 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
 
 	return 0;
 errout:
-	parse_state->error->help = strdup("(add -v to see detail)");
-	parse_state->error->str = strdup(errbuf);
+	parse_events__handle_error(parse_state->error, 0,
+				strdup(errbuf), strdup("(add -v to see detail)"));
 	return err;
 }
 
@@ -784,36 +784,38 @@ parse_events_config_bpf(struct parse_events_state *parse_state,
 		return 0;
 
 	list_for_each_entry(term, head_config, list) {
-		char errbuf[BUFSIZ];
 		int err;
 
 		if (term->type_term != PARSE_EVENTS__TERM_TYPE_USER) {
-			snprintf(errbuf, sizeof(errbuf),
-				 "Invalid config term for BPF object");
-			errbuf[BUFSIZ - 1] = '\0';
-
-			parse_state->error->idx = term->err_term;
-			parse_state->error->str = strdup(errbuf);
+			parse_events__handle_error(parse_state->error, term->err_term,
+						strdup("Invalid config term for BPF object"),
+						NULL);
 			return -EINVAL;
 		}
 
 		err = bpf__config_obj(obj, term, parse_state->evlist, &error_pos);
 		if (err) {
+			char errbuf[BUFSIZ];
+			int idx;
+
 			bpf__strerror_config_obj(obj, term, parse_state->evlist,
 						 &error_pos, err, errbuf,
 						 sizeof(errbuf));
-			parse_state->error->help = strdup(
+
+			if (err == -BPF_LOADER_ERRNO__OBJCONF_MAP_VALUE)
+				idx = term->err_val;
+			else
+				idx = term->err_term + error_pos;
+
+			parse_events__handle_error(parse_state->error, idx,
+						strdup(errbuf),
+						strdup(
 "Hint:\tValid config terms:\n"
 "     \tmap:[<arraymap>].value<indices>=[value]\n"
 "     \tmap:[<eventmap>].event<indices>=[event]\n"
 "\n"
 "     \twhere <indices> is something like [0,3...5] or [all]\n"
-"     \t(add -v to see detail)");
-			parse_state->error->str = strdup(errbuf);
-			if (err == -BPF_LOADER_ERRNO__OBJCONF_MAP_VALUE)
-				parse_state->error->idx = term->err_val;
-			else
-				parse_state->error->idx = term->err_term + error_pos;
+"     \t(add -v to see detail)"));
 			return err;
 		}
 	}
@@ -877,8 +879,8 @@ int parse_events_load_bpf(struct parse_events_state *parse_state,
 						   -err, errbuf,
 						   sizeof(errbuf));
 
-		parse_state->error->help = strdup("(add -v to see detail)");
-		parse_state->error->str = strdup(errbuf);
+		parse_events__handle_error(parse_state->error, 0,
+					strdup(errbuf), strdup("(add -v to see detail)"));
 		return err;
 	}
 
-- 
2.27.0.383.g050319c2ae-goog

