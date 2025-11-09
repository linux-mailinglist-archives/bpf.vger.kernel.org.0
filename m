Return-Path: <bpf+bounces-74016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD7AC444A0
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 18:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DE7F4E3C34
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B66228CBC;
	Sun,  9 Nov 2025 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oecbm9re"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EE4217F31
	for <bpf@vger.kernel.org>; Sun,  9 Nov 2025 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762709829; cv=none; b=HKOxgYj8Bs9P8RdrGzgXiNP4HTzxoLZxGpnFsl+NNfaGm5rT53uExRoMlp29pFOOI2qyBZ+fTMkp7yVr0w0nJx3BLX0Y/sUbkKaXuP7Hubirkjk8nzpYCxOpixRneLQMLa0er1KT6e+uj4ZBdR3XhkZkoRBcmvKBmlX55tGsaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762709829; c=relaxed/simple;
	bh=Wb3tE7c/dmu07513EKo/FSElmVlMfDZpjkLJ41kDH40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhgCJk2WzG2Pkxo8+rD8U6C/qToUru93bgqTaWgPEvpCnYXw9PlIaJyILMU51q7D4SwYQW6kLIjgGlkwugJByFvZiYhIiqPK5OZGJXhq/ihZhgINoOg0Bfl6LYuKoSespQu+lEgom/EYt3ZIW7RBzgKWcVfWj/sREvcSBmfw9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oecbm9re; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3437ea05540so633753a91.0
        for <bpf@vger.kernel.org>; Sun, 09 Nov 2025 09:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762709825; x=1763314625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/2M2flGrieWttfrfxj9I55hLNbMitMROgQ6YPWlAilA=;
        b=Oecbm9reTghgUr+E+yCGEMm7OIPDpzCzAFWj7VorJTD0cwkugUZ5/fvGZupLsWLRNW
         SSfwej7FKfk9lSeLm/Yoo686TqhM/R6k+La8wv8RtEwyhFsegO2oRsvesVLaPjinvkc2
         BF8Ec+QbD4wLQCJbMtsrd9AlJvNVG065GJOBlngcZfTk5tP8C/teulczrP4/tSWTqw1M
         fUi0QQjehbBKvYb+fNg+pGa311CqqAOOs7Jb1a1zB1HluZUVR0LLwKaJKjy4xeChCCWU
         U/hO/cXDt6KKuzXSI4MFtkQDwSTKaicvSv1nSZgK9VSNeynbKArzM2JjLr6WqPsykQHB
         DmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762709825; x=1763314625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2M2flGrieWttfrfxj9I55hLNbMitMROgQ6YPWlAilA=;
        b=mkcpH7Lo72tcqnBu7epgniHscYlwi2PmMiKFtkJ3HqbO7CGjmWa7sgbugGn+U59NM+
         gVb6seCgQSG54OUSvop8aNQWLXRQeVdwvM1+5YPrmsairaWQrKY+Pt88F4WJ6QL28qZp
         R6IswkqAMlvfo/8i8VOROaNXdzez8Bj64K9KZOHhxvrxLr86TZs2p2gSA1DrS1qyaxHc
         BMIYbYcuMzqheje/g54uQUWjZTPbV8o4ObIGix1ZUosBuGdjtaAMd5cjSlM259bnnTwU
         Z0At0B4Az5l8xW2Ezo7ez/wXosISgUuZVM27G+cWqdjt2ADICH17VfXtz8a1Qi2lrbev
         rdiw==
X-Forwarded-Encrypted: i=1; AJvYcCWPes8n0fq6HPrpwvoDAok3qCcjyMh7FSXU+bdYkdKADM2Iv70PTM8mmkp85YpbtIMzbvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYRuZAWs9Ao1qBmlujfeR4PVa/T6V9/IPB2HIocbmEd0H1gYK
	pEeGNeE+WwyMMgNpmW9qs5dU4h+iCEdyT45pbOrneUH+h7PxxUov6yph
X-Gm-Gg: ASbGncts2PnPA+J3cH5lTCYIdsIJG6gcNjMCdGckQ2GmFCJtxUU8nCNcyuKSuiZe9YM
	4zt1mT0dG9nmgT7Ij8B0CcY1BBDdu1qoSy9D0vVOTMyjeQju3OWodITYjmn43JC11IMLRMH7LTE
	TnbUGH7o2yosz4bhPXtwSQ4GQ/nYA6GCvehLdL3EtUCC/SarpxgRyK/Q/+NtjB9BiO2iO4xNuPY
	aRjZDoBhCyRJIz+B1QlAusML054/FIAba8XELUeQ1Ki1Q1HQR+fCm3BOCkBgshJ66IdGLSMhKF3
	Dgyp2wxWm+wmcDy8//5iLjrumlf3+4oK8ZcMhD9d2c7tveFnVKarOxKU9f1/UaVaXpFOr1+KHDM
	poz3GbPKvjg55WwxZJVGk21rWN4piAVZFJfGbrwDkMNThPCtbZhkBkcLseUkO2B36ikjGzM7wh5
	N2x3hItZG8ZL/Beog=
X-Google-Smtp-Source: AGHT+IExyUWicwK6lUCVCk+d7+U1PD6jL3gZpcOu3pGvdWDSUZwKJkahsVrZq/KrEPZ0ea2oOvmYNQ==
X-Received: by 2002:a17:90b:2f47:b0:341:8491:472a with SMTP id 98e67ed59e1d1-3436cb0d183mr6823789a91.4.1762709824965;
        Sun, 09 Nov 2025 09:37:04 -0800 (PST)
Received: from chandna.localdomain ([106.222.234.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68c822dsm15059310a91.8.2025.11.09.09.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 09:37:04 -0800 (PST)
From: Sahil Chandna <chandna.sahil@gmail.com>
To: yonghong.song@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bigeasy@linutronix.de,
	bpf@vger.kernel.org
Cc: Sahil Chandna <chandna.sahil@gmail.com>,
	syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.comi
Subject: [PATCH bpf-next] bpf: use preempt_disable/enable() to protect bpf_bprintf_buffers nesting
Date: Sun,  9 Nov 2025 23:06:48 +0530
Message-ID: <20251109173648.401996-1-chandna.sahil@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_bprintf_prepare() and related helpers (bpf_try_get_buffers() /
bpf_put_buffers()) rely on a per-CPU counter bpf_bprintf_nest_level to
manage nested buffer usage. However, when invoked from different contexts
(process, softirq, NMI), the nesting counter can become inconsistent if
task  migration occurs between CPUs during these operations. This can
result in warnings such as:

WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_try_get_buffers kernel/bpf/helpers.c:781 [inline]
WARNING: CPU: 1 PID: 6145 at kernel/bpf/helpers.c:781 bpf_bprintf_prepare+0x12cf/0x13a0 kernel/bpf/helpers.c:834

Having only migrate_disable is insufficient here to prevent nesting,
hence add preempt_disable()/enable() around buffer acquisition and release.

Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.comi
Closes: https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
Fixes: 7c33e97a6ef5 ("bpf: Do not disable preemption in bpf_test_run().")
Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Sahil Chandna <chandna.sahil@gmail.com>

---
Testing:
Tested using syzkaller reproducers from:
  [1] https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
  [2] https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb

Validation was done on PREEMPT_FULL and PREEMPT_RT configurations.
---
 kernel/bpf/helpers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index eb25e70e0bdc..01dbede0ecdc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -777,9 +777,11 @@ int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
 	int nest_level;
 
+	preempt_disable();
 	nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
 	if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
 		this_cpu_dec(bpf_bprintf_nest_level);
+		preempt_enable();
 		return -EBUSY;
 	}
 	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
@@ -789,9 +791,12 @@ int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
 
 void bpf_put_buffers(void)
 {
-	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
+	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0)) {
+		preempt_enable();
 		return;
+	}
 	this_cpu_dec(bpf_bprintf_nest_level);
+	preempt_enable();
 }
 
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
-- 
2.50.1


