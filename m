Return-Path: <bpf+bounces-350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C72E6FF698
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23950280E73
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067ED63AB;
	Thu, 11 May 2023 15:57:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9739E206B5
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 15:57:53 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7D1BD
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 08:57:50 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5308f5d8ac9so122691a12.0
        for <bpf@vger.kernel.org>; Thu, 11 May 2023 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683820670; x=1686412670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QLxaN9ENLbeR+Q95KRBuvS8H3wRNyP3zT94cxQ7OMZI=;
        b=Q8lTIkGyCME7e4IOa/di8JvYkKHV8UMkuxxmWBYhHXoOWB/kOni6h6QadCIuu+aXLy
         oIViCgY1qSV4vP0Xc2ts+zZLmcIjHA/K1uXN0GL/RSxG5bCxFB2hEVjAceFaoh6uY6Mv
         Mk6AeFhHNzcPKDbNIlN9M5WcNeCqm8RN6hlpJe06Zldedu6nL7tAbktgfdSt5cHn1vkw
         Inaf4EAERvjvCWeFpk9yzSjxgrj5109bHwa8QVHmhbyOdU25xVGG1p4gWgGpf4jFO48R
         J6IvCia8/IbU/+qEyd5XbUXUr7DYm+moYCPCOVQVthsA1tavojbd5nzlBskBmViBMu1l
         U3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683820670; x=1686412670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLxaN9ENLbeR+Q95KRBuvS8H3wRNyP3zT94cxQ7OMZI=;
        b=MBchkD1M9PvkhEIDl91WRYpIO4un9rcMe4o9ZV2Jvg6GWL3HD9zAtMXNzI5MnXPi3n
         CQD0zsL2+ACgKnxUN2tcb8Xrnd+cb6DlKhXFRJ327p7nM/Ry8HIqflk5/aLIBo09z0R0
         CCX7ccB5elgp/noqiXlo7pTipy6PxkLtp9MM42kRBm9uuV8Fgbob8qpz4rs8KcxjGvJZ
         hNiXhFhsWBknmqaB305JS+8k6UIHVyq6WRM21ufwm/hchZ7kd9RFM1ySrcAbUW67RX6o
         PFdq5u7ovFFsHjPfvuvWUpT5taFwP2G+GPILoRhaIDZvdBg2zBslhCXO4BpxkDxsb0zL
         fZNA==
X-Gm-Message-State: AC+VfDyC17U/sBQ5r/3uAFlheMUF42eJ6S1zfSrJYdnMWyQsYNmdTZx8
	eSWdjKuVGv82nS9NnQp4KwzVpt8RPY4ut+LZlEw0HePQFlGiihkaQFPghmyF3V7dKumDZjK94U5
	pEsx3LKVXi297OjVU4GA3RLEy1soyk2yF80DE4Oh6qKqG26g02w==
X-Google-Smtp-Source: ACHHUZ5iGoYchCwe4UKJy5Sz8wzIp2TOfdcOJYbet/e/lJbXydqcdZC7FbJvuUKCrOPHVv6+CzBe8lM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:6b44:0:b0:50b:dda2:6140 with SMTP id
 g65-20020a636b44000000b0050bdda26140mr5953008pgc.11.1683820670023; Thu, 11
 May 2023 08:57:50 -0700 (PDT)
Date: Thu, 11 May 2023 08:57:39 -0700
In-Reply-To: <20230511155740.902548-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230511155740.902548-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511155740.902548-5-sdf@google.com>
Subject: [PATCH bpf-next v5 3/4] selftests/bpf: Correctly handle optlen > 4096
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Even though it's not relevant in selftests, the people
might still copy-paste from them. So let's take care
of optlen > 4096 cases explicitly.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../bpf/prog_tests/cgroup_getset_retval.c     |  20 ++++
 .../bpf/prog_tests/sockopt_inherit.c          |  59 +++-------
 .../selftests/bpf/prog_tests/sockopt_multi.c  | 108 +++++-------------
 .../bpf/prog_tests/sockopt_qos_to_cc.c        |   2 +
 .../progs/cgroup_getset_retval_getsockopt.c   |  13 +++
 .../progs/cgroup_getset_retval_setsockopt.c   |  17 +++
 .../selftests/bpf/progs/sockopt_inherit.c     |  18 ++-
 .../selftests/bpf/progs/sockopt_multi.c       |  26 ++++-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |  10 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  25 ++--
 10 files changed, 166 insertions(+), 132 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c b/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
index 4d2fa99273d8..2bb5773d6f99 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
@@ -25,6 +25,8 @@ static void test_setsockopt_set(int cgroup_fd, int sock_fd)
 	if (!ASSERT_OK_PTR(obj, "skel-load"))
 		return;
 
+	obj->bss->page_size = sysconf(_SC_PAGESIZE);
+
 	/* Attach setsockopt that sets EUNATCH, assert that
 	 * we actually get that error when we run setsockopt()
 	 */
@@ -59,6 +61,8 @@ static void test_setsockopt_set_and_get(int cgroup_fd, int sock_fd)
 	if (!ASSERT_OK_PTR(obj, "skel-load"))
 		return;
 
+	obj->bss->page_size = sysconf(_SC_PAGESIZE);
+
 	/* Attach setsockopt that sets EUNATCH, and one that gets the
 	 * previously set errno. Assert that we get the same errno back.
 	 */
@@ -100,6 +104,8 @@ static void test_setsockopt_default_zero(int cgroup_fd, int sock_fd)
 	if (!ASSERT_OK_PTR(obj, "skel-load"))
 		return;
 
+	obj->bss->page_size = sysconf(_SC_PAGESIZE);
+
 	/* Attach setsockopt that gets the previously set errno.
 	 * Assert that, without anything setting one, we get 0.
 	 */
@@ -134,6 +140,8 @@ static void test_setsockopt_default_zero_and_set(int cgroup_fd, int sock_fd)
 	if (!ASSERT_OK_PTR(obj, "skel-load"))
 		return;
 
+	obj->bss->page_size = sysconf(_SC_PAGESIZE);
+
 	/* Attach setsockopt that gets the previously set errno, and then
 	 * one that sets the errno to EUNATCH. Assert that the get does not
 	 * see EUNATCH set later, and does not prevent EUNATCH from being set.
@@ -177,6 +185,8 @@ static void test_setsockopt_override(int cgroup_fd, int sock_fd)
 	if (!ASSERT_OK_PTR(obj, "skel-load"))
 		return;
 
+	obj->bss->page_size = sysconf(_SC_PAGESIZE);
+
 	/* Attach setsockopt that sets EUNATCH, then one that sets EISCONN,
 	 * and then one that gets the exported errno. Assert both the syscall
 	 * and the helper sees the last set errno.
@@ -224,6 +234,8 @@ static void test_setsockopt_legacy_eperm(int cgroup_fd, int sock_fd)
 	if (!ASSERT_OK_PTR(obj, "skel-load"))
 		return;
 
+	obj->bss->page_size = sysconf(_SC_PAGESIZE);
+
 	/* Attach setsockopt that return a reject without setting errno
 	 * (legacy reject), and one that gets the errno. Assert that for
 	 * backward compatibility the syscall result in EPERM, and this
@@ -268,6 +280,8 @@ static void test_setsockopt_legacy_no_override(int cgroup_fd, int sock_fd)
 	if (!ASSERT_OK_PTR(obj, "skel-load"))
 		return;
 
+	obj->bss->page_size = sysconf(_SC_PAGESIZE);
+
 	/* Attach setsockopt that sets EUNATCH, then one that return a reject
 	 * without setting errno, and then one that gets the exported errno.
 	 * Assert both the syscall and the helper's errno are unaffected by
@@ -319,6 +333,8 @@ static void test_getsockopt_get(int cgroup_fd, int sock_fd)
 	if (!ASSERT_OK_PTR(obj, "skel-load"))
 		return;
 
+	obj->bss->page_size = sysconf(_SC_PAGESIZE);
+
 	/* Attach getsockopt that gets previously set errno. Assert that the
 	 * error from kernel is in both ctx_retval_value and retval_value.
 	 */
@@ -359,6 +375,8 @@ static void test_getsockopt_override(int cgroup_fd, int sock_fd)
 	if (!ASSERT_OK_PTR(obj, "skel-load"))
 		return;
 
+	obj->bss->page_size = sysconf(_SC_PAGESIZE);
+
 	/* Attach getsockopt that sets retval to -EISCONN. Assert that this
 	 * overrides the value from kernel.
 	 */
@@ -396,6 +414,8 @@ static void test_getsockopt_retval_sync(int cgroup_fd, int sock_fd)
 	if (!ASSERT_OK_PTR(obj, "skel-load"))
 		return;
 
+	obj->bss->page_size = sysconf(_SC_PAGESIZE);
+
 	/* Attach getsockopt that sets retval to -EISCONN, and one that clears
 	 * ctx retval. Assert that the clearing ctx retval is synced to helper
 	 * and clears any errors both from kernel and BPF..
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 60c17a8e2789..917f486db826 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -2,6 +2,8 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 
+#include "sockopt_inherit.skel.h"
+
 #define SOL_CUSTOM			0xdeadbeef
 #define CUSTOM_INHERIT1			0
 #define CUSTOM_INHERIT2			1
@@ -132,58 +134,30 @@ static int start_server(void)
 	return fd;
 }
 
-static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char *title,
-		       const char *prog_name)
-{
-	enum bpf_attach_type attach_type;
-	enum bpf_prog_type prog_type;
-	struct bpf_program *prog;
-	int err;
-
-	err = libbpf_prog_type_by_name(title, &prog_type, &attach_type);
-	if (err) {
-		log_err("Failed to deduct types for %s BPF program", prog_name);
-		return -1;
-	}
-
-	prog = bpf_object__find_program_by_name(obj, prog_name);
-	if (!prog) {
-		log_err("Failed to find %s BPF program", prog_name);
-		return -1;
-	}
-
-	err = bpf_prog_attach(bpf_program__fd(prog), cgroup_fd,
-			      attach_type, 0);
-	if (err) {
-		log_err("Failed to attach %s BPF program", prog_name);
-		return -1;
-	}
-
-	return 0;
-}
-
 static void run_test(int cgroup_fd)
 {
+	struct bpf_link *link_getsockopt = NULL;
+	struct bpf_link *link_setsockopt = NULL;
 	int server_fd = -1, client_fd;
-	struct bpf_object *obj;
+	struct sockopt_inherit *obj;
 	void *server_err;
 	pthread_t tid;
 	int err;
 
-	obj = bpf_object__open_file("sockopt_inherit.bpf.o", NULL);
-	if (!ASSERT_OK_PTR(obj, "obj_open"))
+	obj = sockopt_inherit__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
 		return;
 
-	err = bpf_object__load(obj);
-	if (!ASSERT_OK(err, "obj_load"))
-		goto close_bpf_object;
+	obj->bss->page_size = sysconf(_SC_PAGESIZE);
 
-	err = prog_attach(obj, cgroup_fd, "cgroup/getsockopt", "_getsockopt");
-	if (!ASSERT_OK(err, "prog_attach _getsockopt"))
+	link_getsockopt = bpf_program__attach_cgroup(obj->progs._getsockopt,
+						     cgroup_fd);
+	if (!ASSERT_OK_PTR(link_getsockopt, "cg-attach-getsockopt"))
 		goto close_bpf_object;
 
-	err = prog_attach(obj, cgroup_fd, "cgroup/setsockopt", "_setsockopt");
-	if (!ASSERT_OK(err, "prog_attach _setsockopt"))
+	link_setsockopt = bpf_program__attach_cgroup(obj->progs._setsockopt,
+						     cgroup_fd);
+	if (!ASSERT_OK_PTR(link_setsockopt, "cg-attach-setsockopt"))
 		goto close_bpf_object;
 
 	server_fd = start_server();
@@ -217,7 +191,10 @@ static void run_test(int cgroup_fd)
 close_server_fd:
 	close(server_fd);
 close_bpf_object:
-	bpf_object__close(obj);
+	bpf_link__destroy(link_getsockopt);
+	bpf_link__destroy(link_setsockopt);
+
+	sockopt_inherit__destroy(obj);
 }
 
 void test_sockopt_inherit(void)
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c b/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
index 7f5659349011..759bbb6f8c5f 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_multi.c
@@ -2,61 +2,13 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 
-static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char *title, const char *name)
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
-	prog = bpf_object__find_program_by_name(obj, name);
-	if (!prog) {
-		log_err("Failed to find %s BPF program", name);
-		return -1;
-	}
-
-	err = bpf_prog_attach(bpf_program__fd(prog), cgroup_fd,
-			      attach_type, BPF_F_ALLOW_MULTI);
-	if (err) {
-		log_err("Failed to attach %s BPF program", name);
-		return -1;
-	}
-
-	return 0;
-}
+#include "sockopt_multi.skel.h"
 
-static int prog_detach(struct bpf_object *obj, int cgroup_fd, const char *title, const char *name)
-{
-	enum bpf_attach_type attach_type;
-	enum bpf_prog_type prog_type;
-	struct bpf_program *prog;
-	int err;
-
-	err = libbpf_prog_type_by_name(title, &prog_type, &attach_type);
-	if (err)
-		return -1;
-
-	prog = bpf_object__find_program_by_name(obj, name);
-	if (!prog)
-		return -1;
-
-	err = bpf_prog_detach2(bpf_program__fd(prog), cgroup_fd,
-			       attach_type);
-	if (err)
-		return -1;
-
-	return 0;
-}
-
-static int run_getsockopt_test(struct bpf_object *obj, int cg_parent,
+static int run_getsockopt_test(struct sockopt_multi *obj, int cg_parent,
 			       int cg_child, int sock_fd)
 {
+	struct bpf_link *link_parent = NULL;
+	struct bpf_link *link_child = NULL;
 	socklen_t optlen;
 	__u8 buf;
 	int err;
@@ -89,8 +41,9 @@ static int run_getsockopt_test(struct bpf_object *obj, int cg_parent,
 	 * - child:  0x80 -> 0x90
 	 */
 
-	err = prog_attach(obj, cg_child, "cgroup/getsockopt", "_getsockopt_child");
-	if (err)
+	link_child = bpf_program__attach_cgroup(obj->progs._getsockopt_child,
+						cg_child);
+	if (!ASSERT_OK_PTR(link_child, "cg-attach-getsockopt_child"))
 		goto detach;
 
 	buf = 0x00;
@@ -113,8 +66,9 @@ static int run_getsockopt_test(struct bpf_object *obj, int cg_parent,
 	 * - parent: 0x90 -> 0xA0
 	 */
 
-	err = prog_attach(obj, cg_parent, "cgroup/getsockopt", "_getsockopt_parent");
-	if (err)
+	link_parent = bpf_program__attach_cgroup(obj->progs._getsockopt_parent,
+						 cg_parent);
+	if (!ASSERT_OK_PTR(link_parent, "cg-attach-getsockopt_parent"))
 		goto detach;
 
 	buf = 0x00;
@@ -157,11 +111,8 @@ static int run_getsockopt_test(struct bpf_object *obj, int cg_parent,
 	 * - parent: unexpected 0x40, EPERM
 	 */
 
-	err = prog_detach(obj, cg_child, "cgroup/getsockopt", "_getsockopt_child");
-	if (err) {
-		log_err("Failed to detach child program");
-		goto detach;
-	}
+	bpf_link__destroy(link_child);
+	link_child = NULL;
 
 	buf = 0x00;
 	optlen = 1;
@@ -198,15 +149,17 @@ static int run_getsockopt_test(struct bpf_object *obj, int cg_parent,
 	}
 
 detach:
-	prog_detach(obj, cg_child, "cgroup/getsockopt", "_getsockopt_child");
-	prog_detach(obj, cg_parent, "cgroup/getsockopt", "_getsockopt_parent");
+	bpf_link__destroy(link_child);
+	bpf_link__destroy(link_parent);
 
 	return err;
 }
 
-static int run_setsockopt_test(struct bpf_object *obj, int cg_parent,
+static int run_setsockopt_test(struct sockopt_multi *obj, int cg_parent,
 			       int cg_child, int sock_fd)
 {
+	struct bpf_link *link_parent = NULL;
+	struct bpf_link *link_child = NULL;
 	socklen_t optlen;
 	__u8 buf;
 	int err;
@@ -236,8 +189,9 @@ static int run_setsockopt_test(struct bpf_object *obj, int cg_parent,
 
 	/* Attach child program and make sure it adds 0x10. */
 
-	err = prog_attach(obj, cg_child, "cgroup/setsockopt", "_setsockopt");
-	if (err)
+	link_child = bpf_program__attach_cgroup(obj->progs._setsockopt,
+						cg_child);
+	if (!ASSERT_OK_PTR(link_child, "cg-attach-setsockopt_child"))
 		goto detach;
 
 	buf = 0x80;
@@ -263,8 +217,9 @@ static int run_setsockopt_test(struct bpf_object *obj, int cg_parent,
 
 	/* Attach parent program and make sure it adds another 0x10. */
 
-	err = prog_attach(obj, cg_parent, "cgroup/setsockopt", "_setsockopt");
-	if (err)
+	link_parent = bpf_program__attach_cgroup(obj->progs._setsockopt,
+						 cg_parent);
+	if (!ASSERT_OK_PTR(link_parent, "cg-attach-setsockopt_parent"))
 		goto detach;
 
 	buf = 0x80;
@@ -289,8 +244,8 @@ static int run_setsockopt_test(struct bpf_object *obj, int cg_parent,
 	}
 
 detach:
-	prog_detach(obj, cg_child, "cgroup/setsockopt", "_setsockopt");
-	prog_detach(obj, cg_parent, "cgroup/setsockopt", "_setsockopt");
+	bpf_link__destroy(link_child);
+	bpf_link__destroy(link_parent);
 
 	return err;
 }
@@ -298,9 +253,8 @@ static int run_setsockopt_test(struct bpf_object *obj, int cg_parent,
 void test_sockopt_multi(void)
 {
 	int cg_parent = -1, cg_child = -1;
-	struct bpf_object *obj = NULL;
+	struct sockopt_multi *obj = NULL;
 	int sock_fd = -1;
-	int err = -1;
 
 	cg_parent = test__join_cgroup("/parent");
 	if (!ASSERT_GE(cg_parent, 0, "join_cgroup /parent"))
@@ -310,13 +264,11 @@ void test_sockopt_multi(void)
 	if (!ASSERT_GE(cg_child, 0, "join_cgroup /parent/child"))
 		goto out;
 
-	obj = bpf_object__open_file("sockopt_multi.bpf.o", NULL);
-	if (!ASSERT_OK_PTR(obj, "obj_load"))
+	obj = sockopt_multi__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
 		goto out;
 
-	err = bpf_object__load(obj);
-	if (!ASSERT_OK(err, "obj_load"))
-		goto out;
+	obj->bss->page_size = sysconf(_SC_PAGESIZE);
 
 	sock_fd = socket(AF_INET, SOCK_STREAM, 0);
 	if (!ASSERT_GE(sock_fd, 0, "socket"))
@@ -327,7 +279,7 @@ void test_sockopt_multi(void)
 
 out:
 	close(sock_fd);
-	bpf_object__close(obj);
+	sockopt_multi__destroy(obj);
 	close(cg_child);
 	close(cg_parent);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_qos_to_cc.c b/tools/testing/selftests/bpf/prog_tests/sockopt_qos_to_cc.c
index 6b53b3cb8dad..6b2d300e9fd4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_qos_to_cc.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_qos_to_cc.c
@@ -42,6 +42,8 @@ void test_sockopt_qos_to_cc(void)
 	if (!ASSERT_OK_PTR(skel, "skel"))
 		goto done;
 
+	skel->bss->page_size = sysconf(_SC_PAGESIZE);
+
 	sock_fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (!ASSERT_GE(sock_fd, 0, "v6 socket open"))
 		goto done;
diff --git a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
index b2a409e6382a..932b8ecd4ae3 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_getsockopt.c
@@ -12,6 +12,7 @@ __u32 invocations = 0;
 __u32 assertion_error = 0;
 __u32 retval_value = 0;
 __u32 ctx_retval_value = 0;
+__u32 page_size = 0;
 
 SEC("cgroup/getsockopt")
 int get_retval(struct bpf_sockopt *ctx)
@@ -20,6 +21,10 @@ int get_retval(struct bpf_sockopt *ctx)
 	ctx_retval_value = ctx->retval;
 	__sync_fetch_and_add(&invocations, 1);
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+
 	return 1;
 }
 
@@ -31,6 +36,10 @@ int set_eisconn(struct bpf_sockopt *ctx)
 	if (bpf_set_retval(-EISCONN))
 		assertion_error = 1;
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+
 	return 1;
 }
 
@@ -41,5 +50,9 @@ int clear_retval(struct bpf_sockopt *ctx)
 
 	ctx->retval = 0;
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+
 	return 1;
 }
diff --git a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c
index d6e5903e06ba..b7fa8804e19d 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_setsockopt.c
@@ -11,6 +11,7 @@
 __u32 invocations = 0;
 __u32 assertion_error = 0;
 __u32 retval_value = 0;
+__u32 page_size = 0;
 
 SEC("cgroup/setsockopt")
 int get_retval(struct bpf_sockopt *ctx)
@@ -18,6 +19,10 @@ int get_retval(struct bpf_sockopt *ctx)
 	retval_value = bpf_get_retval();
 	__sync_fetch_and_add(&invocations, 1);
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+
 	return 1;
 }
 
@@ -29,6 +34,10 @@ int set_eunatch(struct bpf_sockopt *ctx)
 	if (bpf_set_retval(-EUNATCH))
 		assertion_error = 1;
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+
 	return 0;
 }
 
@@ -40,6 +49,10 @@ int set_eisconn(struct bpf_sockopt *ctx)
 	if (bpf_set_retval(-EISCONN))
 		assertion_error = 1;
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+
 	return 0;
 }
 
@@ -48,5 +61,9 @@ int legacy_eperm(struct bpf_sockopt *ctx)
 {
 	__sync_fetch_and_add(&invocations, 1);
 
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/sockopt_inherit.c b/tools/testing/selftests/bpf/progs/sockopt_inherit.c
index 9fb241b97291..c8f59caa4639 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_inherit.c
@@ -9,6 +9,8 @@ char _license[] SEC("license") = "GPL";
 #define CUSTOM_INHERIT2			1
 #define CUSTOM_LISTENER			2
 
+__u32 page_size = 0;
+
 struct sockopt_inherit {
 	__u8 val;
 };
@@ -55,7 +57,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval = ctx->optval;
 
 	if (ctx->level != SOL_CUSTOM)
-		return 1; /* only interested in SOL_CUSTOM */
+		goto out; /* only interested in SOL_CUSTOM */
 
 	if (optval + 1 > optval_end)
 		return 0; /* EPERM, bounds check */
@@ -70,6 +72,12 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	ctx->optlen = 1;
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+	return 1;
 }
 
 SEC("cgroup/setsockopt")
@@ -80,7 +88,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval = ctx->optval;
 
 	if (ctx->level != SOL_CUSTOM)
-		return 1; /* only interested in SOL_CUSTOM */
+		goto out; /* only interested in SOL_CUSTOM */
 
 	if (optval + 1 > optval_end)
 		return 0; /* EPERM, bounds check */
@@ -93,4 +101,10 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	ctx->optlen = -1;
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+	return 1;
 }
diff --git a/tools/testing/selftests/bpf/progs/sockopt_multi.c b/tools/testing/selftests/bpf/progs/sockopt_multi.c
index 177a59069dae..96f29fce050b 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_multi.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_multi.c
@@ -5,6 +5,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+__u32 page_size = 0;
+
 SEC("cgroup/getsockopt")
 int _getsockopt_child(struct bpf_sockopt *ctx)
 {
@@ -12,7 +14,7 @@ int _getsockopt_child(struct bpf_sockopt *ctx)
 	__u8 *optval = ctx->optval;
 
 	if (ctx->level != SOL_IP || ctx->optname != IP_TOS)
-		return 1;
+		goto out;
 
 	if (optval + 1 > optval_end)
 		return 0; /* EPERM, bounds check */
@@ -26,6 +28,12 @@ int _getsockopt_child(struct bpf_sockopt *ctx)
 	ctx->optlen = 1;
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+	return 1;
 }
 
 SEC("cgroup/getsockopt")
@@ -35,7 +43,7 @@ int _getsockopt_parent(struct bpf_sockopt *ctx)
 	__u8 *optval = ctx->optval;
 
 	if (ctx->level != SOL_IP || ctx->optname != IP_TOS)
-		return 1;
+		goto out;
 
 	if (optval + 1 > optval_end)
 		return 0; /* EPERM, bounds check */
@@ -49,6 +57,12 @@ int _getsockopt_parent(struct bpf_sockopt *ctx)
 	ctx->optlen = 1;
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+	return 1;
 }
 
 SEC("cgroup/setsockopt")
@@ -58,7 +72,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval = ctx->optval;
 
 	if (ctx->level != SOL_IP || ctx->optname != IP_TOS)
-		return 1;
+		goto out;
 
 	if (optval + 1 > optval_end)
 		return 0; /* EPERM, bounds check */
@@ -67,4 +81,10 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	ctx->optlen = 1;
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+	return 1;
 }
diff --git a/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
index 1bce83b6e3a7..dbe235ede7f3 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_qos_to_cc.c
@@ -9,6 +9,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+__u32 page_size = 0;
+
 SEC("cgroup/setsockopt")
 int sockopt_qos_to_cc(struct bpf_sockopt *ctx)
 {
@@ -19,7 +21,7 @@ int sockopt_qos_to_cc(struct bpf_sockopt *ctx)
 	char cc_cubic[TCP_CA_NAME_MAX] = "cubic";
 
 	if (ctx->level != SOL_IPV6 || ctx->optname != IPV6_TCLASS)
-		return 1;
+		goto out;
 
 	if (optval + 1 > optval_end)
 		return 0; /* EPERM, bounds check */
@@ -36,4 +38,10 @@ int sockopt_qos_to_cc(struct bpf_sockopt *ctx)
 			return 0;
 	}
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+	return 1;
 }
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index fe1df4cd206e..cb990a7d3d45 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -37,7 +37,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	/* Bypass AF_NETLINK. */
 	sk = ctx->sk;
 	if (sk && sk->family == AF_NETLINK)
-		return 1;
+		goto out;
 
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
@@ -52,8 +52,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 * let next BPF program in the cgroup chain or kernel
 		 * handle it.
 		 */
-		ctx->optlen = 0; /* bypass optval>PAGE_SIZE */
-		return 1;
+		goto out;
 	}
 
 	if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
@@ -61,7 +60,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 * let next BPF program in the cgroup chain or kernel
 		 * handle it.
 		 */
-		return 1;
+		goto out;
 	}
 
 	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION) {
@@ -69,7 +68,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 * let next BPF program in the cgroup chain or kernel
 		 * handle it.
 		 */
-		return 1;
+		goto out;
 	}
 
 	if (ctx->level == SOL_TCP && ctx->optname == TCP_ZEROCOPY_RECEIVE) {
@@ -85,7 +84,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		if (((struct tcp_zerocopy_receive *)optval)->address != 0)
 			return 0; /* unexpected data */
 
-		return 1;
+		goto out;
 	}
 
 	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
@@ -129,6 +128,12 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	ctx->optlen = 1;
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+	return 1;
 }
 
 SEC("cgroup/setsockopt")
@@ -142,7 +147,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	/* Bypass AF_NETLINK. */
 	sk = ctx->sk;
 	if (sk && sk->family == AF_NETLINK)
-		return 1;
+		goto out;
 
 	/* Make sure bpf_get_netns_cookie is callable.
 	 */
@@ -224,4 +229,10 @@ int _setsockopt(struct bpf_sockopt *ctx)
 			   */
 
 	return 1;
+
+out:
+	/* optval larger than PAGE_SIZE use kernel's buffer. */
+	if (ctx->optlen > page_size)
+		ctx->optlen = 0;
+	return 1;
 }
-- 
2.40.1.521.gf1e218fcd8-goog


