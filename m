Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0592115AF
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 00:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgGAWOU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 18:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgGAWOU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 18:14:20 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ACCC08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 15:14:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so13079245iob.4
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 15:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kAufCfJ43mLIic7FHAN55qDLK+gVYEIQwToTqpIXUp8=;
        b=I7Ly6pWt6Z8DMetFrlmpKMEFPDepa3VmhoqWNIXW7HidB02AuD4rZQPsnzfKVCQ9Ms
         P+EmNoLe1i4Q9/RU0+nlSo835wGwWgVEZpdbibdoXteXij8tpo9YxQ/JuVeHeqBEZSBF
         rhCpQB3jahp0X9xcJqZTUyUMNCbQfYkyokOnqsMC9gNwUKRn6fJ7LBRfoel1koOt2YNL
         RU2iC4y6/yF0d2AIshYxDy2N7Vr6yR+5Nj/WFmEbmWDhFoX6CxwrDLpUzn00CsaRwKkB
         nGSdafSzmiIgXHtUC1A5laq7wLJPGW6x8XbiN+7UNddD2yACtnH60/V6Dg6KDjaGGC7/
         IWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kAufCfJ43mLIic7FHAN55qDLK+gVYEIQwToTqpIXUp8=;
        b=QTR41jLPswtzcodGIhElVUTLM/GTUsrWMWlbo9s2d6ocWTFJyUWg9sTvhHZNiF7iri
         uYKEXS6GymtBGqeEZtZFLk9lvpkwWNEEUDhfwpu5odsvuMlDdLw1uvTVPJ1tYvxxEx+S
         QX/cLfXGuBrmmAghpDVFh8lBcb5fTkn7v2tsvIu8ji5UFl+j7SIiNnHnYGqn9jgYL66u
         TpiBozzMvYDL+8UqA4sZ72stiXzgJmY6ouh9vuKP29kiLgGkzmGpb5spSBctLz5jcQUF
         q/UtFsMo7dS8JWKK/5px0kcuIhtz2iGVcwrjRTsQdu0RrAMveXlnwOqpgD3CIPD2IgII
         d5bw==
X-Gm-Message-State: AOAM533QchlS+FaGop9dJiu8mZ/9RXIv6TWhwfpN2x+9P0DkmO4CNnG+
        8op5xThXy3lthek+8pI+xPpJUBG3ZT9UHg==
X-Google-Smtp-Source: ABdhPJwjzxxdpZH43zQLbth733misN+0K6LH1Q59nUV63Th537pQoG0GJpGHW1WZ7vwgbj/iJmqXGg==
X-Received: by 2002:a6b:7107:: with SMTP id q7mr4381587iog.86.1593641659184;
        Wed, 01 Jul 2020 15:14:19 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id t83sm4051543ilb.47.2020.07.01.15.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 15:14:18 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>, YiFei Zhu <zhuyifei@google.com>
Subject: [RFC PATCH bpf-next 4/5] selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress
Date:   Wed,  1 Jul 2020 17:13:57 -0500
Message-Id: <a81fb721c7e653130399ec52ee7cda7bdefddc2b.1593638618.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593638618.git.zhuyifei@google.com>
References: <cover.1593638618.git.zhuyifei@google.com>
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
index 140fb42929b5..0047dd485104 100644
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

