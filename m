Return-Path: <bpf+bounces-34864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20603931D76
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB046282B80
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 23:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92421144D09;
	Mon, 15 Jul 2024 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCmPOIb5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268813AA45
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084562; cv=none; b=ul/ZontTUu2Rwt/nQ6vm8GLcHqv4drnwg8t7OduQKHkGoU5KtULmqlsEIf2QFsBvSDRI0IuJAqbAZoraDn1SO/A3p6+slarHdDMOkydjcHAy1iZr/SjIfDuSn/qIW2kpNai3uh+OrZvCiPD5mzycVwuLFD90X2IVdFknVPIqx24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084562; c=relaxed/simple;
	bh=APg9O6emCXAGGjuLk1KItMYvtBnc/1l5qtVb5mqamqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EARmiANlndT8mzBEFqRLCfh2FqjXH+ZjydMtg579hUQP5vQiu/3CUvthsHA3d78oYSyEvTaA/5LRoXhIy3rnaTytwaqUDhXqQHKFL706EtJBHM50E5Wl7jDOIwIJGy6OEteuJmay9WIYZZpT6YbqNZS2Jfw+rv58rG9+Ly/NVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCmPOIb5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-78135be2d46so3612524a12.0
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721084560; x=1721689360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kOsKjJfIvHIToI5g7d4J3FIacvTfIMk8phPLkMiI5A=;
        b=iCmPOIb5qFYrvMLk+RtwfN6/EdfPXGTgUCoWtO0Pb9mm1s8PQuCFsq7v4w9SI1dW1T
         ckC5L1UnWlH71UlAt492qSPprA8Hx48QpI5cRiQBOSF1dBnrMa4EFVrVK10+n5Hz0eQE
         rIVkW3hUjf1MnDmFX7zN5LxBtqp/yfmbWr5svwRMKjdbMRMhjGXOx5rlGXpCufvo0LMd
         ZRu6Lg5jNtk8ugGsCCXavfhi1fN4HPfRXlsQr5h803a7zOWT6SRSaJVFNleYrjHepFNS
         AVdy6T9R3gWAPVvERoVdE7P16+Wj36DOaMqhowIPeJF7M3fea5ejTvzsjU27FyJ+gotV
         M6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721084560; x=1721689360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kOsKjJfIvHIToI5g7d4J3FIacvTfIMk8phPLkMiI5A=;
        b=My5KizFoRc/AAh+vajC+/i3AAUxhQa6IVkV4rL+L7J7C+9jBhXbDpBXeMHr+6YgdZS
         zyeDd7SZTRKDU7onhtnpJw9EMlrDhiViPEqHcodynIuBD3Dm1T8Eig7uDFEJIzBb4n7+
         bBXLwce5IUgSpPSpmxEjJ0g5rPFIjBBceweECZRVuzv7/8WYmDU59zbp60GQnUVcHTmT
         b2ghgrlGdlRxqm8IslI9Uw02sVPMV2GWNiukvy8/4PiUK3nA9AJaqRIDf0q8HXWpsjV1
         WX0C8w8b5vFhn229ROzQW7+A0ILrUe9TBuUAhYgP3XlkUYu8uqEwNKnKHaRlJ8rn23WS
         ML7Q==
X-Gm-Message-State: AOJu0YwpDQIva5nMXs4jNhidGQJpgPyqfG5DU2ele4YimCT9eLk+8aEM
	WAfvG+i61Vb/tUeS+s6U7CenyFDr2+rWbybiFHP44HZwTftMUFPF1Zq2dA==
X-Google-Smtp-Source: AGHT+IFp06INSDsZd/BcHaIYy2vMn+Vsqkt42YNWODmyiKxrT1LQtgeiVN8AexzOa+p6dJxJmPhgvA==
X-Received: by 2002:a05:6a20:4388:b0:1c3:b144:2ee1 with SMTP id adf61e73a8af0-1c3f12978f7mr487307637.44.1721084559672;
        Mon, 15 Jul 2024 16:02:39 -0700 (PDT)
Received: from badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc9d36sm4915344b3a.205.2024.07.15.16.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:02:39 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jose.marchesi@oracle.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [bpf-next v3 12/12] selftests/bpf: check nocsr contract for bpf_probe_read_kernel()
Date: Mon, 15 Jul 2024 16:02:01 -0700
Message-ID: <20240715230201.3901423-13-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715230201.3901423-1-eddyz87@gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that nocsr contract is enforced for bpf_probe_read_kernel() and
bpf_probe_read_kernel_str(). These functions access memory via
parameter with type ARG_ANYTHING.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_nocsr.c      | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_nocsr.c b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
index 84f76f850e9a..8b789f56c9e4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_nocsr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_nocsr.c
@@ -462,6 +462,95 @@ __naked void bad_helper_write(void)
 	: __clobber_all);
 }
 
+SEC("raw_tp")
+__arch_x86_64
+__xlated("1: *(u64 *)(r10 -16) = r1")
+__xlated("3: r0 = &(void __percpu *)(r0)")
+__xlated("5: r1 = *(u64 *)(r10 -16)")
+__success
+__naked void bad_probe_read_kernel_fixed_off(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	/* nocsr pattern with stack offset -24 */
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 1;"
+	"r3 = r10;"
+	"r3 += -16;"
+	/* read src is fp[-16], thus nocsr rewrite not applied */
+	"call %[bpf_probe_read_kernel];"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("2: r0 = &(void __percpu *)(r0)")
+__success
+__naked void good_probe_read_kernel_fixed_off(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	/* nocsr pattern with stack offset -24 */
+	"*(u64 *)(r10 - 24) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 24);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 1;"
+	"r3 = r10;"
+	"r3 += -16;"
+	/* read src is fp[-16], nocsr rewrite should be ok */
+	"call %[bpf_probe_read_kernel];"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_probe_read_kernel)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__arch_x86_64
+__xlated("6: *(u64 *)(r10 -16) = r1")
+__xlated("8: r0 = &(void __percpu *)(r0)")
+__xlated("10: r1 = *(u64 *)(r10 -16)")
+__success
+__naked void bad_probe_read_kernel_var_off(void)
+{
+	asm volatile (
+	"r6 = *(u64 *)(r1 + 0);" /* random scalar value */
+	"r6 &= 0x7;"		 /* r6 range [0..7] */
+	"r6 += 0x2;"		 /* r6 range [2..9] */
+	"r7 = 0;"
+	"r7 -= r6;"		 /* r7 range [-9..-2] */
+	"r1 = 1;"
+	/* nocsr pattern with stack offset -24 */
+	"*(u64 *)(r10 - 16) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"r1 = r10;"
+	"r1 += -8;"
+	"r2 = 1;"
+	"r3 = r10;"
+	"r3 += r7;"
+	/* read src is fp[-9..-2],
+	 * which touches range [-16..-9] reserved for nocsr rewrite
+	 */
+	"call %[bpf_probe_read_kernel_str];"
+	"exit;"
+	:
+	: __imm(bpf_get_smp_processor_id),
+	  __imm(bpf_probe_read_kernel_str)
+	: __clobber_all);
+}
+
 SEC("raw_tp")
 __arch_x86_64
 /* main, not patched */
-- 
2.45.2


