Return-Path: <bpf+bounces-70123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C026BB15C4
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 19:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A254D19C07C9
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42E42D3A71;
	Wed,  1 Oct 2025 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHW4KupK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4D28137D
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759339638; cv=none; b=aHc8H0giv03yCfUBQKgqJo4EsBWHp+T5TFKk8uzj8PBq3WT4jQ8OpvGJW1hwGaIYoP5bnDqCvIlvwuZ0W8d/OC+jtOMjv9GMXqs2bu7x2MQ/axkxnYBDakF7GJWrvPr7KfFRvUstCpJAwHOHpu4e6iSKU1J1sIfo8nLZdbi+NSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759339638; c=relaxed/simple;
	bh=ubfK/ePH/veUHp40IZrgk6Me6lIRvwEW5VXGUMLKXg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HExq3pYdRcriBGZou30fW0vD22ghnjdTVgoFSMfbSGtM8n+7SvlMr1qrqpsUYE8usi+5IL7dLnHpnvJF5ud/7p0+YuRWs2flngidczhzpc4weC3Ti+i61ojxVCVG6vIwEYcfYA3p+IW9T7epRzDkUw2RhJlemjc+yp9ak5VlCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHW4KupK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7811fa91774so179988b3a.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759339636; x=1759944436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PTFSUhPIBDImToz1WTzPiK7finHO4CEiAocRP3PiLlE=;
        b=XHW4KupKdsR6s0K/s1RCwrcpAF8zzY9bkWofqBLwtLUwki1fFUf8rZ4QPQEHjoFHB7
         ubEmHBPHxwBX4GyAa75phaVpFGHDHtLk9zXRmM7gd1hBRNqAaQkLq3/pFaHjbffp059H
         7co8q/eb4Ol3L67cxlAfFUCwU49GzioeVbxaMEP9WnO+sMyt1ppLT2JAp1gzAjFdvsGg
         6uWQhrR+vUH7sHAqry1QJj1gSzmj8pgLJuAWB1QaMZ7ffEciA6c9MEYtMavCQmdoy/VS
         sohaCZPbp3iYJ6oiQJimQxGy8TDWXs96ug5lbu57K4YF7BwpJYrDTpbo3jw7EdICuefB
         jWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759339636; x=1759944436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTFSUhPIBDImToz1WTzPiK7finHO4CEiAocRP3PiLlE=;
        b=Tccsg1XZ0tfU5aTNhKKZZkE0ZC9gmvnZ/NcUAxb8zY6bb5rvAfuXyJy04BgtrgIYTx
         N1Waqnew3Gufxx/Ok9RAUuu15n5AwZ3YYvWp3sLfk5PI5Zrx9E/OyTPpgTTC6kGvH+AA
         h2NuajnM+ziqUdayBrPA0apkCBAEc3l1bGSyq+5JGWP5Qg8+FLiag/QVCIqaeDfdjS4L
         hjFeQnGbchDzvKa0lwe/mee22YlfQSDxF3JaU8ZbI5F29D3svXkkFHgcBn4cs/r+CkLS
         qOQ/CidLmgTOtCUkpQI5kHTwgxpaeV/M86uRo61rtOzcjR47ojmd2jQgFe4E+RJ4T+pL
         GqfQ==
X-Gm-Message-State: AOJu0YzlULZqF6quu284RNlQMIhCIYnbxsZThxXggjqD7yMrgEeIv1Xc
	uwPFpDk6DzSDP532KRvFZgz9G1z1EL8ql1X66o3Bq/0iu6o/u67/CR6aSLrbjA==
X-Gm-Gg: ASbGnctrx6L8JMWbMNlaRq9wG19jUkeqji3ySPOpgNcl/WKulijPzIsFTxiUE/hccQy
	IM0M25FDpeBJG/Hm1khP+k+RX82L6dQUS9w51M77lnbOsa29eKqiY6Dy49eB9OUDYEacxYsT3xz
	xEPBMDtDquVehG7T9mPE/cLw6Zr/NskyoffHPwK+EXNvG8YIGSZZrWWAyJ0Xz8Y5UQHo561rrZ4
	9WV2iSXOyn5CRROaWpqRV5l4xKjVOm4n829bfO0hZVVbBKKjrULPYJo/iftRFg6GD1J7RP/QFml
	mc1hW4an4vgP7ZM+iDcUXJgNyV6NBR8zJVLonibRGAOa1zu86jEkg8qktXBrKirh+YWxjf6buuz
	Nye8dsDwOzEHucnaT5gCb7rWcrYoySBs9D0l5ERnnmJp/xK+T8N5emAu4VOL3L1burMfYr83GY6
	2nNt7ZWvXoxfPK4Xgjz95x1OzPqXwRJihZ0Kxq02SxTVx7
X-Google-Smtp-Source: AGHT+IEcQTZ97wfnglG+Pjwc9RQfNW7erwNDt2Ki3vNl0N8s+MqP6fdnvV8TfO0hvsk2YlZPWMLnrg==
X-Received: by 2002:a05:6a00:3ccb:b0:76e:885a:c32c with SMTP id d2e1a72fcca58-78af4176844mr5177741b3a.26.1759339635838;
        Wed, 01 Oct 2025 10:27:15 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02053b77sm236976b3a.43.2025.10.01.10.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 10:27:15 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	rjsu26@gmail.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH bpf-next] bpf: Cleanup unused func args in rqspinlock implementation
Date: Wed,  1 Oct 2025 17:27:02 +0000
Message-ID: <20251001172702.122838-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cleanup unused function args in check_deadlock* functions.

Fixes: 31158ad02ddb ("rqspinlock: Add deadlock detection and recovery")
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 kernel/bpf/rqspinlock.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index a00561b1d3e5..21be48108e96 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -89,15 +89,14 @@ struct rqspinlock_timeout {
 DEFINE_PER_CPU_ALIGNED(struct rqspinlock_held, rqspinlock_held_locks);
 EXPORT_SYMBOL_GPL(rqspinlock_held_locks);
 
-static bool is_lock_released(rqspinlock_t *lock, u32 mask, struct rqspinlock_timeout *ts)
+static bool is_lock_released(rqspinlock_t *lock, u32 mask)
 {
 	if (!(atomic_read_acquire(&lock->val) & (mask)))
 		return true;
 	return false;
 }
 
-static noinline int check_deadlock_AA(rqspinlock_t *lock, u32 mask,
-				      struct rqspinlock_timeout *ts)
+static noinline int check_deadlock_AA(rqspinlock_t *lock)
 {
 	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
 	int cnt = min(RES_NR_HELD, rqh->cnt);
@@ -118,8 +117,7 @@ static noinline int check_deadlock_AA(rqspinlock_t *lock, u32 mask,
  * more locks, which reduce to ABBA). This is not exhaustive, and we rely on
  * timeouts as the final line of defense.
  */
-static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
-					struct rqspinlock_timeout *ts)
+static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
 {
 	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
 	int rqh_cnt = min(RES_NR_HELD, rqh->cnt);
@@ -142,7 +140,7 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
 		 * Let's ensure to break out of this loop if the lock is available for
 		 * us to potentially acquire.
 		 */
-		if (is_lock_released(lock, mask, ts))
+		if (is_lock_released(lock, mask))
 			return 0;
 
 		/*
@@ -198,15 +196,14 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
 	return 0;
 }
 
-static noinline int check_deadlock(rqspinlock_t *lock, u32 mask,
-				   struct rqspinlock_timeout *ts)
+static noinline int check_deadlock(rqspinlock_t *lock, u32 mask)
 {
 	int ret;
 
-	ret = check_deadlock_AA(lock, mask, ts);
+	ret = check_deadlock_AA(lock);
 	if (ret)
 		return ret;
-	ret = check_deadlock_ABBA(lock, mask, ts);
+	ret = check_deadlock_ABBA(lock, mask);
 	if (ret)
 		return ret;
 
@@ -234,7 +231,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	 */
 	if (prev + NSEC_PER_MSEC < time) {
 		ts->cur = time;
-		return check_deadlock(lock, mask, ts);
+		return check_deadlock(lock, mask);
 	}
 
 	return 0;
-- 
2.43.0


