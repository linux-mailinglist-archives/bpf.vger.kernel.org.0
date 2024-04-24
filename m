Return-Path: <bpf+bounces-27611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B828AFDD6
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3450F1C2246A
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 01:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7EBBE4F;
	Wed, 24 Apr 2024 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1jL1YBo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EB6FC2
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713922131; cv=none; b=uAg4WVj+GXyvphIBYUTzcgBpUuFlfqoY2lL9wEk/BZm9dowxPQVhgr9Ijw6XA7zXm0nBqh44MwSdjoWm5o6PmfpxP/JGWxacI9T/J6VS3jc7fWiDYk67paVev5Nd695jWJv/MF4GdqC8cem9hUxfIvk0tE0hB6gLBFHH4kvN/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713922131; c=relaxed/simple;
	bh=Nwkgt3kRLR7hbWESbpleJdPHGyNN9y3gJVWWefNDWEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BS1kKStnUbgxbLclU+8DWR0Vp3c8L9dC/nZixbqhZRLWl/eUrCn/LfohDhmGr7NAodBsnF5iZBc58uuR5i9nRDzY9GsXR+3k4JVzqTQaTqqjCSFa82dHnFwV736SfiLIQngqr4AXUjfoUUYLxPr5RRDsox/SFyLTXABLFNn5iUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1jL1YBo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ee12766586so369643b3a.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 18:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713922129; x=1714526929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGom8NiuBuJrUn6+QQCpbHJYsvp6s+pmTnv9noWy96k=;
        b=J1jL1YBoO7mp1TYmKuT+Q9rZtAudP4bSxuAURaa2tg5IbJFUm4dthUJnArqvDZz1dP
         gCaK6oO1KPe//k70lCfkCt/XM0Zsmpz8ez0qUG3h6R6eBl4kI/d9ZdiGFdK1F0f+fB92
         Q6BUpA08Ao4Zjjaql8ilhYFx9stNkRhK/a7YUJBLQVhjQxfpt3FSGyaRT0YIJCGTQ0oN
         iqUDKgUTwLx63oVOJwNwkTGB42resW7EAvsjEf1bPr453OGwKMgwRLMl9rv1dA5RuQRb
         6uPeNTXqa+aHLLaXV4xPoDHT053rVMUijvYVQgRDY5tepaYwOZxQucqtQ4F3FmXJE3UX
         I3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713922129; x=1714526929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGom8NiuBuJrUn6+QQCpbHJYsvp6s+pmTnv9noWy96k=;
        b=iLNwrUbQXIT6HYBnnYIPFeVIZaf/9mJytYuJ4aRTGRUBqVjM0tRRs9b3Guf56zRABg
         vDr8F/Wx81VfBQ6ZBTDLMAyxF4gpIDS3BNwAMv9nLYUOItPlH1Tccc9NZd22xRiOf4br
         fWmRRhcQ+qKYXgUsv/bSu/wxSwYKPSHbxQAR2C9FdAdUTbXiPDDJw1zdFia8jnorrjSg
         tbPKHdHfcSNxcRfVqS5oul7WtE3MAbaOhZ9CdhC6DQbl42DUXADd34oM4y9t0xJZb2LG
         5/DL97UQfzmcIUydFdOrQuxFoscw/X2BQ2qCFed2ebsVvo9mb2Xv0ZsZ7BPJhz6eOF71
         Obdg==
X-Gm-Message-State: AOJu0YyGSpMEX+utowCYd28V3+zGACirTF4UR8nbDhJ/eaC1vo7Hqd8r
	l5PvcN28wtVjYSolgpV6tAK9VcXm3qZ4XRcPz6ez5eVdmm/kjpHxY4Xheg==
X-Google-Smtp-Source: AGHT+IFSOalnDEKncN+1ptDFvmrUKldllCQ3osF0i1Vpbh/m6VsxYIi+OhjsEZvu9aMFnsIsKP/G4Q==
X-Received: by 2002:a05:6a00:2283:b0:6ed:5f9e:39d7 with SMTP id f3-20020a056a00228300b006ed5f9e39d7mr5681482pfe.5.1713922129247;
        Tue, 23 Apr 2024 18:28:49 -0700 (PDT)
Received: from badger.vs.shawcable.net ([2604:3d08:9880:5900:1fa0:b3a5:f828:f414])
        by smtp.gmail.com with ESMTPSA id fk24-20020a056a003a9800b006ed9d839c4csm10271007pfb.4.2024.04.23.18.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 18:28:48 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	jemarch@gnu.org,
	thinker.li@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/5] selftests/bpf: adjust dummy_st_ops_success to detect additional error
Date: Tue, 23 Apr 2024 18:28:18 -0700
Message-Id: <20240424012821.595216-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424012821.595216-1-eddyz87@gmail.com>
References: <20240424012821.595216-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by Jose E. Marchesi in off-list discussion, GCC and LLVM
generate slightly different code for dummy_st_ops_success/test_1():

  SEC("struct_ops/test_1")
  int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
  {
  	int ret;

  	if (!state)
  		return 0xf2f3f4f5;

  	ret = state->val;
  	state->val = 0x5a;
  	return ret;
  }

  GCC-generated                  LLVM-generated
  ----------------------------   ---------------------------
  0: r1 = *(u64 *)(r1 + 0x0)     0: w0 = -0xd0c0b0b
  1: if r1 == 0x0 goto 5f        1: r1 = *(u64 *)(r1 + 0x0)
  2: r0 = *(s32 *)(r1 + 0x0)     2: if r1 == 0x0 goto 6f
  3: *(u32 *)(r1 + 0x0) = 0x5a   3: r0 = *(u32 *)(r1 + 0x0)
  4: exit                        4: w2 = 0x5a
  5: r0 = -0xd0c0b0b             5: *(u32 *)(r1 + 0x0) = r2
  6: exit                        6: exit

If the 'state' argument is not marked as nullable in
net/bpf/bpf_dummy_struct_ops.c, the verifier would assume that
'r1 == 0x0' is never true:
- for the GCC version, this means that instructions #5-6 would be
  marked as dead and removed;
- for the LLVM version, all instructions would be marked as live.

The test dummy_st_ops/dummy_init_ret_value actually sets the 'state'
parameter to NULL.

Therefore, when the 'state' argument is not marked as nullable,
the GCC-generated version of the code would trigger a NULL pointer
dereference at instruction #3.

This patch updates the test_1() test case to always follow a shape
similar to the GCC-generated version above, in order to verify whether
the 'state' nullability is marked correctly.

Reported-by: Jose E. Marchesi <jemarch@gnu.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/dummy_st_ops_success.c      | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
index 1efa746c25dc..cc7b69b001aa 100644
--- a/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
+++ b/tools/testing/selftests/bpf/progs/dummy_st_ops_success.c
@@ -11,8 +11,17 @@ int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
 {
 	int ret;
 
-	if (!state)
-		return 0xf2f3f4f5;
+	/* Check that 'state' nullable status is detected correctly.
+	 * If 'state' argument would be assumed non-null by verifier
+	 * the code below would be deleted as dead (which it shouldn't).
+	 * Hide it from the compiler behind 'asm' block to avoid
+	 * unnecessary optimizations.
+	 */
+	asm volatile (
+		"if %[state] != 0 goto +2;"
+		"r0 = 0xf2f3f4f5;"
+		"exit;"
+	::[state]"p"(state));
 
 	ret = state->val;
 	state->val = 0x5a;
-- 
2.34.1


