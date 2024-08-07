Return-Path: <bpf+bounces-36611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC894AFCC
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 20:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B2A1C20BE4
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 18:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5311420CC;
	Wed,  7 Aug 2024 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzyc47sC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9D13F458
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055519; cv=none; b=AHbHfHq6a58/p5hzgSbl3cQZAm6DTX8thhC45rZFiZ2N5/hIfSX3ecB/N2VbAk9G/Zi07eRqqVy9bBRYM4K6FeCCwDfqL1NRgU8JxWRp9s3Lh3RKKe5DTlgzdHahroxG94YGJzx9ttR7+OLwNCPC6tBqRP5guo5blXQi7KAeElc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055519; c=relaxed/simple;
	bh=P8lNR6soeXWr0nPEKNRdCWFFT+afOftxtWzlHgVj1oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ippWch6qUvbjejVi/ptu3zJpYB6/YkzQSMIKowtiVd419dpguqXEfocYRLZf/rO3YZXoYz3pr9nqZ+uBoUoqRRux4m3PfPeljazoKFclxCwL6avVTXi+jctep32xy55d3Dfd5kXgDRnN0ZYxwuv3WOxmp9YWtD15yOgkMNgVbpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzyc47sC; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6694b50a937so1786577b3.0
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723055517; x=1723660317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QCurrhCImbc7wVzXiUJOjtvYEztt8msK6KjMSay9IA=;
        b=lzyc47sCXYWHsN9IQ5SyywxjKRB/Pj6BlxBaErhk/gT2IfceT1TA+0VCHvb4JU5tvn
         7iqXyhxCKk01pmeZLus5KOvcdjswvuasIelU6mYmd63kPfaaEwqX/wrVYCvPVRHyeBLD
         6kkYiW6jZTLg04q6wWzq4KPRf1en77KDCHNzuMyA6O6SxOYctpWH+6LTaqJIDdRye2jW
         UIDRTY7UKIm3FA8ekg7Z22s6GooBKZGQdBTc+5mUPGLeoxNR3xu0QnGW+o0i69ZwA0c4
         ZOEpbqlrcNhNkmqTHLWbrqfwKcLLY7ugDqLg2Aa9i7StpnYbUJe/XE7TKSvpYuoDICEZ
         S82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723055517; x=1723660317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QCurrhCImbc7wVzXiUJOjtvYEztt8msK6KjMSay9IA=;
        b=sh5yt5YaXDqpcu0UnxUJmVwOdPNo3qLW3aoldn7+Oogh/G8vyitmAuIJA1sfLaQ56L
         Fo0IxCn00q0BSAWJ7R1j/Rvbm/TlwugMD/t3hnYTSl1Q8mgRqCd1JDOyQzoOFOgfB+Kn
         LTjHBbrkwywRNPcqoUOdb46i9gKp4C79u3Uir2HCHor0AW9jtPNfxcYRbIdmx8JKxRq3
         tvnnIPTuGxrmC/rDTVE8pnkaz0tzfEwyeJamM/fE723GGSjmtw16E5D/RKum2eTbSiqj
         Wer39867hC9Yw+2enVo4J+K1A4ul140HtOtIkY/PxZgY59/wZIJoGModdfHgPNKej4G1
         H16w==
X-Gm-Message-State: AOJu0Yz5GPHmgRFkxvx/JLkQZXo6tCRBie7b2QEHjh35xatyWRdOGB7Z
	R7jJc29wJOfQWlFKeW344wijDA+IrlhHQ8ET5n2jIdH5pgJ/ilG09ECs17/I
X-Google-Smtp-Source: AGHT+IEfU4CID9YuAZ4/ARQ0Zr2eauTjSDHdVxlg6ksEacpu3AQ96vKFehuO71Ip7ASyZSNPBRZWDQ==
X-Received: by 2002:a0d:dc07:0:b0:65f:8f77:720f with SMTP id 00721157ae682-6895f60d50emr205780007b3.5.1723055516803;
        Wed, 07 Aug 2024 11:31:56 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f4188a9sm20106447b3.2.2024.08.07.11.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:31:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 3/6] selftests/bpf: netns_new() and netns_free() helpers.
Date: Wed,  7 Aug 2024 11:31:46 -0700
Message-Id: <20240807183149.764711-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807183149.764711-1-thinker.li@gmail.com>
References: <20240807183149.764711-1-thinker.li@gmail.com>
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


