Return-Path: <bpf+bounces-48088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6EDA03EC4
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57243163EEC
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1D71EE7D3;
	Tue,  7 Jan 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuijT5Qc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341BE1EE7C6;
	Tue,  7 Jan 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251796; cv=none; b=Wfo03m9hqv64xAcy1dI4dg+2Jmq/DXd0KRN8R8jvgM8GAKRHQCuZP0PCt4LCtfptYBRIHWI6LOleUkEtBRHJHdP5hDx/PP2gUrYS89dUfO4azYwPxwCw0ssnH0TqT5TGGpKlvt7YvtAXbqloHe3JOKjzZk73ErAQs6V8UfYkMf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251796; c=relaxed/simple;
	bh=0z1zGJsu3WN74tcxO3hAJKjwCJ3Cp5632Mlb8ahdQXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZraiM++qQ9vxUtms0tCwO5ODeuG4UeR7d2INnZpzrb7cLA3c64pXVKZ3sPTkiiz1KFr/6owKS578tSs1Wpzfaqf2hNHttWdJhWemydQScfZy0UMudGX5Sj9OeJ5Q2gHh1RYA/Au6RbJReqzzv3jxO7Cre58zGHWXZbKxXnNNgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuijT5Qc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166651f752so29428145ad.3;
        Tue, 07 Jan 2025 04:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251742; x=1736856542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9huKsVEbf1v8YAcptwSkkhP1blRdS46Sxfnig2SU0AQ=;
        b=AuijT5Qc9TRDsZ+w4WQcQgDUMUX8paPBGVV1VKI7RX+7DQAwghytFnVEhbHuHdavT2
         vbVFjkXlDyuD5UmW52kwomacyH19oThrmzS5MlWtJnZdxmUmYz8gql5hIDHJgf4SSWDY
         B4csB7u6TsGZbDYMicU8E557cTMvcQrlsuuigfYraqUf0+L8TFAjvVe3pVnUsGjBtIMv
         PmfsPNZm6z3dHI+Glmfq96Wtg+VmgDEQMBur+29k/sxx9jXQvSmLgwV9jlFufAP3MbBs
         vhbDvsp0qmRI+/JxmtmX1QUK7g+lrkhytBjNaM3it90+8N3V+5T3KrvY6X0F8dybki1l
         BnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251742; x=1736856542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9huKsVEbf1v8YAcptwSkkhP1blRdS46Sxfnig2SU0AQ=;
        b=eKmdDKKz/GLe/vlqkFw0kti75X613oQlyATxK91QMVr6cIFku+H9B75xNZS8uPKPAA
         4GALun9posrkYM/uRFsf4j6L3Ucgbx2UwucYAwvZhq6EecV/PlSR7zYoEbHT2SdfshS8
         46pDMc/e8LafQcx1lICb8oFK8hSDK3hDuHJHaV7zWYbWCIDyjgplx72g3dQ3k/3ATzpF
         3FomXfMf6jpzL2ZH7+OVNNn2vr48VI74wPCnfufqTYucwxVyGRUBIBH/1Cv25c0TuUix
         8pfNJQHZ1b4hOzPbVZktxeeziIwtccv53QZvRrHGsygCRQCtglvLOIgEcFN8V+VatIka
         kkiw==
X-Forwarded-Encrypted: i=1; AJvYcCV6NSxZhpmyWmeI9my/+HcRjZry4xb/4Oc5wOsk83sCrXlOsdOcxV74KsoFN2lF/DwYvJSsrkHDtj7HEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydPffWgZwVUle7yczKn0vKehrNancOwDxc94AnJfyFBoTiccH/
	kog9QATXaY1DoBQWt/rY9n+JK2eFve4QX9W0PTMG5WJmBBr6A2E6
X-Gm-Gg: ASbGnctO6Af/xYRJsk6sb7ANSxOwJD8672dZDZT7LM74Ca8v7UX4zmqY1Q/G8T0V6gn
	7tWaOBujUG7hyAiKywx8CqeT4fugbhrw8fG9aFsRBJwkpviQk/xElJYDRin5OnEo13X/XEmYhKP
	QaWZsSmtQeF1k0yoddyLa0XciARGvRveRtgiXxsUs3RsOpAzUwYWcsI+Egi0hnTAwFkzFiYB6km
	bC2as/rtknp0E5t7nVhD8t4kGZw8OU8wq/gU/Jo7GOgQNkCm0i+YwxMTf3vY/ZksLdw
X-Google-Smtp-Source: AGHT+IGvaP49H23xLy+bsto3vxdfgvz+Gvvf70cc/Eo51fyAsqd6bFhIe7C0yzv+9ObH3BhuUjMIsw==
X-Received: by 2002:a05:6a20:6a20:b0:1e0:d99f:7ad3 with SMTP id adf61e73a8af0-1e5e084b3f5mr95001497637.44.1736251741628;
        Tue, 07 Jan 2025 04:09:01 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:09:01 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 21/22] selftests: add tests for covering both bpf aio and split
Date: Tue,  7 Jan 2025 20:04:12 +0800
Message-ID: <20250107120417.1237392-22-tom.leiming@gmail.com>
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

Add ublk-stripe for covering both bpf aio and io split features.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 tools/testing/selftests/ublk/Makefile         |   3 +
 .../selftests/ublk/progs/ublk_stripe.c        | 319 ++++++++++++++++++
 .../testing/selftests/ublk/test_stripe_01.sh  |  35 ++
 .../testing/selftests/ublk/test_stripe_02.sh  |  26 ++
 tools/testing/selftests/ublk/ublk_bpf.c       |  88 ++++-
 5 files changed, 468 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/progs/ublk_stripe.c
 create mode 100755 tools/testing/selftests/ublk/test_stripe_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_stripe_02.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 2540ae7a75a3..7c30c5728694 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -27,6 +27,9 @@ TEST_PROGS += test_null_04.sh
 TEST_PROGS += test_loop_01.sh
 TEST_PROGS += test_loop_02.sh
 
+TEST_PROGS += test_stripe_01.sh
+TEST_PROGS += test_stripe_02.sh
+
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS_EXTENDED = ublk_bpf
 
diff --git a/tools/testing/selftests/ublk/progs/ublk_stripe.c b/tools/testing/selftests/ublk/progs/ublk_stripe.c
new file mode 100644
index 000000000000..98a59239047c
--- /dev/null
+++ b/tools/testing/selftests/ublk/progs/ublk_stripe.c
@@ -0,0 +1,319 @@
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
+struct ublk_stripe {
+#define MAX_BACKFILES	4
+	unsigned char chunk_shift;
+	unsigned char nr_backfiles;
+	int fds[MAX_BACKFILES];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 128);
+	__type(key, unsigned int);	/* dev id */
+	__type(value, struct ublk_stripe);	/* stripe setting */
+} stripe_map SEC(".maps");
+
+/* todo: make it writable payload of ublk_bpf_io */
+struct ublk_io_payload {
+	unsigned int ref;
+	int res;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 10240);
+	__type(key, unsigned long long);	/* dev_id + q_id + tag */
+	__type(value, struct ublk_io_payload);	/* io payload */
+} io_map SEC(".maps");
+
+static inline void dec_stripe_io_ref(const struct ublk_bpf_io *io, struct ublk_io_payload *pv, int ret)
+{
+	if (!pv)
+		return;
+
+	if (pv->res >= 0)
+		pv->res = ret;
+
+	if (!__sync_sub_and_fetch(&pv->ref, 1)) {
+		unsigned rw = (io->iod->op_flags & 0xff);
+
+		if (pv->res >= 0 && (rw <= 1))
+			pv->res = io->iod->nr_sectors << 9;
+		ublk_bpf_complete_io(io, pv->res);
+	}
+}
+
+static inline void ublk_stripe_comp_and_release_aio(struct bpf_aio *aio, int ret)
+{
+	struct ublk_bpf_io *io = ublk_bpf_acquire_io_from_aio(aio);
+	struct ublk_io_payload *pv = NULL;
+	unsigned long long io_key = build_io_key(io);
+
+	if (!io)
+		return;
+
+	io_key = build_io_key(io);
+	pv = bpf_map_lookup_elem(&io_map, &io_key);
+
+	/* drop reference for each underlying aio */
+	dec_stripe_io_ref(io, pv, ret);
+	ublk_bpf_release_io_from_aio(io);
+
+	ublk_bpf_dettach_and_complete_aio(aio);
+	bpf_aio_release(aio);
+}
+
+SEC("struct_ops/bpf_aio_complete_cb")
+void BPF_PROG(ublk_stripe_comp_cb, struct bpf_aio *aio, long ret)
+{
+	BPF_DBG("aio result %d, back_file %s pos %llx", ret,
+			aio->iocb.ki_filp->f_path.dentry->d_name.name,
+			aio->iocb.ki_pos);
+	ublk_stripe_comp_and_release_aio(aio, ret);
+}
+
+SEC(".struct_ops.link")
+struct bpf_aio_complete_ops stripe_ublk_bpf_aio_ops = {
+	.id = 32,
+	.bpf_aio_complete_cb = (void *)ublk_stripe_comp_cb,
+};
+
+static inline int ublk_stripe_submit_backing_io(const struct ublk_bpf_io *io,
+		int backfile_fd, unsigned long backfile_off,
+		unsigned int backfile_bytes,
+		unsigned int buf_off)
+{
+	const struct ublksrv_io_desc *iod = io->iod;
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
+	res = ublk_bpf_attach_and_prep_aio(io, buf_off, backfile_bytes, aio);
+	if (res < 0) {
+		bpf_printk("bpf aio attaching failed %d\n", res);
+		goto fail;
+	}
+
+	/* submit this aio onto the backing file */
+	res = bpf_aio_submit(aio, backfile_fd, backfile_off, backfile_bytes, op_flags);
+	if (res < 0) {
+		bpf_printk("aio submit failed %d\n", res);
+		ublk_stripe_comp_and_release_aio(aio, res);
+	}
+	return 0;
+fail:
+	return res;
+}
+
+static int calculate_backfile_off_bytes(const struct ublk_stripe *stripe,
+		unsigned long stripe_off, unsigned int stripe_bytes,
+		unsigned long *backfile_off,
+		unsigned int *backfile_bytes)
+{
+	unsigned long chunk_size = 1U << stripe->chunk_shift;
+	unsigned int nr_bf = stripe->nr_backfiles;
+	unsigned long unit_chunk_size = nr_bf << stripe->chunk_shift;
+	unsigned long start_off = stripe_off & ~(chunk_size - 1);
+	unsigned long unit_start_off = stripe_off & ~(unit_chunk_size - 1);
+	unsigned int idx = (start_off - unit_start_off) >> stripe->chunk_shift;
+
+	*backfile_bytes = stripe_bytes;
+	*backfile_off = (unit_start_off / nr_bf)  + (idx << stripe->chunk_shift)  + (stripe_off - start_off);
+
+	return stripe->fds[idx % MAX_BACKFILES];
+}
+
+static unsigned int calculate_stripe_off_bytes(const struct ublk_stripe *stripe,
+		const struct ublksrv_io_desc *iod, unsigned int this_off,
+		unsigned long *stripe_off)
+{
+	unsigned long off, next_off;
+	unsigned int chunk_size = 1U << stripe->chunk_shift;
+	unsigned int max_size = (iod->nr_sectors << 9) - this_off;
+
+	off = (iod->start_sector << 9) + this_off;
+	next_off = (off & ~(chunk_size  - 1)) + chunk_size;;
+
+	*stripe_off = off;
+
+	if (max_size < next_off - off)
+		return max_size;
+	return next_off - off;
+}
+
+static inline ublk_bpf_return_t __ublk_stripe_handle_io_cmd(const struct ublk_bpf_io *io, unsigned int off)
+{
+	ublk_bpf_return_t ret = ublk_bpf_return_val(UBLK_BPF_IO_QUEUED, 0);
+	unsigned long stripe_off, backfile_off;
+	unsigned int stripe_bytes, backfile_bytes;
+	int dev_id = ublk_bpf_get_dev_id(io);
+	const struct ublksrv_io_desc *iod;
+	const struct ublk_stripe *stripe;
+	int res = -EINVAL;
+	int backfile_fd;
+	unsigned long long io_key = build_io_key(io);
+	struct ublk_io_payload pl = {
+		.ref = 2,
+		.res = 0,
+	};
+	struct ublk_io_payload *pv = NULL;
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
+	stripe = bpf_map_lookup_elem(&stripe_map, &dev_id);
+	if (!stripe) {
+		bpf_printk("can't get FD from %d\n", dev_id);
+		return ret;
+	}
+
+	/* todo: build as big chunk as possible for each underlying files/disks */
+	stripe_bytes = calculate_stripe_off_bytes(stripe, iod, off, &stripe_off);
+	backfile_fd = calculate_backfile_off_bytes(stripe, stripe_off, stripe_bytes,
+			&backfile_off, &backfile_bytes);
+	BPF_DBG("\t <chunk_shift %u files %u> stripe(%lx %lu) backfile(%d %lx %lu)",
+			stripe->chunk_shift, stripe->nr_backfiles,
+			stripe_off, stripe_bytes,
+			backfile_fd, backfile_off, backfile_bytes);
+
+	if (!stripe_bytes) {
+		bpf_printk("submit bpf aio failed %d\n", res);
+		res = -EINVAL;
+		goto exit;
+	}
+
+	/* grab one submission reference, and one extra for the whole batch */
+	if (!off) {
+		res = bpf_map_update_elem(&io_map, &io_key, &pl, BPF_ANY);
+		if (res) {
+			bpf_printk("update io map element failed %d key %llx\n", res, io_key);
+			goto exit;
+		}
+	} else {
+		pv = bpf_map_lookup_elem(&io_map, &io_key);
+		if (pv)
+			__sync_fetch_and_add(&pv->ref, 1);
+	}
+
+	/* handle this io command by submitting IOs on backing file */
+	res = ublk_stripe_submit_backing_io(io, backfile_fd, backfile_off, backfile_bytes, off);
+
+exit:
+	/* io cmd can't be completes until this reference is dropped */
+	if (res < 0) {
+		bpf_printk("submit bpf aio failed %d\n", res);
+		ublk_bpf_complete_io(io, res);
+		return ret;
+	}
+
+	/* drop the extra reference for the whole batch */
+	if (off + stripe_bytes == iod->nr_sectors << 9) {
+		if (!pv)
+			pv = bpf_map_lookup_elem(&io_map, &io_key);
+		dec_stripe_io_ref(io, pv, pv ? pv->res : 0);
+	}
+
+	return ublk_bpf_return_val(UBLK_BPF_IO_CONTINUE, stripe_bytes);
+}
+
+SEC("struct_ops/ublk_bpf_release_io_cmd")
+void BPF_PROG(ublk_stripe_release_io_cmd, struct ublk_bpf_io *io)
+{
+	BPF_DBG("%s: complete io command %d", __func__, io->res);
+}
+
+SEC("struct_ops.s/ublk_bpf_queue_io_cmd_daemon")
+ublk_bpf_return_t BPF_PROG(ublk_stripe_handle_io_cmd, struct ublk_bpf_io *io, unsigned int off)
+{
+	return __ublk_stripe_handle_io_cmd(io, off);
+}
+
+SEC("struct_ops/ublk_bpf_attach_dev")
+int BPF_PROG(ublk_stripe_attach_dev, int dev_id)
+{
+	const struct ublk_stripe *stripe;
+
+	/* retrieve backing file descriptor */
+	stripe = bpf_map_lookup_elem(&stripe_map, &dev_id);
+	if (!stripe) {
+		bpf_printk("can't get FD from %d\n", dev_id);
+		return -EINVAL;
+	}
+
+	if (stripe->nr_backfiles >= MAX_BACKFILES)
+		return -EINVAL;
+
+	if (stripe->chunk_shift < 12)
+		return -EINVAL;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct ublk_bpf_ops stripe_ublk_bpf_ops = {
+	.id = 32,
+	.attach_dev = (void *)ublk_stripe_attach_dev,
+	.queue_io_cmd_daemon = (void *)ublk_stripe_handle_io_cmd,
+	.release_io_cmd = (void *)ublk_stripe_release_io_cmd,
+};
+
+char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/ublk/test_stripe_01.sh b/tools/testing/selftests/ublk/test_stripe_01.sh
new file mode 100755
index 000000000000..3c21f7db495a
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stripe_01.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+
+. test_common.sh
+
+TID="stripe_01"
+ERR_CODE=0
+
+# prepare & register and pin bpf prog
+_prep_bpf_test "stripe" ublk_stripe.bpf.o
+
+backfile_0=`_create_backfile 256M`
+backfile_1=`_create_backfile 256M`
+
+# add two ublk null disks with the pinned bpf prog
+_add_ublk_dev -t stripe -n 0 --bpf_prog 32 --bpf_aio_prog 32 --quiet $backfile_0 $backfile_1
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
+_cleanup_bpf_test "stripe"
+
+_remove_backfile $backfile_0
+_remove_backfile $backfile_1
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stripe_02.sh b/tools/testing/selftests/ublk/test_stripe_02.sh
new file mode 100755
index 000000000000..fdbb81dc53d8
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stripe_02.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+. test_common.sh
+
+TID="stripe_02"
+ERR_CODE=0
+
+# prepare & register and pin bpf prog
+_prep_bpf_test "stripe" ublk_stripe.bpf.o
+
+backfile_0=`_create_backfile 256M`
+backfile_1=`_create_backfile 256M`
+
+# add two ublk null disks with the pinned bpf prog
+_add_ublk_dev -t stripe -n 0 --bpf_prog 32 --bpf_aio_prog 32 --quiet $backfile_0 $backfile_1
+
+_mkfs_mount_test /dev/ublkb0
+ERR_CODE=$?
+
+# cleanup & unregister and unpin the bpf prog
+_cleanup_bpf_test "stripe"
+
+_remove_backfile $backfile_0
+_remove_backfile $backfile_1
+
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/ublk_bpf.c b/tools/testing/selftests/ublk/ublk_bpf.c
index c24d5e18a1b1..85b2b4a09e05 100644
--- a/tools/testing/selftests/ublk/ublk_bpf.c
+++ b/tools/testing/selftests/ublk/ublk_bpf.c
@@ -1283,14 +1283,14 @@ static int cmd_dev_reg_bpf(struct dev_ctx *ctx)
 
 static int cmd_dev_help(char *exe)
 {
-	printf("%s add -t [null|loop] [-q nr_queues] [-d depth] [-n dev_id] [--bpf_prog ublk_prog_id] [--bpf_aio_prog ublk_aio_prog_id] [backfile1] [backfile2] ...\n", exe);
+	printf("%s add -t [null|loop|stripe] [-q nr_queues] [-d depth] [-n dev_id] [--bpf_prog ublk_prog_id] [--bpf_aio_prog ublk_aio_prog_id] [backfile1] [backfile2] ...\n", exe);
 	printf("\t default: nr_queues=2(max 4), depth=128(max 128), dev_id=-1(auto allocation)\n");
 	printf("%s del [-n dev_id] -a \n", exe);
 	printf("\t -a delete all devices -n delete specified device\n");
 	printf("%s list [-n dev_id] -a \n", exe);
 	printf("\t -a list all devices, -n list specified device, default -a \n");
-	printf("%s reg -t [null|loop] bpf_prog_obj_path \n", exe);
-	printf("%s unreg -t [null|loop]\n", exe);
+	printf("%s reg -t [null|loop|stripe] bpf_prog_obj_path \n", exe);
+	printf("%s unreg -t [null|loop|stripe]\n", exe);
 	return 0;
 }
 
@@ -1475,6 +1475,83 @@ static int ublk_loop_tgt_init(struct ublk_dev *dev)
 	return 0;
 }
 
+struct ublk_stripe_params {
+	unsigned char chunk_shift;
+	unsigned char nr_backfiles;
+	int fds[MAX_BACK_FILES];
+};
+
+static int stripe_bpf_setup_parameters(struct ublk_dev *dev, unsigned int chunk_shift)
+{
+	int dev_id = dev->dev_info.dev_id;
+	struct ublk_stripe_params stripe = {
+		.chunk_shift	=	chunk_shift,
+		.nr_backfiles	=	dev->nr_fds - 1,
+	};
+	int map_fd;
+	int err, i;
+
+	for (i = 0; i < stripe.nr_backfiles; i++)
+		stripe.fds[i] = dev->fds[i + 1];
+
+	map_fd = bpf_obj_get("/sys/fs/bpf/ublk/stripe/stripe_map");
+	if (map_fd < 0) {
+		ublk_err("Error getting map file descriptor\n");
+		return -EINVAL;
+	}
+
+	err = bpf_map_update_elem(map_fd, &dev_id, &stripe, BPF_ANY);
+	if (err) {
+		ublk_err("Error updating map element: %d\n", errno);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ublk_stripe_tgt_init(struct ublk_dev *dev)
+{
+	unsigned long long bytes = 0;
+	unsigned chunk_shift = 12;
+	int ret, i;
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
+	ret = backing_file_tgt_init(dev);
+	if (ret)
+		return ret;
+
+	assert(stripe_bpf_setup_parameters(dev, chunk_shift) == 0);
+
+	for (i = 0; i < dev->nr_fds - 1; i++) {
+		unsigned long size = dev->tgt.backing_file_size[i];
+
+		if (size != dev->tgt.backing_file_size[0])
+			return -EINVAL;
+		if (size & ((1 << chunk_shift) - 1))
+			return -EINVAL;
+		bytes += size;
+	}
+
+	dev->tgt.dev_size = bytes;
+	p.basic.dev_sectors = bytes >> 9;
+	dev->tgt.params = p;
+
+	return 0;
+}
 
 static const struct ublk_tgt_ops tgt_ops_list[] = {
 	{
@@ -1487,6 +1564,11 @@ static const struct ublk_tgt_ops tgt_ops_list[] = {
 		.init_tgt = ublk_loop_tgt_init,
 		.deinit_tgt = backing_file_tgt_deinit,
 	},
+	{
+		.name = "stripe",
+		.init_tgt = ublk_stripe_tgt_init,
+		.deinit_tgt = backing_file_tgt_deinit,
+	},
 };
 
 static const struct ublk_tgt_ops *ublk_find_tgt(const char *name)
-- 
2.47.0


