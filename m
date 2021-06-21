Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635633AF823
	for <lists+bpf@lfdr.de>; Mon, 21 Jun 2021 23:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhFUV7N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Jun 2021 17:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhFUV7M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Jun 2021 17:59:12 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D9C061756
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 14:56:56 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id t131-20020a37aa890000b02903a9f6c1e8bfso15561574qke.10
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o7AiO7cf+g5j73bnIKC5PyTIHqUoKVu2uLnXWRb97sM=;
        b=ZArou9EpOMHKZdF4JziC2HUFizemZfHZxYohE3H/4NjcwmlquDQ2fdyZIrSB4+jrGa
         qKjnVY3MV7YctoL7xZq2jvEu2DE8x03uMjUTGvi63UUsOqaULaUISvn/ymiX17zzp1iX
         XYw12fKEsRvWK1PQmAa1IbLPJ6XP6a8/qfVSvp3poP9JHGMV+LAR+ou5QzseEkjnAG/R
         qWhObxJnFu16ryTZ0BP7ZKBAO9Qd4bBcKHX4Mqf8nJq70mUuiC4WTpb6qRbdUYj/4lZ3
         pcLQdqdBhNMd57MwVAA5807sijCAQ9PHJaAussOPguyfoICmC6VLJ3dTFDS4qE/2Gqwd
         cBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o7AiO7cf+g5j73bnIKC5PyTIHqUoKVu2uLnXWRb97sM=;
        b=g7DWSuxtWFwDaQjaz/bolGx6LilnT0lcILWA293E/aMMTKsIZe81KvGyOva2xFwhgr
         kr9h0XQgDmf6FjAUc0q39Fk4lRwF2hsVyr6rwSbzA62bdiAeo/9h0hjSb0hc1t9XrSrY
         yR8iqo1cOmCQ2qySK+e2beOtCTbDacC3jQl9cC4T0yKsIBcoDYy8tXLfO1+RJppAp98n
         16VwLXR4wah+NbqvNoc6JajA5x8rofxAF1Cp+9m4X5B7JCqDWJKvRtZ5Z1J7f1gCM40A
         Y5+80i498uFSnAo3YWRLwD+AH5edcKnjL8+Sah1jVspdSaEowGDgjwSiI5yIZbjw/tRU
         ItFw==
X-Gm-Message-State: AOAM532wDzQJo6u4XZTQGRE/kwr9kNb67cTsX25RatX3sdJHM3saznpd
        u2RTY/9lDohKsVJtrMqALO//MQq6djfz
X-Google-Smtp-Source: ABdhPJyGBlSlo07F4G7w4AxwWPsxT8RK5eHECX8mtkRUDvlMQ9S86+4p8nnfQnKE92k781Q430veQF9794kH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ffd6:b7f5:87ee:7be2])
 (user=irogers job=sendgmr) by 2002:a25:cac4:: with SMTP id
 a187mr112611ybg.423.1624312615504; Mon, 21 Jun 2021 14:56:55 -0700 (PDT)
Date:   Mon, 21 Jun 2021 14:56:47 -0700
In-Reply-To: <20210621215648.2991319-1-irogers@google.com>
Message-Id: <20210621215648.2991319-2-irogers@google.com>
Mime-Version: 1.0
References: <20210621215648.2991319-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v2 2/3] perf test: Add verbose skip output for bpf counters
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

Provide additional context for when the stat bpf counters test skips.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 22eb31e48ca7..85eb689fe202 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -22,7 +22,13 @@ compare_number()
 }
 
 # skip if --bpf-counters is not supported
-perf stat --bpf-counters true > /dev/null 2>&1 || exit 2
+if ! perf stat --bpf-counters true > /dev/null 2>&1; then
+	if [ "$1" == "-v" ]; then
+		echo "Skipping: --bpf-counters not supported"
+		perf --no-pager stat --bpf-counters true || true
+	fi
+	exit 2
+fi
 
 base_cycles=$(perf stat --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
 bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- perf bench sched messaging -g 1 -l 100 -t 2>&1 | awk '/cycles/ {print $1}')
-- 
2.32.0.288.g62a8d224e6-goog

