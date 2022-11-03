Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572C6618858
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiKCTL5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiKCTL4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548B01CB1F
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:11:55 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d20so1777845plr.10
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oCwhgZQ7Xnt+S+beUfv9uqIXYJJ8phXFcrA9w3Lfh0=;
        b=LGeOpeRtp6AUiEl8rTkpmp6S8ay2GPW55jhA6IyK+h+/6JuJB+qHtaKM3/dEoVSvCD
         XmvtUuLSOW9xYOeifyUAiE+3pcml8C9nomfB0T1KPp83lRqTBQdG8NAenRoaxM7uJiN3
         FWf5rx0QUOGw7tmHpzWv8+eI7/+/7lc2f5CPLF4/UhXS0FlybwYRzaQlsPNHl6SbS1N/
         H3aigJlWYn7Ay3RBBPZd8/rzvRW3vvsMImuHEcP10MssPkT+v7kSQo7C9wcti4W8+ITl
         7+Hv+gfR66Jg8hOqqwL79Ke8usJWY7Ue+uhV08D1ErNEs7UVcwUmBhLshE6/SbVFLZ4+
         l5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oCwhgZQ7Xnt+S+beUfv9uqIXYJJ8phXFcrA9w3Lfh0=;
        b=2jMbj8S5Yo4XfBx8Obcb1YQHaAN771XOxzdspKJv7bMtLC8qvHxN0d7j4gPhzszUTK
         3pzUtFe777xKEhFrJFztqxBq7b85UwZvZqcUy0ArxIAv6eco+Xb/K+XIthCPSJFIeFuh
         owjhnZfQKojq50pLPvC4rDowU48nA9KkQlQPlLGxCGl5ttuvmQeKBVtxKxGMg1lnvxgd
         nAX7dVZwwWV3YKC46BWSzQ7YncLslCdsQXc9oW6u+fR8e/eT2aA34n481154EaLxkUqc
         8MDoTEVJttni27T3JgDtH1jwIi34XZIPQRwJpFGUxfzpkIDyzlCEmwX7SQr90dyOkqy5
         ukYQ==
X-Gm-Message-State: ACrzQf2JDnO2eFb1gZDpNhQH6z2rs0wR+7+ZpugPUHI6XVL5smMuat17
        Ihl2Dgbe944ElcoeWggYh0TjFcuFwWhp7Q==
X-Google-Smtp-Source: AMsMyM5pbtn4bO+yyDti++sQ/GpYMYGihQo7Yu0nbXwVqPeWN4fwUHyE6yjCbdSGa7VLVOYOJ+l9aw==
X-Received: by 2002:a17:90b:3ec2:b0:215:db2e:b23d with SMTP id rm2-20020a17090b3ec200b00215db2eb23dmr7007174pjb.187.1667502714534;
        Thu, 03 Nov 2022 12:11:54 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id bb16-20020a17090b009000b00212d4cbcbfdsm346496pjb.22.2022.11.03.12.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:11:54 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 24/24] selftests/bpf: Add BPF linked list API tests
Date:   Fri,  4 Nov 2022 00:40:13 +0530
Message-Id: <20221103191013.1236066-25-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13314; i=memxor@gmail.com; h=from:subject; bh=4gZM3pWimB1giLYjtSx0GPxyWEqMUx8kc1pMdyoJ3kw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBICOjIzQPMzmadVJk8W/iRrTYMQ53LX2J3qHyEW mq+s8sqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAgAKCRBM4MiGSL8RyvIcEA CXhoK2QL+FILXCJZaGWiazYkB/u6/0PtELch9GT3QhPXDdKymHJsXfQ4iLZP+JSdZoTZBGmVnF//t6 5Yk550qNV+PYI4vDedfdj2KryvltGXyf2Vz3IaJj8Lmb1uANt+dMoyRTsZjqRPDHAuLNACYDS2XuP0 S6ioA4V605ysWU/wtr/4Y3tQe9YE+5+KrrItRa80FJUyTaev/1L09IP9pLlhQgB8D12bJ+qNhr66v9 4JH0xmgm53bibfP9Mpze6MaCgxe8781q56B1ZbJgAPwyFS4yE/BxMdTfK5V3BMCJnyZseTZHMnE5nE cIpj9/iNTSj4HiNswxHqzhtPbwXWFaqpDQUdvr+c2g/fDMv70iCyDJWux0gAQfkEl8cobc6+EiDMQt wY6LE2lCYtHXF+V6XSBsce28vEYuEK0xGb/NH/0F1P9cL04gYGXc9BCrjRAWEaYYowhPLJSe3wJBQJ 2tPOWmFxYC1t6HKWaOHuqf86KKdll0OkySZc+HugFSTFPSJ1v/Gyyoyt7YDfttQySAV+hWCQEnSQL3 ENNw6uxQXZGxXIqscpz2LWRm/qvnTqJl+42H+oOLqA8A9qJghnBxBODvCeIH9REySBzMgxaeGMa4iG ZvBOjgFSJrALYoMVA9lLCuABuMCVEaVVVwZsADdGGfJATf95T+NSuIelFNig==
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
 .../selftests/bpf/prog_tests/linked_list.c    |  79 +++++
 .../testing/selftests/bpf/progs/linked_list.c | 330 ++++++++++++++++++
 4 files changed, 414 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 0acd87ed22fc..db4398a5bb35 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1839,7 +1839,10 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 
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
index be4e3d47ea3e..072243af93b0 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -33,6 +33,7 @@ ksyms_module                             # test_ksyms_module__open_and_load unex
 ksyms_module_libbpf                      # JIT does not support calling kernel function                                (kfunc)
 ksyms_module_lskel                       # test_ksyms_module_lskel__open_and_load unexpected error: -9                 (?)
 libbpf_get_fd_by_id_opts                 # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
+linked_list				 # JIT does not support calling kernel function                                (kfunc)
 lookup_key                               # JIT does not support calling kernel function                                (kfunc)
 lru_bug                                  # prog 'printk': failed to auto-attach: -524
 map_kptr                                 # failed to open_and_load program: -524 (trampoline)
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
new file mode 100644
index 000000000000..a017bc1b7b0a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <network_helpers.h>
+
+#include "linked_list.skel.h"
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
+	ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.data_A), &key, buf, 0),
+		  "check_and_free_fields");
+	ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.array_map), &key, buf, 0),
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
+	ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.data_A), &key, buf, 0),
+		  "check_and_free_fields");
+	ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.array_map), &key, buf, 0),
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
+	ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.data_A), &key, buf, 0),
+		  "check_and_free_fields");
+	ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel->maps.array_map), &key, buf, 0),
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
index 000000000000..eed0b2c1eb4a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -0,0 +1,330 @@
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
+#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
+
+private(A) static struct bpf_spin_lock glock;
+private(A) static struct bpf_list_head ghead __contains(foo, node);
+private(A) static struct bpf_list_head gghead __contains(foo, node);
+
+static __always_inline int list_push_pop(struct bpf_spin_lock *lock,
+					 struct bpf_list_head *head, bool leave_in_map)
+{
+	struct bpf_list_node *n;
+	struct foo *f;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 2;
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_obj_drop(container_of(n, struct foo, node));
+		bpf_obj_drop(f);
+		return 3;
+	}
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_back(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_obj_drop(container_of(n, struct foo, node));
+		bpf_obj_drop(f);
+		return 4;
+	}
+
+
+	bpf_spin_lock(lock);
+	f->data = 42;
+	bpf_list_push_front(head, &f->node);
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
+		bpf_obj_drop(f);
+		return 6;
+	}
+
+	bpf_spin_lock(lock);
+	f->data = 13;
+	bpf_list_push_front(head, &f->node);
+	bpf_spin_unlock(lock);
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (!n)
+		return 7;
+	f = container_of(n, struct foo, node);
+	if (f->data != 13) {
+		bpf_obj_drop(f);
+		return 8;
+	}
+	bpf_obj_drop(f);
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_obj_drop(container_of(n, struct foo, node));
+		return 9;
+	}
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_back(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_obj_drop(container_of(n, struct foo, node));
+		return 10;
+	}
+	return 0;
+}
+
+
+static __always_inline int list_push_pop_multiple(struct bpf_spin_lock *lock,
+						  struct bpf_list_head *head, bool leave_in_map)
+{
+	struct bpf_list_node *n;
+	struct foo *f[8], *pf;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(f); i++) {
+		f[i] = bpf_obj_new(typeof(**f));
+		if (!f[i])
+			return 2;
+		f[i]->data = i;
+		bpf_spin_lock(lock);
+		bpf_list_push_front(head, &f[i]->node);
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
+			bpf_obj_drop(pf);
+			return 4;
+		}
+		bpf_spin_lock(lock);
+		bpf_list_push_back(head, &pf->node);
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
+			bpf_obj_drop(pf);
+			return 6;
+		}
+		bpf_obj_drop(pf);
+	}
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_back(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_obj_drop(container_of(n, struct foo, node));
+		return 7;
+	}
+
+	bpf_spin_lock(lock);
+	n = bpf_list_pop_front(head);
+	bpf_spin_unlock(lock);
+	if (n) {
+		bpf_obj_drop(container_of(n, struct foo, node));
+		return 8;
+	}
+	return 0;
+}
+
+static __always_inline int list_in_list(struct bpf_spin_lock *lock,
+					struct bpf_list_head *head, bool leave_in_map)
+{
+	struct bpf_list_node *n;
+	struct bar *ba[8], *b;
+	struct foo *f;
+	int i;
+
+	f = bpf_obj_new(typeof(*f));
+	if (!f)
+		return 2;
+	for (i = 0; i < ARRAY_SIZE(ba); i++) {
+		b = bpf_obj_new(typeof(*b));
+		if (!b) {
+			bpf_obj_drop(f);
+			return 3;
+		}
+		b->data = i;
+		bpf_spin_lock(&f->lock);
+		bpf_list_push_back(&f->head, &b->node);
+		bpf_spin_unlock(&f->lock);
+	}
+
+	bpf_spin_lock(lock);
+	f->data = 42;
+	bpf_list_push_front(head, &f->node);
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
+		bpf_obj_drop(f);
+		return 5;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ba); i++) {
+		bpf_spin_lock(&f->lock);
+		n = bpf_list_pop_front(&f->head);
+		bpf_spin_unlock(&f->lock);
+		if (!n) {
+			bpf_obj_drop(f);
+			return 6;
+		}
+		b = container_of(n, struct bar, node);
+		if (b->data != i) {
+			bpf_obj_drop(f);
+			bpf_obj_drop(b);
+			return 7;
+		}
+		bpf_obj_drop(b);
+	}
+	bpf_spin_lock(&f->lock);
+	n = bpf_list_pop_front(&f->head);
+	bpf_spin_unlock(&f->lock);
+	if (n) {
+		bpf_obj_drop(f);
+		bpf_obj_drop(container_of(n, struct bar, node));
+		return 8;
+	}
+	bpf_obj_drop(f);
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
2.38.1

