Return-Path: <bpf+bounces-54115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F391A6337D
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FF917037A
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36A813FD72;
	Sun, 16 Mar 2025 04:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgCFU0ja"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3B2940B;
	Sun, 16 Mar 2025 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097948; cv=none; b=JdSPycj8GG31Mgp7dOMAE0vt0ftEf+cc1bMSp+F3mwOqPd50AWed3HQbLz0f0lPDZcrTYIXtvOyexSzc2Q+rz6tUHf+etO4JCo2GIKhVyzdHe6R2KgHHjnGz24nXCBhjiMEoq1EsqwTJJk9N4YQkMJuJYzjMSH1BaowC2n85ABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097948; c=relaxed/simple;
	bh=eRhFkF/3rcweOD1hEb8YOfkkc+MgHB8pVKtpJtztTto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0kUkpAjvfjeLlFSPkowJ3AnuMEWVlN7RUijhgQewgmXwLRS+KX7+OWrD/fRxvACNwixy5zB6Qg6Nc/0PrgUMnkaEslRonX/Xdq6hikxDiJCcOiWM83l8pH1eETtkdOqGF4RhiekDcbtof8EFuooGottFln69oCoPOfpGzp/bAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgCFU0ja; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4394a823036so9985065e9.0;
        Sat, 15 Mar 2025 21:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097944; x=1742702744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAZ9jQC/mJhCSOh/eXQcdu5v8UyTgJRpZIptn/Tfisg=;
        b=ZgCFU0jaFN6KoFwiAEE4/dM3+uc63WNZApudc86j5h3FbFeTsRs6qHSXI7ZC9KaSRB
         quLr41ZTylvLhuoX9+1DipSsZEj7flJ0XfUTRco8lvZ3HYYvRjNzjZfIwToKQ9Wqx4Vc
         ENdOYkl3X6DqcpTFC8UWe1i4istZE5dfCv2sMRnJq86lL24hogxg5jzqz/nkG6u69PVa
         TOVFDkiHI2JFgSQ55o6Oakm58zKYeel7/8GvYl49Vs8DTu2bxwQO8FVUzfE9ubvqOWig
         dLupiyAZSn+N6Maz0oxzdhxO6JeBb198nOYGNPsnTuQtcdmMLgpE2z4er3MfBYL0nxdg
         /kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097944; x=1742702744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAZ9jQC/mJhCSOh/eXQcdu5v8UyTgJRpZIptn/Tfisg=;
        b=SsC2/ArMl+rwP4dIPrmUbhknmHfRt1b0AEvGmxpUDvH6jNDu/5QsD3d343bdwCad+T
         Xq7gTIVn7EwS5zOgjqK0PykjPuGNANvQLv0335VOiEFXbmAfolqkQY8YeMzTOvsGVboH
         RgBKFiGohvH0lFyOdhr5e9gFgCygXiIhAJaM8WPwmxslaxJkJZ1y2XlLjlVDU95cHBJR
         5//K42E6bfiTcDtnNBWWgU1R2VOpLBPtNuLym5NYWFZBNFZgSELN0KH5OdcN/jY8Sby+
         qU2iLvmLnaTjKr/qiKtKgvyeE8xX17P4We0cGqoYWDi8wGLO362cn996jJ/tvyzpAxdf
         R9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuRPEkUmAGf0ZVuiwwINMjP00rf08INTbzWF1CP7Qzw8C8vr8g4gFdPmOmysJaDIUbQ5QtpVlM85MpRhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyT2IsZobxQNV62Uvwd/O22RICEeFXL0aWm4HD+D4cuDWQazkX
	wcMQMOD7LbRx90axzZFpFFVAC2Gtn32MJ5w4VMvOHl0DD99GmTGFeqCCseuobaE=
X-Gm-Gg: ASbGncvZa41QwKOXLblWEsVlQMw2zXS4VWdZA4FQUPIPa0YcQPZs0OskrhOiD4md7BW
	kEirCHYTW3vExqzZbmqCRof85ZuwjjYp6EMhK8vKR+f5NndZw/CuAPPWhez5wEg5ZNmveWkBTfL
	OkjDd1qNxZsdQ4tm5JwWQmIH5rPMKlja6Jh3ZUj9vogvEwZyhaRCWgJSWsjk3x1P84T+Ddcz8Fw
	mlou8GltQDtfBIHP0XKi0Hrj+PIWJpbK1eCaRubqjDPi2pb3OGKoNy6F3C4ocpwiAUXiZl/FA5u
	3eU8gLeK1zXPu0zob4Y25bUQnxywMm8uMw==
X-Google-Smtp-Source: AGHT+IGf5Cwi04Qa+X8PjeKePQUKLiwDo+IJ3EDto0rr/2TEINmkWVGh9IecdlUhicgQ4p2TyfcEGQ==
X-Received: by 2002:a05:600c:4f41:b0:43c:e7a7:aea0 with SMTP id 5b1f17b1804b1-43d1ecd94b6mr82913775e9.26.1742097943833;
        Sat, 15 Mar 2025 21:05:43 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3978ef9a23bsm6539658f8f.15.2025.03.15.21.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:05:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 01/25] locking: Move MCS struct definition to public header
Date: Sat, 15 Mar 2025 21:05:17 -0700
Message-ID: <20250316040541.108729-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; h=from:subject; bh=eRhFkF/3rcweOD1hEb8YOfkkc+MgHB8pVKtpJtztTto=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3butWk8EuLzPVXxsuVw8yqD8MdVwsBmree1XPD V9Au8WSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN2wAKCRBM4MiGSL8RyiyIEA CF0DaeI20sABfTiW+XnI2K40s/yy2XdKyaP2M+UF+REcO/yDFmgt6PB92KqELak5+J8Zi2i1IGAPbL VUQGB/9GPicCJbHPwoFytzQGK9WLhUge3emsZIXUEY6hsTw5s5YX3aKvWQSxl2n+2FRSIopyc1rC3+ nX4Pt4N8iQzyrESusYoivUFphBfzorcIhNELZlC8XfeNgSvpH7VhGHxzgDF+f0x7ptI8tLqB4S9WnC rGlawzSJSmYe+054/yEUR03h250A1H8XHtH8s0UkaymWWfZwSVmdA2vRjk0YvRn/kn0jx3eBtT/Tc1 MnmcwgF3gfyF2j7LQ9KQ79/bXniDKzmIuPc4cUE7V8Mj/AWjZPH/AEFoQy7K47YG2vKIGBw+LK0DZD 8CMVBbbCsDt32Q699Fn0tSZeYkwgoDuNKv3MIFEk8nz7Ih7KdMQgjbUPJyk1KW8RabsVw0BOlA3igv /cfexOGCQVv0Tr8SQeEhc6OGyDr1NKnYqPqJ3+aBlq4sy68DpHYpQSYKJcESF4nGYrf9eOB6GPGPGK BEZnXXAechWthJbFWsNbSQMW/iZ7GgQ5MtQ4/T19J94XQ3Bc/LoSVUvlTBboqEyIUDd+eYO1ECll0r w9vUiTso2v9M8XgX8vGZeEBkK42nAuhPuDiT1R4EOcasWTSuQANf3LFmwfGQ==
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
2.47.1


