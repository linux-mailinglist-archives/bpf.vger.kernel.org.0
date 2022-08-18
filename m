Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC71059904D
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 00:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbiHRWNG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 18:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbiHRWMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 18:12:53 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CD2D2B2C;
        Thu, 18 Aug 2022 15:12:50 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id b2so2170438qkh.12;
        Thu, 18 Aug 2022 15:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IPE6ZkOz25DaM8MPwquoglqMb4NvpJbWwzXgRvcsZEQ=;
        b=pLMv61rd6k6zqASgnqwQlvmuvFcdQvY1GZv/Qjei/LT/wMaQivcknI9e7TM/pYv7VU
         /k7qn2m+BWtMbrOrDGiODC2MTRf/xG6TuA39Nx09ol0wCNlo5CBvqoXCgLaohB+56KHM
         miAXCrzGZtb0TIAw12fM3vn2reDWY8KuL9INgovmTzcC8qRU72QS1ZIS8l0ipodHf/Lb
         2KZIFAXF7SRQPhbCVW+BXoBi4jl6zCnrouqPbQFgoHrjv7xVAEDS+0DMudmOhjqrHosL
         77ZzMZS05YM8LYm07WT2j3p0dp5mVyVsUxOnkaBupgPY7VR9qukzQ7G8QtEuUeWqQ8Fw
         o76Q==
X-Gm-Message-State: ACgBeo1OF6D27Iau8AuqIZIaO36/NiWqv8Wc7fBzgxI9o3wjIqtgDIWH
        zUjFa+x2bNTnHGeZwUlyNuWSd+2DY8RxQINa
X-Google-Smtp-Source: AA6agR52gcZMbpiLeK78h0Koe+fSV0jeZix1XoXpFrr2BcBxpoWAykBr6WM1SexPmVkF7kxWsA8WeQ==
X-Received: by 2002:a05:620a:248a:b0:6bb:16a8:a80a with SMTP id i10-20020a05620a248a00b006bb16a8a80amr3605297qkn.619.1660860769447;
        Thu, 18 Aug 2022 15:12:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::70d6])
        by smtp.gmail.com with ESMTPSA id u22-20020a05620a431600b006b99b78751csm2373943qko.112.2022.08.18.15.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:12:49 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Cc:     kernel-team@fb.com, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        joannelkoong@gmail.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] selftests/bpf: Add selftests validating the user ringbuf
Date:   Thu, 18 Aug 2022 17:12:13 -0500
Message-Id: <20220818221212.464487-5-void@manifault.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220818221212.464487-1-void@manifault.com>
References: <20220818221212.464487-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 .../selftests/bpf/prog_tests/user_ringbuf.c   | 755 ++++++++++++++++++
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 177 ++++
 .../bpf/progs/user_ringbuf_success.c          | 220 +++++
 .../testing/selftests/bpf/test_user_ringbuf.h |  35 +
 4 files changed, 1187 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_ringbuf_success.c
 create mode 100644 tools/testing/selftests/bpf/test_user_ringbuf.h

diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
new file mode 100644
index 000000000000..83a0e1fad4a1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
@@ -0,0 +1,755 @@
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
+#include <uapi/linux/bpf.h>
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
+static int write_samples(struct user_ring_buffer *ringbuf, uint32_t num_samples)
+{
+	int i, err = 0;
+
+	/* Write some number of samples to the ring buffer. */
+	for (i = 0; i < num_samples; i++) {
+		struct sample *entry;
+		int read;
+
+		entry = user_ring_buffer__reserve(ringbuf, sizeof(*entry));
+		if (!entry) {
+			err = -errno;
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
+			user_ring_buffer__discard(ringbuf, entry);
+			goto done;
+		}
+
+		user_ring_buffer__submit(ringbuf, entry);
+	}
+
+done:
+	drain_current_samples();
+
+	return err;
+}
+
+static struct user_ringbuf_success *open_load_ringbuf_skel(void)
+{
+	struct user_ringbuf_success *skel;
+	int err;
+
+	skel = user_ringbuf_success__open();
+	if (CHECK(!skel, "skel_open", "skeleton open failed\n"))
+		return NULL;
+
+	err = bpf_map__set_max_entries(skel->maps.user_ringbuf, c_ringbuf_size);
+	if (CHECK(err != 0, "set_max_entries", "set max entries failed: %d\n", err))
+		goto cleanup;
+
+	err = bpf_map__set_max_entries(skel->maps.kernel_ringbuf, c_ringbuf_size);
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
+				     struct user_ring_buffer **user_ringbuf_out)
+{
+	struct user_ringbuf_success *skel;
+	struct ring_buffer *kern_ringbuf = NULL;
+	struct user_ring_buffer *user_ringbuf = NULL;
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
+		if (CHECK(!kern_ringbuf, "kern_ringbuf_create", "failed to create kern ringbuf\n"))
+			goto cleanup;
+
+		*kern_ringbuf_out = kern_ringbuf;
+	}
+
+	if (user_ringbuf_out) {
+		rb_fd = bpf_map__fd(skel->maps.user_ringbuf);
+		user_ringbuf = user_ring_buffer__new(rb_fd, NULL);
+		if (CHECK(!user_ringbuf, "user_ringbuf_create", "failed to create user ringbuf\n"))
+			goto cleanup;
+
+		*user_ringbuf_out = user_ringbuf;
+		ASSERT_EQ(skel->bss->read, 0, "no_reads_after_load");
+	}
+
+	err = user_ringbuf_success__attach(skel);
+	if (CHECK(err != 0, "skel_attach", "skeleton attachment failed: %d\n", err))
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
+	user_ring_buffer__free(user_ringbuf);
+	user_ringbuf_success__destroy(skel);
+	return err;
+}
+
+static int load_skel_create_user_ringbuf(struct user_ringbuf_success **skel_out,
+					 struct user_ring_buffer **ringbuf_out)
+{
+	return load_skel_create_ringbufs(skel_out, NULL, NULL, ringbuf_out);
+}
+
+static void manually_write_test_invalid_sample(struct user_ringbuf_success *skel,
+					       __u32 size, __u64 producer_pos)
+{
+	void *data_ptr;
+	__u64 *producer_pos_ptr;
+	int rb_fd, page_size = getpagesize();
+
+	rb_fd = bpf_map__fd(skel->maps.user_ringbuf);
+
+	ASSERT_EQ(skel->bss->read, 0, "num_samples_before_bad_sample");
+
+	/* Map the producer_pos as RW. */
+	producer_pos_ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+				MAP_SHARED, rb_fd, page_size);
+	ASSERT_OK_PTR(producer_pos_ptr, "producer_pos_ptr");
+
+	/* Map the data pages as RW. */
+	data_ptr = mmap(NULL, page_size, PROT_WRITE, MAP_SHARED, rb_fd, 2 * page_size);
+	ASSERT_OK_PTR(data_ptr, "rw_data");
+
+	memset(data_ptr, 0, BPF_RINGBUF_HDR_SZ);
+	*(__u32 *)data_ptr = size;
+
+	/* Synchronizes with smp_load_acquire() in __bpf_user_ringbuf_peek() in the kernel. */
+	smp_store_release(producer_pos_ptr, producer_pos + BPF_RINGBUF_HDR_SZ);
+
+	drain_current_samples();
+	ASSERT_EQ(skel->bss->read, 0, "num_samples_after_bad_sample");
+	ASSERT_EQ(skel->bss->err, -EINVAL, "err_after_bad_sample");
+
+	ASSERT_OK(munmap(producer_pos_ptr, page_size), "unmap_producer_pos");
+	ASSERT_OK(munmap(data_ptr, page_size), "unmap_data_ptr");
+}
+
+static void test_user_ringbuf_post_misaligned(void)
+{
+	struct user_ringbuf_success *skel;
+	struct user_ring_buffer *ringbuf;
+	int err;
+	__u32 size = (1 << 5) + 7;
+
+	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
+	if (CHECK(err, "misaligned_skel", "Failed to create skel\n"))
+		return;
+
+	manually_write_test_invalid_sample(skel, size, size);
+	user_ring_buffer__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static void test_user_ringbuf_post_producer_wrong_offset(void)
+{
+	struct user_ringbuf_success *skel;
+	struct user_ring_buffer *ringbuf;
+	int err;
+	__u32 size = (1 << 5);
+
+	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
+	if (CHECK(err, "wrong_offset_skel", "Failed to create skel\n"))
+		return;
+
+	manually_write_test_invalid_sample(skel, size, size - 8);
+	user_ring_buffer__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static void test_user_ringbuf_post_larger_than_ringbuf_sz(void)
+{
+	struct user_ringbuf_success *skel;
+	struct user_ring_buffer *ringbuf;
+	int err;
+	__u32 size = c_ringbuf_size;
+
+	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
+	if (CHECK(err, "huge_sample_skel", "Failed to create skel\n"))
+		return;
+
+	manually_write_test_invalid_sample(skel, size, size);
+	user_ring_buffer__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static void test_user_ringbuf_basic(void)
+{
+	struct user_ringbuf_success *skel;
+	struct user_ring_buffer *ringbuf;
+	int err;
+
+	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
+	if (CHECK(err, "ringbuf_basic_skel", "Failed to create skel\n"))
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
+	user_ring_buffer__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static void test_user_ringbuf_sample_full_ringbuffer(void)
+{
+	struct user_ringbuf_success *skel;
+	struct user_ring_buffer *ringbuf;
+	int err;
+	void *sample;
+
+	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
+	if (CHECK(err, "ringbuf_full_sample_skel", "Failed to create skel\n"))
+		return;
+
+	sample = user_ring_buffer__reserve(ringbuf, c_ringbuf_size - BPF_RINGBUF_HDR_SZ);
+	if (CHECK(sample == NULL, "full_sample", "failed to create big sample: %d\n", errno))
+		goto cleanup;
+
+	user_ring_buffer__submit(ringbuf, sample);
+	ASSERT_EQ(skel->bss->read, 0, "num_samples_read_before");
+	drain_current_samples();
+	ASSERT_EQ(skel->bss->read, 1, "num_samples_read_after");
+
+cleanup:
+	user_ring_buffer__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static void test_user_ringbuf_post_alignment_autoadjust(void)
+{
+	struct user_ringbuf_success *skel;
+	struct user_ring_buffer *ringbuf;
+	struct sample *sample;
+	int err;
+
+	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
+	if (CHECK(err, "ringbuf_align_autoadjust_skel", "Failed to create skel\n"))
+		return;
+
+	/* libbpf should automatically round any sample up to an 8-byte alignment. */
+	sample = user_ring_buffer__reserve(ringbuf, sizeof(*sample) + 1);
+	CHECK(sample == NULL, "reserve_autoaligned",
+	      "Failed to properly handle autoaligned size\n");
+	user_ring_buffer__submit(ringbuf, sample);
+
+	ASSERT_EQ(skel->bss->read, 0, "num_samples_read_before");
+	drain_current_samples();
+	ASSERT_EQ(skel->bss->read, 1, "num_samples_read_after");
+
+	user_ring_buffer__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static void test_user_ringbuf_overfill(void)
+{
+	struct user_ringbuf_success *skel;
+	struct user_ring_buffer *ringbuf;
+	int err;
+
+	err = load_skel_create_user_ringbuf(&skel, &ringbuf);
+	if (err)
+		return;
+
+	err = write_samples(ringbuf, c_max_entries * 5);
+	CHECK(!err, "write_samples", "Incorrectly overcommitted ringbuffer\n");
+	ASSERT_EQ(errno, ENODATA, "too_many_samples_posted");
+	ASSERT_EQ(skel->bss->read, c_max_entries, "max_entries");
+
+	user_ring_buffer__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static void test_user_ringbuf_discards_properly_ignored(void)
+{
+	struct user_ringbuf_success *skel;
+	struct user_ring_buffer *ringbuf;
+	int err, num_discarded = 0;
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
+		token = user_ring_buffer__reserve(ringbuf, sizeof(*token));
+		if (!token)
+			break;
+
+		user_ring_buffer__discard(ringbuf, token);
+		num_discarded++;
+	}
+
+	if (!ASSERT_GE(num_discarded, 0, "num_discarded"))
+		goto cleanup;
+
+	/* Should not read any samples, as they are all discarded. */
+	ASSERT_EQ(skel->bss->read, 0, "num_pre_kick");
+	drain_current_samples();
+	ASSERT_EQ(skel->bss->read, 0, "num_post_kick");
+
+	/* Now that the ringbuffer has been drained, we should be able to reserve another token. */
+	token = user_ring_buffer__reserve(ringbuf, sizeof(*token));
+
+	if (CHECK(!token, "new_token", "Failed to get entry after drain\n"))
+		goto cleanup;
+
+	user_ring_buffer__discard(ringbuf, token);
+cleanup:
+	user_ring_buffer__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static void test_user_ringbuf_loop(void)
+{
+	struct user_ringbuf_success *skel;
+	struct user_ring_buffer *ringbuf;
+	uint32_t total_samples = 8192;
+	uint32_t remaining_samples = total_samples;
+	int err;
+
+	BUILD_BUG_ON(total_samples <= c_max_entries);
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
+			CHECK(err, "write_samples", "failed to write sample batch: %d\n", err);
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
+	user_ring_buffer__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static int send_test_message(struct user_ring_buffer *ringbuf,
+			     enum test_msg_op op, s64 operand_64,
+			     s32 operand_32)
+{
+	struct test_msg *msg;
+
+	msg = user_ring_buffer__reserve(ringbuf, sizeof(*msg));
+	if (!msg) {
+		/* Only invoke CHECK on the error path to avoid spamming
+		 * logs with mostly success messages.
+		 */
+		CHECK(msg != NULL, "reserve_msg", "Failed to reserve message\n");
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
+		user_ring_buffer__discard(ringbuf, msg);
+		return -EINVAL;
+	}
+
+	user_ring_buffer__submit(ringbuf, msg);
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
+		CHECK(!err, "consume_kern_ringbuf", "Failed to consume kernel ringbuf\n");
+}
+
+static void test_user_ringbuf_msg_protocol(void)
+{
+	struct user_ringbuf_success *skel;
+	struct user_ring_buffer *user_ringbuf;
+	struct ring_buffer *kern_ringbuf;
+	int err, i;
+	__u64 expected_kern = 0;
+
+	err = load_skel_create_ringbufs(&skel, &kern_ringbuf, handle_kernel_msg, &user_ringbuf);
+	if (CHECK(err, "create_ringbufs", "Failed to create ringbufs: %d\n", err))
+		return;
+
+	for (i = 0; i < 64; i++) {
+		enum test_msg_op op = i % TEST_MSG_OP_NUM_OPS;
+		__u64 operand_64 = TEST_OP_64;
+		__u32 operand_32 = TEST_OP_32;
+
+		err = send_test_message(user_ringbuf, op, operand_64, operand_32);
+		if (err) {
+			CHECK(err, "send_test_message", "Failed to send test message\n");
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
+			ASSERT_EQ(skel->bss->kern_mutated, expected_kern, "expected_kern");
+			ASSERT_EQ(skel->bss->err, 0, "bpf_prog_err");
+			drain_kernel_messages_buffer(kern_ringbuf);
+		}
+	}
+
+cleanup:
+	ring_buffer__free(kern_ringbuf);
+	user_ring_buffer__free(user_ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static void *kick_kernel_cb(void *arg)
+{
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
+static void test_user_ringbuf_blocking_reserve(void)
+{
+	struct user_ringbuf_success *skel;
+	struct user_ring_buffer *ringbuf;
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
+		token = user_ring_buffer__reserve(ringbuf, sizeof(*token));
+		if (!token)
+			break;
+
+		*token = 0xdeadbeef;
+
+		user_ring_buffer__submit(ringbuf, token);
+		num_written++;
+	}
+
+	if (!ASSERT_GE(num_written, 0, "num_written"))
+		goto cleanup;
+
+	/* Should not have read any samples until the kernel is kicked. */
+	ASSERT_EQ(skel->bss->read, 0, "num_pre_kick");
+
+	/* We correctly time out after 1 second, without a sample. */
+	token = user_ring_buffer__reserve_blocking(ringbuf, sizeof(*token), 1000);
+	if (!ASSERT_EQ(token, NULL, "pre_kick_timeout_token"))
+		goto cleanup;
+
+	err = spawn_kick_thread_for_poll();
+	if (!ASSERT_EQ(err, 0, "deferred_kick_thread\n"))
+		goto cleanup;
+
+	/* After spawning another thread that asychronously kicks the kernel to
+	 * drain the messages, we're able to block and successfully get a
+	 * sample once we receive an event notification.
+	 */
+	token = user_ring_buffer__reserve_blocking(ringbuf, sizeof(*token), 10000);
+
+	if (CHECK(!token, "block_token", "Failed to block for a ringbuf entry\n"))
+		goto cleanup;
+
+	ASSERT_GT(skel->bss->read, 0, "num_post_kill");
+	ASSERT_LE(skel->bss->read, num_written, "num_post_kill");
+	ASSERT_EQ(skel->bss->err, 0, "err_post_poll");
+	user_ring_buffer__discard(ringbuf, token);
+
+cleanup:
+	user_ring_buffer__free(ringbuf);
+	user_ringbuf_success__destroy(skel);
+}
+
+static struct {
+	const char *prog_name;
+	const char *expected_err_msg;
+} failure_tests[] = {
+	/* failure cases */
+	{"user_ringbuf_callback_bad_access1", "negative offset dynptr_ptr ptr"},
+	{"user_ringbuf_callback_bad_access2", "dereference of modified dynptr_ptr ptr"},
+	{"user_ringbuf_callback_write_forbidden", "invalid mem access 'dynptr_ptr'"},
+	{"user_ringbuf_callback_null_context_write", "invalid mem access 'scalar'"},
+	{"user_ringbuf_callback_null_context_read", "invalid mem access 'scalar'"},
+	{"user_ringbuf_callback_discard_dynptr", "arg 1 is an unacquired reference"},
+	{"user_ringbuf_callback_submit_dynptr", "arg 1 is an unacquired reference"},
+	{"user_ringbuf_callback_invalid_return", "At callback return the register R0 has value"},
+};
+
+#define SUCCESS_TEST(_func) { _func, #_func }
+
+static struct {
+	void (*test_callback)(void);
+	const char *test_name;
+} success_tests[] = {
+	SUCCESS_TEST(test_user_ringbuf_mappings),
+	SUCCESS_TEST(test_user_ringbuf_post_misaligned),
+	SUCCESS_TEST(test_user_ringbuf_post_producer_wrong_offset),
+	SUCCESS_TEST(test_user_ringbuf_post_larger_than_ringbuf_sz),
+	SUCCESS_TEST(test_user_ringbuf_basic),
+	SUCCESS_TEST(test_user_ringbuf_sample_full_ringbuffer),
+	SUCCESS_TEST(test_user_ringbuf_post_alignment_autoadjust),
+	SUCCESS_TEST(test_user_ringbuf_overfill),
+	SUCCESS_TEST(test_user_ringbuf_discards_properly_ignored),
+	SUCCESS_TEST(test_user_ringbuf_loop),
+	SUCCESS_TEST(test_user_ringbuf_msg_protocol),
+	SUCCESS_TEST(test_user_ringbuf_blocking_reserve),
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
+		verify_fail(failure_tests[i].prog_name, failure_tests[i].expected_err_msg);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
new file mode 100644
index 000000000000..82aba4529aa9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -0,0 +1,177 @@
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
+	bpf_user_ringbuf_drain(&user_ringbuf, try_submit_dynptr, NULL, 0);
+
+	return 0;
+}
+
+static long
+invalid_drain_callback_return(struct bpf_dynptr *dynptr, void *context)
+{
+	return 2;
+}
+
+/* A callback that accesses a dynptr in a bpf_user_ringbuf_drain callback should
+ * not be able to write to that pointer.
+ */
+SEC("?raw_tp/sys_nanosleep")
+int user_ringbuf_callback_invalid_return(void *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf, invalid_drain_callback_return, NULL, 0);
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
2.37.1

