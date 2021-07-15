Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E2E3C9559
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 02:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhGOA5s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Jul 2021 20:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhGOA5h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Jul 2021 20:57:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52D3C061765;
        Wed, 14 Jul 2021 17:54:43 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso2908828pjp.2;
        Wed, 14 Jul 2021 17:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3AnCCDqs6Pu4Sum/tHjFW07NtXhr3dGCSSM7oeOGZ10=;
        b=c8RLUoMVZhWPDPeO26bD08oMugGXwBieT30cTK/XOWbZ5yfViHLtmrYrDBvVLyWb+J
         JNOiaYTPpHw/VXWE7BVWItHbjCQ015j3V8bpvLMQCkez51n3NmLk2BMOE/mNp78MgpP9
         Imzp8Q81Io8NVbIy/5iFLsfdAOTxhVhdQ/dun/qxGMU+/ECOfddmLIpuwOjjg7wS48b6
         6Nu/sIVhyNrG+6MrFOnjIZ+SWVQTSAEPWFEZc22lc7WyEk6Q6WJma/OuX4EfJ8PF1Uxh
         fgKw1NwY6xcgSfxgVJdPar78z+5NyB3Xetbn8Uh08tE5TrzKYZhwuRC3EP635qwnZikG
         yJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3AnCCDqs6Pu4Sum/tHjFW07NtXhr3dGCSSM7oeOGZ10=;
        b=JFXGPIbDlBSHN3TDY7tfpE2ICmQ5yCEizikSCFJNH883iGvCR7JSYLKQEQyVVKZgfy
         ao353L2lKg65KzdoXCIrSihH5R1JoAZaTuLHG/z6DLW2RnanDV2X/GFgYF7Ksg9uZWTQ
         gq3RLhAydlceMO60c+S4Nc3lX7xcbRf5b4Usiu6yeQml0lSu7hSgGfOTRwSp35z6daJu
         Z4BmdN+o0THkD6SnzFMiws/zy6r6amyApVJSeP0ySG+oqKy0paOBrpq/qv/SaTB+l16s
         rJhNBF4hU2Ahx6lO4PxzIUC4g305iYrkOhAaTuaGUtdsm25PkVhBebeYsSSgMgH1zh1E
         KGJg==
X-Gm-Message-State: AOAM533tr1mOYRv453jVw/spozsR6bc89BBajCnwMCz9VkrKHXY1uNad
        lTxN9PDlB/LLvrvmSfJuy3A=
X-Google-Smtp-Source: ABdhPJz3RSHyUgHq0tPcbux/6L11+qwFQTgdLWOuvh/ADvTgtuefEKU0ggEK5D3hWOqvrRuj+6o8xA==
X-Received: by 2002:a17:902:650b:b029:129:9c6a:13d8 with SMTP id b11-20020a170902650bb02901299c6a13d8mr736150plk.63.1626310483128;
        Wed, 14 Jul 2021 17:54:43 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:120c])
        by smtp.gmail.com with ESMTPSA id nl2sm3439011pjb.10.2021.07.14.17.54.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jul 2021 17:54:42 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 bpf-next 10/11] selftests/bpf: Add bpf_timer test.
Date:   Wed, 14 Jul 2021 17:54:16 -0700
Message-Id: <20210715005417.78572-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210715005417.78572-1-alexei.starovoitov@gmail.com>
References: <20210715005417.78572-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add bpf_timer test that creates timers in preallocated and
non-preallocated hash, in array and in lru maps.
Let array timer expire once and then re-arm it for 35 seconds.
Arm lru timer into the same callback.
Then arm and re-arm hash timers 10 times each.
At the last invocation of prealloc hash timer cancel the array timer.
Force timer free via LRU eviction and direct bpf_map_delete_elem.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/timer.c  |  55 ++++
 tools/testing/selftests/bpf/progs/timer.c     | 297 ++++++++++++++++++
 2 files changed, 352 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer.c

diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
new file mode 100644
index 000000000000..25f40e1b9967
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <test_progs.h>
+#include "timer.skel.h"
+
+static int timer(struct timer *timer_skel)
+{
+	int err, prog_fd;
+	__u32 duration = 0, retval;
+
+	err = timer__attach(timer_skel);
+	if (!ASSERT_OK(err, "timer_attach"))
+		return err;
+
+	ASSERT_EQ(timer_skel->data->callback_check, 52, "callback_check1");
+	ASSERT_EQ(timer_skel->data->callback2_check, 52, "callback2_check1");
+
+	prog_fd = bpf_program__fd(timer_skel->progs.test1);
+	err = bpf_prog_test_run(prog_fd, 1, NULL, 0,
+				NULL, NULL, &retval, &duration);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(retval, 0, "test_run");
+	timer__detach(timer_skel);
+
+	usleep(50); /* 10 usecs should be enough, but give it extra */
+	/* check that timer_cb1() was executed 10+10 times */
+	ASSERT_EQ(timer_skel->data->callback_check, 42, "callback_check2");
+	ASSERT_EQ(timer_skel->data->callback2_check, 42, "callback2_check2");
+
+	/* check that timer_cb2() was executed twice */
+	ASSERT_EQ(timer_skel->bss->bss_data, 10, "bss_data");
+
+	/* check that there were no errors in timer execution */
+	ASSERT_EQ(timer_skel->bss->err, 0, "err");
+
+	/* check that code paths completed */
+	ASSERT_EQ(timer_skel->bss->ok, 1 | 2 | 4, "ok");
+
+	return 0;
+}
+
+void test_timer(void)
+{
+	struct timer *timer_skel = NULL;
+	int err;
+
+	timer_skel = timer__open_and_load();
+	if (!ASSERT_OK_PTR(timer_skel, "timer_skel_load"))
+		goto cleanup;
+
+	err = timer(timer_skel);
+	ASSERT_OK(err, "timer");
+cleanup:
+	timer__destroy(timer_skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
new file mode 100644
index 000000000000..5f5309791649
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/timer.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <linux/bpf.h>
+#include <time.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+struct hmap_elem {
+	int counter;
+	struct bpf_timer timer;
+	struct bpf_spin_lock lock; /* unused */
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1000);
+	__type(key, int);
+	__type(value, struct hmap_elem);
+} hmap SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 1000);
+	__type(key, int);
+	__type(value, struct hmap_elem);
+} hmap_malloc SEC(".maps");
+
+struct elem {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, struct elem);
+} array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(max_entries, 4);
+	__type(key, int);
+	__type(value, struct elem);
+} lru SEC(".maps");
+
+__u64 bss_data;
+__u64 err;
+__u64 ok;
+__u64 callback_check = 52;
+__u64 callback2_check = 52;
+
+#define ARRAY 1
+#define HTAB 2
+#define HTAB_MALLOC 3
+#define LRU 4
+
+/* callback for array and lru timers */
+static int timer_cb1(void *map, int *key, struct bpf_timer *timer)
+{
+	/* increment bss variable twice.
+	 * Once via array timer callback and once via lru timer callback
+	 */
+	bss_data += 5;
+
+	/* *key == 0 - the callback was called for array timer.
+	 * *key == 4 - the callback was called from lru timer.
+	 */
+	if (*key == ARRAY) {
+		struct bpf_timer *lru_timer;
+		int lru_key = LRU;
+
+		/* rearm array timer to be called again in ~35 seconds */
+		if (bpf_timer_start(timer, 1ull << 35, 0) != 0)
+			err |= 1;
+
+		lru_timer = bpf_map_lookup_elem(&lru, &lru_key);
+		if (!lru_timer)
+			return 0;
+		bpf_timer_set_callback(lru_timer, timer_cb1);
+		if (bpf_timer_start(lru_timer, 0, 0) != 0)
+			err |= 2;
+	} else if (*key == LRU) {
+		int lru_key, i;
+
+		for (i = LRU + 1;
+		     i <= 100  /* for current LRU eviction algorithm this number
+				* should be larger than ~ lru->max_entries * 2
+				*/;
+		     i++) {
+			struct elem init = {};
+
+			/* lru_key cannot be used as loop induction variable
+			 * otherwise the loop will be unbounded.
+			 */
+			lru_key = i;
+
+			/* add more elements into lru map to push out current
+			 * element and force deletion of this timer
+			 */
+			bpf_map_update_elem(map, &lru_key, &init, 0);
+			/* look it up to bump it into active list */
+			bpf_map_lookup_elem(map, &lru_key);
+
+			/* keep adding until *key changes underneath,
+			 * which means that key/timer memory was reused
+			 */
+			if (*key != LRU)
+				break;
+		}
+
+		/* check that the timer was removed */
+		if (bpf_timer_cancel(timer) != -EINVAL)
+			err |= 4;
+		ok |= 1;
+	}
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	struct bpf_timer *arr_timer, *lru_timer;
+	struct elem init = {};
+	int lru_key = LRU;
+	int array_key = ARRAY;
+
+	arr_timer = bpf_map_lookup_elem(&array, &array_key);
+	if (!arr_timer)
+		return 0;
+	bpf_timer_init(arr_timer, &array, CLOCK_MONOTONIC);
+
+	bpf_map_update_elem(&lru, &lru_key, &init, 0);
+	lru_timer = bpf_map_lookup_elem(&lru, &lru_key);
+	if (!lru_timer)
+		return 0;
+	bpf_timer_init(lru_timer, &lru, CLOCK_MONOTONIC);
+
+	bpf_timer_set_callback(arr_timer, timer_cb1);
+	bpf_timer_start(arr_timer, 0 /* call timer_cb1 asap */, 0);
+
+	/* init more timers to check that array destruction
+	 * doesn't leak timer memory.
+	 */
+	array_key = 0;
+	arr_timer = bpf_map_lookup_elem(&array, &array_key);
+	if (!arr_timer)
+		return 0;
+	bpf_timer_init(arr_timer, &array, CLOCK_MONOTONIC);
+	return 0;
+}
+
+/* callback for prealloc and non-prealloca hashtab timers */
+static int timer_cb2(void *map, int *key, struct hmap_elem *val)
+{
+	if (*key == HTAB)
+		callback_check--;
+	else
+		callback2_check--;
+	if (val->counter > 0 && --val->counter) {
+		/* re-arm the timer again to execute after 1 usec */
+		bpf_timer_start(&val->timer, 1000, 0);
+	} else if (*key == HTAB) {
+		struct bpf_timer *arr_timer;
+		int array_key = ARRAY;
+
+		/* cancel arr_timer otherwise bpf_fentry_test1 prog
+		 * will stay alive forever.
+		 */
+		arr_timer = bpf_map_lookup_elem(&array, &array_key);
+		if (!arr_timer)
+			return 0;
+		if (bpf_timer_cancel(arr_timer) != 1)
+			/* bpf_timer_cancel should return 1 to indicate
+			 * that arr_timer was active at this time
+			 */
+			err |= 8;
+
+		/* try to cancel ourself. It shouldn't deadlock. */
+		if (bpf_timer_cancel(&val->timer) != -EDEADLK)
+			err |= 16;
+
+		/* delete this key and this timer anyway.
+		 * It shouldn't deadlock either.
+		 */
+		bpf_map_delete_elem(map, key);
+
+		/* in preallocated hashmap both 'key' and 'val' could have been
+		 * reused to store another map element (like in LRU above),
+		 * but in controlled test environment the below test works.
+		 * It's not a use-after-free. The memory is owned by the map.
+		 */
+		if (bpf_timer_start(&val->timer, 1000, 0) != -EINVAL)
+			err |= 32;
+		ok |= 2;
+	} else {
+		if (*key != HTAB_MALLOC)
+			err |= 64;
+
+		/* try to cancel ourself. It shouldn't deadlock. */
+		if (bpf_timer_cancel(&val->timer) != -EDEADLK)
+			err |= 128;
+
+		/* delete this key and this timer anyway.
+		 * It shouldn't deadlock either.
+		 */
+		bpf_map_delete_elem(map, key);
+
+		/* in non-preallocated hashmap both 'key' and 'val' are RCU
+		 * protected and still valid though this element was deleted
+		 * from the map. Arm this timer for ~35 seconds. When callback
+		 * finishes the call_rcu will invoke:
+		 * htab_elem_free_rcu
+		 *   check_and_free_timer
+		 *     bpf_timer_cancel_and_free
+		 * to cancel this 35 second sleep and delete the timer for real.
+		 */
+		if (bpf_timer_start(&val->timer, 1ull << 35, 0) != 0)
+			err |= 256;
+		ok |= 4;
+	}
+	return 0;
+}
+
+int bpf_timer_test(void)
+{
+	struct hmap_elem *val;
+	int key = HTAB, key_malloc = HTAB_MALLOC;
+
+	val = bpf_map_lookup_elem(&hmap, &key);
+	if (val) {
+		if (bpf_timer_init(&val->timer, &hmap, CLOCK_BOOTTIME) != 0)
+			err |= 512;
+		bpf_timer_set_callback(&val->timer, timer_cb2);
+		bpf_timer_start(&val->timer, 1000, 0);
+	}
+	val = bpf_map_lookup_elem(&hmap_malloc, &key_malloc);
+	if (val) {
+		if (bpf_timer_init(&val->timer, &hmap_malloc, CLOCK_BOOTTIME) != 0)
+			err |= 1024;
+		bpf_timer_set_callback(&val->timer, timer_cb2);
+		bpf_timer_start(&val->timer, 1000, 0);
+	}
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test2")
+int BPF_PROG(test2, int a, int b)
+{
+	struct hmap_elem init = {}, *val;
+	int key = HTAB, key_malloc = HTAB_MALLOC;
+
+	init.counter = 10; /* number of times to trigger timer_cb2 */
+	bpf_map_update_elem(&hmap, &key, &init, 0);
+	val = bpf_map_lookup_elem(&hmap, &key);
+	if (val)
+		bpf_timer_init(&val->timer, &hmap, CLOCK_BOOTTIME);
+	/* update the same key to free the timer */
+	bpf_map_update_elem(&hmap, &key, &init, 0);
+
+	bpf_map_update_elem(&hmap_malloc, &key_malloc, &init, 0);
+	val = bpf_map_lookup_elem(&hmap_malloc, &key_malloc);
+	if (val)
+		bpf_timer_init(&val->timer, &hmap_malloc, CLOCK_BOOTTIME);
+	/* update the same key to free the timer */
+	bpf_map_update_elem(&hmap_malloc, &key_malloc, &init, 0);
+
+	/* init more timers to check that htab operations
+	 * don't leak timer memory.
+	 */
+	key = 0;
+	bpf_map_update_elem(&hmap, &key, &init, 0);
+	val = bpf_map_lookup_elem(&hmap, &key);
+	if (val)
+		bpf_timer_init(&val->timer, &hmap, CLOCK_BOOTTIME);
+	bpf_map_delete_elem(&hmap, &key);
+	bpf_map_update_elem(&hmap, &key, &init, 0);
+	val = bpf_map_lookup_elem(&hmap, &key);
+	if (val)
+		bpf_timer_init(&val->timer, &hmap, CLOCK_BOOTTIME);
+
+	/* and with non-prealloc htab */
+	key_malloc = 0;
+	bpf_map_update_elem(&hmap_malloc, &key_malloc, &init, 0);
+	val = bpf_map_lookup_elem(&hmap_malloc, &key_malloc);
+	if (val)
+		bpf_timer_init(&val->timer, &hmap_malloc, CLOCK_BOOTTIME);
+	bpf_map_delete_elem(&hmap_malloc, &key_malloc);
+	bpf_map_update_elem(&hmap_malloc, &key_malloc, &init, 0);
+	val = bpf_map_lookup_elem(&hmap_malloc, &key_malloc);
+	if (val)
+		bpf_timer_init(&val->timer, &hmap_malloc, CLOCK_BOOTTIME);
+
+	return bpf_timer_test();
+}
-- 
2.30.2

