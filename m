Return-Path: <bpf+bounces-72261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D519AC0B11E
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72FDB4EB7E9
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190B92FE595;
	Sun, 26 Oct 2025 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIMRyoex"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA452877E7
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506445; cv=none; b=JzH1S/Rczx0KNj6I3eppoKe2AMj3hTAp3lruYSR7mCU8O5HC28drrZTSMlNa5LlgNH8eMdo6t8MzeW90CB3yKWSkaDnJBHx0iodlFV578hVMglv6uWR1aEUt9uVF7Ol93MwjF2lbbjdOmNAmX/NTEZ/4rFTGw49Gvkw6GYQrj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506445; c=relaxed/simple;
	bh=/R779rxMpaEFZpDO2t/0BGq9G02XmMFolHpjZXhB0lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kT4ZEu3Mrm1jtcFIlrCp3+Rj9LLydc1PZBHq82PXrvjqnnHRD4aczkz1rGYuDRCAhmcjX0IVNZ2HODTpydnbIPdRXja+/fxgctivH1huezZ2JJ0fPMJN6i/ueJAG/8VliVJSjaBARzf0a+KSylc3xQon5b3fnNrSc5eXcdSlrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIMRyoex; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475dae5d473so16249805e9.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506442; x=1762111242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abMdxTHz4mnM65Ksd/VEIUAZrfx+v2elsO+gicoW6G0=;
        b=IIMRyoex0ZBZj0FTVDyHOMZo7wnC9AKFsYbL7S9+MjwqvjFuyX/ifTBrL1zsh6Yb02
         Z5ktp68o/mTZkCpjiWfZmRcBV4GmjrVRwMpbbt7QJV09mt9KJ7azN0V8xz72ARtbxYxj
         HuUqhMXo5mTSP5jGfA5D7fgxjowr1Sk5s5YaLK46wxXKFOgJkJC3DUf85NtFAXG/kKS4
         scyrMzokuydz4Vfyjw9ItbTJ0TIfI/56+dg8PJFRpFFF/BkDtk9rRBvnHKI+OZAQgmj6
         85id6TK9trMyFFtou91LJ7qk7rVFwVjIyfi5DG+Jo05eZq3UGLF5SHCPhMf+03+HMJLF
         EWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506442; x=1762111242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abMdxTHz4mnM65Ksd/VEIUAZrfx+v2elsO+gicoW6G0=;
        b=d4Q/Eb6BcMSI5iwHcx6RNaSRw5O2ehg5LFVo7JAr66J3dJbAfwGl25KRYy4r0Y2Fgy
         kAInlO6DKZG6U23Ab8KkA0xcoL43FADdGXgcC9A4iLsVTNLIZ8tWoFkVGt/SLLDr7/bx
         M+Q9mZbcD93b/Vvuh3XZnZ6H5SLX3DXHyWZe8W4S1mZma7TsYp2Q0pF7nvzsWOPkt+sD
         pYY/ipcI5m9dAW+mK5Jt6an8BNSKt8w9kXzk+zu4z19Asgi8ZLxG134nvgwNAHf9Rits
         pvg643fURYK9NS3Mbq1ngT7iNqV4oq5XLvUy1VuDDEhmrhOi/2HydZmzAly2X8r2YYrk
         Ic1g==
X-Gm-Message-State: AOJu0Yyqv3HAozPGWrw16tYa4JYwEHhSMhNdvhHFfbcvCpCyn3P2RPMJ
	FcH1VRwULftAC6ptNhSIt+7pd6noL5qJfQwffEngtE/8ZNM5eqOq+ELfF1u//A==
X-Gm-Gg: ASbGncsKtd3kesvC8Wd/0MFZvaO2JuflIm0dYg9ru4KlpNFQ1237kGUG+9iKdEkmn5l
	o1rJ97zhQUKXSRz00D39tCGLVScqyPmazbhMFCq9I0dQTliUuG4Ub+OXuxEZoglhG2xbiHFjMXr
	k1zfbRx+GrBXrxK3R0kUzGJj2tsWZl7tiGdxCJ5DO2X4Hc6hPBRBepOB+TG6Yd//Q//LHAhX7Vf
	3cHiMP8AbYS5GhYC3vBJRwtwLmHujZjhNn3tBIwasr2x3mrOQyVs8AXAMdH7RpC/5vyWHHgncp7
	U2AV/ntREtEiMQ+EPKTMhMtmF41KixzdT8hy4C50UY5BEXK7OWUYcTxaJqudKKtLRbEaREgbnAj
	dQvJp7ahJIuwKiHrNRR+cJgdGNVXdQ6lIA5FIsMCmUIopVC3YV047HHYf6Jtl/fWqRfICY253X4
	AVPSWSZlohVeCViiILKkKp0f16vj6rXQ==
X-Google-Smtp-Source: AGHT+IHd5wyxyqH3i3Q3rrFLpLc95H9ZebXFVFPNW83P1b3yu+7Bl2NpftgSz3qPiju1YTOmroFVGw==
X-Received: by 2002:a05:600c:3b03:b0:468:86e0:de40 with SMTP id 5b1f17b1804b1-4711786c6b9mr274271335e9.4.1761506439938;
        Sun, 26 Oct 2025 12:20:39 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm92434375e9.5.2025.10.26.12.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:20:39 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 04/12] selftests/bpf: test instructions arrays with blinding
Date: Sun, 26 Oct 2025 19:27:01 +0000
Message-Id: <20251026192709.1964787-5-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a specific test for instructions arrays with blinding enabled.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index a4304ef5be13..bab55ae7687e 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -227,6 +227,98 @@ static void check_incorrect_index(void)
 	check_mid_insn_index();
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
+		val.orig_off = i;
+		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0, "bpf_map_update_elem"))
+			goto cleanup;
+	}
+
+	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
+		goto cleanup;
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
 /* Once map was initialized, it should be frozen */
 static void check_load_unfrozen_map(void)
 {
@@ -382,6 +474,9 @@ void test_bpf_insn_array(void)
 	if (test__start_subtest("deletions-with-functions"))
 		check_deletions_with_functions();
 
+	if (test__start_subtest("blindness"))
+		check_blindness();
+
 	/* Check all kinds of operations and related restrictions */
 
 	if (test__start_subtest("incorrect-index"))
-- 
2.34.1


