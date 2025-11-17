Return-Path: <bpf+bounces-74791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 892C9C65F06
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 20:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B3F7346C27
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 19:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919033FE08;
	Mon, 17 Nov 2025 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBW5IjnH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B133F8C7
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406918; cv=none; b=d5z0kd05WlsM4XzagCUxs5+MjCz0sI5OXNxZ/bZzC67BhB7hPXQ7VoZyw26CX7fOPZ9iTmACy2hn8nd/7FrWH5y/KdCY6e8k7qCq+RFmY6QX6uyT315P6Plms5VPD+LZ+ljT2jLMx4kBb9Phmdg45Oc7j0fK93M85sW1XbB4dUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406918; c=relaxed/simple;
	bh=8XYMyZUxzf2Gu/EkbhT25ijmIzyv6Q+HEDxpFUrbxvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOesoDmsIbsu1uiybFQ59OqRFMSht+SsCf8DQR4cyLIDL+vMPyj5be6mU9cUz1WKnpyl7QLVCRoSUwtDQ2RS7dGv+ch6/pjaTFfyuFFBpCiiq+PRdhS3tBaEzemyRG0589cx2iyw4xoGLFAu0m+SxYApQoJ8gMo7Buqh4nlggxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBW5IjnH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso5222093b3a.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 11:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763406916; x=1764011716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxBy++oAoQMduY8bXug9aUHF7Mi2DRiPPKfNcmF1Q+w=;
        b=UBW5IjnHvP7rgwE7fl33PNvEAlfa6E/3ozwNVrWigUbOhmqrBN7DiVX8wKey/ABjiK
         iI0Zf7Ovz4q76e9oI5nOifPSXf5TTzJied57fWoIvio55/DQtXdarS+shkZXvzafDnuQ
         GasTPj/htUUI3itm76hNpDsiC7MxRHh0tyMrwiV9GhAAk/zk0pCqGplFZx8+9IHqO9GY
         NqEwHlz2R7u8vLrsQID7PNHu53PYHqOXXUd6KRh8rX29Ay7Lbwjo4G5mWPKlzDCQnBqS
         6l4TP63MuSJyQDdTuhFqxCnCcQRJ7hjtnx3KdKrvWFkTYWffu1MXqnvci4o0TCJwlJuY
         hmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406916; x=1764011716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxBy++oAoQMduY8bXug9aUHF7Mi2DRiPPKfNcmF1Q+w=;
        b=Z2P4zja5J0gpBy/mS6+udnFQWuXVYkYIP78sdRTGdOMdSZu7xW8/HSXfLWyTlkuHiw
         WPJqERBpW5CYNICsI0dBRlKSyWsYu4F6t1PzLABcE5l8h8HcStbRjhLkNko2I5fyD+cp
         44Em5Ss6GYs1EORfwuTYb5uMyphXntsr+2xCV6/cc/zcOXygqr5J4whGTPh9QaK0+WNW
         KraR10NrB0LtSvTijHLvovcv1Zgc1L4Hdv3mDgcE6PsTlETrxnNpxvvbWgQLgRaJWmsn
         YMXGPWxzxjcBGHPaFQ1q1H5JT2fpZ/+SSgjajTa+9VHoehvaO9lQxakMrmcW9hVSBYQ4
         1Pnw==
X-Gm-Message-State: AOJu0YyuFh6B4nKP6z5KuQXwgBMyFLFNS4fT1q7WdwwI9gPHzsttr2Hd
	YiDAUheC8vnyen6h/94ISLBBdG1KaXe0FV1+ZKHRBa1falm0T+soJKT735Votw==
X-Gm-Gg: ASbGnctrhd+3T7GfBz3bNdbiiuWenaBxk7ONlLi2+xtfe+lNJ7KGMxu9/gm13MXsQVG
	pCo7wze/wAK2oHm9Ll0qV9F7PS8ebQlTrA7kpzhWmljB9ciXxGXhQRRa9flAqb/ty2HegpHHPzu
	6Lea7bPNrPibFBxaTerXZW3ZgR1UaideisPMIOO2APW9WCW1aY5zRRH9/3ki5RtAuPKLS/DLgSX
	ni0sEiXcI/X0BQxYzM6yR+Ds3rzAoA4gwX+DnxvYZelhX5D2KgqG/Yvtws3vbvauOU6ShxMWL5+
	WOh+ACwy6ObsVM8kfw0scBMn3FcJrbA6S1Ro1IKxH9y1C8o/4hV8cEHocniFGwVQPGUWzV5xsmo
	BG9xBUGJqLocAWE2BQM9z4fszRSEri5kDCWjZtmUqH+fsN7/BRw+m2QtihaUnTp+s31aUeEQ4F+
	dtaMkWBUTFTaYl9A==
X-Google-Smtp-Source: AGHT+IFg9m2V8IGb7kvHuVx3MlddcQxQnC06pKFHTVSj+DnxLfz6b9fR/ZfBVQmI4UhIgu60FR0jIw==
X-Received: by 2002:a05:6a00:174c:b0:7ad:df61:e686 with SMTP id d2e1a72fcca58-7ba3bb96782mr14320319b3a.16.1763406915969;
        Mon, 17 Nov 2025 11:15:15 -0800 (PST)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aea0f8sm14155354b3a.5.2025.11.17.11.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 11:15:15 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring functions with __must_check
Date: Mon, 17 Nov 2025 11:15:15 -0800
Message-ID: <20251117191515.2934026-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Locking a resilient queued spinlock can fail when deadlock or timeout
happen. Mark the lock acquring functions with __must_check to make sure
callers always handle the returned error.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/asm-generic/rqspinlock.h | 47 +++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 6d4244d643df..855c09435506 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -171,7 +171,7 @@ static __always_inline void release_held_lock_entry(void)
  * * -EDEADLK	- Lock acquisition failed because of AA/ABBA deadlock.
  * * -ETIMEDOUT - Lock acquisition failed because of timeout.
  */
-static __always_inline int res_spin_lock(rqspinlock_t *lock)
+static __always_inline __must_check int res_spin_lock(rqspinlock_t *lock)
 {
 	int val = 0;
 
@@ -223,27 +223,36 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
 #define raw_res_spin_lock_init(lock) ({ *(lock) = (rqspinlock_t){0}; })
 #endif
 
-#define raw_res_spin_lock(lock)                    \
-	({                                         \
-		int __ret;                         \
-		preempt_disable();                 \
-		__ret = res_spin_lock(lock);	   \
-		if (__ret)                         \
-			preempt_enable();          \
-		__ret;                             \
-	})
+static __always_inline __must_check int raw_res_spin_lock(rqspinlock_t *lock)
+{
+	int ret;
+
+	preempt_disable();
+	ret = res_spin_lock(lock);
+	if (ret)
+		preempt_enable();
+
+	return ret;
+}
 
 #define raw_res_spin_unlock(lock) ({ res_spin_unlock(lock); preempt_enable(); })
 
-#define raw_res_spin_lock_irqsave(lock, flags)    \
-	({                                        \
-		int __ret;                        \
-		local_irq_save(flags);            \
-		__ret = raw_res_spin_lock(lock);  \
-		if (__ret)                        \
-			local_irq_restore(flags); \
-		__ret;                            \
-	})
+static __always_inline __must_check int
+__raw_res_spin_lock_irqsave(rqspinlock_t *lock, unsigned long *flags)
+{
+	unsigned long __flags;
+	int ret;
+
+	local_irq_save(__flags);
+	ret = raw_res_spin_lock(lock);
+	if (ret)
+		local_irq_restore(__flags);
+
+	*flags = __flags;
+	return ret;
+}
+
+#define raw_res_spin_lock_irqsave(lock, flags) __raw_res_spin_lock_irqsave(lock, &flags)
 
 #define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
 
-- 
2.47.3


