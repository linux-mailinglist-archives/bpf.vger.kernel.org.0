Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9525E357C3B
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 08:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhDHGO2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 02:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhDHGOZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 02:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617862454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ue1WJN9VVLFtg4vxqXBhw+4/lkwt4siu2NvJcjrHRVw=;
        b=GPZFhdx4xt0YjrDtvi5piq8dCUkffv/4b5gGmqfG5NC3+bqhAf4POuW5VRWAxhUnkuvoWs
        1Kpnw4aKkIJodw6K9dqitFdlKEw+Yiw40HBgl43yq/5PO6nwM8WULySTSyxOtbyTwujoLy
        tjOWKaaksmXratay3rmnQxfGBzwZhqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-niffexRxN4Cg581WxUPLoQ-1; Thu, 08 Apr 2021 02:14:12 -0400
X-MC-Unique: niffexRxN4Cg581WxUPLoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F49283DD20;
        Thu,  8 Apr 2021 06:14:11 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74E3C7A395;
        Thu,  8 Apr 2021 06:13:17 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v4 2/9] selftests/bpf: test_progs/sockopt_sk: Convert to use BPF skeleton
Date:   Thu,  8 Apr 2021 09:13:03 +0300
Message-Id: <20210408061310.95877-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
References: <20210408061238.95803-1-yauheni.kaliuta@redhat.com>
 <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

