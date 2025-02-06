Return-Path: <bpf+bounces-50634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D9EA2A65D
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97173A8821
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2262288C7;
	Thu,  6 Feb 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXz3RrA/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB1D227B95;
	Thu,  6 Feb 2025 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839281; cv=none; b=sEmOM+RXG6yEO98I5ugChd79RWD3pSG87PEBEs6sFhljJw6OzfZHwDfPR72RVt0uy2ztbRMkE0CwtN/XzT0r297payGW7j2uJxfvuQbC381yLjxp0OiK6WnOoIaJQ58LbcbHEKjGuyVJQ5XVbDs6JJwAC7qfCNNF+NG8FGVKgqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839281; c=relaxed/simple;
	bh=l+FzxzqcQOvCH8c5GurhKDmppajCdKyqii/WUkvzxT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPAxdiuZu6K9UN3tNE59awP8CPcNnUFnKVZokZRF8AOFMEOmN8amNMUQq5TK4zhnCMvmyjgZj5fF5t7s8CtGDTgpmewP2i8+VPCzUzrLx723bjGapjKgSEb2S7+qwwaVFa8xCExNoROUbUp2SPQBUaCAtk5a4gcGwNQLWP875Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXz3RrA/; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43690d4605dso4793825e9.0;
        Thu, 06 Feb 2025 02:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839278; x=1739444078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4Fpzu6vEVBo0wCJhRUrT6eOf6iL8Bnn94ks0el4cwM=;
        b=nXz3RrA/8stgP+UsnGvRt4R51unV5VzltJAUGlkXRQXD1aP063mRHP6kMZOgDktG9q
         VRyu9Z7sV2FNLfsuB/5Ohd24Afu6logdv8r5o1zXoy5xh7cmx4IcaRfD+gkwfFBESqu+
         YaiP0Fyuf+CxggEDVijWTNSb6b/LeO8HS0cw35Uu7bUDuEh4ybsldeIHu6Z761RwZtfU
         UetchwXeBKAs8qf0vIYEzUowNQmFrYMW98r6cz3JV6xjvDYsTv+paFxWMRyvSmXfxfJQ
         V16jO2rT0+LTqRiWLhgZ5wkHMpeNMcg2V7ufujTLy6ygW+XvRpFPX2efbslYnZJHi31a
         Hs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839278; x=1739444078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4Fpzu6vEVBo0wCJhRUrT6eOf6iL8Bnn94ks0el4cwM=;
        b=Vk7qJ/4lRRYM1R9qI+FzPnEyddNnjzxg2lsNntJDs3Q+WC3srto9xmrBxPy6vxwhm7
         rQxKdxiX/guoh5f5NbFJDA/5urjDHDds3Oh3Jcs+xDXAv8jOxwi4mEHQ1tEEF7yN9qOr
         j9cGaENIq641UIy8AuY6m8B7dyqQKVyRvwahJBH0wcOSzXyZi5VBULVcLmv0bNKgIW58
         BFT9XydLJdTWBKYm4uKz0uyZqT+apNRxMOIs8awS9SYpM8FzNNCR+7CT3LdhkIHCVywv
         yHQu5qigiRsA7imOrqw4vDxkfXL2jStPcA9OKS3DYwKVsgmiiwsvHHfQXQKyWNDCULYs
         KvBA==
X-Forwarded-Encrypted: i=1; AJvYcCUhT0aYtlpThzNU97MF0U6vLuvJGrcAQsh1IXHTpmBWJQba701f50saHuthFZoQCDCdOBt6o2UU3kyjMyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdY6o8sRfxgotEZA1al0b8DY8sn3NdKbnNjsWUh7nVYxmbjQnt
	NQ1bp5wzjM21CzkzQOy6yiQhVTbLeZbLQOUcJdVcQj2HIYaJerBZ2s1tbGk1Xr8=
X-Gm-Gg: ASbGncsL1towLfvTsaQykJjh/gAi7EYFF7o6COTxTGPSnKazKpUyi4SfYzr5B5+ocl/
	chNs+iZ0IncTRs+eICYuNaFG8k2ABOnJ1+8p+vpI9+Rmilhb2JHj1Uq66P52tKTJmdYq/Z/qDAz
	chAzl2I2FffX3FHMDeGM5gkAAsT96VhNr5x82Py3AzHk/l8lV1vVT1/MO6S8RhdsWCXHHIJ2Pj4
	F7nzGJPHT2SmbCD/LtwcrRXGhfY9XNgbrnsqUVfdIV1VkZaxz1SSmqoETpp0aWapkKUQlYir8Mw
	5LJEXw==
X-Google-Smtp-Source: AGHT+IHM5vaMe7dQKG64EkTeSRsdLjRkMoUvLfANIG4QYK0OqXKUcNrK28QFEfWzU8iR33/xEot5Og==
X-Received: by 2002:a05:6000:184c:b0:38d:b807:b894 with SMTP id ffacd0b85a97d-38db807bb8fmr3106134f8f.18.1738839277867;
        Thu, 06 Feb 2025 02:54:37 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:72::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc050d688sm912424f8f.24.2025.02.06.02.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:37 -0800 (PST)
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
Subject: [PATCH bpf-next v2 01/26] locking: Move MCS struct definition to public header
Date: Thu,  6 Feb 2025 02:54:09 -0800
Message-ID: <20250206105435.2159977-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; h=from:subject; bh=l+FzxzqcQOvCH8c5GurhKDmppajCdKyqii/WUkvzxT8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRjghejvu1V67bqXOIvMlrdiOA5EFuq9ml673Px YVwX7L2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUYwAKCRBM4MiGSL8RymRCD/ 9/YOhtMVXa4uhP+xTSUCPdwnoJ2e7ZwYDxog71LJ2HXxXg9/eSH8/Si/tA5gU1tWmG5QH+z9074vpJ vFqxdR0gSvIAsqQrBO0Tj1Qgtdyo22PRO5rV3ADONgAsBycwmCaZBA33dyS1teyYYdgun6rsOcUI+f 7pF1YCbr7dccOv8O7agZL2Y/864xfviCiuvbQTK+cwwdqybOxwT1eXhHNeK0iH7aUa6XsePpDTIUo+ Jjk3tHIskRifzXmI0/KTA1h/KRtLc8mbDdNugVNuuQ0Zglv9yZqIcVqy3z2l/OXaAVJlh5g0JO6dlM UFIZc61NIQP5h0n4mDGH9B1u7jcOYk+PiiJHCe89a2orxDwKXXe/wwnz5jKbllMykb9ikA9Ok+hW5d iP0uJ1ZTBE0OFUVJ7kZfX+CbwA9+l0dW6Sk5V88N8siHqhSZvKmyXQLvmnfjHCgGWq9VIkbzgNLFaZ yMEFQeShp0yCBfOTpqybarU2fc79rESPAl91vmwTkbkdGWUDl7ZmqaOlaNcnSsdyJIX4CxqqO0ad7h s2JcoMGOqNOzWMpcA7dkooTjlAydnB+BiivOD4kaYuS141fC0PntHgdN8c2hpVTrG9A64nnLBRMSVN wvOc8dXgBeQceXqmhiBDNuP6995mi4cgcucLwriFXse32y+vjJeqT2hqUBzA==
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


