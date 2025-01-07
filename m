Return-Path: <bpf+bounces-48114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC55A04181
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28AB1887F4A
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E59B1F4286;
	Tue,  7 Jan 2025 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETCozqCi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0D71F131C;
	Tue,  7 Jan 2025 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258442; cv=none; b=pu7vzas+xouX3OL+nqDGgr/BRsJte/8JQLlq4YvifpI/KwdnK2pKbdlcravbHw9h3G2fEslMRohBIkF1UINBHmP6/ZVNjqiZq1VtL6YLdAIIwQP6CvzcSgm91NGIGy3MXJdKrLoKuoh5pr06LuMuvRifw7S/6xYAR2cC4uANLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258442; c=relaxed/simple;
	bh=kJwiyjXFeK0kbAuecq07qq2Ed4NzRpp2/JL55Sm7hfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWhrfxUOvDHDn/dq2yUX9j7GbNZVcL3kKvyiaVnw5Y42qKV1M8Adk0u5akCFPCPkuGsAZxMTd+FJDABaPfPpTctOnlzIKw6fCZ+/oLqWiFofCgUpeT6cN0OKHrgNBvWAMkZCZYUob98FcdyDuPEiC9Z1+QUGpO7PRqdGEEeCDvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETCozqCi; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so8526388f8f.2;
        Tue, 07 Jan 2025 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258433; x=1736863233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9xklAp5T7bV+X+CaErK/4BbIoKeDnGWA2MeVPN/LNA=;
        b=ETCozqCihL39YSqk6NlN/S2L+OcfpWngISXUD/ox47hfZGjKcgvLlltmlWcdfDgAGJ
         BDEMb0AyK8PFs3i9IWfTi0UeKdwEyBjWs11rtv/yxyy4T/0OhMQXtLNcvkJwbc5mH859
         M3sRjiTevabl5dnEdKIM4iB6XetHY1M0S8ld2k6bv66hFA5RWUWxNRE/dtZmAjr6M9ES
         116eoA+TX21eEjKaHYR7vqxXDl91IqOA6FMrlLBzqRxO18rKqJ/SFIBGn0ufDFfl0tXQ
         KlRo+TeB8pjE39jGVGKg3VtVfrWc7NO7BFIwqfgN56/SIpjMeM8irXlHgWzHA73zSQ4m
         C8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258433; x=1736863233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9xklAp5T7bV+X+CaErK/4BbIoKeDnGWA2MeVPN/LNA=;
        b=FR2bsY3sgojhMC5k4cXsZHUPAqQQl/uJzAdlwVhqkyPl4MsTKegK7Bu6AWfU4H2osf
         zGuLo15rByR0AGT7LBLsj8SVrVqfVe2BYzlnU884mDnQO+IBNR76y6Hb615FlOWUAuaY
         1MC4/uul1Z+Dzwov5FupXZPXat9cCMKNZghzZV5W2ff6SWlDHUF+wyN/5zHLBZuCH8hX
         mznPEqM3FhzwosWASMVjM/h0MDlhz9kt8n9PApfmRr3TG58d3DFRs5Bnq5u1qyhgKdom
         r9BzZDrrDXCxeIe9sc2dK+2qkOZkEXTH03JIs+osQhNMomTumDToTfYklTHpm9X1Gjrj
         x3Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVs384yY4NtGbYi/lOez9dP1/0maGJYrHCXVJEsextwIGokO28dNT+9/R1L0gL/fWO4Lg7ni598a1tH13M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxHw3g4QNRHvZbeBV7qljltbUP29Le/ykTrO53rs1aCYaD26H
	BY1Pg7wGJ/uebTcctj0GnXL+MDtpN2fn1/imu7BfZbFPJTyr7HnDJiiNaBMyDbYvww==
X-Gm-Gg: ASbGnctNycAd+okPb/YNLfwx0GTylAdjL0lQuVEPpquTKGEExySVQsb5AocX9fpF2Wk
	9pxvsMCufznoL91KVbDI0PctXqSDw9wipfcIfGY6CzoboH3tJVuMeGb52CXNLqvIKqNsVTFkFnW
	qhYYw7yWK8u3J3V7YcBODmw0M2FBAIcheC/M6+jcI+2bdttUw3KuJuq8aDDwRpyUaCUnwBx5An0
	qzc7Euc0/AzEQhgaWQZmmDwabRNPKoMVua8cgWkCP80cQ==
X-Google-Smtp-Source: AGHT+IEsxrWwpFJrtsfOm6AgcJMnVDxtLA4K2laEeRp2CCwsjr5JXjmVwIf43rIlpNfRhbgfPgxVFA==
X-Received: by 2002:a5d:6c6d:0:b0:385:fc70:832 with SMTP id ffacd0b85a97d-38a221f9e10mr49545102f8f.16.1736258432624;
        Tue, 07 Jan 2025 06:00:32 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:c::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a28f17315sm45033426f8f.108.2025.01.07.06.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:32 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 15/22] rqspinlock: Add locktorture support
Date: Tue,  7 Jan 2025 05:59:57 -0800
Message-ID: <20250107140004.2732830-16-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2982; h=from:subject; bh=kJwiyjXFeK0kbAuecq07qq2Ed4NzRpp2/JL55Sm7hfM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCe5KmCSuSd9mM2LdcZb8GYSohl/x1Jvibb1Hdu iYe1KECJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wngAKCRBM4MiGSL8RypEnD/ 96FIqsjGRFcCnCJy0k6k6rLkuZ0umtG5fVLQL12gf64SzNuP3q/++JUiEAyZSocdSHjKHEZZdf+j7G 5Gt2mVOxAxvavz6BDHBa0ldHyHDPcmDYJd1gN5Ya6C2IqMAz7F+KPrmpZ4hWCKdSOw2IxURW7Wx6/D btp7VzcjcuqGZOnepibuXwYAAptPF5PESU77UEiWj5aX7K74xm5qxnFBrche+qSJW6+g0SMYaYBteN NNxG4u2mHeS1MoXQBvL4qjh2SZ4jguoFzh46nYmicQbArVCY+Nh0h0KZpJww7KasFTUlIwfmLbcjzz dYJlflyRvWVMdmLixJgBJNkT2Zhj/+iIoSXFOb+6Y2zAnv0ZZza2yPZHTt6SZFKIANpPBKBwVqX6N3 CklqXIzXkdFyzu2/NOUJUwStnq/8DWceHLeLbyZZ93mf1dXNdkJcOHo/VU+VK0yV6iO9/dwmE/aqm+ cRu9/1FyzliKuCCfEelMeDwCOFUCguWZH7mi+TD8iq8v4Sq//yts/30JTeUMe7cPmZxBi5juA8QWGs iWkOhXW9bNU37QpTDGeklCrGsQD0KO7JXY9W80Lo5DhEj2qQGw2CmtqmXdIOSFwA5pqhtnhUANN6zf M/DCcqpZfe+ecwLkaLmFihYVOtrYGQTMmwgFn5YEPQmlhf/Bf58hI6Hq6tCA==
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
index de95ec07e477..897a7de0cd83 100644
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
index 467336f6828e..9d3036f5e613 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -82,6 +82,7 @@ struct rqspinlock_timeout {
 #define RES_TIMEOUT_VAL	2
 
 DEFINE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
+EXPORT_SYMBOL_GPL(rqspinlock_held_locks);
 
 static bool is_lock_released(struct qspinlock *lock, u32 mask, struct rqspinlock_timeout *ts)
 {
-- 
2.43.5


