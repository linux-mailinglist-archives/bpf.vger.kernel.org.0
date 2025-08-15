Return-Path: <bpf+bounces-65715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F456B278FD
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3F33BC8C6
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646429D292;
	Fri, 15 Aug 2025 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8hDl+mW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5F31984A;
	Fri, 15 Aug 2025 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238722; cv=none; b=F7u+s2CEj70tGSNDdYg+9+uepar2arltH06nDQ01bIimmR2CmdpIC/bpyo/2hSXh/FrLiiQDAEhgVfMkdrIr7nzcvo2h7hYln9m0sOg+zZvcEa5CV6MTYHd6xcwcdM7WPzJruRpZFpnnFNvWUNxN+eHGFd9SPGA5hlGKIgc23/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238722; c=relaxed/simple;
	bh=x1ATtyTcNSslUyv0qjv3375CuVeybZpmPNqMbhb1yZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVZPKbPLWaQaMPSh+6WZhJ+kdjsA5JfSlbL0cwBd2JXhqIa3Mvz1axuuPzQO5cAm/Q9Emp5CsSWnFpxcj3xas5Rs1K6PtWDIA+bND+n4vyZqoRO+wYyyJOR3vOGjUywwABhriO+ezhkY9FEYjCkIIMA/1RWRHRru82Vo3Dk+kto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8hDl+mW; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so1359558a91.2;
        Thu, 14 Aug 2025 23:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238718; x=1755843518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J1O4cvXmQVXOS+LA9W9A1gYpwwOti/g631zQHcAM1M=;
        b=d8hDl+mWoGqwLrnbGmArmB/zKOljRNrXPB0O7o6n3DUYccdNqfU8jAPLnJg/UFM9Ce
         DclQX4xAmBnffRzrfXigvcSfCfTdfrRgWekfijDvFAjH/7/OeSXiJYMNDk4+LnP0U17/
         9Nv889IG4OVZ/6Ma9pOiy//x7jnO54+7TBKDviXlYAYjvsa0B88g5u1s4rdoJ4bXikUp
         gwfnbgzdomausRTO2fP+sCUm2jXpHcOBNAZ80ZyF//FAoBROrNHP3ZdOVHMiFA3okFJT
         CqhBRfefMyfscZV6EJlFklikV153dsHd1KszPf1lOu760O3mxZhrD+38Cn5p4h6akQqw
         ByeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238718; x=1755843518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4J1O4cvXmQVXOS+LA9W9A1gYpwwOti/g631zQHcAM1M=;
        b=dltmutn0TKvaE5dz7TZ42qmyitnraeJAqaKVZtv86gY2CLsqTzagmeEKPogFzdwbtW
         xfmvYYv/TX7ftqFSPbMZro89pXJnSdTVLhc2Fmoj7tb1Sgfvp/EQaInmkjrLZYM/tT6L
         CUYBBUjggwnTlY/AcK/pL8bR5tyF8sC9W6lb6BIsbJemwruKg01V5uYIdQtuDPQnXfXa
         X074jUP1vdfGPvPp4aWQ4I38d8gVO7V8YDqO+UCILCe6zbPx7gZR9hB5ZTJZsWTzU9u4
         2dJKEYpOziGyq4XnMk2mOn0TjAlvZ5phr2g40k/usNpB9Qz4mJ7AkiOifoKT3M+JERNo
         FBVg==
X-Forwarded-Encrypted: i=1; AJvYcCVKU00PzZOxp9ZBraVC2SPWwhC20mav5XJaH3Yo6W23yzLeHqO6vmBo7k4u1Gpn8Y1xf64=@vger.kernel.org, AJvYcCXePOopB6aiXqjKzAYD2BK6DbEQ7MSSR2lUnqM0qdXxIgejfPJ8YqK6XFE4PJF0Gt9+b3kIHIXTVxVsbHYJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WtIg3+6UU7wvzrvvfsIWisEi7bIYVpfHemw5mMLnrlPFpYNB
	qZsK9ro+4NSATdyCLgnisx+RIXoP9drjTG7pfTRCaa6PZX8GctLg2LTf
X-Gm-Gg: ASbGncvb6cknJZlBtbzb0S7upulq5emtDZR233O1NevBJrENBbFnZ4cFbdU1TvwUio1
	V9HQs+diJL9L11MZv6yyu7ULKCbUYEcp+o7t21JWhcy1pvENfu2K5+un/Angzd4zRev16L7yayi
	PYZWvXgzEZBZfzBuRalF9PjYqbF8hFTJk32phgZ2yekqzsmDl9b2GiTsR/oM+UNz/FlwNwY4aoq
	DnMHyyeD8uc/NUwnjBIZrhP0aCpxUHZ2KW+n2zvPI5WOfwDvmX9HAk4muP0ePpGM4aSyXHPM3Na
	HSO/mKXsTani7cfoRcmXP5nBxyYJh64O5UCbqLwFa28FcY1A7eivrujfd0VWq9Orr1pDNOpm+o4
	f6emFqqihsSm86+mBC1c=
X-Google-Smtp-Source: AGHT+IGEamtl0+FoPBkIDlXgUljBSam0In6IaXjx3HrsQ//QiaFz+SZtALG8m3pGv2VN3oPUxCaPqw==
X-Received: by 2002:a17:90b:3dc7:b0:315:aa28:9501 with SMTP id 98e67ed59e1d1-323421610e4mr1795691a91.24.1755238717706;
        Thu, 14 Aug 2025 23:18:37 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4558ae7bsm408607b3a.95.2025.08.14.23.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:18:37 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/7] rcu: add rcu_migrate_enable and rcu_migrate_disable
Date: Fri, 15 Aug 2025 14:18:18 +0800
Message-ID: <20250815061824.765906-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815061824.765906-1-dongml2@chinatelecom.cn>
References: <20250815061824.765906-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

migrate_disable() is called to disable migration in the kernel, and it is
used togather with rcu_read_lock() oftenly.

However, with PREEMPT_RCU disabled, it's unnecessary, as rcu_read_lock()
will disable preemption, which will also disable migration.

Introduce rcu_migrate_enable() and rcu_migrate_disable(), which will do
the migration enable and disable only when the rcu_read_lock() can't do
it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/rcupdate.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 120536f4c6eb..0d9dbd90d025 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -72,6 +72,16 @@ static inline bool same_state_synchronize_rcu(unsigned long oldstate1, unsigned
 void __rcu_read_lock(void);
 void __rcu_read_unlock(void);
 
+static inline void rcu_migrate_enable(void)
+{
+	migrate_enable();
+}
+
+static inline void rcu_migrate_disable(void)
+{
+	migrate_disable();
+}
+
 /*
  * Defined as a macro as it is a very low level header included from
  * areas that don't even know about current.  This gives the rcu_read_lock()
@@ -105,6 +115,14 @@ static inline int rcu_preempt_depth(void)
 	return 0;
 }
 
+static inline void rcu_migrate_enable(void)
+{
+}
+
+static inline void rcu_migrate_disable(void)
+{
+}
+
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 #ifdef CONFIG_RCU_LAZY
-- 
2.50.1


