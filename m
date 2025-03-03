Return-Path: <bpf+bounces-53086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A12A4C509
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9FA31886BEC
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B65A23315D;
	Mon,  3 Mar 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbMHeOSh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2122FF4F;
	Mon,  3 Mar 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015415; cv=none; b=SikjabbnpQOL4SIZXILE99OK4O2ECii48BztuHBtT6rn7SfTSCHDyIAtbT6gLXohEa776xS9WYkz/r9E2qlJnVtn0zTsEuyqRJ+uxGqXcyR1oFaSfdkZO9hlU+xazO1KIMmVhn2+mUm6y8c3Y+b/2Agpn+obgAvViNs+Z+rLUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015415; c=relaxed/simple;
	bh=bthuxBncjGOs4mky1mKdWZk3nTI3RWDlXR+RsRusmm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFdaGRqwKfnKQQSS1YBSBUws9L0Kr//zZtU1Qyw7Cs9ggDSozkExC3S64nPLjt5bEo7alyG34/C23eJCzZZFD2CC8XsBQBOtFLNWcsD/mvW9tcZrB+TnJKg5Ln/9HYbjg8+ouQXppJ3/0MD3dflgHp3RUnxNDWGJ5ZhjAk/BNHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbMHeOSh; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4394036c0efso29344875e9.2;
        Mon, 03 Mar 2025 07:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015412; x=1741620212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKS1T/XQ/tWs8ecRTlu3cl4kKPJmu8O7rwuQ99x/CTQ=;
        b=JbMHeOShC0Meih8JAt1gcghndF+ApNyi7ZpsZf4kwqWvY31rCG/VKgVJsX+kPGt1It
         MwV7IfZSCTnQjZwTyfhVm0Q05DEFWH6AjqcREWV6ixLI81SM98HYt+QBkoW929thymdi
         c7H2AaIeagt+wh4H0GnKlgwMs+h/Vd5AKrdBzr2mlNKzF94MVHJ+AnaCKsOqDqBvuZji
         /t+Rg86uzVI1S0mLpBjXiFohfduRLo3NPScfPZelqIH7PbSn4iQcvABkCv5s7t/5jKp0
         DL1XCOoE9VLst1xoGolpsV+LQ2m0AhDigfv5MbIu6YJfUWtU8l3FOuaBdAtP0iW4zRBO
         gQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015412; x=1741620212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKS1T/XQ/tWs8ecRTlu3cl4kKPJmu8O7rwuQ99x/CTQ=;
        b=YJxd3qT+/pEyuSw9zrxVtt8aR5cLWvHNRLjmcJ+Zp0CMIlNXjzhfzKfD+indHC+jga
         SbDSpLZE6hVdmieVf618u8BsUcY/g1aqC/9YJp9Fw09hUAD3DQODEJ8w5p2WzaOJ2OMx
         2ZV4iSlenIrt3YX5V0GIi8YKPKx3VgEiTvPlkIvCkshMKQ79TV53ZCdspLEr49l29Og+
         HyA+f4TYLY/41cdx9BlWPHtWgdVAM+BocvaOzWfCLS4sVtHzSJ3pNnbCk4oheSJep0d/
         47d6v/08IAfBxWfYFkuN2ucWu0TP62ImYKhbpvHOrzUMQXEcPY5BpPWCLziqd7d6lu1j
         LOug==
X-Forwarded-Encrypted: i=1; AJvYcCWhOGx6d/1Vk2nBXyij6YHm/ldVKjNh6L0GV9phX8lN8RVh2/yU2Ggvepo7XXaO1ZGZrWThMVi8jU+In/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ2yncphtmBYRwQK4Yeb41r3MNQt3Y2zkxNYs7RegTmIwBKzwt
	5azNNhQdojn5CTyWOtBnxMoKFf4zWp6BKZPzdkT5WsBNyIhxhV6sBMIdyJUWhmE=
X-Gm-Gg: ASbGnctM8nRsCwExO2rKBwUVTFiMFWF8oQb+H84Xzttl1WYebBdy1OnfInNRRuRKdpi
	FtD/9www8lmpDpTKd1HF7nP6Qb8/vne2tWac5PYfAmtrVa2QX0EVJ0Tioraoki9P2vbrakQcNn1
	HkfazlklT4g4geWkU1CFMwKN1stgd9d7bfbuOPZj1r3iKbj0u5S0lWeCrl4yxTkK5KExfwqUJtB
	pUo8PYcYQV+/L7JR1b3OyVyCQyFlnO3OwI8orRh+Z+S92ZIYvJ8ihIiSKsKuZbqK0SpIZFeJpD/
	wuSyyskwR1GiDzVitLRTzRuxH8XQyk8+aPQ=
X-Google-Smtp-Source: AGHT+IGlH16ifEyb4PlL+eWM8UXuzJH348pjxTrHJU3GO0ZnngxsPxkDQyxyCAS30KE/L9MfeFB7Sw==
X-Received: by 2002:a05:600c:511e:b0:439:6017:6689 with SMTP id 5b1f17b1804b1-43ba66e0bf5mr109140235e9.9.1741015411800;
        Mon, 03 Mar 2025 07:23:31 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796084sm15030999f8f.19.2025.03.03.07.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:31 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 17/25] rqspinlock: Add locktorture support
Date: Mon,  3 Mar 2025 07:22:57 -0800
Message-ID: <20250303152305.3195648-18-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149; h=from:subject; bh=bthuxBncjGOs4mky1mKdWZk3nTI3RWDlXR+RsRusmm0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWYc+Sgz0ORRtjBX9jRAAhbYoGw0HwGVEnt1lkK 0s8wahWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFmAAKCRBM4MiGSL8RylTSD/ 9TP8RtAKolLrilNYH10VbArS3ra9jOCKUgFIRYMn7uqajviRSi77CSgnaVlYnmA9EfkXqnPw6r53W8 inm8T7K1fkgOmvIbYxtsKTKVPyW6c0loQf/rxpgCr7uK34o5YRBK/iSgFyLS4uAE5QbB/Pf9jJ28lv Wtgk/Ey42frf7Uf5RQNdrzPGWDnh/n2149+2agrmt9UNjkHTYYsrn6TOvYBRgxX0kiN60RLQbmXTjC nHD31GAomXGCnNxzEDhY1G2vG7r5C67GzOWT3UMHmKgQdaRcF/Lsw8fkI6g612CABQio63//Nm0QSA Myxwcedn9UdnGHGvM0F3IlXZs2Ub9fwmfoi6C1gmJ3MJiii8TYzxMoVYTXMM5yktxCqQG11WnTNq0l b3CpjATOtu5zhfGJH4mG717bInDxZ1ZmPKWEEGT4Hz0ePktKsfs56WLmTMhKVkRnC8Fa8ztfYGJLdG bQg5bPK0unpb/3Z3pIjZUHVpqVYWKGFYCmKd8AYmN3D7RlJn7HRmZCf56bovKsEgHPk9ZlLamM213o m1cj0p0dLPhfrYItv1LDuMe8Xkd/8Dzp3oWLhMa097fZFVsUhzB6TnuCE56VdlV2ZEvObJHft6x3OR yX8L4HXgOOdKq1WkjxYTYQtu9ZbqUVfB5ojTHrx1qJR9u7pdx19dUvyvMZQg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce locktorture support for rqspinlock using the newly added
macros as the first in-kernel user and consumer. Guard the code with
CONFIG_BPF_SYSCALL ifdef since rqspinlock is not available otherwise.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/locktorture.c | 57 ++++++++++++++++++++++++++++++++++++
 kernel/locking/rqspinlock.c  |  1 +
 2 files changed, 58 insertions(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index cc33470f4de9..ce0362f0a871 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -362,6 +362,60 @@ static struct lock_torture_ops raw_spin_lock_irq_ops = {
 	.name		= "raw_spin_lock_irq"
 };
 
+#ifdef CONFIG_BPF_SYSCALL
+
+#include <asm/rqspinlock.h>
+static rqspinlock_t rqspinlock;
+
+static int torture_raw_res_spin_write_lock(int tid __maybe_unused)
+{
+	raw_res_spin_lock(&rqspinlock);
+	return 0;
+}
+
+static void torture_raw_res_spin_write_unlock(int tid __maybe_unused)
+{
+	raw_res_spin_unlock(&rqspinlock);
+}
+
+static struct lock_torture_ops raw_res_spin_lock_ops = {
+	.writelock	= torture_raw_res_spin_write_lock,
+	.write_delay	= torture_spin_lock_write_delay,
+	.task_boost     = torture_rt_boost,
+	.writeunlock	= torture_raw_res_spin_write_unlock,
+	.readlock       = NULL,
+	.read_delay     = NULL,
+	.readunlock     = NULL,
+	.name		= "raw_res_spin_lock"
+};
+
+static int torture_raw_res_spin_write_lock_irq(int tid __maybe_unused)
+{
+	unsigned long flags;
+
+	raw_res_spin_lock_irqsave(&rqspinlock, flags);
+	cxt.cur_ops->flags = flags;
+	return 0;
+}
+
+static void torture_raw_res_spin_write_unlock_irq(int tid __maybe_unused)
+{
+	raw_res_spin_unlock_irqrestore(&rqspinlock, cxt.cur_ops->flags);
+}
+
+static struct lock_torture_ops raw_res_spin_lock_irq_ops = {
+	.writelock	= torture_raw_res_spin_write_lock_irq,
+	.write_delay	= torture_spin_lock_write_delay,
+	.task_boost     = torture_rt_boost,
+	.writeunlock	= torture_raw_res_spin_write_unlock_irq,
+	.readlock       = NULL,
+	.read_delay     = NULL,
+	.readunlock     = NULL,
+	.name		= "raw_res_spin_lock_irq"
+};
+
+#endif
+
 static DEFINE_RWLOCK(torture_rwlock);
 
 static int torture_rwlock_write_lock(int tid __maybe_unused)
@@ -1168,6 +1222,9 @@ static int __init lock_torture_init(void)
 		&lock_busted_ops,
 		&spin_lock_ops, &spin_lock_irq_ops,
 		&raw_spin_lock_ops, &raw_spin_lock_irq_ops,
+#ifdef CONFIG_BPF_SYSCALL
+		&raw_res_spin_lock_ops, &raw_res_spin_lock_irq_ops,
+#endif
 		&rw_lock_ops, &rw_lock_irq_ops,
 		&mutex_lock_ops,
 		&ww_mutex_lock_ops,
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 3b4fdb183588..0031a1bfbd4e 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -85,6 +85,7 @@ struct rqspinlock_timeout {
 #define RES_TIMEOUT_VAL	2
 
 DEFINE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
+EXPORT_SYMBOL_GPL(rqspinlock_held_locks);
 
 static bool is_lock_released(rqspinlock_t *lock, u32 mask, struct rqspinlock_timeout *ts)
 {
-- 
2.43.5


