Return-Path: <bpf+bounces-37246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199359528FA
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 07:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15F92859E6
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 05:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427C115E5BD;
	Thu, 15 Aug 2024 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnhjJ/Ph"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3249B3FB30
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699984; cv=none; b=nzWkHNx8dwlozS71kYQnW7Sk08D/iGVIJrBsZ2onBksBkhEazxgVHnoAs7BM5lkRja9jocSli0sQw6xjAQCFCG/OU4tQ/g5TuY3cMWvKSNP/TiCz3Qe596Z4dpALyrTGuz5UxHVjcySvf53YAJ5kA4n2LNexx6c2DnEOkfoIqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699984; c=relaxed/simple;
	bh=Hvjt66AUPlbSTCqNorgfBIjPye5MrCCCs0NidIOX124=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqkHxUQdEgJacEE7sHQsBtIhaEhclkeUM5wsn0Mxft7uj0Wa6Ezd072+NN32Y5zNbK9ODTUfu6cUksE375AFHqI3C0QYEULHPA+sjk+GKAORMbvto/JIoTks4bBEBmAMPExNH3Le42m+YRe7U56svgqrm4ZbGO5IQ3KFUIcv86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnhjJ/Ph; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso714490276.0
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 22:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723699982; x=1724304782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsCc6ng7NizmE9UoYEt96es4Cp2qLeQy0D4Q53gM03Y=;
        b=OnhjJ/PhMn6GmsfPYJvzpe8OHVX25MtDr8enN7PSZrDmiWtYnArdBCRGKwexb5Ce3l
         M+u6QDvKVqyCjsnWgIwYPQHxXcCmmbY0IR1D4EGcqqoHcfYQG07dR0BYZiR41xzgQhU3
         T2cRTcfbtIRvtpU/J59ua13bVbI2rJsk5BJ8bbZYPyC3AcDXhu/zZINvO0BaU3wvKNDo
         jd/XAlmNvccOKl2PDwoOr5Z008GEfILaxMDQlgR7S4ntgq4SvVPYSCKSVY+6SHAmgmvG
         YZ0KCTs0LD0AS7ITNtLoSqNZhM6/X06zdhYEoPj5n+2ybOtMHKewrwJj9wOgnK2+w39E
         qS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723699982; x=1724304782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsCc6ng7NizmE9UoYEt96es4Cp2qLeQy0D4Q53gM03Y=;
        b=FijE4XnxpwqBvPMq+AdN5GKm3fmv2mQs3r96HuW/7Jn7RfvNacV2pUIVjBljd/F2up
         Q6eqOjftdwj9q9TWXq+8Y2ZGdc7JSkg7LQzpVV25ga9h46Udea3OdTP/AsQ1dOjG2VMq
         QIXaj6AHL42xfslAZt7Ao7sCo5yPyIlu+t/LUEl8bGTRX6Z1uTSHfJ7i9fmRL0PDz/yv
         wXN8BGLzbEZjyT8KtjcjL4XXYzND/hVD/JtwVPPcl4r3b8tw/ZVdm0379A7I9H9Jf+Xm
         25o5CxBFp/tYWz8rIshOkSBWhvBS3dJsvW5BjXbk6dDRpuuHxDyRlwcEynWoAkWYXf0/
         /aUA==
X-Gm-Message-State: AOJu0YyaoCzL03j2ppTovZ2J2Yf4UT0WATMEkg/nE9uGJIRN3++r8bOA
	1skR27gNyph++sQnnFa4V3yNXxTN+i8yClKRVymQsKj8rQf9LNJ0byjhPMdX
X-Google-Smtp-Source: AGHT+IHPd4j4915cXh5NoUj7zrhrUBFt0/2HZ4dwl/G2dhPZAfawCOu2jEmEbsSBOxT9qiEnQCrVqA==
X-Received: by 2002:a05:6902:1a43:b0:e0b:c100:efcc with SMTP id 3f1490d57ef6-e1155bf84damr5083292276.52.1723699981738;
        Wed, 14 Aug 2024 22:33:01 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:11c4:fddc:768f:9072])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9da160c7sm1482307b3.118.2024.08.14.22.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 22:33:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 3/6] selftests/bpf: netns_new() and netns_free() helpers.
Date: Wed, 14 Aug 2024 22:32:51 -0700
Message-Id: <20240815053254.470944-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815053254.470944-1-thinker.li@gmail.com>
References: <20240815053254.470944-1-thinker.li@gmail.com>
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 50 +++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  2 +
 tools/testing/selftests/bpf/test_progs.c      | 88 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |  4 +
 4 files changed, 144 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 4ab0568d7309..c4fc27931122 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -446,6 +446,56 @@ char *ping_command(int family)
 	return "ping";
 }
 
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


