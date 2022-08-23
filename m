Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5259EF36
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiHWW0x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiHWW0Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:26:16 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C98768F
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:26:06 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id v65-20020a626144000000b0052f89472f54so6589608pfb.11
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=jBE6VSBpJP/1/JdUAjLaekJwGZ4/sCWpsCE/p+yPAbM=;
        b=PuCJqc9ednWNUgfRzOITi1IL/ita/kL4WWrD6INjYsjICyTaT0mli8DLMbXjyjwsT8
         GVClDfOBXZYWS+UXtqgxmTPEPha7OTpLttuMJZd4qV/GrAPwoJYzD7oR0C+EObf4EHsx
         Pz0/Iamk5RnEC60EFLSUF8CteL2jC8FbJ8Zb6v/mV3rCOLCxhXoFWZKK2OgI+qnw81Qj
         l2v9BgAbWu628SqI1hM7GRZwoNNYOMz6Xq3cTRLwg7eNguV8X8B3YaIe2dw5R3pncb70
         GUAgjg7udjT0SreLedUw2nUa93u8sJgfdMhqXeFmPdDCq9DKoIwjcqDbWZqR6AFRNsxp
         40Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=jBE6VSBpJP/1/JdUAjLaekJwGZ4/sCWpsCE/p+yPAbM=;
        b=cj2lAA2ZOJemReU4NbGTDLEuR/jVHTSs1SYD10or7ip6HQeL5JIP6OpUJQrUsj36II
         v2yCykte6Ck2+kDArT/8DASrW2iQ4Perjz7ybPocEk4Fd4AAwy5HUDl3VCvTIF1G8JrR
         4RSATOgFgDnAt4SDRCAYTQ7WGD1DK7lbu7AkHHTosLTMYXURcpHK9b/XHW215cGewOnd
         E74FHospsNHY3N9bLxFdml3ougomxzmyH3lu8/Uni5cKaC8GipjQ1FDxlw7/Z4y+uqjA
         ZZxo10eUCYzoMjb1/mu3D11JHUo0dtvlu8ZZvNQCDq8p9jolrUgnhP2C8Z6q5s2QlS+j
         Ft/w==
X-Gm-Message-State: ACgBeo0LRzWZUzDc9H4DH3AQa0At4Pu16RxPOJlsIWuWp6+aKWE1THjC
        Be2In977RO9rKksMrPlJqJhaGJ73mgMKwsZ8MJrCdmoqaEgIxRcSV2VNP7UhD6sPajqFimTj05J
        GRJybBz4zjYCpVFSHBn+iaCXxvxCUDXv/w0XJ6fhfogZYOxK2Dw==
X-Google-Smtp-Source: AA6agR7BznM+Mu1KfXVsG27jct2+Kejt65cn0etiCavxI285N4wNDbekMxUJ4YzTyYzOHsW9LRsj60o=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:e543:b0:1fa:d591:12c4 with SMTP id
 ei3-20020a17090ae54300b001fad59112c4mr5105544pjb.91.1661293566103; Tue, 23
 Aug 2022 15:26:06 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:25:55 -0700
In-Reply-To: <20220823222555.523590-1-sdf@google.com>
Message-Id: <20220823222555.523590-6-sdf@google.com>
Mime-Version: 1.0
References: <20220823222555.523590-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v5 5/5] selftests/bpf: Make sure bpf_{g,s}et_retval
 is exposed everywhere
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <kafai@fb.com>
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
- cg_skb ingress and egress

Acked-by: Martin KaFai Lau <kafai@fb.com>
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
index 000000000000..a525d3544fd7
--- /dev/null
+++ b/tools/testing/selftests/bpf/cgroup_getset_retval_hooks.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+BPF_RETVAL_HOOK(ingress, "cgroup_skb/ingress", __sk_buff, -EINVAL)
+BPF_RETVAL_HOOK(egress, "cgroup_skb/egress", __sk_buff, -EINVAL)
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

