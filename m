Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F6B492979
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 16:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbiARPOC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 10:14:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344977AbiARPOB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Jan 2022 10:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642518841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SBWXHV4rq5C+Zy00MCJDNgodxABjxEMEpY21t6DRkbE=;
        b=UJpmnqrNqPn6kKCkcP/56JzpDmYJlcNjac4k8c5i3eqmXF/ajkyPB7WO4eAiq/wTFreWS3
        PObhYq6WAN6aeSe98kfMd0LnHPcu71IZUEcePk36aIMApAj+wFeEzynVC4ufqql0ebAlrx
        a1X6WejLfm3ad+5NisM/jBaVvEdlEYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-NpUe5zWFMb-EoZ1KCMUlSw-1; Tue, 18 Jan 2022 10:13:55 -0500
X-MC-Unique: NpUe5zWFMb-EoZ1KCMUlSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7181F1868336;
        Tue, 18 Jan 2022 15:12:52 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.40.194.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C47915CE80;
        Tue, 18 Jan 2022 15:12:50 +0000 (UTC)
From:   Felix Maurer <fmaurer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     sdf@google.com, kafai@fb.com, ast@kernel.org, jakub@cloudflare.com
Subject: [PATCH bpf v2] selftests: bpf: Fix bind on used port
Date:   Tue, 18 Jan 2022 16:11:56 +0100
Message-Id: <551ee65533bb987a43f93d88eaf2368b416ccd32.1642518457.git.fmaurer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bind_perm BPF selftest failed when port 111/tcp was already in use
during the test. To fix this, the test now runs in its own network name
space.

To use unshare, it is necessary to reorder the includes. The style of
the includes is adapted to be consistent with the other prog_tests.

v2: Replace deprecated CHECK macro with ASSERT_OK

Fixes: 8259fdeb30326 ("selftests/bpf: Verify that rebinding to port < 1024 from BPF works")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 .../selftests/bpf/prog_tests/bind_perm.c      | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bind_perm.c b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
index d0f06e40c16d..eac71fbb24ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/bind_perm.c
+++ b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
@@ -1,13 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <test_progs.h>
-#include "bind_perm.skel.h"
-
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdlib.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/capability.h>
 
+#include "test_progs.h"
+#include "bind_perm.skel.h"
+
 static int duration;
 
+static int create_netns(void)
+{
+	if (!ASSERT_OK(unshare(CLONE_NEWNET), "create netns"))
+		return -1;
+
+	return 0;
+}
+
 void try_bind(int family, int port, int expected_errno)
 {
 	struct sockaddr_storage addr = {};
@@ -75,6 +86,9 @@ void test_bind_perm(void)
 	struct bind_perm *skel;
 	int cgroup_fd;
 
+	if (create_netns())
+		return;
+
 	cgroup_fd = test__join_cgroup("/bind_perm");
 	if (CHECK(cgroup_fd < 0, "cg-join", "errno %d", errno))
 		return;
-- 
2.34.1

