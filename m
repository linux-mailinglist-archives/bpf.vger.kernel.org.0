Return-Path: <bpf+bounces-73230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C75D7C27C52
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 12:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0D9E34AA68
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 11:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0EF2F12DA;
	Sat,  1 Nov 2025 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErB/h9lc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A112E4254
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761994870; cv=none; b=Y10DxibhA2LJlKVz/OBPLNgG8Cn23czsidl/8SNtKVnyV8LZ7Xx/RRM7eT6qFG3CHYY/UuDmrXDgRV0oCvpUi1iuiLnDxeiEtlpMHwBLWQikAtEwyfL8f0ULUIwd8ciC/wKAsZ0DoGnwIc3jUR3N2yW4PLDbM9LsG8yxu6zgOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761994870; c=relaxed/simple;
	bh=BAI1lQvBdK84P02oXH9mr+Un3U8voH71+b1L9kEL3V4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HgLOay70fqtDlbF5NIGKECAr7bsxBtYmR3TQ5AAtJI7X66NtguVmGrp69YeL7GlUTyAZY7u5Yx8AHgLIY6az6oKA2sRaVPiSg0IzOc0AtsgnkDDS+x5nco22COkr+V594ViE5tYK9a20Tjqc0m4R1Z3WnzXz3MpaWQo43fLnWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErB/h9lc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47728f914a4so15382665e9.1
        for <bpf@vger.kernel.org>; Sat, 01 Nov 2025 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761994867; x=1762599667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2f4Qgz9oPkF0TdRJ7L47LATnJp6o9y0e7RASwzwmN8=;
        b=ErB/h9lcDbxahyT28j4En4Y5HsZiuVaQUApAxBfPEHtZr9Kak2DIHeq28F2ykinBsa
         pLHoJW43OtGp4qjVEq8EHj1AFBD0U5T380YW/NN2nvqjSvK38aW3u4ipEI+kicEEy+R/
         srMc82zOTIAbn7FKS/8DSzWEgKZCW3TK1Gn6XgmOxcEVev6WCbNlPe2j86lfzN7dTSsx
         +DPDpQQTeSbLtW3RfGjOqt+QXvc/RaZwAW3LuP2kt3QuVK4hksB2ZhXTVLYzE4OsTncI
         YnyRLTgi1cTk/+gmfnczI2A6Z1CVF5YH3ByC7r4iMdXSySeMWAiG4jB/Xl7pHf2cQHxh
         JnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761994867; x=1762599667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2f4Qgz9oPkF0TdRJ7L47LATnJp6o9y0e7RASwzwmN8=;
        b=cf3Czqjeyybhz6ozXH9S56lxLc8q64H07g8VOLXY76RTNOgMFaOekWBPEPMyQTdDqG
         YXbtKEba/0oV5kxTqI1u8x2bwhTHKHb1fZx292uBYINqKaQrF57NAJnssxj7o1X3Gs64
         yo9ktjSwtUbxYKYhi04Zv9SltAFsJxoAmx7CR2ddePJuV1Ve/gKcU7b5qBtDlXl9qHnZ
         cO7NzKjuSk+HBnqdJ2Y44rIovdLvSQ354tsSKbmqkNsPDnAn24W0wFwi7uuX8iSVhn2W
         enMSWMfPPgOgUt7L7XFLJWeuuCClmY+A1xqQSaN6QWoHu7q0fiiTNcVNp+TPNxtaxwiC
         Hs7g==
X-Gm-Message-State: AOJu0YwbwHu30JqiumDZ1xaghbWXFjs9gNlF/qREr819ycx7OWTHWNuX
	673SQP6X+YHl4tI6QdlmWtx0Cc/E+lB2erDfUf4e2zXEGPmNhsQ4bChANlfD2A==
X-Gm-Gg: ASbGnctVTs4hp0mAcCnMjOYGpJrzlIcDOy2lh7XbdtrJn7UIhd5mz0IKx02Hgf9DjOt
	I8JFsdehksSH4kGdxidTMWsN1tDYJT+lEEwE84K1umxDJaJ6U9vaq27l0YHrz9sOgjsUok3inZo
	6uUMT8zclv7nipYpOR954D6ne2C+Gk3weUg1VXd0AO/jc8LShAvPB/2wE0z0CujZvsbNXB4SJJW
	ZYLaJtlGDIche2RYKHmXIrQM5Y45772sdnG5FUz/N4obd78Ix/Zum+w0NXaJOwVMsYF6K940Zf2
	1NJEdhsJY7TzQdZNHFs2h1tLymH3L2g5o5FpB7nazr/CsmNeI9bxp53XXs5zX1UMbUxUSvGjWUC
	BeC/dtRYjHEiZI9312KjG2EgLv8VqNnoBgt7t6+XFnVOADd7ItcJnEY66IMXJeD7DeGLCqZ0m+H
	tDO5rFysliSyLkxqiqvVOvmNlVvFkAjQ==
X-Google-Smtp-Source: AGHT+IFow7kGTQAJ634/JAU+/jWeA3lzKysra5YDtHfeiaIU6gh4bt0BCy+Yhx1/9DbrZHqr1hgZrA==
X-Received: by 2002:a05:600c:a345:b0:471:1717:421 with SMTP id 5b1f17b1804b1-47730872584mr54592045e9.19.1761994866642;
        Sat, 01 Nov 2025 04:01:06 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772fc52378sm38794005e9.6.2025.11.01.04.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:01:05 -0700 (PDT)
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
Subject: [PATCH v9 bpf-next 04/11] selftests/bpf: test instructions arrays with blinding
Date: Sat,  1 Nov 2025 11:07:10 +0000
Message-Id: <20251101110717.2860949-5-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
References: <20251101110717.2860949-1-a.s.protopopov@gmail.com>
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


