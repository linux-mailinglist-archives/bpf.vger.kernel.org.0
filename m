Return-Path: <bpf+bounces-35960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2426E940224
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 02:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AFA1F2283F
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 00:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49168440C;
	Tue, 30 Jul 2024 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M660VYSM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50E1FAA
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299277; cv=none; b=HTj6SwNWEYvYj2T8NWSdPrjXWzVXqRv4yylb1jF46YUz6UmOSkBv3a8NtcIFF2lEwW+z6/h/BDrWS0/g/Trq+RX36mW6MQKN+WYGWWXCf5gXdS9Kpc1yAxKS7NgD2w2tYGdjt/tzpU4+mPA9SzE8xfbRTPnaKy+wzCfCW28GtWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299277; c=relaxed/simple;
	bh=DTtvp6vsqXy7HozIRrWm0gToOu8eFQaCyNjFxaLwIYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAXUGLgtrjGw/HgOBcoyyhBbJyfYEVE04GsAQep4RxeyScpCMPF7ny/i3MUY9G6SG1gvjZn21S/4Vblb4AU7ObwvpEiWJTkdozJQW0BHMTR4TlZ+XyxFhW9x8A0Dtbg/ZM8b30FAG1DReNdPqOnWglG72lBmbRN66Q3+0O24WmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M660VYSM; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-64f4fd64773so27451937b3.0
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 17:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722299275; x=1722904075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XapJx9d7rawJZiXxi/Qv0npkRKS41fYZIenUXcIpSwo=;
        b=M660VYSMgmMMhPZWLR83/pdfQji0egtUqV103g9+QjI3qc/g5sQOSG9qKQIqaC/2Kg
         arAo+uiMAiV6bPXj/h/IcOLqf5178LNMkWgOsUn0h7mchtcjaA4gby2LKL13HqTGtzSa
         P3hxF1kZ61tOWfuoR0Xy8wigLEL9PdggpDa5Ir8qME+DUkLPUTy1xw916R2RZaw3JccX
         inW2gmoplOPmbnCevUJw2Apy7/iZkyB+2UUM8f+IdvwZ60x2Czqhs56igI6czeBVh3UI
         IWHs/E9hmbMHgRTILEMmfNQSy0TVUnXhJ0W4fQEMzs0XLcN/QdraRDbL8pXEqMI8NHol
         +q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722299275; x=1722904075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XapJx9d7rawJZiXxi/Qv0npkRKS41fYZIenUXcIpSwo=;
        b=OF9Ivy7ureLez4TJknlO2tYyABTAFQ/VIpjBpwzdMh+nhwmUMwrtkc8DDGZqgAtrzt
         v1KbpIZ2boIBU8krZgOeVSyLKL77Z3cCWZn8hhfIyzhx3V3ejwcUTcSro1ME68b4+wB4
         By7Ydhke0VzQpuBauZAcmtI3bqSb0I+7XLv1VXAgZTh0hifp01GDX/7tPn8wx7ascKwe
         OmYpCPvbqGhu2RahaHgb5qJuyQo8+H80PKR1O8TK1rMDYYZkQtVfiP7pIHZ68HzX1jm0
         x2FYnMAcwcl+G18LADiwUHCBS/Vkf1B7wYv+K3H9Ap47seThCiKuqgoan0yyRfDmZINX
         4rVw==
X-Gm-Message-State: AOJu0YyyLkd06d7k5Py/3u8qWrBQxoWRkL8AY2LzM/yRAty4N8TpEWs3
	8/2o17Pn+tsecNMghFjrEyDwbNrnFUpGPxd2D4Z4Jf8w8m/AcRMAyOZ5Bh8X
X-Google-Smtp-Source: AGHT+IEaf58f82urLhVCoymaHh2KKPU/7Y5HuYHOx42IcYCOUQ2kIN92GwTY7PikWCYVm1uyG42h6Q==
X-Received: by 2002:a0d:c885:0:b0:64a:9832:48a with SMTP id 00721157ae682-67a0068d697mr124075167b3.0.1722299274875;
        Mon, 29 Jul 2024 17:27:54 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5695:a85f:7b5f:e238])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756c44c698sm23052177b3.135.2024.07.29.17.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 17:27:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/6] selftests/bpf: netns_new() and netns_free() helpers.
Date: Mon, 29 Jul 2024 17:27:42 -0700
Message-Id: <20240730002745.1484204-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730002745.1484204-1-thinker.li@gmail.com>
References: <20240730002745.1484204-1-thinker.li@gmail.com>
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
 tools/testing/selftests/bpf/network_helpers.c | 26 ++++++
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 tools/testing/selftests/bpf/test_progs.c      | 80 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  4 +
 4 files changed, 112 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index e0cba4178e41..99c67020c824 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -448,6 +448,32 @@ char *ping_command(int family)
 	return "ping";
 }
 
+int make_netns(const char *name)
+{
+	char cmd[128];
+	int r;
+
+	snprintf(cmd, sizeof(cmd), "ip netns add %s", name);
+	r = system(cmd);
+	if (r > 0)
+		/* exit code */
+		return -r;
+	return r;
+}
+
+int remove_netns(const char *name)
+{
+	char cmd[128];
+	int r;
+
+	snprintf(cmd, sizeof(cmd), "ip netns del %s >/dev/null 2>&1", name);
+	r = system(cmd);
+	if (r > 0)
+		/* exit code */
+		return -r;
+	return r;
+}
+
 struct nstoken {
 	int orig_netns_fd;
 };
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index aac5b94d6379..91763fbe58d2 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -92,6 +92,8 @@ struct nstoken;
 struct nstoken *open_netns(const char *name);
 void close_netns(struct nstoken *token);
 int send_recv_data(int lfd, int fd, uint32_t total_bytes);
+int make_netns(const char *name);
+int remove_netns(const char *name);
 
 static __u16 csum_fold(__u32 csum)
 {
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 2fb375ecc095..a5036f3359e8 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1060,6 +1060,86 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
 	return err;
 }
 
+struct netns_obj {
+	char nsname[128];
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
+ * name: the name of the network namespace to create.
+ * open: open the network namespace if true.
+ *
+ * Return: the network namespace object on success, NULL on failure.
+ */
+struct netns_obj *netns_new(const char *name, bool open)
+{
+	struct netns_obj *netns_obj = malloc(sizeof(*netns_obj));
+	int r;
+
+	if (!netns_obj)
+		return NULL;
+	memset(netns_obj, 0, sizeof(*netns_obj));
+
+	strncpy(netns_obj->nsname, name, sizeof(netns_obj->nsname));
+	netns_obj->nsname[sizeof(netns_obj->nsname) - 1] = '\0';
+
+	/* Create the network namespace */
+	r = make_netns(name);
+	if (r)
+		goto fail;
+
+	/* Set the network namespace of the current process */
+	if (open) {
+		netns_obj->nstoken = open_netns(name);
+		if (!netns_obj->nstoken)
+			goto fail;
+	}
+
+	/* Start traffic monitor */
+	if (env.test->should_tmon ||
+	    (env.subtest_state && env.subtest_state->should_tmon)) {
+		netns_obj->tmon = traffic_monitor_start(name);
+		if (!netns_obj->tmon)
+			goto fail;
+	} else {
+		netns_obj->tmon = NULL;
+	}
+
+	return netns_obj;
+fail:
+	close_netns(netns_obj->nstoken);
+	remove_netns(name);
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
+	free(netns_obj);
+}
+
 /* extern declarations for test funcs */
 #define DEFINE_TEST(name)				\
 	extern void test_##name(void) __weak;		\
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 6c88e15564d6..b1419589d8c1 100644
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


