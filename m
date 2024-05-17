Return-Path: <bpf+bounces-29903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E5E8C7FE8
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 04:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AB11F2260B
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 02:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92258828;
	Fri, 17 May 2024 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9zwSAXC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001E28E6
	for <bpf@vger.kernel.org>; Fri, 17 May 2024 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913069; cv=none; b=HXMPc/Yg8embjqxiKsB9mSBWaDSNEyLMUNTzNaGtOqXGQThEdIa70D9i9EvWz6bLTwCdD8Z8DfB1AQPSMcNY7l/DoJCn1lkmetZ5+CWvjyFM20G94/iWioT2spBMmYWdT5MnE0+fbTEYMndHGHGXjL+uAZ3xk4txiIJ6jLVycXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913069; c=relaxed/simple;
	bh=cH1HWM91qme/TAm3mxGXhxHU76/I5+XF8Jx3+X3KrdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jZX8U+oj2sdOfT6BLuLyecu6SjIIAuIOckxxMDsBZzQg8957/l4X+8EBA5bjettt4oFo65tj9/sS6L8aDcrZdBDwJBIhRcVC3cHK4Iymmv63o7OQvumW8Ac62KBp4kNVPcG90FZH8Pfc1Q0atLMjyARqqP/C9VuFKUK3AYWi3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9zwSAXC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so1204635ad.1
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 19:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715913067; x=1716517867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rizb7YdC00S/X0d/TiUaqgbIo7Eopz1oXUEqBGg6mL0=;
        b=E9zwSAXCq+7tdeaqr+nP3TWU0F7dmwBFDm9XoqqGs5MXlmZ1c280bfrw1gVjrcOpfb
         Asb6v3bUfbyRYwzXhGu955qY449kHxqnD55qShUBhjIAKARYFocSkkUKmTMHst0SU4OT
         4ao0ufpQV8t+hwm4wD0vLm/CpOFAXkqtKVLPtQa95hy0Abcp7CFgYdeF8HzLfn88mqw+
         fJXkgKzrNFSV8O5RMS//yY7cx/fb3F6ISP25w0sKhAPnxeXkToZeGyIedC4T1AICLOWm
         /e8IvY9mk4Tskb0g7jhBNUavQKNjXh3iahYPXI8269/cz3LqymAorUzIELMMgBpAI1gv
         jqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715913067; x=1716517867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rizb7YdC00S/X0d/TiUaqgbIo7Eopz1oXUEqBGg6mL0=;
        b=dLwvQzKClzRBRWy1HKUZ1mMBAOuG2f38QtYkNYpXawqJVtF1kKgyMs/mie4AdnC9Cs
         URnX3yffqwyY++bz/J1exAe0C8duGYp//GzbScydrFLmI4DKh8BmbKBHDoI//ZYtj7qb
         Jer6kE7Rxn4A1je1hOe6+b/5MMeP7jPkrp1r0pAkLKKiHuctMf2qThGn68dseETm1ltv
         7ovajfrccSm7CIGZXOnYduzILQhKPpRuqCEGH1EM305+JbjILeiPyWYpLaUr3u9J/UeB
         hH+SntNIrqv5aT0PLvLBYGboNDGEjASDwiNXko7bsAi1FW+KwaxEHFuwOJAT0PJ6Loyj
         govg==
X-Gm-Message-State: AOJu0YwhcpXGT0+lWVJmrvM7si0fhYJvUWYNUTSlS/Q773YRp2aS/eKB
	+J6tbR8VctGoD5knGgsb1heGoo9Rk4wytRXo8iHRdcDSmV9ADW2P
X-Google-Smtp-Source: AGHT+IH54xtRganVT4di/Tl4+a9U6dPfaWPHw7lDH83GEqbuM2GXVjcCRy8s25SSQqb1pUM6DSyNDQ==
X-Received: by 2002:a17:902:8492:b0:1e0:a3dd:82df with SMTP id d9443c01a7336-1ef43e23e64mr172936505ad.38.1715913067249;
        Thu, 16 May 2024 19:31:07 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f093824c4dsm41361395ad.282.2024.05.16.19.30.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2024 19:31:06 -0700 (PDT)
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
Subject: [PATCH v8 bpf-next 2/2] selftests/bpf: Add selftest for bits iter
Date: Fri, 17 May 2024 10:30:34 +0800
Message-Id: <20240517023034.48138-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240517023034.48138-1-laoar.shao@gmail.com>
References: <20240517023034.48138-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases for the bits iter:

- Positive cases
  - Bit mask representing a single word (8-byte unit)
  - Bit mask representing data spanning more than one word
  - The index of the set bit

- Nagative cases
  - bpf_iter_bits_destroy() is required after calling
    bpf_iter_bits_new()
  - bpf_iter_bits_destroy() can only destroy an initialized iter
  - bpf_iter_bits_next() must use an initialized iter
  - Bit mask representing zero words
  - Bit mask representing fewer words than expected
  - Case for ENOMEM
  - Case for NULL pointer

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_bits_iter.c  | 153 ++++++++++++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c60db8beeb73..8743340b5bf6 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -85,6 +85,7 @@
 #include "verifier_xadd.skel.h"
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
+#include "verifier_bits_iter.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -200,6 +201,7 @@ void test_verifier_var_off(void)              { RUN(verifier_var_off); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
+void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
new file mode 100644
index 000000000000..716113c2bce2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -0,0 +1,153 @@
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
+int bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign,
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
+	u64 data = 1;
+
+	bpf_iter_bits_new(&it, &data, 1);
+	bpf_iter_bits_next(&it);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__description("uninitialized iter in ->next()")
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
+__description("uninitialized iter in ->destroy()")
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
+__description("null pointer")
+__success __retval(0)
+int null_pointer(void)
+{
+	int nr = 0;
+	int *bit;
+
+	bpf_for_each(bits, bit, NULL, 1)
+		nr++;
+	return nr;
+}
+
+SEC("syscall")
+__description("bits copy")
+__success __retval(10)
+int bits_copy(void)
+{
+	u64 data = 0xf7310UL; /* 4 + 3 + 2 + 1 + 0*/
+	int nr = 0;
+	int *bit;
+
+	bpf_for_each(bits, bit, &data, 1)
+		nr++;
+	return nr;
+}
+
+SEC("syscall")
+__description("bits memalloc")
+__success __retval(64)
+int bits_memalloc(void)
+{
+	u64 data[2];
+	int nr = 0;
+	int *bit;
+
+	__builtin_memset(&data, 0xf0, sizeof(data)); /* 4 * 16 */
+	bpf_for_each(bits, bit, &data[0], sizeof(data) / sizeof(u64))
+		nr++;
+	return nr;
+}
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
+	bpf_for_each(bits, bit, &data, 1) {
+		if (*bit == 0)
+			continue;
+		bit_idx = *bit;
+	}
+	return bit_idx;
+}
+
+SEC("syscall")
+__description("bits nomem")
+__success __retval(0)
+int bits_nomem(void)
+{
+	u64 data[4];
+	int nr = 0;
+	int *bit;
+
+	__builtin_memset(&data, 0xff, sizeof(data));
+	bpf_for_each(bits, bit, &data[0], 513) /* Be greater than 512 */
+		nr++;
+	return nr;
+}
+
+SEC("syscall")
+__description("fewer words")
+__success __retval(1)
+int fewer_words(void)
+{
+	u64 data[2] = {0x1, 0xff};
+	int nr = 0;
+	int *bit;
+
+	bpf_for_each(bits, bit, &data[0], 1)
+		nr++;
+	return nr;
+}
+
+SEC("syscall")
+__description("zero words")
+__success __retval(0)
+int zero_words(void)
+{
+	u64 data[2] = {0x1, 0xff};
+	int nr = 0;
+	int *bit;
+
+	bpf_for_each(bits, bit, &data[0], 0)
+		nr++;
+	return nr;
+}
-- 
2.39.1


