Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C55A5FD4C5
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJMGY5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJMGY4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:24:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7571F2FA
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d24so962932pls.4
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghFRpgH15UJe1Lrs71Ulg8wJUyIqEfeI+MNIZP9ENSs=;
        b=LRls6O+cGG+r0joaywDpXIs2wIJ4KJm5YXCs4wiX2v13RHSjL4dcivHyFsoyixRRSO
         ZanVdUbcMBPky5HyXuVJFbP8CsJEz3wpsdM0WmPV1eDNficfAayx329+qUCgPiaIpEvi
         Q0zcxMbxWJmtEidsd72MnZ9G9XPVn3UqD2Bykfv7hcUEbC4S9L2r0ODOykEX7bLOBfz3
         BRl31JxDUcWaoXMvnxcX5V5qGEYNccM6j4MkURdaWnuCWQhCL/jhbXgvnPQe0Wv+7I5V
         amdMhlhaWSCHQwXhzJkwEju1hmcNN+FFfpQUsdBKwv1zyxDkS9/PtPowY4lwRXnYI+Lg
         n1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghFRpgH15UJe1Lrs71Ulg8wJUyIqEfeI+MNIZP9ENSs=;
        b=AXQmg1ZYWJ0yCRJL0KTRtz/1+0Mh1shub33frFjEzEZFd4vbxKmacldWfBetud7AZY
         IZpcPLWbKdhLSfW5m8x+mG1LNuecns3gIC8GuXYT5HxV63xh4uM728tXULeVGaHJjUYj
         MSiI5+QBGFVuqi+H1Qt+KKqhsBpNHnxDYJwUl5MHoPG08llQldtxKqAw0CIeYr+WQylQ
         6mPH6BKxxtpw8IXjreiiDYaaO8Ec4/4ZO57KGGTgBplgjL/UnqrE0OMQyaesTHRrW/v4
         YdfJmFfwMeZWbcG8/lacRpJoDctHBlJpIp5nWcibzV+4Gg1loh3EWolDVEWIlt8HweYj
         FBYw==
X-Gm-Message-State: ACrzQf1cFYwFoUZkqyNgaQK4aXn3Ade1Dm9A/xy6a6o0kShMaUeRj0uh
        1kABp5HG5MKHwUrC2E7A7vx7iAxkrmY=
X-Google-Smtp-Source: AMsMyM5yzVKzoMThjtl3BxAAhWdXuGigRPvJDmnUI0elMn2mliuyyTZ4pXgaV7xbnsy2yXpQmdmDyg==
X-Received: by 2002:a17:903:22d0:b0:180:a0b9:77 with SMTP id y16-20020a17090322d000b00180a0b90077mr28407268plg.71.1665642291277;
        Wed, 12 Oct 2022 23:24:51 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001743ba85d39sm11554424pll.110.2022.10.12.23.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:24:50 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 25/25] selftests/bpf: Add BPF linked list API tests
Date:   Thu, 13 Oct 2022 11:53:03 +0530
Message-Id: <20221013062303.896469-26-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13011; i=memxor@gmail.com; h=from:subject; bh=RFN1iHBiB/PvMLvFf+cdm17Hg0NnTExk9lvbW2wC3TM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67EmwTidW7hUgmXva56xC/xt8H50xt2kvNo64/I b+/tmkeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euxAAKCRBM4MiGSL8RynwkEA ChmgB9wFAsXtBnKQAojrX5WYpsu9/gwVe1PnaaPDV7VCaF7iJmA44NKMKa0DOvDDblqt95WTdnoycB 7A/jl14+jEH5+nIRpqdwfrGMj4sMHdiM0GY6mmyg9tzB4Nh+50t34U0ccl3tHc1TDVF4LqRwO3oWkW fHpM6tR4ur6PEbXV9jiddGgYghAqj/W/tcf1RGRQhK0MOeoSpGYzdC+qQb1d6PP5FowKumZ3eoTicq cDnmosNuyU5FiM78eZq8XiwDjgtcU4uBF0kzy5lImYCVNa9sX0ooy6kC6TXmJUVt8tkm67NvPG2GS6 im7JEirVW43+RfTfa9sRhYUYqAEth1bq4Omq0GdT4f7hZ1UTieG0qFGO2vURVqJox75RWS4JEIJncn /kegiqWctHiALvxDpaz4Vm4NBmsLumg37lRJUGSPOcrAF9CeTJP/GD9yodaJhr6psBPcGp0VVKufa1 TrUnEOL1cIyh8icb8ZBAj4NxXnDtEegAQziIAhC5o/fX5fmSx+Ky4XweAfQXpnUQoRDcE0zz+mM7ng 9cTRtko40+NyaL9XnZMCQmSYaAwmZsKqjZyWIBH2Z28fiTMntPindEWfxP1o51BJ5DU80LMSi3B8lv 1wPgzmvrIs2FboxJxfDHz9TCWRD5HtidxLDqqvpKEXNG3O1EJrXF4TPo+CKQ==
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
index 71e0f19f738a..6f012aa44ebe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1833,7 +1833,10 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 
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
index 520f12229b98..d13e908da387 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -32,6 +32,7 @@ ksyms_module                             # test_ksyms_module__open_and_load unex
 ksyms_module_libbpf                      # JIT does not support calling kernel function                                (kfunc)
 ksyms_module_lskel                       # test_ksyms_module_lskel__open_and_load unexpected error: -9                 (?)
 libbpf_get_fd_by_id_opts                 # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
+linked_list				 # JIT does not support calling kernel function                                (kfunc)
 lookup_key                               # JIT does not support calling kernel function                                (kfunc)
 lru_bug                                  # prog 'printk': failed to auto-attach: -524
 map_kptr                                 # failed to open_and_load program: -524 (trampoline)
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
2.38.0

