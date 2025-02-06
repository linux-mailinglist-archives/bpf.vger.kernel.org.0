Return-Path: <bpf+bounces-50644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 227DBA2A671
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A618168095
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40B022F390;
	Thu,  6 Feb 2025 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZVCKj3P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8EC22B5A1;
	Thu,  6 Feb 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839295; cv=none; b=oSYyFV0ah6s2KkVlvrM1QKEGQp3+9pF+XluAz+N4OAk7gJcwmbZyyjwS+Xn9lWorEmmXIkI5fcRyR3QRnDOw2ls0vtjH+ig7NkKa3PoB6VHK4NtUe2asv1TjYZcVaU49Lk4bfu4Gsa4Yx4D4JC5NSakVLk/ZMg75Dl8v79k/oxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839295; c=relaxed/simple;
	bh=jiFbzaZcn62jcwbclsn6fFlBfAVbcfgq/5K/rfr88pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1CP+gyzYOzS/kUzvfWs7YDLPmQoowbwEqRF94YPnUof5dbKYi5N00KLD62VVz11dWCE2l7G3/uit4/ya8jXylQBPSAIBzpQyWe6rHScxZi+1W7QlSvbbu/azWAELTJC42dm0REgbOlED8EkycTPtS/mQkRBbQciUVMEJx5q8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZVCKj3P; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso4507865e9.3;
        Thu, 06 Feb 2025 02:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839291; x=1739444091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vau+zNCewZiHW38t3Nl8HxSJyuVHZ3A5oWGeCWcGqfM=;
        b=UZVCKj3PsaZCa/LJ2SZJkiydtrRq8UnHR1yV/fcAJpgbsvLfHs5o6zMARakQI15vlh
         yvoN3y3Oh6YTYtLEIO7x+esHTsY8FZOxr95hNVmqTPC21zKYHFvfBdHtxUnvuiRpY2Z1
         Br4v9G8Dywl3oXba8P6bVLiwz4SuF2Cx7b9pCTXyzMzPDYVLGTfH6YOUrR8yQd6q1P9I
         lgAkdz6Q2wQRFgFwZR0aym6OlqDiYv4zmc2IdGL45CcobsGTtKtylaj0isMwYzpVRHQ5
         9xPdyc7euyRWYwPl0Zc8OwOHk2YmI8Vh0vd7KwPaBrWI8w1rNXpw4c5rq0d/M/nOXDPf
         Nfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839291; x=1739444091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vau+zNCewZiHW38t3Nl8HxSJyuVHZ3A5oWGeCWcGqfM=;
        b=EDKJh/PyrgC3ugsj1u1L34ETX6B+VN8Xcx6tt6R/U8wGTezIcHI6rBWzRlizb8rgkl
         SutEhHXUFZxjuReMCzeVzSj3fIzZvOwI/JHQiWw+0xJCXIU8jY5bgLZVffzfgq62KlQ1
         ZC7/+to2I1w20G1Hc4aSaJt2UF2UE4SyHR0wpwV78eeDlPE2tXbeROa7hP+7XD7GBknS
         VwmgOZLzFTT54a+y9pNCU9HpnSKo/TB4QJhKrJX+vBRdE7f4/ISryAAtlFwffir988Z4
         m49u1Y+n5kzw7VZiaXbfc/di2Gr9xKsyJc2hdj2u7MJ8dlbkyLpbHXIooWvCCqKv4RJX
         mj4A==
X-Forwarded-Encrypted: i=1; AJvYcCXd4gmiICdJarj9mKh8lQsxyZXmIuyoPtkSPKquhza8vcfsEH0aj/0I+YyEANTPW1shT9o4t4ulogbW7LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPK9nPrHLuPDQIqUtnNBas5YxFmFVBrNf+JAk8a9Khu+wbu8/y
	nskCYD+1pzSDO0xGS1p2+Dd+M5SaB5UDW6OBFkywgSZnJ9i2yqJVwvVgaX6Bjgk=
X-Gm-Gg: ASbGncsYXPvOo4+tzmcQrgsZJ2XC7HUIl9Tb+8PZ40MA662X1w5Ad/JPRcZKuR4dRFP
	ykPA+mB/dk5wjXJ6j0tzuzjPPml/C/MB3c5jXVqKIqD/He+4Lg1lZojulcUqliMi4LJTKloi4U/
	E057CFIKckI34jE5rpeW1lpDlnl6rAmd6ME0Z6Bawi7OrOwvCQlWIajzyCioZm3YTCd3rl39l9c
	IRwvqQ00ggDl8+uD5dn6jRJvv0kmBPTX8mGV2tgTE1dYWzCThJzSPcTowXikck3i2Epq50GGETC
	otfP9Q==
X-Google-Smtp-Source: AGHT+IH09CkYJ0UtkBe+a5qInFgvMXJIECzPffzqtSRnQ4/rOtucmd7AR3vCh/FlzDD0l/wp6T1GPQ==
X-Received: by 2002:a05:600c:3b11:b0:434:a7b6:10e9 with SMTP id 5b1f17b1804b1-4390d43f76emr48688805e9.17.1738839290760;
        Thu, 06 Feb 2025 02:54:50 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:14::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391da96640sm15993445e9.8.2025.02.06.02.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:49 -0800 (PST)
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
Subject: [PATCH bpf-next v2 10/26] rqspinlock: Protect waiters in trylock fallback from stalls
Date: Thu,  6 Feb 2025 02:54:18 -0800
Message-ID: <20250206105435.2159977-11-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512; h=from:subject; bh=jiFbzaZcn62jcwbclsn6fFlBfAVbcfgq/5K/rfr88pM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRlAFWO9LNwjO/6CG81gcHcw9dLmIxeb4fj+/Fr WCxwUJyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZQAKCRBM4MiGSL8RylLCEA DDo4P5cRJ8lPeqvkLpxQQ1B7QXy+KIgoUK7g8esRrYEGzu3/eXsNpmYAoOvt3pEFrK41Z912PBSwiZ i494ekqsWp8O2NUu2LAySNMiQoLle49dVCJVCS6XExiZjShBBUkEtEuCd6nUmFQI75F1VAg1iHmFJB Cfib9a+3IucRelAmkgBnQ/O2d/fQo0v+SD0awcgBflP6r/Lt63AmQA4aZ4sFZ6racNxenALC+V6MfK eW1pM/lb2MDwv9GUrhhA/tvKIXCGXkR+t6Ujo9S300ORDUjNyeubMZtLOCzHkmeb6HyI/laIez2iWD Ek0KD+qMhLwDY6ZzHwu0bVuubuavObYEZQjiTGON1QtULb4JSDF56lM2C2rOn45iYri4ihN0gLv3Zs 2ViXlGn24tXGV6kxa8MyOwWHOShlj4BRY0MGSol1jU2UZbp2ztn5iujPHmtcZDFMbAAe8HF8eaAnJp EhjV0kpIyUMml54A8fDiGMgjt5jI0ciIUDnEYtzcDCC56XaCPRwRRYluCIYOk1O6sczyszhNNwEWsM +oYoNqL47WMzOJThezb9dy0n2ARWnKz5fdrzN1fZIqArDB6QziEdYH90bwROd3jhypRSPWfKyYUWg7 y0WljjCeSXbVoHZmX0zVKWnH/l+jCp7pdBirkN9WK6Cr5eBJYTtvKNDwUP/A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

When we run out of maximum rqnodes, the original queued spin lock slow
path falls back to a try lock. In such a case, we are again susceptible
to stalls in case the lock owner fails to make progress. We use the
timeout as a fallback to break out of this loop and return to the
caller. This is a fallback for an extreme edge case, when on the same
CPU we run out of all 4 qnodes. When could this happen? We are in slow
path in task context, we get interrupted by an IRQ, which while in the
slow path gets interrupted by an NMI, whcih in the slow path gets
another nested NMI, which enters the slow path. All of the interruptions
happen after node->count++.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/rqspinlock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
index fdc20157d0c9..df7adec59cec 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -255,8 +255,14 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val,
 	 */
 	if (unlikely(idx >= _Q_MAX_NODES)) {
 		lockevent_inc(lock_no_node);
-		while (!queued_spin_trylock(lock))
+		RES_RESET_TIMEOUT(ts);
+		while (!queued_spin_trylock(lock)) {
+			if (RES_CHECK_TIMEOUT(ts, ret)) {
+				lockevent_inc(rqspinlock_lock_timeout);
+				break;
+			}
 			cpu_relax();
+		}
 		goto release;
 	}
 
-- 
2.43.5


