Return-Path: <bpf+bounces-66160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC05B2F35D
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2F25E6AFC
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039962ED85D;
	Thu, 21 Aug 2025 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmUkwFpL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5452EBB84;
	Thu, 21 Aug 2025 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767189; cv=none; b=LF5OpRkb14HR5nWK4U3bkJmmcT2cxh+xsGXAnF7WaRuCja7DEBcJhlpaMGKH7PHcfRkiB4557pQeKnQTR6vIs2aJTeLu0/AwIsSn61O+NUy11e1+dFwt9A6emaTJANJ9mk6TTtscovxJFw2lezPJ0Nci/BIcLOlH/DsyN+jFClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767189; c=relaxed/simple;
	bh=onO1kdG0wfR8fcTpUtHZzKTzoXwXEO6zkb9GsAGsMvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBxTNtjOHvFgKlxv8zaCFelH4Uyt9Om/4otIZlr7dE+1nXX8q5QRzdzjJCDDxgsbztz5x5EMC9POIzklmATOX2S5kgVTrDu3XFU89HzUBkItaMx7GvCvH6l0peVnce9OZBpc7RUKPH9dpV4qtQebxFcmM3kTDSJYTwYxBeerp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmUkwFpL; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-323266d6f57so811587a91.0;
        Thu, 21 Aug 2025 02:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755767187; x=1756371987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81UsXzxUVJ+ajSffOPLVSZMBWfzn2NrgIut+TwVub3g=;
        b=nmUkwFpLxZu74y5pRQ+aOjBSVl+xQrwKhEuunylvstDtJARN3sqCXRpccYkEQ0QFjp
         Qq/gpTsWOmyLooA8TPQTGlkz98wlMFdqdxBIhYTR/U0Cxds6EFEWCZxlFQOD1ZORCEnh
         hz9KItA2KZan1S7AeX52qWn7YSW4DJ5eEY6jvy4VnRdEkCWE7QNbjmtE4073HOdSMruu
         EPM449mcg+fvNETXPrwhkYIV9XUSfog1bTGwbgR1tH22sfCfYCFQktZrdSLg5vpITRyf
         lhLIRy3OzkLZcqyidTSML2XgYaoVHH0muoKq9Xm3sMCwAJbCpJVKYW/7cz4srsHX35Pt
         YsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767187; x=1756371987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81UsXzxUVJ+ajSffOPLVSZMBWfzn2NrgIut+TwVub3g=;
        b=ht3Esj0XB1pjAxyrGF57kmwpbFdthSfjEUnFjAlEOn1CaUKRbtQnexdEZiTwHk+Vv9
         fjFzIyT5zE6HMG324x9IGoB9lPbSSnd7lZ0LplgwrZ48Sx99ezszhzekXpXDkG9Bud0z
         Bo2xOjwahQXYPj/nTO16Yof2VZLyTC8z2DtoYph0hbhaBuUrzKIs+U/x0oQoBjJTaI13
         FiPqxF/+d/xnl5xIheW15pS/Q0p7oo3mY0Gmn/cVZaLCwh7Hrvva58DMlu4K5v7sQqHR
         y12Tp5wqEdR/E3qIOXGw16YX7MQAvEkGv/2OzYye9yi6WTYGygC4X1+/dgeDpirLYIMq
         lQDg==
X-Forwarded-Encrypted: i=1; AJvYcCVdCjFuw1rF7NWvOgmNrFv3WP1p0i/E0BoULhqk5lbgW6+XhuMaGqia3Wfh46ztVYhnT5a2XABOqpT2beWp@vger.kernel.org, AJvYcCVjym/G1VvxfGgBckVDMDQnmrsIKC62S30sOE0oziW9FrWLGJ769sKgshfTQcQRO9raQTjz@vger.kernel.org, AJvYcCWO0oZlxh61xY309ndf+UXijcB281dxJkEH1tfQJGGGKojSPEmUDmdtoEOt6vbPsBRbHjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8Cj1xg/jD9XT73Sj3DfudmrOPDtqMYfIvVmUhRYstOZKVRQ/
	riyP/Dj/LCrw1t/k2z52LmThS0sY3iYdrKfHQC+u5IDJPPYgsCvyILiI
X-Gm-Gg: ASbGncs/X4HaFyDJHzIizfEaNS5rcasDnAZ5BxMM4JJ8NKwRhk9hagzISwQZGkEp15o
	Jy19RYHDmnVCkp2EFSkWSuVUe8m79O6rZMdkmhT0Yn1TSAwGgrLSBbeTm1cyqomujJTODcM4+ZD
	XinlcT/2XPUnexIqXAlBzqxwjKijosJ2sN25quhjvTABK5KeC/t0JCwnwmPBuqP6nRcuwU+1cVg
	IelJDKpO3f/R8AKSG1DPewfJRp1HqMGS+2olYz0Y3zifkTkA7KrcydOpuU0Xj1aePYA/p5QJpmN
	Lm4P+j7lqV2YH3DfkJx8hPWuFxQKcDgKqLK3IaZydd0suP4Yx/JECn9e/dJ5uteH4Z/hassnkT3
	Wno4Mo4pBLRKI5Ql2S9DkK2M=
X-Google-Smtp-Source: AGHT+IHiOLaegPCqFhRjfODnSsdY9SrWFYGEQbdp54vFBIfPCpuzu4ZDNs0sWLbQVDRFdlPHmxWDbA==
X-Received: by 2002:a17:90b:54c8:b0:321:2b8a:4304 with SMTP id 98e67ed59e1d1-324ed0f42c0mr2906974a91.10.1755767187389;
        Thu, 21 Aug 2025 02:06:27 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76ea0c16351sm1708937b3a.14.2025.08.21.02.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:06:27 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	daniel@iogearbox.net,
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
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 1/7] rcu: add rcu_read_lock_dont_migrate()
Date: Thu, 21 Aug 2025 17:06:03 +0800
Message-ID: <20250821090609.42508-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821090609.42508-1-dongml2@chinatelecom.cn>
References: <20250821090609.42508-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

migrate_disable() is called to disable migration in the kernel, and it is
often used together with rcu_read_lock().

However, with PREEMPT_RCU disabled, it's unnecessary, as rcu_read_lock()
will always disable preemption, which will also disable migration.

Introduce rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate(),
which will do the migration enable and disable only when PREEMPT_RCU.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- make rcu_read_lock_dont_migrate() more compact

v2:
- introduce rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
---
 include/linux/rcupdate.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 120536f4c6eb..9691ca380a4f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -962,6 +962,20 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 	preempt_enable_notrace();
 }
 
+static __always_inline void rcu_read_lock_dont_migrate(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
+		migrate_disable();
+	rcu_read_lock();
+}
+
+static inline void rcu_read_unlock_migrate(void)
+{
+	rcu_read_unlock();
+	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
+		migrate_enable();
+}
+
 /**
  * RCU_INIT_POINTER() - initialize an RCU protected pointer
  * @p: The pointer to be initialized.
-- 
2.50.1


