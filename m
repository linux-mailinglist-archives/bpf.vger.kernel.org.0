Return-Path: <bpf+bounces-36597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5EB94AF21
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A437C282477
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4CA13E025;
	Wed,  7 Aug 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jViFFLVe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863A13DBBC
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053062; cv=none; b=AzLoak5SnQf6jO7qlGypMA6UMNUPRD/NQSY85cgZ/Ldo7IK7izzPIfws9aSfz5J4YmiuSPdSa0f5IXMYaUhIOY2nVbWvcv1d6fnJF8DfxyNkEUXDh/gSAxl+rITwOiwyLLeuGBCEAdSuOflGjGMQWPmJVmNp1g919l33TvXNUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053062; c=relaxed/simple;
	bh=P8lNR6soeXWr0nPEKNRdCWFFT+afOftxtWzlHgVj1oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XlY0hPeRXLXacaUHSjwvxeXUNRw4pw+8cNHpBAHvQxKvjryuMWwEEIV7/ixRJF5xGUnLblE+WKKjyyuDqycOohDpod1lVmKa4Fq5ATBYqFtne/SAfkPdkjHzRBo9cpYytzrpixw+VMpG6sdhGhGbSlfanEgsxAz0U5iT3CGJhJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jViFFLVe; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-699ac6dbf24so973657b3.3
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723053059; x=1723657859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QCurrhCImbc7wVzXiUJOjtvYEztt8msK6KjMSay9IA=;
        b=jViFFLVeeJkz1RQ/Z6Er185GhYIVU9Y1J/gMRzrMIsKPDGQPSMdvnc2TiqSIMeibV1
         CuBFlLvHlAlbis1zN3UA55cRIAMlQSXXcK7vb7cpsgViEngvmTjZ2R5gzUWSDZrvSWRK
         wTb+enIMEL8jgM2xY25qhkFPt8So42p5ZGcutxLT6vAbl1m/WhvG0sQNH23IxWk3COKo
         LyPP4Sa38JCxH8c252nwPMTUw+7terw68juMpXHPlT4sc9MJxYeoA0LGYBo29vNht5VL
         9ZNCp2pEuKvPq5SoNHLi967YqAg4jTSR4FWmygLaPhkIHs2ElBdu5d2bJwTDBGi4WENP
         PKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053059; x=1723657859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QCurrhCImbc7wVzXiUJOjtvYEztt8msK6KjMSay9IA=;
        b=OseJzRWia+5V8gflX0UUwgfeG84Da+O4rEchS3eYRAczDt+MvxiLS3CDDzqb2RNCkS
         CQYK51Jpa5khQ4toteRJUcGkeX48zwcAzDqBz5s3n15GpUi+Dzf1r8v7NGTzhOel0RJU
         dkb0Yb0rxsE3fm0cd8nzAbyfyjuKo7HXQKqVwlHb1lPgWV1llWfdMuCsjzYUGurAR4or
         OkvNGjqysriPJR4gCHcaWnovH5X/dgf5o8DpqJ8Nb5yotC8BYxg+KuwWvBy74Vlsnqux
         1oPX/Bk/qn2TuneDpvB3GeuqoHAtadZF1VJTBWBhEbV16OyRiooEhvNek1tJ6/o+FD+U
         OFHA==
X-Gm-Message-State: AOJu0YxqkufeOgZqTv9qpd8qipCP7NxqRlhyi2Gnh2V5J0o934PKbBPw
	JH3J/ge9LPJXE/OJfeD1HK+Zkwt7bDXbRLHzMwMe+mApT4z9/BldxgCSV/zI
X-Google-Smtp-Source: AGHT+IHbZHYNIdeRECA0Wjwi9wYuyEuJIUpsuFTo3UuS42korZZuAcvbvYNahVr6QGe3AyuAQw7pUg==
X-Received: by 2002:a81:8a46:0:b0:651:79ee:d13f with SMTP id 00721157ae682-6896122b9f6mr179310237b3.20.1723053058963;
        Wed, 07 Aug 2024 10:50:58 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68fcd1727f3sm14988727b3.90.2024.08.07.10.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 10:50:58 -0700 (PDT)
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
Subject: [RFC bpf-next v6 3/6] selftests/bpf: netns_new() and netns_free() helpers.
Date: Wed,  7 Aug 2024 10:50:49 -0700
Message-Id: <20240807175052.674250-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807175052.674250-1-thinker.li@gmail.com>
References: <20240807175052.674250-1-thinker.li@gmail.com>
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
 tools/testing/selftests/bpf/network_helpers.c | 40 +++++++++
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 tools/testing/selftests/bpf/test_progs.c      | 90 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  4 +
 4 files changed, 136 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 462aeadd767e..3611c542241c 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -445,6 +445,46 @@ char *ping_command(int family)
 	return "ping";
 }
 
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
+	if (r > 0)
+		/* exit code */
+		r = -r;
+
+	free(cmd);
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
index fed22e9fd223..3f79ce52aeb0 100644
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
@@ -642,6 +644,94 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
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
+	/* Set the network namespace of the current process */
+	if (open) {
+		netns_obj->nstoken = open_netns(nsname);
+		if (!netns_obj->nstoken)
+			goto fail;
+	}
+
+	/* Start traffic monitor */
+	if (env.test->should_tmon ||
+	    (env.subtest_state && env.subtest_state->should_tmon)) {
+		test_name = env.test->test_name;
+		subtest_name = env.subtest_state ? env.subtest_state->name : NULL;
+		netns_obj->tmon = traffic_monitor_start(nsname, test_name, subtest_name);
+		if (!netns_obj->tmon)
+			fprintf(stderr, "Failed to start traffic monitor for %s\n", nsname);
+	} else {
+		netns_obj->tmon = NULL;
+	}
+
+	system("ip link set lo up");
+
+	return netns_obj;
+fail:
+	close_netns(netns_obj->nstoken);
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
+	if (netns_obj->tmon)
+		traffic_monitor_stop(netns_obj->tmon);
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


