Return-Path: <bpf+bounces-40272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55407984C8C
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 23:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7757E1C20B68
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 21:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BB013CFA5;
	Tue, 24 Sep 2024 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFYIuX5d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FC13B5B4
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212146; cv=none; b=XlKnjHnaTlHfkiWGuzr5/x8sl2+232h9+hsx7nj1KTuK+VqX/zdgkkpfuG5hDe9e3t4DLAKjlhINr6NZb0z+H89+uoFsc9AQHJ+popeRZUgXS6J1lzojjrMZWdZLxIk1vAcxqihgpVMCGxSiatDP8jWz2XzKrnYdy1MjipyGeMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212146; c=relaxed/simple;
	bh=uQY69AN8q+sEP73JsOur8VycktqJEzb4LLI0FBG9vvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5W5qoTTB042Tm6wo+sGgnfuVCREm274wvy6pmh+WQm9duxu2tEaXARuOGRKiNqfj28FZJKXWKs4t9iN13ZyXY7yZc6pwS28GJ4Qi7HPGm+N0DYDy2tYQnfvdGyAMSBsZtK9DOZlwIRx5t8tkofiwB/yh644uQv8KFHOA+pNF1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFYIuX5d; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718f4fd89e5so5081105b3a.0
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727212143; x=1727816943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYjUmC5BvzuaA2QRQKI2p9C62dv0nKyrVH5j7EwR20o=;
        b=VFYIuX5dVBmvCF7/YQJvii7vXDGg+3ckJjint2zstVwI8bfNGn1BHjVGxIuBE8fVBe
         GrHrH1sGFAwiqLlDqfA3ewRlFwg8CrE/dC1V1bRVhLTOhBy3YjQ3F2koWzYASSnMcw8c
         wDnGE5kmF0MUx1Abr2BtkPTyxsaR+uHlbLdAO8Fi6djeZpPYj8IEpiR1sp02AvvCjJ9W
         AqMXDTst2gP3CAETMy8iyL+ZDulgfGLo8Zrwyp8JITy4gtHxke7MQbEFynWJLn2zIDU7
         68XnIsjzQFShpPkTywZWFo25Lhi1BYlyBcPwGz+KFKpfrj/uQ0yD1oONIYVEd2/ttYB/
         UUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212143; x=1727816943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYjUmC5BvzuaA2QRQKI2p9C62dv0nKyrVH5j7EwR20o=;
        b=D/RETKMdQ6L7wFc5o9qjBQSn9/p7Q9pBed8V0GitkhtxOa8aUastqUOe8UMddkydry
         ywWdc4hNwiEGGLKKcS7FmcsJs3GndKJwwpt1RTEwHqRABo0upScvR2hu5JDl+B6TkJco
         ThOthcKiMIRenTBAIci1ghOWtt7C2fqT/pqlkvuGM7NIoH9y7/7biQmrI20WBnP6apOw
         8bgA3OKka3NbzrpahUdIgPhUPC2dCyCRwSHtOws7gyqrCOgPlbQnzltDWNT4t4JAegsN
         DpK7aB0qBRtiGPA6xp0txik32J3HywNumkCrONmkuHK0npQP9XeQq/d1TR6SIpnTwu0/
         EZ9Q==
X-Gm-Message-State: AOJu0YxbW2B/gvwOXQdfBCAypOqNTiunQtXYrbsKvvhbh2xVuHAkK8xD
	oN9rAq/TNzacC2qqMslofhTN6FRLHAa8pY3+IKlncYLe3wAbeix0LnHn4kLL
X-Google-Smtp-Source: AGHT+IHXzjI95jIME7sD8ylJEzTpqTAAsoXmBdCm8zIlmRzQlncNFezhTNw6UeDdB1b3tkIE6o6N1A==
X-Received: by 2002:a05:6a00:170d:b0:70d:33b3:2d7f with SMTP id d2e1a72fcca58-71b0acb62f7mr751427b3a.26.1727212143364;
        Tue, 24 Sep 2024 14:09:03 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc846dbfsm1567628b3a.80.2024.09.24.14.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 14:09:02 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v1 2/2] selftests/bpf: verify that sync_linked_regs preserves subreg_def
Date: Tue, 24 Sep 2024 14:08:44 -0700
Message-ID: <20240924210844.1758441-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240924210844.1758441-1-eddyz87@gmail.com>
References: <20240924210844.1758441-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test was added because of a bug in verifier.c:sync_linked_regs(),
upon range propagation it destroyed subreg_def marks for registers.
The test is written in a way to return an upper half of a register
that is affected by range propagation and must have it's subreg_def
preserved. This gives a return value of 0 and leads to undefined
return value if subreg_def mark is not preserved.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 2ecf77b623e0..7c5e5e6d10eb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -760,4 +760,71 @@ __naked void two_old_ids_one_cur_id(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+/* Note the flag, see verifier.c:opt_subreg_zext_lo32_rnd_hi32() */
+__flag(BPF_F_TEST_RND_HI32)
+__success
+/* This test was added because of a bug in verifier.c:sync_linked_regs(),
+ * upon range propagation it destroyed subreg_def marks for registers.
+ * The subreg_def mark is used to decide whether zero extension instructions
+ * are needed when register is read. When BPF_F_TEST_RND_HI32 is set it
+ * also causes generation of statements to randomize upper halves of
+ * read registers.
+ *
+ * The test is written in a way to return an upper half of a register
+ * that is affected by range propagation and must have it's subreg_def
+ * preserved. This gives a return value of 0 and leads to undefined
+ * return value if subreg_def mark is not preserved.
+ */
+__retval(0)
+/* Check that verifier believes r1/r0 are zero at exit */
+__log_level(2)
+__msg("4: (77) r1 >>= 32                     ; R1_w=0")
+__msg("5: (bf) r0 = r1                       ; R0_w=0 R1_w=0")
+__msg("6: (95) exit")
+__msg("from 3 to 4")
+__msg("4: (77) r1 >>= 32                     ; R1_w=0")
+__msg("5: (bf) r0 = r1                       ; R0_w=0 R1_w=0")
+__msg("6: (95) exit")
+/* Verify that statements to randomize upper half of r1 had not been
+ * generated.
+ */
+__xlated("call unknown")
+__xlated("r0 &= 2147483647")
+__xlated("w1 = w0")
+/* This is how disasm.c prints BPF_ZEXT_REG at the moment, x86 and arm
+ * are the only CI archs that do not need zero extension for subregs.
+ */
+#if !defined(__TARGET_ARCH_x86) && !defined(__TARGET_ARCH_arm64)
+__xlated("w1 = w1")
+#endif
+__xlated("if w0 < 0xa goto pc+0")
+__xlated("r1 >>= 32")
+__xlated("r0 = r1")
+__xlated("exit")
+__naked void linked_regs_and_subreg_def(void)
+{
+	asm volatile (
+	"call %[bpf_ktime_get_ns];"
+	/* make sure r0 is in 32-bit range, otherwise w1 = w0 won't
+	 * assign same IDs to registers.
+	 */
+	"r0 &= 0x7fffffff;"
+	/* link w1 and w0 via ID */
+	"w1 = w0;"
+	/* 'if' statement propagates range info from w0 to w1,
+	 * but should not affect w1->subreg_def property.
+	 */
+	"if w0 < 10 goto +0;"
+	/* r1 is read here, on archs that require subreg zero
+	 * extension this would cause zext patch generation.
+	 */
+	"r1 >>= 32;"
+	"r0 = r1;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.46.0


