Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C36B38021D
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2019 23:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404878AbfHBVLT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Aug 2019 17:11:19 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36575 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731216AbfHBVLR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Aug 2019 17:11:17 -0400
Received: by mail-pg1-f202.google.com with SMTP id 8so42871055pgl.3
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2019 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zmKiJD0uvKVR9RO89XkV5HgjXrEgjVbaxP8rKxrpyGQ=;
        b=lOXUtYAwzEuHmi4/HZIi+BwUlk6FCMKjUrt3nDoJcImYhouYgnX93/Zwl7QVZd3rP6
         AZZPaWCKxy6Kd3kddsb9cVJHkijs1ciq9n9a+lZIxQWqR97n3Ggc15H+brwaowR4Q/C5
         1AP0iVn2llXWelsK88957ayRS9/PNhML2ALj8W4R/tozLSM+YdiM5vU3bXCeACBVxT0t
         sPjE9Une/g7BS7wS/Jol+fy/mSEEDnQySbU7fo8frf2HX1gMfDXBO1suLsXO5tOySnxu
         rJ5RScuk/HG9I7bOZrxhhq8MW5fZDckYPBYVPVj2UR9uK6Rx5sa1BwphJgKhbC69unZ/
         L8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zmKiJD0uvKVR9RO89XkV5HgjXrEgjVbaxP8rKxrpyGQ=;
        b=SNp1DOM1iaFoN8a6I+5sLs5/H4FLn2u2vEG/7ofZAEjoUhkYC/Ld9cLeyX0PfywJ7O
         TVnll5qz7WPbvv/wfPl8s+WzEpTBbEQAPUVttpcSbMMM71ZofujirNuNqhdrVsVEvs8E
         0OzQnQtlWIhhCGjsAv/T1NtlzqSXHROvIKoqpYnfxOa1U6A5UcbhMxkACinKq7n4gjHH
         0z2rGUdQxPcG6MWZmYgFLUjSz3x8+TaDe+ltq4REri+iz5DcgPBTm8IYEZDTtn7gv/bn
         +3nKvLEPpiCUtQANqnXe5UcJPIwAUkkeVYR05BAi2cWvR+IAG4AWFsZXAo+skgB5nA2m
         eD6Q==
X-Gm-Message-State: APjAAAVFHjsR7In9WAKuNzPCWqhYa5qFVU+iJ16hkhjW1q6HZsyfiZkb
        4Q5HRuwKI4ziOMsCeCdF0uUSBOw=
X-Google-Smtp-Source: APXvYqxDdJDQIyEG9dugRobHpl4LXwmv+c4PQB8jC5A68pcdW7iSPwHz0rw6IDe1PSpGt5BAEfosSI8=
X-Received: by 2002:a65:5348:: with SMTP id w8mr124955660pgr.176.1564780276299;
 Fri, 02 Aug 2019 14:11:16 -0700 (PDT)
Date:   Fri,  2 Aug 2019 14:11:07 -0700
In-Reply-To: <20190802211108.90739-1-sdf@google.com>
Message-Id: <20190802211108.90739-3-sdf@google.com>
Mime-Version: 1.0
References: <20190802211108.90739-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: test_progs: test__printf -> printf
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that test__printf is a simple wraper around printf, let's drop it
(and test__vprintf as well).

Cc: Andrii Nakryiko <andriin@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/bpf_verif_scale.c   |  4 ++--
 .../testing/selftests/bpf/prog_tests/l4lb_all.c  |  2 +-
 .../testing/selftests/bpf/prog_tests/map_lock.c  | 10 +++++-----
 .../selftests/bpf/prog_tests/send_signal.c       |  4 ++--
 .../testing/selftests/bpf/prog_tests/spinlock.c  |  2 +-
 .../bpf/prog_tests/stacktrace_build_id.c         |  4 ++--
 .../bpf/prog_tests/stacktrace_build_id_nmi.c     |  4 ++--
 .../selftests/bpf/prog_tests/xdp_noinline.c      |  4 ++--
 tools/testing/selftests/bpf/test_progs.c         | 16 +---------------
 tools/testing/selftests/bpf/test_progs.h         | 10 ++++------
 10 files changed, 22 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index b4be96162ff4..3548ba2f24a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -5,13 +5,13 @@ static int libbpf_debug_print(enum libbpf_print_level level,
 			      const char *format, va_list args)
 {
 	if (level != LIBBPF_DEBUG) {
-		test__vprintf(format, args);
+		vprintf(format, args);
 		return 0;
 	}
 
 	if (!strstr(format, "verifier log"))
 		return 0;
-	test__vprintf("%s", args);
+	vprintf("%s", args);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/l4lb_all.c b/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
index 5ce572c03a5f..20ddca830e68 100644
--- a/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
+++ b/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
@@ -74,7 +74,7 @@ static void test_l4lb(const char *file)
 	}
 	if (bytes != MAGIC_BYTES * NUM_ITER * 2 || pkts != NUM_ITER * 2) {
 		error_cnt++;
-		test__printf("test_l4lb:FAIL:stats %lld %lld\n", bytes, pkts);
+		printf("test_l4lb:FAIL:stats %lld %lld\n", bytes, pkts);
 	}
 out:
 	bpf_object__close(obj);
diff --git a/tools/testing/selftests/bpf/prog_tests/map_lock.c b/tools/testing/selftests/bpf/prog_tests/map_lock.c
index 2e78217ed3fd..ee99368c595c 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_lock.c
@@ -9,12 +9,12 @@ static void *parallel_map_access(void *arg)
 	for (i = 0; i < 10000; i++) {
 		err = bpf_map_lookup_elem_flags(map_fd, &key, vars, BPF_F_LOCK);
 		if (err) {
-			test__printf("lookup failed\n");
+			printf("lookup failed\n");
 			error_cnt++;
 			goto out;
 		}
 		if (vars[0] != 0) {
-			test__printf("lookup #%d var[0]=%d\n", i, vars[0]);
+			printf("lookup #%d var[0]=%d\n", i, vars[0]);
 			error_cnt++;
 			goto out;
 		}
@@ -22,8 +22,8 @@ static void *parallel_map_access(void *arg)
 		for (j = 2; j < 17; j++) {
 			if (vars[j] == rnd)
 				continue;
-			test__printf("lookup #%d var[1]=%d var[%d]=%d\n",
-				     i, rnd, j, vars[j]);
+			printf("lookup #%d var[1]=%d var[%d]=%d\n",
+			       i, rnd, j, vars[j]);
 			error_cnt++;
 			goto out;
 		}
@@ -43,7 +43,7 @@ void test_map_lock(void)
 
 	err = bpf_prog_load(file, BPF_PROG_TYPE_CGROUP_SKB, &obj, &prog_fd);
 	if (err) {
-		test__printf("test_map_lock:bpf_prog_load errno %d\n", errno);
+		printf("test_map_lock:bpf_prog_load errno %d\n", errno);
 		goto close_prog;
 	}
 	map_fd[0] = bpf_find_map(__func__, obj, "hash_map");
diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 461b423d0584..1575f0a1f586 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -202,8 +202,8 @@ static int test_send_signal_nmi(void)
 			 -1 /* cpu */, -1 /* group_fd */, 0 /* flags */);
 	if (pmu_fd == -1) {
 		if (errno == ENOENT) {
-			test__printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n",
-				     __func__);
+			printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n",
+			       __func__);
 			return 0;
 		}
 		/* Let the test fail with a more informative message */
diff --git a/tools/testing/selftests/bpf/prog_tests/spinlock.c b/tools/testing/selftests/bpf/prog_tests/spinlock.c
index deb2db5b85b0..114ebe6a438e 100644
--- a/tools/testing/selftests/bpf/prog_tests/spinlock.c
+++ b/tools/testing/selftests/bpf/prog_tests/spinlock.c
@@ -12,7 +12,7 @@ void test_spinlock(void)
 
 	err = bpf_prog_load(file, BPF_PROG_TYPE_CGROUP_SKB, &obj, &prog_fd);
 	if (err) {
-		test__printf("test_spin_lock:bpf_prog_load errno %d\n", errno);
+		printf("test_spin_lock:bpf_prog_load errno %d\n", errno);
 		goto close_prog;
 	}
 	for (i = 0; i < 4; i++)
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
index 356d2c017a9c..ac44fda84833 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
@@ -109,8 +109,8 @@ void test_stacktrace_build_id(void)
 	if (build_id_matches < 1 && retry--) {
 		bpf_link__destroy(link);
 		bpf_object__close(obj);
-		test__printf("%s:WARN:Didn't find expected build ID from the map, retrying\n",
-			     __func__);
+		printf("%s:WARN:Didn't find expected build ID from the map, retrying\n",
+		       __func__);
 		goto retry;
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
index f44f2c159714..9557b7dfb782 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
@@ -140,8 +140,8 @@ void test_stacktrace_build_id_nmi(void)
 	if (build_id_matches < 1 && retry--) {
 		bpf_link__destroy(link);
 		bpf_object__close(obj);
-		test__printf("%s:WARN:Didn't find expected build ID from the map, retrying\n",
-			     __func__);
+		printf("%s:WARN:Didn't find expected build ID from the map, retrying\n",
+		       __func__);
 		goto retry;
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c b/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
index b5404494b8aa..15f7c272edb0 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
@@ -75,8 +75,8 @@ void test_xdp_noinline(void)
 	}
 	if (bytes != MAGIC_BYTES * NUM_ITER * 2 || pkts != NUM_ITER * 2) {
 		error_cnt++;
-		test__printf("test_xdp_noinline:FAIL:stats %lld %lld\n",
-			     bytes, pkts);
+		printf("test_xdp_noinline:FAIL:stats %lld %lld\n",
+		       bytes, pkts);
 	}
 out:
 	bpf_object__close(obj);
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index eb8743302a00..1827ce5114f4 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -108,20 +108,6 @@ void test__force_log() {
 	env.test->force_log = true;
 }
 
-void test__vprintf(const char *fmt, va_list args)
-{
-	vprintf(fmt, args);
-}
-
-void test__printf(const char *fmt, ...)
-{
-	va_list args;
-
-	va_start(args, fmt);
-	test__vprintf(fmt, args);
-	va_end(args);
-}
-
 struct ipv4_packet pkt_v4 = {
 	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
 	.iph.ihl = 5,
@@ -313,7 +299,7 @@ static int libbpf_print_fn(enum libbpf_print_level level,
 {
 	if (!env.very_verbose && level == LIBBPF_DEBUG)
 		return 0;
-	test__vprintf(format, args);
+	vprintf(format, args);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 54f30d7731c6..1231b30cbbda 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -69,8 +69,6 @@ extern int error_cnt;
 extern int pass_cnt;
 extern struct test_env env;
 
-extern void test__printf(const char *fmt, ...);
-extern void test__vprintf(const char *fmt, va_list args);
 extern void test__force_log();
 extern bool test__start_subtest(const char *name);
 
@@ -96,12 +94,12 @@ extern struct ipv6_packet pkt_v6;
 	int __ret = !!(condition);					\
 	if (__ret) {							\
 		error_cnt++;						\
-		test__printf("%s:FAIL:%s ", __func__, tag);		\
-		test__printf(format);					\
+		printf("%s:FAIL:%s ", __func__, tag);			\
+		printf(format);						\
 	} else {							\
 		pass_cnt++;						\
-		test__printf("%s:PASS:%s %d nsec\n",			\
-			      __func__, tag, duration);			\
+		printf("%s:PASS:%s %d nsec\n",				\
+		       __func__, tag, duration);			\
 	}								\
 	__ret;								\
 })
-- 
2.22.0.770.g0f2c4a37fd-goog

