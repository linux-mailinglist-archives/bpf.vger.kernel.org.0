Return-Path: <bpf+bounces-50650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F01E6A2A67F
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB0F166A93
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A79230D05;
	Thu,  6 Feb 2025 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUwiQWGK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66691230270;
	Thu,  6 Feb 2025 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839303; cv=none; b=kBY7wG1wrMnM9heoBEBrW8EwAUd8xShafnkGTCFSFv3c0zdqWs4ysUFx6IYa0HqwDu/bTVUtQ8L6HzsmtYEWiOrF0d35kwLOuRtVTB5dI00bPqEUZ91HnL+FDpXJyBx+SAQ+EJ1mOB1sx7Ngr0K/HMmgdhttd4gk0tlimmNXR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839303; c=relaxed/simple;
	bh=lkeMxyDGnEWVT4+0Paf/jS31tLo0YsbXyTnTYAfMTz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAZ+NFgiQ4HPUFkUqVCcj49el2+uOli9pKgZmRa1w+0WG6nXVDazyKzkhMIesII5HFU48yRDghU6HQgg3yHRHaTgMbpjtl+BNWZhwGpAGV1gIMyEOTmZuQpLDZPwvX4Noy+3th8FkdZ6Ma1hHhAibD+8kKtSX+vBIZs2uJwj75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUwiQWGK; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-38dbaae68a2so598307f8f.3;
        Thu, 06 Feb 2025 02:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839299; x=1739444099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/27xKgFdSZVO2eLH/O6emznfiz3pieZcJIn5kKU89M=;
        b=AUwiQWGKHYnXNO5BoV419wqq5G+Viauj5tWbYjWWnXKiDsndyh7M/CrPbWQf0a8abP
         x++4EnNktkQ3l/zvc4oqVOLpdSZsDZ2ByjlV+8G9yJ7Y1D0CQVuBXgjCTWxBVKntO+j4
         mSpWEoZ9tmCUgw7NFVBZI29dP9xchkrhV7R/IX3EdXe2HOvHfBS8eHOKCOR3ZqqbQq9P
         HREWXRPOAGmAmNHl1cY95rYuFNljKFd8YZLBblVHtKhnQkgSsncoEH8mWZtGV0qtOJSr
         X2SWAEefwZCNya70k+Zihbxdvzoe/AhbOIOZ+RAkMz08WQ3QVBfFoqSDgx2AiwtDGI/D
         3LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839299; x=1739444099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/27xKgFdSZVO2eLH/O6emznfiz3pieZcJIn5kKU89M=;
        b=Hjw8G6LQ6Ut/ONWr37xZQejIrHcU2PCc9XQvZSYknmxpEFrRN8o4ybJqiHnZkmk9Y6
         XgfjZQShwoaQoS/3C8XmJSncRXp3itGN8zZm0QcEIAVOtH0pULexky+TVZ728ZY1Uo5T
         VdUhbbz/BSHu/JHskmFzW2Gwe/Wd9kBgeX813Pkx0/ZfmxH4yoFafiXcsuvzViSMRWpq
         6FBUxyOeR9L5uyN1R5/6lEm3iAL11EjGRk+6fSRbIYxE0FnBOrKWW98baNFskZgVmBQn
         GEHKFgwKgvkuylg/970iZE/Jx7emImEWpXJUBstGghvf0s0ysxGRz6UzDSnLGFgcrOpo
         Aeug==
X-Forwarded-Encrypted: i=1; AJvYcCUIT0G6mH/dmX2TMq2lOpkO/UI3xe8ysBX3ar05hu6yBxCm5/dR4ZyoigR5/H+H7CPIRXNLBEEI7akVnhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0hRxakGQL3BG3donNbrbzrCJz+v2NRNAbSK8WNe/6ky/ZEZIw
	VYly6vJkExmMTuKUtrS2uiMrf0jrKr1o7YkxeuTzY8qnWFYkUienvZD6GoTGChQ=
X-Gm-Gg: ASbGncsFHa7USPN7082XEKa1V5Xkn0/ut8LTd1Yp5A2aLxh6YtZDspEortmeS006KMf
	djykXZV6ka9xvfJM0h7mqz1db2sDX4e1HlXAlaEd8JuuAxhUV9NhFSNDJbHohero3lJ6EaWxv7Q
	KKdCq9VxavFMpanw4aVBH4bZRR78H7weJtL97IqHFTq1iTqfsUMrJMZ0TT041JEmMsx1Ya0Nmsl
	euNVmtx7A6X0XuYfkwbjJs+mV7lPuyaE3G+wbpevrwGgPS8rN0gT7hKKQg15chdC74ZXDb13hcl
	e0Oc
X-Google-Smtp-Source: AGHT+IEaxBrKjdya80s5GTFvJ53ssNGQMjtcN2JFoVjdVKyNSB8TPhmiwUVzhaT6kIG4/mzrT4zfQg==
X-Received: by 2002:adf:f9ce:0:b0:386:3835:9fec with SMTP id ffacd0b85a97d-38db492a155mr4449175f8f.44.1738839299377;
        Thu, 06 Feb 2025 02:54:59 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdc30fbbsm1419486f8f.0.2025.02.06.02.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:58 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 16/26] rqspinlock: Add locktorture support
Date: Thu,  6 Feb 2025 02:54:24 -0800
Message-ID: <20250206105435.2159977-17-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; h=from:subject; bh=lkeMxyDGnEWVT4+0Paf/jS31tLo0YsbXyTnTYAfMTz8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRmHQ2YyiZ2nANvO6JQtZoHC62f1PKXDNjawAxK mKA8GLiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZgAKCRBM4MiGSL8RyjR0D/ 9UxpQJ303fRMoYR6fqKrESf9af9KoWduUW16ytQ8cl8LUmJvwPsQA2RBgUKdWqIjIitbNFRK0ahuL2 G3ZxiZ7lVlv6kVhyOprX9Rp9/1KXJb9AssTbXNvRGsblLw0VJWdbOxKA4CzRsqXHpyhAZw+crjWaAi e76bz8XD/UpVFVgPBoDM6XHvEU2CQz9W0Mujyrr8fIKId/Ly9v+BzlYwvJ5Dwiq0pKOjO1wJSs2GSe xJNqUgPJbtFFLsbyNGsWDMGgSm+PQL9V4lY/frjPS48Pxdu+urR1lOEEV933OLvUjCojgSyeFrQFi4 C7ca0HI9k7+q8frWCz+Je2IqiCXf7yXlCIM2WkxiNzINim/wLLzaPdOeueZFq4MdMjMZBhCcUB1Rbe mRdSVBLs7X7Zpm/3jue63s7r1/T5Zdd+FnKnX9Mx1pbvmw8d+u28kL4LxsLFp3fBS3zeo5fKA1b74I aPnMh8oLweieJCNzHBtJmoA+8bROXjIbWCktLpZ6wtoxPmkgKNC65kw8ylP9OD9mtdz/bYC6djzAq0 WjHL34MT7pIHjgbJe86Kbe4rqIKg2p+NIDSL06kM7XS11ju9ee0SrcJYHqw/rvOlMJqzWxf4Nv/Lcw tVGq7vh2z1O7XmMCOh+d4cORBxDlJ4pqO/LdJnm3CeCaaMqsWEXlmgSV6ZRA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce locktorture support for rqspinlock using the newly added
macros as the first in-kernel user and consumer.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/locktorture.c | 51 ++++++++++++++++++++++++++++++++++++
 kernel/locking/rqspinlock.c  |  1 +
 2 files changed, 52 insertions(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index cc33470f4de9..a055ff38d1f5 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -362,6 +362,56 @@ static struct lock_torture_ops raw_spin_lock_irq_ops = {
 	.name		= "raw_spin_lock_irq"
 };
 
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
 static DEFINE_RWLOCK(torture_rwlock);
 
 static int torture_rwlock_write_lock(int tid __maybe_unused)
@@ -1168,6 +1218,7 @@ static int __init lock_torture_init(void)
 		&lock_busted_ops,
 		&spin_lock_ops, &spin_lock_irq_ops,
 		&raw_spin_lock_ops, &raw_spin_lock_irq_ops,
+		&raw_res_spin_lock_ops, &raw_res_spin_lock_irq_ops,
 		&rw_lock_ops, &rw_lock_irq_ops,
 		&mutex_lock_ops,
 		&ww_mutex_lock_ops,
diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index 93f928bc4e9c..49b4f3c75a3e 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -86,6 +86,7 @@ struct rqspinlock_timeout {
 #define RES_TIMEOUT_VAL	2
 
 DEFINE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
+EXPORT_SYMBOL_GPL(rqspinlock_held_locks);
 
 static bool is_lock_released(rqspinlock_t *lock, u32 mask, struct rqspinlock_timeout *ts)
 {
-- 
2.43.5


