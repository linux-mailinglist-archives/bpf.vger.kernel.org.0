Return-Path: <bpf+bounces-36512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CE1949B04
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 00:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCC0B218B7
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A75517279E;
	Tue,  6 Aug 2024 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRptcJgn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF4171E49
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982376; cv=none; b=oSfE6zOHSWN1uXJunmh7kOTSYCiMkMzN1jh5R2Gs9tThODiy+aoImRgIIO+XdZI3QYH+YsV1kVVfFu/zgQnUk7+EukGhuwANydeKfj6f5cF19QR7FMH8Cf6VeWeBFbPEaoT+GXMle1UsmglIZFtJ2q3faDsK6r5eg/NtfXFcCoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982376; c=relaxed/simple;
	bh=p7Gv4fQWV8U7d79/IKBq94MKCCQbxRXcrul0dG59K+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YU1T4SBYGIS3/9AYoI2SKQzIO+ue8FaaFAPT4F+62IkjF+PUiKaVUXeM4upRBmgVuj1kj9OWk/jJUB5OYJNr4P0eUjXuZKak+Grk5zqXnNPQh+S5/vIAwywzBgLsdWvkbDx3NgzP/BdJVNqCVoEZJ/DPEGkEZuzvvowrPOkGWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRptcJgn; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66ca5e8cc51so10657477b3.1
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 15:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722982374; x=1723587174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+rsQYojVxMoYCnlnJKnjTxiNThHXjos+KDhHh5tzeU=;
        b=WRptcJgnG8Ql2ckHRqTOc1WDdnSm4CP26hcaWio9jtADXYMXy7KpYCQZsLqGR2FDO2
         GeHWpYeeVTWbsfdSzRjjOdapHgycAvWllaJr/n4j6ANmvXMLFXq7x6wm/Eu1VnfcH8K0
         KH4U17ftLiV3M/Gdrb99n+c6NkzM9jDZOwH8D94tnDEaHXl62mHZUtVKpxjKJ+yWc55l
         NHtXb11pxZUSlI/RZ48Zsk+bKAqVrUqe1Icp3v4axibxuklYd3C0aWAt/R6W0Mbl3p+f
         z8CuTVbA3OUgCtoQieBcY01DDLADvrgf/zVq8IKNsnOhyVIX197wJHgbikiI+DbHxPgw
         3vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982374; x=1723587174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+rsQYojVxMoYCnlnJKnjTxiNThHXjos+KDhHh5tzeU=;
        b=ej0r4pAe83yeHvaJc+xAWMAPnnnEBD7a0hbUun5TpFA5eGoxY4ht4fnufIAbP+xXJO
         xu29wjaIQr/jVP4q8VgieSaohH4//21FzpVkbli8bFVAXtcveVrTJZaGD9EiPuwR7IGa
         J6tXQWeBla0wNDFlQAxN1d6tUXF6JJskRXi1JnLauGBwQGwVldYnzSAsJ8TUlYJrfyZ5
         DYn4SoQ//s3ldKa65e/TJA8vrrpCHrNkDGw2wUbjrRJRdDTfwaG+eqfiuRIm1mhKV0z+
         +6Wth+Eb+sqT2TbylK9H3UsCelPs+Pno57sWwrK59joPREF9th1z3AKMu4Z5D2iDsfbp
         h+7A==
X-Gm-Message-State: AOJu0YwMyLWfmot3Xu87rDoiQiqWXqX35OgxYnL5mS4nckruqhTjF+Qu
	zvb6sFeC9JZR6KUktDZB/yJCkordjpEzm0egQy3EGIovlC1QaWPGrCj/Y9Ki
X-Google-Smtp-Source: AGHT+IHRFq82/vtNttGEfr3rOpXqMu1DOT6bU+F+vLuc5IETla+Sc1rKVOeA+SnqUOyWIfRxZwkIMA==
X-Received: by 2002:a81:7702:0:b0:66a:8ce9:b1c7 with SMTP id 00721157ae682-68964390fa9mr196902127b3.37.1722982374014;
        Tue, 06 Aug 2024 15:12:54 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a12d138b6sm16990017b3.88.2024.08.06.15.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:12:53 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 3/6] selftests/bpf: netns_new() and netns_free() helpers.
Date: Tue,  6 Aug 2024 15:12:40 -0700
Message-Id: <20240806221243.1806879-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806221243.1806879-1-thinker.li@gmail.com>
References: <20240806221243.1806879-1-thinker.li@gmail.com>
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
index 496723b194fe..447f97ed3790 100644
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
index cfd2330a5230..057fffea57e7 100644
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


