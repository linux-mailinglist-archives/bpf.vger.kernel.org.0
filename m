Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6134E6A2A88
	for <lists+bpf@lfdr.de>; Sat, 25 Feb 2023 16:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjBYPkX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Feb 2023 10:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBYPkW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Feb 2023 10:40:22 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930C013D76
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 07:40:19 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id o15so6362774edr.13
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 07:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD/mc1LmfnxgHNmQmK7JRIeSTn2yxhkXy4Q0SoOGquM=;
        b=MWbg7KF323niT8xTO6F4ACa1jtxtsB9Zqc1mF1qksivTKDd6AGD/5w8wKFyzyTqVGc
         dj0knhJxNLN13ndmdGJt/S6XSKL9fTTxr8I+NRE0o6rZ9f4LxCg0NQX6YwiiJ6Xy0WEs
         m3WzT+K1Et7WxP6BXiRoIQvUCrvdDqq9Hie/E5j+mp8w3a6DN1VotYKYXohd28VssgCU
         7/PRPzSFeF8A2wjgCxFz4sXkahY5eSyVSw73CF6a0C2ZiHB8LnosPAYvbdIAvWmUcThf
         gmuEpXnI9zolIGwOm8ACXBgI1Q5ety8/DtfC13Bbh6AIawF1roBc+wVc7Txi27Wpuq5e
         kapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zD/mc1LmfnxgHNmQmK7JRIeSTn2yxhkXy4Q0SoOGquM=;
        b=YUiuD5s9rk9LTIOt4j1PYNzkex+vNOIrT/xNpWTsEIEYhxGEcustMjWYs5gSWJU7DB
         xVK6b1vt/OH7iK1cZnLrL2tsm80fbVP6sGFM40McUWi8mk4SuFiCixDNxtREsR8Jk90T
         JxzqP0+vT6M2dpAoaIZgTZr3YpMGHfqEjRv9Bd/rZuqu1lBGMVNhgCHHbNptHp9aqdOq
         lA6+EQnZG3ccBUx78P17M9d0XBiO3oP88hZJTvwJr3WUR+aHr31gmL5zgMdB5HhvAwwb
         uK/ApOldszl9EaO7pkPkZQ6w4OSvacsZ2nCjingKxcNAps1O55JZgMe0yxJtPNXJgnHW
         uzSg==
X-Gm-Message-State: AO0yUKVHjKw77enRxIfMlrejVZ81y/W2cp0QRt53u5LwoRhffIKF+Ru5
        Vn2mSFWmvmhKp2d0jL8B7gOe7iphzOqsrw==
X-Google-Smtp-Source: AK7set+sMnDcTyo8AO6QP2OtonsLy0PMZfLhXW62Fe00D+S1XhddVX0w4mKAU4B/iUmsy2nU/q+pWQ==
X-Received: by 2002:a17:907:8c06:b0:8e3:86ef:505b with SMTP id ta6-20020a1709078c0600b008e386ef505bmr19514383ejc.21.1677339617339;
        Sat, 25 Feb 2023 07:40:17 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:30])
        by smtp.gmail.com with ESMTPSA id m5-20020a170906234500b008d9c518a318sm951140eja.142.2023.02.25.07.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 07:40:16 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add more tests for kptrs in maps
Date:   Sat, 25 Feb 2023 16:40:10 +0100
Message-Id: <20230225154010.391965-4-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225154010.391965-1-memxor@gmail.com>
References: <20230225154010.391965-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20731; i=memxor@gmail.com; h=from:subject; bh=HD608qFKl594YjCl2Nzw1XXhkHBPzjs0Fw+3//cmScc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj+itK6rn4+b/yGFrIYO6IO1BjoCzaDHfjLeiKTWyG qvWsWv2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/orSgAKCRBM4MiGSL8Rytz+EA CnLCwkuCB16ekJ2LjwNkSZpgb5IS3AR3Aw5hb+NU6H2JJpeKfZSnI0l5Ca75I5CIocrJSCaC9Rnbwl yuuUOv3C/PYPmyGevnQ5BJoaJfi6OMX/pzdcoo/HNWglN36BLAwSQ+QXdhS2at41z9+TsojK0bCAi+ hGJNBdlT64eGwWWUDaemQuocl5TBKuC0vwWeJafA4Yqamk1MSTzINiVgeL/ZpQ4k46K/FEk/UN1Skx qlrARze+r3IvAMCqmvTOgxDYcUKqePZSifcDRHH++5kcnMlDwTVPVuT4pAfwBf9O37KmrMewuNc3H7 yh7oaQSjbCJX5v1oC2sB9PqCxwm1gpH7S7Gdp9mo+rZC0D40B/FeVLLRT8LCHXAmg/21aUUyFzLbjA 5v4s6ju4d5FCysDTs0uqxtIqHmRhG1X07OB8so/dKmABoUWbWWHq33xSbGFBg7SlnJ6xaj+mP9VzIb 4ZFADn+JH32lY/6SNlCCg54gnzAzx8MC/eZWzdu2bvOb53o8NP5LiYuhf+pbGSrG3q7oWQww9hsien 0amfI7u2EtQpyctpr/ciiJkXqJlKOuD3xsKdSdcol4ss6XveleMjS3I0YdCg9XAp+gVrsrfyFkoEM4 f21d6MGfr6jrdLNVSuxqRAsV7X1Tm55gUmmo1l7RTpxq8cPeA8JcOpk9iglA==
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

Firstly, ensure programs successfully load when using all of the
supported maps. Then, extend existing tests to test more cases at
runtime. We are currently testing both the synchronous freeing of items
and asynchronous destruction when map is freed, but the code needs to be
adjusted a bit to be able to also accomodate support for percpu maps.

We now do a delete on the item (and update for array maps which has a
similar effect for kptrs) to perform a synchronous free of the kptr, and
test destruction both for the synchronous and asynchronous deletion.
Next time the program runs, it should observe the refcount as 1 since
all existing references should have been released by then. By running
the program after both possible paths freeing kptrs, we establish that
they correctly release resources. Next, we augment the existing test to
also test the same code path shared by all local storage maps using a
task local storage map.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/map_kptr.c       | 136 +++++--
 tools/testing/selftests/bpf/progs/map_kptr.c  | 344 +++++++++++++++---
 .../selftests/bpf/progs/rcu_tasks_trace_gp.c  |  36 ++
 3 files changed, 451 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/rcu_tasks_trace_gp.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index 3533a4ecad01..8743df599567 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -4,70 +4,160 @@
 
 #include "map_kptr.skel.h"
 #include "map_kptr_fail.skel.h"
+#include "rcu_tasks_trace_gp.skel.h"
 
 static void test_map_kptr_success(bool test_run)
 {
+	LIBBPF_OPTS(bpf_test_run_opts, lopts);
 	LIBBPF_OPTS(bpf_test_run_opts, opts,
 		.data_in = &pkt_v4,
 		.data_size_in = sizeof(pkt_v4),
 		.repeat = 1,
 	);
+	int key = 0, ret, cpu;
 	struct map_kptr *skel;
-	int key = 0, ret;
-	char buf[16];
+	char buf[16], *pbuf;
 
 	skel = map_kptr__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "map_kptr__open_and_load"))
 		return;
 
-	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref), &opts);
-	ASSERT_OK(ret, "test_map_kptr_ref refcount");
-	ASSERT_OK(opts.retval, "test_map_kptr_ref retval");
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref1), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref1 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref1 retval");
 	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref2), &opts);
 	ASSERT_OK(ret, "test_map_kptr_ref2 refcount");
 	ASSERT_OK(opts.retval, "test_map_kptr_ref2 retval");
 
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_ls_map_kptr_ref1), &lopts);
+	ASSERT_OK(ret, "test_ls_map_kptr_ref1 refcount");
+	ASSERT_OK(lopts.retval, "test_ls_map_kptr_ref1 retval");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_ls_map_kptr_ref2), &lopts);
+	ASSERT_OK(ret, "test_ls_map_kptr_ref2 refcount");
+	ASSERT_OK(lopts.retval, "test_ls_map_kptr_ref2 retval");
+
 	if (test_run)
 		goto exit;
 
+	cpu = libbpf_num_possible_cpus();
+	if (!ASSERT_GT(cpu, 0, "libbpf_num_possible_cpus"))
+		goto exit;
+
+	pbuf = calloc(cpu, sizeof(buf));
+	if (!ASSERT_OK_PTR(pbuf, "calloc(pbuf)"))
+		goto exit;
+
 	ret = bpf_map__update_elem(skel->maps.array_map,
 				   &key, sizeof(key), buf, sizeof(buf), 0);
 	ASSERT_OK(ret, "array_map update");
-	ret = bpf_map__update_elem(skel->maps.array_map,
-				   &key, sizeof(key), buf, sizeof(buf), 0);
-	ASSERT_OK(ret, "array_map update2");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
+
+	ret = bpf_map__update_elem(skel->maps.pcpu_array_map,
+				   &key, sizeof(key), pbuf, cpu * sizeof(buf), 0);
+	ASSERT_OK(ret, "pcpu_array_map update");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
-	ret = bpf_map__update_elem(skel->maps.hash_map,
-				   &key, sizeof(key), buf, sizeof(buf), 0);
-	ASSERT_OK(ret, "hash_map update");
 	ret = bpf_map__delete_elem(skel->maps.hash_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "hash_map delete");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
+
+	ret = bpf_map__delete_elem(skel->maps.pcpu_hash_map, &key, sizeof(key), 0);
+	ASSERT_OK(ret, "pcpu_hash_map delete");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
-	ret = bpf_map__update_elem(skel->maps.hash_malloc_map,
-				   &key, sizeof(key), buf, sizeof(buf), 0);
-	ASSERT_OK(ret, "hash_malloc_map update");
 	ret = bpf_map__delete_elem(skel->maps.hash_malloc_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "hash_malloc_map delete");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
+
+	ret = bpf_map__delete_elem(skel->maps.pcpu_hash_malloc_map, &key, sizeof(key), 0);
+	ASSERT_OK(ret, "pcpu_hash_malloc_map delete");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
-	ret = bpf_map__update_elem(skel->maps.lru_hash_map,
-				   &key, sizeof(key), buf, sizeof(buf), 0);
-	ASSERT_OK(ret, "lru_hash_map update");
 	ret = bpf_map__delete_elem(skel->maps.lru_hash_map, &key, sizeof(key), 0);
 	ASSERT_OK(ret, "lru_hash_map delete");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
+
+	ret = bpf_map__delete_elem(skel->maps.lru_pcpu_hash_map, &key, sizeof(key), 0);
+	ASSERT_OK(ret, "lru_pcpu_hash_map delete");
+	skel->data->ref--;
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_map_kptr_ref3), &opts);
+	ASSERT_OK(ret, "test_map_kptr_ref3 refcount");
+	ASSERT_OK(opts.retval, "test_map_kptr_ref3 retval");
 
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_ls_map_kptr_ref_del), &lopts);
+	ASSERT_OK(ret, "test_ls_map_kptr_ref_del delete");
+	skel->data->ref--;
+	ASSERT_OK(lopts.retval, "test_ls_map_kptr_ref_del retval");
+
+	free(pbuf);
 exit:
 	map_kptr__destroy(skel);
 }
 
-void test_map_kptr(void)
+static int kern_sync_rcu_tasks_trace(struct rcu_tasks_trace_gp *rcu)
 {
-	if (test__start_subtest("success")) {
+	long gp_seq = READ_ONCE(rcu->bss->gp_seq);
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+
+	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(rcu->progs.do_call_rcu_tasks_trace),
+					      &opts), "do_call_rcu_tasks_trace"))
+		return -EFAULT;
+	if (!ASSERT_OK(opts.retval, "opts.retval == 0"))
+		return -EFAULT;
+	while (gp_seq == READ_ONCE(rcu->bss->gp_seq))
+		sched_yield();
+	return 0;
+}
+
+void serial_test_map_kptr(void)
+{
+	struct rcu_tasks_trace_gp *skel;
+
+	RUN_TESTS(map_kptr_fail);
+
+	skel = rcu_tasks_trace_gp__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "rcu_tasks_trace_gp__open_and_load"))
+		return;
+	if (!ASSERT_OK(rcu_tasks_trace_gp__attach(skel), "rcu_tasks_trace_gp__attach"))
+		goto end;
+
+	if (test__start_subtest("success-map")) {
+		test_map_kptr_success(true);
+
+		ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
+		ASSERT_OK(kern_sync_rcu(), "sync rcu");
+		/* Observe refcount dropping to 1 on bpf_map_free_deferred */
 		test_map_kptr_success(false);
-		/* Do test_run twice, so that we see refcount going back to 1
-		 * after we leave it in map from first iteration.
-		 */
+
+		ASSERT_OK(kern_sync_rcu_tasks_trace(skel), "sync rcu_tasks_trace");
+		ASSERT_OK(kern_sync_rcu(), "sync rcu");
+		/* Observe refcount dropping to 1 on synchronous delete elem */
 		test_map_kptr_success(true);
 	}
 
-	RUN_TESTS(map_kptr_fail);
+end:
+	rcu_tasks_trace_gp__destroy(skel);
+	return;
 }
diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index 228ec45365a8..a24d17bc17eb 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -15,6 +15,13 @@ struct array_map {
 	__uint(max_entries, 1);
 } array_map SEC(".maps");
 
+struct pcpu_array_map {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} pcpu_array_map SEC(".maps");
+
 struct hash_map {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, int);
@@ -22,6 +29,13 @@ struct hash_map {
 	__uint(max_entries, 1);
 } hash_map SEC(".maps");
 
+struct pcpu_hash_map {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} pcpu_hash_map SEC(".maps");
+
 struct hash_malloc_map {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, int);
@@ -30,6 +44,14 @@ struct hash_malloc_map {
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 } hash_malloc_map SEC(".maps");
 
+struct pcpu_hash_malloc_map {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} pcpu_hash_malloc_map SEC(".maps");
+
 struct lru_hash_map {
 	__uint(type, BPF_MAP_TYPE_LRU_HASH);
 	__type(key, int);
@@ -37,6 +59,41 @@ struct lru_hash_map {
 	__uint(max_entries, 1);
 } lru_hash_map SEC(".maps");
 
+struct lru_pcpu_hash_map {
+	__uint(type, BPF_MAP_TYPE_LRU_PERCPU_HASH);
+	__type(key, int);
+	__type(value, struct map_value);
+	__uint(max_entries, 1);
+} lru_pcpu_hash_map SEC(".maps");
+
+struct cgrp_ls_map {
+	__uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct map_value);
+} cgrp_ls_map SEC(".maps");
+
+struct task_ls_map {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct map_value);
+} task_ls_map SEC(".maps");
+
+struct inode_ls_map {
+	__uint(type, BPF_MAP_TYPE_INODE_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct map_value);
+} inode_ls_map SEC(".maps");
+
+struct sk_ls_map {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct map_value);
+} sk_ls_map SEC(".maps");
+
 #define DEFINE_MAP_OF_MAP(map_type, inner_map_type, name)       \
 	struct {                                                \
 		__uint(type, map_type);                         \
@@ -160,6 +217,58 @@ int test_map_kptr(struct __sk_buff *ctx)
 	return 0;
 }
 
+SEC("tp_btf/cgroup_mkdir")
+int BPF_PROG(test_cgrp_map_kptr, struct cgroup *cgrp, const char *path)
+{
+	struct map_value *v;
+
+	v = bpf_cgrp_storage_get(&cgrp_ls_map, cgrp, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (v)
+		test_kptr(v);
+	return 0;
+}
+
+SEC("lsm/inode_unlink")
+int BPF_PROG(test_task_map_kptr, struct inode *inode, struct dentry *victim)
+{
+	struct task_struct *task;
+	struct map_value *v;
+
+	task = bpf_get_current_task_btf();
+	if (!task)
+		return 0;
+	v = bpf_task_storage_get(&task_ls_map, task, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (v)
+		test_kptr(v);
+	return 0;
+}
+
+SEC("lsm/inode_unlink")
+int BPF_PROG(test_inode_map_kptr, struct inode *inode, struct dentry *victim)
+{
+	struct map_value *v;
+
+	v = bpf_inode_storage_get(&inode_ls_map, inode, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (v)
+		test_kptr(v);
+	return 0;
+}
+
+SEC("tc")
+int test_sk_map_kptr(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	struct bpf_sock *sk;
+
+	sk = ctx->sk;
+	if (!sk)
+		return 0;
+	v = bpf_sk_storage_get(&sk_ls_map, sk, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (v)
+		test_kptr(v);
+	return 0;
+}
+
 SEC("tc")
 int test_map_in_map_kptr(struct __sk_buff *ctx)
 {
@@ -189,106 +298,257 @@ int test_map_in_map_kptr(struct __sk_buff *ctx)
 	return 0;
 }
 
-SEC("tc")
-int test_map_kptr_ref(struct __sk_buff *ctx)
+int ref = 1;
+
+static __always_inline
+int test_map_kptr_ref_pre(struct map_value *v)
 {
 	struct prog_test_ref_kfunc *p, *p_st;
 	unsigned long arg = 0;
-	struct map_value *v;
-	int key = 0, ret;
+	int ret;
 
 	p = bpf_kfunc_call_test_acquire(&arg);
 	if (!p)
 		return 1;
+	ref++;
 
 	p_st = p->next;
-	if (p_st->cnt.refs.counter != 2) {
+	if (p_st->cnt.refs.counter != ref) {
 		ret = 2;
 		goto end;
 	}
 
-	v = bpf_map_lookup_elem(&array_map, &key);
-	if (!v) {
-		ret = 3;
-		goto end;
-	}
-
 	p = bpf_kptr_xchg(&v->ref_ptr, p);
 	if (p) {
-		ret = 4;
+		ret = 3;
 		goto end;
 	}
-	if (p_st->cnt.refs.counter != 2)
-		return 5;
+	if (p_st->cnt.refs.counter != ref)
+		return 4;
 
 	p = bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);
 	if (!p)
-		return 6;
-	if (p_st->cnt.refs.counter != 3) {
-		ret = 7;
+		return 5;
+	ref++;
+	if (p_st->cnt.refs.counter != ref) {
+		ret = 6;
 		goto end;
 	}
 	bpf_kfunc_call_test_release(p);
-	if (p_st->cnt.refs.counter != 2)
-		return 8;
+	ref--;
+	if (p_st->cnt.refs.counter != ref)
+		return 7;
 
 	p = bpf_kptr_xchg(&v->ref_ptr, NULL);
 	if (!p)
-		return 9;
+		return 8;
 	bpf_kfunc_call_test_release(p);
-	if (p_st->cnt.refs.counter != 1)
-		return 10;
+	ref--;
+	if (p_st->cnt.refs.counter != ref)
+		return 9;
 
 	p = bpf_kfunc_call_test_acquire(&arg);
 	if (!p)
-		return 11;
+		return 10;
+	ref++;
 	p = bpf_kptr_xchg(&v->ref_ptr, p);
 	if (p) {
-		ret = 12;
+		ret = 11;
 		goto end;
 	}
-	if (p_st->cnt.refs.counter != 2)
-		return 13;
+	if (p_st->cnt.refs.counter != ref)
+		return 12;
 	/* Leave in map */
 
 	return 0;
 end:
+	ref--;
 	bpf_kfunc_call_test_release(p);
 	return ret;
 }
 
-SEC("tc")
-int test_map_kptr_ref2(struct __sk_buff *ctx)
+static __always_inline
+int test_map_kptr_ref_post(struct map_value *v)
 {
 	struct prog_test_ref_kfunc *p, *p_st;
-	struct map_value *v;
-	int key = 0;
-
-	v = bpf_map_lookup_elem(&array_map, &key);
-	if (!v)
-		return 1;
 
 	p_st = v->ref_ptr;
-	if (!p_st || p_st->cnt.refs.counter != 2)
-		return 2;
+	if (!p_st || p_st->cnt.refs.counter != ref)
+		return 1;
 
 	p = bpf_kptr_xchg(&v->ref_ptr, NULL);
 	if (!p)
-		return 3;
-	if (p_st->cnt.refs.counter != 2) {
+		return 2;
+	if (p_st->cnt.refs.counter != ref) {
 		bpf_kfunc_call_test_release(p);
-		return 4;
+		return 3;
 	}
 
 	p = bpf_kptr_xchg(&v->ref_ptr, p);
 	if (p) {
 		bpf_kfunc_call_test_release(p);
-		return 5;
+		return 4;
 	}
-	if (p_st->cnt.refs.counter != 2)
-		return 6;
+	if (p_st->cnt.refs.counter != ref)
+		return 5;
+
+	return 0;
+}
+
+#define TEST(map)                            \
+	v = bpf_map_lookup_elem(&map, &key); \
+	if (!v)                              \
+		return -1;                   \
+	ret = test_map_kptr_ref_pre(v);      \
+	if (ret)                             \
+		return ret;
+
+#define TEST_PCPU(map)                                 \
+	v = bpf_map_lookup_percpu_elem(&map, &key, 0); \
+	if (!v)                                        \
+		return -1;                             \
+	ret = test_map_kptr_ref_pre(v);                \
+	if (ret)                                       \
+		return ret;
+
+SEC("tc")
+int test_map_kptr_ref1(struct __sk_buff *ctx)
+{
+	struct map_value *v, val = {};
+	int key = 0, ret;
+
+	bpf_map_update_elem(&hash_map, &key, &val, 0);
+	bpf_map_update_elem(&hash_malloc_map, &key, &val, 0);
+	bpf_map_update_elem(&lru_hash_map, &key, &val, 0);
+
+	bpf_map_update_elem(&pcpu_hash_map, &key, &val, 0);
+	bpf_map_update_elem(&pcpu_hash_malloc_map, &key, &val, 0);
+	bpf_map_update_elem(&lru_pcpu_hash_map, &key, &val, 0);
+
+	TEST(array_map);
+	TEST(hash_map);
+	TEST(hash_malloc_map);
+	TEST(lru_hash_map);
+
+	TEST_PCPU(pcpu_array_map);
+	TEST_PCPU(pcpu_hash_map);
+	TEST_PCPU(pcpu_hash_malloc_map);
+	TEST_PCPU(lru_pcpu_hash_map);
+
+	return 0;
+}
+
+#undef TEST
+#undef TEST_PCPU
+
+#define TEST(map)                            \
+	v = bpf_map_lookup_elem(&map, &key); \
+	if (!v)                              \
+		return -1;                   \
+	ret = test_map_kptr_ref_post(v);     \
+	if (ret)                             \
+		return ret;
+
+#define TEST_PCPU(map)                                 \
+	v = bpf_map_lookup_percpu_elem(&map, &key, 0); \
+	if (!v)                                        \
+		return -1;                             \
+	ret = test_map_kptr_ref_post(v);               \
+	if (ret)                                       \
+		return ret;
+
+SEC("tc")
+int test_map_kptr_ref2(struct __sk_buff *ctx)
+{
+	struct map_value *v;
+	int key = 0, ret;
+
+	TEST(array_map);
+	TEST(hash_map);
+	TEST(hash_malloc_map);
+	TEST(lru_hash_map);
+
+	TEST_PCPU(pcpu_array_map);
+	TEST_PCPU(pcpu_hash_map);
+	TEST_PCPU(pcpu_hash_malloc_map);
+	TEST_PCPU(lru_pcpu_hash_map);
 
 	return 0;
 }
 
+#undef TEST
+#undef TEST_PCPU
+
+SEC("tc")
+int test_map_kptr_ref3(struct __sk_buff *ctx)
+{
+	struct prog_test_ref_kfunc *p;
+	unsigned long sp = 0;
+
+	p = bpf_kfunc_call_test_acquire(&sp);
+	if (!p)
+		return 1;
+	ref++;
+	if (p->cnt.refs.counter != ref) {
+		bpf_kfunc_call_test_release(p);
+		return 2;
+	}
+	bpf_kfunc_call_test_release(p);
+	ref--;
+	return 0;
+}
+
+SEC("syscall")
+int test_ls_map_kptr_ref1(void *ctx)
+{
+	struct task_struct *current;
+	struct map_value *v;
+	int ret;
+
+	current = bpf_get_current_task_btf();
+	if (!current)
+		return 100;
+	v = bpf_task_storage_get(&task_ls_map, current, NULL, 0);
+	if (v)
+		return 150;
+	v = bpf_task_storage_get(&task_ls_map, current, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!v)
+		return 200;
+	return test_map_kptr_ref_pre(v);
+}
+
+SEC("syscall")
+int test_ls_map_kptr_ref2(void *ctx)
+{
+	struct task_struct *current;
+	struct map_value *v;
+	int ret;
+
+	current = bpf_get_current_task_btf();
+	if (!current)
+		return 100;
+	v = bpf_task_storage_get(&task_ls_map, current, NULL, 0);
+	if (!v)
+		return 200;
+	return test_map_kptr_ref_post(v);
+}
+
+SEC("syscall")
+int test_ls_map_kptr_ref_del(void *ctx)
+{
+	struct task_struct *current;
+	struct map_value *v;
+	int ret;
+
+	current = bpf_get_current_task_btf();
+	if (!current)
+		return 100;
+	v = bpf_task_storage_get(&task_ls_map, current, NULL, 0);
+	if (!v)
+		return 200;
+	if (!v->ref_ptr)
+		return 300;
+	return bpf_task_storage_delete(&task_ls_map, current);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/rcu_tasks_trace_gp.c b/tools/testing/selftests/bpf/progs/rcu_tasks_trace_gp.c
new file mode 100644
index 000000000000..df4873558634
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/rcu_tasks_trace_gp.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+struct task_ls_map {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, int);
+} task_ls_map SEC(".maps");
+
+long gp_seq;
+
+SEC("syscall")
+int do_call_rcu_tasks_trace(void *ctx)
+{
+    struct task_struct *current;
+    int *v;
+
+    current = bpf_get_current_task_btf();
+    v = bpf_task_storage_get(&task_ls_map, current, NULL, BPF_LOCAL_STORAGE_GET_F_CREATE);
+    if (!v)
+        return 1;
+    /* Invoke call_rcu_tasks_trace */
+    return bpf_task_storage_delete(&task_ls_map, current);
+}
+
+SEC("kprobe/rcu_tasks_trace_postgp")
+int rcu_tasks_trace_postgp(void *ctx)
+{
+    __sync_add_and_fetch(&gp_seq, 1);
+    return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.39.2

