Return-Path: <bpf+bounces-75422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D761AC832E0
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 04:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909E03AB9F1
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 03:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042DB1C2324;
	Tue, 25 Nov 2025 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWEotCN1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F27263B
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040143; cv=none; b=PNed9Pf1Y8IqVF2g8MvKGaPHBF0GE0gj3QZXjFis14CBMLDDAdfW181CaHdsbGj7939PLHZRhMi8kA9ns2db+nzX/AJnCcc9PLN5brEF8ucNUcQ8jHX0mPla3UUGlkkCLxwHRT42pZIGScZ+cimwfOg3iO8WEr8yk1pgZOVmqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040143; c=relaxed/simple;
	bh=gh68/CGlFNLhoESH/ZvD8BuFS4v2qyOCs+7oZ6zwUEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3rPbyHyceMWuQRCy/1e2QQ9pAc3ZO7/gzijTnracNXUdpN5W4weZfiXnP23IBle6loRreaj9vM2dy+JR4piKZ8qDqoicdJ6Xfly2rx1kuSYiICPTTKE3jsnbsFnKinyBbIW9uE934XghO6up31+rgBikvc0QKstfcfSLsLl/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWEotCN1; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso32330025e9.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 19:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764040140; x=1764644940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFFTTN+qJ/RyBP+xVAIMoFUwrAmrj5F9t2M0pjG5RTA=;
        b=YWEotCN1pqZG+ve0Wth8kAuqC8kFYONeMPVu7xX/r1wQhST8kdNiHyMQYR7HPfLQGo
         TLFJgDMSz1vS2CAjJCCFP2WM6Aw/IsU4WYD/V7zgW04dfv6i7CNFYjyjMT0Nf5PDRs3E
         srWRAkPhyWWWF/rjtDCLK+Rcp0H+jbczNDqNtHtURSmfYRKcZ44sldT1atnvrCPuAQba
         SdnL3jFPZlFGD+pQr4QO/IPEbEUKtBks50ynicoMW5vd016h9zdKjdNPj9KvhaKu6cMn
         b0y6qUhn+LCWBn4Gw0Iarb9z8ZukBod7VB7bnL2yDa+CvT+vfDJV/oJXgj3dejhB9nGe
         Nn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764040140; x=1764644940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFFTTN+qJ/RyBP+xVAIMoFUwrAmrj5F9t2M0pjG5RTA=;
        b=RfpyrnjxEyR7DY+S/W44ns6HE5wWuXRgXDQzGxm3T9mJhH+IV6Ks3vv6U+YeOPvGq3
         Nr1AN6UEFHeLlxaeLMpGlycbF5usg8hWKNyJcsxSjF3Cm7DXIW8O3aEwzn7sqklgOhzd
         4grRFU5pd34Ftxq1FETPDRgGL/8I8H00XKIXrYZfK81Qxk/DX5rxGw4h1Ng6UddjMCjn
         8DCqwatgIuTfWs0ulkYtRlx4qZIEqLpKysaWlze7Y+uKBWNo7mohwMFXKK8z/WrT/Xy2
         s5ErHQXhzmYTCFTQKmbTvWoxZeUjJ5rWl97v+i6Dq/vZi3YkxU5o1cEQXMblAGOILCJw
         95rA==
X-Gm-Message-State: AOJu0Yw10nPx04YF9UWdOkUhzTWE8STdDXHPWxg0JBC+vPKwfp9J5jC2
	sH4zYETMbUtEzJ+hkjknC+SvZUrjbFvluD1DUHiW9ivE1AO7Xhl9USjrKWUW+WEI
X-Gm-Gg: ASbGncsD1U2fnm+QDvTcLLJUOEmSeWLSIs1tGFXG3JiyERe1+9mZyo5sKswnBkxGJeb
	57zoaaAmhc9dAdWaXzIUZj9mf0hZIZX5ETVnPXuRhwb/D8z6tMnlbZ8xy9lAY927PaNLkyrPsVG
	Z6W4NAuunaOlndvEr5Zi/y8dM/ttS4LLFKE0fe3wKmZLTXs7ByrEFTgUoNPsSsvzv7/oFLFmGZn
	Ia3sUmxomQQLx198UVWV2mGA6X94n8lVx23X7Z27V69ICrUSBJqlasCkqcYofQeTMR1f6KnaMdO
	yB8flpcJhnAZwoNIVuoIzxeKYQpyqVs0oe2HF6R9IbMg/3zsY8ywV0uFGWtSLL+XXJNkGKw808j
	U8T729tMJk7ExR1nJDRZ4JnhEEj3XfZYCINhOeEuxMmZ0civf2a9cfStNMeoajaF0YYkUiyrCzd
	7tRZuCn10FOEm3/HZKSYwJVjU+mmL3BFO+GcGVGzgL0r/GLq6LI9GiYKOiXJtmitv4WgU8ww+ws
	Lc=
X-Google-Smtp-Source: AGHT+IHW4j/3mMdMLqHaRuSq1rj2U/+zt7xNdWDGAv6AKY+a9zEY5URTU7Im//LYusD+XqydZSwmiQ==
X-Received: by 2002:a7b:c857:0:b0:477:9fa0:74ed with SMTP id 5b1f17b1804b1-477c01c4d6emr90598445e9.26.1764040139795;
        Mon, 24 Nov 2025 19:08:59 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477bf216ddasm221605385e9.0.2025.11.24.19.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 19:08:59 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] rqspinlock: Introduce res_spin_trylock
Date: Tue, 25 Nov 2025 03:08:58 +0000
Message-ID: <20251125030858.2485401-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A trylock variant for rqspinlock was missing owing to lack of users in
the tree thus far, add one now as it would be needed in subsequent
patches. Mark as __must_check and __always_inline.

This essentially copies queued_spin_trylock, but doesn't depend on it as
rqspinlock compiles down to a TAS when CONFIG_QUEUED_SPINLOCKS=n.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/rqspinlock.h | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 6d4244d643df3..a7f4b7c0fb78a 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -217,12 +217,57 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
 	this_cpu_dec(rqspinlock_held_locks.cnt);
 }

+/**
+ * res_spin_trylock - try to acquire a queued spinlock
+ * @lock: Pointer to queued spinlock structure
+ *
+ * Attempts to acquire the lock without blocking. This function should be used
+ * in contexts where blocking is not allowed (e.g., NMI handlers).
+ *
+ * Return:
+ * * 1    - Lock was acquired successfully.
+ * * 0    - Lock acquisition failed.
+ */
+static __must_check __always_inline int res_spin_trylock(rqspinlock_t *lock)
+{
+	int val = atomic_read(&lock->val);
+	int ret;
+
+	if (unlikely(val))
+		return 0;
+
+	ret = likely(atomic_try_cmpxchg_acquire(&lock->val, &val, 1));
+	if (ret)
+		grab_held_lock_entry(lock);
+	return ret;
+}
+
 #ifdef CONFIG_QUEUED_SPINLOCKS
 #define raw_res_spin_lock_init(lock) ({ *(lock) = (rqspinlock_t)__ARCH_SPIN_LOCK_UNLOCKED; })
 #else
 #define raw_res_spin_lock_init(lock) ({ *(lock) = (rqspinlock_t){0}; })
 #endif

+#define raw_res_spin_trylock(lock)              \
+	({                                      \
+		int __ret;                      \
+		preempt_disable();              \
+		__ret = res_spin_trylock(lock); \
+		if (!__ret)                     \
+			preempt_enable();       \
+		__ret;                          \
+	})
+
+#define raw_res_spin_trylock_irqsave(lock, flags)   \
+	({                                          \
+		int __ret;                          \
+		local_irq_save(flags);              \
+		__ret = raw_res_spin_trylock(lock); \
+		if (!__ret)                         \
+			local_irq_restore(flags);   \
+		__ret;                              \
+	})
+
 #define raw_res_spin_lock(lock)                    \
 	({                                         \
 		int __ret;                         \

