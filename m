Return-Path: <bpf+bounces-48087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A65AA03EC2
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D88D3A49E3
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710191EE03B;
	Tue,  7 Jan 2025 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc/8B4EL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933631EE7B4;
	Tue,  7 Jan 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251792; cv=none; b=ZGSXuQqILfRBYVKf7JEpl8lmwYdLGAbboME+PFVK1KNMA49/KA07wOFHK3OJZPQpguO1IbbW9lp4+pPFXjuzk2tX2R275hkdlkPoyKSbrL6nwvJ6XS7ubinC9qsMj0YIug/OCvaFA90PD0Wt79kepTflUkNElbC6e8xmwDMLZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251792; c=relaxed/simple;
	bh=f5L3NOtDgrIxKxz+MIuEtL6HHvK1MQWt487MDa2bWI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9Pt17trSgt+gTZdZxvBfE1iCSjW9eznuaGhs7NLtWceJNpaS5sxsl2LHFdRGiCrG5JHc4CVIdyD8ozBqb6u7e5N/BbkmQwLRZ6PiC2Zo10jPEhInlMkiXKCxSA+2+ezMwTuEdxm2UqL/3qCZ+81IWmBzp8cOzbZD5dTYp6Y2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc/8B4EL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21636268e43so45719895ad.2;
        Tue, 07 Jan 2025 04:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251738; x=1736856538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BuNFZWGqYgSgLMfecofkQzEbOmOZM/5htkp9yJ0Ubs=;
        b=mc/8B4ELowCq+NBsdTQwy1ysL3c0Zg6F1FIQj2dpXw3+jzD7cvU+w1F0W27mDKRA+2
         DJq5X5mUid0fVVLiCuiH3YNUC2k+1zi5QHgZ/zFTpC/t2+M/LOywbKc9PmcnFIJgJbT2
         BfNilZCZAlM6tzpq1/vGtl3XOVD31TWK86Wd2JMCGmFub7E0NdCetkYo/dN49QAThbvn
         VTJuUkd10RySjn0xjKqApSwuqwCI40rS9GW0s/mUkQy5iHtSCuAJNAFQywTHZi7KFTEB
         C+ARXRHOgdMO8o+neiqGFqnPAvKcp5WxGp23HVkIee6mKd8XnetL6H10Pof33STcH9AH
         CS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251738; x=1736856538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BuNFZWGqYgSgLMfecofkQzEbOmOZM/5htkp9yJ0Ubs=;
        b=TS0rTCitAfwMCswxxOlBZrVbkvYM9jckxoiMrnDtQoZmJ+W2Gmge7ETnJLhuapyfgi
         pzDoyeW2CDeV3v766i1ah2Fba8lTKPsIjEEGs5WG8tD0+S8ze5gBDwU+fMxetkYU5w2V
         o/fm75goyiZb/BX8Q+Scq+c1w7ps73Qh2MRObmjH08lE5JnhabVuBlSmwSjl7HIVByaA
         pvkHYvfcm+CqZt4lGZ5LyawT/VkhjoM+GivKmk/ipCqgi+uF1Kx0MCYJYlQUcHXyK+a5
         xmFvpDFcH7U/Ibx8qwpr1ob7WBiiwZsRxdGTToDC9i5PMnfoYC54pqlj35eiqnGF+1cY
         CUdA==
X-Forwarded-Encrypted: i=1; AJvYcCX50qiIkWN8WzhCRaIknJXyRP1YKhOH7gdyzkWiy+B63wtaAdbmmPddISEOvF/CO292XulUqSm/Z9iJjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNUFXoflpv/tkl09VoxQjaIsQbmf7/x0JiHGmDMhr7+B8aZhde
	555YMxXPlkE1/hrIycU+0erchJOkdp5ZxNAQVyZEfWiG3lSTmpHI
X-Gm-Gg: ASbGnctNkmCAiMCGO15MXPHbNaylPQdlwL9P4VyTRvUzYdhZwsuM3WhW50OgW9SXOkj
	1gNvPOvFY8Df87oG4ZluA8PSJwDTzJdZ8NaDvCq9EKv+VcvSa8NoMf9VBhfL0++Q4hhRC1FHoq+
	iR58j+T0imDfEo855yox5nECnghxHjjhVMktTcjBp6BMekab9sC/evFbJ8uoYouWnLfN5cxmrgA
	xqyOX7NkK3GFJ8ny5iZtzZ4MoGTUWR95jefY0uTnQN2be2pZXAwlV5Vj6zf+2NbActF
X-Google-Smtp-Source: AGHT+IGENnGhBxrC+8M9hZHMO9JRu9R3U8nGFcolu2U0Lqgy068q45LLaSI4e7pHEXjT8WUH7Mdzsw==
X-Received: by 2002:a05:6a21:6d86:b0:1e0:ae58:2945 with SMTP id adf61e73a8af0-1e5e081179bmr115955173637.31.1736251738479;
        Tue, 07 Jan 2025 04:08:58 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:57 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 20/22] selftests: add tests for ublk bpf aio
Date: Tue,  7 Jan 2025 20:04:11 +0800
Message-ID: <20250107120417.1237392-21-tom.leiming@gmail.com>
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

Create ublk loop target which uses bpf aio to submit & complete FS
IO, then run write & read & verify on the ublk loop disk for making
sure ublk bpf aio works as expected.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 tools/testing/selftests/ublk/Makefile         |   3 +
 .../selftests/ublk/progs/ublk_bpf_kfunc.h     |  11 ++
 .../testing/selftests/ublk/progs/ublk_loop.c  | 166 ++++++++++++++++++
 tools/testing/selftests/ublk/test_common.sh   |  47 +++++
 tools/testing/selftests/ublk/test_loop_01.sh  |  33 ++++
 tools/testing/selftests/ublk/test_loop_02.sh  |  24 +++
 tools/testing/selftests/ublk/ublk_bpf.c       | 141 ++++++++++++++-
 7 files changed, 419 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/progs/ublk_loop.c
 create mode 100755 tools/testing/selftests/ublk/test_loop_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_loop_02.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 38903f05d99d..2540ae7a75a3 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -24,6 +24,9 @@ TEST_PROGS += test_null_02.sh
 TEST_PROGS += test_null_03.sh
 TEST_PROGS += test_null_04.sh
 
+TEST_PROGS += test_loop_01.sh
+TEST_PROGS += test_loop_02.sh
+
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS_EXTENDED = ublk_bpf
 
diff --git a/tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h b/tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h
index 1db8870b57d6..9fb134e40d49 100644
--- a/tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h
+++ b/tools/testing/selftests/ublk/progs/ublk_bpf_kfunc.h
@@ -21,6 +21,17 @@ extern int ublk_bpf_get_dev_id(const struct ublk_bpf_io *io) __ksym;
 extern int ublk_bpf_get_queue_id(const struct ublk_bpf_io *io) __ksym;
 extern int ublk_bpf_get_io_tag(const struct ublk_bpf_io *io) __ksym;
 
+extern void ublk_bpf_dettach_and_complete_aio(struct bpf_aio *aio) __ksym;
+extern int ublk_bpf_attach_and_prep_aio(const struct ublk_bpf_io *_io, unsigned off, unsigned bytes, struct bpf_aio *aio) __ksym;
+extern struct ublk_bpf_io *ublk_bpf_acquire_io_from_aio(struct bpf_aio *aio) __ksym;
+extern void ublk_bpf_release_io_from_aio(struct ublk_bpf_io *io) __ksym;
+
+extern struct bpf_aio *bpf_aio_alloc(unsigned int op, enum bpf_aio_flag flags) __ksym;
+extern struct bpf_aio *bpf_aio_alloc_sleepable(unsigned int op, enum bpf_aio_flag flags) __ksym;
+extern void bpf_aio_release(struct bpf_aio *aio) __ksym;
+extern int bpf_aio_submit(struct bpf_aio *aio, int fd, loff_t pos,
+                unsigned bytes, unsigned io_flags) __ksym;
+
 static inline unsigned long long build_io_key(const struct ublk_bpf_io *io)
 {
 	unsigned long long dev_id = (unsigned short)ublk_bpf_get_dev_id(io);
diff --git a/tools/testing/selftests/ublk/progs/ublk_loop.c b/tools/testing/selftests/ublk/progs/ublk_loop.c
new file mode 100644
index 000000000000..952caf7b7399
--- /dev/null
+++ b/tools/testing/selftests/ublk/progs/ublk_loop.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <linux/const.h>
+#include <linux/errno.h>
+#include <linux/falloc.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+//#define DEBUG
+#include "ublk_bpf.h"
+
+/* libbpf v1.4.5 is required for struct_ops to work */
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 128);
+	__type(key, unsigned int);	/* dev id */
+	__type(value, int);		/* backing file fd */
+} fd_map SEC(".maps");
+
+static inline void ublk_loop_comp_and_release_aio(struct bpf_aio *aio, int ret)
+{
+	struct ublk_bpf_io *io = ublk_bpf_acquire_io_from_aio(aio);
+
+	ublk_bpf_complete_io(io, ret);
+	ublk_bpf_release_io_from_aio(io);
+
+	ublk_bpf_dettach_and_complete_aio(aio);
+	bpf_aio_release(aio);
+}
+
+SEC("struct_ops/bpf_aio_complete_cb")
+void BPF_PROG(ublk_loop_comp_cb, struct bpf_aio *aio, long ret)
+{
+	BPF_DBG("aio result %d, back_file %s pos %llx", ret,
+			aio->iocb.ki_filp->f_path.dentry->d_name.name,
+			aio->iocb.ki_pos);
+	ublk_loop_comp_and_release_aio(aio, ret);
+}
+
+SEC(".struct_ops.link")
+struct bpf_aio_complete_ops loop_ublk_bpf_aio_ops = {
+	.id = 16,
+	.bpf_aio_complete_cb = (void *)ublk_loop_comp_cb,
+};
+
+static inline int ublk_loop_submit_backing_io(const struct ublk_bpf_io *io,
+		const struct ublksrv_io_desc *iod, int backing_fd)
+{
+	unsigned int op_flags = 0;
+	struct bpf_aio *aio;
+	int res = -EINVAL;
+	int op;
+
+	/* translate ublk opcode into backing file's */
+	switch (iod->op_flags & 0xff) {
+	case 0 /*UBLK_IO_OP_READ*/:
+		op = BPF_AIO_OP_FS_READ;
+		break;
+	case 1 /*UBLK_IO_OP_WRITE*/:
+		op = BPF_AIO_OP_FS_WRITE;
+		break;
+	case 2 /*UBLK_IO_OP_FLUSH*/:
+		op = BPF_AIO_OP_FS_FSYNC;
+		break;
+	case 3 /*UBLK_IO_OP_DISCARD*/:
+		op = BPF_AIO_OP_FS_FALLOCATE;
+		op_flags = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
+		break;
+	case 4 /*UBLK_IO_OP_WRITE_SAME*/:
+		op = BPF_AIO_OP_FS_FALLOCATE;
+		op_flags = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
+		break;
+	case 5 /*UBLK_IO_OP_WRITE_ZEROES*/:
+		op = BPF_AIO_OP_FS_FALLOCATE;
+		op_flags = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	res = -ENOMEM;
+	aio = bpf_aio_alloc(op, 0);
+	if (!aio)
+		goto fail;
+
+	/* attach aio into the specified range of this io command */
+	res = ublk_bpf_attach_and_prep_aio(io, 0, iod->nr_sectors << 9, aio);
+	if (res < 0) {
+		bpf_printk("bpf aio attaching failed %d\n", res);
+		goto fail;
+	}
+
+	/* submit this aio onto the backing file */
+	res = bpf_aio_submit(aio, backing_fd, iod->start_sector << 9,
+			iod->nr_sectors << 9, op_flags);
+	if (res < 0) {
+		bpf_printk("aio submit failed %d\n", res);
+		ublk_loop_comp_and_release_aio(aio, res);
+	}
+	return 0;
+fail:
+	return res;
+}
+
+static inline ublk_bpf_return_t __ublk_loop_handle_io_cmd(const struct ublk_bpf_io *io, unsigned int off)
+{
+	const struct ublksrv_io_desc *iod;
+	int res = -EINVAL;
+	int fd_key = ublk_bpf_get_dev_id(io);
+	int *fd;
+	ublk_bpf_return_t ret = ublk_bpf_return_val(UBLK_BPF_IO_QUEUED, 0);
+
+	iod = ublk_bpf_get_iod(io);
+	if (!iod) {
+		ublk_bpf_complete_io(io, res);
+		return ret;
+	}
+
+	BPF_DBG("ublk dev %u qid %u: handle io cmd tag %u op %u %lx-%d off %u",
+			ublk_bpf_get_dev_id(io),
+			ublk_bpf_get_queue_id(io),
+			ublk_bpf_get_io_tag(io),
+			iod->op_flags & 0xff,
+			iod->start_sector << 9,
+			iod->nr_sectors << 9, off);
+
+	/* retrieve backing file descriptor */
+	fd = bpf_map_lookup_elem(&fd_map, &fd_key);
+	if (!fd) {
+		bpf_printk("can't get FD from %d\n", fd_key);
+		return ret;
+	}
+
+	/* handle this io command by submitting IOs on backing file */
+	res = ublk_loop_submit_backing_io(io, iod, *fd);
+
+exit:
+	/* io cmd can't be completes until this reference is dropped */
+	if (res < 0)
+		ublk_bpf_complete_io(io, io->res);
+
+	return ublk_bpf_return_val(UBLK_BPF_IO_QUEUED, 0);
+}
+
+SEC("struct_ops/ublk_bpf_release_io_cmd")
+void BPF_PROG(ublk_loop_release_io_cmd, struct ublk_bpf_io *io)
+{
+	BPF_DBG("%s: released io command %d", __func__, io->res);
+}
+
+SEC("struct_ops.s/ublk_bpf_queue_io_cmd_daemon")
+ublk_bpf_return_t BPF_PROG(ublk_loop_handle_io_cmd, struct ublk_bpf_io *io, unsigned int off)
+{
+	return __ublk_loop_handle_io_cmd(io, off);
+}
+
+SEC(".struct_ops.link")
+struct ublk_bpf_ops loop_ublk_bpf_ops = {
+	.id = 16,
+	.queue_io_cmd_daemon = (void *)ublk_loop_handle_io_cmd,
+	.release_io_cmd = (void *)ublk_loop_release_io_cmd,
+};
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 466b82e77860..4727a6ec9734 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -70,3 +70,50 @@ _add_ublk_dev() {
 	fi
 	udevadm settle
 }
+
+_create_backfile() {
+        local my_size=$1
+        local my_file=`mktemp ublk_bpf_${my_size}_XXXXX`
+
+        truncate -s ${my_size} ${my_file}
+	echo $my_file
+}
+
+_remove_backfile() {
+        local file=$1
+
+        [ -f "$file" ] && rm -f $file
+}
+
+_create_tmp_dir() {
+        local my_file=`mktemp -d ublk_bpf_dir_XXXXX`
+
+	echo $my_file
+}
+
+_remove_tmp_dir() {
+	local dir=$1
+
+	[ -d "$dir" ] && rmdir $dir
+}
+
+_mkfs_mount_test()
+{
+	local dev=$1
+	local err_code=0
+	local mnt_dir=`_create_tmp_dir`
+
+	mkfs.ext4 -F $dev > /dev/null 2>&1
+	err_code=$?
+	if [ $err_code -ne 0 ]; then
+		return $err_code
+	fi
+
+	mount -t ext4 $dev $mnt_dir > /dev/null 2>&1
+	umount $dev
+	err_code=$?
+	_remove_tmp_dir $mnt_dir
+	if [ $err_code -ne 0 ]; then
+		return $err_code
+	fi
+}
diff --git a/tools/testing/selftests/ublk/test_loop_01.sh b/tools/testing/selftests/ublk/test_loop_01.sh
new file mode 100755
index 000000000000..10c73ec0a01a
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_01.sh
@@ -0,0 +1,33 @@
+#!/bin/bash
+
+. test_common.sh
+
+TID="loop_01"
+ERR_CODE=0
+
+# prepare & register and pin bpf prog
+_prep_bpf_test "loop" ublk_loop.bpf.o
+
+backfile_0=`_create_backfile 256M`
+
+# add two ublk null disks with the pinned bpf prog
+_add_ublk_dev -t loop -n 0 --bpf_prog 16 --bpf_aio_prog 16 --quiet $backfile_0
+
+# run fio over the ublk disk
+fio --name=write_and_verify \
+    --filename=/dev/ublkb0 \
+    --ioengine=libaio --iodepth=4 \
+    --rw=write \
+    --size=256M \
+    --direct=1 \
+    --verify=crc32c \
+    --do_verify=1 \
+    --bs=4k > /dev/null 2>&1
+ERR_CODE=$?
+
+# cleanup & unregister and unpin the bpf prog
+_cleanup_bpf_test "loop"
+
+_remove_backfile $backfile_0
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_loop_02.sh b/tools/testing/selftests/ublk/test_loop_02.sh
new file mode 100755
index 000000000000..05c3a863f517
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_loop_02.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+
+. test_common.sh
+
+TID="loop_02"
+ERR_CODE=0
+
+# prepare & register and pin bpf prog
+_prep_bpf_test "loop" ublk_loop.bpf.o
+
+backfile_0=`_create_backfile 256M`
+
+# add two ublk null disks with the pinned bpf prog
+_add_ublk_dev -t loop -n 0 --bpf_prog 16 --bpf_aio_prog 16 --quiet $backfile_0
+
+_mkfs_mount_test /dev/ublkb0
+ERR_CODE=$?
+
+# cleanup & unregister and unpin the bpf prog
+_cleanup_bpf_test "loop"
+
+_remove_backfile $backfile_0
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/ublk_bpf.c b/tools/testing/selftests/ublk/ublk_bpf.c
index e2c2e92268e1..c24d5e18a1b1 100644
--- a/tools/testing/selftests/ublk/ublk_bpf.c
+++ b/tools/testing/selftests/ublk/ublk_bpf.c
@@ -64,6 +64,7 @@ struct dev_ctx {
 	int nr_files;
 	char *files[MAX_BACK_FILES];
 	int bpf_prog_id;
+	int bpf_aio_prog_id;
 	unsigned int	logging:1;
 	unsigned int	all:1;
 };
@@ -107,7 +108,10 @@ struct ublk_tgt {
 	unsigned int  cq_depth;
 	const struct ublk_tgt_ops *ops;
 	struct ublk_params params;
-	char backing_file[1024 - 8 - sizeof(struct ublk_params)];
+
+	int nr_backing_files;
+	unsigned long backing_file_size[MAX_BACK_FILES];
+	char backing_file[MAX_BACK_FILES][PATH_MAX];
 };
 
 struct ublk_queue {
@@ -133,12 +137,13 @@ struct ublk_dev {
 	struct ublksrv_ctrl_dev_info  dev_info;
 	struct ublk_queue q[UBLK_MAX_QUEUES];
 
-	int fds[2];	/* fds[0] points to /dev/ublkcN */
+	int fds[MAX_BACK_FILES + 1];	/* fds[0] points to /dev/ublkcN */
 	int nr_fds;
 	int ctrl_fd;
 	struct io_uring ring;
 
 	int bpf_prog_id;
+	int bpf_aio_prog_id;
 };
 
 #ifndef offsetof
@@ -983,7 +988,7 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 	struct ublk_dev *dev;
 	int dev_id = ctx->dev_id;
 	char ublkb[64];
-	int ret;
+	int ret, i;
 
 	ops = ublk_find_tgt(tgt_type);
 	if (!ops) {
@@ -1022,6 +1027,13 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 	dev->tgt.sq_depth = depth;
 	dev->tgt.cq_depth = depth;
 	dev->bpf_prog_id = ctx->bpf_prog_id;
+	dev->bpf_aio_prog_id = ctx->bpf_aio_prog_id;
+	for (i = 0; i < MAX_BACK_FILES; i++) {
+		if (ctx->files[i]) {
+			strcpy(dev->tgt.backing_file[i], ctx->files[i]);
+			dev->tgt.nr_backing_files++;
+		}
+	}
 
 	ret = ublk_ctrl_add_dev(dev);
 	if (ret < 0) {
@@ -1271,14 +1283,14 @@ static int cmd_dev_reg_bpf(struct dev_ctx *ctx)
 
 static int cmd_dev_help(char *exe)
 {
-	printf("%s add -t [null] [-q nr_queues] [-d depth] [-n dev_id] [--bpf_prog ublk_prog_id] [backfile1] [backfile2] ...\n", exe);
+	printf("%s add -t [null|loop] [-q nr_queues] [-d depth] [-n dev_id] [--bpf_prog ublk_prog_id] [--bpf_aio_prog ublk_aio_prog_id] [backfile1] [backfile2] ...\n", exe);
 	printf("\t default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)\n");
 	printf("%s del [-n dev_id] -a \n", exe);
 	printf("\t -a delete all devices -n delete specified device\n");
 	printf("%s list [-n dev_id] -a \n", exe);
 	printf("\t -a list all devices, -n list specified device, default -a \n");
-	printf("%s reg -t [null] bpf_prog_obj_path \n", exe);
-	printf("%s unreg -t [null]\n", exe);
+	printf("%s reg -t [null|loop] bpf_prog_obj_path \n", exe);
+	printf("%s unreg -t [null|loop]\n", exe);
 	return 0;
 }
 
@@ -1356,12 +1368,125 @@ static int ublk_null_queue_io(struct ublk_queue *q, int tag)
 	return 0;
 }
 
+static void backing_file_tgt_deinit(struct ublk_dev *dev)
+{
+	int i;
+
+	for (i = 1; i < dev->nr_fds; i++) {
+		fsync(dev->fds[i]);
+		close(dev->fds[i]);
+	}
+}
+
+static int backing_file_tgt_init(struct ublk_dev *dev)
+{
+	int fd, i;
+
+	assert(dev->nr_fds == 1);
+
+	for (i = 0; i < dev->tgt.nr_backing_files; i++) {
+		char *file = dev->tgt.backing_file[i];
+		unsigned long bytes;
+		struct stat st;
+
+		ublk_dbg(UBLK_DBG_DEV, "%s: file %d: %s\n", __func__, i, file);
+
+		fd = open(file, O_RDWR | O_DIRECT);
+		if (fd < 0) {
+			ublk_err("%s: backing file %s can't be opened: %s\n",
+					__func__, file, strerror(errno));
+			return -EBADF;
+		}
+
+		if (fstat(fd, &st) < 0) {
+			close(fd);
+			return -EBADF;
+		}
+
+		if (S_ISREG(st.st_mode))
+			bytes = st.st_size;
+		else if (S_ISBLK(st.st_mode)) {
+			if (ioctl(fd, BLKGETSIZE64, &bytes) != 0)
+				return -1;
+		} else {
+			return -EINVAL;
+		}
+
+		dev->tgt.backing_file_size[i] = bytes;
+		dev->fds[dev->nr_fds] = fd;
+		dev->nr_fds += 1;
+	}
+
+	return 0;
+}
+
+static int loop_bpf_setup_fd(unsigned dev_id, int fd)
+{
+	int map_fd;
+	int err;
+
+	map_fd = bpf_obj_get("/sys/fs/bpf/ublk/loop/fd_map");
+	if (map_fd < 0) {
+		ublk_err("Error getting map file descriptor from pinned map\n");
+		return -EINVAL;
+	}
+
+	err = bpf_map_update_elem(map_fd, &dev_id, &fd, BPF_ANY);
+	if (err) {
+		ublk_err("Error updating map element: %d\n", errno);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ublk_loop_tgt_init(struct ublk_dev *dev)
+{
+	unsigned long long bytes;
+	int ret;
+	struct ublk_params p = {
+		.types = UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_BPF,
+		.basic = {
+			.logical_bs_shift	= 9,
+			.physical_bs_shift	= 12,
+			.io_opt_shift	= 12,
+			.io_min_shift	= 9,
+			.max_sectors = dev->dev_info.max_io_buf_bytes >> 9,
+		},
+		.bpf = {
+			.flags = UBLK_BPF_HAS_OPS_ID | UBLK_BPF_HAS_AIO_OPS_ID,
+			.ops_id = dev->bpf_prog_id,
+			.aio_ops_id = dev->bpf_aio_prog_id,
+		},
+	};
+
+	assert(dev->tgt.nr_backing_files == 1);
+	ret = backing_file_tgt_init(dev);
+	if (ret)
+		return ret;
+
+	assert(loop_bpf_setup_fd(dev->dev_info.dev_id, dev->fds[1]) == 0);
+
+	bytes = dev->tgt.backing_file_size[0];
+	dev->tgt.dev_size = bytes;
+	p.basic.dev_sectors = bytes >> 9;
+	dev->tgt.params = p;
+
+	return 0;
+}
+
+
 static const struct ublk_tgt_ops tgt_ops_list[] = {
 	{
 		.name = "null",
 		.init_tgt = ublk_null_tgt_init,
 		.queue_io = ublk_null_queue_io,
 	},
+	{
+		.name = "loop",
+		.init_tgt = ublk_loop_tgt_init,
+		.deinit_tgt = backing_file_tgt_deinit,
+	},
 };
 
 static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
@@ -1389,6 +1514,7 @@ int main(int argc, char *argv[])
 		{ "debug_mask",		1,	NULL,  0  },
 		{ "quiet",		0,	NULL,  0  },
 		{ "bpf_prog",		1,	NULL,  0  },
+		{ "bpf_aio_prog",	1,	NULL,  0  },
 		{ 0, 0, 0, 0 }
 	};
 	int option_idx, opt;
@@ -1398,6 +1524,7 @@ int main(int argc, char *argv[])
 		.nr_hw_queues	=	2,
 		.dev_id		=	-1,
 		.bpf_prog_id	=	-1,
+		.bpf_aio_prog_id	=	-1,
 	};
 	int ret = -EINVAL, i;
 
@@ -1433,6 +1560,8 @@ int main(int argc, char *argv[])
 				ctx.bpf_prog_id = strtol(optarg, NULL, 10);
 				ctx.flags |= UBLK_F_BPF;
 			}
+			if (!strcmp(longopts[option_idx].name, "bpf_aio_prog"))
+				ctx.bpf_aio_prog_id = strtol(optarg, NULL, 10);
 			break;
 		}
 	}
-- 
2.47.0


