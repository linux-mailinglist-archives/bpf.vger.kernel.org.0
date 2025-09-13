Return-Path: <bpf+bounces-68299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70441B562C7
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 21:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D46C67A53EB
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 19:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323AA24A044;
	Sat, 13 Sep 2025 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QldkxvBB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C472550A3
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757792027; cv=none; b=Mmoo4wT9LpcLsXcac+dp9mMITRMdukpkS7BOfwX1dElWNyXoH4MgoCUahIreOny5QAAfEX588xL+7nVm1wqfTNlJ0as4GxgjGQ/h+cZnDYt+oz9h60wrSfrr8vxcO1VVBdhUVDYjKnouLz1Cu3bLiJcO2NyZVslOHJeIL+AkvK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757792027; c=relaxed/simple;
	bh=l45/9EeDAZ9Gkm5gJgbZIUToBJbD/hPJkHCB6LgV3Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uvJw8DQm85gnfJP4nPJHGVSX7Gk/UGp3oJZ4iFtUQ+uTj4JDOqXa5/fV8He6lw163FmO8ZPhi4LWO6a4LpD5tqSD3qF+Dbxh4hWn0a8SwO8ONMVU1GrqFlKE7UQHkaDrGHtm1Sa4QXtFHO79WH1kQ2fdYCuvXuTMWqTkd6jXWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QldkxvBB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so2115492f8f.3
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757792024; x=1758396824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0IpU8W2qRdZwBfmyMjSwRdVsHzO0hX0laffmfKzelw=;
        b=QldkxvBB4fKuqwNZ5rTJiG+wrxRr3wvr6MxzA3fZivILP+VOi8k5HODyLcK44HG5HN
         jgyEs7zPGjNHKUjrLxEOxm6yvnFYybp6ACFDeRzhdDuv/DNrTjblm9wccnTfqts2zdqL
         JVlK9rRW33KJ6DKyeIVXbG6o3gMcnMD5BU+ExKf1HbtYzSbuU8rbGJedlMZma1+O2GOe
         VvrFwtTzl8r2eZrfBLxQNzGSykhGMtzdgd+HXe3oBNe26+DoQ590Q6aghADyCJ5OHS/4
         EB4BYmUkgpQ0ZDJIdWgLy6ZBm0kFPXlGu70bnpi3QZ//G7Kb181iT0Le+9ePuc+vfiWw
         v6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757792024; x=1758396824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0IpU8W2qRdZwBfmyMjSwRdVsHzO0hX0laffmfKzelw=;
        b=TOJxQIrM+kXRZ+fhZeidIcfqT0LDUGH5qEzPnn6HeerzxCOMPHhEMYzTx3oJ3v3Ksr
         isrUbNGq6A2CUaLp1ETXiqJhHArK31d5eIGMN3nIuN3BLzmgWdaEFVzBR6o8ipobvGrx
         Mzvyz7WPBlduJSuiiIuHS4630lCiD96aMhO/P0IqD8GSL65qble0qfufV5fSEcGWkU1+
         5hVfTMKn16PzTOGRVwe4Jm5yG5xHYsaDjMfqCnRKKiE7jRy7vRHkRUb7CJX9X+vpNuG1
         4PGRsI+fvNMzGRBSuVWQQXbUyCTlJB4jLfp4cmcG9hLprb9W+z7sD7Ub39i1bZrkNS1W
         9Oqg==
X-Gm-Message-State: AOJu0Yx5XdoAVMtZ6z8S6suTDUnU8WWPL4BY5HinpQkrXyYn8quBOtgY
	Pdn635MKbFMeSNxAXeUlUL5uw5X7w0JydT0Vhwynyu0B8Ew7nP83S70qecUxFA==
X-Gm-Gg: ASbGncvbfxN2KlwjpbId2gEm6GQwFcdAkXk6iHDZEEXhDFhGvtWpvkZYdOqHIbut24T
	qzGzMr/KvzpoDny98ZCls9x4Q2P4sQRg3CdBI9cP3Lw0NrO4B+z6VvDTjWTVRZleX7h3emx3zjl
	hZfm3WogZkasmyugM+GGLK0OdOarBGDY0n+TB9P3NQ8a6kpyXks+ZU18p93rvZNJX9PTzPV+Su1
	JLTRiQEko/seYg6ZzGfEnEk2uv9GWkbPOsJCcB6AgLMBsmpAmVv40YPE6i2Io8v+TYErfyHqeFH
	jj11w3JfSPSTCtT+2SYBxzfZoHvp+ndM11hFWfbPBQdnt0OiaEcT/B554PL4L6VAnKHQD7GIpLZ
	mHOo8t0zOesQubfrdE+2IdwHRCVncHQyJ5HCFzr/WN+m4d1qnLerx
X-Google-Smtp-Source: AGHT+IFp7LbvBrteQQuqnYgvCwyoSibcUMtXOa138vN+7yCQDZuQQb3RekhogNnLOxZ75bPAxAUhIA==
X-Received: by 2002:adf:a455:0:b0:3e8:57e1:8fcf with SMTP id ffacd0b85a97d-3e857e1912amr1652143f8f.34.1757792024031;
        Sat, 13 Sep 2025 12:33:44 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm4948753f8f.27.2025.09.13.12.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 12:33:43 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 06/13] selftests/bpf: test instructions arrays with blinding
Date: Sat, 13 Sep 2025 19:39:15 +0000
Message-Id: <20250913193922.1910480-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
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


