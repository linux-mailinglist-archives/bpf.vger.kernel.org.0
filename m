Return-Path: <bpf+bounces-28651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7618BC63F
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 05:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B531C2082D
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 03:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9BC4316B;
	Mon,  6 May 2024 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5h5So1B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B70842AB1
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714966530; cv=none; b=h2Zg1ZG60z8SPenKtw+ERwC9nVN5o6yUU02BLuNJXlZ2M7MnWjasmRaa0LSfpfx2svPiJ7JCXjnzGtB4JwjZ460xsn1BSeWJQ9wDz/u1aOJUCrqaJOWv3GvRM1qFZMPMREYa1pTGq2aJUyd2h8ZwtoM3mv9BpBI6gRmiMnoHVtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714966530; c=relaxed/simple;
	bh=cJQSKVREEGBzqn0kfSjFC1WsXamdAymuXVpbIsB/juw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z0RnMjvXsK4ly3DQzk0CYA1eEwqyu5DDvIQI8nTV5qV5dxulGuJaX0IPDt8Phhb+Gnhr0TUq8CCUwNbCVzTIf8nWX9/c56/DqN2uUuYUAk8OebddNx2W9AOtnKAMyrgIcDjWJoqjRUVOykYU5uZMakem0QQnN7tz2p90M7Gtths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5h5So1B; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f05c253669so224796a34.2
        for <bpf@vger.kernel.org>; Sun, 05 May 2024 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714966527; x=1715571327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjUPPgHKdKYsIH5Ik1GIm4wNBzLe/gilY+fLZ8Kem+A=;
        b=A5h5So1BrqqSWt45v6hTOR2oAzn+7h5SbojmQw2Bos7HDTqGFMYooFE0w9G69m0NcJ
         PaH/gDceQJQpqG1AMva0f+3kNzcMCZzh+hGRdgR3c92z3n96CITjP+wwBNgEsKPNtJoB
         wqxQ9w/k1BgNnxJODK3YsADiZNB7EfsvjnERdjw2SPmhyp/aCrAYatDEtirY0WM1a10p
         j2IQghI3s+tFDEaQ7LiXE7CnMwAj/q4/AsR84hMHeiNNN2t5SVPDNNvAxsBifpc8bhpH
         JYfGAeeX/sYGdqxcGG++Rf9oGunzG/sulTCO/qYe1H58SqQ42AT+dMKAd5A6nCe8+028
         nO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714966527; x=1715571327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjUPPgHKdKYsIH5Ik1GIm4wNBzLe/gilY+fLZ8Kem+A=;
        b=AYs9qh1wTXERGDJr/brprS/YKAxv0gAg+h6+q4xGM8Q2mobcAVFPhCtsI/2dFk91N2
         brYFPDuVC5TxzjjeK0ouFY94VMm5Ptxgq4/LlUXKcd5fQtj0FnHaAnCt/vs9w314/D4D
         nDupRmxK4SCKtbe8UTkST2avMARGWZCkQjgtZWDbJ25UG3lT7cK1GuUywGirShGF1rhI
         PxCG959jvmmBmg68DCatvn0X1pCWpd682SZX55AblTchWOJ+mbHJei04syzeAaDIz9f0
         MIlZEQVSrfo2NBv1O2foiiFnhlM8i0YVe+TkOq+PWqsngpnzky9cHiFlsA4xLu+TdIkG
         Pbqw==
X-Gm-Message-State: AOJu0YyrIq4ZvSL1mTR6c/WkT73oHfH8coNpA/3+vphhskUMVdKJpp+b
	SH1FvwZIoOSv4wyyQHoYcRZg9eVf3taWwzOxHKQq6skX4mPhRi44
X-Google-Smtp-Source: AGHT+IE3HDOUBQ2Br+xdZ6gNxVi2NK7lStXRmMGIBHjgRYFFgWfUlBRaRQBmKrlWZ+wiWhlymJiiAg==
X-Received: by 2002:a05:6808:302:b0:3c9:6e96:88f9 with SMTP id i2-20020a056808030200b003c96e9688f9mr1604529oie.4.1714966527567;
        Sun, 05 May 2024 20:35:27 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.178])
        by smtp.gmail.com with ESMTPSA id g9-20020aa79dc9000000b006f33c0aee44sm6897539pfq.91.2024.05.05.20.35.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2024 20:35:27 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 bpf-next 2/2] selftests/bpf: Add selftest for bits iter
Date: Mon,  6 May 2024 11:33:53 +0800
Message-Id: <20240506033353.28505-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240506033353.28505-1-laoar.shao@gmail.com>
References: <20240506033353.28505-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases for the bits iter:
- positive case
  - bit mask smaller than 8 bytes
  - a typical case of having 8-byte bit mask
  - another typical case where bit mask is > 8 bytes
  - the index of set bit

- nagative cases
  - bpf_iter_bits_destroy() is required after calling
    bpf_iter_bits_new()
  - bpf_iter_bits_destroy() can only destroy an initialized iter
  - bpf_iter_bits_next() must use an initialized iter

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_bits_iter.c  | 160 ++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c4f9f306646e..7e04ecaaa20a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -84,6 +84,7 @@
 #include "verifier_xadd.skel.h"
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
+#include "verifier_bits_iter.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -198,6 +199,7 @@ void test_verifier_var_off(void)              { RUN(verifier_var_off); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
+void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
new file mode 100644
index 000000000000..2f7b62b25638
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign,
+		      u32 nr_bits) __ksym __weak;
+int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
+void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
+
+SEC("iter.s/cgroup")
+__description("bits iter without destroy")
+__failure __msg("Unreleased reference")
+int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits it;
+	struct task_struct *p;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 1;
+
+	bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
+
+	bpf_iter_bits_next(&it);
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__description("bits iter with uninitialized iter in ->next()")
+__failure __msg("expected an initialized iter_bits as arg #1")
+int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits *it = NULL;
+
+	bpf_iter_bits_next(it);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__description("bits iter with uninitialized iter in ->destroy()")
+__failure __msg("expected an initialized iter_bits as arg #1")
+int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits it = {};
+
+	bpf_iter_bits_destroy(&it);
+	return 0;
+}
+
+SEC("syscall")
+__description("bits copy 32")
+__success __retval(10)
+int bits_copy32(void)
+{
+	/* 21 bits:             --------------------- */
+	u32 data = 0b11111101111101111100001000100101U;
+	int nr = 0, offset = 0;
+	int *bit;
+
+#if defined(__TARGET_ARCH_s390)
+	offset = sizeof(u32) - (21 + 7) / 8;
+#endif
+	bpf_for_each(bits, bit, ((char *)&data) + offset, 21)
+		nr++;
+	return nr;
+}
+
+SEC("syscall")
+__description("bits copy 64")
+__success __retval(18)
+int bits_copy64(void)
+{
+	/* 34 bits:         ~-------- */
+	u64 data = 0xffffefdf0f0f0f0fUL;
+	int nr = 0, offset = 0;
+	int *bit;
+
+#if defined(__TARGET_ARCH_s390)
+	offset = sizeof(u64) - (34 + 7) / 8;
+#endif
+
+	bpf_for_each(bits, bit, ((char *)&data) + offset, 34)
+		nr++;
+	return nr;
+}
+
+SEC("syscall")
+__description("bits memalloc long-aligned")
+__success __retval(32) /* 16 * 2 */
+int bits_memalloc(void)
+{
+	char data[16];
+	int nr = 0;
+	int *bit;
+
+	__builtin_memset(&data, 0x48, sizeof(data));
+	bpf_for_each(bits, bit, &data, sizeof(data) * 8)
+		nr++;
+	return nr;
+}
+
+SEC("syscall")
+__description("bits memalloc non-long-aligned")
+__success __retval(85) /* 17 * 5*/
+int bits_memalloc_non_aligned(void)
+{
+	char data[17];
+	int nr = 0;
+	int *bit;
+
+	__builtin_memset(&data, 0x1f, sizeof(data));
+	bpf_for_each(bits, bit, &data, sizeof(data) * 8)
+		nr++;
+	return nr;
+}
+
+SEC("syscall")
+__description("bits memalloc non-aligned-bits")
+__success __retval(27) /* 8 * 3 + 3 */
+int bits_memalloc_non_aligned_bits(void)
+{
+	char data[16];
+	int nr = 0;
+	int *bit;
+
+	__builtin_memset(&data, 0x31, sizeof(data));
+	/* Different with all other bytes */
+	data[8] = 0xf7;
+
+	bpf_for_each(bits, bit, &data,  68)
+		nr++;
+	return nr;
+}
+
+
+SEC("syscall")
+__description("bit index")
+__success __retval(8)
+int bit_index(void)
+{
+	u64 data = 0x100;
+	int bit_idx = 0;
+	int *bit;
+
+	bpf_for_each(bits, bit, &data, 64) {
+		if (*bit == 0)
+			continue;
+		bit_idx = *bit;
+	}
+	return bit_idx;
+}
-- 
2.30.1 (Apple Git-130)


