Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBFE6F7210
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjEDSoB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 14:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjEDSoA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 14:44:00 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576AA3C33
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 11:43:57 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6439cf8d6faso12593b3a.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 11:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683225837; x=1685817837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGZxIBtz4nGyUZmik4dC7PnZLPJz9Yx6DwC5/+xIjPI=;
        b=pLVRgzgHMoukFU5/rTH9/ySp1gXhzLfCKZN0h6zELKSpTVYybfiLwKS5rMsTlv2LpZ
         Qh5FzMf2SonR2AMSYOHcmdGr/CZ/Pgz3aJzolnxi9G9tWNY8b4ZMJktSA/JGJ0V314YX
         VQKiBi8Hrsv1uIe99BICoHHvXJIPjYgvhc65j95QRNKfELYFTvY2uIUoXNTUztQ/8aLG
         YWmZlRP3920mVGnpVOXA9tre2vjbp8Rao1uKHpURP87j++s+N0MqtZKE/V9vugNosbPS
         DyqujCT9YnGTz3s5RbCi/K0hj569m3Foutm9k5n45cBc/881e2ddLeSvebmg9TyWHCxp
         Hu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683225837; x=1685817837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGZxIBtz4nGyUZmik4dC7PnZLPJz9Yx6DwC5/+xIjPI=;
        b=KOtMut8ToPkuArj9wDdFgPxnLgJfi1kd5RfherIAK3GsYY9G7ldzjofS6K+2G0Kecz
         G7Ct/C2exRTsEQCMDXFSU7PLeE7tAlW8fEvxxtU9u5lySImkuqGrREqa7B9fauSTy29W
         TC+3sksc5AMIJlAGYVYw0d5sKy9rCNxFTdzwcFuAKlxZmeTy+nudrUpnZbSUtmeH8KmP
         XXLuQ0HjXIQ3Xm2tkMjstgl0FVAtNZpVJv8BxhkZgg05sTl0UVvXk8Nz96SFEyw3xcXq
         4+tMUy3M4rgs07D4vgUSRKy2CagySTgwHuLF7wxDprYWnBi/8MSXiMBFLT1usupWOCth
         n4TA==
X-Gm-Message-State: AC+VfDzmv9VNTRSGDKjWtadSdQm8wPtivd1mvBZwqIWVrp00GkRGWEb/
        m5BQ1WdvYk0ACI0jSMYbcgzVmPbIDvF8bX4DUXPLPdYrS58NsHEE4JKdLjoG/Aw8DzsOreeZPLx
        lAHh+RzIqlOUaEoRakNWDzUv590uDdOlWy2USSr00fqq5abbuCg==
X-Google-Smtp-Source: ACHHUZ77V7ZxGnbvQqXm/aygUgjGQ/jFhIJrg+fJm5poC6lYgSdybtKlAj/EzaOP5A+MghuygI/tBR0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:80f6:b0:63b:7cae:1164 with SMTP id
 ei54-20020a056a0080f600b0063b7cae1164mr774234pfb.1.1683225836732; Thu, 04 May
 2023 11:43:56 -0700 (PDT)
Date:   Thu,  4 May 2023 11:43:48 -0700
In-Reply-To: <20230504184349.3632259-1-sdf@google.com>
Mime-Version: 1.0
References: <20230504184349.3632259-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230504184349.3632259-4-sdf@google.com>
Subject: [PATCH bpf-next v4 3/4] selftests/bpf: Correctly handle optlen > 4096
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Even though it's not relevant in selftests, the people
might still copy-paste from them. So let's take care
of optlen > 4096 cases explicitly.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../bpf/prog_tests/cgroup_getset_retval.c     |  20 ++++
 .../bpf/prog_tests/sockopt_inherit.c          |  59 +++-------
 .../selftests/bpf/prog_tests/sockopt_multi.c  | 110 +++++-------------
 .../bpf/prog_tests/sockopt_qos_to_cc.c        |   2 +
 .../progs/cgroup_getset_retval_getsockopt.c   |  13 +++
 .../progs/cgroup_getset_retval_setsockopt.c   |  17 +++
 .../selftests/bpf/progs/sockopt_inherit.c     |  18 ++-
 .../selftests/bpf/progs/sockopt_multi.c       |  26 ++++-
 .../selftests/bpf/progs/sockopt_qos_to_cc.c   |  10 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  |  25 ++--
 10 files changed, 167 insertions(+), 133 deletions(-)

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
index 7f5659349011..6f43536f98f4 100644
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
+#include "sockopt_multi.skel.h"
 
-	err = bpf_prog_attach(bpf_program__fd(prog), cgroup_fd,
-			      attach_type, BPF_F_ALLOW_MULTI);
-	if (err) {
-		log_err("Failed to attach %s BPF program", name);
-		return -1;
-	}
-
-	return 0;
-}
-
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
-		goto out;
+	obj = sockopt_multi__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "skel-load"))
+		return;
 
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

