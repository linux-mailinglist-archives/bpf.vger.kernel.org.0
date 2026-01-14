Return-Path: <bpf+bounces-78947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A92F1D20CE9
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7083330FB403
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147AE285CAD;
	Wed, 14 Jan 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuODXyiV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C46335546
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414992; cv=none; b=o0rY4mJEM4Vuj2mET8UkTm+zD/nxOGIYxjQazyqKkf989NCDLL/WM8nH2FYoxqdNnYtqKrV53skc0Zvx/V2q5g1jGRUvQQ3gwpvwL82N5wUX039cVFHk9D6f3KggZCmpVguzwv3+1spJW+xPdPpv0DeAuIbGee+4ZUcVMMl1Ar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414992; c=relaxed/simple;
	bh=JKBjbNUtBHESTjAIlmqPBcHxJGDK+qyh2B4o4yRVhso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olC3tkQug6P0bl60V/lTU24GQyVJJ8jIJeoOcGFcVLgIaZstfxE0Px+KWag2eJJ9MI+NxCLre1tM8wktu+f2wP4vjEMUzfs4eCk4b4sVHyj41HB38+9EwIozSIb0eIZuXQwZqZBdBW46XVFOng9EtrZbjdxkaLEUMWuL1TxkrcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuODXyiV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so1469945e9.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 10:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768414989; x=1769019789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCvK/g+wR2ZpmYXs/flQESilNxBrXWCl+GXchoYnBUU=;
        b=BuODXyiVQg73m1dJmSxew2gd+MMJVoRlzCtmOE5qJ45A6Oc5N1Ik5K11+y5uzDXixE
         PhnMxAnN9vd/wsygnz/YOKKsaHQcTxG5qML/KJ1VU+aKnccnRzVKoC9wCSzhg28HBjMt
         asmBvEoA7VqBN0tbXIQDRVbGndby06kdF1sYFG9Rnsg1H7Jk+tHr5rMNp6Z9LjilwyqG
         fxrMdvhkagGuSDuNAKLgo/+h+AQVD6vb6p1sPn4RaZIHCpiuIMRLS6YrBOjDysPBZRcw
         nMKzh7cVEk2I/ImLiAazi/FisNjyIN5RnO1yqOw4FIzuuF1IAEmiFSW4Wc5hZK6AjU76
         u31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414989; x=1769019789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OCvK/g+wR2ZpmYXs/flQESilNxBrXWCl+GXchoYnBUU=;
        b=XGKFWbUrGeEmKhM2CP/rRfH5ZS/OZ76BXjaDcRDc4AmQeAiQy0cBvic20Z8EwSRdRw
         PItOebDHWDx6cShkKYSq7NV7087siUjLE7S0rRRV3AbuldpYBHR+eXSkkQFw2bIqrHqU
         E0eeIbDwJbZbuO9Bcrucga1QWkv3Qq24lyCTxnqbwLPVxk96kgZ+feMnoIzm6nVIAUnR
         3ViHIcYBHfwYCRFgZtjhtsVphrGgLOblqJo7cCnvLvKx0x89Kh4XaxH65T6hYxa0TjbH
         GGFmqfQxF6n5/xkwh/KYKLRikK7/MoK3exMWDQ5roe/t432KQFwZEyhopCUe3QvWU37f
         K4BQ==
X-Gm-Message-State: AOJu0YwvE6lf9WYCxvhlZgny4aVOPLxlAIt2yuVBam6oN0TtWuCcTv5I
	SA1Ek530hCm8IcXfCA9HGllumzhj1XN9gVJFlaCfkB8CyXI/96tdhEwX
X-Gm-Gg: AY/fxX5+W0Lfbt4pS2GHuzw8XRZ/YKGJ4KH9TnL5yY1fCXmii2kggUgprBr0Az8hkag
	RbL2oEY3QJNHpbKptihTpX+zy2M5/r1ihzFF9ind+y/WK0NXrBCE15JSKhy6JFUSa65Sk3iLloS
	LVyK0FeAKsWF7a5ZRUHFcMVOOEUMSxUfMU+PsJd5lHDvpoTZ+KYgCI1s8IOfMSEHQRokAbw9264
	yHBAzfScixZAmUnz/zUxXrv5WqtafpyvevAaJnZUO0Vksygnv2DJxH/sBXj59dg49cSbUS0VdPa
	ri/XfUzhEM1z8mSnaqf2c+GSZajvWH4aUv9EgeniW7knE1yXDerDox6udd6fbcFJBzHL6R5dqif
	Am+rnGff9iBYGQO4H9rbaCRyObBobBIs6y15cnz2vVjDuFNkpiyU4/c+6cz0DPU+inCTwt+r1gL
	G23ie5AI4EDDddtQK+jJMI
X-Received: by 2002:a05:600c:3586:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47ee32e09c0mr45931045e9.5.1768414989437;
        Wed, 14 Jan 2026 10:23:09 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee0baf482sm26622165e9.2.2026.01.14.10.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:23:08 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 14 Jan 2026 18:22:49 +0000
Subject: [PATCH RFC v4 5/8] bpf: Introduce bpf_timer_cancel_async() kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-timer_nolock-v4-5-fa6355f51fa7@meta.com>
References: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
In-Reply-To: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768414982; l=1365;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=kNQYmljWMdi7DM85dEZ+JaKWNKuhehu9jT41Hir1a2M=;
 b=jByVTGa/v9DZi0CdtfEFPcnyuWCT5JgUL0WQQZsRoAQs5JornBP1hFGvtpQcv5Q9Me1dP62fd
 PLqzaZQcxTQDo3dSpMwgr1ov0tlo+Ri6oMTOi84tEeCCj5PC+9vrRBb
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

introducing bpf timer cancel kfunc that attempts canceling timer
asynchronously, hence, supports working in NMI context.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5d6938d23829b01aaa6b22ac0e2905319eb7f22..bc6cacfe13abc481e9c4fb4330b2889299175e7a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4469,6 +4469,19 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 	return 0;
 }
 
+__bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
+{
+	struct bpf_async_cb *cb;
+	struct bpf_async_kern *async = (void *)timer;
+
+	guard(rcu)();
+	cb = READ_ONCE(async->cb);
+	if (!cb)
+		return -EINVAL;
+
+	return bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0);
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4650,6 +4663,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
+BTF_ID_FLAGS(func, bpf_timer_cancel_async)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {

-- 
2.52.0


