Return-Path: <bpf+bounces-75739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784F8C9347D
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 00:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D66E3A8A27
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 23:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9646A2EBDF2;
	Fri, 28 Nov 2025 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps3WlB50"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BA42E7186
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764371751; cv=none; b=qiX4LkYqulMjgBNjrvSHJRKHreMCt5MVBe6m5nURRTl5q+Qk9FG0sUNwvJGc6934IWyxu/ai4r8O5kHCTGcbGFH3ry+X0kvIyau+iMJmAqge8CxsJ1prTwR5Hmxd3arrOz9ujPDOYfb3yMYwCZ9MiOADSJUoMttNEPHqFK0SBJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764371751; c=relaxed/simple;
	bh=/2Gywl2SQIh9ifJihoM+7pP7rH2Xbl8EROV03S2A8T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfVtD6zWXwnWCG4WmypsmEy77dGeqgEAZovZ/O6/Xz33mhX3gzoMX6kV7Pwc9TgGEpAoNOdwD2HMt0XcZJTpMK0vh6YeBLzIh8CgEzY8e8Qyihrj3jLU9REBRbl3zuUWpeh7Xld0iiSakgV64sdsHJN7zpLThJSVrMDEPTUL7Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps3WlB50; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47796a837c7so15214125e9.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 15:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764371747; x=1764976547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+tIstacjHMTn1LPeEU4QExye03110q8XLikjhEGCRs=;
        b=Ps3WlB50dsxHq7NiqhIwjOctKNhZUKRG5j9gI6LS5Je7WnqbKj+UfTzwgUSCAoNAG+
         Lol2qyF8hU/95AUyXcI9e0mOkwqSXRns5mdQMLklExK8QKrXv14z7jGL2R6O55AAB6QL
         XnAiGxHdoEK7XphZDl5koo+s/pa/ekose8iEopk905s3UbUvJGS1PHCsG8YsdsFrfQ0f
         KRfl9b9YOEpcmslUNERZfhnEGMY2o8Q/AjmLnnDpiE/0W9SZyyP9zcqqcfh8oRKgHXXN
         nDKI7WP5i775pbhav3fjM3m+TWGa8tbQFl57b0GG8/NgqySS5KW/JV3kkw1W/Rvhj4CP
         Lj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764371747; x=1764976547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8+tIstacjHMTn1LPeEU4QExye03110q8XLikjhEGCRs=;
        b=ROKYnS2XoBOHz2xfkFvhnYTx6SdWAQqU/w5l5Mk1MYo3s+TI6InZIHkdK8WYPG8wdX
         HOXMhoy9sbETPRnl7xC05xJq7to2L35YCxsWe+m1bkYzMpXwhUfOCSw+ng1qkfxfkLW3
         3+pROqWII+dp3SajqK0JNtUps/7sOUeouTizrshFw4UjQTt5IYUBkPB0yepjSc9yBzgq
         ZvuSnpLV9T7NmlhNmlm4RBNiYbePkeJw0YqdxVzTVMwyPqleihUhVj0+NDr9S+72CTqh
         3mImWInSNeNwRBmDUqWFw/437JT+FRnVAJocyFo5eGnSkEJCQVriBeVYfvYoaIG1GDYy
         mYpA==
X-Gm-Message-State: AOJu0YwXKNSdtbtF2imD9FNGqIfIf2iYY/0I4fRDtJCQ62Gg1zrtS9ds
	jMK6rgOXpVorOZMKxVc22y3xgeDbwLDvCjDt93oVW85VRARxaZbBnV9ZJBjTlpTF
X-Gm-Gg: ASbGncvPA/y/qEG/dovqHu3qBVIDVzoNcEMWwHVZznn/oFGiERNrKRxCrT4AStpaWBW
	akOUpXr8YcJeYTDyvi6f2Hhsbbs0DwlM6BqFVjS9gN0Ld4J5HJ05XvKozcvPoZRiaBeRO/eZroW
	107xad7nBj+ekMbhlckekUMvaOtho17BUcDgtFK3ijOqv3iIE8tTy4dQadBLaczR3/IrI4S8Koz
	RWYX58tH44W3NxOneRXXwuEiocpEyfWDzNvMkT9w/prcJ9PCwBiocLkaXB38bGQSHI6GdeYZgka
	BBn0xuojs/yvddLx+mACnbyTNNjZtCYhFnrsobpc3pdxclGtoVkmTWnBbEQLW2xvsWb6ClYXQTZ
	uquWwbo4Oui0d45ZwOtWdBPuVIh2ff0EG1kswSvn5dR3Z49JMq8WoYubDPdyifY1cioKAk5ZUeD
	fe8E8A71MaudPxcS0XhBH35NrIq9oEU6btLlNG2vvupAuzHlEQQXnlzvXzLSMAhtRW
X-Google-Smtp-Source: AGHT+IF0OH+WJcPdykhizwQdY/IMBLPyv/008HKyhovDHpEq1MN0EKvpuoBGlZfdd96lNagNn2qRvw==
X-Received: by 2002:a05:600c:3b8d:b0:477:aed0:f3fd with SMTP id 5b1f17b1804b1-477c016de43mr332386635e9.8.1764371747333;
        Fri, 28 Nov 2025 15:15:47 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1ca78f77sm11989868f8f.32.2025.11.28.15.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 15:15:46 -0800 (PST)
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
Subject: [PATCH bpf-next v1 2/6] rqspinlock: Perform AA checks immediately
Date: Fri, 28 Nov 2025 23:15:39 +0000
Message-ID: <20251128231543.890923-3-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128231543.890923-1-memxor@gmail.com>
References: <20251128231543.890923-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248; i=memxor@gmail.com; h=from:subject; bh=/2Gywl2SQIh9ifJihoM+7pP7rH2Xbl8EROV03S2A8T8=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBpKiyQ7QEUVcRaj5B2UCNe/iKuLsaQRzeLowZ5i agsdJy6ag+JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaSoskAAKCRBM4MiGSL8R yk06EACGzaPlo/MR5gab3OiX/xPNvLDCwf+NB+Q0Ep71DXLihaJPzzRBO5NtPnO2hrrTkJhRWJI j6apvP4mJ27jmJ+co6ZlM+wrdY893md56T2zkDVOXc/n0dHqnD30F3NP2kBsPy9NS8Fw8ohmgGN zQEgsMqgsfn8Phzj1LDziFRD0wGUQPMaMhVM33su2Wg7Xgfg9Qq9szSpAEi7K/M1GEOXh/xTRKJ F0ULUXnZoC3B7n9+0tTXSyQ6VAdX5wZznCTuZEn/wxizCznWyf1z+YMNN1quEwVZISLsYj73Y3+ JyzbFhg3Nz91BZdXFqoh5kueACRb8DZABOgaZqa49q4D8pd6YQSlSmjVT28+qVu0Y0yZAY9I8AI uaWjqLNmryc9wsiHShwI/RSubd4GK24pF9sLYOTwptN7Yd9t0BmIaJNQr+6non1SSBP7K5RpDxA HVOWCAh/90/1gkfs0Iugrxe7vrNn1iV4qHTxFCCaTbO7wnDRaYSpUMO99w/6OlV3tqGals2AX++ 2HX8LQnjcgTtWjogD7NDaDnXuRvG9y4QTu1ehRO/R+8sFSJs0vMjwhju4rOcPCVC2Zg0l6rBjrB +2P3adox9msfAbf9xUw/qkt8dvIlGaN6kx0vKX7oQf+/55V6TQrFL6iO7RAQq0HLRfq04PbYx1+ rDPpzYgymObrt1g==
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


