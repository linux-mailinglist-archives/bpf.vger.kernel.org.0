Return-Path: <bpf+bounces-54120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D2DA63388
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E6F7A7ECB
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126116A395;
	Sun, 16 Mar 2025 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guzslKKp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E98A15573A;
	Sun, 16 Mar 2025 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097953; cv=none; b=DiWsiQKSHsXW5CvSqRPX4v43VqODcEE+P8dufg77Haw9rwiyHeo4bh9i/kXzHQEGO8pQqkGLxD7s2mrA+PNqwf4mMfJQPI7vQc7FlY7VLCV3OqnTXr682zdWJGA5wL9PFW0Vb9nG/Ss7+b4YTpKHlsvJsJe/E/Y8ohnj8bxs7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097953; c=relaxed/simple;
	bh=J879+EgbuyTebrgMR7yNECE6EUzDiFxlkQMxluMZnf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcFM4GiCc0JadSDugiMlvK7F7pPY24w+K5NNQAwtUojAIksl4hfGsSpxropqz4HJ8ayV8XeenKzYCy/+RYDdGU1IQiTihzW7E0mhryxXVkWeqBmRtPrxdZgEwSsi35ic8t0XHcRcbhEb//jN1B3K7KVJxHtR0BwaJVFU/HdU0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guzslKKp; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43cf257158fso5957155e9.2;
        Sat, 15 Mar 2025 21:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097949; x=1742702749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beVjeo/VucQmznYM//yRk+lY9Xj8BUazd5x3dTjfvms=;
        b=guzslKKpD/S/oyM/P+cmWuUldUn3bf2RKdlHNLZsMCfENb+1ya309XsMmLmLpwKL6q
         QQpZbAMPDfgLSBznaX3aQ4IOZOGFuggmMq6k3aziK2JFdSrxkcBqxgzIzX0X5+91PQxR
         e/XpPXK9Onrn4QP07FkreS0JpF5o0GE+yOBLQ8AH2KoOCiGdMyboIJsE8rT8b7MVheaq
         +xFtsynhyPDHz1cu72CC5q5+pO0NUWUUQB6GuTdAlOTyraERi285q149HOv8mkoVkGp5
         BGUCcd4ojKwq00XtaX9h4HE7At/xmlHnaIqKfgmtnLTi5kmBUVsqOjDn+hGHaNGi9hrn
         Sy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097949; x=1742702749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beVjeo/VucQmznYM//yRk+lY9Xj8BUazd5x3dTjfvms=;
        b=fcjkPTY0QXo0bXlQGYL5c4HQJOdGDA2k4UUcWRJI1AQTgu9aSWn3AetVztCNLf2988
         2V0R4sxeGA5sC/PsASM76KDOml/5KziU1UX+iCadJBs8GJhuPMgwF6Ux9l/fngjdhOzW
         rhVpelmfLyGjmJ0rtjaDOY2Hh91UugrYaQuc/1Rd0lXUHub0W3B2FmJIuIPNTExA2Rme
         aY+ku9C8iNfaK/WDtu1xcsDU2pfqig2TjTx94lHLrNg6IwZjiFLsZhCnIM4Gqh2uBAcP
         StL2YhzjtWAWzMnGgA8oHh7/wFon+6rRjeT5Ekf6zcA5jRBjdpY3z3T4ob7Vf+8CLjzz
         8Jiw==
X-Forwarded-Encrypted: i=1; AJvYcCU/wIomca8YGLtrOKLJVYTkyBPujesrNNuSNvypFvjOXMddznBpdULY6nXP5GHe4pM1AHJg/HjphrT/GZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2Uflv+KPRvks2A5rz5HXrQzv6ss+zqvdg6GPz830dIgV3QYW
	BkUjpd6VfnkO/pfwII7UIAGemhaRiQvj/8zkec6nNao8D4dALJua7f1RBY+oIjk=
X-Gm-Gg: ASbGncs6gJdzNLHcOMcLV9vhWpED2EWaoc27eP1JAXgNUL5S2KrcckpSELQ2v055Qu2
	+UnrcbUL7YvzNFxnKmGRUZIn1GCx1jhHFMsv4rO8wN8i4YVIQtSYFk+UomDb6iLBpm8SaWQ6R3J
	CaWWfm2Gnhh4RXzcLuEvKOufmAqlElBYkqcX/eXjt6qLq468AHBUWHHJ1BA9aKfmpt2cU/Jwny/
	CztWBa1Jb8lA3FMh2rGfbwcLKg9Dvf5i1LPB80OuqjaOgDixZPXGM3Zc1Akb+Py55sg+grb86nQ
	aYuba9DRb2W3cjZVKZ+9W+INsp7iuEYreg==
X-Google-Smtp-Source: AGHT+IHr2XBo0Zj7lg7uqlYGSFDV9q6POPhHGxARC6AThdf9jY9aY0L+6DWSNr/0NWU8352lQtntYA==
X-Received: by 2002:a5d:6da3:0:b0:38d:dd52:1b5d with SMTP id ffacd0b85a97d-3971d03eeb0mr7839110f8f.4.1742097949466;
        Sat, 15 Mar 2025 21:05:49 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:9::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60b91sm67303265e9.31.2025.03.15.21.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:05:48 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 05/25] rqspinlock: Add rqspinlock.h header
Date: Sat, 15 Mar 2025 21:05:21 -0700
Message-ID: <20250316040541.108729-6-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286; h=from:subject; bh=J879+EgbuyTebrgMR7yNECE6EUzDiFxlkQMxluMZnf4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3b9elCAd3YQ236M81hMVLjSuOppZtbhch+VA6/ +rsNVFWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN2wAKCRBM4MiGSL8RyshkEA CCv98+4lY1p9/sFVO0M2tPH7eTtOTASKJhakQbPqh1VQV36TyCzSaQMxrKctCpN8C7owWTC01bHGqc uI+Z9UudyPSj0Cm7RYxCrP93Lb3Uayvcj3YxfZ4ECgMrBwLS3EOpGMhRJd60Dcb6XFtUQOMUQvrve4 cuGnRz6yfsa+vQNLSW1t0H2BODbKRzlFEu1WGD42YiEzjN4knrh/owAlZ1Av8cUPJpxMNzueQASucb eGyQ18wsYNVZjVcc/wp4dif0cQLiLc7c+6E9bxeuTzbgRHtAxzROq9WCxfhDOPYLlZe5m/aFW2HojL 7ilY58wpGW0Rhs3XUzv4sGUT9tj3GcDBl0dm7dPpLB4d0JrX4YkowIj4b/07SIASKj3ovG7wFW+o0m 5qe+QjTAhKQ1RgSIfkCaRVQGQBhPFqBL5Zf1/JTJ1VmHf0uuxx8/7CvgRM+p5KETo8myeIC5Tt9//M B+5VUrfWUAdSF6KWRzKCTFpqBHuJS6T+4JbZX2he0aHaQZOHxX2qn3lDC6VzuHL5BR5XX5LdizGzBV f/EiK7VPNweuCM6BurIbBqvfKkiq86dQe15jvoRriwpQuGOlaOaeUayhNQDPOQpAlufShTTNKO/MiT z5CdzlZbqINK5Uj9m28uAQkGmSkxfPYss0RS+pN4X5EuZINLNuJyoxi2UMzA==
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
 kernel/bpf/rqspinlock.c          |  3 ++-
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 include/asm-generic/rqspinlock.h

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
new file mode 100644
index 000000000000..22f8094d0550
--- /dev/null
+++ b/include/asm-generic/rqspinlock.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Resilient Queued Spin Lock
+ *
+ * (C) Copyright 2024-2025 Meta Platforms, Inc. and affiliates.
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
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 762108cb0f38..93e31633c2aa 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
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
2.47.1


