Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BE73ABBF9
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhFQSok (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 14:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbhFQSoj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 14:44:39 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80FCC061760
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 11:42:31 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id eb2-20020ad44e420000b029025a58adfc6bso1866754qvb.9
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PFZQwytkaiwWlIlKohYqf6fjHhndSooLEMwUFHht7ds=;
        b=iyJ1e2QDwkO2dM31gs2gGxDqbXMTnBTPHawrQ46ZYkK1iL09n0hHmRo50WUvVWMF1o
         j4i74zlkPXYgC9ZQTxakKY2nVhpaODFg8TpjOWOjtPqCOSjpleV/gByQbmj98wgYlYsO
         yWmn4LHLY1bbJw87u3Y4/6hUVR4xVy8fkz8WCUCHuASES/yhxsr8BMhA0szo/Xs9XKX+
         vGHQTsCVj812n/TeIQeuWwu6R9kwVQ3IhDNEhmh2BIDjD7NbVboT9QT1adqLGA1y9njG
         E1SeuhymSiP6QdRYN7r8f4l9i6lTW/sGCCX2kV26XDTKmfDO3coo19/4fKOaodfvO02T
         ckzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PFZQwytkaiwWlIlKohYqf6fjHhndSooLEMwUFHht7ds=;
        b=NP1qfOaS9fsEoBmRihCXwtufF/8W/MXpwBKEfTO29ZHpSJXDJWvV4XmavvkLFInexo
         6czJFXSpPyr2buOtkk6lKb1udAGXUdmzCDGSdd1OYg1E5XhOINrk//BNC07FTahb6teb
         uuro7elKEd7UboBwfjG3AxO7yEmfGAXzJsHhlwqr9NS9yc1Lbh//Aghl8HQRYrjo5NQG
         kXak4WxA2TAuNxnqGSG18o1qnrzDBQO/k7hXQCENOksVCnQhbTgTCCVyflunVHqWUMyu
         TsyBzyw61fPZXcVssIr2hZHbWtK3PaD+ku2ExKMJ7aA1+tYARv8mpqF0Uusp39Zs1dsa
         ZzKQ==
X-Gm-Message-State: AOAM533uJeKrkiFGfHjGfQpIDWSvlqMn6iqan4c74o0yKBhtQgiwHMw1
        oh45rtMdP/Lv2eUF9TSTeFYpGBdw8FRP
X-Google-Smtp-Source: ABdhPJxCHi9VcrdwhllY0LhoGwLekF7I6iEiE23gPOhHNruIdT2wgVP0bd5Vr4d54ca3YYS+iZblTXZdWg4a
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ef90:beff:e92f:7ce0])
 (user=irogers job=sendgmr) by 2002:a25:c243:: with SMTP id
 s64mr8032005ybf.171.1623955350902; Thu, 17 Jun 2021 11:42:30 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:42:14 -0700
In-Reply-To: <20210617184216.2075588-1-irogers@google.com>
Message-Id: <20210617184216.2075588-2-irogers@google.com>
Mime-Version: 1.0
References: <20210617184216.2075588-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 2/4] perf test: Pass the verbose option to shell tests
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
 tools/perf/tests/builtin-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index cbbfe48ab802..a8160b1684de 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -577,11 +577,14 @@ struct shell_test {
 static int shell_test__run(struct test *test, int subdir __maybe_unused)
 {
 	int err;
-	char script[PATH_MAX];
+	char script[PATH_MAX + 3];
 	struct shell_test *st = test->priv;
 
 	path__join(script, sizeof(script), st->dir, st->file);
 
+	if (verbose)
+		strncat(script, " -v", sizeof(script));
+
 	err = system(script);
 	if (!err)
 		return TEST_OK;
-- 
2.32.0.288.g62a8d224e6-goog

