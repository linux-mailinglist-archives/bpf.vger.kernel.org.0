Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA2B21AB00
	for <lists+bpf@lfdr.de>; Fri, 10 Jul 2020 00:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGIWzO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jul 2020 18:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgGIWzN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 18:55:13 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95DDC08C5DC
        for <bpf@vger.kernel.org>; Thu,  9 Jul 2020 15:55:13 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so4100439iob.4
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2020 15:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMjpMjNih1+jm3foEyZS3IDJgvYOqAdwPfkk24YvvLw=;
        b=AsxufSAEerBoMVsbXY1ZV6bwuRMBzghdOq88N3xe88pg+EDuGnATg6u3IA4vQlTiEP
         XafqDr0EkUK/b+R5SMC2n/6UMFbeouJ5hudn5OYhRWAC7QUyrHsFwXWcYcOX7kRv2+Ko
         aPfQhcowvv0ZStuPShWd2FjWpBMylqa1ivvJoDgR0/8RfEJzz7QaJIP9EkNEvpe5ddzv
         14ABHj0B6+Uk4gSkr9eCNy0uDSMzdvupXYgR0P+xR/zB8OIeSJfRRvcMcWqOdfi6kYvY
         ADqnKTRKvH3IVr0781P2uVSxhRkGUXPo1F3ZS/Ppv/0o3nbms0c/vFgjdRtXI+8eglZ4
         diCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMjpMjNih1+jm3foEyZS3IDJgvYOqAdwPfkk24YvvLw=;
        b=Ufv1I2hzEKUGB8XlLuApzcw/XGb04pU+4GSsmfUC/BigPZ4bCfbmAopipaGZ5AHwVj
         dgrpYKJmCga6qZPgLMP3AP/bhTAs7ngwQ2euldd84Ba7mAtKNTfNcCJjlGJdrQC5dwtu
         FRB6z381feYbfXYxX1QHsL2nj90nYuWsJlLl0NOGgXfOnsnP3uWUAxuWMAoWAhAgNb6f
         uL0qpA5z63WPRot+/8UCQDTTDhhWob+B1kTDHoDytHl6jAvrD39cDE7/cUBx04n8/58X
         E7PiCeOiLFhp/BbTEtjVnJXFWXaw4/jmCaobo+vgKqNxBT7t2W8SG/g9MM/eeKzbcKFM
         eqdw==
X-Gm-Message-State: AOAM5303uK0L3KYmBD5bSDpGGSlogE0WIxYp8HJLor50SQWaPs2EyKuk
        ag7jrJvJl29EPkN3j/MpqPlE8VTWoWB1vw==
X-Google-Smtp-Source: ABdhPJxtqnzKIT75aHfsyHZzGSVSQ1vt5xNQ3eP4Jj80IrL7VPwCtUQTdESQPbTqOkKsLSKU1zn8Ug==
X-Received: by 2002:a6b:ba8b:: with SMTP id k133mr44928106iof.204.1594335312921;
        Thu, 09 Jul 2020 15:55:12 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id q2sm2552416ilp.82.2020.07.09.15.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:55:12 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH v2 bpf-next 4/5] selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress
Date:   Thu,  9 Jul 2020 17:54:50 -0500
Message-Id: <4c369d3f1cdf16904922fcacf90fafb1cb8e4a70.1594333800.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594333800.git.zhuyifei@google.com>
References: <cover.1594333800.git.zhuyifei@google.com>
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
 .../bpf/prog_tests/cg_storage_multi.c         | 90 +++++++++++++++++--
 1 file changed, 83 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
index 1f4ab437ddb9..aa2b448c4214 100644
--- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
@@ -28,7 +28,6 @@ static bool assert_storage(struct bpf_map *map, const char *cgroup_path,
 	map_fd = bpf_map__fd(map);
 
 	key.cgroup_inode_id = get_cgroup_id(cgroup_path);
-	key.attach_type = BPF_CGROUP_INET_EGRESS;
 	if (CHECK(bpf_map_lookup_elem(map_fd, &key, &value) < 0,
 		  "map-lookup", "errno %d", errno))
 		return true;
@@ -48,7 +47,6 @@ static bool assert_storage_noexist(struct bpf_map *map, const char *cgroup_path)
 	map_fd = bpf_map__fd(map);
 
 	key.cgroup_inode_id = get_cgroup_id(cgroup_path);
-	key.attach_type = BPF_CGROUP_INET_EGRESS;
 	if (CHECK(bpf_map_lookup_elem(map_fd, &key, &value) == 0,
 		  "map-lookup", "succeeded, expected ENOENT"))
 		return true;
@@ -156,14 +154,92 @@ static void test_egress_only(int parent_cgroup_fd, int child_cgroup_fd)
 static void test_egress_ingress(int parent_cgroup_fd, int child_cgroup_fd)
 {
 	struct cg_storage_multi_egress_ingress *obj;
+	struct cgroup_value expected_cgroup_value;
+	struct bpf_link *parent_egress_link = NULL, *parent_ingress_link = NULL;
+	struct bpf_link *child_egress_link = NULL, *child_ingress_link = NULL;
+	bool err;
 
-	/* Cannot load both programs due to verifier failure:
-	 * "only one cgroup storage of each type is allowed"
-	 */
 	obj = cg_storage_multi_egress_ingress__open_and_load();
-	if (CHECK(obj || errno != EBUSY,
-		  "skel-load", "errno %d, expected EBUSY", errno))
+	if (CHECK(!obj, "skel-load", "errno %d", errno))
 		return;
+
+	/* Attach to parent cgroup, trigger packet from child.
+	 * Assert that there is two runs, one with parent cgroup egress and
+	 * one with parent cgroup ingress.
+	 * Also assert that child cgroup's storage does not exist
+	 */
+	parent_egress_link = bpf_program__attach_cgroup(obj->progs.egress,
+							parent_cgroup_fd);
+	if (CHECK(IS_ERR(parent_egress_link), "parent-egress-cg-attach",
+		  "err %ld", PTR_ERR(parent_egress_link)))
+		goto close_bpf_object;
+	parent_ingress_link = bpf_program__attach_cgroup(obj->progs.ingress,
+							 parent_cgroup_fd);
+	if (CHECK(IS_ERR(parent_ingress_link), "parent-ingress-cg-attach",
+		  "err %ld", PTR_ERR(parent_ingress_link)))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK(err, "first-connect-send", "errno %d", errno))
+		goto close_bpf_object;
+	if (CHECK(obj->bss->invocations != 2,
+		  "first-invoke", "invocations=%d", obj->bss->invocations))
+		goto close_bpf_object;
+	expected_cgroup_value = (struct cgroup_value) {
+		.egress_pkts = 1,
+		.ingress_pkts = 1,
+	};
+	if (assert_storage(obj->maps.cgroup_storage,
+			   PARENT_CGROUP, &expected_cgroup_value))
+		goto close_bpf_object;
+	if (assert_storage_noexist(obj->maps.cgroup_storage, CHILD_CGROUP))
+		goto close_bpf_object;
+
+	/* Attach to parent and child cgroup, trigger packet from child.
+	 * Assert that there is four additional runs, parent cgroup egress and
+	 * ingress, child cgroup egress and ingress.
+	 */
+	child_egress_link = bpf_program__attach_cgroup(obj->progs.egress,
+						       child_cgroup_fd);
+	if (CHECK(IS_ERR(child_egress_link), "child-egress-cg-attach",
+		  "err %ld", PTR_ERR(child_egress_link)))
+		goto close_bpf_object;
+	child_ingress_link = bpf_program__attach_cgroup(obj->progs.ingress,
+							child_cgroup_fd);
+	if (CHECK(IS_ERR(child_ingress_link), "child-ingress-cg-attach",
+		  "err %ld", PTR_ERR(child_ingress_link)))
+		goto close_bpf_object;
+	err = connect_send(CHILD_CGROUP);
+	if (CHECK(err, "second-connect-send", "errno %d", errno))
+		goto close_bpf_object;
+	if (CHECK(obj->bss->invocations != 6,
+		  "second-invoke", "invocations=%d", obj->bss->invocations))
+		goto close_bpf_object;
+	expected_cgroup_value = (struct cgroup_value) {
+		.egress_pkts = 2,
+		.ingress_pkts = 2,
+	};
+	if (assert_storage(obj->maps.cgroup_storage,
+			   PARENT_CGROUP, &expected_cgroup_value))
+		goto close_bpf_object;
+	expected_cgroup_value = (struct cgroup_value) {
+		.egress_pkts = 1,
+		.ingress_pkts = 1,
+	};
+	if (assert_storage(obj->maps.cgroup_storage,
+			   CHILD_CGROUP, &expected_cgroup_value))
+		goto close_bpf_object;
+
+close_bpf_object:
+	if (parent_egress_link)
+		bpf_link__destroy(parent_egress_link);
+	if (parent_ingress_link)
+		bpf_link__destroy(parent_ingress_link);
+	if (child_egress_link)
+		bpf_link__destroy(child_egress_link);
+	if (child_ingress_link)
+		bpf_link__destroy(child_ingress_link);
+
+	cg_storage_multi_egress_ingress__destroy(obj);
 }
 
 void test_cg_storage_multi(void)
-- 
2.27.0

