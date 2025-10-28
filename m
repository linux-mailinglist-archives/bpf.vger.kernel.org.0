Return-Path: <bpf+bounces-72541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5D6C15255
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F141884087
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5503370FE;
	Tue, 28 Oct 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgpcfV4+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431781F8AC5
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660917; cv=none; b=W3ZLyDW1aeLfxAmIc4zRDy6b7EMiuavi9DK86iKHqOe2mJumci4wOgsr9evzM8+OMfErM1bdeblD2XpxebOjDbW+G739AH9SDp4mwe1QLQEORbQfcHZaU5bwHe+wux7et6WjOSaS7f6S2GynvgKG3FQdJaFreEKLTycqAkMHa6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660917; c=relaxed/simple;
	bh=BAI1lQvBdK84P02oXH9mr+Un3U8voH71+b1L9kEL3V4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhuzRGqhp2KkSYJ0HmEZe/igYrup4MWBDtJY09+v2UIGp+JIfnuIMNQ+XULk3Nzwxd3VM3scNmWJyY3oYMEy/LN4AF0/7rbE8C6JbfJKvkQEjuVtFj50VCGl39RtCDs4SMcZRlkkasf4evlNaEs2d5HAyX2qx9eKDkg+rZewsLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgpcfV4+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so6185147f8f.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 07:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660913; x=1762265713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2f4Qgz9oPkF0TdRJ7L47LATnJp6o9y0e7RASwzwmN8=;
        b=XgpcfV4+vRhXgxoiTNtPg9D7wH0P7zbUSBuCQ15khE6vKSMPSy20tE1zZyAjnqT8IL
         6RhoOdSIKKs9zNFsZrm/m0G6xodZNuHVIDijj1x4SLMuyL6OPDmHll1j0vbDopJSYeQi
         3OLKoW0BmLIb3xhvJJ1HrRvvuZtN9RwemKUkQ1LkNeo2mRcsHUu6C64EA8lDHNYNid8q
         3wf9EXCIDykBjMRPgsVuEklK62rWj7eW9mRqglI5XrPgfg+2W/rKzPKrIIk8d/VMhDoP
         ZkgnmGKNBg1XbA0hvvESoG9bUVGxmaAwOeN3H8RzU37LLI4c8/lLQ7j51CWFKDomR1Na
         noUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660913; x=1762265713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2f4Qgz9oPkF0TdRJ7L47LATnJp6o9y0e7RASwzwmN8=;
        b=OFRfJ7ZhnnjTvCt75ipCSxds4npt4qpzw55ciTEBjEcrPUmobK8Q5E1noamNNVldzf
         c9YzQeQcMicwDkcdd87HwoK6LLgCZflWtJlHp5ysE3PIJBrli6wkBTGz6mn8MXTDdVG8
         4YC1930zsnwi22HDpj5SVdqsPUu0sm+gdYoOYU4sSy0x6V8DlX5+UDtQ5wnarq4gdNm1
         /3x2gepW1U0J0blt42h0eTI+/+RR0rinUjanh757Av8iDfH5vhxolDVC5rnvYIkymdYr
         ruFq79W5QIgabxUq/JsDXd9Vf7xfI2KpIqrI0Q/5InwSpQBQA7MOnr/mpTf04d3GqJCI
         ZutA==
X-Gm-Message-State: AOJu0YwfIsxY9TWpy0FPGzdOXZFzB/tngglnPvsKWxfcp4CJU+7f1+Rq
	EuLbrcL8P0dWcnrIIn6zzWtRZOaE74rkxQsA96EscSqRl0Q0Ps7y1LYMxaX00g==
X-Gm-Gg: ASbGncuis3Jnjzn9K9kVV025VLSqXGUjviDge0bWPgLAGKFBsU4z8Q88In6FI6qMmjE
	CijQ0wNyUodEU3sin1E+KOIJAw0UMoLzxNCSWZyGGoV55ci1BaQIJlH5YvHxIklmHxQer/jxr5A
	Pd6BOmrQi9FbY+N4u27xpd6/C7Q23Cimpl8i+be0G4RDLVAtuF7W8XGYCcKkY7xZLjLL9BYFog/
	re4PoyYmZywWvBMpM6+mJjdrNpeLMPVsHrtfxqYZk2Y3dJgbtGmqF6O7E7fkopR5MIqxnSnagsT
	xm4zw6Ec6Oq7u3thTgkgWISXD38HfiMkEKvxZBpbWfEZ6YMwQvWJNKAAMuPMNROXsUyl6Slhcth
	FR8CBNbXXl/BUcGUSGeMSI/hUVXIA16D6kkTvAylqOuTasbqyjOmjnE81G6j1FQj5JVFFzSa+yc
	j0KAgHjdFqcbKWzFnbLLY=
X-Google-Smtp-Source: AGHT+IEfts+D7UwCR6AjXEnNQ3g0fvbTymcftICIXhM5LhE+PS5SXqjMr57QCHVtLMPO7gFsT3oGIA==
X-Received: by 2002:a05:6000:40df:b0:425:76e3:81c5 with SMTP id ffacd0b85a97d-429a7e4edc5mr3095795f8f.17.1761660912694;
        Tue, 28 Oct 2025 07:15:12 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm20867060f8f.21.2025.10.28.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:15:12 -0700 (PDT)
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
Subject: [PATCH v8 bpf-next 04/11] selftests/bpf: test instructions arrays with blinding
Date: Tue, 28 Oct 2025 14:20:42 +0000
Message-Id: <20251028142049.1324520-5-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
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


