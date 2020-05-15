Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE6E1D5A5D
	for <lists+bpf@lfdr.de>; Fri, 15 May 2020 21:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgEOTtT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 May 2020 15:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726372AbgEOTtI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 May 2020 15:49:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6834FC05BD0A
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 12:49:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y8so3863777ybn.20
        for <bpf@vger.kernel.org>; Fri, 15 May 2020 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oIsUTANHRmEkQKJU7Z0AimFtTaGt0Uh4fII97KnaoIw=;
        b=TbG7UuFCxqjFz421TwcE6YPv8ieDIN31752XKaXqvLsKGdxbzDpWqF+nAegbA5IVil
         Tjv4dwjYQutNneKYjelvnARgllGn0odF/1UuxcGk7q5wlcaZNX9960FQryFmuux96+uB
         mJEVGTp835pJrtOznOLq1Ghplyy4hRH6cI4DytVL+iBi5Xi8TCkjt/2bqHMsccHt4xa5
         FX6FTsZhlXfnOQ6cq+af5zNb1HMla2nXgf4OHwCG6DLyymHEUJPb6uFsnO8nc98/ibKF
         mvwVh0/7Tf8i/v4GUbOJC/mM4AUtPxBHKiLzqzoiuoqOOppLFxP86KQznP0a7Y1oRsLR
         D0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oIsUTANHRmEkQKJU7Z0AimFtTaGt0Uh4fII97KnaoIw=;
        b=qbQ+9grUbLYjcj6KnTdCEvQrPuZyHSLUaOPCBC3WTAou+kMTQSBxBB3k1Gy0IeMgAP
         c+M+AK/NCXKkBYlAtF/Q3GdE+AKAB8hWkXZVJskACpq8zOTVviAoN0p845DDewsNtHA0
         tZdwjEDoGXzLj3bXcGeDrY/Q6s/S5gzXWMZN84zXslK/prAg2Wgr8jzl8rSNJaTjIwV9
         3v54obwNANndEWHFdOt+UKipgxnojwSQZrDe7Yl33hSrZdeHBOQMHmSD83KHS9h8CzDN
         MEU0vG2F/c+sSx7+armls8N6DOvN2ktzAoF0EqapnexYFHaJTKU3KZF1yCALw69Qcoff
         IrqA==
X-Gm-Message-State: AOAM531pwr7uz/uOyDpoU7sGvmCRi1bKUbbUelNE9c44QRbqA/1WA9Fq
        h5TOUVba13/AIKKn524UA+xBJ5A=
X-Google-Smtp-Source: ABdhPJyMlfg/P/OmhsItCNG1x6HJ3mh7BzURZwscxZ0cLQ58mkV70rd/NCCsUZsUKgKqMy2hn3D5/7s=
X-Received: by 2002:a25:d55:: with SMTP id 82mr8739164ybn.8.1589572147668;
 Fri, 15 May 2020 12:49:07 -0700 (PDT)
Date:   Fri, 15 May 2020 12:49:04 -0700
In-Reply-To: <20200515194904.229296-1-sdf@google.com>
Message-Id: <20200515194904.229296-2-sdf@google.com>
Mime-Version: 1.0
References: <20200515194904.229296-1-sdf@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH bpf-next 2/2] selftests/bpf: move test_align under test_progs
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is a much higher chance we can see the regressions if the
test is part of test_progs.

Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../bpf/{test_align.c => prog_tests/align.c}  | 68 ++-----------------
 1 file changed, 7 insertions(+), 61 deletions(-)
 rename tools/testing/selftests/bpf/{test_align.c => prog_tests/align.c} (94%)

diff --git a/tools/testing/selftests/bpf/test_align.c b/tools/testing/selftests/bpf/prog_tests/align.c
similarity index 94%
rename from tools/testing/selftests/bpf/test_align.c
rename to tools/testing/selftests/bpf/prog_tests/align.c
index c9c9bdce9d6d..c548aded6585 100644
--- a/tools/testing/selftests/bpf/test_align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -1,24 +1,5 @@
-#include <asm/types.h>
-#include <linux/types.h>
-#include <stdint.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <stddef.h>
-#include <stdbool.h>
-
-#include <linux/unistd.h>
-#include <linux/filter.h>
-#include <linux/bpf_perf_event.h>
-#include <linux/bpf.h>
-
-#include <bpf/bpf.h>
-
-#include "../../../include/linux/filter.h"
-#include "bpf_rlimit.h"
-#include "bpf_util.h"
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
 
 #define MAX_INSNS	512
 #define MAX_MATCHES	16
@@ -670,51 +651,16 @@ static int do_test_single(struct bpf_align_test *test)
 	return ret;
 }
 
-static int do_test(unsigned int from, unsigned int to)
+void test_align(void)
 {
-	int all_pass = 0;
-	int all_fail = 0;
 	unsigned int i;
 
-	for (i = from; i < to; i++) {
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		struct bpf_align_test *test = &tests[i];
-		int fail;
-
-		printf("Test %3d: %s ... ",
-		       i, test->descr);
-		fail = do_test_single(test);
-		if (fail) {
-			all_fail++;
-			printf("FAIL\n");
-		} else {
-			all_pass++;
-			printf("PASS\n");
-		}
-	}
-	printf("Results: %d pass %d fail\n",
-	       all_pass, all_fail);
-	return all_fail ? EXIT_FAILURE : EXIT_SUCCESS;
-}
-
-int main(int argc, char **argv)
-{
-	unsigned int from = 0, to = ARRAY_SIZE(tests);
 
-	if (argc == 3) {
-		unsigned int l = atoi(argv[argc - 2]);
-		unsigned int u = atoi(argv[argc - 1]);
+		if (!test__start_subtest(test->descr))
+			continue;
 
-		if (l < to && u < to) {
-			from = l;
-			to   = u + 1;
-		}
-	} else if (argc == 2) {
-		unsigned int t = atoi(argv[argc - 1]);
-
-		if (t < to) {
-			from = t;
-			to   = t + 1;
-		}
+		CHECK_FAIL(do_test_single(test));
 	}
-	return do_test(from, to);
 }
-- 
2.26.2.761.g0e0b3e54be-goog

