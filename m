Return-Path: <bpf+bounces-65822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1462B28FFC
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 20:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48845C096A
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 18:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7DE3019B5;
	Sat, 16 Aug 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E63/3cUx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14721E1A3D
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755367328; cv=none; b=rXIdqcUcFdzAvz7l15sh3v6KHhSMe5BKYfEAi+n+idVtwPHzZzmqqRijkP1oM1mT0YLBWzDsmgl7ynZO0WAAifW49nmLOmYF9cZvFUQLqDKzg21DKwQhhZ5IwaeMxYjFnfjkEmAtdXcrdwmNdYte4I4MA++baRKiA08QtF5adXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755367328; c=relaxed/simple;
	bh=b8m08FEJ82EolP51zIAwwLa3onPEWcFAvAvIUiQH1dU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNRwAaDs1r3KB5V+xGG5qgdjbJpuYfMMTdBfzUgzxe5R0OXxn/isvEz9POlfTE4gy5bXnOc9GRinZgyaJoemDe9hWxA55JEk0mflDhjf7UK9LavAZKwHuUzR9kuyPMTokR7ArXm6HiJUhajLxIoEGTmV6wf9jQnxiAFEL8FZbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E63/3cUx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9d41c1963so1453993f8f.0
        for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755367325; x=1755972125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYrjQhvJMHXaP/9ruUcfnVI2r2C+MiR/30xTndOw3+s=;
        b=E63/3cUxWUDFP8/4EqHbsXPW/uPu4CyRDKteWPlOCDQm5Xh8aqxeGvaX4b78g7T3J9
         Dn0mWJjfLG85YoZ58IVx8K6ig8GP3A25fU6q1eSEERoismAOQA+nKn3ZgVB66sOvsRsK
         sVd5hTXu+QIqIdZwdrhrf0DcwkKSWJwsaXjvB0mFBD/OeTT9kQZ8KRnTHu09SykNDpHZ
         D+GVc6RuL66PTQqRqw0MHxzNccoKEYd2wSNzJetq2EfVHGGH71Ml6nM7JvQ0zuz5TEiY
         OANCQ/LhwIxZ2wOhuAyXPnJy0yKg/OisV5YezuIxeD6c7CFLOr5ju7KOhUcRYR97k2og
         st6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755367325; x=1755972125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYrjQhvJMHXaP/9ruUcfnVI2r2C+MiR/30xTndOw3+s=;
        b=GtQ0KNE+Pr20AvjGC/vjA5GVUZeDrYmsNCGCIQdbpIVQNuRs+LPEPeU6iQ/S5tcL/L
         6nH3FZue7aqNQTUGX6fywWd/I9VttdqvS7T1nnKX4OcW26S/z2ezSpWh7ippIkFpfaUd
         bbZ1I6YAoWOdZB8zKKidaMtxRyPNDxakZGG0uoGVnCb+Gis00trVIuPTLHdrQNbYA3em
         QTURd7QLZCUdoij9dZPCIS//sYfQxmFx2C3LCMrI6PfUUpZGJmrq2tC8mUzvCc9p/MFU
         cJvGZROZDGO9x57k3jDNDlY1a915+Cdcf+Q9tBQSkMeKawCfFk+zD+bwYITbrI9qqa5I
         xqiw==
X-Gm-Message-State: AOJu0YwqyPlOy/S5H383IfTSKq6jG0oUA2iNjJo+oNM06yXXmvTKK0wV
	NvSHn1+Lcub44EkFWwAoUBNvVufxuH+yEAGLt700Qy8LgW1tOjqI5b8Cyv0Xsg==
X-Gm-Gg: ASbGncuXx+ymq8t6i0nzVZOPFVEpkUB5+tv7KubamTDE6UWAmlkgmraY4piJDjg2SxS
	cTVah2wzLYZEt+EgWgOoeLxN1JEe5ffu+wKY3B7sq/Sj/5jRsKqUEO5YsqNqoOJS62VdaFbia/w
	N5GjNnbHtWNtjS3swOcbAnlusDylqDb597qh6P+yUVzjtjFcJUujJQ95GTVInbApiOIvt6/zoHs
	sBS6Rz3SYz5Oi5Fyk1LjbMKcJIG3yleZU4dnHLjOzssATXoNLSUx9q40Wa3/XFHPWWuYrtYwtQd
	6T6J8cLlibVkyVNIznrPHXtkXZqQeZEAWUEFaSVUpkgdfxBD9h5UqGgP4kIJBbSQwE9TdA350Kt
	R4nP3nixUVlfVVWPX02eGrT67vsTyq+acqIT9RLShkrU=
X-Google-Smtp-Source: AGHT+IG/Wd3NBFQaW1Z7Ldz/b2j9gbxQwxqG1hGJJdXMNtm9EljxmSGJUcudtlpztnDczSYUWi83Xw==
X-Received: by 2002:a05:6000:24c4:b0:3b7:644f:9ca7 with SMTP id ffacd0b85a97d-3bc694261a0mr2388933f8f.25.1755367324807;
        Sat, 16 Aug 2025 11:02:04 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bd736b88besm1080193f8f.67.2025.08.16.11.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:02:04 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 06/11] selftests/bpf: test instructions arrays with blinding
Date: Sat, 16 Aug 2025 18:06:26 +0000
Message-Id: <20250816180631.952085-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816180631.952085-1-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
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
index da329c2e85f2..4fa09c05c272 100644
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
+        if (fd < 0) {
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
@@ -390,6 +479,9 @@ void test_bpf_insn_array(void)
 
 	if (test__start_subtest("multiple-functions"))
 		check_with_functions();
+
+	if (test__start_subtest("blindness"))
+		check_blindness();
 }
 
 /* Check all kinds of operations and related restrictions */
-- 
2.34.1


