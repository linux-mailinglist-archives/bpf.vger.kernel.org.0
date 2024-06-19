Return-Path: <bpf+bounces-32550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7145B90F9DE
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 01:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113D01F22546
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 23:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDB915B55C;
	Wed, 19 Jun 2024 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDZLprZJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C331E515
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718841247; cv=none; b=SycJEw8KLexdhn5U0qzQLv3z01raJp9XBaFcb9DVY7Gpdq6d1FJUspZROty4nU9iLaj8YGq9++c1P4Q5LEyDwZrIvPeUGXCPb5/pVXGDcpEAjQkljhyNdrWxwoBckCRr69gVCWI9IiW4OfzumUYeSFoBEqchjKnooDcMStnq8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718841247; c=relaxed/simple;
	bh=Z8djsL0SKhP4c4tKJCrjk3F0zuo6gm9FVyhsau3KR58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dGKpJ9MS7Bg+yKlLRa/NFF+xuf9UZEDR4A1vX8qCnRV7LQAUHdUC1VtoW9HQT59bDm/zzdASshouGv9pn6ROXKNVrjKLFbKqg3f1vhUbfY0JeXDrdJPdssR0irZgJbRf4eVF031RjuvEZUnJRU/6zctkTwWRu8tWjqgW9e7a2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDZLprZJ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-250c0555a63so185258fac.1
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718841244; x=1719446044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5JJu2dafBvk/HJ+QMt9Dgtrjoj/dCrS1cyMgn8mtIc=;
        b=RDZLprZJ3Lzg5zgxoOetbmgD2gjUJR+Xl6K/0jfWrbH/DJtGMVN1BmLSHrLg+V9eb0
         uHk0mNML/z0VnGes64+HwRMK2BV+xD3nx1Ym25mfwvd/HQKRd7/3rs3e5H+9WiQVVJ9M
         ML99FHNvX4YZUPiB5rhn2sdXcyX4PkzeOGlHVmpcF8bbSspnM/1RUChw6sDddsvLnhcN
         rVQh1avC2IYvMlBpl2py2l+SjnB2QInAA5+SMU4EVngUNmDppSYX4JkX7yhZ53R9vDOY
         qLzasxtkunS/aQqvoEnpPZxSONyCKrWeXAx7Qg3bCIKsKjN/sH2RXDtFMYRcxMkArWd6
         XC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718841244; x=1719446044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5JJu2dafBvk/HJ+QMt9Dgtrjoj/dCrS1cyMgn8mtIc=;
        b=kfNepIqr8o8EEmPqoctcZzeybbmqZ9HP7q1ON06oTLX9oMyRGDlCMxfF/rci8vACCA
         8pZmOAMph89WeZIPdrkvLS1e6YZS6bTJcji3SbdG/O2EHtjuv3n2Wb8V4nGbgaCBuefQ
         I/7JNK44JKxp3uKQkrRFqkqfpuPU5kiZBx9sJeqjgnrDTXEzYzNKC8DzuOn4yIdCQ/er
         d55+CV1i7aBWcfnLCO1wuaS0OuKbYurJiekX3ph+9EwLYyjVzOkBA1Mue5Rh6SGol/Yq
         521iWBDOFRhfTtbz2goWc0juLNYtIInBrX5QFxMjUlfxAr60SG0r41VxewHYQmpfMXZ1
         ZyOQ==
X-Gm-Message-State: AOJu0Yzk2nQzGJ0G6u1U4xVULB42pt8mv8YtwOQXdy1ZalXMoQaGwist
	KWSM3LVR67Tz/34yMSmKLg1mPZAa9CZxKmlYvTbodCjEvWF/U661EODfPQ==
X-Google-Smtp-Source: AGHT+IF24s/WqD8Us5YubPH5LU9udWTuq4OXdleu9Fe7mMUWPOw5FpNgKX0q5ogAgYyiKcw5JO6ewg==
X-Received: by 2002:a05:6870:e412:b0:24f:f45e:5541 with SMTP id 586e51a60fabf-25c949a6ad3mr4719533fac.24.1718841243522;
        Wed, 19 Jun 2024 16:54:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:7a04])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc988700sm11576350b3a.91.2024.06.19.16.54.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Jun 2024 16:54:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	zacecob@protonmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf 2/2] selftests/bpf: Add tests for may_goto with negative offset.
Date: Wed, 19 Jun 2024 16:53:55 -0700
Message-Id: <20240619235355.85031-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240619235355.85031-1-alexei.starovoitov@gmail.com>
References: <20240619235355.85031-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add few tests with may_goto and negative offset.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_iterating_callbacks.c  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 8885e5239d6b..80c737b6d340 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -274,6 +274,58 @@ static __naked void iter_limit_bug_cb(void)
 	);
 }
 
+int tmp_var;
+SEC("socket")
+__failure __msg("infinite loop detected at insn 2")
+__naked void jgt_imm64_and_may_goto(void)
+{
+	asm volatile ("			\
+	r0 = %[tmp_var] ll;		\
+l0_%=:	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short -3; /* off -3 */		\
+	.long 0; /* imm */		\
+	if r0 > 10 goto l0_%=;		\
+	r0 = 0;				\
+	exit;				\
+"	:: __imm_addr(tmp_var)
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("infinite loop detected at insn 1")
+__naked void may_goto_self(void)
+{
+	asm volatile ("			\
+	r0 = *(u32 *)(r10 - 4);		\
+l0_%=:	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short -1; /* off -1 */		\
+	.long 0; /* imm */		\
+	if r0 > 10 goto l0_%=;		\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(0)
+__naked void may_goto_neg_off(void)
+{
+	asm volatile ("			\
+	r0 = *(u32 *)(r10 - 4);		\
+	goto l0_%=;			\
+	goto l1_%=;			\
+l0_%=:	.byte 0xe5; /* may_goto */	\
+	.byte 0; /* regs */		\
+	.short -2; /* off -2 */		\
+	.long 0; /* imm */		\
+	if r0 > 10 goto l0_%=;		\
+l1_%=:	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
 SEC("tc")
 __failure
 __flag(BPF_F_TEST_STATE_FREQ)
-- 
2.43.0


