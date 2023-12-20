Return-Path: <bpf+bounces-18411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8281A6B0
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 19:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BC11C23CC4
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835A5482E7;
	Wed, 20 Dec 2023 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSUfcDQ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04C482DB
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55333eb0312so3816963a12.1
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 10:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703095704; x=1703700504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmI/R2oaHsH2dMHFLeG1QRlQoXEJurQE2zCWhiGm1x4=;
        b=WSUfcDQ9EMI12KYvrJfejvMDENa80t31sWVDR5uPbGjhfG/I2abO441lqQJBhk3+35
         fzADZbzbBtRtWOYges0t0GXnQtLyqjK7u4I7ImIk79BYH2C18OQXIeOdKFslOtxAKEdt
         G7uADCi+bUdSzQRiKYa+YWq+FDhJ8pZNtqVQRF8fJtgF+byBOTrN/aOopUbgfr2yC5De
         qGDeDMJBITEH0HDVxNkjOlshire7GPqyIx6z/1pH1OVGtuaXWEWWOOu8GfsKZeNXaIxK
         CuujcLze/M6MOS1awJeRiNRyymmRNslrX4UxV+coxozinSOnoxYptkHU1X/kmaZ0QaId
         Zhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703095704; x=1703700504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmI/R2oaHsH2dMHFLeG1QRlQoXEJurQE2zCWhiGm1x4=;
        b=hoDOO83ozNJRWvL5yqXNSJ74ct/IizWuQrorcYg85ORWU5/i4xlrN8QMikm9HurU2P
         7ZGCVMJusMv/2SSuoZ2BEGfkAnJ+69vXQ5gxVuv639mf1j/PgByEpF7G3ppjxRfQzz78
         4qzFMsHAFnijoEkl73ryRvXRurb8Vec//ZHSR9x1vNK0W/uBz9pLdVGwTg1TQf529kdp
         QEHSIFkUKZCb9+Nnl2WyEwSkm544TBu9maKRGv9Xg7mHxqh4GFxwf9j8cgFqCYs0F4zr
         6BDPVeZxQsECmHy3OhTL2Fp4aIkxSaJKO/xNchRPVz7uweNaV9r87gsd/XoK/3K2xAuq
         vwJQ==
X-Gm-Message-State: AOJu0YzWnvOh4+8984NQ2glS8NfRQY3UDof5icFUFxIpHAYCfpzB/M8K
	omqoCu1y8/bDzUJN7SdgztpSZgmHnwIUbw==
X-Google-Smtp-Source: AGHT+IGYbQaRhzYinQawGpgicb/K7343H36tfJECelem3N4rTztqT0cN0vSjP/Mmw1DVPnCPkum4jA==
X-Received: by 2002:a50:8e17:0:b0:553:5648:ea36 with SMTP id 23-20020a508e17000000b005535648ea36mr3260777edw.10.1703095703676;
        Wed, 20 Dec 2023 10:08:23 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id b3-20020aa7d483000000b0054c7dfc63b4sm83786edr.43.2023.12.20.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 10:08:23 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	dan.carpenter@linaro.org,
	olsajiri@gmail.com,
	asavkov@redhat.com,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v10 4/4] selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach
Date: Wed, 20 Dec 2023 19:04:19 +0100
Message-ID: <20231220180422.8375-5-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231220180422.8375-1-9erthalion6@gmail.com>
References: <20231220180422.8375-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case to verify the fix for "prog->aux->dst_trampoline and
tgt_prog is NULL" branch in bpf_tracing_prog_attach. The sequence of
events:

1. load rawtp program
2. load fentry program with rawtp as target_fd
3. create tracing link for fentry program with target_fd = 0
4. repeat 3

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v8:
    - Cleanup, remove link opts and if condition around assert for the
      expected error, unneeded parts of the test bpf prog and some
      indendation improvements.

 .../bpf/prog_tests/recursive_attach.c         | 45 +++++++++++++++++++
 .../bpf/progs/fentry_recursive_target.c       | 10 +++++
 2 files changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
index 4b46dc358925..a0efac8560b2 100644
--- a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -190,3 +190,48 @@ void test_recursive_fentry_detach(void)
 			fentry_recursive__destroy(tracing_chain[i]);
 	}
 }
+
+/*
+ * Test that a tracing prog reattachment (when we land in
+ * "prog->aux->dst_trampoline and tgt_prog is NULL" branch in
+ * bpf_tracing_prog_attach) does not lead to a crash due to missing attach_btf
+ */
+void test_fentry_attach_btf_presence(void)
+{
+	struct fentry_recursive_target *target_skel = NULL;
+	struct fentry_recursive *tracing_skel = NULL;
+	struct bpf_program *prog;
+	int err, link_fd, tgt_prog_fd;
+
+	target_skel = fentry_recursive_target__open_and_load();
+	if (!ASSERT_OK_PTR(target_skel, "fentry_recursive_target__open_and_load"))
+		goto close_prog;
+
+	tracing_skel = fentry_recursive__open();
+	if (!ASSERT_OK_PTR(tracing_skel, "fentry_recursive__open"))
+		goto close_prog;
+
+	prog = tracing_skel->progs.recursive_attach;
+	tgt_prog_fd = bpf_program__fd(target_skel->progs.fentry_target);
+	err = bpf_program__set_attach_target(prog, tgt_prog_fd, "fentry_target");
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto close_prog;
+
+	err = fentry_recursive__load(tracing_skel);
+	if (!ASSERT_OK(err, "fentry_recursive__load"))
+		goto close_prog;
+
+	tgt_prog_fd = bpf_program__fd(tracing_skel->progs.recursive_attach);
+	link_fd = bpf_link_create(tgt_prog_fd, 0, BPF_TRACE_FENTRY, NULL);
+	if (!ASSERT_GE(link_fd, 0, "link_fd"))
+		goto close_prog;
+
+	fentry_recursive__detach(tracing_skel);
+
+	err = fentry_recursive__attach(tracing_skel);
+	ASSERT_ERR(err, "fentry_recursive__attach");
+
+close_prog:
+	fentry_recursive_target__destroy(target_skel);
+	fentry_recursive__destroy(tracing_skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
index 6e0b5c716f8e..51af8426da3a 100644
--- a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
+++ b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
@@ -15,3 +15,13 @@ int BPF_PROG(test1, int a)
 {
 	return 0;
 }
+
+/*
+ * Dummy bpf prog for testing attach_btf presence when attaching an fentry
+ * program.
+ */
+SEC("raw_tp/sys_enter")
+int BPF_PROG(fentry_target, struct pt_regs *regs, long id)
+{
+	return 0;
+}
-- 
2.41.0


