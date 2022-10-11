Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204175FAA1A
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiJKB2K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJKB2F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:28:05 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D14B11A3A
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:28:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id i3so2626549pfc.11
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4+ekUqIZd5eL09ZPjvNVNPvbG6BayKOu2Lhkt7vOIs=;
        b=mpNAbJmAUfmWZg2Y8ibO+GKRnloWY3KrVsgANXn8AiCo2fe4cgxp6N+oOavkKmDzGo
         L337kcfjsR9DgEUvUk+Fgx6VGA4eHukIdK0FHndGKoFbUlYKr4JtB30l0gUa4EQus/Rj
         MQVXs8ToRy2FxsJpyeltDE6tBW55Or+X6o81Rjp6JQalU+weAoap1+fcLvq++41XoDuX
         zDCr4G6e+6f2bOhEwm3rS4c80PeoIHXejDOeUqtcOqcovSESxkjx360/mqcZUToOO3wJ
         PXGSinO1QrCycTv8X4qQ/mFwLgnSzjkof0071MgtogIbNlrGwUsZ9rDJ2itdIHYAQxB9
         DPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4+ekUqIZd5eL09ZPjvNVNPvbG6BayKOu2Lhkt7vOIs=;
        b=bJJVa1MbhKXhNa1RG9uTt54IBjkjArkTqPAKiPoaSWeX/iao5F1+3vQtdJTVFiqwYn
         2uhpgpRkHxg4/5aNl0g7ONlto9JyxP2+rozOpP1Y/yd3llOeQ7RwJH+NTq5IKgcTvWKZ
         IRoEVFTMAsyvN+4TlwRzKoOq/5YEeOuh9sRSstEMLsuWyedQZkcRCIhRYIT5x62/shR7
         Jne9UP1gFYoTxTkABUX5O0yWaAdGXDtKMxQkfc9T7y7I2+3m6iR9ojBlIY1saJJK08R6
         Mi16LO9wQrm4xACWNfnXkn/+kHsRK8/cA9cPuHCD15EUTibeGjR5aJGuJTZh1uFFNbNU
         qYOA==
X-Gm-Message-State: ACrzQf1obVjP9fqhI5ZdY5rlA7Boi79iIY05e240BKQYrR59ENaAFu7c
        rfpuRBLcBpvsP26I5NWEiYy6iPGAm86+9w==
X-Google-Smtp-Source: AMsMyM7vhERIIz/Tl6Z/pyAfFOisAm99gR2WCGzgMWBFqytV7SE62q1SJLYYwPul0JmI9ZZZfunysQ==
X-Received: by 2002:a05:6a00:1ace:b0:546:94a3:b235 with SMTP id f14-20020a056a001ace00b0054694a3b235mr22831401pfv.50.1665451683447;
        Mon, 10 Oct 2022 18:28:03 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902db1200b0017b69f99321sm7286603plx.219.2022.10.10.18.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:28:03 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 25/25] selftests/bpf: Add BPF linked list API tests
Date:   Tue, 11 Oct 2022 06:52:40 +0530
Message-Id: <20221011012240.3149-26-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12702; i=memxor@gmail.com; h=from:subject; bh=vb+9cai0yfiEi0iSjRhBPgyvrn6f4DOvacv+qC/VKIQ=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUcsnRYvkktsIoLXFLB3ELLmPDuhuu8Jr55MW8B a4KzXxOJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFHAAKCRBM4MiGSL8RytRBEA CI0Q7GcP6k30BdtC5APNuAYD8RglzFdfA4WawWk3Cj57Ghz5QFCaSyeL3tkF7EHS3vtl34PT45IWuS ADx9V0hV8dqucOPIBFuaC0vJ7YOE84uI8yZ5WgYAIFl2DJUUaSf4WLQipcKSwS77GINApm+ud+Y+6N +SiepJfgdpk0MsyVd6XLpRbF09RFHkLLBoYVMrn9Gax7tgkqygS0xwmp7zRsK8490pXDZrG9ulVc6a GSLbSYLG5AFO0WylO6jcK/hepK7nSTHpwzCd1aWD7c8ufCl8bxoYQXDj9VDiWYckjnYNVZIdKgx0Sg uzNHM1n9yxM0GRdOPKemVI1WZ/sXj4QYFgn2LqxQL6LNUw1yqZV9+kgmDnuIS1uo7g1SGqmuUMkdSk PRNN0fBW/rGMwwqzANvOWK9WGk4PPgzS0SgeZJ7CMOK/0iYUjUQ+GLdPWAJ6OCTzQPZL/gtu4ZF9qb WPxT1LsBShhvSklnsrN9UvrOEfqlbiBITkmGljLo4gZCwpddZctgb6O3vamT/xP3Nb2vG+UemBG3Lk gcDwSMuYdHqWKheWeR2X9y1XUH+ZFKSpIP4+tt1i1uj3k+qGV40dWaLKVbtsL1SpOrcz16BhKDNXQ9 SRGsmXXhEz6cFUcvg7RiBlaUCQF/eAVZbHIUaWwaXG6/gey5hLAunCA+msLA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/linked_list.c    |  88 +++++
 .../testing/selftests/bpf/progs/linked_list.c | 325 ++++++++++++++++++
 4 files changed, 418 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5cbd5a02a460..02813f1dded1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1830,7 +1830,10 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 
 static int __init kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
 }
 
 late_initcall(kfunc_init);
diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 0fb03b8047d5..1a59524516df 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -76,3 +76,4 @@ lookup_key                               # JIT does not support calling kernel f
 verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
 kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
 deny_namespace                           # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
+linked_list				 # JIT does not support calling kernel function                                (kfunc)
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
index 000000000000..1b228ada7d2c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -0,0 +1,325 @@
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
+	struct bpf_list_node node;
+	int data;
+};
+
+struct foo {
+	struct bpf_list_node node;
+	struct bpf_list_head head __contains(bar, node);
+	struct bpf_spin_lock lock;
+	int data;
+};
+
+struct map_value {
+	struct bpf_list_head head __contains(foo, node);
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
+struct bpf_list_head ghead __contains(foo, node) SEC(".bss.private");
+struct bpf_list_head gghead __contains(foo, node) SEC(".bss.private");
+
+static __always_inline int list_push_pop(void *lock, void *head, bool leave_in_map)
+{
+	struct bpf_list_node *n;
+	struct foo *f;
+
+	f = bpf_kptr_new(typeof(*f));
+	if (!f)
+		return 2;
+
+	bpf_spin_lock(lock);
+	n = bpf_list_del(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_kptr_drop(container_of(n, struct foo, node));
+		bpf_kptr_drop(f);
+		return 3;
+	}
+
+	bpf_spin_lock(lock);
+	n = bpf_list_del_tail(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_kptr_drop(container_of(n, struct foo, node));
+		bpf_kptr_drop(f);
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
+	n = bpf_list_del_tail(head);
+	bpf_spin_unlock(lock);
+	if (!n)
+		return 5;
+	f = container_of(n, struct foo, node);
+	if (f->data != 42) {
+		bpf_kptr_drop(f);
+		return 6;
+	}
+
+	bpf_spin_lock(lock);
+	bpf_list_add(&f->node, head);
+	f->data = 13;
+	bpf_spin_unlock(lock);
+	bpf_spin_lock(lock);
+	n = bpf_list_del(head);
+	bpf_spin_unlock(lock);
+	if (!n)
+		return 7;
+	f = container_of(n, struct foo, node);
+	if (f->data != 13) {
+		bpf_kptr_drop(f);
+		return 8;
+	}
+	bpf_kptr_drop(f);
+
+	bpf_spin_lock(lock);
+	n = bpf_list_del(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_kptr_drop(container_of(n, struct foo, node));
+		return 9;
+	}
+
+	bpf_spin_lock(lock);
+	n = bpf_list_del_tail(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_kptr_drop(container_of(n, struct foo, node));
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
+		f[i] = bpf_kptr_new(typeof(**f));
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
+		n = bpf_list_del(head);
+		bpf_spin_unlock(lock);
+		if (!n)
+			return 3;
+		pf = container_of(n, struct foo, node);
+		if (pf->data != (ARRAY_SIZE(f) - i - 1)) {
+			bpf_kptr_drop(pf);
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
+		n = bpf_list_del_tail(head);
+		bpf_spin_unlock(lock);
+		if (!n)
+			return 5;
+		pf = container_of(n, struct foo, node);
+		if (pf->data != i) {
+			bpf_kptr_drop(pf);
+			return 6;
+		}
+		bpf_kptr_drop(pf);
+	}
+	bpf_spin_lock(lock);
+	n = bpf_list_del_tail(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_kptr_drop(container_of(n, struct foo, node));
+		return 7;
+	}
+
+	bpf_spin_lock(lock);
+	n = bpf_list_del(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_kptr_drop(container_of(n, struct foo, node));
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
+	f = bpf_kptr_new(typeof(*f));
+	if (!f)
+		return 2;
+	for (i = 0; i < ARRAY_SIZE(ba); i++) {
+		b = bpf_kptr_new(typeof(*b));
+		if (!b) {
+			bpf_kptr_drop(f);
+			return 3;
+		}
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
+	n = bpf_list_del(head);
+	bpf_spin_unlock(lock);
+	if (!n)
+		return 4;
+	f = container_of(n, struct foo, node);
+	if (f->data != 42) {
+		bpf_kptr_drop(f);
+		return 5;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ba); i++) {
+		bpf_spin_lock(&f->lock);
+		n = bpf_list_del(&f->head);
+		bpf_spin_unlock(&f->lock);
+		if (!n) {
+			bpf_kptr_drop(f);
+			return 6;
+		}
+		b = container_of(n, struct bar, node);
+		if (b->data != i) {
+			bpf_kptr_drop(f);
+			bpf_kptr_drop(b);
+			return 7;
+		}
+		bpf_kptr_drop(b);
+	}
+	bpf_spin_lock(&f->lock);
+	n = bpf_list_del(&f->head);
+	bpf_spin_unlock(&f->lock);
+	if (n) {
+		bpf_kptr_drop(f);
+		bpf_kptr_drop(container_of(n, struct bar, node));
+		return 8;
+	}
+	bpf_kptr_drop(f);
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

