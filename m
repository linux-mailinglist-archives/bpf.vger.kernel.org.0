Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994EB3504ED
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhCaQpq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 12:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232805AbhCaQpW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 12:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617209121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ue1WJN9VVLFtg4vxqXBhw+4/lkwt4siu2NvJcjrHRVw=;
        b=SPn0nqp+/5ndQpCLGpafDRGLY3PfQSzHGe+wapNlbYGDnRt1E9Puu214DoLo8Zk1YXFI07
        mORbArXYkGjPi6ZhLhjme9TG+AS2n0QqNCK0MNIyQf1PGPmLmpaRlv8hRHkqtoCZkL3z5k
        1o+w6M0VROdfQ8BC5bDxn2B+k6tNW84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-724S6QzSNQi_ZK9sqV5fJQ-1; Wed, 31 Mar 2021 12:45:19 -0400
X-MC-Unique: 724S6QzSNQi_ZK9sqV5fJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1DA710082EC;
        Wed, 31 Mar 2021 16:45:18 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-48.ams2.redhat.com [10.36.114.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A360516922;
        Wed, 31 Mar 2021 16:45:17 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v3 2/8] selftests/bpf: test_progs/sockopt_sk: Convert to use BPF skeleton
Date:   Wed, 31 Mar 2021 19:44:58 +0300
Message-Id: <20210331164504.320614-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210331164504.320614-1-yauheni.kaliuta@redhat.com>
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
 <20210331164504.320614-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch the test to use BPF skeleton to save some boilerplate and
make it easy to access bpf program bss segment.

The latter will be used to pass PAGE_SIZE from userspace since there
is no convenient way for bpf program to get it from inside of the
kernel.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 65 +++++--------------
 1 file changed, 17 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index d5b44b135c00..7274b12abe17 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -3,6 +3,7 @@
 #include "cgroup_helpers.h"
 
 #include <linux/tcp.h>
+#include "sockopt_sk.skel.h"
 
 #ifndef SOL_TCP
 #define SOL_TCP IPPROTO_TCP
@@ -191,60 +192,28 @@ static int getsetsockopt(void)
 	return -1;
 }
 
-static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char *title)
-{
-	enum bpf_attach_type attach_type;
-	enum bpf_prog_type prog_type;
-	struct bpf_program *prog;
-	int err;
-
-	err = libbpf_prog_type_by_name(title, &prog_type, &attach_type);
-	if (err) {
-		log_err("Failed to deduct types for %s BPF program", title);
-		return -1;
-	}
-
-	prog = bpf_object__find_program_by_title(obj, title);
-	if (!prog) {
-		log_err("Failed to find %s BPF program", title);
-		return -1;
-	}
-
-	err = bpf_prog_attach(bpf_program__fd(prog), cgroup_fd,
-			      attach_type, 0);
-	if (err) {
-		log_err("Failed to attach %s BPF program", title);
-		return -1;
-	}
-
-	return 0;
-}
-
 static void run_test(int cgroup_fd)
 {
-	struct bpf_prog_load_attr attr = {
-		.file = "./sockopt_sk.o",
-	};
-	struct bpf_object *obj;
-	int ignored;
-	int err;
-
-	err = bpf_prog_load_xattr(&attr, &obj, &ignored);
-	if (CHECK_FAIL(err))
-		return;
+	struct sockopt_sk *skel;
+
+	skel = sockopt_sk__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		goto cleanup;
 
-	err = prog_attach(obj, cgroup_fd, "cgroup/getsockopt");
-	if (CHECK_FAIL(err))
-		goto close_bpf_object;
+	skel->links._setsockopt =
+		bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._setsockopt, "setsockopt_link"))
+		goto cleanup;
 
-	err = prog_attach(obj, cgroup_fd, "cgroup/setsockopt");
-	if (CHECK_FAIL(err))
-		goto close_bpf_object;
+	skel->links._getsockopt =
+		bpf_program__attach_cgroup(skel->progs._getsockopt, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links._getsockopt, "getsockopt_link"))
+		goto cleanup;
 
-	CHECK_FAIL(getsetsockopt());
+	ASSERT_OK(getsetsockopt(), "getsetsockopt");
 
-close_bpf_object:
-	bpf_object__close(obj);
+cleanup:
+	sockopt_sk__destroy(skel);
 }
 
 void test_sockopt_sk(void)
-- 
2.31.1

