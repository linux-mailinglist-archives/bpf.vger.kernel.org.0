Return-Path: <bpf+bounces-57110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78514AA59F6
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 05:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53344E391C
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 03:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029092309AF;
	Thu,  1 May 2025 03:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWONbMw4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E27D1A0BFE
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746070065; cv=none; b=VFdGZeUObhNZYBomhGyH935WTaHqBkg0yjPW6otdgfI3ClOSePpDxrf3xbX5QtzTr9jCUccPOtPCWdfC8M6AbgLK4BcDh8pk/dfCdHEJ/VmfoUEgpOHctYVjtwtOWCA9lJgOw5Iul9h6Scmb81+bDHGwhNARvc/sKeSYoT1NenM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746070065; c=relaxed/simple;
	bh=3BfhELOfCluPVPOMvrYb7sV/DygqjLyikdfK5Cpkgq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BI/IvuLNQrukx3BzHtHEmYZAOjiM/Qe/R5qhxsDWe+D9fE+fEbiFwL60U0r0mfHJsLN/T1ragAfofXZgGYe5GWS/AvbQICAmzOitTnMlmt8uQc77nVtldnAhscYLnWi18+3bJBUv8dAf1U/t7steGmWfihoCI6VH4nYjVrg/6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWONbMw4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af523f4511fso523169a12.0
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 20:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746070062; x=1746674862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX6llm03C0LIofZKVhngpskpWSkctaSgtaEvqaJgRKA=;
        b=OWONbMw4hMiehzenlOkoBxZsGJrR4o9XWbbecvg81yJwnCSE5ZqKQl3ymkIHn1rMEw
         KWtfbXZzuIHXmPN+3rj4iT9wSIKOjN7C53g/HngsQAPrRQSexc4PS0WgunkaHR8BaFOq
         /4Luibhw27SOPwXATVxU+4lvYf9r2GxOoM7nBGlmh/D2N+FQMSOFWzejP4AULrVcyliG
         LugP7qW81E3mgUAwx+YW2mRILWDEGnc8lNZlMOiGOEQuqdZJbnvNCnWYbil7fPDByHkt
         BdfqmQa+SBfCE3AXN06y30IpsURIjjK+V/byR8/CJozXGDPDw9NQHR9Vnpi105LP82ez
         +68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746070062; x=1746674862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX6llm03C0LIofZKVhngpskpWSkctaSgtaEvqaJgRKA=;
        b=roVwn+b6gipF0YorpIj/1bBQgbEC58cD+CK2UApFMpqrY4N9Lw8FG2LY5k8MN5k6+d
         eLHglgEKSlYdMV3C5UiujEMupjpDRTQZB+nbtI0Ei2UGAw4z4zh3+W1NxgTDlWV6Iafp
         SwbLi3UZPjIf0jPx1pAWBfQ6d4P5T9kWjNovCiTtAHb5BHT7dSMdbdE36ONIbaXOZLix
         S0R8eefGMTaPCVX0SPlnj34UrVmy6Ad6jIUC4CO/J3knWCLexdm+y/S5mj1V0fwNy136
         lSvj7Jj5dkfZSE0k1xTMOLqPnoRKaAEAH2lgLq1WxOaLe5tSM00Qq3N4mToJAVRpBaKA
         Tgzg==
X-Gm-Message-State: AOJu0Yz+p7ECPWu2YMQHV+Iy7fs3KSxANLjkpBDX18safZ2gqBgkzLjO
	4+erjfl5dIKpiSkfREnmQYrvWZVwZS1yfg3zKzj+vwdpIWbVJRGF82d5jQ==
X-Gm-Gg: ASbGncszMkkzg2oxguUCtKBEPz7WK0XpTeqNnBtQRv9gEqiWwHkX9PjkCOTXxdyQLIF
	MWhZ1GqB14HzN13oy6HxmOsLktoPkyWw/nIWFVPiXFuxCQTHvoppNzFk+pMSQUtW9HubaxYqVtt
	f6+eKqPdKwc14tvEAiCvgkp8esN4tvgOUWKtTp3uS3r3GyLSAvhS97g/rd3g22Ps0Rye4NArqw+
	2W5NO5p47oaNSjgIxQgyIRw8ui5IY8sMHBAXHP7IfXWpTo4kWdbNIbvdL4neTJ6tiwtXD2MODNz
	tJKarAOQRJ8Izo5/KxsVH98T7mS1vURrGGxUJp0xTU/kxs9H4sjNpV5BAIrpfbvq+gAh
X-Google-Smtp-Source: AGHT+IGnPb76TyUdO9Ok/eAIZ2iA6j3BcFpbdz59/hEoRzxhRnG5xDhSPIVqOw3bH3ISf3RLwvXNzw==
X-Received: by 2002:a05:6a20:d705:b0:1f5:8262:2c0b with SMTP id adf61e73a8af0-20bd6656f44mr1758597637.2.1746070061886;
        Wed, 30 Apr 2025 20:27:41 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:13f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740398f9aa0sm2616253b3a.10.2025.04.30.20.27.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Apr 2025 20:27:41 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
Cc: vbabka@suse.cz,
	harry.yoo@oracle.com,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	hannes@cmpxchg.org,
	willy@infradead.org
Subject: [PATCH 4/6] locking/local_lock: Introduce local_lock_irqsave_check()
Date: Wed, 30 Apr 2025 20:27:16 -0700
Message-Id: <20250501032718.65476-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce local_lock_irqsave_check() to check that local_lock is
not taken recursively.
In !PREEMPT_RT local_lock_irqsave() disables IRQ, but
re-entrance is possible either from NMI or strategically placed
kprobe. The code should call local_lock_is_locked() before proceeding
to acquire a local_lock. Such local_lock_is_locked() might be called
earlier in the call graph and there could be a lot of code
between local_lock_is_locked() and local_lock_irqsave_check().

Without CONFIG_DEBUG_LOCK_ALLOC the local_lock_irqsave_check()
is equivalent to local_lock_irqsave().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          | 13 +++++++++++++
 include/linux/local_lock_internal.h | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 092ce89b162a..0d6efb0fdd15 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -81,6 +81,19 @@
 #define local_trylock_irqsave(lock, flags)			\
 	__local_trylock_irqsave(lock, flags)
 
+/**
+ * local_lock_irqsave_check - Acquire a per CPU local lock, save and disable
+ *			      interrupts
+ * @lock:	The lock variable
+ * @flags:	Storage for interrupt flags
+ *
+ * This function checks that local_lock is not taken recursively.
+ * In !PREEMPT_RT re-entrance is possible either from NMI or kprobe.
+ * In PREEMPT_RT it checks that current task is not holding it.
+ */
+#define local_lock_irqsave_check(lock, flags)			\
+	__local_lock_irqsave_check(lock, flags)
+
 DEFINE_GUARD(local_lock, local_lock_t __percpu*,
 	     local_lock(_T),
 	     local_unlock(_T))
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 263723a45ecd..7c4cc002bc68 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -168,6 +168,15 @@ do {								\
 /* preemption or migration must be disabled before calling __local_lock_is_locked */
 #define __local_lock_is_locked(lock) READ_ONCE(this_cpu_ptr(lock)->acquired)
 
+#define __local_lock_irqsave_check(lock, flags)					\
+	do {									\
+		if (IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&			\
+		    (!__local_lock_is_locked(lock) || in_nmi()))		\
+			WARN_ON_ONCE(!__local_trylock_irqsave(lock, flags));	\
+		else								\
+			__local_lock_irqsave(lock, flags);			\
+	} while (0)
+
 #define __local_lock_release(lock)					\
 	do {								\
 		local_trylock_t *tl;					\
@@ -293,4 +302,14 @@ do {								\
 #define __local_lock_is_locked(__lock)					\
 	(rt_mutex_owner(&this_cpu_ptr(__lock)->lock) == current)
 
+#define __local_lock_irqsave_check(lock, flags)				\
+	do {								\
+		typecheck(unsigned long, flags);			\
+		flags = 0;						\
+		migrate_disable();					\
+		if (IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC))		\
+			WARN_ON_ONCE(__local_lock_is_locked(lock));	\
+		spin_lock(this_cpu_ptr((lock)));			\
+	} while (0)
+
 #endif /* CONFIG_PREEMPT_RT */
-- 
2.47.1


