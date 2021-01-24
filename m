Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5B301E8A
	for <lists+bpf@lfdr.de>; Sun, 24 Jan 2021 20:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbhAXTvc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jan 2021 14:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbhAXTvb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jan 2021 14:51:31 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9509EC0613D6
        for <bpf@vger.kernel.org>; Sun, 24 Jan 2021 11:50:51 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id s6so5283098qvn.6
        for <bpf@vger.kernel.org>; Sun, 24 Jan 2021 11:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5H4F1gmoipwG83urJ0GufOSLL/z094qoUDfMitivKk=;
        b=a7BCdxgeJJ0FITpuBTIh8kj1ss+dazz9z/GJKhWpXRIul8GD+VmA2cR0iYiW0/bfHe
         DNTpqK6FqmBQdNA2ZKbr4m8d/jJlR0ERXidAiGuBKcd5A425kPJ3MHRi8CXI5ij15H1c
         B/4Ccfc+rHF77cqKchpCDK6M8ty+NDKhIRtbLJS1VU8BmHxWKpGz26dBXzZ9SHjumz1H
         okdrjv766jNaFnyOtCBXjt4OXy4Ids0uvlOrS6XaQrUXPylYLUrgNKcmV0M89dInMxsI
         Cvd136QCw8HQn6v06NR83vGoohXGS3hv3OUptn5dyNYL/d4IgIO36djR1JTLusc3dV53
         QYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5H4F1gmoipwG83urJ0GufOSLL/z094qoUDfMitivKk=;
        b=W1mwG2tnDvze4ZDbgW6ffC3ozmRZ1/C/U4KbJ5RdepExhTRUvMImt220MV7wJ9+FFV
         MO2KClXcDDPPtfdgjnGH0beyh3mDWs71YifPqo1isL9SDhyopJXbv1Q44sjzScmOOXOy
         dXYRoSSj9EN4FFaLywrLkcAt5EwrpaO7v03Der8JpPEjUlygi+RWkQYIrKvdkk0s1suK
         s7EbojsnzPX5eKYJ0WEndXXHzZZaswrKvHKI9wNLJ+qOHsWFQtKx69fRRmf9DwvawPMQ
         6VHyYYvvqWBwuPTsU7Qk2ckGBzT5XRRthW8jO98MudO8YCjISEb4euYR7ObNWjtwQwoE
         6Uyw==
X-Gm-Message-State: AOAM533aB+6yGwBnzglVE2QXy78RmXXqgbAO6m+FaMMsDpNEWIbeQ+O1
        PU91BO7hKeSzo7Sm+QaZlVpLM2GfWr5VsA==
X-Google-Smtp-Source: ABdhPJxrFroiyq8KRA1SRJiQl3EZ/fAoEXQ6qvTvl0uFIEG87DB4a594uE5+ari88Gv+nIb0L0hNvw==
X-Received: by 2002:a0c:fdec:: with SMTP id m12mr13517303qvu.11.1611517850497;
        Sun, 24 Jan 2021 11:50:50 -0800 (PST)
Received: from localhost (pool-96-239-57-246.nycmny.fios.verizon.net. [96.239.57.246])
        by smtp.gmail.com with ESMTPSA id p128sm10501196qkb.101.2021.01.24.11.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 11:50:50 -0800 (PST)
From:   Andrei Matei <andreimatei1@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v2 4/5] selftest/bpf: move utility function to tests header
Date:   Sun, 24 Jan 2021 14:49:08 -0500
Message-Id: <20210124194909.453844-5-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210124194909.453844-1-andreimatei1@gmail.com>
References: <20210124194909.453844-1-andreimatei1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

get_base_addr is generally useful for tests attaching uprobes. This
patch moves it from one particular test to test_progs.{h,c}. The
function will be used by a second test in the next patch.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 21 ----------------
 tools/testing/selftests/bpf/test_progs.c      | 25 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  1 +
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index a0ee87c8e1ea..3bda8acbbafb 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -2,27 +2,6 @@
 #include <test_progs.h>
 #include "test_attach_probe.skel.h"
 
-ssize_t get_base_addr() {
-	size_t start, offset;
-	char buf[256];
-	FILE *f;
-
-	f = fopen("/proc/self/maps", "r");
-	if (!f)
-		return -errno;
-
-	while (fscanf(f, "%zx-%*x %s %zx %*[^\n]\n",
-		      &start, buf, &offset) == 3) {
-		if (strcmp(buf, "r-xp") == 0) {
-			fclose(f);
-			return start - offset;
-		}
-	}
-
-	fclose(f);
-	return -EINVAL;
-}
-
 void test_attach_probe(void)
 {
 	int duration = 0;
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 213628ee721c..6d3354ae4034 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -423,6 +423,31 @@ static int load_bpf_testmod(void)
 	return 0;
 }
 
+/* find the address at which the executable section of the current program has
+ * been loaded.
+ */
+ssize_t get_base_addr(void)
+{
+	size_t start, offset;
+	char buf[256];
+	FILE *f;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		return -errno;
+
+	while (fscanf(f, "%zx-%*x %s %zx %*[^\n]\n",
+		      &start, buf, &offset) == 3) {
+		if (strcmp(buf, "r-xp") == 0) {
+			fclose(f);
+			return start - offset;
+		}
+	}
+
+	fclose(f);
+	return -EINVAL;
+}
+
 /* extern declarations for test funcs */
 #define DEFINE_TEST(name) extern void test_##name(void);
 #include <prog_tests/tests.h>
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index f7c2fd89d01a..7a1eafd7ae77 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -219,6 +219,7 @@ int compare_map_keys(int map1_fd, int map2_fd);
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
 int extract_build_id(char *build_id, size_t size);
 int kern_sync_rcu(void);
+ssize_t get_base_addr(void);
 
 #ifdef __x86_64__
 #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
-- 
2.27.0

