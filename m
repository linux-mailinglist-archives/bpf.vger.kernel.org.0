Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9034F56A75A
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 18:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiGGQCh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 12:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiGGQCg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 12:02:36 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384DF28E34
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 09:02:35 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id f9-20020a636a09000000b00401b6bc63beso8810644pgc.23
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5rG1Lib/zGVpNfpbS/Aj4qZe8ei8MICbFB7WX19/VLQ=;
        b=pAZI6d6k6hisxOmjVfTmTqS0bmK+27pmhiL0tOPzCNQgOrgN+Cv7UIEz+otyMuT7Hl
         6GuH6uwAUjIuG2GmKpr3lo1A4Sdq3vOfkZMY4kNbTekxDP6u4iZMkuHfetWAUTz10hgk
         IXH0+jkirtGreOZgmXFn9vAIKGHf+tWDPM3N5PPUN0VI7dmuSnEqCOpWMcpLcKjYsnzY
         P030K2WWEJWcXNam+XTAFp/v/Jy9rPM2IuVeQn0mUzb2gM9RDMkXMgJtrQ5DBlmFyY7e
         lGrP1TGjOJ3+6OKJTG37xioZrkjEwiIAatC00eo2Futk3wjJzxg8IxzLDumqFXtwS6En
         QcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5rG1Lib/zGVpNfpbS/Aj4qZe8ei8MICbFB7WX19/VLQ=;
        b=U+FjUPX7tg7Qd0pqG7XyK6NsZ/FxPBwwjp5u5f9S+xml/vnJ/wEhXQXdKkFT21xIrD
         0Dh/XJAFszVZLxQs4tdw5a0lEX9JV7kLndyUddgdoONtIOqApLipERm+lFin66Y4FAzi
         /L2tWRmuiu/3xFjKFwv823GSubVtAzNiJgSaqX8lXZC4Y3b7ykFpPRWTktOz0ukNgUHD
         PlrDrkNe1lfx6LFXkJRxIW4uvNgHZrVfqugYkJXrj69nOzHabwQ0iNdpdfei/fnlhIkw
         Y5Ez/LbkIml7hjZXjUFTKX6naFgtwZ/ygmHgjbjGodyJMwCmkDUZIc1feYySc4YvkhDH
         rdJQ==
X-Gm-Message-State: AJIora9Mae9lL5gDZyhNb0koaDoCIg5718eBA21285zeFAEn05XX9mb0
        r8zAiR/bUtd2hGaVWqNX3iIYnbHYV5vRg/IatRkiyoitLFdyuABZztTE7rhfIW3posGj8N+jxtf
        tjrIKfrSZK9pOHVLbiDsBCnB1a2GDSFuaT3M4sLZ8fZI1V5sr5A==
X-Google-Smtp-Source: AGRyM1vRCgcO8yogn6SQORt/Cl54Ic56J7S4dP9pFPiCI0Rr1m2+d7b+wxT/k/jSeyT78tk64/o39To=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:618d:0:b0:412:9362:9603 with SMTP id
 v135-20020a63618d000000b0041293629603mr9419689pgb.478.1657209754560; Thu, 07
 Jul 2022 09:02:34 -0700 (PDT)
Date:   Thu,  7 Jul 2022 09:02:33 -0700
Message-Id: <20220707160233.2078550-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v2] bpf: check attach_func_proto more carefully in check_return_code
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
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

Syzkaller reports the following crash:
RIP: 0010:check_return_code kernel/bpf/verifier.c:10575 [inline]
RIP: 0010:do_check kernel/bpf/verifier.c:12346 [inline]
RIP: 0010:do_check_common+0xb3d2/0xd250 kernel/bpf/verifier.c:14610

With the following reproducer:
bpf$PROG_LOAD_XDP(0x5, &(0x7f00000004c0)={0xd, 0x3, &(0x7f0000000000)=ANY=[@ANYBLOB="1800000000000019000000000000000095"], &(0x7f0000000300)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x2b, 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x80)

Because we don't enforce expected_attach_type for XDP programs,
we end up in hitting 'if (prog->expected_attach_type == BPF_LSM_CGROUP'
part in check_return_code and follow up with testing
`prog->aux->attach_func_proto->type`, but `prog->aux->attach_func_proto`
is NULL.

Add explicit prog_type check for the "Note, BPF_LSM_CGROUP that
attach ..." condition. Also, don't skip return code check for
LSM/STRUCT_OPS.

The above actually brings an issue with existing selftest which
tries to return EPERM from void inet_csk_clone. Fix the
test (and move called_socket_clone to make sure it's not
incremented in case of an error) and add a new one to explicitly
verify this condition.

v2:
- Martin: don't add new helper, check prog_type instead
- Martin: check expected_attach_type as well at the function entry
- Update selftest to verify this condition

Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Reported-by: syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/verifier.c                              |  2 ++
 .../testing/selftests/bpf/prog_tests/lsm_cgroup.c  | 12 ++++++++++++
 tools/testing/selftests/bpf/progs/lsm_cgroup.c     | 12 ++++++------
 .../selftests/bpf/progs/lsm_cgroup_nonvoid.c       | 14 ++++++++++++++
 4 files changed, 34 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_cgroup_nonvoid.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index df3ec6b05f05..2bc1e7252778 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10445,6 +10445,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
 	if (!is_subprog &&
+	    prog->expected_attach_type != BPF_LSM_CGROUP &&
 	    (prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
 	     prog_type == BPF_PROG_TYPE_LSM) &&
 	    !prog->aux->attach_func_proto->type)
@@ -10572,6 +10573,7 @@ static int check_return_code(struct bpf_verifier_env *env)
 	if (!tnum_in(range, reg->var_off)) {
 		verbose_invalid_scalar(env, reg, &range, "program exit", "R0");
 		if (prog->expected_attach_type == BPF_LSM_CGROUP &&
+		    prog_type == BPF_PROG_TYPE_LSM &&
 		    !prog->aux->attach_func_proto->type)
 			verbose(env, "Note, BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
 		return -EINVAL;
diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
index c542d7e80a5b..1102e4f42d2d 100644
--- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
@@ -6,6 +6,7 @@
 #include <bpf/btf.h>
 
 #include "lsm_cgroup.skel.h"
+#include "lsm_cgroup_nonvoid.skel.h"
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 
@@ -293,9 +294,20 @@ static void test_lsm_cgroup_functional(void)
 	lsm_cgroup__destroy(skel);
 }
 
+static void test_lsm_cgroup_nonvoid(void)
+{
+	struct lsm_cgroup_nonvoid *skel = NULL;
+
+	skel = lsm_cgroup_nonvoid__open_and_load();
+	ASSERT_NULL(skel, "open succeeds");
+	lsm_cgroup_nonvoid__destroy(skel);
+}
+
 void test_lsm_cgroup(void)
 {
 	if (test__start_subtest("functional"))
 		test_lsm_cgroup_functional();
+	if (test__start_subtest("nonvoid"))
+		test_lsm_cgroup_nonvoid();
 	btf__free(btf);
 }
diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup.c b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
index 89f3b1e961a8..4f2d60b87b75 100644
--- a/tools/testing/selftests/bpf/progs/lsm_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/lsm_cgroup.c
@@ -156,25 +156,25 @@ int BPF_PROG(socket_clone, struct sock *newsk, const struct request_sock *req)
 {
 	int prio = 234;
 
-	called_socket_clone++;
-
 	if (!newsk)
 		return 1;
 
 	/* Accepted request sockets get a different priority. */
 	if (bpf_setsockopt(newsk, SOL_SOCKET, SO_PRIORITY, &prio, sizeof(prio)))
-		return 0; /* EPERM */
+		return 1;
 
 	/* Make sure bpf_getsockopt is allowed and works. */
 	prio = 0;
 	if (bpf_getsockopt(newsk, SOL_SOCKET, SO_PRIORITY, &prio, sizeof(prio)))
-		return 0; /* EPERM */
+		return 1;
 	if (prio != 234)
-		return 0; /* EPERM */
+		return 1;
 
 	/* Can access cgroup local storage. */
 	if (!test_local_storage())
-		return 0; /* EPERM */
+		return 1;
+
+	called_socket_clone++;
 
 	return 1;
 }
diff --git a/tools/testing/selftests/bpf/progs/lsm_cgroup_nonvoid.c b/tools/testing/selftests/bpf/progs/lsm_cgroup_nonvoid.c
new file mode 100644
index 000000000000..6cb0f161f417
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_cgroup_nonvoid.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("lsm_cgroup/inet_csk_clone")
+int BPF_PROG(nonvoid_socket_clone, struct sock *newsk, const struct request_sock *req)
+{
+	/* Can not return any errors from void LSM hooks. */
+	return 0;
+}
-- 
2.37.0.rc0.161.g10f37bed90-goog

