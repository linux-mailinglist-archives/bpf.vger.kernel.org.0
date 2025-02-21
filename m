Return-Path: <bpf+bounces-52219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B36FA4027D
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 23:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DE917EBEB
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 22:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61620254AE4;
	Fri, 21 Feb 2025 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF85CbKM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13796253F3B
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176054; cv=none; b=spCpMXTyC0XiJtIweW1Tigeoxa3zTM56Qi6gylJ+neEb813/TbS3TDNqADIYnkafOJ0AgMOXBdiflxNrnrQkpYDtKaAJgHiD5PoqZwLogdEHWc0NUIYgXk8IX7GePAtamWhDr20M5HRGili9sb8jssUCypDJWh4czf3dWYYr6Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176054; c=relaxed/simple;
	bh=hkU94gsQL0oAgxYTfGzs7HNjfFoysGnBT8KjUdz4i2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iU8hflG2rtrsOIXR2znb6IsaI4hLhSHWEpe/JCTGKarTaqwWkFSos0IbEGY2Ers5zBMb6lU0oj991qX6iRVC630F2NO/JSquHU9RbLYmfdXQQUkuQWlHLP2Xf/rn4xWhqcIAkLT0FyMZJQ1FfFkP1Rs1bOr0eKpnlRPQhv/gGAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF85CbKM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso26401915e9.1
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 14:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740176051; x=1740780851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FjE5DQWY/2WNS7aNEg53sV/Q9GrD/0CuPnveAlPfNo=;
        b=LF85CbKMVxSIgpPcqzXlWfPDO0EzKTF1PNxzhWxQ2P4TwQXsoLNh9zsmSVtIWY2trM
         rvFO2l9jzBMqpF1h4CeNTustxf8kur/Nqs49VVuxvTwmTDXlElGrx/YnFsR8ofxrwT0Z
         eYCcQ0/UiCQEB0Mvlm5z8X+8uKJliraSTMZXY9CuETY2oTBVd47ozcOB+woUOcaAINsi
         Ws/6WhvUl/ltcfIzKHrpnHLDG1P/IwZF4bNdROaT1FDf8nFj3qqh/vdVEuTR+at2G0u3
         Nbnlm1SaPWbPJLj09XxFUP4o0Zt5C1jIA0ARvYzrwrifMvBgb7dJRV3CBQWSjTgSoHoE
         saog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740176051; x=1740780851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FjE5DQWY/2WNS7aNEg53sV/Q9GrD/0CuPnveAlPfNo=;
        b=ff5VhcuEa+RJwbQWSVI0JTnqlyBL0ilL4hj1K2/zLDwnOtnVTkUUQH2+lrkiK5D+8J
         BLkFekRg+psZ93mlpcOdTjUGnrz9jbyzlxPHunyjvFeQhCqFh5S/Ei1XVOiBLKgto8b9
         r1HgDQRpcDnFhEaShOYlyuKB3Dxwb8ip8I36satYWqJsx2ktB3BaO0z8D1G7Z3jSRuh3
         e0bL+dF/rl5XkKQtXjfHgmwOYdpZdMMojUQZJhpFuYrcJQqxOQW8dvNuyJONGnRnyGFy
         mGLX9DbeEIwlVRgAFZGIlc3r9seG/U5swPRhf8J+yOQuqyP/iR0EZlzgymYyVAtKZjT8
         TPmA==
X-Gm-Message-State: AOJu0YzBEVsJY6jLNzgvQNja7z0yYqRs1y+zUtO7BE2rDDEGqfDENSBb
	kqa+MTYw50swg5uBICc1wBzz84ZzPHcIDe+95v3aC07uXcc4Um9aKEOh2g==
X-Gm-Gg: ASbGncvgANp9rGq6P7w+K5DBe3HxIqpNWhDelOeaGP9C5bpwCSzFPZ/lK81U8b0S1Wb
	bi90RWWV6KHALzdYankvXnmZetjazPbIAci7+VqiGDTB51MGtdnwZLx11VDyMxwUON78JKskXyL
	MxiQMh016EUqPFtgtbgxkDTKNFud7R9EO3nWd08241700AwwUspvtUaMa/Ovk6Z8Kt9NpeCwJgo
	An2a/CHswVwJBu3Vvy8Gk2DQidXhwmgdvyvXpcDct8YblVJUTgTfeWOgltWESybG6KkcyxJmmGE
	cFQ6MFPcVjkpWoHThbOFco9BfcDq4wezwPfAILD0KjSI/7rDsr3uYtnMQsU1ENPt4AmX9oBMylm
	gyRSU/S1GNc8T/mDKRT3fqf6RCQ/CdmY=
X-Google-Smtp-Source: AGHT+IH+EzmaEK7VTJQYS5AM1X2VFsNqywHThc026sDcBDxzo/5tIcyOU1YLIjlC0Ke/R1pWAmCAOQ==
X-Received: by 2002:a05:6000:885:b0:38c:3f12:64be with SMTP id ffacd0b85a97d-38f6f096fe5mr4552054f8f.35.1740176051104;
        Fri, 21 Feb 2025 14:14:11 -0800 (PST)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm24070707f8f.86.2025.02.21.14.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 14:14:10 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: add tests for bpf_dynptr_copy
Date: Fri, 21 Feb 2025 22:14:00 +0000
Message-ID: <20250221221400.672980-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221221400.672980-1-mykyta.yatsenko5@gmail.com>
References: <20250221221400.672980-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add XDP setup type for dynptr tests, enabling testing for
non-contiguous buffer.
Add 2 tests:
 - test_dynptr_copy - verify correctness for the fast (contiguous
 buffer) code path.
 - test_dynptr_copy_xdp - verifies code paths that handle
 non-contiguous buffer.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  21 ++++
 .../selftests/bpf/progs/dynptr_success.c      | 112 +++++++++++++++++-
 2 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index b614a5272dfd..e29cc16124c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -10,6 +10,7 @@ enum test_setup_type {
 	SETUP_SYSCALL_SLEEP,
 	SETUP_SKB_PROG,
 	SETUP_SKB_PROG_TP,
+	SETUP_XDP_PROG,
 };
 
 static struct {
@@ -18,6 +19,8 @@ static struct {
 } success_tests[] = {
 	{"test_read_write", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_data", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_copy", SETUP_SYSCALL_SLEEP},
+	{"test_dynptr_copy_xdp", SETUP_XDP_PROG},
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
@@ -120,6 +123,24 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 
 		break;
 	}
+	case SETUP_XDP_PROG:
+	{
+		char data[5000];
+		int err, prog_fd;
+		LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .data_in = &data,
+			    .data_size_in = sizeof(data),
+			    .repeat = 1,
+		);
+
+		prog_fd = bpf_program__fd(prog);
+		err = bpf_prog_test_run_opts(prog_fd, &opts);
+
+		if (!ASSERT_OK(err, "test_run"))
+			goto cleanup;
+
+		break;
+	}
 	}
 
 	ASSERT_EQ(skel->bss->err, 0, "err");
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index bfcc85686cf0..dd10411d1c02 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -1,20 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Facebook */
 
+#include <vmlinux.h>
 #include <string.h>
 #include <stdbool.h>
-#include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
-#include "bpf_kfuncs.h"
 #include "errno.h"
 
 char _license[] SEC("license") = "GPL";
 
 int pid, err, val;
 
-struct sample {
+struct ringbuf_sample {
 	int pid;
 	int seq;
 	long value;
@@ -121,7 +120,7 @@ int test_dynptr_data(void *ctx)
 
 static int ringbuf_callback(__u32 index, void *data)
 {
-	struct sample *sample;
+	struct ringbuf_sample *sample;
 
 	struct bpf_dynptr *ptr = (struct bpf_dynptr *)data;
 
@@ -138,7 +137,7 @@ SEC("?tp/syscalls/sys_enter_nanosleep")
 int test_ringbuf(void *ctx)
 {
 	struct bpf_dynptr ptr;
-	struct sample *sample;
+	struct ringbuf_sample *sample;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
 		return 0;
@@ -567,3 +566,106 @@ int BPF_PROG(test_dynptr_skb_tp_btf, void *skb, void *location)
 
 	return 1;
 }
+
+SEC("?tp/syscalls/sys_enter_nanosleep")
+int test_dynptr_copy(void *ctx)
+{
+	char data[] = "hello there, world!!";
+	char buf[32] = {'\0'};
+	__u32 sz = sizeof(data);
+	struct bpf_dynptr src, dst;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sz, 0, &src);
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sz, 0, &dst);
+
+	/* Test basic case of copying contiguous memory backed dynptrs */
+	err = bpf_dynptr_write(&src, 0, data, sz, 0);
+	err = err ?: bpf_dynptr_copy(&dst, 0, &src, 0, sz);
+	err = err ?: bpf_dynptr_read(buf, sz, &dst, 0, 0);
+	err = err ?: __builtin_memcmp(data, buf, sz);
+
+	/* Test that offsets are handled correctly */
+	err = err ?: bpf_dynptr_copy(&dst, 3, &src, 5, sz - 5);
+	err = err ?: bpf_dynptr_read(buf, sz - 5, &dst, 3, 0);
+	err = err ?: __builtin_memcmp(data + 5, buf, sz - 5);
+
+	bpf_ringbuf_discard_dynptr(&src, 0);
+	bpf_ringbuf_discard_dynptr(&dst, 0);
+	return 0;
+}
+
+SEC("xdp")
+int test_dynptr_copy_xdp(struct xdp_md *xdp)
+{
+	struct bpf_dynptr ptr_buf, ptr_xdp;
+	char data[] = "qwertyuiopasdfghjkl";
+	char buf[32] = {'\0'};
+	__u32 len = sizeof(data);
+	int i, chunks = 200;
+
+	/* ptr_xdp is backed by non-contiguous memory */
+	bpf_dynptr_from_xdp(xdp, 0, &ptr_xdp);
+	bpf_ringbuf_reserve_dynptr(&ringbuf, len * chunks, 0, &ptr_buf);
+
+	/* Destination dynptr is backed by non-contiguous memory */
+	bpf_for(i, 0, chunks) {
+		err = bpf_dynptr_write(&ptr_buf, i * len, data, len, 0);
+		if (err)
+			goto out;
+	}
+
+	err = bpf_dynptr_copy(&ptr_xdp, 0, &ptr_buf, 0, len * chunks);
+	if (err)
+		goto out;
+
+	bpf_for(i, 0, chunks) {
+		__builtin_memset(buf, 0, sizeof(buf));
+		err = bpf_dynptr_read(&buf, len, &ptr_xdp, i * len, 0);
+		if (err)
+			goto out;
+		if (__builtin_memcmp(data, buf, len) != 0)
+			goto out;
+	}
+
+	/* Source dynptr is backed by non-contiguous memory */
+	__builtin_memset(buf, 0, sizeof(buf));
+	bpf_for(i, 0, chunks) {
+		err = bpf_dynptr_write(&ptr_buf, i * len, buf, len, 0);
+		if (err)
+			goto out;
+	}
+
+	err = bpf_dynptr_copy(&ptr_buf, 0, &ptr_xdp, 0, len * chunks);
+	if (err)
+		goto out;
+
+	bpf_for(i, 0, chunks) {
+		__builtin_memset(buf, 0, sizeof(buf));
+		err = bpf_dynptr_read(&buf, len, &ptr_buf, i * len, 0);
+		if (err)
+			goto out;
+		if (__builtin_memcmp(data, buf, len) != 0)
+			goto out;
+	}
+
+	/* Both source and destination dynptrs are backed by non-contiguous memory */
+	err = bpf_dynptr_copy(&ptr_xdp, 2, &ptr_xdp, len, len * (chunks - 1));
+	if (err)
+		goto out;
+
+	bpf_for(i, 0, chunks - 1) {
+		__builtin_memset(buf, 0, sizeof(buf));
+		err = bpf_dynptr_read(&buf, len, &ptr_xdp, 2 + i * len, 0);
+		if (err)
+			goto out;
+		if (__builtin_memcmp(data, buf, len) != 0)
+			goto out;
+	}
+
+	if (bpf_dynptr_copy(&ptr_xdp, 2000, &ptr_xdp, 0, len * chunks) != -E2BIG)
+		err = 1;
+
+out:
+	bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
+	return XDP_DROP;
+}
-- 
2.48.1


