Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347FB222FDB
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 02:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgGQAQ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jul 2020 20:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgGQAQ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jul 2020 20:16:58 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF8FC061755
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 17:16:58 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so8321228iom.10
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMjpMjNih1+jm3foEyZS3IDJgvYOqAdwPfkk24YvvLw=;
        b=DPfaoOtRWDhk3QZz7krIsppQULeURrpQ715cxOAbla3BSfzrJDIAw7iAbOCGviDaK6
         MOE2ObOm5iJNHcNlE5vkZB1IURcGuGAWmBVOYZLILHNz2y+BH7d+WGDtnTUlaRCITVb7
         JSZnoTKHqYrJ3SSgRjo5HF32aet+Er95IYoPJxSM+gC3MrIFdW9vmle1PcXA21RCcu9X
         3m4TUweJjLA0gWi0c9Pct3ukoqPCexcdqtWYQEkbGKkqo+bq7pOJNAzceU9Qe/RQQt1f
         tM8Oqspo05w85/FTUMEFhjEUsnsRYW2mPl4obCWEuGoKyVXJQC8HJnrJNCbXt+lbANnk
         lxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMjpMjNih1+jm3foEyZS3IDJgvYOqAdwPfkk24YvvLw=;
        b=IelTz+MKctmp7WZBMn9HBvf3D1608e3MTyblfBm1bPPzRThofuyvtWLLaLRetNxwo8
         tnCjgivZ5WL7KlHpPxzYOUvMdTIHl2vc8Q/o9H+CkfMdsbW6qaEPPXH8BXjJtwPIFEo3
         0wUfN2kNYW/fLEvFTN4kKpCs0lwKmXop29LvQWu69y07IkHDUYSU6DLfpTh5Iaw7qnJC
         fqbc0GdhueTypQ0JV6nfUBSsa5ijAfmpnjnmgVkqVObSBeDEIhEx2jbTsYSNWw1Xk33l
         ggpOeA27hsoTQd2NlpFzaHJoi+OWVUz6+uQ/APFC0zOdmkJxUeQE3csp9bmE+DZh3Zli
         phMw==
X-Gm-Message-State: AOAM533dAtjFQC3xAKkPm7xuHb2Cg0YV17vhPHIv5ZQZvyowD4qqgDLC
        1mc7BEz1GUJe4f3d6s4QxGUbHNIDCjS61Q==
X-Google-Smtp-Source: ABdhPJwpxbbaRfmxqHVGHF5dzSsWTQKQI1niNbh8IhLcUzuno8XhA3i0OFauFDvxddsN803fCurmVw==
X-Received: by 2002:a5e:a60d:: with SMTP id q13mr6938760ioi.199.1594945016995;
        Thu, 16 Jul 2020 17:16:56 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id m5sm3427493ilg.18.2020.07.16.17.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 17:16:56 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH v3 bpf-next 4/5] selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress
Date:   Thu, 16 Jul 2020 19:16:28 -0500
Message-Id: <7d0c60e72a521cc5d2ba92a9e20dacc05c09d8cd.1594944827.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594944827.git.zhuyifei@google.com>
References: <cover.1594944827.git.zhuyifei@google.com>
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

