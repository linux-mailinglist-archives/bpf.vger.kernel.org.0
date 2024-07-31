Return-Path: <bpf+bounces-36164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F15F943676
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 21:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460A3280D57
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 19:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A5546542;
	Wed, 31 Jul 2024 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu5YQNai"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA917BCE
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454310; cv=none; b=aE9kkdI3Etzbbpd+bO+0GxotHKg9PRu9DjjG4PTu3KvOQ7+dfdqlTPg2x2RjOJUjL/sW1ncyjHZhCtx0TUv8e6oJqV7uZfcNuCaPozfGZIYRw6MPZzlMkIqZ85zwImvmPTC4Nq7cix3gpm8r0r+RGQrx7RIuiwAzHoKVHQbyeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454310; c=relaxed/simple;
	bh=6KP6XsUv2MGZxxCLPVaPwIrIr/pUiW9quThq/ark6wY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQL72S88m1SHfbNXy1p7O+JI5YBD7e0NpZBLW7dsw3B4nXv95Opdu9qjkN676N2otaE6DERZc2hRDx074/w7BAsU/GDjfxGybpXXSLUmTPFaRGa7Ui3KILY4zaiYYfpUBZFcIlkM/EuckaEl1lsj5jXrPPTFPch1FanK8IILUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu5YQNai; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-664ccd158b0so47599917b3.1
        for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722454307; x=1723059107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqyn20/ZGp0eJf+fwSbjl5bPgfZOLDFMntDAjkIVgDU=;
        b=cu5YQNaihGjWJCFd/JeWlgcJAGzYPG9g0HYkfZYod0lbBWzDKrIAEVXf9ectmdkdIc
         4Ong2kHgkg4nOK9X2QO7z/fEdsjO7Oz+s696vy4zHOJjvH0ZV8qr+UidPb3Sm7GUX/jH
         EcyzTIGJLesnJ9JLn8RO1S1jOkdmXNlXXViLXmGCrI7RuTQ6J8urlk3CR5PJ92rND06n
         W6FGDjLV1cAVn4rLygRhLPOzLSi4YaJpaMssn6/T/Z/bzqKwZMgGf0nRC8ss1zlqDDrc
         ZkGWIh2btCztC/xWfd21GSXm7jVuX8G7MKUuxdUnJVeKqk1HD0ygNayTFYFXdUmNFqLT
         /itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722454307; x=1723059107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pqyn20/ZGp0eJf+fwSbjl5bPgfZOLDFMntDAjkIVgDU=;
        b=jSbFnxPQaK9pLmLQN8KBmrdAHC/ZmrJhd/4BwGxm+k64iBzpRIjjp13LgipGXUBI+N
         URshG9QSJ1SXU/uO9hLW2Fe3m4+9QJdFX+K5GLjbFXICHRI3lA+vxs/FxGFIR0g9ihYu
         R29h1V2pGSQsg6/raalk4Sf1TQgUntkFR/UHVopPNC/kk4GQtWyYBM+959mut0iIqS4+
         1zW/QP3+eZl1bufPct5VS5A/dHT4ZfUkHbrZ+3Qb4WMOIgTpK5Tc14l8eB2uqPsGCbIa
         Rb0hI/bTcZRJo+9btUXYDNC/a8rgHx9bV9ftNN8eQ5bJzB/hFEybZeXM0LWN+HyTNVcy
         TI1w==
X-Gm-Message-State: AOJu0Yzn3+J4LMzk5W55LL3euBKV/K0EKpZOJCGmHWzTp1TxcpgW0UIy
	/4pfeX6AgX8xQfOeVfwNYYpv8s5IFCbxYA/W6EW8xWfMWANjIB/qKUrXhKWY
X-Google-Smtp-Source: AGHT+IETXJNqQl5qB/oph2YCkC7jbvBOHW8Z2lMm8A9Po7+b1mAseiT+inQZRy8I2RAKfCYT6Qo22A==
X-Received: by 2002:a0d:f207:0:b0:669:b45d:2098 with SMTP id 00721157ae682-6874b291af6mr2031847b3.5.1722454307311;
        Wed, 31 Jul 2024 12:31:47 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c6db:9dfe:1d13:3b2e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024ab1sm30891597b3.91.2024.07.31.12.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:31:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/6] selftests/bpf: netns_new() and netns_free() helpers.
Date: Wed, 31 Jul 2024 12:31:37 -0700
Message-Id: <20240731193140.758210-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731193140.758210-1-thinker.li@gmail.com>
References: <20240731193140.758210-1-thinker.li@gmail.com>
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
index a3f0a49fb26f..f2cf43382a8e 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -432,6 +432,32 @@ char *ping_command(int family)
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
index cce56955371f..f8aa8680a640 100644
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
index 95643cd3119a..f86d47efe06e 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1074,6 +1074,86 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
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
index ceda86a5a524..e025ac6f5a8d 100644
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


