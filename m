Return-Path: <bpf+bounces-70016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 965A3BAC8E6
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACF9B4E228B
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E972275AF6;
	Tue, 30 Sep 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCOqcv45"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3832FAC09
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229394; cv=none; b=gHKW6QWvPagCa8LjmDPmvYtEeCovFOvYRSwNd8xKgR2EbyTKL2rC+uKFd1dbJ32oncB+nsoeKD/8DhffM63Pg/Zo/ua+b2lmpFPcr2F+O/vH8kCUSmUXQVEedHpJW/eU3E975O5qrCi8FuzIgnGYHHvoYPHpIN7bNQkaE/mZjRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229394; c=relaxed/simple;
	bh=jQ/TRt8DI2iNunVmfa84vn3u7RoRojxSDonghgjPMEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NObHtMVdXVaxJzR1E8w/DA7JQ/Xqvo7e8uFLjK1iOQJZjW2ceFXBmZl8TUbxBUA6aq7zvEhuhMZWHaj1t/57FTCJi3K8VkjenC6OSRYTgJOU/6Mz3l9eVNMa9J3q3Mo1hj+1TxBTTa9vXggY6LIQDrdRMSEdrYmvHdYGptW5bdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCOqcv45; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4178528f8f.0
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229390; x=1759834190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k20JsPsAL+9Xp7NPFMoGW+nmMZkqu9GxlEz1OKzN/LQ=;
        b=TCOqcv45b7+dSCn/Tct1w6ACKRiO0+MaQ7DmlpecPBcRchzWaFmsoXsNClJCeYAakY
         Q4QYhJHLeMwd7IlFNUipBkzXS+Mbzc5odyCFX2/zg+GsbtLbilgAdTFjIdIjWobZuwLs
         qB45LZxqr/o+WbAKUSn+Tfn0cwocZE+LCkawMmt1JZq8MR8IQBwKzUxTSwwfNG4SHZCD
         8QuOZ1fTDqGkm1t7WKW+I9gpvcnvbDQr5XcCN4mtpolQ3MZ2J/riunf09j3kE/WE+csB
         auy99SA9zlezwiUNfMHIzAT4USxq3eu1oaw9P8r7rxGb31XAH499em92LDLj4Dh0UsPV
         GTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229390; x=1759834190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k20JsPsAL+9Xp7NPFMoGW+nmMZkqu9GxlEz1OKzN/LQ=;
        b=eeHevN8tGd4YGwoELaLFZUFba1ItIfm78ljVD0cCYuFlpjDfgMl3Ay2xxllG2NbpDx
         0AfubbGpcmPu4BOh7ISbWaabQ3ZgJ1I0yG07kUENKixQWJv7JNsSL0NLsC8weW77yfP6
         H3F0sRYhMtyjpwSHz/0Kx8IKuKT0oEoGCcAUDohWF2pJ74t2f7H0MMCan0A1LPltx8ks
         I2HZX2kE+5jdmAbfC7hyBRH9SDyA0zgbNzYUxTD8lri5JP3DayhtElQwUf90fLN4dseV
         Dghwp86R4X2lNrlGmogKpzJzC7Oho0/VK76AFd2+yvD3zK9Yo/RlNHu4x5+1sLR//MQR
         XuAA==
X-Gm-Message-State: AOJu0Yy827lA+KsLUQDL/VbgW+e/mHmyRWRcDIZKvhNry32a8x8notzB
	Sqgtg3r5zHG8CMzBMWmVkzDO7uyJdy423Lq9i3SUD8S3W4t9dvQ8Y3Sk+M0Frw==
X-Gm-Gg: ASbGncsZktHcGYrccxIAaE0t00IgfdcTg1JExov491OaAzS/jzPEKxYuHLJpngygDZf
	G9sFrtwMcbttDOJedlxPGgSfSCNBT2AmoHgbh4uROY2IqbvU993bsdpDk+hFP6JdXwS4RkwfVy7
	PY002E/c7ucTb9GR7zrVSPRnVAYvUCtfuSX4oW+fF47Xn9QY/KtEPXkjOMSPcrWSKdzGs1QgK0Q
	BhlEIpGbN6jXPeyYOhHnfAFYqttoVv8ulCEY/h73XjPoDw0PL7Ieq/nXmN/2K4RJStb4VNhMjB3
	TvNxtNc8QLKD5fSqG/OGkfv0oLrbMkvZU7q1DYUMQ0/T9c2SHJBvAaoGMLqgNCxhu63YnYLacBS
	jpSS/h+UV7IHziFLaEh6SQnwOg2UQWG+K2QKCHFvtbetc3NPNqBP+8Lj1wD83B7WqWLT8MKCkIi
	OADiY3590VUno=
X-Google-Smtp-Source: AGHT+IHUalobsOtFnBfPwddL1FlAKeaHr6ABOgQok4bEUe5tXTLCsSVWu0NO2LwzHI3K+rcYW6mEow==
X-Received: by 2002:adf:b1c8:0:b0:411:3c14:3a8b with SMTP id ffacd0b85a97d-4113c144043mr11995123f8f.61.1759229390241;
        Tue, 30 Sep 2025 03:49:50 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:49 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 07/15] selftests/bpf: test instructions arrays with blinding
Date: Tue, 30 Sep 2025 10:55:15 +0000
Message-Id: <20250930105523.1014140-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
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
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index 9406a4e2faad..22a6f0ec66f6 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -305,6 +305,98 @@ static void check_with_functions(void)
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
@@ -463,6 +555,9 @@ void test_bpf_insn_array(void)
 	if (test__start_subtest("multiple-functions"))
 		check_with_functions();
 
+	if (test__start_subtest("blindness"))
+		check_blindness();
+
 	/* Check all kinds of operations and related restrictions */
 
 	if (test__start_subtest("incorrect-index"))
-- 
2.34.1


