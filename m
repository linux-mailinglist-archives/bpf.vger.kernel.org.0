Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2F859638A
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 22:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiHPUMZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbiHPUMX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 16:12:23 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E3A7EFE0
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 13:12:22 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id c142-20020a621c94000000b005324991c5b8so4176337pfc.15
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=451XEOcpdi8L15HuIBG3e1nRoudM4FMRk+2vKbPEhBQ=;
        b=LAYkUbnOIIEealCZVOAOB1B4azIqb0/7k9JKHuHJURA5ZjT4SANcsJDuxejdOny1SA
         RH3T8Tp17CeClQcsCMge+NivcAc2DxVumAQkiJ8DtO1nwbb335+H/Je3X/6ENYCA/xUg
         WYXRvABEor1CnUWxrYtPSSGvBa2ialQsoc5pOhvOtKZ+RYlQ6qagyzCmS5HjG1uL19iw
         lZFzSgZoHi6HU47bMs6rEwTRC3JoFVLlozKYCxYnkZ1ZRQSLp3RgZUhPVltoFn9IbYeg
         aP+/W/AK2Ggt/mtx5J5ayRrV9HzvVfnvLT2815mEWXL8faEzZa5JyWfX0NDxTgowLDxI
         U87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=451XEOcpdi8L15HuIBG3e1nRoudM4FMRk+2vKbPEhBQ=;
        b=dyKSVugAOy+CnNyp+YkvHqs7zjJrnbG3QtC2BTsBKMCRINQBIPoz8qUd1efkQ/5W+W
         zLzLKIetLwv+9N6RhtJc3Wcp0c38M8lJoka52K0dCygYAPf3kOeqEfx75I8LZPCHCp16
         zb84+Zy+HIKVLwitNM8Mevab88X2Jna0wlIbZ5aCyreNihgQgaboGGfMYbDYgHjds2jF
         145wJVELf2/IIpgXJNKY1AZ/J+oAsoR3xwNAcODDuj4a07XZy1gOwm+llkBmdDpQl0b+
         knYeBmDp7cb3FUzd8V6kOWxpvhZgMLlx67t3qDnX2fcJ9p6j+lHLf/mXFWI2NpgzL1rF
         qsvw==
X-Gm-Message-State: ACgBeo27peWwU/LRv2AXApGd9or4xXkOdomoYgtPsuO0dOWcOwWSOFm3
        vvBWGliuYOFFfRP6y7WgaJ4nPYRpLmck3r3MTv2hrsSE2ALj4ijA3vxabXvMRpkLECyJwJYbHUj
        johZsnhXmVmLgYBEPArtB7h+Bo6wd+OLrevYUk+cug+yfnTV7wQ==
X-Google-Smtp-Source: AA6agR7slH1s+eFoBdGIdkpguIzJ5xLNn0X1bDQaQMf4DGY3738zaUfCkk01c06gBMh/bSRn9xLc/qw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:9893:b0:170:8c4e:e2c3 with SMTP id
 s19-20020a170902989300b001708c4ee2c3mr23455955plp.171.1660680741082; Tue, 16
 Aug 2022 13:12:21 -0700 (PDT)
Date:   Tue, 16 Aug 2022 13:12:14 -0700
In-Reply-To: <20220816201214.2489910-1-sdf@google.com>
Message-Id: <20220816201214.2489910-4-sdf@google.com>
Mime-Version: 1.0
References: <20220816201214.2489910-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Make sure bpf_{g,s}et_retval
 is exposed everywhere
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

For each hook, have a simple bpf_set_retval(bpf_get_retval) program
and make sure it loads for the hooks we want. The exceptions are
the hooks which don't propagate the error to the callers:

- sockops
- recvmsg
- getpeername
- getsockname

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/Makefile          |  1 +
 .../bpf/cgroup_getset_retval_hooks.h          | 25 ++++++++++
 .../bpf/prog_tests/cgroup_getset_retval.c     | 48 +++++++++++++++++++
 .../bpf/progs/cgroup_getset_retval_hooks.c    | 16 +++++++
 4 files changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8d59ec7f4c2d..eecad99f1735 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -323,6 +323,7 @@ $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
 $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
 
 $(OUTPUT)/flow_dissector_load.o: flow_dissector_load.h
+$(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
 
 # Build BPF object using Clang
 # $1 - input .c file
diff --git a/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h b/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
new file mode 100644
index 000000000000..4a8d2063163d
--- /dev/null
+++ b/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+BPF_RETVAL_HOOK(ingress, "cgroup_skb/ingress", __sk_buff, 0)
+BPF_RETVAL_HOOK(egress, "cgroup_skb/egress", __sk_buff, 0)
+BPF_RETVAL_HOOK(sock_create, "cgroup/sock_create", bpf_sock, 0)
+BPF_RETVAL_HOOK(sock_ops, "sockops", bpf_sock_ops, -EINVAL)
+BPF_RETVAL_HOOK(dev, "cgroup/dev", bpf_cgroup_dev_ctx, 0)
+BPF_RETVAL_HOOK(bind4, "cgroup/bind4", bpf_sock_addr, 0)
+BPF_RETVAL_HOOK(bind6, "cgroup/bind6", bpf_sock_addr, 0)
+BPF_RETVAL_HOOK(connect4, "cgroup/connect4", bpf_sock_addr, 0)
+BPF_RETVAL_HOOK(connect6, "cgroup/connect6", bpf_sock_addr, 0)
+BPF_RETVAL_HOOK(post_bind4, "cgroup/post_bind4", bpf_sock_addr, 0)
+BPF_RETVAL_HOOK(post_bind6, "cgroup/post_bind6", bpf_sock_addr, 0)
+BPF_RETVAL_HOOK(sendmsg4, "cgroup/sendmsg4", bpf_sock_addr, 0)
+BPF_RETVAL_HOOK(sendmsg6, "cgroup/sendmsg6", bpf_sock_addr, 0)
+BPF_RETVAL_HOOK(sysctl, "cgroup/sysctl", bpf_sysctl, 0)
+BPF_RETVAL_HOOK(recvmsg4, "cgroup/recvmsg4", bpf_sock_addr, -EINVAL)
+BPF_RETVAL_HOOK(recvmsg6, "cgroup/recvmsg6", bpf_sock_addr, -EINVAL)
+BPF_RETVAL_HOOK(getsockopt, "cgroup/getsockopt", bpf_sockopt, 0)
+BPF_RETVAL_HOOK(setsockopt, "cgroup/setsockopt", bpf_sockopt, 0)
+BPF_RETVAL_HOOK(getpeername4, "cgroup/getpeername4", bpf_sock_addr, -EINVAL)
+BPF_RETVAL_HOOK(getpeername6, "cgroup/getpeername6", bpf_sock_addr, -EINVAL)
+BPF_RETVAL_HOOK(getsockname4, "cgroup/getsockname4", bpf_sock_addr, -EINVAL)
+BPF_RETVAL_HOOK(getsockname6, "cgroup/getsockname6", bpf_sock_addr, -EINVAL)
+BPF_RETVAL_HOOK(sock_release, "cgroup/sock_release", bpf_sock, 0)
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c b/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
index 0b47c3c000c7..4d2fa99273d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_getset_retval.c
@@ -10,6 +10,7 @@
 
 #include "cgroup_getset_retval_setsockopt.skel.h"
 #include "cgroup_getset_retval_getsockopt.skel.h"
+#include "cgroup_getset_retval_hooks.skel.h"
 
 #define SOL_CUSTOM	0xdeadbeef
 
@@ -433,6 +434,50 @@ static void test_getsockopt_retval_sync(int cgroup_fd, int sock_fd)
 	cgroup_getset_retval_getsockopt__destroy(obj);
 }
 
+struct exposed_hook {
+	const char *name;
+	int expected_err;
+} exposed_hooks[] = {
+
+#define BPF_RETVAL_HOOK(NAME, SECTION, CTX, EXPECTED_ERR) \
+	{ \
+		.name = #NAME, \
+		.expected_err = EXPECTED_ERR, \
+	},
+
+#include "cgroup_getset_retval_hooks.h"
+
+#undef BPF_RETVAL_HOOK
+};
+
+static void test_exposed_hooks(int cgroup_fd, int sock_fd)
+{
+	struct cgroup_getset_retval_hooks *skel;
+	struct bpf_program *prog;
+	int err;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(exposed_hooks); i++) {
+		skel = cgroup_getset_retval_hooks__open();
+		if (!ASSERT_OK_PTR(skel, "cgroup_getset_retval_hooks__open"))
+			continue;
+
+		prog = bpf_object__find_program_by_name(skel->obj, exposed_hooks[i].name);
+		if (!ASSERT_NEQ(prog, NULL, "bpf_object__find_program_by_name"))
+			goto close_skel;
+
+		err = bpf_program__set_autoload(prog, true);
+		if (!ASSERT_OK(err, "bpf_program__set_autoload"))
+			goto close_skel;
+
+		err = cgroup_getset_retval_hooks__load(skel);
+		ASSERT_EQ(err, exposed_hooks[i].expected_err, "expected_err");
+
+close_skel:
+		cgroup_getset_retval_hooks__destroy(skel);
+	}
+}
+
 void test_cgroup_getset_retval(void)
 {
 	int cgroup_fd = -1;
@@ -476,6 +521,9 @@ void test_cgroup_getset_retval(void)
 	if (test__start_subtest("getsockopt-retval_sync"))
 		test_getsockopt_retval_sync(cgroup_fd, sock_fd);
 
+	if (test__start_subtest("exposed_hooks"))
+		test_exposed_hooks(cgroup_fd, sock_fd);
+
 close_fd:
 	close(cgroup_fd);
 }
diff --git a/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c
new file mode 100644
index 000000000000..13dfb4bbfd28
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_getset_retval_hooks.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#define BPF_RETVAL_HOOK(name, section, ctx, expected_err) \
+	__attribute__((__section__("?" section))) \
+	int name(struct ctx *_ctx) \
+	{ \
+		bpf_set_retval(bpf_get_retval()); \
+		return 1; \
+	}
+
+#include "cgroup_getset_retval_hooks.h"
+
+#undef BPF_RETVAL_HOOK
-- 
2.37.1.595.g718a3a8f04-goog

