Return-Path: <bpf+bounces-68757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AD3B83D02
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D584D17B77F
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B912E4278;
	Thu, 18 Sep 2025 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EByClhII"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FC2DA746
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187968; cv=none; b=LfwFQ36paeHb0MqoMYa8ZhfmsjKXB1nk3A5Bpjl+dVxVseS74bBEmFGIa7pdnZ/PBGi0DAyqoZzG35ZkhyJ13u+znAgtPANY131Zq2OG+VFMrkhdi/DxwFE9BKz3zqBBToxjqvqzcn3vO8y60x4D9wmdPcAI2jPx/CQC0aqHqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187968; c=relaxed/simple;
	bh=l45/9EeDAZ9Gkm5gJgbZIUToBJbD/hPJkHCB6LgV3Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XuBPRtnz2DJkIZ0bdCa6lBUWj5gOqeGeXiXTEXNff4swW/IAEKrCtWac9FgbnWnp5sRUul/+G/OU4+v9SpTnHkkLdu2PH3vbVr7cRYsxiv84fHG3Ic2TVeRE5t3ZQJvoCHft0CzDelUoSXhVdboSIPdiLO0bJsw+t1FrtbZB3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EByClhII; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46130fc5326so4686215e9.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758187964; x=1758792764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0IpU8W2qRdZwBfmyMjSwRdVsHzO0hX0laffmfKzelw=;
        b=EByClhIIZGxpV2c233AJ/OeU423Zjjm3YFMgo8PaNwKUIQOFxpzOzGnKuSY1zf2YSg
         A7shxqOlZW4R9dVrCAFICREZWlZAZjEHAxYgXjQlA5pgRL2ca3DAwBwXthV6IklVaW4r
         NQPk3sx13FSUPWLghD3wDl384oTYv+MGxZ0m9Ioa3OxWdE0jpQKGVvUqX4ydUGgQhuxl
         yfN4Ebx/7YD6KnZ6etUOa0gqJqRc7o2aBXpGfV+Ru/NGOei1PpQooz1a0AkZUtGIX7CM
         b2tdotLeZ/mHl9jDeJQ2s0ETv6lUP5W3brz8nNWzIrxrj8zz2UXaLFo2ovcE3Us8hfBo
         Ld8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187964; x=1758792764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0IpU8W2qRdZwBfmyMjSwRdVsHzO0hX0laffmfKzelw=;
        b=J1LygGaGlF8TUGDl8W9dIhhrBHatpfBd2Gl3ytnCPiuUc6HdBWGy8JMzyhdZZv3zZ6
         2DYaVHg/+vEjlw6D+cL6SzXzlu12xcvk4IIR3uzROScs7Y0Q9BIJSW0zvdt7WT0DMJHO
         r/eIX+K8r1D7odg5pmeVvRuOsM3UZT3qENlXbsjT5CfKksN3oqI4LyAIKcMZL1bLQhgK
         GPDdp69BBGf6pqx/2Ng6NaVx/7UjSjqVqDfXkBb1UCKTb1NPdvho+DkoTEWNw+ab5uBa
         6IweRSCgPnCQVDoAOvCWeYoHrrWo3o3D9DSu4EFLWrwDIovkCyhH4uc//T+PQwafAbkW
         Q4cg==
X-Gm-Message-State: AOJu0YwfLTAsnYFvCAOi7HMq+8Eg5w4uph3KReqfK+I2DFRAiLRpicIQ
	Pfbs/9oZcyDg+PIvGedkKdcY6gY6FAZ8LvtJ/cDTzINuPnxCTJikPYZFW8SEBg==
X-Gm-Gg: ASbGncu7L1RLJkxx4A9lC9wK8nhw6tiWwL5JYKky8eAZkNPTuOCHmxIiI9xFNFFQLKG
	HD6IaFfFB0cOJYIrmX5Swx4dAjDN7g1sydOx7tLOM7g/F5F+6rOPW2U2v5JU4Xxra1GDHEkUst+
	RFMd9m4REdQOxcGlfPsHiJKCvMO1Jhetch/jZ4GatkgzVPA+EYOkUnXmml4vrLOkNxlZZMNddWG
	bdV4DP3iBM+dRXhNbDr4U+N7Uwiil2iqdlAVf36gnabovodQ13QopUWNj70HsqKdWuhXK/HHuZg
	9XCjAvCYJB1nY4g9RVhszsqqBt9Wr3xXeZjn0+m3cplVxb8i4u6xq59S7F0S/jweHmqt1CMjPVl
	VtuOWpvz2JoPtWQc41GXYd7HrYvrnwWbnCO7aIhiTkpZefcLIr2bV1ftejfjSGsshxla1Lak=
X-Google-Smtp-Source: AGHT+IECWCsgFD7tkBYqZAODX+QcTTm06dsVaN2+lig7/wEy4EwaEYekPc51xdHa00RA/WfrjbGI5w==
X-Received: by 2002:a05:600c:198f:b0:45f:28ba:e187 with SMTP id 5b1f17b1804b1-46205cc8628mr46717035e9.21.1758187964171;
        Thu, 18 Sep 2025 02:32:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf0a4fsm2775026f8f.52.2025.09.18.02.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:32:43 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v3 bpf-next 06/13] selftests/bpf: test instructions arrays with blinding
Date: Thu, 18 Sep 2025 09:38:43 +0000
Message-Id: <20250918093850.455051-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918093850.455051-1-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a specific test for instructions arrays with blinding enabled.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index f785132497d6..489badc17a2d 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -287,6 +287,95 @@ static void check_with_functions(void)
 	close(map_fd);
 }
 
+static int set_bpf_jit_harden(char *level)
+{
+	char old_level;
+	int err = -1;
+	int fd = -1;
+
+	fd = open("/proc/sys/net/core/bpf_jit_harden", O_RDWR | O_NONBLOCK);
+	if (fd < 0) {
+		ASSERT_FAIL("open .../bpf_jit_harden returned %d (errno=%d)", fd, errno);
+		return -1;
+	}
+
+	err = read(fd, &old_level, 1);
+	if (err != 1) {
+		ASSERT_FAIL("read from .../bpf_jit_harden returned %d (errno=%d)", err, errno);
+		err = -1;
+		goto end;
+	}
+
+	lseek(fd, 0, SEEK_SET);
+
+	err = write(fd, level, 1);
+	if (err != 1) {
+		ASSERT_FAIL("write to .../bpf_jit_harden returned %d (errno=%d)", err, errno);
+		err = -1;
+		goto end;
+	}
+
+	err = 0;
+	*level = old_level;
+end:
+	if (fd >= 0)
+		close(fd);
+	return err;
+}
+
+static void check_blindness(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 4),
+		BPF_MOV64_IMM(BPF_REG_0, 3),
+		BPF_MOV64_IMM(BPF_REG_0, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd = -1, map_fd;
+	struct bpf_insn_array_value val = {};
+	char bpf_jit_harden = '@'; /* non-exizsting value */
+	int i;
+
+	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, ARRAY_SIZE(insns));
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		val.xlated_off = i;
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	bpf_jit_harden = '2';
+	if (set_bpf_jit_harden(&bpf_jit_harden)) {
+		bpf_jit_harden = '@'; /* open, read or write failed => no write was done */
+		goto cleanup;
+	}
+
+	prog_fd = prog_load(insns, ARRAY_SIZE(insns), &map_fd, 1);
+	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++) {
+		char fmt[32];
+
+		if (!ASSERT_EQ(bpf_map_lookup_elem(map_fd, &i, &val), 0, "bpf_map_lookup_elem"))
+			goto cleanup;
+
+		snprintf(fmt, sizeof(fmt), "val should be equal 3*%d", i);
+		ASSERT_EQ(val.xlated_off, i * 3, fmt);
+	}
+
+cleanup:
+	/* restore the old one */
+	if (bpf_jit_harden != '@')
+		set_bpf_jit_harden(&bpf_jit_harden);
+
+	close(prog_fd);
+	close(map_fd);
+}
+
 /* Map can be used only by one BPF program */
 static void check_no_map_reuse(void)
 {
@@ -392,6 +481,9 @@ void test_bpf_insn_array(void)
 	if (test__start_subtest("multiple-functions"))
 		check_with_functions();
 
+	if (test__start_subtest("blindness"))
+		check_blindness();
+
 	/* Check all kinds of operations and related restrictions */
 
 	if (test__start_subtest("incorrect-index"))
-- 
2.34.1


