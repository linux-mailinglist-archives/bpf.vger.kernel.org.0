Return-Path: <bpf+bounces-75751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDAEC934B6
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EE494E2376
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F392F2607;
	Fri, 28 Nov 2025 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRlJAWuh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5B2F12D4
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764372489; cv=none; b=Y8PAI6gMxfCQ3/w2g+KY3oerWlWqBdLIgrxa4XsQTQcjRmWclp4Hef4Ow+JmjekJ2uASCm3YPi3G+nnJjFAmc123zsarx7feweiM+iV6HtYrkuuPTvvPgjBTofymzSwiloPw4qQpMuj0yceQbC+UPXUQcsIm696k1kpCufOYy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764372489; c=relaxed/simple;
	bh=/2Gywl2SQIh9ifJihoM+7pP7rH2Xbl8EROV03S2A8T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViuraBXkhmzDJvpG6JAnCl7Jw7xS7Ut9gz7C6luiDP/JQBZiXv/VQMjG4yS+5N8iHQW7HocVyRvfVPHSOUv+D0uluNQN9dg/2i7KJ1VoUFM3vHXPxHaQprY3fXQ325jf1fH9z7wEtvikyxIzu809yVQAZyhFGNjW//jCmko2aOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRlJAWuh; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso1040834f8f.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764372486; x=1764977286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+tIstacjHMTn1LPeEU4QExye03110q8XLikjhEGCRs=;
        b=gRlJAWuhM3PTNrfgz5NXUvrnWutKZjLlb0bX2Z0bp5UhXMaSQCdqV6m6hPsHnWN93q
         iiY31S4XeBqFjQLi7dOKA6gKYCJuCiR+nDhhRoWM/OBsBhq2ie5vvnUNtBDSC/tsw4f5
         /tTQdkgAX49aGwsPZ6g0NMWXB5U/VlChSNCB8ffFUPyIlrK+DFCiiB3hcfSwVqNeBd4n
         Ff7foKR5buzN71kg0fPcasLwfF9cgTsy+2QjauHLJPF+uMhQ2h9a2TWrhzMA5V78rzGI
         p+eL/MKnFtBkrSo8uMl8e0laeaIQ+YXv72G7PMDlQnfVEgeILCipj99ebF+Kv8FF5LEI
         J4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764372486; x=1764977286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8+tIstacjHMTn1LPeEU4QExye03110q8XLikjhEGCRs=;
        b=IauRBc3w9nswVPVmaXYl4u7ZAn2wMXI+tKILjgkNorAHb//vVaHuNFCv2v7Ao5LZ9A
         SYnJaoyiaqBX4GaIQBbUnKhFj68okXwgzhKTUhp7jRrQqAJfZRBqyj3F+zhaofERe99N
         88ZpBR/zi392+Hb6pW/Lm+GQb429PpDZYH2f05Mgbt5Rq4QgrKxxfPas3ZxmJrOWz1PQ
         cjR+tlwlBcHTVqzHKXjDJBmbSWqbjNsitRcWrRQ4pORmuzLeG5Kx9JL2VV5Ej4OYZkIi
         ua3LEGtiaYZBYNMBNDzhidc4um68l2SoUTOtiX6PCLiRU25FWMyIEk40d3CYhOlZReX7
         eE0w==
X-Gm-Message-State: AOJu0YxUJMRWwMQtrGzJN3cwhrv3b/GuuXpsl82ZhcIbmeMhYCMTF6jF
	dBEY2kZ2GfAQaT9I1HAQ0vzZb0wSQjCeCIX0LsWVa2hyxhaSDFTnlLM48+YgBBEV
X-Gm-Gg: ASbGnctMmxcrfn3JUwPeLKJi7laqEhUN8cbe6qaT8rnZEFF1hgGnI6z6hL9zfIOTXJ9
	YbwGMsX/xuuSGGPnt2JggzDzptW7SpV3yOQKqk4GIg24nUKj1/9Nc4LhUeoLalwt1szlA6oJ1vo
	eD2WHMTZH3C2H5VbXS+L4KyEn1uoFCLd6+DDkbRaik4qR687H0ExXnM0bIRrci2vjWcgxfFTder
	i/R2m6g+uzBzis3c5QedmDVGSp5wP7ZcADG/ZlL0Yyg7msfRx4/XGdMPKr68SZaO4EOVti42ZDM
	CuBmdxfMLH06dR6hzg21Yn79vMTzTNlNzcIQCggiOYC4XU3By+yfFgKggo3c0NOkuYko9fWP9Zz
	QcEIT4pFsSHLqdYJTLczdELuFGTnOUdIdhLIRTynnQBcGzdL2M3VqTVK3XQmc8QMURFf+98Gpww
	ANWTLiqkjK0byD5vJjsrJht7n/uI11iUcBenjJznO6mv+xvtG4LyH9sDCGDHvrYVXy
X-Google-Smtp-Source: AGHT+IF29yCV3RnkjpSaozQELt7eLNYU8xk0jBlQPgIbSJKGe6P3XNEDsrgqEhOCMf2HXdOiG0VzYQ==
X-Received: by 2002:a05:600c:3589:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-477c110262fmr293743375e9.1.1764372485902;
        Fri, 28 Nov 2025 15:28:05 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1caae37esm12118315f8f.40.2025.11.28.15.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:28:05 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>,
	Jelle van der Beek <jelle@superluminal.eu>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/6] rqspinlock: Perform AA checks immediately
Date: Fri, 28 Nov 2025 23:27:58 +0000
Message-ID: <20251128232802.1031906-3-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128232802.1031906-1-memxor@gmail.com>
References: <20251128232802.1031906-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248; i=memxor@gmail.com; h=from:subject; bh=/2Gywl2SQIh9ifJihoM+7pP7rH2Xbl8EROV03S2A8T8=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKi/x7QEUVcRaj5B2UCNe/iKuLsaQRzeLowZ5i agsdJy6ag+JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSov8QAKCRBM4MiGSL8R yicBEACQqTzByiA4EDmjMwj2GLfuVhWHw6aXwQMnE89+JuSwdrHfw26XQui2OXlQyqP28duugFd wa4hxpFXE4ka+MwpAstwbsGk7obIPUohODAFDY+Z8lHJWmKuOneIO+eB9oaduRPBcejtMIHpzJA MgXqpIvPrBwn3vQx2jNsgKn3e76xfLxxjfdj1r1APwPEnJhhiGhIGdTbmWBdO/f3zmdQkDcnDSI vO54EYsyMvxpviPTkZ60Xb3htcXvqoagrlBCXV6ZgF6EvnIM99W8hofXoFMbLCP6CudZLTq0DrB H1984rhoPo8U6IfBTjTMNVrmj3ejvYiEZz1t9mzw1aqdZl5GYM2q6TEw0sJdQMfFSbDZisUUTxz 8plvH7r1gX+CN5eb23eOcFo5UP1S4CHZS5v/a4fgA/ndiuxZc3DE+l5nn/kbUsJrH6/A1+wVAbF rL3VSNoILpziFsobPKkGI62nuGteFGF3lT5XUF8dIZKwXlsi4A9AMxDGfeLZQD9/+uDBiIUWmgn X+zi0hT45DPUzzVuYrZTVR5FMFWTGL/e2UqkP+WTrmJ+wVxpLVnQjHsIj6OJb1n6Qpjjnz9NL97 mEYZZlPF4ldd+t6tvp3CMc2LaTrmWayNjsS76T7xusCxuMZp48eoGUJiZfuE6TGHN4x4rJSMbHg Q9viZENFjMKdhIg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, while we enter the check_timeout call immediately due to the
way the ts.spin is initialized, we still invoke the AA and ABBA checks
in the second invocation, and only initialize the timestamp in the first
one. Since each iteration is at least done with a 1ms delay, this can
add delays in detection of AA deadlocks, up to a ms.

Rework check_timeout() to avoid this. First, call check_deadlock_AA()
while initializing the timestamps for the wait period. This also means
that we only do it once per waiting period, instead of every invocation.
Finally, drop check_deadlock() and call check_deadlock_ABBA() directly.

To save on unnecessary ktime_get_mono_fast_ns() in case of AA deadlock,
sample the time only if it returns 0.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 878d641719da..d160123e2ec4 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -196,32 +196,21 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
 	return 0;
 }
 
-static noinline int check_deadlock(rqspinlock_t *lock, u32 mask)
-{
-	int ret;
-
-	ret = check_deadlock_AA(lock);
-	if (ret)
-		return ret;
-	ret = check_deadlock_ABBA(lock, mask);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 				  struct rqspinlock_timeout *ts)
 {
-	u64 time = ktime_get_mono_fast_ns();
 	u64 prev = ts->cur;
+	u64 time;
 
 	if (!ts->timeout_end) {
-		ts->cur = time;
-		ts->timeout_end = time + ts->duration;
+		if (check_deadlock_AA(lock))
+			return -EDEADLK;
+		ts->cur = ktime_get_mono_fast_ns();
+		ts->timeout_end = ts->cur + ts->duration;
 		return 0;
 	}
 
+	time = ktime_get_mono_fast_ns();
 	if (time > ts->timeout_end)
 		return -ETIMEDOUT;
 
@@ -231,7 +220,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	 */
 	if (prev + NSEC_PER_MSEC < time) {
 		ts->cur = time;
-		return check_deadlock(lock, mask);
+		return check_deadlock_ABBA(lock, mask);
 	}
 
 	return 0;
-- 
2.51.0


