Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8FD34A71A
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhCZMZM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 08:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229882AbhCZMYo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 08:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616761483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SAwTQ0VaCubvF8+lJjw41zWb458iCBIQT7bnPFJm/IU=;
        b=RutPa1h09NfJ5JXDHYUrNFYAQ7rLdYbZXMochfm+JIpH1b4wENdFTGZ217AesIzqH37683
        xiYuywy8lcMi+3W6aGYYllZNJMsVeA50PKK6Z8RIBGaYWAu1qFC8gBzrlczcgmX3QLhY1m
        5q5zY1AIujGGFHFdfw2SVReZ2+YH3wE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-f6zYn7x7M46R9ZbR8bhPuA-1; Fri, 26 Mar 2021 08:24:41 -0400
X-MC-Unique: f6zYn7x7M46R9ZbR8bhPuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D387294DCA;
        Fri, 26 Mar 2021 12:24:40 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-130.ams2.redhat.com [10.36.114.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E1935D9E3;
        Fri, 26 Mar 2021 12:24:39 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH v2 1/4] selftests/bpf: test_progs/sockopt_sk: Convert to use BPF skeleton
Date:   Fri, 26 Mar 2021 14:24:35 +0200
Message-Id: <20210326122438.211242-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 72 ++++++-------------
 1 file changed, 23 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index d5b44b135c00..114c1a622ffa 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -3,6 +3,7 @@
 #include "cgroup_helpers.h"
 
 #include <linux/tcp.h>
+#include "sockopt_sk.skel.h"
 
 #ifndef SOL_TCP
 #define SOL_TCP IPPROTO_TCP
@@ -191,60 +192,33 @@ static int getsetsockopt(void)
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
-
-	err = prog_attach(obj, cgroup_fd, "cgroup/getsockopt");
-	if (CHECK_FAIL(err))
-		goto close_bpf_object;
-
-	err = prog_attach(obj, cgroup_fd, "cgroup/setsockopt");
-	if (CHECK_FAIL(err))
-		goto close_bpf_object;
+	struct sockopt_sk *skel;
+	int duration = 0;
+
+	skel = sockopt_sk__open_and_load();
+	if (CHECK(!skel, "skel_load", "sockopt_sk skeleton failed\n"))
+		goto cleanup;
+
+	skel->links._setsockopt =
+		bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
+	if (CHECK(IS_ERR(skel->links._setsockopt),
+			 "setsockopt_attach", "err: %ld\n",
+			 PTR_ERR(skel->links._setsockopt)))
+		goto cleanup;
+
+	skel->links._getsockopt =
+		bpf_program__attach_cgroup(skel->progs._getsockopt, cgroup_fd);
+	if (CHECK(IS_ERR(skel->links._getsockopt),
+			 "getsockopt_attach", "err: %ld\n",
+			 PTR_ERR(skel->links._getsockopt)))
+		goto cleanup;
 
 	CHECK_FAIL(getsetsockopt());
 
-close_bpf_object:
-	bpf_object__close(obj);
+cleanup:
+	sockopt_sk__destroy(skel);
 }
 
 void test_sockopt_sk(void)
-- 
2.29.2

