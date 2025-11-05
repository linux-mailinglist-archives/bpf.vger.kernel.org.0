Return-Path: <bpf+bounces-73593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0109EC34A28
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB00118C746E
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19C32F069E;
	Wed,  5 Nov 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDc/IFeI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611EF2EFD92
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333088; cv=none; b=P9gYQ2HhX8YSwUvebR5atWHApBAdzA14BB/oRQUSVo9czFW9sE/Vg0RnALVf5OORumVsoLrBgUSv6RW3hbpJFKFZHHXPiFx45sgVT6sG3+mxlRxExPqmsxpumpOos9pRTspGbMDyq6rgQmgf36hQCvu3zD0V5ja7Kq8upbK985o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333088; c=relaxed/simple;
	bh=BAI1lQvBdK84P02oXH9mr+Un3U8voH71+b1L9kEL3V4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l3AA73pBmQYCgPIJ5gRI6LQuWgxFe35PuQiHkGAEfeUfX5mTYFd4gKUOOR2mIIWQrHS6NGWajwaQ3+uWgXnZ8dUG3wb64eCUD9MHR67cnNbGVgGbIDY/eGkZ0V4dbQrpc0zqtjHaHjj18wpzzDkYJsVtvkvBthupGIICzHGdShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDc/IFeI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7277324204so13637466b.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 00:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762333084; x=1762937884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2f4Qgz9oPkF0TdRJ7L47LATnJp6o9y0e7RASwzwmN8=;
        b=nDc/IFeIYxe6W6ramegv5dSkIusUckPyQUTlJlKlNnFlx3RJillCP+D4cScEKp3xvC
         I56VFur2A5xT+MPl6Ka85CH63s56hjbyK9AYMOILmbtbMW5SsdyuWAVXs+5vD3QsjiFs
         LDUcZ570gnd74EHgWulAHCkDvvcz0lNAJksq+EWK8fJV4/t4OOGDiWppR+99PzeK8jlC
         ZkDB+MQmwszkIaKK1rlpbcxPsNlJxfVYytmVn0V1I896VXJHgrLSi2cLeHsLnnTA2T+p
         McKOKVDV8dUz+MiQnQIb3gnP4sGqXI0Qa9piMmh4D38sA+PLsBB6DbIJdR4YVUhVIYjU
         QSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333084; x=1762937884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2f4Qgz9oPkF0TdRJ7L47LATnJp6o9y0e7RASwzwmN8=;
        b=lkO5WCnFVWho217nBw7IdCX7wiOaYLOqwHJDqoKdsk0CH/DhveL+ZCqHGFwMcLH/oN
         donGTl5nQhf399I8DXR+NQQt0AjpdSgElT4vYQiSyIVDY1w6Uo+vIlGEgzgxeZ1ZCO+k
         mEUjr02gYJX1eoleit/fwhIDZUpqLQqTSS2r173XMzY0xQ022rOnbOnTB/oOXN6KlXiW
         vQHC+e2ug/8+uwP5XsIDz4ys12bdBN+SmlgZpKYV9esVoqtvrwUr+fOs4Pa1iQQ3xtyA
         mC+qHiACQIykCJDPlrgSKe5vKsCwwx7TCDS/56lNRGwEd3PvVpmiaQl9G3nvqynwhQKE
         yQPg==
X-Gm-Message-State: AOJu0YytrRNj0QxjjUDvIlDCP/gtyN+91YsuyQ3wrZkpT73Ot3VYLDeZ
	ajGN7YnI/uOYCFy+t0LBeYADBcZMliVGtmk8SnCCvwNDV7UzRCRFOTzTqRMAFw==
X-Gm-Gg: ASbGnctLwlQZcX8rCJL0mJMVlGDYz3ErZm76doJyQK6UyPdTSCEqPzBXUlJIdyibcs7
	52Ryf7yfWwxWxS2pvMbJNmGaXZNDxlxU2eX5u886bI+P9+tdP5HUpDaMsFF7HoX10/wSMz9c+S5
	fXPLwitn9CTYdvuPhjensdGN0SkZ51FsCxxO1vNNPh2nnNNUwfIgjwhL8y6TdJ02HQ7LSS+cHGS
	HsRKfiAkALP9Efz5DM6DJ7fCUO8h+WrGfoHK/naPEAkb7MpkEnQGeixFYeoFP4hoop/7qYFWwNb
	K1evFLVdrUw4dZ89b7nnHwkoML8KmWPzz8Cztrk7GhVAkCquxqk3eBmSqkRcwLY9/gRx6NVojJC
	F1DKcHlCRvCp9SzXw0H+5EcIOt2xUagTEtWJb8WJ1HYES1VoTqCvSHa+2fxlb3SgYAFHYmsbJNn
	OmHlU0pYftTRzAVCuCrzk=
X-Google-Smtp-Source: AGHT+IGsKP/kmxLgMG8PCwAOrxZOHsOdGya5WVPpnCdiMIUWqxXehMOsJpgol+hjdD4JtjrLQoABaw==
X-Received: by 2002:a17:907:3d4a:b0:b6d:51f1:beee with SMTP id a640c23a62f3a-b7264e54066mr233137966b.0.1762333083606;
        Wed, 05 Nov 2025 00:58:03 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723db0fd12sm429685466b.32.2025.11.05.00.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:58:02 -0800 (PST)
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
Subject: [PATCH v11 bpf-next 06/12] selftests/bpf: test instructions arrays with blinding
Date: Wed,  5 Nov 2025 09:04:04 +0000
Message-Id: <20251105090410.1250500-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
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


