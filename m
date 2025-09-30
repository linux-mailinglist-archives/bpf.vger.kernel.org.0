Return-Path: <bpf+bounces-70036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEA2BACE8F
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 14:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65F816C5D2
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EC53016F2;
	Tue, 30 Sep 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8dhDke+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E82F99AE
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236346; cv=none; b=aaEE4XakDrxS8vzAVUdCxfLWwiZkuxmn0Fo2Epp8aIo1t9kwLo/pO8fOlt1rUDClPr8wSnPjx8Z9ARoM3TjselFyZnp+QezNvFuTuB8wG+kpCo9UQi+A0JlCcxQaN4QTVJ8bet1eLWUqQ3s/Yr3mATEUSRRp6Qr0mw/bYuigLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236346; c=relaxed/simple;
	bh=jQ/TRt8DI2iNunVmfa84vn3u7RoRojxSDonghgjPMEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3dmAxe+T6rP/0xKZKCk0AwYQF/k6n5GypwDBVcTRseEd3c42U7MPxMICK0udGv9bu/0xLusVZsCbNsWvXbwSJb0PwuAbH4I0gnKHMGNi3GsyV3ewtsLLdihnLu9wI/m5GVGeCKa1tlLVKnE3UXPFmtJFUry3UbZcm33Q1rIwMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8dhDke+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e504975dbso18900515e9.1
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236342; x=1759841142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k20JsPsAL+9Xp7NPFMoGW+nmMZkqu9GxlEz1OKzN/LQ=;
        b=D8dhDke+rZAgBU85u7oCxnQiuXfsIUlZEzZLabZBV6U4tRHdCrsd+BU44hqlqe1AlV
         vrLV0UwQmmRXD1C7PmqGyLl2bU+aXaAhQIyY5NdVCwhQq5VtjuCjy7z64Sz5mKetKeGk
         lXaktwjNjt8PIoo4/TKnyLdruhM16QSvy4jJKubZdGTEEK11Ol9SRNjRDi0GuslhF+RO
         WAFKxhPSeeoaonsDx+SvPVtuo7vtYejdwe/i0h/nbrxrhLmhY3LNLrucPCORUg5+Od0g
         DINHM+NVKXgdjD6/2XB87I2t+bFUsvGwOYPOUMJCVhlziOMkKvrgfgFmZcsAGDNWrpy5
         7sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236342; x=1759841142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k20JsPsAL+9Xp7NPFMoGW+nmMZkqu9GxlEz1OKzN/LQ=;
        b=j5qR1wQuiymVeR4Dby5UmkPz6sOhI1/OhnandTypSsg6jNQKoEOWt4J5P6X4tvpqeg
         6JyB4QsF2sbsCPwHmRFMeTsJpNggSvokWNeka6XzSEIRPaYlTgjkHVGoPswrU2ptgGlr
         sCqTDqIbb0SWtGSxKpsDCJej0GEOyz+7iNpIdCk4wCK7MfEY3JqOHp0juOrh4Q4RLxe7
         sg/yaZrJJqgU0HmSp2xX54cfvgFqU8+7FCwSz1wxYGVyWNsFttailXyoPRJf/C/eggKu
         /PmKBZewdUm5wraItmILOImYQkLLPDhB2g05Byp4knNXgarDVmbI9WBUEwZW45uasloK
         6Aiw==
X-Gm-Message-State: AOJu0Yw2K+fXPnN3K74ddQiVP4G8IlbsJW7vJB+COVWxrSE1PTnDaCab
	hhLax9DQL8hMIH/kBwf45LlZafHIpzC+RVtMX1TpD99bzaccpPe+sUX/AIb3yA==
X-Gm-Gg: ASbGncv5EeQAEdk46vLWQXyh3tKriNWb1cwrG4rgmxOxvGof6+ktDeAEHsw+YIhwzcA
	n2xW0jkfiFy6sATNMq/mrDgn3AdUrYQpnESthCwvUNSpYoojCcnYIEKw453lu73FKfhQJFujiA9
	RO89PpUbZbvfmXW73EbOAQLez5JoEvr6UCGQCVgl1LaePcuGS5TP0SdWdyPWVecW+rjKY0vLZDv
	wehHNtX8VA17h6fa5oChh7qLlvArPjecAISBRql7uGt5uUFLDYsYgQi03bHcUKx22OjTOqWBq1+
	mZ/iVgf2/S0EPP5NygGpmoBtmDQZj0fINEN4+FfNho43Q3Qy43jaxtmt1U40OLdLSnK1i6YLrnf
	VwSfjSTONG5v0/Q1OZMJqbwfr9N+gZUz686ejfXQkcCpKz+08hx95qVHbv/86zc8NIUogQVQt4z
	de
X-Google-Smtp-Source: AGHT+IEo1wPXZ/x+Y/6HYovXARa8Uh30ioQSknmwNpEhXOl07PV1l90gpK4H2ZbJNV2xeGaOCpOUdA==
X-Received: by 2002:a05:600c:1908:b0:46e:4c67:ff17 with SMTP id 5b1f17b1804b1-46e4c6801cbmr76640925e9.14.1759236341955;
        Tue, 30 Sep 2025 05:45:41 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm22392586f8f.59.2025.09.30.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:45:40 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 07/15] selftests/bpf: test instructions arrays with blinding
Date: Tue, 30 Sep 2025 12:51:03 +0000
Message-Id: <20250930125111.1269861-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
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


