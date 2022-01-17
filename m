Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB8D4909FF
	for <lists+bpf@lfdr.de>; Mon, 17 Jan 2022 15:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiAQOI0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Jan 2022 09:08:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230445AbiAQOI0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Jan 2022 09:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642428505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wkCYchSMuUOmtyeTT3Zz6bJxZRZtIoKHl9Dc6+V27ng=;
        b=FgHmSyi02zgNIaxKVVtITQhknRDdlEz0kUHCBKmt99FRPUmnq8PaMXwVfSJQw79Qv3lHGP
        YgCuwAKEATpbsnzLh0VDXNZm0ogx8+DjzZ6k2K9HzwElklppL67dT1YdVyC8AeyXIDckGz
        d2ZImg3q5dLcfd4KKxRXu2E7jU9VaAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-17bYCHA0PXKShv9fflHigg-1; Mon, 17 Jan 2022 09:08:19 -0500
X-MC-Unique: 17bYCHA0PXKShv9fflHigg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A77A3E768;
        Mon, 17 Jan 2022 14:08:17 +0000 (UTC)
Received: from thinkpad.fritz.box (unknown [10.40.194.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62F0A7B6E0;
        Mon, 17 Jan 2022 14:08:16 +0000 (UTC)
From:   Felix Maurer <fmaurer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     sdf@google.com, kafai@fb.com, ast@kernel.org
Subject: [PATCH bpf] selftests: bpf: Fix bind on used port
Date:   Mon, 17 Jan 2022 15:07:28 +0100
Message-Id: <20220117140728.167736-1-fmaurer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bind_perm BPF selftest failed when port 111/tcp was already in use
during the test. To fix this, the test now runs in its own network name
space.

To use unshare, it is necessary to reorder the includes. The style of
the includes is adapted to be consistent with the other prog_tests.

Fixes: 8259fdeb30326 ("selftests/bpf: Verify that rebinding to port < 1024 from BPF works")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 .../selftests/bpf/prog_tests/bind_perm.c      | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bind_perm.c b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
index d0f06e40c16d..cbd739d36e4d 100644
--- a/tools/testing/selftests/bpf/prog_tests/bind_perm.c
+++ b/tools/testing/selftests/bpf/prog_tests/bind_perm.c
@@ -1,13 +1,26 @@
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
+	if (CHECK(unshare(CLONE_NEWNET), "create netns",
+		  "unshare(CLONE_NEWNET): %s (%d)",
+		  strerror(errno), errno))
+		return -1;
+
+	return 0;
+}
+
 void try_bind(int family, int port, int expected_errno)
 {
 	struct sockaddr_storage addr = {};
@@ -75,6 +88,9 @@ void test_bind_perm(void)
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

