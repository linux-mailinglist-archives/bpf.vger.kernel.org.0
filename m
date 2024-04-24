Return-Path: <bpf+bounces-27759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707AF8B1697
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0BE1F2536F
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566BD16EC0F;
	Wed, 24 Apr 2024 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ5PO+YY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D5B16E885
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999335; cv=none; b=eDoJkmlHQShwsaX39Y3OHzsdrVE5wo4qjua6WO/FUgqD7WLXqh7w09Tj/p94Tt0lZWKYRPgJdcPaFClknAJ/6sNKYqXiWS8xc7i2LhfWh99mPVuoiVEMFcNiNalLHYPUpgOf7XTGyFqo/NlpnB8cVSWNyaY2TVW1F3dfbbwfBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999335; c=relaxed/simple;
	bh=tb1si4tbc3+2z8zqUHfUj9nNCPOxDzewa2cmnYJjYhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uci94Os37YOiBMiA7w8j4hvCAhtLTVH623BE7XYkkqx8vEg8ss9Wikze7x1Yd/0a1gZTDN8q1B7Z6xI3oDtLEu6Kmc3+JM0SsTnisP50N57VBkjRIvU9TTEFhlwOJ4LCdltutUiTlAEsOY8eUZ8IuhqSoC2rOZrxz+bAaewxBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ5PO+YY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f2f6142d64so408210b3a.2
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713999333; x=1714604133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYnDqmpduO94evVcf3wJXgszkYSXfNWROukJ7FfrxzE=;
        b=iZ5PO+YY2X9wdG4n4zArK9NH5Yc5IXTcM3AP6eViRpWDsdeVfgI41Fut990IIS/je3
         0vlXjqkKFwiAzHbzJHypxF2t7iZqzja3D002ggzz6ouzjwxG8AdezQJHEFrXynKqmYN/
         mLBkF7lqs+gL+miyy4HV4N+3k1h/0HzXGUtPvXOuLg4ZxjzHe9U0aThQMQbtn0qH0a+n
         QoA5jqg2byoRBkmQ4nAC13WKPjxPs59FooG/EaKkO72YtyTfwhkjLUiX5JkP6KCmX8V2
         7SGak72bwWKmedLuvhMjZXo7v/+y0+wKdjT0PAByKtLYwBHLAzJj91G41l0RHZkTMLDR
         EOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713999333; x=1714604133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYnDqmpduO94evVcf3wJXgszkYSXfNWROukJ7FfrxzE=;
        b=os22Z175ZbE9AQjRVwSdRzpJVmSWQ6onsGMbKm/ZErARnqp8ADAVl/2vkPr0zIv2iX
         zBrejT+mu5SuMELQhjAZ+yKoeq6HOrlHlMqUfvcfUQqfZhOhvoBMLf4Dr1b3DfrJOmIh
         JfqSxvnfP1zh9iCjHPJC0wQR23TREjLAk04AdjGLaGGD89z2gozNmb7kNgijQ/gvidX2
         zgtK28m4/n1+Mp1EocBdDoXARVEzXlISJMBNHZlch+R7y91SMTxr9ZDvWRx0bSU5bUVN
         OB6ZPi4Td9UVMoyviO0cfvurf4iyqzMIYvq9kd/C3/D5gWVa01i8nTP8Vi9PcaOaiGQt
         quSQ==
X-Gm-Message-State: AOJu0YzlESqAlDOKGqXzwf4UeOh/SlaTi+s3D9Pz+Zt5kVp+HXwjv6gq
	cbVjrrwgmC4lw3UJ9jab5VkDb7ts3eTSAgVhqWkqiRceaygJ1vqlwhxJWQ==
X-Google-Smtp-Source: AGHT+IEAIgp2WkZp+f95etx1h9ekzcxSGjsjTjQ9VmOeGWcOhlvluOooH3M4rnVj7rWroXshNMntWA==
X-Received: by 2002:a05:6a20:5524:b0:1a9:9825:a2d1 with SMTP id ko36-20020a056a20552400b001a99825a2d1mr4078393pzb.30.1713999333109;
        Wed, 24 Apr 2024 15:55:33 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::4:a1ce])
        by smtp.gmail.com with ESMTPSA id n13-20020a17090ac68d00b002ab68ce865asm13029455pjt.9.2024.04.24.15.55.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Apr 2024 15:55:32 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next] bpf: Add bpf_guard_preempt() convenience macro
Date: Wed, 24 Apr 2024 15:55:29 -0700
Message-Id: <20240424225529.16782-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add bpf_guard_preempt() macro that uses newly introduced
bpf_preempt_disable/enable() kfuncs to guard a critical section.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 22 +++++++++++++++++++
 .../selftests/bpf/progs/preempt_lock.c        |  7 ++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 93c5a6c446b3..8b9cc87be4c4 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -397,6 +397,28 @@ l_true:												\
 		     , [as]"i"((dst_as << 16) | src_as));
 #endif
 
+void bpf_preempt_disable(void) __weak __ksym;
+void bpf_preempt_enable(void) __weak __ksym;
+
+typedef struct {
+} __bpf_preempt_t;
+
+static inline __bpf_preempt_t __bpf_preempt_constructor(void)
+{
+	__bpf_preempt_t ret = {};
+
+	bpf_preempt_disable();
+	return ret;
+}
+static inline void __bpf_preempt_destructor(__bpf_preempt_t *t)
+{
+	bpf_preempt_enable();
+}
+#define bpf_guard_preempt() \
+	__bpf_preempt_t ___bpf_apply(preempt, __COUNTER__)			\
+	__attribute__((__unused__, __cleanup__(__bpf_preempt_destructor))) =	\
+	__bpf_preempt_constructor()
+
 /* Description
  *	Assert that a conditional expression is true.
  * Returns
diff --git a/tools/testing/selftests/bpf/progs/preempt_lock.c b/tools/testing/selftests/bpf/progs/preempt_lock.c
index 6c637ee01ec4..672fc368d9c4 100644
--- a/tools/testing/selftests/bpf/progs/preempt_lock.c
+++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
@@ -3,9 +3,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
-
-void bpf_preempt_disable(void) __ksym;
-void bpf_preempt_enable(void) __ksym;
+#include "bpf_experimental.h"
 
 SEC("?tc")
 __failure __msg("1 bpf_preempt_enable is missing")
@@ -92,8 +90,7 @@ static __noinline void preempt_balance_subprog(void)
 SEC("?tc")
 __success int preempt_balance(struct __sk_buff *ctx)
 {
-	bpf_preempt_disable();
-	bpf_preempt_enable();
+	bpf_guard_preempt();
 	return 0;
 }
 
-- 
2.43.0


