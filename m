Return-Path: <bpf+bounces-54133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2D0A6339F
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99691886ADB
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A4319F13F;
	Sun, 16 Mar 2025 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZcssJmE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F2019ADA2;
	Sun, 16 Mar 2025 04:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097970; cv=none; b=FiRL9/R8XBdRP6H38cbPbL+DhDt95BcfjCbSzawkApRqUOYTZ3gmajjbUyFmkUSupwOnnFbc0qm7nTkhMnmWOnzVdl6xQ1ggFKRtEmy0hN4zSQ1q97HLieqR5z1/jLwkphLRzL9Wt8VolSE8r1RmQCDTy5bQVTkljp4MP6IYRIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097970; c=relaxed/simple;
	bh=SBe9SrR1gqB5bS55WnFfwdHWzM4LavhATA7RzB99U+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MO0NN4YyT0Zn/Br8TuFTiOAI/4oHJnHWR9/c3pBto92/GVn2WGyBQcLaT2r5TIYFn2sQO2d4XOxFmVJksUCkNPfupNYF0/FWgG9fReAah2P/uh+DPEQ1inkHBXIoVKz/qDi6PO94X810MEhdPIgT9yaHrnyR6EQd5YrisSoQ5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZcssJmE; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43690d4605dso6607925e9.0;
        Sat, 15 Mar 2025 21:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097966; x=1742702766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elS4VXsAjSZVIDIoCNxyLW7RW0fHjd1SmHmDu6oNDNQ=;
        b=mZcssJmET5txjquHTJS05NnT9IxD/rQxyTpPFXsAGAM/hF9DAVtZKwK5VHIYOE6/mP
         H21VuraN9GCcvgUZO8CQJLBgczLNxnkKHKdOhc3alB1S1uBpEDkEzPBOOuBZdgDor6Hq
         LY3mAOx2WtVMV5QgaHaxJG87GIOLzZY+IUTEZGa0OM35sHD73ZaqsiwNaNdlyPTcDGbT
         TRPI20t84yESEj5188We/gbVQYw4At4g+4uW+hqPyVAAOOfHAMLUO68eh5ACVR2YLXuM
         3qJU3nDPuR07VZw+ZpvtxSyK1MCqgdLW7QEiw3zthS2SM5UX+vgMO74Gsk8latjALMD9
         xNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097966; x=1742702766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elS4VXsAjSZVIDIoCNxyLW7RW0fHjd1SmHmDu6oNDNQ=;
        b=H0Q0XZH6znJfAyqyIKM8ef595MVuiBapxhVvzqx4Pqfs+XHysDCCV64WLJqOa2o5ZT
         GknR9zDQVmLyPDGPR/EOl9aMr++qOBvYdc9coBB4BYOSqrYhh7jW2mh7aVFvKp0EPmyH
         diCsM6sxOrAJT64nrUGAmIgVqG0OueTCh+g4Vx+Run3owowAeWBbHaae/ynL6vedd1oY
         ZJI/ir/DzywPCr0nH3XA7Hr2FGfElg/mSl0lw2QK7gXVBGhVlgeJx1Mgo17F1p0e9PPt
         PJNUGWbgiC4zTTmK5j8fTKXuZHMoK28WQODZUgK9WpCy7C0l8XkOphQ16ZkOEzCcalBv
         ihAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5/LbSU3foBghE3M3+JkH32Yjkdi9QSk49TCQ/G8OKB+fP71KNEKX5cuGCps12ihfoO+WMeoH5P5qKVbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj3TjpSY8SlSqVCmXJeHzbd4tzJ2BAesVgW7MlSrGQvPk05cGL
	7/NbkISj5jBG6IkOg1EwmOKvt2nFJwBni/LJCqISQR3ucfIWqSvRloqogc2Rz7Q=
X-Gm-Gg: ASbGnculgdrakAvCcvC53ynG9+uEmV69TQWNLdeQcR0idO2CRtokH5KBh8ZkIaPm5Rk
	eIVwu4BH+eIjw7A3sM0K26yxuXSsahkAodHOQqjQnpprRSPygRTteF86cAovp5dp8U0NmTb4jfW
	BFc2yuTI55mZXPiS4mJw9MUXI/FVbV92MWRAoIVbYMC2N8EWw1k7rX3544QKe2cLyJoYWsHXwG0
	il8TaZDbKP5JNXjMzfS6KmRdwL8UZBNSSPOgD+/h4KSD7WQ9EKZ+cIH6qtpwzKae5C32pV1tJ2E
	UUYGMg33FaqHhl7s23H3gkVvTXyS+wukeQ==
X-Google-Smtp-Source: AGHT+IEnbdVB/nE2Pi33KFYYtnULRWUI98TYw/MBJWQBTX6XEUdt0SDKhZrXk7vHOjd1S2LDfZ7qnQ==
X-Received: by 2002:adf:c790:0:b0:391:41fb:89ff with SMTP id ffacd0b85a97d-3971f60b104mr8750937f8f.27.1742097966388;
        Sat, 15 Mar 2025 21:06:06 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb9ccsm11053346f8f.96.2025.03.15.21.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:06:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 18/25] rqspinlock: Add locktorture support
Date: Sat, 15 Mar 2025 21:05:34 -0700
Message-ID: <20250316040541.108729-19-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2633; h=from:subject; bh=SBe9SrR1gqB5bS55WnFfwdHWzM4LavhATA7RzB99U+Y=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3eNpMeA1g8bEkNbE5LoMw6rWgMD0iqfFTREsw3 1ViDmC2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3gAKCRBM4MiGSL8RyuqtD/ 9/IGQPEqqIYM45Wbzz/zxdRnXzdviyqlrvI07Exouh0vJd+riQkKUn0fvtxOmYGiW0hf+KSPes3ypJ tSGUhUEHoy4KZ6aHeBpDd+Atw6aeLia+nCh/xXga/cb8an5pVO+3oHinEiNot2dfTsznbw2rgqLI/o 18KlBPsGuCz9o9fNDbrrYW89iCAR62qZm/ELBGZ5tUXVLKJTJU5+/FUG2EM+D6yyeWllgXPFCL9B// ySaQANZ8Bhy9vbrVe4wW67L581XJr2ML9um5yEfmYDqkTanYBBHCU+e7kguhEs2Q0bjT9F9AO609C7 uL1NTzcDsH6c0Avd6a/ITdoNp1E4ZvVp6HQqo/pBk6PXgu1gBcudXCyPs+Igx8NV4FiaP31yQ5e01S 9UbxJSSzxs2+fgRnO/i6pqNrO8Mktz8buhxlr5r2gqkDOXqWeWZEDHrj32fD3WgY7j99ENTR9y98bp L0wcKbx1en8AJckwWYMKtSC5TbsAU1rBvKW1jJtjXsifakOYMtf+dASlhIY/fIoefIOQ98NgY3wJDS RwY9kcDNvp8LkYBgR0/kRIpMAkUqpoon7lKnqgV4ZsxKpi8p5BN3ZSvGMbHMrJs+4gaGIeSnBJFaNM 5Lj0WTWrsYOJXYBXA0iaogmJAwZ8UtN5+FNxg+SHFESqpNMmvjruoQOLu8vg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Introduce locktorture support for rqspinlock using the newly added
macros as the first in-kernel user and consumer. Guard the code with
CONFIG_BPF_SYSCALL ifdef since rqspinlock is not available otherwise.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/locktorture.c | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

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
-- 
2.47.1


