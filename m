Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CD45AC682
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIDUmb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiIDUmY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:24 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426402CDD9
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:23 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e17so1423517edc.5
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YmFOS4EJ+WTsyrgaSJ8VvBhPmgVii8rC8XJWqwk2Otc=;
        b=ozoHAEt466V0h0lcGeOBY1gaxFiaFPJL4NQAm0B6Bb/CVZdIIXc0woj5bGDtgQ3s3v
         Cy3QalUcf6WmlcPNRZ5YIjXcmjs29uzDm5HttU4F67//2pKJVGWW8CNGl2eEua3T2jZa
         s8ZoJZomiCkkAWFh72nKe2E2SlN5Bprjh5GlczWC7V5x8A4utCeeQVzKCxvNqAe1iU3F
         o0eLv6vSS6TqVdhHIL8f5lFv3BUgQh/rla7C4z4XD2FFEJtQnyVpTnsTRrNW1plqHIwC
         CX4GiKbyCgsxQQRkvnZ7VSzV28dFK5a0Fc5odiE0MrBn+elZcRr8Z3g/dLkEWQUAL2oM
         4gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YmFOS4EJ+WTsyrgaSJ8VvBhPmgVii8rC8XJWqwk2Otc=;
        b=m1WO733ziGYLhNb0/b0m5l44KzbCGMLHShCVR2jS6rbxW1i5IM1vDt5RySIyEBZL8I
         jntO76sXBDbPShO9m5Y+lk16Hq/eoxOiQNblJhYwaO10TNuyVIHFAojE5xmw8BwyRwi0
         FqLB0JxZ3oUomymjPnzBZwZTzndxKQDVb2jTeP0JR+FYPIF6o/X4qGSez94zBJHpve/d
         l0HZhQdW8zEOPvPQTHe/zgvC8I+2CnZPcWken+jC85fQPh7sokDOOYi7TsGKUbFBNFYe
         pQ2dHr4oFVh5WkOTAtlhtGNNIz7BbzPla/jJBKvdOkJGFRsYXiKJ/S86i6PCfd3QVhNF
         ATJg==
X-Gm-Message-State: ACgBeo2Q7x6hRJmIu5V6TzeW2ud/C93BK0hzKx2DIvA41Bcs2fe70Kee
        9pG5ZDLf1/vvxNsybwuOmHoLPeIBEDspOQ==
X-Google-Smtp-Source: AA6agR59SYIj9na42IP7IftI22ix02SMA3XLLn/mOLPGhLRj3miaEClR7xLaBiXHGVCmb4GFrw4+kg==
X-Received: by 2002:a05:6402:40cb:b0:448:627d:90d6 with SMTP id z11-20020a05640240cb00b00448627d90d6mr29337734edb.233.1662324141601;
        Sun, 04 Sep 2022 13:42:21 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id dc4-20020a170906c7c400b0073bf84be798sm4121289ejb.142.2022.09.04.13.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:21 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 31/32] selftests/bpf: Add BPF linked list API tests
Date:   Sun,  4 Sep 2022 22:41:44 +0200
Message-Id: <20220904204145.3089-32-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12271; i=memxor@gmail.com; h=from:subject; bh=vDQTsM6dAQwKfYjVJ13BCNe8guT9obgO9ltFhsSB56M=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1yRVgtyUEk4KHTcK/RUqpg/hmSZyV/m+7baHCN aKjGK0eJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcgAKCRBM4MiGSL8Ryqr0D/ 9Yj70ifTlJtBzz/zdLoMZAJwhvwRwqtSyvKFoEyRJs7NuMJhlB6w7RyGJ5MFzknWoMU8xxsl2o6PCl NvroTCVAcBQmGzKhetms7tbq8e6CISGrBMDmuhDwSxKGXS6dhPaimTJA5GJBpQvWMYg9AYkx/Fubvt LcPla/ShR0BhqCPkL6HikkROnIPP1s4298zfju9LcRwr6lnlN5aJQVtpin5CLFm93w3gxxvgsco3gy JJigWtFKlI5vQ3fap23ShGfA3KhmskUxitAhSuVcW1OEUzG+TpUMAXOypApnKtQtEMVlzqasEGkbZp RknCgjL2/519ZDPa+JfBkwCEZX0AnR9SRhjCjRBeQfm7lxZMSR7EucRfMDOB/BxMavTh2ckmJOwb5Y dml4yojQjdUkTmGvyjp31CEES7s22CoJr2UKR1YUeZlUJU8s/m2ae18KF4gNfXELfxpezPDv5MA4T2 xoMAKQOa2nkEN0DBsFcVH9GJ7PvIG4UZzYHuIIRpMf2GS6UFWRxMZRAS+q119Mx5Pv48ySc2D6nUsI mm33N2Mg5LGD86fUg9BUx1YhxHYRDA5I8J228tQ7BwWIDe0kFMC69wU5j9YpBuxt/VD+P/H7Xe/eIb 4XPuUxTYT3UZ+MvYGTPGEIHAH0UgP2JeRDxmYGGzV9fNBumVY1uRWJwg6fvg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include various tests covering the success and failure cases. Also, run
the success cases at runtime to verify correctness of linked list
manipulation routines, in addition to ensuring successful verification.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c                          |   5 +-
 .../selftests/bpf/prog_tests/linked_list.c    |  88 +++++
 .../testing/selftests/bpf/progs/linked_list.c | 347 ++++++++++++++++++
 3 files changed, 439 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 030c35bf030d..928466f83cca 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1831,7 +1831,10 @@ static const struct btf_kfunc_id_set tracing_kfunc_set = {
 
 static int __init kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &tracing_kfunc_set);
 }
 
 late_initcall(kfunc_init);
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
new file mode 100644
index 000000000000..2dc695fb05b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#define __KERNEL__
+#include "bpf_experimental.h"
+#undef __KERNEL__
+
+#include "linked_list.skel.h"
+
+static char log_buf[1024 * 1024];
+
+static struct {
+	const char *prog_name;
+	const char *err_msg;
+} linked_list_fail_tests = {
+};
+
+static void test_linked_list_success(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+	struct linked_list *skel;
+	int key = 0, ret;
+	char buf[32];
+
+	(void)log_buf;
+	(void)&linked_list_fail_tests;
+
+	skel = linked_list__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "linked_list__open_and_load"))
+		return;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.map_list_push_pop), &opts);
+	ASSERT_OK(ret, "map_list_push_pop");
+	ASSERT_OK(opts.retval, "map_list_push_pop retval");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop), &opts);
+	ASSERT_OK(ret, "global_list_push_pop");
+	ASSERT_OK(opts.retval, "global_list_push_pop retval");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop_unclean), &opts);
+	ASSERT_OK(ret, "global_list_push_pop_unclean");
+	ASSERT_OK(opts.retval, "global_list_push_pop_unclean retval");
+
+	ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.bss_private), &key, buf, 0),
+		  "check_and_free_fields");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.map_list_push_pop_multiple), &opts);
+	ASSERT_OK(ret, "map_list_push_pop_multiple");
+	ASSERT_OK(opts.retval, "map_list_push_pop_multiple retval");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop_multiple), &opts);
+	ASSERT_OK(ret, "global_list_push_pop_multiple");
+	ASSERT_OK(opts.retval, "global_list_push_pop_multiple retval");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_push_pop_multiple_unclean), &opts);
+	ASSERT_OK(ret, "global_list_push_pop_multiple_unclean");
+	ASSERT_OK(opts.retval, "global_list_push_pop_multiple_unclean retval");
+
+	ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.bss_private), &key, buf, 0),
+		  "check_and_free_fields");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.map_list_in_list), &opts);
+	ASSERT_OK(ret, "map_list_in_list");
+	ASSERT_OK(opts.retval, "map_list_in_list retval");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_in_list), &opts);
+	ASSERT_OK(ret, "global_list_in_list");
+	ASSERT_OK(opts.retval, "global_list_in_list retval");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_in_list_unclean), &opts);
+	ASSERT_OK(ret, "global_list_in_list_unclean");
+	ASSERT_OK(opts.retval, "global_list_in_list_unclean retval");
+
+	ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.bss_private), &key, buf, 0),
+		  "check_and_free_fields");
+
+	linked_list__destroy(skel);
+}
+
+void test_linked_list(void)
+{
+	test_linked_list_success();
+}
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
new file mode 100644
index 000000000000..0fff427a23a5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_experimental.h"
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
+struct bar {
+	struct bpf_list_node node __kernel;
+	int data;
+};
+
+struct foo {
+	struct bpf_list_node node __kernel;
+	struct bpf_list_head head __kernel __contains(struct, bar, node);
+	struct bpf_spin_lock lock __kernel;
+	int data;
+};
+
+struct map_value {
+	struct bpf_list_head head __contains(struct, foo, node);
+	struct bpf_spin_lock lock;
+	int data;
+};
+
+struct array_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} array_map SEC(".maps");
+
+struct bpf_spin_lock glock SEC(".bss.private");
+struct bpf_list_head ghead __contains(struct, foo, node) SEC(".bss.private");
+struct bpf_list_head gghead __contains(struct, foo, node) SEC(".bss.private");
+
+static struct foo *foo_alloc(void)
+{
+	struct foo *f;
+
+	f = bpf_kptr_alloc(bpf_core_type_id_local(struct foo), 0);
+	if (!f)
+		return NULL;
+	bpf_list_node_init(&f->node);
+	bpf_list_head_init(&f->head);
+	bpf_spin_lock_init(&f->lock);
+	return f;
+}
+
+static void foo_free(struct foo *f)
+{
+	if (!f)
+		return;
+	bpf_list_head_fini(&f->head, offsetof(struct bar, node));
+	bpf_kptr_free(f);
+}
+
+static __always_inline int list_push_pop(void *lock, void *head, bool leave_in_map)
+{
+	struct bpf_list_node *n;
+	struct foo *f;
+
+	f = foo_alloc();
+	if (!f)
+		return 2;
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		foo_free(container_of(n, struct foo, node));
+		foo_free(f);
+		return 3;
+	}
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_back(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		foo_free(container_of(n, struct foo, node));
+		foo_free(f);
+		return 4;
+	}
+
+
+	bpf_spin_lock(lock);
+	bpf_list_add(&f->node, head);
+	f->data = 42;
+	bpf_spin_unlock(lock);
+	if (leave_in_map)
+		return 0;
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_back(head);
+	bpf_spin_unlock(lock);
+	if (!n)
+		return 5;
+	f = container_of(n, struct foo, node);
+	if (f->data != 42) {
+		foo_free(f);
+		return 6;
+	}
+
+	bpf_spin_lock(lock);
+	bpf_list_add(&f->node, head);
+	f->data = 13;
+	bpf_spin_unlock(lock);
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (!n)
+		return 7;
+	f = container_of(n, struct foo, node);
+	if (f->data != 13) {
+		foo_free(f);
+		return 8;
+	}
+	foo_free(f);
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		foo_free(container_of(n, struct foo, node));
+		return 9;
+	}
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_back(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		foo_free(container_of(n, struct foo, node));
+		return 10;
+	}
+	return 0;
+}
+
+
+static __always_inline int list_push_pop_multiple(void *lock, void *head, bool leave_in_map)
+{
+	struct bpf_list_node *n;
+	struct foo *f[8], *pf;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(f); i++) {
+		f[i] = foo_alloc();
+		if (!f[i])
+			return 2;
+		f[i]->data = i;
+		bpf_spin_lock(lock);
+		bpf_list_add(&f[i]->node, head);
+		bpf_spin_unlock(lock);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(f); i++) {
+		bpf_spin_lock(lock);
+		n = bpf_list_pop_front(head);
+		bpf_spin_unlock(lock);
+		if (!n)
+			return 3;
+		pf = container_of(n, struct foo, node);
+		if (pf->data != (ARRAY_SIZE(f) - i - 1)) {
+			foo_free(pf);
+			return 4;
+		}
+		bpf_spin_lock(lock);
+		bpf_list_add_tail(&pf->node, head);
+		bpf_spin_unlock(lock);
+	}
+
+	if (leave_in_map)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(f); i++) {
+		bpf_spin_lock(lock);
+		n = bpf_list_pop_back(head);
+		bpf_spin_unlock(lock);
+		if (!n)
+			return 5;
+		pf = container_of(n, struct foo, node);
+		if (pf->data != i) {
+			foo_free(pf);
+			return 6;
+		}
+		foo_free(pf);
+	}
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_back(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		foo_free(container_of(n, struct foo, node));
+		return 7;
+	}
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		foo_free(container_of(n, struct foo, node));
+		return 8;
+	}
+	return 0;
+}
+
+static __always_inline int list_in_list(void *lock, void *head, bool leave_in_map)
+{
+	struct bpf_list_node *n;
+	struct bar *ba[8], *b;
+	struct foo *f;
+	int i;
+
+	f = foo_alloc();
+	if (!f)
+		return 2;
+	for (i = 0; i < ARRAY_SIZE(ba); i++) {
+		b = bpf_kptr_alloc(bpf_core_type_id_local(struct bar), 0);
+		if (!b) {
+			foo_free(f);
+			return 3;
+		}
+		bpf_list_node_init(&b->node);
+		b->data = i;
+		bpf_spin_lock(&f->lock);
+		bpf_list_add_tail(&b->node, &f->head);
+		bpf_spin_unlock(&f->lock);
+	}
+
+	bpf_spin_lock(lock);
+	bpf_list_add(&f->node, head);
+	f->data = 42;
+	bpf_spin_unlock(lock);
+
+	if (leave_in_map)
+		return 0;
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (!n)
+		return 4;
+	f = container_of(n, struct foo, node);
+	if (f->data != 42) {
+		foo_free(f);
+		return 5;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ba); i++) {
+		bpf_spin_lock(&f->lock);
+		n = bpf_list_pop_front(&f->head);
+		bpf_spin_unlock(&f->lock);
+		if (!n) {
+			foo_free(f);
+			return 6;
+		}
+		b = container_of(n, struct bar, node);
+		if (b->data != i) {
+			foo_free(f);
+			bpf_kptr_free(b);
+			return 7;
+		}
+		bpf_kptr_free(b);
+	}
+	bpf_spin_lock(&f->lock);
+	n = bpf_list_pop_front(&f->head);
+	bpf_spin_unlock(&f->lock);
+	if (n) {
+		foo_free(f);
+		bpf_kptr_free(container_of(n, struct bar, node));
+		return 8;
+	}
+	foo_free(f);
+	return 0;
+}
+
+SEC("tc")
+int map_list_push_pop(void *ctx)
+{
+	struct map_value *v;
+
+	v = bpf_map_lookup_elem(&array_map, &(int){0});
+	if (!v)
+		return 1;
+	return list_push_pop(&v->lock, &v->head, false);
+}
+
+SEC("tc")
+int global_list_push_pop(void *ctx)
+{
+	return list_push_pop(&glock, &ghead, false);
+}
+
+SEC("tc")
+int global_list_push_pop_unclean(void *ctx)
+{
+	return list_push_pop(&glock, &gghead, true);
+}
+
+SEC("tc")
+int map_list_push_pop_multiple(void *ctx)
+{
+	struct map_value *v;
+
+	v = bpf_map_lookup_elem(&array_map, &(int){0});
+	if (!v)
+		return 1;
+	return list_push_pop_multiple(&v->lock, &v->head, false);
+}
+
+SEC("tc")
+int global_list_push_pop_multiple(void *ctx)
+{
+	return list_push_pop_multiple(&glock, &ghead, false);
+}
+
+SEC("tc")
+int global_list_push_pop_multiple_unclean(void *ctx)
+{
+	return list_push_pop_multiple(&glock, &gghead, true);
+}
+
+SEC("tc")
+int map_list_in_list(void *ctx)
+{
+	struct map_value *v;
+
+	v = bpf_map_lookup_elem(&array_map, &(int){0});
+	if (!v)
+		return 1;
+	return list_in_list(&v->lock, &v->head, false);
+}
+
+SEC("tc")
+int global_list_in_list(void *ctx)
+{
+	return list_in_list(&glock, &ghead, false);
+}
+
+SEC("tc")
+int global_list_in_list_unclean(void *ctx)
+{
+	return list_in_list(&glock, &gghead, true);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

