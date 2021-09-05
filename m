Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B744400EFE
	for <lists+bpf@lfdr.de>; Sun,  5 Sep 2021 12:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbhIEKKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Sep 2021 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbhIEKKX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Sep 2021 06:10:23 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D47EC061575
        for <bpf@vger.kernel.org>; Sun,  5 Sep 2021 03:09:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j1so2456353pjv.3
        for <bpf@vger.kernel.org>; Sun, 05 Sep 2021 03:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dLiniIKer+yqpCrftVKNNMJg4bC6zOjvixu+pjUgVRY=;
        b=EdAiVQ1TDzZOqHrzcM67/InnLz/S1JDOK/0KQRy7kqqbSveVlqNR7uGvfwSSD9GvP7
         YJJ2ICbfkxY3tQbG9xJyNzzG8Pym7p6Lq8eDlEyWqTHRkntYNYatcYNRGb8qsogcdnxg
         J6cNgaFBSIUcLKV7C+spuv1hnDXhnlzh04I+5NzgE0houqJePFkBsfrEuIG6IDh5brKH
         BdGb2COR8/Ge61qiaPeLj8Yzx8w6g+2a4z7acSO7o4qLj1pzuuwjHtfau5GqSWr4KOvU
         pZ9u7jtZ+YGObAu5bwBEqQSQuMfFEJ+QaZNaGyl5uDRH6i/0JsNwmM9/FuZPNtv/JRCk
         ii4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLiniIKer+yqpCrftVKNNMJg4bC6zOjvixu+pjUgVRY=;
        b=f17rqCeqSr4URrRz9Jjc/YCcuVUu0l7/paMHbgl8QZ7s5kc/GkUCji/ByODjO6K7Xr
         vsW4jwMOsX9VG1APDFzr66z/pyYpnoqeAQrX3Gw6C/yegZCD5/G/h5rNNJNQo95eaPXP
         t+n1gqjJoLdJw82nQTYKPUWMXYPMQLJZWHp7ILW0JDpUeJuTeC+JggYdjQnE493nIQdX
         hCgOMKExeWAx6295LS25/L7lZFLtO8IPAENaWz4oXF05we6nCLdlt/d3Zc96g5uRKycC
         enOLBWVFFg9ut5uLJrbonWsADWzo7g1JW0f+hv+nuoRPw59bQ4ojWu9l9/EIzLcGRYnK
         PWhg==
X-Gm-Message-State: AOAM53265L5S+zgA+xJGin8abscOD4tQN2PUTuoa5qdY0zWa38q0wN18
        aIgZOvfdR5/vfNOjICRWvpH5PmU6RHQ=
X-Google-Smtp-Source: ABdhPJx9c/Cz/x5xNgnILpeCRr8IgVr8kETEROF7lL9LtrRM9gHQQf6Mwnp3XvHSZZ6ka8UYax4zkQ==
X-Received: by 2002:a17:90a:f285:: with SMTP id fs5mr8318848pjb.148.1630836559757;
        Sun, 05 Sep 2021 03:09:19 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id o6sm4443960pjk.4.2021.09.05.03.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 03:09:19 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test BPF map creation using BTF-defined key/value
Date:   Sun,  5 Sep 2021 18:09:14 +0800
Message-Id: <20210905100914.33007-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210905100914.33007-1-hengqi.chen@gmail.com>
References: <20210905100914.33007-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test BPF map creation using BTF-defined key/value. The test defines
some specialized maps by specifying BTF types for key/value and
checks those maps are correctly initialized and loaded.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 .../selftests/bpf/prog_tests/map_create.c     |  87 ++++++++++++++
 .../selftests/bpf/progs/test_map_create.c     | 110 ++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_create.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_create.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_create.c b/tools/testing/selftests/bpf/prog_tests/map_create.c
new file mode 100644
index 000000000000..6ca32d0dffd2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_create.c
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include <test_progs.h>
+#include "test_map_create.skel.h"
+
+void test_map_create(void)
+{
+	struct test_map_create *skel;
+	int err, fd;
+
+	skel = test_map_create__open();
+	if (!ASSERT_OK_PTR(skel, "test_map_create__open failed"))
+		return;
+
+	err = test_map_create__load(skel);
+	if (!ASSERT_OK(err, "test_map_create__load failed"))
+		goto cleanup;
+
+	fd = bpf_map__fd(skel->maps.map1);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+	fd = bpf_map__fd(skel->maps.map2);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+	fd = bpf_map__fd(skel->maps.map3);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+	fd = bpf_map__fd(skel->maps.map4);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+	fd = bpf_map__fd(skel->maps.map5);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+	fd = bpf_map__fd(skel->maps.map6);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+	fd = bpf_map__fd(skel->maps.map7);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+	fd = bpf_map__fd(skel->maps.map8);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+	fd = bpf_map__fd(skel->maps.map9);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+	fd = bpf_map__fd(skel->maps.map10);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+	fd = bpf_map__fd(skel->maps.map11);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+	fd = bpf_map__fd(skel->maps.map12);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+	fd = bpf_map__fd(skel->maps.map13);
+	if (!ASSERT_GT(fd, 0, "bpf_map__fd failed"))
+		goto cleanup;
+	close(fd);
+
+cleanup:
+	test_map_create__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_map_create.c b/tools/testing/selftests/bpf/progs/test_map_create.c
new file mode 100644
index 000000000000..2e9950e56b0f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_map_create.c
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 Hengqi Chen */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+#define MAX_ENTRIES	8
+
+struct {
+	__uint(type,BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, int);
+	__type(value, int);
+} map1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, int);
+	__type(value, __u64);
+} map2 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CGROUP_ARRAY);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, int);
+	__type(value, int);
+} map3 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_ARRAY);
+		__uint(max_entries, 1);
+		__type(key, __u32);
+		__type(value, __u32);
+	});
+} map4 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, int);
+	__type(value, int);
+	__array(values, struct {
+		__uint(type, BPF_MAP_TYPE_ARRAY);
+		__uint(max_entries, 1);
+		__type(key, __u32);
+		__type(value, __u32);
+	});
+} map5 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, int);
+	__type(value, int);
+} map6 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, int);
+	__type(value, int);
+} map7 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_CPUMAP);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, int);
+	__type(value, int);
+} map8 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_XSKMAP);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, int);
+	__type(value, int);
+} map9 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, int);
+	__type(value, int);
+} map10 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(value, int);
+} map11 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(value, int);
+} map12 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
+	__uint(max_entries, MAX_ENTRIES);
+	__type(key, int);
+	__type(value, int);
+} map13 SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
-- 
2.25.1

