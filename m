Return-Path: <bpf+bounces-73260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DBDC296A1
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 21:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB009188B55F
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 20:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896E223D7F8;
	Sun,  2 Nov 2025 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpcd0sKR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52797220F5C
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762116718; cv=none; b=cIvHv+lDBzVn2dbMY/p0XqmC+IbCMPQYpKamGnfBun8W9L1YYeRT5qtdW4haCwc/gA0Mmg/5NIPIzaqdFCBHhPZZkQzum4eQ7PCCmPlD/IpGLJfMUfDglgDQB1kT4A4/F0WEr0sRgvH8Swk14U7vcXrpvhwuIa0AlqkTj+/O/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762116718; c=relaxed/simple;
	bh=BAI1lQvBdK84P02oXH9mr+Un3U8voH71+b1L9kEL3V4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PG0TkXDdOcNTAMNdstq/t4jOoXErJo2NgQAfa2gdUST+enNEhrqGYW+MJ/7l+er1nxYB+BbuQJIfdQa0fLekpTUH9MWzfl5itVbgE4CNDcrT+i8jMYihc3tgCf61yCk34RWS65VsTWqP5UeMJedDGMKQSLtWX/P9VZippogi/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpcd0sKR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3e9d633b78so924107066b.1
        for <bpf@vger.kernel.org>; Sun, 02 Nov 2025 12:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762116714; x=1762721514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2f4Qgz9oPkF0TdRJ7L47LATnJp6o9y0e7RASwzwmN8=;
        b=fpcd0sKRNfLz5pmXGpsWKtRrpvcfcyyeAWEY7MIuEmoVLN3v/oUA47h+gfxw6olP5L
         d+O/n3HSul6RHDIANs9n7so8EbHkYi6wStZTkeHM5f4JCygiY3mQJnuogjlHEk0bSXp/
         OTS08Ss9+kQ23xb7c5WmFQb2tm2drsQQRdD1eKgCuM14W3+qiKpfEVWPrIm6K5hRcPvn
         nPx/MVzhycxGSRVH9Gw/jqk6phJYdOgTMJPso20Z1Cwr915OhAcWCW/E5p+Syd0+hmKt
         UET5P/FaOy139X3D5uarChlrUDzD+nHusaiw69iSd/Fx9i868jM95fqIsyl81OvOrgIK
         HCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762116714; x=1762721514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2f4Qgz9oPkF0TdRJ7L47LATnJp6o9y0e7RASwzwmN8=;
        b=eBi/SEHikuf1uC3i5Erty0ICTIEPXnJZRyzKXGs8DoMmGO6L8wctACCOOPUPvzewIW
         3JwhoABhV3GWvk9aGIyaJ0S1be0NfIrAbWg0+PzSJx4a4ScOcLjzIxw2DJOiXAgXiWgb
         Q2yOgFFHTifjukc27BM/2c6hsZLtWAt7uuwVVq80OsQX8JgVUS+QdtczHiGF0MZI+Yih
         uokgXsbMQSWKmEgp6U7nrDnzk5h5RyhQKkVgMyMSWbvSod37c6iF9n7nwhfFWWLn4aTi
         LyGuanP9NbL5/IHVTkxNxjaSj+n0elqjgZR6GieJca1wZxA5hfE7F416oYw52vRRLSE8
         yi1Q==
X-Gm-Message-State: AOJu0Yz7e6a4qMUbveuQl4IKiU2lWzNBSs1rkNJOV+o9gvtyTkSCXbAx
	fycZMig+Ypx4+6HcfOyTIrJ+ltDCL/ztT4WZoo2UwfK5WbriK8uW9yLfFI8onw==
X-Gm-Gg: ASbGncsz7rpDkK7ArEozQ/YC7a44BLVRyJsqPcuNfC97yfkXfo6XD4zyoTq7Ry0B7Ah
	VzKFpbbdl0LAB3+bTa9hrVx3YT/yRJCeWsWV+Fgoq3tFN9uFPWZSqOd9CFD9CO0n+MH/eRYFSZk
	dXjkiF3R2vvken1N50G8IKrmx8PQAOmuKO0B0/oV0IZ48djn0QO1dn5uhptyAmSjMBuExpJeUFR
	xWMJc5JaPK9MDxvt2AOAC7tXxAXWo6fCh1Ts6515nHghNj54vZOYwieFy8i5Y2YbSg/PbpNxlNw
	P3PriS+PBljIgAuRNvTCGOAP5WvgU/RpwI9rOLfL8AqT+JN58RYDBIt1uAFMAwD9wPa9Ut49ZwN
	Di9bfXiByyWFVS2Bot0BiSe+gxFOxSYE5z9RcoHnCSKlGfVLj3W4h4KyQBWfl32QXWETVuj57z7
	kEHWd5YHtV4Ek+CTyDs2TBUC7qBMEDyQ==
X-Google-Smtp-Source: AGHT+IE1IMQkiZGw6HPm8y6sY7lZsw6+gfyQV2sz2/Fs5GQb1906pSgWNc1FCX9WQioai9ww6Gl+8A==
X-Received: by 2002:a17:907:7b89:b0:b70:b323:b7e1 with SMTP id a640c23a62f3a-b70b323f7bbmr234628666b.28.1762116714047;
        Sun, 02 Nov 2025 12:51:54 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b71240c245bsm14029566b.10.2025.11.02.12.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 12:51:53 -0800 (PST)
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
Subject: [PATCH v10 bpf-next 04/11] selftests/bpf: test instructions arrays with blinding
Date: Sun,  2 Nov 2025 20:57:15 +0000
Message-Id: <20251102205722.3266908-5-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
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
index 96ee9c9984f1..cf852318eeb2 100644
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
@@ -382,6 +474,9 @@ static void __test_bpf_insn_array(void)
 	if (test__start_subtest("deletions-with-functions"))
 		check_deletions_with_functions();
 
+	if (test__start_subtest("blindness"))
+		check_blindness();
+
 	/* Check all kinds of operations and related restrictions */
 
 	if (test__start_subtest("incorrect-index"))
-- 
2.34.1


