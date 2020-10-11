Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D342228A832
	for <lists+bpf@lfdr.de>; Sun, 11 Oct 2020 18:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgJKPs6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Oct 2020 11:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbgJKPsI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Oct 2020 11:48:08 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD11C0613CE;
        Sun, 11 Oct 2020 08:48:07 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d20so15158541iop.10;
        Sun, 11 Oct 2020 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CqHR3iMjvi/+BrsGXxXP4f66oyzEMJKnPL1FtLSH8L8=;
        b=FXc0WLhjeHfK9C8wWpomg6X0AAghKxyk/f9EBD39vsaQL+JKeAEOiaBr3h9ezgAe87
         HaB75HWBrBHEOGKaXLU/dKt1+Se1vfQbfFfkAnGTS4XtupW7exDeYf4MAncmqOMcq7vl
         +Qu2alQYmkwjS0+O7dB9UBaRlxNcwKCfXTDcUqVSGKC6z4HspmIbS4IbQCtwwfc6vGHF
         lRZHpaTt9epjMenR8QpcQ3Nsy0tOzwzXXWnaHrS7+TRyc6nM7RloV1/vdMiD3SJosNj8
         wtZ8DdUoxgApvT/nu86sGuqRiTDVqwN8ZQExat+/0OIcyp/uQ5T+Ln6Eg7Tozz9niaNx
         g5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CqHR3iMjvi/+BrsGXxXP4f66oyzEMJKnPL1FtLSH8L8=;
        b=MZyYzLXG6oL7Rd5eyVE2EpnNpF7i5wO0JcOtx0upRfR8e50xjaS2o5ybaJ45yykaya
         Ileq+q861heZ72EQeWCwinYN4wCcM9knzsdvNJ32vMnH9Prlt9Sf6lVN4/K0v2sAMpzi
         rndb9pamL8HZOhkOq/zFxfKa27DteLY3ljR2G6z5RklC9h2fjcB+8+tcT8reEcuag3uy
         Fq1XWbIeDjVIPSalVEruxyI/3l3v+0eFLnyCq1PqJ6+HFYj0VID1vOcIMF7GZxGMNpa8
         SSF5FmM0o9tqyTalGqO8UfFbMoF9pyYT7emvF5i1HG7WH/Y9eXpk4HhJS8IiiVWlDlBe
         v3jw==
X-Gm-Message-State: AOAM532cxkX8kAgsOA8UxEV5/6weWvIv6iIruD644KM1r1RR/ctLaGQz
        B5AqxICZjlobfZ8AHP8ySew=
X-Google-Smtp-Source: ABdhPJzcS4g+GlCNtvm4i/61B2qI1ru9NONLXqq8xwCqDctFJJc0r+6V5ncPXhTQU5vP8f9xlEzEPg==
X-Received: by 2002:a05:6638:a90:: with SMTP id 16mr6821761jas.91.1602431287115;
        Sun, 11 Oct 2020 08:48:07 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id q16sm7502881ilj.71.2020.10.11.08.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 08:48:06 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH v5 seccomp 4/5] selftests/seccomp: Compare bitmap vs filter overhead
Date:   Sun, 11 Oct 2020 10:47:45 -0500
Message-Id: <1b61df3db85c5f7f1b9202722c45e7b39df73ef2.1602431034.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602431034.git.yifeifz2@illinois.edu>
References: <cover.1602431034.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

As part of the seccomp benchmarking, include the expectations with
regard to the timing behavior of the constant action bitmaps, and report
inconsistencies better.

Example output with constant action bitmaps on x86:

$ sudo ./seccomp_benchmark 100000000
Current BPF sysctl settings:
net.core.bpf_jit_enable = 1
net.core.bpf_jit_harden = 0
Benchmarking 200000000 syscalls...
129.359381409 - 0.008724424 = 129350656985 (129.4s)
getpid native: 646 ns
264.385890006 - 129.360453229 = 135025436777 (135.0s)
getpid RET_ALLOW 1 filter (bitmap): 675 ns
399.400511893 - 264.387045901 = 135013465992 (135.0s)
getpid RET_ALLOW 2 filters (bitmap): 675 ns
545.872866260 - 399.401718327 = 146471147933 (146.5s)
getpid RET_ALLOW 3 filters (full): 732 ns
696.337101319 - 545.874097681 = 150463003638 (150.5s)
getpid RET_ALLOW 4 filters (full): 752 ns
Estimated total seccomp overhead for 1 bitmapped filter: 29 ns
Estimated total seccomp overhead for 2 bitmapped filters: 29 ns
Estimated total seccomp overhead for 3 full filters: 86 ns
Estimated total seccomp overhead for 4 full filters: 106 ns
Estimated seccomp entry overhead: 29 ns
Estimated seccomp per-filter overhead (last 2 diff): 20 ns
Estimated seccomp per-filter overhead (filters / 4): 19 ns
Expectations:
	native ≤ 1 bitmap (646 ≤ 675): ✔️
	native ≤ 1 filter (646 ≤ 732): ✔️
	per-filter (last 2 diff) ≈ per-filter (filters / 4) (20 ≈ 19): ✔️
	1 bitmapped ≈ 2 bitmapped (29 ≈ 29): ✔️
	entry ≈ 1 bitmapped (29 ≈ 29): ✔️
	entry ≈ 2 bitmapped (29 ≈ 29): ✔️
	native + entry + (per filter * 4) ≈ 4 filters total (755 ≈ 752): ✔️

Signed-off-by: Kees Cook <keescook@chromium.org>
[YiFei: Changed commit message to show stats for this patch series]
Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 .../selftests/seccomp/seccomp_benchmark.c     | 151 +++++++++++++++---
 tools/testing/selftests/seccomp/settings      |   2 +-
 2 files changed, 130 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index 91f5a89cadac..fcc806585266 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -4,12 +4,16 @@
  */
 #define _GNU_SOURCE
 #include <assert.h>
+#include <limits.h>
+#include <stdbool.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
 #include <unistd.h>
 #include <linux/filter.h>
 #include <linux/seccomp.h>
+#include <sys/param.h>
 #include <sys/prctl.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -70,18 +74,74 @@ unsigned long long calibrate(void)
 	return samples * seconds;
 }
 
+bool approx(int i_one, int i_two)
+{
+	double one = i_one, one_bump = one * 0.01;
+	double two = i_two, two_bump = two * 0.01;
+
+	one_bump = one + MAX(one_bump, 2.0);
+	two_bump = two + MAX(two_bump, 2.0);
+
+	/* Equal to, or within 1% or 2 digits */
+	if (one == two ||
+	    (one > two && one <= two_bump) ||
+	    (two > one && two <= one_bump))
+		return true;
+	return false;
+}
+
+bool le(int i_one, int i_two)
+{
+	if (i_one <= i_two)
+		return true;
+	return false;
+}
+
+long compare(const char *name_one, const char *name_eval, const char *name_two,
+	     unsigned long long one, bool (*eval)(int, int), unsigned long long two)
+{
+	bool good;
+
+	printf("\t%s %s %s (%lld %s %lld): ", name_one, name_eval, name_two,
+	       (long long)one, name_eval, (long long)two);
+	if (one > INT_MAX) {
+		printf("Miscalculation! Measurement went negative: %lld\n", (long long)one);
+		return 1;
+	}
+	if (two > INT_MAX) {
+		printf("Miscalculation! Measurement went negative: %lld\n", (long long)two);
+		return 1;
+	}
+
+	good = eval(one, two);
+	printf("%s\n", good ? "✔️" : "❌");
+
+	return good ? 0 : 1;
+}
+
 int main(int argc, char *argv[])
 {
+	struct sock_filter bitmap_filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS, offsetof(struct seccomp_data, nr)),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog bitmap_prog = {
+		.len = (unsigned short)ARRAY_SIZE(bitmap_filter),
+		.filter = bitmap_filter,
+	};
 	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS, offsetof(struct seccomp_data, args[0])),
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
 	};
 	struct sock_fprog prog = {
 		.len = (unsigned short)ARRAY_SIZE(filter),
 		.filter = filter,
 	};
-	long ret;
-	unsigned long long samples;
-	unsigned long long native, filter1, filter2;
+
+	long ret, bits;
+	unsigned long long samples, calc;
+	unsigned long long native, filter1, filter2, bitmap1, bitmap2;
+	unsigned long long entry, per_filter1, per_filter2;
 
 	printf("Current BPF sysctl settings:\n");
 	system("sysctl net.core.bpf_jit_enable");
@@ -101,35 +161,82 @@ int main(int argc, char *argv[])
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	assert(ret == 0);
 
-	/* One filter */
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog);
+	/* One filter resulting in a bitmap */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bitmap_prog);
 	assert(ret == 0);
 
-	filter1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
-	printf("getpid RET_ALLOW 1 filter: %llu ns\n", filter1);
+	bitmap1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
+	printf("getpid RET_ALLOW 1 filter (bitmap): %llu ns\n", bitmap1);
+
+	/* Second filter resulting in a bitmap */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bitmap_prog);
+	assert(ret == 0);
 
-	if (filter1 == native)
-		printf("No overhead measured!? Try running again with more samples.\n");
+	bitmap2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
+	printf("getpid RET_ALLOW 2 filters (bitmap): %llu ns\n", bitmap2);
 
-	/* Two filters */
+	/* Third filter, can no longer be converted to bitmap */
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog);
 	assert(ret == 0);
 
-	filter2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
-	printf("getpid RET_ALLOW 2 filters: %llu ns\n", filter2);
-
-	/* Calculations */
-	printf("Estimated total seccomp overhead for 1 filter: %llu ns\n",
-		filter1 - native);
+	filter1 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
+	printf("getpid RET_ALLOW 3 filters (full): %llu ns\n", filter1);
 
-	printf("Estimated total seccomp overhead for 2 filters: %llu ns\n",
-		filter2 - native);
+	/* Fourth filter, can not be converted to bitmap because of filter 3 */
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &bitmap_prog);
+	assert(ret == 0);
 
-	printf("Estimated seccomp per-filter overhead: %llu ns\n",
-		filter2 - filter1);
+	filter2 = timing(CLOCK_PROCESS_CPUTIME_ID, samples) / samples;
+	printf("getpid RET_ALLOW 4 filters (full): %llu ns\n", filter2);
+
+	/* Estimations */
+#define ESTIMATE(fmt, var, what)	do {			\
+		var = (what);					\
+		printf("Estimated " fmt ": %llu ns\n", var);	\
+		if (var > INT_MAX)				\
+			goto more_samples;			\
+	} while (0)
+
+	ESTIMATE("total seccomp overhead for 1 bitmapped filter", calc,
+		 bitmap1 - native);
+	ESTIMATE("total seccomp overhead for 2 bitmapped filters", calc,
+		 bitmap2 - native);
+	ESTIMATE("total seccomp overhead for 3 full filters", calc,
+		 filter1 - native);
+	ESTIMATE("total seccomp overhead for 4 full filters", calc,
+		 filter2 - native);
+	ESTIMATE("seccomp entry overhead", entry,
+		 bitmap1 - native - (bitmap2 - bitmap1));
+	ESTIMATE("seccomp per-filter overhead (last 2 diff)", per_filter1,
+		 filter2 - filter1);
+	ESTIMATE("seccomp per-filter overhead (filters / 4)", per_filter2,
+		 (filter2 - native - entry) / 4);
+
+	printf("Expectations:\n");
+	ret |= compare("native", "≤", "1 bitmap", native, le, bitmap1);
+	bits = compare("native", "≤", "1 filter", native, le, filter1);
+	if (bits)
+		goto more_samples;
+
+	ret |= compare("per-filter (last 2 diff)", "≈", "per-filter (filters / 4)",
+			per_filter1, approx, per_filter2);
+
+	bits = compare("1 bitmapped", "≈", "2 bitmapped",
+			bitmap1 - native, approx, bitmap2 - native);
+	if (bits) {
+		printf("Skipping constant action bitmap expectations: they appear unsupported.\n");
+		goto out;
+	}
 
-	printf("Estimated seccomp entry overhead: %llu ns\n",
-		filter1 - native - (filter2 - filter1));
+	ret |= compare("entry", "≈", "1 bitmapped", entry, approx, bitmap1 - native);
+	ret |= compare("entry", "≈", "2 bitmapped", entry, approx, bitmap2 - native);
+	ret |= compare("native + entry + (per filter * 4)", "≈", "4 filters total",
+			entry + (per_filter1 * 4) + native, approx, filter2);
+	if (ret == 0)
+		goto out;
 
+more_samples:
+	printf("Saw unexpected benchmark result. Try running again with more samples?\n");
+out:
 	return 0;
 }
diff --git a/tools/testing/selftests/seccomp/settings b/tools/testing/selftests/seccomp/settings
index ba4d85f74cd6..6091b45d226b 100644
--- a/tools/testing/selftests/seccomp/settings
+++ b/tools/testing/selftests/seccomp/settings
@@ -1 +1 @@
-timeout=90
+timeout=120
-- 
2.28.0

