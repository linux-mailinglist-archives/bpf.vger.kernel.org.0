Return-Path: <bpf+bounces-36814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A40894DA27
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 04:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B490328214A
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 02:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9381339B1;
	Sat, 10 Aug 2024 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWsf7sJA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8B130AF6
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723257344; cv=none; b=HYwVdDpwlCwZDyvyAjT9fM0JaR4ml/c5vOwLfY/nhy9u9e+AUb3YicYvuhNtma+kaRaya18czjL2pohru41ESy233v8xTYYJR858Et9NsOhN9krhdI21MFQGynqwDvRABVJZ4LACczgBgsM3k1dfUEvoz+j1nI/4C3uZGwro4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723257344; c=relaxed/simple;
	bh=GXbqK0OlN1Iq1S+paGUYYCRl7dExHhLJdWwYwlJixWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AA3GyQV6Z6YqmZ/RQoZ2BYVoEeAZWXtoRYgl/wgwbn+MmKMSb91Bn72EvA6gdA8crohpgcF4Ozi+7RuJnpNCC41LbjQwVmZe1298b4fOlzIcCxqd95OwcpihOANowdXnDz+NIDlOUqc+8tvPg3VlWAfqWtMFEwoO6kYhYRQ4dH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWsf7sJA; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-685cc5415e8so26454217b3.3
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 19:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723257342; x=1723862142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmAToJhlOXgTBoR3AeOW+sPvFitGle+hEJ/YMCiyrqM=;
        b=VWsf7sJAculGegIp9XIfVMLq404R5MnmgiI5GNUOpCvy+7nqh2JystROSuVSqz6Zzq
         +YQa1nYezZcl7cs10fx2ngVnlQQurQojLF/H2KcxTAAvWeLyia+lIsnPL1Dq5eu0IKn6
         DjyanpMZqlaykZBYQjorl0Y5dg1jZNeN+LeoJXxDpw82IW0J2k5Utl+BVP+h6gt+W/97
         PKOekke7CnqVmlIHJ4yxrClaNjXHdyFEIg7R9C4Up7Kdi5TnmV21A2PathXND+RVAAI2
         Julil9/K+ykdg1hxUA97+WWIa9lESxapNN8gfl6aGIsaL2C+6o/P+yX8G0aWYTfax7gs
         6k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723257342; x=1723862142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmAToJhlOXgTBoR3AeOW+sPvFitGle+hEJ/YMCiyrqM=;
        b=YQ5pMIyyfv8iubqhEPJ/Y1B3NDxisZ7x8CfnG6ZvINa6yc9UM6G0TvCwo8kLJPaUfq
         YXSsmVSXbpGvBiDn8AZAFWRHroTm1ggzNqs/z7BIxL1bRw2k+iQp9bNq2RfGmvK0biaU
         4+fD9TaWTsmkYs3g08QLAgB/Wl4G51gStuoestz2Rxt/nGIi3BAEopLBj6Fu4I+6bbP6
         AXotbpC6doTrifyrRSEgM3Al1IDY1Ecm7rb/wGx294i4lG+AwjukxoMj4GaHmthKC7TP
         sl/9mqhn4SSp2QLZS3OW+QBcgenscXYipq5ixqjqTNymTm3Hb9UweOCsdk1qY8JhhUa6
         KinA==
X-Gm-Message-State: AOJu0YzTKaJZiH/g039YdCufvcDtWO2E5nYpEgjnpVkQtJ31T6Pwf556
	KCvZ7RNHNkpyMi3aY7Hg3X0ney5hI9aOpPjEAp5HtaVJvyLjKrojtqZtMLbO
X-Google-Smtp-Source: AGHT+IGvl6kNLNBC4iAX9V7dxpjkfAcsnBqaI6vUNHItnTwnZxs8XCe7shtHPNzDNHzq9m8rxIpM7g==
X-Received: by 2002:a05:690c:4810:b0:665:3394:c068 with SMTP id 00721157ae682-69ec9449b8bmr38527827b3.37.1723257341606;
        Fri, 09 Aug 2024 19:35:41 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:e383:f1a1:d5c5:1cf2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b371sm1280147b3.114.2024.08.09.19.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 19:35:41 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@fomichev.me,
	geliang@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v7 3/6] selftests/bpf: netns_new() and netns_free() helpers.
Date: Fri,  9 Aug 2024 19:35:31 -0700
Message-Id: <20240810023534.2458227-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810023534.2458227-1-thinker.li@gmail.com>
References: <20240810023534.2458227-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netns_new()/netns_free() create/delete network namespaces. They support the
option '-m' of test_progs to start/stop traffic monitor for the network
namespace being created for matched tests.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 52 +++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 tools/testing/selftests/bpf/test_progs.c      | 88 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  4 +
 4 files changed, 146 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 47fc37aa13a5..c896ae365fe3 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -446,6 +446,58 @@ char *ping_command(int family)
 	return "ping";
 }
 
+int remove_netns(const char *name);
+
+int make_netns(const char *name)
+{
+	char *cmd;
+	int r;
+
+	r = asprintf(&cmd, "ip netns add %s", name);
+	if (r < 0) {
+		log_err("Failed to malloc cmd");
+		return -1;
+	}
+
+	r = system(cmd);
+	free(cmd);
+
+	if (r)
+		return r;
+
+	r = asprintf(&cmd, "ip -n %s link set lo up", name);
+	if (r < 0) {
+		log_err("Failed to malloc cmd for setting up lo");
+		remove_netns(name);
+		return -1;
+	}
+
+	r = system(cmd);
+	free(cmd);
+
+	return r;
+}
+
+int remove_netns(const char *name)
+{
+	char *cmd;
+	int r;
+
+	r = asprintf(&cmd, "ip netns del %s >/dev/null 2>&1", name);
+	if (r < 0) {
+		log_err("Failed to malloc cmd");
+		return -1;
+	}
+
+	r = system(cmd);
+	if (r > 0)
+		/* exit code */
+		r = -r;
+
+	free(cmd);
+	return r;
+}
+
 struct nstoken {
 	int orig_netns_fd;
 };
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 0d032ae706c6..c72c16e1aff8 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -93,6 +93,8 @@ struct nstoken;
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
 int send_recv_data(int lfd, int fd, uint32_t total_bytes);
+int make_netns(const char *name);
+int remove_netns(const char *name);
 
 static __u16 csum_fold(__u32 csum)
 {
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index f8ed1a16a884..f45b06791444 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -18,6 +18,8 @@
 #include <bpf/btf.h>
 #include "json_writer.h"
 
+#include "network_helpers.h"
+
 #ifdef __GLIBC__
 #include <execinfo.h> /* backtrace */
 #endif
@@ -642,6 +644,92 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
 	return err;
 }
 
+struct netns_obj {
+	char *nsname;
+	struct tmonitor_ctx *tmon;
+	struct nstoken *nstoken;
+};
+
+/* Create a new network namespace with the given name.
+ *
+ * Create a new network namespace and set the network namespace of the
+ * current process to the new network namespace if the argument "open" is
+ * true. This function should be paired with netns_free() to release the
+ * resource and delete the network namespace.
+ *
+ * It also implements the functionality of the option "-m" by starting
+ * traffic monitor on the background to capture the packets in this network
+ * namespace if the current test or subtest matching the pattern.
+ *
+ * nsname: the name of the network namespace to create.
+ * open: open the network namespace if true.
+ *
+ * Return: the network namespace object on success, NULL on failure.
+ */
+struct netns_obj *netns_new(const char *nsname, bool open)
+{
+	struct netns_obj *netns_obj = malloc(sizeof(*netns_obj));
+	const char *test_name, *subtest_name;
+	int r;
+
+	if (!netns_obj)
+		return NULL;
+	memset(netns_obj, 0, sizeof(*netns_obj));
+
+	netns_obj->nsname = strdup(nsname);
+	if (!netns_obj->nsname)
+		goto fail;
+
+	/* Create the network namespace */
+	r = make_netns(nsname);
+	if (r)
+		goto fail;
+
+	/* Start traffic monitor */
+	if (env.test->should_tmon ||
+	    (env.subtest_state && env.subtest_state->should_tmon)) {
+		test_name = env.test->test_name;
+		subtest_name = env.subtest_state ? env.subtest_state->name : NULL;
+		netns_obj->tmon = traffic_monitor_start(nsname, test_name, subtest_name);
+		if (!netns_obj->tmon) {
+			fprintf(stderr, "Failed to start traffic monitor for %s\n", nsname);
+			goto fail;
+		}
+	} else {
+		netns_obj->tmon = NULL;
+	}
+
+	if (open) {
+		netns_obj->nstoken = open_netns(nsname);
+		if (!netns_obj->nstoken)
+			goto fail;
+	}
+
+	return netns_obj;
+fail:
+	traffic_monitor_stop(netns_obj->tmon);
+	remove_netns(nsname);
+	free(netns_obj->nsname);
+	free(netns_obj);
+	return NULL;
+}
+
+/* Delete the network namespace.
+ *
+ * This function should be paired with netns_new() to delete the namespace
+ * created by netns_new().
+ */
+void netns_free(struct netns_obj *netns_obj)
+{
+	if (!netns_obj)
+		return;
+	traffic_monitor_stop(netns_obj->tmon);
+	close_netns(netns_obj->nstoken);
+	remove_netns(netns_obj->nsname);
+	free(netns_obj->nsname);
+	free(netns_obj);
+}
+
 /* extern declarations for test funcs */
 #define DEFINE_TEST(name)				\
 	extern void test_##name(void) __weak;		\
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 966011eb7ec8..3ad131de14c6 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -430,6 +430,10 @@ int write_sysctl(const char *sysctl, const char *value);
 int get_bpf_max_tramp_links_from(struct btf *btf);
 int get_bpf_max_tramp_links(void);
 
+struct netns_obj;
+struct netns_obj *netns_new(const char *name, bool open);
+void netns_free(struct netns_obj *netns);
+
 #ifdef __x86_64__
 #define SYS_NANOSLEEP_KPROBE_NAME "__x64_sys_nanosleep"
 #elif defined(__s390x__)
-- 
2.34.1


