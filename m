Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E0758CBA2
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 17:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243854AbiHHPyX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 11:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbiHHPyU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 11:54:20 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B0B15824;
        Mon,  8 Aug 2022 08:54:10 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id z7so1392136qki.11;
        Mon, 08 Aug 2022 08:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ycjJa1l1UV6n4vFO48w0Uw4WgpoRildXnTr3vBi+1do=;
        b=aWzgMeWuYm/dmecXKAHhrNG7IHfMFh+kLULTvt2sT5c7RK2Wx+H4+XMpwlQjuhE4Z7
         cp7J/b9MSKtsPH+d3eMQtsP3kzhTsHRU05v4ZamksuF3R+AGzCoZaaSgk7UQzI9jIKRY
         depRTkbgj2Q8absD7pCWBJYcirS4yJWKWe6uhN1Iuv0XqJUwaBlp9ElnjAG8g5/IfcXb
         KlaPWKq6XtKk20MvOgYkgq8CeRblO35ix4TpeTwnqDv+9n0w6XvT0Ja57Bek+Xx+soxW
         Se+W6zs7XnIRUUHvZo2QWtSf6oc+zOvyIQnDsOQxTyYtCnxbFTUXTRtckFP6PRZTelrC
         Q9UA==
X-Gm-Message-State: ACgBeo0+3P2Mm9LTu8PjbVP5v+v7H5PFeEyrK3/CXeuLg7aG8A4GtNEs
        WiDlqAqf2jWm068s3bW8W8zNBHZmvAyXuw==
X-Google-Smtp-Source: AA6agR5OVgZglB9zT9lTBb8kNRZy25po01cV/8Fasj+pJR3VJJDH9g3FNeNybdg7fLvBJcqTD6WL0w==
X-Received: by 2002:a05:620a:2788:b0:6b6:2012:405e with SMTP id g8-20020a05620a278800b006b62012405emr14163238qkp.18.1659974049019;
        Mon, 08 Aug 2022 08:54:09 -0700 (PDT)
Received: from localhost (fwdproxy-ash-008.fbsv.net. [2a03:2880:20ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id dm16-20020a05620a1d5000b006b8cb64110bsm10203821qkb.45.2022.08.08.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:54:08 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, joannelkoong@gmail.com,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com
Subject: [PATCH 5/5] selftests/bpf: Add selftests validating the user ringbuf
Date:   Mon,  8 Aug 2022 08:53:41 -0700
Message-Id: <20220808155341.2479054-5-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220808155341.2479054-1-void@manifault.com>
References: <20220808155341.2479054-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change includes selftests that validate the expected behavior and
APIs of the new BPF_MAP_TYPE_USER_RINGBUF map type.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../selftests/bpf/prog_tests/user_ringbuf.c   | 587 ++++++++++++++++++
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 174 ++++++
 .../bpf/progs/user_ringbuf_success.c          | 220 +++++++
 .../testing/selftests/bpf/test_user_ringbuf.h |  35 ++
 4 files changed, 1016 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_success.c
 create mode 100644 tools/testing/selftests/bpf/test_user_ringbuf.h

diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
new file mode 100644
index 000000000000..d62adb74da73
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -0,0 +1,587 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#define _GNU_SOURCE
+#include <linux/compiler.h>
+#include <linux/ring_buffer.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <sys/sysinfo.h>
+#include <test_progs.h>
+#include <unistd.h>
+
+#include "user_ringbuf_fail.skel.h"
+#include "user_ringbuf_success.skel.h"
+
+#include "../test_user_ringbuf.h"
+
+static int duration;
+static size_t log_buf_sz = 1 << 20; /* 1 MB */
+static char obj_log_buf[1048576];
+static const long c_sample_size = sizeof(struct sample) + BPF_RINGBUF_HDR_SZ;
+static const long c_ringbuf_size = 1 << 12; /* 1 small page */
+static const long c_max_entries = c_ringbuf_size / c_sample_size;
+
+static void drain_current_samples(void)
+{
+	syscall(__NR_getpgid);
+}
+
+static int write_samples(struct ring_buffer_user *ringbuf, uint32_t num_samples)
+{
+	int i, err = 0;
+
+	// Write some number of samples to the ring buffer.
+	for (i = 0; i < num_samples; i++) {
+		struct sample *entry;
+		int read;
+
+		entry = ring_buffer_user__reserve(ringbuf, sizeof(*entry));
+		if (!entry) {
+			err = -ENOMEM;
+			goto done;
+		}
+
+		entry->pid = getpid();
+		entry->seq = i;
+		entry->value = i * i;
+
+		read = snprintf(entry->comm, sizeof(entry->comm), "%u", i);
+		if (read <= 0) {
+			/* Only invoke CHECK on the error path to avoid spamming
+			 * logs with mostly success messages.
+			 */
+			CHECK(read <= 0, "snprintf_comm",
+			      "Failed to write index %d to comm\n", i);
+			err = read;
+			ring_buffer_user__discard(ringbuf, entry);
+			goto done;
+		}
+
+		ring_buffer_user__submit(ringbuf, entry);
+	}
+
+done:
+	drain_current_samples();
+
+	return err;
+}
+
+static struct user_ringbuf_success*
+open_load_ringbuf_skel(void)
+{
+	struct user_ringbuf_success *skel;
+	int err;
+
+	skel = user_ringbuf_success__open();
+	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
+		return NULL;
+
+	err = bpf_map__set_max_entries(skel->maps.user_ringbuf,
+				       c_ringbuf_size);
+	if (CHECK(err != 0, "set_max_entries", "set max entries failed: %d\n", err))
+		goto cleanup;
+
+	err = bpf_map__set_max_entries(skel->maps.kernel_ringbuf,
+				       c_ringbuf_size);
+	if (CHECK(err != 0, "set_max_entries", "set max entries failed: %d\n", err))
+		goto cleanup;
+
+	err = user_ringbuf_success__load(skel);
+	if (CHECK(err != 0, "skel_load", "skeleton load failed\n"))
+		goto cleanup;
+
+	return skel;
+
+cleanup:
+	user_ringbuf_success__destroy(skel);
+	return NULL;
+}
+
+static void test_user_ringbuf_mappings(void)
+{
+	int err, rb_fd;
+	int page_size = getpagesize();
+	void *mmap_ptr;
+	struct user_ringbuf_success *skel;
+
+	skel = open_load_ringbuf_skel();
+	if (!skel)
+		return;
+
+	rb_fd = bpf_map__fd(skel->maps.user_ringbuf);
+	/* cons_pos can be mapped R/O, can't add +X with mprotect. */
+	mmap_ptr = mmap(NULL, page_size, PROT_READ, MAP_SHARED, rb_fd, 0);
+	ASSERT_OK_PTR(mmap_ptr, "ro_cons_pos");
+	ASSERT_ERR(mprotect(mmap_ptr, page_size, PROT_WRITE), "write_cons_pos_protect");
+	ASSERT_ERR(mprotect(mmap_ptr, page_size, PROT_EXEC), "exec_cons_pos_protect");
+	ASSERT_ERR_PTR(mremap(mmap_ptr, 0, 4 * page_size, MREMAP_MAYMOVE), "wr_prod_pos");
+	err = -errno;
+	ASSERT_EQ(err, -EPERM, "wr_prod_pos_err");
+	ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_ro_cons");
+
+	/* prod_pos can be mapped RW, can't add +X with mprotect. */
+	mmap_ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+			rb_fd, page_size);
+	ASSERT_OK_PTR(mmap_ptr, "rw_prod_pos");
+	ASSERT_ERR(mprotect(mmap_ptr, page_size, PROT_EXEC), "exec_prod_pos_protect");
+	err = -errno;
+	ASSERT_EQ(err, -EACCES, "wr_prod_pos_err");
+	ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_rw_prod");
+
+	/* data pages can be mapped RW, can't add +X with mprotect. */
+	mmap_ptr = mmap(NULL, page_size, PROT_WRITE, MAP_SHARED, rb_fd,
+			2 * page_size);
+	ASSERT_OK_PTR(mmap_ptr, "rw_data");
+	ASSERT_ERR(mprotect(mmap_ptr, page_size, PROT_EXEC), "exec_data_protect");
+	err = -errno;
+	ASSERT_EQ(err, -EACCES, "exec_data_err");
+	ASSERT_OK(munmap(mmap_ptr, page_size), "unmap_rw_data");
+
+	user_ringbuf_success__destroy(skel);
+}
+
+static int load_skel_create_ringbufs(struct user_ringbuf_success **skel_out,
+				     struct ring_buffer **kern_ringbuf_out,
+				     ring_buffer_sample_fn callback,
+				     struct ring_buffer_user **user_ringbuf_out)
+{
+	struct user_ringbuf_success *skel;
+	struct ring_buffer *kern_ringbuf = NULL;
+	struct ring_buffer_user *user_ringbuf = NULL;
+	int err = -ENOMEM, rb_fd;
+
+	skel = open_load_ringbuf_skel();
+	if (!skel)
+		return err;
+
+	/* only trigger BPF program for current process */
+	skel->bss->pid = getpid();
+
+	if (kern_ringbuf_out) {
+		rb_fd = bpf_map__fd(skel->maps.kernel_ringbuf);
+		kern_ringbuf = ring_buffer__new(rb_fd, callback, skel, NULL);
+		if (CHECK(!kern_ringbuf, "kern_ringbuf_create",
+					"failed to create kern ringbuf\n"))
+			goto cleanup;
+
+		*kern_ringbuf_out = kern_ringbuf;
+	}
+
+	if (user_ringbuf_out) {
+		rb_fd = bpf_map__fd(skel->maps.user_ringbuf);
+		user_ringbuf = ring_buffer_user__new(rb_fd, NULL);
+		if (CHECK(!user_ringbuf, "user_ringbuf_create",
+			  "failed to create user ringbuf\n"))
+			goto cleanup;
+
+		*user_ringbuf_out = user_ringbuf;
+		ASSERT_EQ(skel->bss->read, 0, "no_reads_after_load");
+	}
+
+	err = user_ringbuf_success__attach(skel);
+	if (CHECK(err != 0, "skel_attach", "skeleton attachment failed: %d\n",
+		  err))
+		goto cleanup;
+
+	*skel_out = skel;
+	return 0;
+
+cleanup:
+	if (kern_ringbuf_out)
+		*kern_ringbuf_out = NULL;
+	if (user_ringbuf_out)
+		*user_ringbuf_out = NULL;
+	ring_buffer__free(kern_ringbuf);
+	ring_buffer_user__free(user_ringbuf);
+	user_ringbuf_success__destroy(skel);
+	return err;
+}
+
+static int
+load_skel_create_user_ringbuf(struct user_ringbuf_success **skel_out,
+			      struct ring_buffer_user **ringbuf_out)
+{
+	return load_skel_create_ringbufs(skel_out, NULL, NULL, ringbuf_out);
+}
+
+static void test_user_ringbuf_commit(void)
+{
+	struct user_ringbuf_success *skel;
+	struct ring_buffer_user *ringbuf;
+	int err;
+
+	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
+	if (err)
+		return;
+
+	ASSERT_EQ(skel->bss->read, 0, "num_samples_read_before");
+
+	err = write_samples(ringbuf, 2);
+	if (CHECK(err, "write_samples", "failed to write samples: %d\n", err))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->read, 2, "num_samples_read_after");
+
+cleanup:
+	ring_buffer_user__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static void test_user_ringbuf_fill(void)
+{
+	struct user_ringbuf_success *skel;
+	struct ring_buffer_user *ringbuf;
+	int err;
+
+	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
+	if (err)
+		return;
+
+	err = write_samples(ringbuf, c_max_entries * 5);
+	ASSERT_EQ(err, -ENOMEM, "too_many_samples_posted");
+	ASSERT_EQ(skel->bss->read, c_max_entries, "max_entries");
+
+	ring_buffer_user__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static void test_user_ringbuf_loop(void)
+{
+	struct user_ringbuf_success *skel;
+	struct ring_buffer_user *ringbuf;
+	uint32_t total_samples = 8192;
+	uint32_t remaining_samples = total_samples;
+	int err;
+
+	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
+	if (err)
+		return;
+
+	do  {
+		uint32_t curr_samples;
+
+		curr_samples = remaining_samples > c_max_entries
+			? c_max_entries : remaining_samples;
+		err = write_samples(ringbuf, curr_samples);
+		if (err != 0) {
+			/* Perform CHECK inside of if statement to avoid
+			 * flooding logs on the success path.
+			 */
+			CHECK(err, "write_samples",
+					"failed to write sample batch: %d\n", err);
+			goto cleanup;
+		}
+
+		remaining_samples -= curr_samples;
+		ASSERT_EQ(skel->bss->read, total_samples - remaining_samples,
+			  "current_batched_entries");
+	} while (remaining_samples > 0);
+	ASSERT_EQ(skel->bss->read, total_samples, "total_batched_entries");
+
+cleanup:
+	ring_buffer_user__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static int send_test_message(struct ring_buffer_user *ringbuf,
+			     enum test_msg_op op, s64 operand_64,
+			     s32 operand_32)
+{
+	struct test_msg *msg;
+
+	msg = ring_buffer_user__reserve(ringbuf, sizeof(*msg));
+	if (!msg) {
+		/* Only invoke CHECK on the error path to avoid spamming
+		 * logs with mostly success messages.
+		 */
+		CHECK(msg != NULL, "reserve_msg",
+		      "Failed to reserve message\n");
+		return -ENOMEM;
+	}
+
+	msg->msg_op = op;
+
+	switch (op) {
+	case TEST_MSG_OP_INC64:
+	case TEST_MSG_OP_MUL64:
+		msg->operand_64 = operand_64;
+		break;
+	case TEST_MSG_OP_INC32:
+	case TEST_MSG_OP_MUL32:
+		msg->operand_32 = operand_32;
+		break;
+	default:
+		PRINT_FAIL("Invalid operand %d\n", op);
+		ring_buffer_user__discard(ringbuf, msg);
+		return -EINVAL;
+	}
+
+	ring_buffer_user__submit(ringbuf, msg);
+
+	return 0;
+}
+
+static void kick_kernel_read_messages(void)
+{
+	syscall(__NR_getcwd);
+}
+
+static int handle_kernel_msg(void *ctx, void *data, size_t len)
+{
+	struct user_ringbuf_success *skel = ctx;
+	struct test_msg *msg = data;
+
+	switch (msg->msg_op) {
+	case TEST_MSG_OP_INC64:
+		skel->bss->user_mutated += msg->operand_64;
+		return 0;
+	case TEST_MSG_OP_INC32:
+		skel->bss->user_mutated += msg->operand_32;
+		return 0;
+	case TEST_MSG_OP_MUL64:
+		skel->bss->user_mutated *= msg->operand_64;
+		return 0;
+	case TEST_MSG_OP_MUL32:
+		skel->bss->user_mutated *= msg->operand_32;
+		return 0;
+	default:
+		fprintf(stderr, "Invalid operand %d\n", msg->msg_op);
+		return -EINVAL;
+	}
+}
+
+static void drain_kernel_messages_buffer(struct ring_buffer *kern_ringbuf)
+{
+	int err;
+
+	err = ring_buffer__consume(kern_ringbuf);
+	if (err)
+		/* Only check in failure to avoid spamming success logs. */
+		CHECK(!err, "consume_kern_ringbuf",
+		      "Failed to consume kernel ringbuf\n");
+}
+
+static void test_user_ringbuf_msg_protocol(void)
+{
+	struct user_ringbuf_success *skel;
+	struct ring_buffer_user *user_ringbuf;
+	struct ring_buffer *kern_ringbuf;
+	int err, i;
+	__u64 expected_kern = 0;
+
+	err = load_skel_create_ringbufs(&skel, &kern_ringbuf, handle_kernel_msg,
+					&user_ringbuf);
+	if (CHECK(err, "create_ringbufs", "Failed to create ringbufs: %d\n",
+		  err))
+		return;
+
+	for (i = 0; i < 64; i++) {
+		enum test_msg_op op = i % TEST_MSG_OP_NUM_OPS;
+		__u64 operand_64 = TEST_OP_64;
+		__u32 operand_32 = TEST_OP_32;
+
+		err = send_test_message(user_ringbuf, op, operand_64,
+					operand_32);
+		if (err) {
+			CHECK(err, "send_test_message",
+			"Failed to send test message\n");
+			goto cleanup;
+		}
+
+		switch (op) {
+		case TEST_MSG_OP_INC64:
+			expected_kern += operand_64;
+			break;
+		case TEST_MSG_OP_INC32:
+			expected_kern += operand_32;
+			break;
+		case TEST_MSG_OP_MUL64:
+			expected_kern *= operand_64;
+			break;
+		case TEST_MSG_OP_MUL32:
+			expected_kern *= operand_32;
+			break;
+		default:
+			PRINT_FAIL("Unexpected op %d\n", op);
+			goto cleanup;
+		}
+
+		if (i % 8 == 0) {
+			kick_kernel_read_messages();
+			ASSERT_EQ(skel->bss->kern_mutated, expected_kern,
+				  "expected_kern");
+			ASSERT_EQ(skel->bss->err, 0, "bpf_prog_err");
+			drain_kernel_messages_buffer(kern_ringbuf);
+		}
+	}
+
+cleanup:
+	ring_buffer__free(kern_ringbuf);
+	ring_buffer_user__free(user_ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static void *kick_kernel_cb(void *arg)
+{
+	/* Sleep to better exercise the path for the main thread waiting in
+	 * poll_wait().
+	 */
+	sleep(1);
+
+	/* Kick the kernel, causing it to drain the ringbuffer and then wake up
+	 * the test thread waiting on epoll.
+	 */
+	syscall(__NR_getrlimit);
+
+	return NULL;
+}
+
+static int spawn_kick_thread_for_poll(void)
+{
+	pthread_t thread;
+
+	return pthread_create(&thread, NULL, kick_kernel_cb, NULL);
+}
+
+static void test_user_ringbuf_poll_wait(void)
+{
+	struct user_ringbuf_success *skel;
+	struct ring_buffer_user *ringbuf;
+	int err, num_written = 0;
+	__u64 *token;
+
+	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
+	if (err)
+		return;
+
+	ASSERT_EQ(skel->bss->read, 0, "num_samples_read_before");
+
+	while (1) {
+		/* Write samples until the buffer is full. */
+		token = ring_buffer_user__reserve(ringbuf, sizeof(*token));
+		if (!token)
+			break;
+
+		*token = 0xdeadbeef;
+
+		ring_buffer_user__submit(ringbuf, token);
+		num_written++;
+	}
+
+	if (!ASSERT_GE(num_written, 0, "num_written"))
+		goto cleanup;
+
+	/* Should not have read any samples until the kernel is kicked. */
+	ASSERT_EQ(skel->bss->read, 0, "num_pre_kick");
+
+	token = ring_buffer_user__poll(ringbuf, sizeof(*token), 1000);
+	if (!ASSERT_EQ(token, NULL, "pre_kick_timeout_token"))
+		goto cleanup;
+
+	err = spawn_kick_thread_for_poll();
+	if (!ASSERT_EQ(err, 0, "deferred_kick_thread\n"))
+		goto cleanup;
+
+	token = ring_buffer_user__poll(ringbuf, sizeof(*token), 10000);
+	if (!token) {
+		PRINT_FAIL("Failed to poll for user ringbuf entry\n");
+		ring_buffer_user__discard(ringbuf, token);
+		goto cleanup;
+	}
+
+	ASSERT_EQ(skel->bss->read, num_written, "num_post_kill");
+	ASSERT_EQ(skel->bss->err, 0, "err_post_poll");
+	ring_buffer_user__discard(ringbuf, token);
+
+cleanup:
+	ring_buffer_user__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static struct {
+	const char *prog_name;
+	const char *expected_err_msg;
+} failure_tests[] = {
+	/* failure cases */
+	{"user_ringbuf_callback_bad_access1", "negative offset alloc_dynptr_ptr ptr"},
+	{"user_ringbuf_callback_bad_access2", "dereference of modified alloc_dynptr_ptr ptr"},
+	{"user_ringbuf_callback_write_forbidden", "invalid mem access 'alloc_dynptr_ptr'"},
+	{"user_ringbuf_callback_null_context_write", "invalid mem access 'scalar'"},
+	{"user_ringbuf_callback_null_context_read", "invalid mem access 'scalar'"},
+	{"user_ringbuf_callback_discard_dynptr", "arg 1 is an unacquired reference"},
+	{"user_ringbuf_callback_submit_dynptr", "arg 1 is an unacquired reference"},
+};
+
+#define SUCCESS_TEST(_func) { _func, #_func }
+
+static struct {
+	void (*test_callback)(void);
+	const char *test_name;
+} success_tests[] = {
+	SUCCESS_TEST(test_user_ringbuf_mappings),
+	SUCCESS_TEST(test_user_ringbuf_commit),
+	SUCCESS_TEST(test_user_ringbuf_fill),
+	SUCCESS_TEST(test_user_ringbuf_loop),
+	SUCCESS_TEST(test_user_ringbuf_msg_protocol),
+	SUCCESS_TEST(test_user_ringbuf_poll_wait),
+};
+
+static void verify_fail(const char *prog_name, const char *expected_err_msg)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct bpf_program *prog;
+	struct user_ringbuf_fail *skel;
+	int err;
+
+	opts.kernel_log_buf = obj_log_buf;
+	opts.kernel_log_size = log_buf_sz;
+	opts.kernel_log_level = 1;
+
+	skel = user_ringbuf_fail__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "dynptr_fail__open_opts"))
+		goto cleanup;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	bpf_program__set_autoload(prog, true);
+
+	bpf_map__set_max_entries(skel->maps.user_ringbuf, getpagesize());
+
+	err = user_ringbuf_fail__load(skel);
+	if (!ASSERT_ERR(err, "unexpected load success"))
+		goto cleanup;
+
+	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
+		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
+		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
+	}
+
+cleanup:
+	user_ringbuf_fail__destroy(skel);
+}
+
+void test_user_ringbuf(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(success_tests); i++) {
+		if (!test__start_subtest(success_tests[i].test_name))
+			continue;
+
+		success_tests[i].test_callback();
+	}
+
+	for (i = 0; i < ARRAY_SIZE(failure_tests); i++) {
+		if (!test__start_subtest(failure_tests[i].prog_name))
+			continue;
+
+		verify_fail(failure_tests[i].prog_name,
+			    failure_tests[i].expected_err_msg);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
new file mode 100644
index 000000000000..237df8ca637a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct sample {
+	int pid;
+	int seq;
+	long value;
+	char comm[16];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
+} user_ringbuf SEC(".maps");
+
+static long
+bad_access1(struct bpf_dynptr *dynptr, void *context)
+{
+	const struct sample *sample;
+
+	sample = bpf_dynptr_data(dynptr - 1, 0, sizeof(*sample));
+	bpf_printk("Was able to pass bad pointer %lx\n", (__u64)dynptr - 1);
+
+	return 0;
+}
+
+/* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
+ * not be able to read before the pointer.
+ */
+SEC("?raw_tp/sys_nanosleep")
+int user_ringbuf_callback_bad_access1(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_user_ringbuf_drain(&user_ringbuf, bad_access1, NULL, 0);
+
+	return 0;
+}
+
+static long
+bad_access2(struct bpf_dynptr *dynptr, void *context)
+{
+	const struct sample *sample;
+
+	sample = bpf_dynptr_data(dynptr + 1, 0, sizeof(*sample));
+	bpf_printk("Was able to pass bad pointer %lx\n", (__u64)dynptr + 1);
+
+	return 0;
+}
+
+/* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
+ * not be able to read past the end of the pointer.
+ */
+SEC("?raw_tp/sys_nanosleep")
+int user_ringbuf_callback_bad_access2(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_user_ringbuf_drain(&user_ringbuf, bad_access2, NULL, 0);
+
+	return 0;
+}
+
+static long
+write_forbidden(struct bpf_dynptr *dynptr, void *context)
+{
+	*((long *)dynptr) = 0;
+
+	return 0;
+}
+
+/* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
+ * not be able to write to that pointer.
+ */
+SEC("?raw_tp/sys_nanosleep")
+int user_ringbuf_callback_write_forbidden(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_user_ringbuf_drain(&user_ringbuf, write_forbidden, NULL, 0);
+
+	return 0;
+}
+
+static long
+null_context_write(struct bpf_dynptr *dynptr, void *context)
+{
+	*((__u64 *)context) = 0;
+
+	return 0;
+}
+
+/* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
+ * not be able to write to that pointer.
+ */
+SEC("?raw_tp/sys_nanosleep")
+int user_ringbuf_callback_null_context_write(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_user_ringbuf_drain(&user_ringbuf, null_context_write, NULL, 0);
+
+	return 0;
+}
+
+static long
+null_context_read(struct bpf_dynptr *dynptr, void *context)
+{
+	__u64 id = *((__u64 *)context);
+
+	bpf_printk("Read id %lu\n", id);
+
+	return 0;
+}
+
+/* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
+ * not be able to write to that pointer.
+ */
+SEC("?raw_tp/sys_nanosleep")
+int user_ringbuf_callback_null_context_read(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_user_ringbuf_drain(&user_ringbuf, null_context_read, NULL, 0);
+
+	return 0;
+}
+
+static long
+try_discard_dynptr(struct bpf_dynptr *dynptr, void *context)
+{
+	bpf_ringbuf_discard_dynptr(dynptr, 0);
+
+	return 0;
+}
+
+/* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
+ * not be able to read past the end of the pointer.
+ */
+SEC("?raw_tp/sys_nanosleep")
+int user_ringbuf_callback_discard_dynptr(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_user_ringbuf_drain(&user_ringbuf, try_discard_dynptr, NULL, 0);
+
+	return 0;
+}
+
+static long
+try_submit_dynptr(struct bpf_dynptr *dynptr, void *context)
+{
+	bpf_ringbuf_submit_dynptr(dynptr, 0);
+
+	return 0;
+}
+
+/* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
+ * not be able to read past the end of the pointer.
+ */
+SEC("?raw_tp/sys_nanosleep")
+int user_ringbuf_callback_submit_dynptr(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_user_ringbuf_drain(&user_ringbuf, try_submit_dynptr, NULL, 0);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_success.c b/tools/testing/selftests/bpf/progs/user_ringbuf_success.c
new file mode 100644
index 000000000000..ab8035a47da5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_success.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_user_ringbuf.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
+} user_ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+} kernel_ringbuf SEC(".maps");
+
+/* inputs */
+int pid, err, val;
+
+int read = 0;
+
+/* Counter used for end-to-end protocol test */
+__u64 kern_mutated = 0;
+__u64 user_mutated = 0;
+__u64 expected_user_mutated = 0;
+
+static int
+is_test_process(void)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	return cur_pid == pid;
+}
+
+static long
+record_sample(struct bpf_dynptr *dynptr, void *context)
+{
+	const struct sample *sample = NULL;
+	struct sample stack_sample;
+	int status;
+	static int num_calls;
+
+	if (num_calls++ % 2 == 0) {
+		status = bpf_dynptr_read(&stack_sample, sizeof(stack_sample),
+					 dynptr, 0, 0);
+		if (status) {
+			bpf_printk("bpf_dynptr_read() failed: %d\n", status);
+			err = 1;
+			return 0;
+		}
+	} else {
+		sample = bpf_dynptr_data(dynptr, 0, sizeof(*sample));
+		if (!sample) {
+			bpf_printk("Unexpectedly failed to get sample\n");
+			err = 2;
+			return 0;
+		}
+		stack_sample = *sample;
+	}
+
+	__sync_fetch_and_add(&read, 1);
+	return 0;
+}
+
+static void
+handle_sample_msg(const struct test_msg *msg)
+{
+	switch (msg->msg_op) {
+	case TEST_MSG_OP_INC64:
+		kern_mutated += msg->operand_64;
+		break;
+	case TEST_MSG_OP_INC32:
+		kern_mutated += msg->operand_32;
+		break;
+	case TEST_MSG_OP_MUL64:
+		kern_mutated *= msg->operand_64;
+		break;
+	case TEST_MSG_OP_MUL32:
+		kern_mutated *= msg->operand_32;
+		break;
+	default:
+		bpf_printk("Unrecognized op %d\n", msg->msg_op);
+		err = 2;
+	}
+}
+
+static long
+read_protocol_msg(struct bpf_dynptr *dynptr, void *context)
+{
+	const struct test_msg *msg = NULL;
+
+	msg = bpf_dynptr_data(dynptr, 0, sizeof(*msg));
+	if (!msg) {
+		err = 1;
+		bpf_printk("Unexpectedly failed to get msg\n");
+		return 0;
+	}
+
+	handle_sample_msg(msg);
+
+	return 0;
+}
+
+static int publish_next_kern_msg(__u32 index, void *context)
+{
+	struct test_msg *msg = NULL;
+	int operand_64 = TEST_OP_64;
+	int operand_32 = TEST_OP_32;
+
+	msg = bpf_ringbuf_reserve(&kernel_ringbuf, sizeof(*msg), 0);
+	if (!msg) {
+		err = 4;
+		return 1;
+	}
+
+	switch (index % TEST_MSG_OP_NUM_OPS) {
+	case TEST_MSG_OP_INC64:
+		msg->operand_64 = operand_64;
+		msg->msg_op = TEST_MSG_OP_INC64;
+		expected_user_mutated += operand_64;
+		break;
+	case TEST_MSG_OP_INC32:
+		msg->operand_32 = operand_32;
+		msg->msg_op = TEST_MSG_OP_INC32;
+		expected_user_mutated += operand_32;
+		break;
+	case TEST_MSG_OP_MUL64:
+		msg->operand_64 = operand_64;
+		msg->msg_op = TEST_MSG_OP_MUL64;
+		expected_user_mutated *= operand_64;
+		break;
+	case TEST_MSG_OP_MUL32:
+		msg->operand_32 = operand_32;
+		msg->msg_op = TEST_MSG_OP_MUL32;
+		expected_user_mutated *= operand_32;
+		break;
+	default:
+		bpf_ringbuf_discard(msg, 0);
+		err = 5;
+		return 1;
+	}
+
+	bpf_ringbuf_submit(msg, 0);
+
+	return 0;
+}
+
+static void
+publish_kern_messages(void)
+{
+	if (expected_user_mutated != user_mutated) {
+		bpf_printk("%d != %d\n", expected_user_mutated, user_mutated);
+		err = 3;
+		return;
+	}
+
+	bpf_loop(8, publish_next_kern_msg, NULL, 0);
+}
+
+SEC("fentry/" SYS_PREFIX "sys_getcwd")
+int test_user_ringbuf_protocol(void *ctx)
+{
+	long status = 0;
+	struct sample *sample = NULL;
+	struct bpf_dynptr ptr;
+
+	if (!is_test_process())
+		return 0;
+
+	status = bpf_user_ringbuf_drain(&user_ringbuf, read_protocol_msg, NULL, 0);
+	if (status < 0) {
+		bpf_printk("Drain returned: %ld\n", status);
+		err = 1;
+		return 0;
+	}
+
+	publish_kern_messages();
+
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int test_user_ringbuf(void *ctx)
+{
+	int status = 0;
+	struct sample *sample = NULL;
+	struct bpf_dynptr ptr;
+
+	if (!is_test_process())
+		return 0;
+
+	err = bpf_user_ringbuf_drain(&user_ringbuf, record_sample, NULL, 0);
+
+	return 0;
+}
+
+static long
+do_nothing_cb(struct bpf_dynptr *dynptr, void *context)
+{
+	__sync_fetch_and_add(&read, 1);
+	return 0;
+}
+
+SEC("fentry/" SYS_PREFIX "sys_getrlimit")
+int test_user_ringbuf_epoll(void *ctx)
+{
+	long num_samples;
+
+	if (!is_test_process())
+		return 0;
+
+	num_samples = bpf_user_ringbuf_drain(&user_ringbuf, do_nothing_cb, NULL,
+					     0);
+	if (num_samples <= 0)
+		err = 1;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_user_ringbuf.h b/tools/testing/selftests/bpf/test_user_ringbuf.h
new file mode 100644
index 000000000000..1643b4d59ba7
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_user_ringbuf.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _TEST_USER_RINGBUF_H
+#define _TEST_USER_RINGBUF_H
+
+#define TEST_OP_64 4
+#define TEST_OP_32 2
+
+enum test_msg_op {
+	TEST_MSG_OP_INC64,
+	TEST_MSG_OP_INC32,
+	TEST_MSG_OP_MUL64,
+	TEST_MSG_OP_MUL32,
+
+	// Must come last.
+	TEST_MSG_OP_NUM_OPS,
+};
+
+struct test_msg {
+	enum test_msg_op msg_op;
+	union {
+		__s64 operand_64;
+		__s32 operand_32;
+	};
+};
+
+struct sample {
+	int pid;
+	int seq;
+	long value;
+	char comm[16];
+};
+
+#endif /* _TEST_USER_RINGBUF_H */
-- 
2.30.2

