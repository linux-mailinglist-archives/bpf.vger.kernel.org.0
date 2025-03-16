Return-Path: <bpf+bounces-54126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3DA63394
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B5D3B3B6A
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE9A190696;
	Sun, 16 Mar 2025 04:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNllPUhV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9914F102;
	Sun, 16 Mar 2025 04:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097961; cv=none; b=apwHBw49QHUXe6rw4cYXrtNmpRTLEBHfFR1XZAWVGDr9n0i1ZrPDCS2IyrGbJ3QXk43vILEohK6yqewP5Hxp3hYDWBG7xsR54rlP2y3Tmx46LfnywfKh8Oncl5HKQv4HNGJWpbL2X7zV2OE2VtwFXZBepuhq2nOVdbb8R3NXnYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097961; c=relaxed/simple;
	bh=6ga9NaPnm2qscV5e908A787vKJcwTZL0L+jNyYJdaTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0y9xXGNV/r8+VDhuh6jJiDrgvOIQPWs2vI/Za1hGKQUiYGG6MjBOb/Aeu980rGNuPpSJXgNTUHJwVceswJJebnXgnR6I2uR5NfqwoIo49ZlrX/sYEvjoTgw+R5jjCccru6/FlkDkViPm1AhVfXVZJFUcr689bXGrb5pqxyOd2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNllPUhV; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43690d4605dso6607265e9.0;
        Sat, 15 Mar 2025 21:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097957; x=1742702757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HX6HuMB01wWAUhOciNQt+DcJpa4mtBn0KQKhBNdUTd8=;
        b=JNllPUhVLWELcCTtna3ahdsmRnct2xRVLLy0D/CUxAzKu4MDQVOQKWNGNk5jCzef37
         qhvOXUm53Aqcd2/pE+5xFzeNGAeq5nXj02XN49m/ooMbuJOQnmEDNOx/JIqlAwDdDbIr
         Z5rxSG6yWI+ziFHTnsHOe2pnedopDiqED1JOXhTADEuSoXsFlHkElmg30UfJ0/eCippA
         YmwNuj4DVWG6DC2N1e2ts+txu8AJuJcvOQF3gmeUpBcJ6qwAdYxfydV9IZoqz7o6mDMd
         6MlCK47BWKDec5dLvPJuMyBv24F4rsnTRjQCwUmkGhqrEC1qCA7n7suv9rQGpMyKR4Ax
         Dffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097957; x=1742702757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HX6HuMB01wWAUhOciNQt+DcJpa4mtBn0KQKhBNdUTd8=;
        b=HmEnzM9pE4VRooKCAvFnkd5jDW8ZnRigidWQ0e/VjPoXBMBntt2/09wzCoAKctap/T
         I+i+/YV0pTgLdJic2t3rFLO+9CrzW9KzeHhaAbuEh1D84XyNKODO4U30H16IesIQ0Xct
         MRKaVdEqJiT9/b5XvM8srTW3yvATeVryuwZgIN3LFFOlmyVTTwL8z6XfmeH9IEHIb0QS
         QIsF8yqq5sFbFletxX+cpIUwIv3wHEjVOt69+8ffZHkX7CiV09M1nwKZJOSI62NKQFVM
         uxfuUcNfS3b4wj9iWjfS/Gh8S8kDz9kDFlcqPGji1W2sxJMEE4zzS8YOSVpb8eqQyROE
         Uz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXIeOkFQ/ssJ95kOjuF7iWqyz+hPmjXi/wyX65ES1DljDeKlX7FodRz3Q71BlSCygf+EP3SbCcl1P7YR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDbeG9xAGRDYhmchTqDYimNcmNJ2g8gqSBLqpqAsWDofPn1pXk
	r2v/8dUW5URu7avZXwQ37JKh4TmatM/7Q7mzSukxIlGdOwZS/hePZWobZVc3uQU=
X-Gm-Gg: ASbGncu86M3ovaX8ssRmg1DpYRBJrVubZG7uaIdZpX6uzdZ850TytjMKUrTpgXe9Uis
	ju0p65KAw2jRTMWdD1AzhbyG++1DsHzB5z7+7QK9ULJFcI8WsQG7TNwV2PwoK72kRen25xMy5nZ
	9ABv7GoVftibRoagUHPq0v9kR39zm6EzDKYPIlKMN+ZwGaX5XZLrU933uffmaJMduyisydScPgg
	687W+UU3c/8Ac+eajMsqhOQzRr02y/y9a4sJyIvMg1C8RvxkuztXuq7F4qtOKwAnYAl6Q6QPNQl
	/rCzlLfe1p67Z/EN5g77ZFH5P5F1rjCo0Z6uZ66NhVcDbA==
X-Google-Smtp-Source: AGHT+IGdjZLS03B/i/oyj0FVCH6ak251OqqszbVDTcp6yx3FeG6rdnMDu6XNNYRan/DL0Mz7Gi3+Xw==
X-Received: by 2002:a05:600c:1548:b0:43c:e2dd:98f3 with SMTP id 5b1f17b1804b1-43d1ecff3d0mr77112145e9.21.1742097957130;
        Sat, 15 Mar 2025 21:05:57 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4c::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fad59sm67783415e9.26.2025.03.15.21.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:05:56 -0700 (PDT)
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
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 11/25] rqspinlock: Protect waiters in trylock fallback from stalls
Date: Sat, 15 Mar 2025 21:05:27 -0700
Message-ID: <20250316040541.108729-12-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; h=from:subject; bh=6ga9NaPnm2qscV5e908A787vKJcwTZL0L+jNyYJdaTA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3cd+lc2mT7eAYTtSCeru7PXMbtZTLl1rVKe2Na zqq61WeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3AAKCRBM4MiGSL8RymCDEA C4K937bgxXiBFwWg7wVsj1Ouwcy1m1SvtfIZLVr3xtAqcbiYKXGG0i5pXm3XBUM2mgmI9CropTshbQ dQWs7kFH1UBO0zy35y69RMSbrW+XYvOIUv+szj8w1OnAXfbt5cxjZY2oWdwBfSiPYvDI8qqWAJq92x Eu9XxhjsiU3DKxEIhABz7oovXElnhcqiaJX0bMqx1PJqHQEUx+v8FQX4j/K/bNuVyKsahTVF0QLweA VdrXkytJDmq29EvwZiID/KwMdFSAlK8imRvbwx38oDpj5kOvmKd2YPf+9yf+Q1X6A2Om6Z42ulZ+ju 44r5dNM2UD3qahjawRGUazaB+18OIHX1yD++NqUAjsQFympNzvBFjjeeC8ffwxmNJkaXt7zT43YAqL /uOkIADmjS54logpdlm10XVwYzPrtEOTELnZknQ8zGIG8h4on+rvZfgi++0tV7gs78T0qEEknIsIYB 0uXO7Y1CGP+IevSyeQ3EJvHV2IYztylGYEHyA9GKqpmo5nBFslUK7B3Y9WsiuQJFs3DzzTDWNjIOsc 8Y37rSMW+XsAoDPAbL+h6fkt5rkhyDfpkpnfY7TEZ9vp3KcnIvAS4dh/o691vcK4ZXIZx+LGjvb7WN VxSTT/cmkbB6g757jZk6EG/qXsjkzmmz6wFs7p7bSxl0HNH1488vWapQ0xWw==
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

We use RES_DEF_TIMEOUT as our spinning duration, but in the case of this
fallback, no fairness is guaranteed, so the duration may be too small
for contended cases, as the waiting time is not bounded. Since this is
an extreme corner case, let's just prefer timing out instead of
attempting to spin for longer.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 65c2b41d8937..361d452f027c 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -275,8 +275,14 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (unlikely(idx >= _Q_MAX_NODES)) {
 		lockevent_inc(lock_no_node);
-		while (!queued_spin_trylock(lock))
+		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
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
2.47.1


