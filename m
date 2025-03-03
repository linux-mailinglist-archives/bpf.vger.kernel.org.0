Return-Path: <bpf+bounces-53069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE29A4C508
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B425E7AA48E
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB853214A9D;
	Mon,  3 Mar 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z51Dp6Df"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38872144C3;
	Mon,  3 Mar 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015395; cv=none; b=Hne3ljpHVk6JZKDU/UOdIU7mmxJz0R/c3VhkKccGsMmdU6FCcYT/RWevvSMIh4cXRHL9tPAwshDTIZpeCRgoTikduiCHzv1Xbgbu7y62l8JlxEaOYlp2mRlty2z/zpcgPSugVomj97qibrK0++I99eGqB1pF4goclDmQhE17ShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015395; c=relaxed/simple;
	bh=l+FzxzqcQOvCH8c5GurhKDmppajCdKyqii/WUkvzxT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIQTD3DBg1c1tvTNLs+RPA7dp3pIGtwPrymIgGlFNGfUIJSvDKbiOOv4Za8l5PUK/uZnyQgsYICJRvQb2bjZzH9Z23QNZEFI114e+VwuaM5E+Kf4cgUMo9jR9tD0rrpg+smC7EOaWL19OsU2eK0Vqq4s5Mwdl3j8bKD29vP7RxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z51Dp6Df; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so29222855e9.3;
        Mon, 03 Mar 2025 07:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015392; x=1741620192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4Fpzu6vEVBo0wCJhRUrT6eOf6iL8Bnn94ks0el4cwM=;
        b=Z51Dp6DfOVoMM2SZoNOnS7Y51ZJ5AiIM8lmnXn2DSEP4GknEP/eiGT8HomESgYohPL
         6d2YosDZjlp6I0NjUyey05jwGux6PNlAL0RgzhL79/ShLoV2afTLvb89LLtgkiJtSf4U
         D8yQln4/ti/H+ZvMwW/ORzdiVOcx29E3AfOM2Phs+eX0F1IPmEEu1jyxKYg/Ya/F5uqu
         bOvgsgrlQtGaWwmNFwXgFciavzLvbssm0sPM2VeVM1twHAaT6HSIt1B7RI50ZNQ9C/nJ
         SWA95HdnQnJS2aVb3ZoMz9RO0pqlREAgqfGbfYKUr0wxPh3xotUCqyDdxDCqnSx+tgO9
         ClNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015392; x=1741620192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4Fpzu6vEVBo0wCJhRUrT6eOf6iL8Bnn94ks0el4cwM=;
        b=OaxrvSj37OW5LI/2fiSlEImqa3atd9ZIM/WMtuwFxP7hqbWKYQghcXIYaPm8zLlxIM
         IYsqoYgNNI/DqzTq2NcMRZU0ywlmeOJjsI4T18hJYFzFP0QP1IJBBzq+/4eGiW3IcRa3
         VjmmhFXHWxINgsZEpepynIutEAlwVhOwkSBsNsvqm8rbjsqOGcj9BDDsYh2dqcIHeIvE
         bfei30ZZihPwTp5qBXiwk47xdNSvO+moJi4s5uwU6p7izixoBBqqCI9PruBDdzbmf3WQ
         7DyXSUv6tMshUjYuBsiIYwXi7huBltXALXkoD6cclmjT+BBK1iFYW4Qan9lokrFTfN/W
         kMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPYWbPPUBLyCcS639f8MTPs0BLRo0EK5+ooJkmDRGarVcc+rUzIbRMLe/OGYTD/P/mEqNLTc/LGuuu6KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA18NYncjoL4F4Fq4pWxqv29L2KegsakNoWp1KDyvwy97eii/G
	xxuK9xpPX7zJWzDhuUMAqd6sZi63jh3ptuw4z+M7ZKe5UrvMbAA9JSnmeYGPFYU=
X-Gm-Gg: ASbGncuSFvYJN0BiEQRQFGnzI6UqVda+et7UBRXsd6MBjtnt7+sGq5PkLJNVoxJTxlL
	TXvp9DSbeP6jZYiMjWNMg6KJD2o2TlzwLCOFqBvBUX3WjANeNfnyFkuVq5gYOoM7yPcWehLH7OV
	dOzr0g/e0Obs6yUidiutKYHSnac2SBf2nZMPrUm0gm5s3DIIrZjdoJ9kbazB0KZClxMZ0qUBfo1
	leEP/WdLwDNi3K/PI2gs4AKXdjL37VnAVbX84AwuDxOWCV5/Ax26DEjL1KkFIXqhi6ffH5KxN//
	Db1RIw2Q0Jaic5mSCpCcJXCXarw5ZsTg2A==
X-Google-Smtp-Source: AGHT+IGWe7AGIoZyzhIx4o6frHx+jxnpDfdaTig7kvrlS9c7aRLExKFsaeXCaLAhRyKx5jPukd6geQ==
X-Received: by 2002:a05:600c:4f86:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-43bca3972d7mr4843355e9.16.1741015391407;
        Mon, 03 Mar 2025 07:23:11 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f75ebsm164799315e9.3.2025.03.03.07.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:11 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 01/25] locking: Move MCS struct definition to public header
Date: Mon,  3 Mar 2025 07:22:41 -0800
Message-ID: <20250303152305.3195648-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; h=from:subject; bh=l+FzxzqcQOvCH8c5GurhKDmppajCdKyqii/WUkvzxT8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWVghejvu1V67bqXOIvMlrdiOA5EFuq9ml673Px YVwX7L2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFlQAKCRBM4MiGSL8RypodD/ sHpZiA9+maif3gXLaLeb6BTa8ziYYbNY7ZG6/NdOcNw/uV3egEUUzRRqjKaMmDsRtl8u3i8UuKv93i Jpn+XC/A+FwN36qoS13Atwe1+eFSD/ZK0b52m1Tgy5sHI8wLBe/eCop0B6+TdV+nqpCUG22mIxK8kL yxABesXn6haH0qjCe1WgAx2qbP15M5KLx2leHpzsbXkBjQN/URoZHzBv3oyjrWiFXXn0R1lS3yGOwR V3j3EA44LSwOtcKzHtFmZOPnzXP9h/VaWi9Q/827Uq8Q5YpRgAhsDHaBEinMJ6xrWKWKxzosaTM4qZ 3Kl57QWIF7hlmRccjfD2KGQDbup22QXtz34QHm0FjNknfyT3oVfUVoJ8RTYsXR4h6sIkAEV8mEu9Il 8o/qwNMFXj/K1a3Z2+hKs9CkXdftARzIiKNhnOLoZ6OcMybgSp86eS2StUIeegiSSPWCLSHJRijnuU wb0sFuJWRQ6eveZiG59om0uLPkO1knbSuAk+dkykWu5TmE9nKyt7WXULkN9Q6+rkG9Lkt1jV89MQEX 3sPA7uXmn3t9nLxQINGa3cpYEru6LaMTvUmeUSf5maMPLnh3CMlBYvFVMi5q2JPW9m7JyF1/sqOLrp wGbPN0FktYyVe186BbPjg+7BtvK8bU5OX0ZT5CupTYRg2a1ZfvVBTo+6gZnQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Move the definition of the struct mcs_spinlock from the private
mcs_spinlock.h header in kernel/locking to the mcs_spinlock.h
asm-generic header, since we will need to reference it from the
qspinlock.h header in subsequent commits.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/mcs_spinlock.h | 6 ++++++
 kernel/locking/mcs_spinlock.h      | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/mcs_spinlock.h b/include/asm-generic/mcs_spinlock.h
index 10cd4ffc6ba2..39c94012b88a 100644
--- a/include/asm-generic/mcs_spinlock.h
+++ b/include/asm-generic/mcs_spinlock.h
@@ -1,6 +1,12 @@
 #ifndef __ASM_MCS_SPINLOCK_H
 #define __ASM_MCS_SPINLOCK_H
 
+struct mcs_spinlock {
+	struct mcs_spinlock *next;
+	int locked; /* 1 if lock acquired */
+	int count;  /* nesting count, see qspinlock.c */
+};
+
 /*
  * Architectures can define their own:
  *
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 85251d8771d9..16160ca8907f 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -15,12 +15,6 @@
 
 #include <asm/mcs_spinlock.h>
 
-struct mcs_spinlock {
-	struct mcs_spinlock *next;
-	int locked; /* 1 if lock acquired */
-	int count;  /* nesting count, see qspinlock.c */
-};
-
 #ifndef arch_mcs_spin_lock_contended
 /*
  * Using smp_cond_load_acquire() provides the acquire semantics
-- 
2.43.5


