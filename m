Return-Path: <bpf+bounces-71322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D10ABEEC0C
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62333189A414
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F572EC559;
	Sun, 19 Oct 2025 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4l8hqtJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD7E2EB5D4
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904934; cv=none; b=m0DSB7dPA1Mzy3chi5833L6tTRSvsAfBUite9VzQx6G4QSOhpd+BXEx9djX2aQG/oSUro7g+yBuf96+v309JJhoSWczQQco3YTAYD8KxntJ8Ho4qF7qiOdQg9Obr1zn1DmpP5fiAZcGBg+lKhQa4u03bWhrRLtvTfJ3uOp2ARek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904934; c=relaxed/simple;
	bh=/R779rxMpaEFZpDO2t/0BGq9G02XmMFolHpjZXhB0lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FOoQpQ13H2D23c/dg5T1I9iaH4M650SqlT3SrNn0e85x28nm+oBaXSNmLjg1iYjhEM5hb6Vjutgh22MWrxT/oUMu+x0fnNxnIYTLQEw+SoNmbgllbdN6hg4zPcYuggjNsu1+1sdLsEDjgrwiJZW9RRtBnr7AfzLJJYrJ6uc2b3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4l8hqtJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471b80b994bso14665155e9.3
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904930; x=1761509730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abMdxTHz4mnM65Ksd/VEIUAZrfx+v2elsO+gicoW6G0=;
        b=P4l8hqtJvPWuLRlmq/RqD5GJoolkUhJdpfV14ewBERfSO/QDlCSIzJtJLWYjL4HoMr
         Ios7thDIpecrJyGJioQdlhYvJfoRf++GsE25o2L1eKYSDDKOqL+daloVtrf3I6SMiw6c
         Sj2TxdJKgYHrUPeycEoOPFwl7gw/PQxHoFFLZi8NHXsO1CWeubgErCaBWlkbc2nBAWJm
         8LUZRw6x/jXvl+jm1HcaPU8QEf38C7U5xCc5Sr7wrVywyKxD8e9mPMJiFsrm8h91BEdk
         K7lC751SAFpYQuYcw8de174iAwcRTrwop5iWQKmumN0qcKiKcmHc02dlLH+OYLQUSAzy
         a+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904930; x=1761509730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abMdxTHz4mnM65Ksd/VEIUAZrfx+v2elsO+gicoW6G0=;
        b=ebXklWUuWHJMkj/f89fJ6xfQAEAoWeyCYB2QRQJx8kMzeukN2lPUi7vemf6BvW38VM
         LyH8FM8+X6RKVT2zQ/gukA+b4RxAnWzqTv/8DcqMWVg2Wzr77SODH713zryAUuKj1k+x
         MkQbg1dKwh+cuRf/CzYCpeKoQvZV4+OKIjsUDl4y2yvX4DgFU+GAJeaau87EhvZ0bGj1
         hGXmPlYhFDjElPxy8BJ/bYGZgpcInpMsPpDYgmqpsEIZC6XdeusIfiW1qyaz+9V82ObU
         DRL9ygMvLYBgpWEaHNE4rnLgHDgpDBqvxc4X4N64WMkc49UfBRtOyc501ijBt9nzPaD9
         WBoA==
X-Gm-Message-State: AOJu0YxgazUVi1wm8GNTw3tKehj4CrYd8WRfVP2gV4y0ZvT4mS0tB5k3
	sj0JVU/9+rGns/vT/uWLdtTSqn32gjKE+3OrW3Hu3tIzp2yqDwAlF2VcyFem+w==
X-Gm-Gg: ASbGnctLc9SBv2nIIrByYpSJGK+9lnQZlOJEc556H9KpurHSrcNsQwd6P8bEJejxgZk
	6fGsqjJNPFM0wvq1A4szdF0+AJ6GCo+A1FQFipg0NMNXYQes0IKDY/0XNKpLr6Xu5efYCsaFDJ1
	C9QRzwooo/pQVyGTPtq/CvrXm/6rgf+b5Ix/V5DU/WlnuVw3JyEy1JzruIjxLu9s/WIvcZILDqe
	sOdOt1+Mk204haZ/pqqLdU7wxxvtHfnvHFGbiCK7qn9KaVyB9MjgAK13q6JwF0bKAEuRFDcST5l
	DY8rh46MOz+ZKNSw8BbJ0A83qmrZUbvuPp3kwpz8Y0hl3aO86wtDsR/xOsrDvfYy3MxMg9UGe/c
	txAoojTYc6MBsT/28THB5Yr1fw518y3cXFnB2VoKkVrugyOrir/+DKiM/J+gLcC96ZosLJPCt8s
	c6Y4byJ/t62TmL22JDZ1Tbkos6AIiLeg==
X-Google-Smtp-Source: AGHT+IE1EYHpy7s2Av1T2g8t3SeCRIwG1gVYjxA9RL1O+K8mh9idTyxI0L92gDe4XQpSQlok8Koblw==
X-Received: by 2002:a05:600c:444d:b0:46d:45e:3514 with SMTP id 5b1f17b1804b1-471178b13c6mr70832425e9.17.1760904929880;
        Sun, 19 Oct 2025 13:15:29 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:29 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 07/17] selftests/bpf: test instructions arrays with blinding
Date: Sun, 19 Oct 2025 20:21:35 +0000
Message-Id: <20251019202145.3944697-8-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
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


