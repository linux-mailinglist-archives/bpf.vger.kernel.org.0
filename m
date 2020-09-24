Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F207C2771A2
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 14:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgIXMoz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 08:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgIXMoq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 08:44:46 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B045C0613CE;
        Thu, 24 Sep 2020 05:44:46 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id l16so2913101ilt.13;
        Thu, 24 Sep 2020 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3aehQo/yRfhFUHB1dumyvMfUbkZ02zfVtfOyrlCUCaI=;
        b=nCGFriv/8sgax0UHt+DUO8aQ986sUT+eqetbLNt9cYwSA3JzUS4hp5nL0wEM4pDTm4
         I0511RNTK5Sw5wnEuoK5FJvNGXPvJJa/zuBMBizsKorOvdwkOkJQwjIsxJaHk5A2Towe
         9ParrxvHFlSz7guxQBiJxr/Wdwy2LpeY2rYO/flxXbmHb6A+6ifwep3PwdkcOpWGEh0J
         z1GyyrJs1y+YYpZ6yqjWcCyR2pK3+OlluaO02FNvAJT1UV1oLUTlKCDbbuNXJPaDAFP+
         Nwsk2E0k2h0NIOY9bC32nx07R5QkFCdpTCJgfH9RgGIn7xqCwTyxfpr69/Xa8Q0Y2YLH
         Rs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3aehQo/yRfhFUHB1dumyvMfUbkZ02zfVtfOyrlCUCaI=;
        b=PAIBhKiWppEo05rqmiVBb1hZI1aD11e7uZUT/f6SqpH44uDHWjOL9ROZ0nahImkzew
         TqH8g9Wf/9YSduv8QuGI/zRXFaUj0WqEMrS+CyOJ/Yhy7ZshUxu1GoKRhtKlcdmMUm/X
         ICYRvO+H+Y/Y3DDJelK8IEnT4bhIhSopvd99ktukChAJQy7QOieLnCI1Dwi2aFbBIEV7
         /j8hHDF+sN10j6oNnYklU10hUVrkJ5/8fgNNCjdgJLoy7f0lBVgIu9KqXG5c+DlmwZ1P
         ULndSL583Q7H2QkAlBIrsNMdAlDzTmnuBC0PJGn+OfV0tXSMBdRxoTgm7zOn1x9prh5C
         BGCQ==
X-Gm-Message-State: AOAM5333JXwMyZ9idRRwmy1BMLUu24c3lDA2BfR0KL8VeHUbm2SfEP3V
        rf/oqR5LqeCtEAEYIn7E20M=
X-Google-Smtp-Source: ABdhPJxtAhUVAW7pPuRTVnNeknSF1GHXhg6olEpVTDJpgnqnoZCs1cVoTvO5gywN4hMQ0Xne4LgiNw==
X-Received: by 2002:a92:1503:: with SMTP id v3mr3782779ilk.56.1600951485405;
        Thu, 24 Sep 2020 05:44:45 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id p5sm1575175ilg.32.2020.09.24.05.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:44:44 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
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
Subject: [PATCH v2 seccomp 5/6] selftests/seccomp: Compare bitmap vs filter overhead
Date:   Thu, 24 Sep 2020 07:44:20 -0500
Message-Id: <eedf3323eed8615a4be150b39a717de1a68f0c12.1600951211.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600951211.git.yifeifz2@illinois.edu>
References: <cover.1600951211.git.yifeifz2@illinois.edu>
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
Benchmarking 100000000 syscalls...
63.896255358 - 0.008504529 = 63887750829 (63.9s)
getpid native: 638 ns
130.383312423 - 63.897315189 = 66485997234 (66.5s)
getpid RET_ALLOW 1 filter (bitmap): 664 ns
196.789080421 - 130.384414983 = 66404665438 (66.4s)
getpid RET_ALLOW 2 filters (bitmap): 664 ns
268.844643304 - 196.790234168 = 72054409136 (72.1s)
getpid RET_ALLOW 3 filters (full): 720 ns
342.627472515 - 268.845799103 = 73781673412 (73.8s)
getpid RET_ALLOW 4 filters (full): 737 ns
Estimated total seccomp overhead for 1 bitmapped filter: 26 ns
Estimated total seccomp overhead for 2 bitmapped filters: 26 ns
Estimated total seccomp overhead for 3 full filters: 82 ns
Estimated total seccomp overhead for 4 full filters: 99 ns
Estimated seccomp entry overhead: 26 ns
Estimated seccomp per-filter overhead (last 2 diff): 17 ns
Estimated seccomp per-filter overhead (filters / 4): 18 ns
Expectations:
	native ≤ 1 bitmap (638 ≤ 664): ✔️
	native ≤ 1 filter (638 ≤ 720): ✔️
	per-filter (last 2 diff) ≈ per-filter (filters / 4) (17 ≈ 18): ✔️
	1 bitmapped ≈ 2 bitmapped (26 ≈ 26): ✔️
	entry ≈ 1 bitmapped (26 ≈ 26): ✔️
	entry ≈ 2 bitmapped (26 ≈ 26): ✔️
	native + entry + (per filter * 4) ≈ 4 filters total (732 ≈ 737): ✔️

Signed-off-by: Kees Cook <keescook@chromium.org>
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

