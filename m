Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAFC3AF821
	for <lists+bpf@lfdr.de>; Mon, 21 Jun 2021 23:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhFUV7M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Jun 2021 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbhFUV7J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Jun 2021 17:59:09 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC1C061574
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 14:56:53 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z4-20020ac87f840000b02902488809b6d6so16764102qtj.9
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cqqc0EDu2I7xCxfE/MPAJgRcE4NrX97BWzFjUvHGMpU=;
        b=WFY5SE/nXZWHGedgQMIcsyiRFbkJ5UKJty2UoIJN2MhgpSE0jZ6OSSya1WfhDk3xyV
         UhV1hnt90aAsqKzqZejcfBqI0/lwXJxfxDO1V4EmP09E5iB5JOfEHpc7l1+RAyWbHoZG
         glnUe3AIVXn40Bo9QeDxLVhGf7XJW9J+FXgb5JGUJPx0NheMmUP1BfpL/fkfICCRJOAf
         fFFl9iAPR0niRHl/c8hF1SSnAdFT7p4Uz9Ngb7GXdQ04VyrYgcz098wvMjQGNMCiePfE
         gWZZDX+eevbClaxKlRlisqJXnUAwH/AJEwdqEqDLMh54QEEpF+RKZWU8agoPpeY2eoWy
         vONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cqqc0EDu2I7xCxfE/MPAJgRcE4NrX97BWzFjUvHGMpU=;
        b=T/AQiq8W/kcXcjmYb3Kvb+snJIqvISn70QQkiRvLwEe41x7I8cxptJ1shnJZo5UWjT
         E5KjyXJ/u7MQigd9o7YYNlFpnA/lPq2OPjP8QyqwYGBGu5g6XDfutEu3JMiFb09CcBk8
         GMZkt5UrF33ZuVGRudyiRbeMGkcpexWQ9swwBPmyTxHztVUpDhCzHzyc58iyZKOX7X0/
         Exh//km6Jj9yZbfmxrElc3PQJKrqcPDq29fGMVdwdigaGRIiv30NI+WXOK++AWXI95eO
         bQfjz2ZK+Sw+H/irQu3pgeqNLc6SC00EK07i1L4ZZ14P3CR00Ly+tWYwVkaRtRtHxp6I
         sT+w==
X-Gm-Message-State: AOAM531xAmvG6HrmNLsXHDRlGdqi3u1YYoS4RJKG5zAtzG/9wLOHnJdD
        7ttoZxjDc14ZI7CPQsfXCclMJggbNbWe
X-Google-Smtp-Source: ABdhPJxT1HOzhSPxG+dba5yvPloQAdBq1wQTi12sBnJhG2cGE7eQtv3+Xj8VRwJUw0MSSIDPJ7hpb3lFFy0I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ffd6:b7f5:87ee:7be2])
 (user=irogers job=sendgmr) by 2002:a05:6214:12c6:: with SMTP id
 s6mr22087093qvv.19.1624312612642; Mon, 21 Jun 2021 14:56:52 -0700 (PDT)
Date:   Mon, 21 Jun 2021 14:56:46 -0700
Message-Id: <20210621215648.2991319-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v2 1/3] perf test: Pass the verbose option to shell tests
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Having a verbose option will allow shell tests to provide extra failure
details when the fail or skip.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index cbbfe48ab802..e1ed60567b2f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -577,10 +577,13 @@ struct shell_test {
 static int shell_test__run(struct test *test, int subdir __maybe_unused)
 {
 	int err;
-	char script[PATH_MAX];
+	char script[PATH_MAX + 3];
 	struct shell_test *st = test->priv;
 
-	path__join(script, sizeof(script), st->dir, st->file);
+	path__join(script, sizeof(script) - 3, st->dir, st->file);
+
+	if (verbose)
+		strncat(script, " -v", sizeof(script) - strlen(script) - 1);
 
 	err = system(script);
 	if (!err)
-- 
2.32.0.288.g62a8d224e6-goog

