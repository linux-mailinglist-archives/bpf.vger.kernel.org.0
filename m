Return-Path: <bpf+bounces-48091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD40A03EF0
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66B0160953
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97A71EC004;
	Tue,  7 Jan 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vlltfxr+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300381EC01E;
	Tue,  7 Jan 2025 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736252200; cv=none; b=EJDAfXsPotgWtYGVIrn5Y+CpPH54hPT2d+vLMi35SI4aX0XOPzIN8kc01W1TQa4pAMHn88kFmlDhx95zqIR3nfYsn/fRMduKzufEYUmU3KgcjsmlF0pMk8HzdFsU/HAKWl5GmPQWQOhWg1PDGfMzq8yy8eoNTJ5trYQHiwcgrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736252200; c=relaxed/simple;
	bh=2qD7JRXYOvlfkmYR5r6JnWWjk3xDVrsZmCrn+a3Pj5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7jHzqwNmOubXF2rLV0Fv4gj0buerxLIEvUj11wXVLMBzzEdouVcLNV1AOr6UNUz41KYYWL0rCxBrHtlB2oq20BSFCwLwOLKsKJeuFdXd+b3OTJp2e1GjemmAv7fQHfaFMJpHO1ayZyO8Qb8jDT6J6iHsTy8grbutK0++QH4/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vlltfxr+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21644aca3a0so47107155ad.3;
        Tue, 07 Jan 2025 04:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736252196; x=1736856996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1IzBXLoCjFub0ZAHnwNc3v4ROMZgYPRLWuwGG7QubQ=;
        b=Vlltfxr+7UJ+7f+szEvT9OLKwDYbKLtevr6Z6OCcJmUJ3FBkYfTrcWtot+EIXWlW3p
         aIS3iE/csKOQwSGUyterhBS62iF4rJQVwLDifO6z+KtKO7hmy/9w5BH85s8ya19aRfwD
         sOjHTyxPUW14s/W6lQgWmz+uTF2hYf6K6aSsAGBddrIXxL3cBHpm9vEX3jNFVscEPG1g
         WroSTNc5JRj6u/FWd2yNDXCN4WUeNIvuGyfFvJZSNRstG3DqoAno0E+zTSe7tYELZ6mx
         w/txUgpXkRaDKcS2JFTbdtGFnffSDXG8T8tLuySiomk04OigPPL+pUA09G0z1q9mmk1K
         px+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736252196; x=1736856996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1IzBXLoCjFub0ZAHnwNc3v4ROMZgYPRLWuwGG7QubQ=;
        b=iQpaPIUjb5aRqqQH5R1q/X7uBORgG6XmIGh0eVuFqm+hGznTHsqPoZjtVwRjGmvprw
         G31ku4dPSqongLmf07cj29BBCv2oSEKjM85mwjb91aQuuDXPJy7N5hVYr9VSyOiyW92i
         DD0qUyTSADEbfR4d1Y4nWjIV6tW9ZWaWM1yWmXHQU1sGjn+WaisqsegYlppI9ciYoiSg
         m5aA1XKzbrxbxpJ4ruE0YhRqe+j1634ANrOIqKMnA7UhlieLEwiRwbzyfODswm5nQh8p
         +k8pP98FTjIKZZ7zld5B20Buowsc8t2ILrwp0/KtQVDYxHgp6ZKIhn6Vmx5oXcdDEZ4U
         vr4w==
X-Forwarded-Encrypted: i=1; AJvYcCWpiR9jY9eZ2pR2SvpAXQE3ES+pw8CjcFOSvG+h93sNr88z+NPY67VOX+bGTB+cW8Di+yocNMUnsoS7og==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYf6ChctPUJMagIaqZZE5/aTnK0l0HtPakVLmodVBkcmU5hCKz
	7ZOHa2R6Z+mgHWp4RXQP7HZG2b8pstyExS2rHqItxAEmo5J7W48XHq8tmBtuflc=
X-Gm-Gg: ASbGnctPWcifGtl2ImzcH3ZJR9ws/CCx/YNmgerm35PxkpjvenO/JhiKmC/gS+OVhVM
	rMcgo8XOFn0hmKXwqAFdmM74DcJSs1jBgzL0ikhuCshwgysOmU5dD19b3darj4cbnMebXiL+Mv0
	Y7ZHSRvmPJ2KSZ9NBc3aUH4NoOEQzUFHMPq8g0yMOIOUmd85qr0RNRJLzPWJSYvNy8Ve6SMgzgU
	mv0/Rp0y0Goo+xcOnhD0xOw0S7+FFx8Z0cq2V8Rr/z0bL2upIrjXPol8OtWM+J0sisg
X-Google-Smtp-Source: AGHT+IGTsINaaLmInB+0gPDXxGddb3lHVZPN4pP3+Y/7JAdNdqaFpnGgCOZJ0whUpgZ3dwwQkfLLEQ==
X-Received: by 2002:a05:6a20:8427:b0:1e0:ca95:3cb2 with SMTP id adf61e73a8af0-1e5e0458eb9mr109041326637.8.1736251718952;
        Tue, 07 Jan 2025 04:08:38 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:38 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 14/22] selftests: ublk: add tests for covering redirecting to userspace
Date: Tue,  7 Jan 2025 20:04:05 +0800
Message-ID: <20250107120417.1237392-15-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250107120417.1237392-1-tom.leiming@gmail.com>
References: <20250107120417.1237392-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reuse ublk-null for testing UBLK_BPF_IO_REDIRECT:

- queue & complete io with odd tag number
- redirect io with even tag number, and let userspace handle their
queueing & completion
- also select some ios, and returns -EAGAIN from userspace & marking
it as ready for bpf prog to handle, then finally completed with bpf
prog in 2nd time

So we can cover code path for UBLK_BPF_IO_REDIRECT.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 .../selftests/ublk/progs/ublk_bpf_kfunc.h     | 10 +++
 .../testing/selftests/ublk/progs/ublk_null.c  | 68 +++++++++++++++++++
 tools/testing/selftests/ublk/test_null_04.sh  | 21 ++++++
 tools/testing/selftests/ublk/ublk_bpf.c       | 39 ++++++++++-
 5 files changed, 136 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_null_04.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 5a940bae9cbb..38903f05d99d 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -22,6 +22,7 @@ endif
 TEST_PROGS := test_null_01.sh
 TEST_PROGS += test_null_02.sh
 TEST_PROGS += test_null_03.sh
+TEST_PROGS += test_null_04.sh
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS_EXTENDED = ublk_bpf
diff --git a/tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h b/tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h
index acab490d933c..1db8870b57d6 100644
--- a/tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h
+++ b/tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h
@@ -20,4 +20,14 @@ extern void ublk_bpf_complete_io(const struct ublk_bpf_io *io, int res) __ksym;
 extern int ublk_bpf_get_dev_id(const struct ublk_bpf_io *io) __ksym;
 extern int ublk_bpf_get_queue_id(const struct ublk_bpf_io *io) __ksym;
 extern int ublk_bpf_get_io_tag(const struct ublk_bpf_io *io) __ksym;
+
+static inline unsigned long long build_io_key(const struct ublk_bpf_io *io)
+{
+	unsigned long long dev_id = (unsigned short)ublk_bpf_get_dev_id(io);
+	unsigned long long q_id = (unsigned short)ublk_bpf_get_queue_id(io);
+	unsigned long long tag = ublk_bpf_get_io_tag(io);
+
+	return (dev_id << 32) | (q_id << 16) | tag;
+}
+
 #endif
diff --git a/tools/testing/selftests/ublk/progs/ublk_null.c b/tools/testing/selftests/ublk/progs/ublk_null.c
index 523bf8ff3ef8..cebdc8a2a214 100644
--- a/tools/testing/selftests/ublk/progs/ublk_null.c
+++ b/tools/testing/selftests/ublk/progs/ublk_null.c
@@ -9,6 +9,14 @@
 //#define DEBUG
 #include "ublk_bpf.h"
 
+/* todo: make it writable payload of ublk_bpf_io */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10240);
+	__type(key, unsigned long long);	/* dev_id + q_id + tag */
+	__type(value, int);
+} io_map SEC(".maps");
+
 /* libbpf v1.4.5 is required for struct_ops to work */
 
 static inline ublk_bpf_return_t __ublk_null_handle_io_split(const struct ublk_bpf_io *io, unsigned int _off)
@@ -44,6 +52,54 @@ static inline ublk_bpf_return_t __ublk_null_handle_io_split(const struct ublk_bp
 	return ublk_bpf_return_val(UBLK_BPF_IO_QUEUED, 0);
 }
 
+static inline ublk_bpf_return_t __ublk_null_handle_io_redirect(const struct ublk_bpf_io *io, unsigned int _off)
+{
+	unsigned int tag = ublk_bpf_get_io_tag(io);
+	unsigned long off = -1, sects = -1;
+	const struct ublksrv_io_desc *iod;
+	int res;
+
+	iod = ublk_bpf_get_iod(io);
+	if (iod) {
+		res = iod->nr_sectors << 9;
+		off = iod->start_sector;
+		sects = iod->nr_sectors;
+	} else
+		res = -EINVAL;
+
+	BPF_DBG("ublk dev %u qid %u: handle io tag %u %lx-%d res %d",
+			ublk_bpf_get_dev_id(io),
+			ublk_bpf_get_queue_id(io),
+			ublk_bpf_get_io_tag(io),
+			off, sects, res);
+	if (res < 0) {
+		ublk_bpf_complete_io(io, res);
+		return ublk_bpf_return_val(UBLK_BPF_IO_QUEUED, 0);
+	}
+
+	if (tag & 0x1) {
+		/* complete the whole io command after the 2nd sub-io is queued */
+		ublk_bpf_complete_io(io, res);
+		return ublk_bpf_return_val(UBLK_BPF_IO_QUEUED, 0);
+	} else {
+		unsigned long long key = build_io_key(io);
+		int *pv;
+
+		/* stored value means if it is ready to complete IO */
+		pv = bpf_map_lookup_elem(&io_map, &key);
+		if (pv && *pv) {
+			ublk_bpf_complete_io(io, res);
+			return ublk_bpf_return_val(UBLK_BPF_IO_QUEUED, 0);
+		} else {
+			int v = 0;
+			res = bpf_map_update_elem(&io_map, &key, &v, BPF_ANY);
+			if (res)
+				bpf_printk("update io map element failed %d key %llx\n", res, key);
+			return ublk_bpf_return_val(UBLK_BPF_IO_REDIRECT, 0);
+		}
+	}
+}
+
 
 static inline ublk_bpf_return_t __ublk_null_handle_io(const struct ublk_bpf_io *io, unsigned int _off)
 {
@@ -106,4 +162,16 @@ struct ublk_bpf_ops null_ublk_bpf_ops_split = {
 	.queue_io_cmd = (void *)ublk_null_handle_io_split,
 };
 
+SEC("struct_ops/ublk_bpf_queue_io_cmd")
+ublk_bpf_return_t BPF_PROG(ublk_null_handle_io_redirect, struct ublk_bpf_io *io, unsigned int off)
+{
+	return __ublk_null_handle_io_redirect(io, off);
+}
+
+SEC(".struct_ops.link")
+struct ublk_bpf_ops null_ublk_bpf_ops_redirect = {
+	.id = 2,
+	.queue_io_cmd = (void *)ublk_null_handle_io_redirect,
+};
+
 char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/ublk/test_null_04.sh b/tools/testing/selftests/ublk/test_null_04.sh
new file mode 100755
index 000000000000..f175e2ddb5cd
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_null_04.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+
+. test_common.sh
+
+TID="null_04"
+ERR_CODE=0
+
+# prepare and register & pin bpf prog
+_prep_bpf_test "null" ublk_null.bpf.o
+
+# add two ublk null disks with the pinned bpf prog
+_add_ublk_dev -t null -n 0 --bpf_prog 2 --quiet
+
+# run fio over the ublk disk
+fio --name=job1 --filename=/dev/ublkb0 --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
+ERR_CODE=$?
+
+# clean and unregister & unpin the bpf prog
+_cleanup_bpf_test "null"
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/ublk_bpf.c b/tools/testing/selftests/ublk/ublk_bpf.c
index 2d923e42845d..e2c2e92268e1 100644
--- a/tools/testing/selftests/ublk/ublk_bpf.c
+++ b/tools/testing/selftests/ublk/ublk_bpf.c
@@ -1283,6 +1283,16 @@ static int cmd_dev_help(char *exe)
 }
 
 /****************** part 2: target implementation ********************/
+//extern int bpf_map_update_elem(int fd, const void *key, const void *value,
+//                                   __u64 flags);
+
+static inline unsigned long long build_io_key(struct ublk_queue *q, int tag)
+{
+       unsigned long long dev_id = (unsigned short)q->dev->dev_info.dev_id;
+       unsigned long long q_id = (unsigned short)q->q_id;
+
+       return (dev_id << 32) | (q_id << 16) | tag;
+}
 
 static int ublk_null_tgt_init(struct ublk_dev *dev)
 {
@@ -1314,12 +1324,35 @@ static int ublk_null_tgt_init(struct ublk_dev *dev)
 static int ublk_null_queue_io(struct ublk_queue *q, int tag)
 {
 	const struct ublksrv_io_desc *iod = ublk_get_iod(q, tag);
+	bool bpf = q->dev->dev_info.flags & UBLK_F_BPF;
 
-	/* won't be called for UBLK_F_BPF */
-	assert(!(q->dev->dev_info.flags & UBLK_F_BPF));
+	/* either !UBLK_F_BPF or UBLK_F_BPF with redirect */
+	assert(!bpf || (bpf && !(tag & 0x1)));
 
-	ublk_complete_io(q, tag, iod->nr_sectors << 9);
+	if (bpf && (tag % 4)) {
+		unsigned long long key = build_io_key(q, tag);
+		int map_fd;
+		int err;
+		int val = 1;
+
+		map_fd = bpf_obj_get("/sys/fs/bpf/ublk/null/io_map");
+		if (map_fd < 0) {
+			ublk_err("Error finding BPF map fd from pinned path\n");
+			goto exit;
+		}
+
+		/* make this io ready for bpf prog to handle */
+		err = bpf_map_update_elem(map_fd, &key, &val, BPF_ANY);
+		if (err) {
+			ublk_err("Error updating map element: %d\n", errno);
+			goto exit;
+		}
+		ublk_complete_io(q, tag, -EAGAIN);
+		return 0;
+	}
 
+exit:
+	ublk_complete_io(q, tag, iod->nr_sectors << 9);
 	return 0;
 }
 
-- 
2.47.0


