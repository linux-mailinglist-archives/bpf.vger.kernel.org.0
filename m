Return-Path: <bpf+bounces-48108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CF3A04177
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C710A3A5659
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E391F3D50;
	Tue,  7 Jan 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0k5pcLv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB74E1F2C4E;
	Tue,  7 Jan 2025 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258434; cv=none; b=iJqKg6FD6GF2EzXllMzUyCx5UX+8kTOd6XB31+p8Bu59braanAB9MqrlL37kPbXvY6T3fCQhM/ClwjOMX7//FnXHxippZk+vFe15f30yEaLu6gpers8jhT7eeFXOkpgxk16oNYt6pJMGxo+0TCPGb9sTQyUKcss10Q4guwVnhnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258434; c=relaxed/simple;
	bh=XrkprQgh2R+JBqzrcqVF0TqES9iFxfnGeXRzHPiyDoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5TSEMiFl0EvqdO2fx86zGXbwT0JyyIUxqGTTL/RadyzJJAyWe4/quG7RiUjqi/9HnO6S293B+WSH8ZafrsymJr8E+22sA6eWvERFc6+wo5BmWAJyVYtCiseprfpovInyHzxTvTpT6E5FEAMGKKhtqKUKd2yDhxXRG6npGFUiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0k5pcLv; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4361c705434so112616145e9.3;
        Tue, 07 Jan 2025 06:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258425; x=1736863225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLa73evp3YqHV8fdaIkN/k4tmxXrGX9qEQrGfZnRvGM=;
        b=d0k5pcLvcZWyuemI/8/wLiS1WFS6JH2eldOlEGTKumNZ41/WIR1zqTjmP89FYHuHI5
         PZHVN4JLFJbrpVWWdGKFkNzrii/sulaKYZThdpRAeIx1YQXvAX2uWZhdUEc8mIcHRrw8
         ah5trl83HGLU/XNk4PIoDzQmvx9U477X5EvSC/dVyGEtNu9M2luLfVH38k2uefPb3tw9
         p0Asq/4hgl9qXUNLMlJC6uOiNu7v+5u6Y9e+gd81+MuRhVXPTTRFAYD5Axj6WLHw7o20
         Nhrml4lAl0c4MlHDrLgLbxiSUAygStByXvBaQxy8Via2EbxEJrAUHMO/vFczFVGtRPgN
         cT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258425; x=1736863225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLa73evp3YqHV8fdaIkN/k4tmxXrGX9qEQrGfZnRvGM=;
        b=Ntt+MUsGaaR3h9uFWXANVoVPlGqy5njgEpUq+mrnJsCdVLpMMAB6Z5Yl7iVGgRHNaJ
         19F6atuOkFdtc/APEGxzEeyqjAWLrQC+POWSvjLSCmUc0AAFTB9w5xLc8V9CNmBk+dAE
         RQvtvEVcbsD4JKzECJ8lWdan2wl9jKrFFm0xTMVTR1tsvsmmwsHqg2tQzaoRaknM73Oj
         75D0nEmq5ebRrFd3HUrlvUyVdcF3LXI+NJsqWqgiSfePEJ1Vn1tKiioiNVuC4lXeieBS
         0gWSqDdjoyExd0yu93gjDDR++p478c49CVzDeqe9qeiFKfO+4W03EXzy6EcrhFucjkKj
         FEtA==
X-Forwarded-Encrypted: i=1; AJvYcCVckP6GKlT6uhmWgcmWbZDbEfcdKmzTPdVK18ksp41MjsVCgX0e9Fioyllht6aqNewI0B5Az7we/AxMJP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydAgjxoUNPZ3h0KUsMFJr08RpYcr7CY5CXjC2UmEpFR20h+vtx
	r2B86j/40G++75J8DDfhlOr99jJ5w5V4k+ubD0648z+7Yw/MWbo8dOuwU0NsQcypqw==
X-Gm-Gg: ASbGncvU2IbpBbQ+5HZlptbRjnTPJMRCSQApjjZRZ0/KvZkZjWmlLQ8lrX0i6x/ZVba
	DJxjdUcbizbY8jZrYtsIw5AnJh37jzM7cGoJQ2arlPsoRozKDHQJ8kWrnpmzOVMDribqH0q2+DS
	dgGvk8uDDFHv6PNbUuY69rMgQRvtFwnpXAQm9GPrM9DKMCxsmz24c2Mm/TkyezG1C3cnv27ibyk
	EVLvkHVkxn30ftkB1jgi1HYgDXfFkB9bbchoOiqdDr/57E=
X-Google-Smtp-Source: AGHT+IGS0VWZp035yBJfzAKd95k9hu2+B3ywnAF9DnzUw7iLW/9Um0RGqKnCmUoqdeXVFAwkV+LMgw==
X-Received: by 2002:a05:600c:4588:b0:42c:b16e:7a22 with SMTP id 5b1f17b1804b1-43668643348mr552295875e9.12.1736258424852;
        Tue, 07 Jan 2025 06:00:24 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366128a353sm599016865e9.42.2025.01.07.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:24 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 10/22] rqspinlock: Protect waiters in trylock fallback from stalls
Date: Tue,  7 Jan 2025 05:59:52 -0800
Message-ID: <20250107140004.2732830-11-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; h=from:subject; bh=XrkprQgh2R+JBqzrcqVF0TqES9iFxfnGeXRzHPiyDoE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCdmFm8k8mGBFpl9qTo6AHOVKqkYyiWkymi9Tha aIiJeaqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnQAKCRBM4MiGSL8RypaVEA CIq0Es2lfW5X5IFAiLLKCkSli9baeHSPnI0O/V3GFsTdxcmB70h1IC1Y62z0wwacIwSKZNq0zggIel 3/yfHXI5rr/nyNEcxT37lrixMptQeQdO1CxFoIEILxF6e99h9ClaizZVnUOtvj6LmVYu0OuOAnlzXz PROf1tOuT25trNU0sdbCZ6a3cv/L/U37HPo5LLycwyr7HUZiHbE3wuCb50QtJ0xjU+0GhvFB7WfA3N RQs4TQrdxK5KLVRWHifYTwcTIjezo1DOWy9L2AQJo0Mf4hr2uyFknV8gcppH7RckV4LAvv6Uk1njoc +dVSIJ3aj4GoJY0QmRTDkRYxFToU1Eda+OUU7lKNxiQSefN347Lc5x+zAMeehnx4lZt74PCttggg2L MQ1wOVW+iG1atf34xgo4Y8Gl9rpaTP+QXv294T5Ik5EKmuK/AYB9WXYrEWBuuTqigHKgQQ0s6MwPAL yxWtnG98DbhStLLYwKgnfbJYgCNt1PWk3rrV2yjMcIsc947KNUZSQcDnX6pgKEdw9S/3Vyr0yBy9IT ZUgvE/VtcyX3qTPUJZ2Xc3PMTgRMWeKmrJS16rIDpsODvPJZ9CmQs7Jj3pWeYZ2Hji2ANmrAtl4YCL HRlPm/w1ZreyQ7dEtfyazm3sVIY25pgw0DZFnetcg/AVAWLn130FwyukkWBQ==
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
index f712fe4b1f38..b63f92bd43b1 100644
--- a/kernel/locking/rqspinlock.c
+++ b/kernel/locking/rqspinlock.c
@@ -255,8 +255,14 @@ int __lockfunc resilient_queued_spin_lock_slowpath(struct qspinlock *lock, u32 v
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


