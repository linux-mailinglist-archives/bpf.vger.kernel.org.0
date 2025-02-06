Return-Path: <bpf+bounces-50638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B8CA2A666
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409EB167CB2
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A322CBFC;
	Thu,  6 Feb 2025 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSuA37w3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB62922B5A1;
	Thu,  6 Feb 2025 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839287; cv=none; b=eFPcQS+MTuLUNFGRy+ex+C6ZoCkHQicxrAQjps0E+9+/LJ2pHM1GSf6I9zGYbhwGSJrG0UFIB+R6O+EGNQ08O02dmKOKZflZVGxlig9N2aVMWY1uz2eD+OHoGeGqs2Jakxa5xJR3XbKRPqZ9lo8igxu64tifltT028uts4a8RNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839287; c=relaxed/simple;
	bh=AVuKKIzjLnum/Q8Jp3BllOKRS5yuVDUgY1U4pKev08I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1c2adQ4yiI4nBEZHB5N+Se4FILwXXpw9N6iES/lhYJmXb59PI5WR8LrmLBB/UHyzNDbkNH20mfwepgIZJKXM2kYQnIESupkcl0+/Ytr/1Gqm0vc+aOvnQWk5dPZdgjLVgJnf1IoK36LtiiXMqR5xOGFtYRPPTY1pphKkFdmlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSuA37w3; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so349100f8f.0;
        Thu, 06 Feb 2025 02:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839283; x=1739444083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joZkmdV/dAzLK1UShpkitp+TG0brsNHWZrt+dWRUiK4=;
        b=WSuA37w3iQ+yB/rwMCM+67sVm6lGfW45a51GseFHpNXoOKH+Jo0iHT4g7IAlNbePQY
         5nw2WQ6egFILejeK6r/gfw+4LBSxXlOTkawXRm0fBsIlfRumKtRjGPEu6YhCAtC0mz5C
         mTg2jpQ2Mtm1oPZSRaKGHIajFHdzK9yjVoo3lc/DE9Y5P7nDLd2VL3wxJOBesACZC3K5
         dXVeJvymHqddqAsoEfkVlpcLIPLBjLmkVV8lFnlmPCfanpvPkL8Dnju6IUArwQiFr5EA
         SoswNGCtMaF2emC6/h6hYUXnCyb5jIrAnZERKcC8h2jLB2vIRFi4ODL1Xb6uJu8wtD4m
         wphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839283; x=1739444083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joZkmdV/dAzLK1UShpkitp+TG0brsNHWZrt+dWRUiK4=;
        b=Rx5rGPDBpKDuHZU0oMxodgw++mI7/b167yVTx+r7bZkQ8AHq0n9ooNrqbOWj89PvBt
         oxVIafCs+EdrAJji5tqfVGoFr0qF3xHWcM5da+z7nRut8Tq0oe4wHmKaCAtdVIWAFPHE
         SReBlY7pG7HOAPQFdFl8VcbbPkkY76yixtE6T9e3VV5KIVaebZ3y6I75846Iz5sJ107h
         S6PfdaV9yf/XdX9taWrR+e5VWwzvjnseowlJs4Li2JG2zkRXh4kSYaakJj/QXr5hX5WY
         vxjDr/48U/4gzSAoKx+iJY9SnOKaxruD6EnZTRWuB/DYxEwLjsXs6n8lsdNM+rwmC5X8
         WNFw==
X-Forwarded-Encrypted: i=1; AJvYcCVVrNQc/NYRgD5BuyVtQxKsjGYJRjRP4mZVHlywPHdl/ZgdIlycgqiMO2/97V/CCr8K3wdtQgH7UcjnNrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5h/Q6r2gVqgTBU3FCMKtHm7UgF4d4qijOMlV8XkogGhAGflG
	cQn55cOOtAq/pSIyvWs3rcPVPkmVlAu9mTYLvXl+5BhJ2qhJlNrMDvq0UL1ns8g=
X-Gm-Gg: ASbGncutHC0avuJEaSpzQDw9WESpi/m2SWCpqtUCyEibuMUWwotuMN6xOLWBPT3V18h
	PB/7rQv/Z8SDKS5TxzdENkMrpPFicg2MKunqOFO3CCDkpsEeUsdhsOqGpt4UT/AJTYki6EF5T+7
	L81snTGeu8naqYbn8sb5Bo8npLL8duyIakfJFpODrtS3P95j2yIxWy70G8DnIQzSCdb+QLadUO7
	AGGUJVFEnNNaEgVng5XN0PCL9GOdFw9v8uKDJ/0MXK8x0YqUHw6P1ejjq2TWP2QT2kerFfXOkbV
	p8Z7vA==
X-Google-Smtp-Source: AGHT+IFy0RXuexUHa3kfjyL19mkyb1nAWPyntJqslgT3n34npIvK+M2FW7T6Phh8AkNO/tuBPU7EAg==
X-Received: by 2002:a05:6000:1886:b0:385:db39:2cf with SMTP id ffacd0b85a97d-38db48b9e8emr4235856f8f.12.1738839283504;
        Thu, 06 Feb 2025 02:54:43 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1d::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd35e9esm1390719f8f.25.2025.02.06.02.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:42 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 05/26] rqspinlock: Add rqspinlock.h header
Date: Thu,  6 Feb 2025 02:54:13 -0800
Message-ID: <20250206105435.2159977-6-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; h=from:subject; bh=AVuKKIzjLnum/Q8Jp3BllOKRS5yuVDUgY1U4pKev08I=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRkAUSLUoqJ61KHJqVww5VkHo5XuLe/f7xDpkMh vShNwMCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZAAKCRBM4MiGSL8RyoE9EA ChWskn+IPkSTn/DMBwsfvx6EWqIgzdLCOdPnNCPTWMG8F+qUgNrWq+hnY2AEcF0ceG8KE69wHJ0cLI VBN9DG6qMLro8x1voPjPdK+aL1HAKDexxzJsUGqXzwcJ7tvBu+6aJto1dqMnI/iAjErkVXhTfeeDnQ HE8Vc8ft+nREngcb+k2A3S+vnI7cNgZyEtUXn3mX+4C1e0siL9PCKWRbCj7Dd8CIyhr+I6iVZdwGNy fYfSZBupBuq5C4yvcYeJ8shIaV3bkO04VogVyYLEi/QVP8pKyI8R+EBtKWqigsXI6383C8YLtrbQGd 6GU/QIqvFWawk/4RAnRUbHrfbE0pEX9aYKhgNEqv6/kqUCtYlJg+UsJtP63tthsVPkwsBYSzNyoHbB 0DutHelI8e77l5BQjjBxlxrXXTwKwflGFaPet1F3lFUu5Cq2PuJNvOGpz9xnFAi/8jxZY9QaxMKAUg Xr5iqvWwjk83bjYdoRMl/jswMGFWaFmpSrDUvrXM43JJVq/Jip610cxzOu92F+nVn1lWFbMEC4Bpva mhfxqax6cnPG6vhnjpN4uowxGnWFTJUwdYsICJWIXeHdbiXs3WJOtEvcwisb0n3r1F6T8NtLM+7Mdu KrBmyKQ6ZIowge2wnwHfNovFg8fEt4LhwMndrwjiFM78K91D7w+iuxRUPVLw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This header contains the public declarations usable in the rest of the
kernel for rqspinlock.

Let's also type alias qspinlock to rqspinlock_t to ensure consistent use
of the new lock type. We want to remove dependence on the qspinlock type
in later patches as we need to provide a test-and-set fallback, hence
begin abstracting away from now onwards.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 19 +++++++++++++++++++
 kernel/locking/rqspinlock.c      |  3 ++-
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 include/asm-generic/rqspinlock.h

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
new file mode 100644
index 000000000000..54860b519571
--- /dev/null
+++ b/include/asm-generic/rqspinlock.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Resilient Queued Spin Lock
+ *
+ * (C) Copyright 2024 Meta Platforms, Inc. and affiliates.
+ *
+ * Authors: Kumar Kartikeya Dwivedi <memxor@gmail.com>
+ */
+#ifndef __ASM_GENERIC_RQSPINLOCK_H
+#define __ASM_GENERIC_RQSPINLOCK_H
+
+#include <linux/types.h>
+
+struct qspinlock;
+typedef struct qspinlock rqspinlock_t;
+
+extern void resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val);
+
+#endif /* __ASM_GENERIC_RQSPINLOCK_H */
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index caaa7c9bbc79..18eb9ef3e908 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -23,6 +23,7 @@
 #include <asm/byteorder.h>
 #include <asm/qspinlock.h>
 #include <trace/events/lock.h>
+#include <asm/rqspinlock.h>
 
 /*
  * Include queued spinlock definitions and statistics code
@@ -127,7 +128,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-void __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+void __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	u32 old, tail;
-- 
2.43.5


