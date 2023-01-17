Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD54C66D572
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 05:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjAQEuj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 23:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjAQEug (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 23:50:36 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B25234FE
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 20:50:32 -0800 (PST)
X-QQ-mid: bizesmtp82t1673931011tc4ge5k6
Received: from localhost.localdomain ( [1.202.165.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 17 Jan 2023 12:50:09 +0800 (CST)
X-QQ-SSF: 01000000000000709000000A0000000
X-QQ-FEAT: +FrjhAEeCXsmF5IaL3D29sBXbpY081Qnr6CCZ56mMUQ6BrV6Wanmk6Xo+iL/Y
        GGA45CHEblr+yolM0moN81SaJEZ3LjNAcCNAhxijNlXT3MYBMwKwDFC9ddhUGXe/pZNaV1w
        /pMCAl2goAvGrDyz9nm39jSNn8xKFaaBRqUW4H5MQJasYguMjM+KzOQJOu+SwI3mi39x7GU
        BwNVaG9K/bHLuf5WtXa9OYBaXpDZXtSJJjT6BOqkQCILd0vkb3aP4zko4LdsMp6tIVdfu99
        lg1KsHNIx19pGnoiAQ6XwAjzkdqeJb1am8YrejOw34kBRUBKpzvU0e0pcKYSKdq6wWTmQi4
        6aZCLhPovANsF/nm47cog8uI79lrabhgYqCFdcO
X-QQ-GoodBg: 0
From:   tong@infragraf.org
To:     bpf@vger.kernel.org
Cc:     Tonghao Zhang <tong@infragraf.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [bpf-next v1 1/2] libbpf: introduce new API libbpf_num_online_cpus
Date:   Tue, 17 Jan 2023 12:49:01 +0800
Message-Id: <20230117044902.98938-1-tong@infragraf.org>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:infragraf.org:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Tonghao Zhang <tong@infragraf.org>

Adding a new API libbpf_num_online_cpus() that helps user with
fetching online CPUs number.

It's useful in system which number of online CPUs is different with
possible CPUs.

Signed-off-by: Tonghao Zhang <tong@infragraf.org>
Cc: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 47 ++++++++++++++++++++++++++++++----------
 tools/lib/bpf/libbpf.h   |  7 ++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 27d9faa80471..b84904f79ffd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12192,30 +12192,53 @@ int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz)
 	return parse_cpu_mask_str(buf, mask, mask_sz);
 }
 
-int libbpf_num_possible_cpus(void)
+static int num_cpus(const char *fcpu)
 {
-	static const char *fcpu = "/sys/devices/system/cpu/possible";
-	static int cpus;
-	int err, n, i, tmp_cpus;
+	int err, n, i, cpus;
 	bool *mask;
 
-	tmp_cpus = READ_ONCE(cpus);
-	if (tmp_cpus > 0)
-		return tmp_cpus;
-
 	err = parse_cpu_mask_file(fcpu, &mask, &n);
 	if (err)
 		return libbpf_err(err);
 
-	tmp_cpus = 0;
+	cpus = 0;
 	for (i = 0; i < n; i++) {
 		if (mask[i])
-			tmp_cpus++;
+			cpus++;
 	}
 	free(mask);
 
-	WRITE_ONCE(cpus, tmp_cpus);
-	return tmp_cpus;
+	return cpus;
+}
+
+int libbpf_num_online_cpus(void)
+{
+	static int online_cpus;
+	int cpus;
+
+	cpus = READ_ONCE(online_cpus);
+	if (cpus > 0)
+		return cpus;
+
+	cpus = num_cpus("/sys/devices/system/cpu/online");
+
+	WRITE_ONCE(online_cpus, cpus);
+	return cpus;
+}
+
+int libbpf_num_possible_cpus(void)
+{
+	static int possible_cpus;
+	int cpus;
+
+	cpus = READ_ONCE(possible_cpus);
+	if (cpus > 0)
+		return cpus;
+
+	cpus = num_cpus("/sys/devices/system/cpu/possible");
+
+	WRITE_ONCE(possible_cpus, cpus);
+	return cpus;
 }
 
 static int populate_skeleton_maps(const struct bpf_object *obj,
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 898db26e42e9..e433575ff865 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1332,6 +1332,13 @@ LIBBPF_API int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type,
  */
 LIBBPF_API int libbpf_num_possible_cpus(void);
 
+/**
+ * @brief **libbpf_num_online_cpus()** is a helper function to get the
+ * number of online CPUs that the host kernel supports and expects.
+ * @return number of online CPUs; or error code on failure
+ */
+LIBBPF_API int libbpf_num_online_cpus(void);
+
 struct bpf_map_skeleton {
 	const char *name;
 	struct bpf_map **map;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 11c36a3c1a9f..384fb6333f3f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -381,6 +381,7 @@ LIBBPF_1.1.0 {
 		user_ring_buffer__reserve;
 		user_ring_buffer__reserve_blocking;
 		user_ring_buffer__submit;
+		libbpf_num_online_cpus;
 } LIBBPF_1.0.0;
 
 LIBBPF_1.2.0 {
-- 
2.27.0

