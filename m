Return-Path: <bpf+bounces-28070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB808B5668
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 13:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B76284306
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E703FBA3;
	Mon, 29 Apr 2024 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkhVGYso"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E521EB2F
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389810; cv=none; b=Mupmn8h4ywjeoE2QnBeBs3kXU7UIUQI6TQqWWI0O+FwIT78C1xuUPoUnxJDQF+xi4P0uwHdVzwYy5Zf0kxmSwBlWKrWXw+IH+5TVvmG9mmpYwPACES6CG7lNBLcJCF12h6crjDx/3z3gnYHLRmZy1MQztkOG8x1Eru4QIqmi7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389810; c=relaxed/simple;
	bh=DOO/x+ElfZcg14znsQ1I1SUoCY5cGqBNUU3ut6iCKtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxqB7T0Q/q6oxQSHyfbzqS8lfrx3cFdFWuNCLhRGj7Vgvj3PmtP8BjyC/h1w43zek0M0HzRODwEAk1a1ESkGXS7Cz30KOLzoPeEAtaj64zQVEYbPelyopq6BZgtZl6qsCmypdFaMayMJoE8XVrPQNAN6CLSoaqaKQsxuXGT9aLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkhVGYso; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714389808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mgUfFtWeaD7JM7Lr7x8FqVNSJqKWyHZuKFgKUMV13c0=;
	b=dkhVGYsomZf/KnE3cWDBAEYJHFjKxTZR5bwZs1mRUCs9eOa2YdLvOggKKYjUDOulKzCzPP
	ZB4rraVPuZPwlM8C7CVYR97gNurE68Z0fwLR0/DVEmqaXyTNyKemVb+FXzjUbiImK0Q93z
	SsOX3m1YKR+IV/EVS40cjtELPTzIDSg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-93Ua6bYuPXuZrZxJ_-6T-Q-1; Mon,
 29 Apr 2024 07:23:21 -0400
X-MC-Unique: 93Ua6bYuPXuZrZxJ_-6T-Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52E333C025D0;
	Mon, 29 Apr 2024 11:23:19 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.84])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DB7240BB4E;
	Mon, 29 Apr 2024 11:23:14 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next] selftests/bpf: run cgroup1_hierarchy test in own mount namespace
Date: Mon, 29 Apr 2024 13:23:11 +0200
Message-ID: <20240429112311.402497-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The cgroup1_hierarchy test uses setup_classid_environment to setup
cgroupv1 environment. The problem is that the environment is set in
/sys/fs/cgroup and therefore, if not run under an own mount namespace,
effectively deletes all system cgroups:

    $ ls /sys/fs/cgroup | wc -l
    27
    $ sudo ./test_progs -t cgroup1_hierarchy
    #41/1    cgroup1_hierarchy/test_cgroup1_hierarchy:OK
    #41/2    cgroup1_hierarchy/test_root_cgid:OK
    #41/3    cgroup1_hierarchy/test_invalid_level:OK
    #41/4    cgroup1_hierarchy/test_invalid_cgid:OK
    #41/5    cgroup1_hierarchy/test_invalid_hid:OK
    #41/6    cgroup1_hierarchy/test_invalid_cgrp_name:OK
    #41/7    cgroup1_hierarchy/test_invalid_cgrp_name2:OK
    #41/8    cgroup1_hierarchy/test_sleepable_prog:OK
    #41      cgroup1_hierarchy:OK
    Summary: 1/8 PASSED, 0 SKIPPED, 0 FAILED
    $ ls /sys/fs/cgroup | wc -l
    1

To avoid this, run setup_cgroup_environment first which will create an
own mount namespace. This only affects the cgroupv1_hierarchy test as
all other cgroup1 test progs already run setup_cgroup_environment prior
to running setup_classid_environment.

Also add a comment to the header of setup_classid_environment to warn
against this invalid usage in future.

Fixes: 360769233cc9 ("selftests/bpf: Add selftests for cgroup1 hierarchy")
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c               | 3 +++
 tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index f2952a65dcc2..23bb9a9e6a7d 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -508,6 +508,9 @@ int cgroup_setup_and_join(const char *path) {
 /**
  * setup_classid_environment() - Setup the cgroupv1 net_cls environment
  *
+ * This function should only be called in a custom mount namespace, e.g.
+ * created by running setup_cgroup_environment.
+ *
  * After calling this function, cleanup_classid_environment should be called
  * once testing is complete.
  *
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c b/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
index 74d6d7546f40..25332e596750 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup1_hierarchy.c
@@ -87,9 +87,12 @@ void test_cgroup1_hierarchy(void)
 		goto destroy;
 
 	/* Setup cgroup1 hierarchy */
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		goto destroy;
 	err = setup_classid_environment();
 	if (!ASSERT_OK(err, "setup_classid_environment"))
-		goto destroy;
+		goto cleanup_cgroup;
 
 	err = join_classid();
 	if (!ASSERT_OK(err, "join_cgroup1"))
@@ -153,6 +156,8 @@ void test_cgroup1_hierarchy(void)
 
 cleanup:
 	cleanup_classid_environment();
+cleanup_cgroup:
+	cleanup_cgroup_environment();
 destroy:
 	test_cgroup1_hierarchy__destroy(skel);
 }
-- 
2.44.0


