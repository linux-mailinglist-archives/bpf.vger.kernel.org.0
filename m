Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6D62160B3
	for <lists+bpf@lfdr.de>; Mon,  6 Jul 2020 22:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgGFUyS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 16:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGFUyP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 16:54:15 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2F4C061794
        for <bpf@vger.kernel.org>; Mon,  6 Jul 2020 13:54:15 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id r12so26925282ilh.4
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2020 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rojhnEPQhTCu/0boOncEU/iB2GL3sfTwVGQ87+2hOJ8=;
        b=R8ReUeJgWN//Na5afWrzzCSmA0QA34PoDHi8FhQiU6yUp2x6IUcC7l6IX5TDAP5lOv
         VjWCIJPxz7FFc5RYmprjJNitsA3SNBgFmAp6JHkVws9ofAWC5BkHBp4Ps3kPYhLn2WU7
         +spRmDGO7tGx27BlKR+xRkRb/zwI7uwn2bTrDi45+STvRwMYw82IIT8cKzx6G3v5oztT
         mS1JHmbgi/hERazLMp2zFJMLov356laiBosEGtoKsE9a0B5WaNnJW8eu18aLpG1BeBtA
         JwAX6eoWIbNK/OBsXblMjOqUsO2DRNJvvboOY9F+aALJTHq2RR6YmkMnoDj8Yu7c8DSZ
         /Pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rojhnEPQhTCu/0boOncEU/iB2GL3sfTwVGQ87+2hOJ8=;
        b=boMhmcVQsrG5zniJZkqliBmgA+NIZp9nl6XeA8LqPq1ne/vpR2z0NVydast1SwSwTd
         RuHgzZSXkXdr+mBiDWxYgUIoEGNJCTnublK/wNabGvxB3vexrra1V9yCorwxrYerquh7
         y9hFJlyz2688dpFCcQEO/hjrqCBvyR1UpELa6u4pIG3SUZ+sZrz8HDzftHArWmfjQkSc
         TyxEVhovs4YEkd8N3BFRHOyC8/iEEsvBPyGrBfUyZq0HvCDjgat60loeIrbIgLsDI+F6
         oCkAAo1FGwJCn5oYZktezAdL206HhknEEBLhaWMmRdVcznhJMGqy5FLbqkAovATKqY9G
         hkTg==
X-Gm-Message-State: AOAM532CZ6ixECbBawoZyzfuSZp4rFAatcmDRVajyw+plnU4JGrhcXvj
        VMWmhFko4oaZ1LA9rippo43D7vsI90A=
X-Google-Smtp-Source: ABdhPJzMywMgfyVfS7hMikvV/q+jb5Z9ohiyQen71MJzb6JaG9ajqLjcYFDjUvEwhYPg3YHOMtF+Yg==
X-Received: by 2002:a05:6e02:8b4:: with SMTP id a20mr31963413ilt.254.1594068854653;
        Mon, 06 Jul 2020 13:54:14 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id r124sm10744198iod.40.2020.07.06.13.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:54:14 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>, YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 4/5] selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress
Date:   Mon,  6 Jul 2020 15:51:21 -0500
Message-Id: <78ebd486140d06d70e64a23bc5d30d2e9a02a997.1594065127.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594065127.git.zhuyifei@google.com>
References: <cover.1594065127.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

This mirrors the original egress-only test. The cgroup_storage is
now extended to have two packet counters, one for egress and one
for ingress. The behavior of the counters are exactly the same as
the original egress-only test, only that the total number of
invocations doubles from having both egress and ingress being
counted.

The field attach_type in the map key is ignored in the kernel;
however, keeping it is pointless here and we are demonstrating the
expected usage of the map, so it is removed. That said, keeping the
field will not fail the test, for backwards compatibility reasons.
In other words, the original egress-only test is not affected by
the change in CGROUP_STORAGE behavior and will pass in both cases.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../bpf/prog_tests/cg_storage_multi.c         | 77 +++++++++++++++++--
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 6738b18835d5..1b973ac56357 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -26,7 +26,6 @@ static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
 	map_fd = bpf_map__fd(map);
 
 	key.cgroup_inode_id = get_cgroup_id(cgroup_path);
-	key.attach_type = BPF_CGROUP_INET_EGRESS;
 	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value) < 0))
 		return true;
 	if (CHECK_FAIL(memcmp(&value, expected, sizeof(struct cgroup_value))))
@@ -44,7 +43,6 @@ static bool assert_storage_noexist(struct bpf_map *map, const char *cgroup_path)
 	map_fd = bpf_map__fd(map);
 
 	key.cgroup_inode_id = get_cgroup_id(cgroup_path);
-	key.attach_type = BPF_CGROUP_INET_EGRESS;
 	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &key, &value) == 0))
 		return true;
 	if (CHECK_FAIL(errno != ENOENT))
@@ -147,16 +145,83 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 static void test_egress_ingress(int parent_cgroup_fd, int child_cgroup_fd)
 {
 	struct cg_storage_multi_egress_ingress *obj;
+	struct cgroup_value expected_cgroup_value;
+	int err;
 
 	if (!test__start_subtest("egress_ingress"))
 		return;
 
-	/* Cannot load both programs due to verifier failure:
-	 * "only one cgroup storage of each type is allowed"
-	 */
 	obj = cg_storage_multi_egress_ingress__open_and_load();
-	if (CHECK_FAIL(obj || errno != EBUSY))
+	if (CHECK_FAIL(!obj))
 		return;
+
+	/* Attach to parent cgroup, trigger packet from child.
+	 * Assert that there is two runs, one with parent cgroup egress and
+	 * one with parent cgroup ingress.
+	 * Also assert that child cgroup's storage does not exist
+	 */
+	err = bpf_prog_attach(bpf_program__fd(obj->progs.egress),
+			      parent_cgroup_fd,
+			      BPF_CGROUP_INET_EGRESS, BPF_F_ALLOW_MULTI);
+	if (CHECK_FAIL(err))
+		goto close_bpf_object;
+	err = bpf_prog_attach(bpf_program__fd(obj->progs.ingress),
+			      parent_cgroup_fd,
+			      BPF_CGROUP_INET_INGRESS, BPF_F_ALLOW_MULTI);
+	if (CHECK_FAIL(err))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK_FAIL(err))
+		goto close_bpf_object;
+	if (CHECK_FAIL(obj->bss->invocations != 2))
+		goto close_bpf_object;
+	expected_cgroup_value = (struct cgroup_value) {
+		.egress_pkts = 1,
+		.ingress_pkts = 1,
+	};
+	if (CHECK_FAIL(assert_storage(obj->maps.cgroup_storage,
+				      PARENT_CGROUP, &expected_cgroup_value)))
+		goto close_bpf_object;
+	if (CHECK_FAIL(assert_storage_noexist(obj->maps.cgroup_storage,
+					      CHILD_CGROUP)))
+		goto close_bpf_object;
+
+	/* Attach to parent and child cgroup, trigger packet from child.
+	 * Assert that there is four additional runs, parent cgroup egress and
+	 * ingress, child cgroup egress and ingress.
+	 */
+	err = bpf_prog_attach(bpf_program__fd(obj->progs.egress),
+			      child_cgroup_fd,
+			      BPF_CGROUP_INET_EGRESS, BPF_F_ALLOW_MULTI);
+	if (CHECK_FAIL(err))
+		goto close_bpf_object;
+	err = bpf_prog_attach(bpf_program__fd(obj->progs.ingress),
+			      child_cgroup_fd,
+			      BPF_CGROUP_INET_INGRESS, BPF_F_ALLOW_MULTI);
+	if (CHECK_FAIL(err))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK_FAIL(err))
+		goto close_bpf_object;
+	if (CHECK_FAIL(obj->bss->invocations != 6))
+		goto close_bpf_object;
+	expected_cgroup_value = (struct cgroup_value) {
+		.egress_pkts = 2,
+		.ingress_pkts = 2,
+	};
+	if (CHECK_FAIL(assert_storage(obj->maps.cgroup_storage,
+				      PARENT_CGROUP, &expected_cgroup_value)))
+		goto close_bpf_object;
+	expected_cgroup_value = (struct cgroup_value) {
+		.egress_pkts = 1,
+		.ingress_pkts = 1,
+	};
+	if (CHECK_FAIL(assert_storage(obj->maps.cgroup_storage,
+				      CHILD_CGROUP, &expected_cgroup_value)))
+		goto close_bpf_object;
+
+close_bpf_object:
+	cg_storage_multi_egress_ingress__destroy(obj);
 }
 
 void test_cg_storage_multi(void)
-- 
2.27.0

