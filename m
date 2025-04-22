Return-Path: <bpf+bounces-56413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9FAA96D62
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C30217D49C
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81C8284B45;
	Tue, 22 Apr 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajfS0Fan"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61544C85;
	Tue, 22 Apr 2025 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329675; cv=none; b=eCwUD+HkIFFqL7SX94GDxAigNTlSDIioVqmIUYRI7sdOAt+VbINQ78hmdA6p6aLy6+6GXCaYsuR/fZAeLPgOM1KZAt9pnZHCLcu3hmRiyopJ3Gix0rm4vGdV/rHhdCmu7OwnVr8c5MKf/mTX8TjzCrwNdCfxgHA6nE3ciWFr8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329675; c=relaxed/simple;
	bh=FoNPp8gvjLy3QZyMyd34WJbEIvriF/TJs1PaU5tXNLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vyg08Y5czSNXF4ku6npTXb5bQJZXiZ71xDW/sE3xiandARRDH5MsqKJVjFVsBgfO149BShxhXxB+MglaOWyY/suK5cDmj85g5Vw2ErNiS9XPk/UpBXRV4xX+V3IMn5BbubzIyvv9whnvtOkWhwWhC/Q2s++Rpd1e+GTM/oNekB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajfS0Fan; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af9b16eca8eso318205a12.1;
        Tue, 22 Apr 2025 06:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745329673; x=1745934473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+ByOwbXTp0uyTPHkOtuOVbDZK9B4SVuPq+zJXZT0mE=;
        b=ajfS0FanXhaoNTgxopjlCzPB+D1KyfWBYmtmBYMO7BYMpuPITN602caBjzzb0aO2cc
         ixG84DT+SK+2sexjOHz2GAzcdRGUAqwmXq+smx+Oc/nLhd84hHr+f57zKA8ywoQ6EGWm
         ThpyV7LCdaaXx6ByZnXkIsWIG9HeRNRUavYS9ZYvFCPj9NXX+PXqMDKq33ZXBieFDzcB
         0Od/hlWT4WZIEgpw4c5kvWSS/S/r0HkOxK9U07bZBSbLnxbE4Ero75GOiQHbjCaMNJbO
         wxAySc6MAEKZwLkqlKmpbE/f9wHKMA5UMIJjPL47RtTEpiNbqonD+raLUoqFSFjrPigB
         mvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329673; x=1745934473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+ByOwbXTp0uyTPHkOtuOVbDZK9B4SVuPq+zJXZT0mE=;
        b=pxS4+qpiYjzBXvK87jJploRibdA+ulLrkDhRoSaKi4ftkrQAO4AWqOWFK2junwlSxF
         quH0AOYlVGcfcDtckC5d/y9djRuRs3OBGFMXn2S55XIY8IIStWRbuO8fRzfQKOZq5d7x
         qO8EHh1ttbzF70Q81sWmVKTmuqo0uburgAyke+ljeqMBTpVfKPGBq+fQmtPymS9i74IZ
         ViTo0EAJhDgD8SPbMK7LddO2kRklJEYtEEKd/K5FJSVaW7mXU5LbxIXYyudpHVlj4nUX
         iP7s6RnLboZRiiTWKwBiOqX9y2sIPcz2GpSrIDqQeUgjJjfVAatHv98DTzuFS1vIolrc
         A8UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYQFXWH4rBCZV2R2+43pDqCDm3asAK+5qCO1kU0BCm6kj2jm9Aa+xy9xKVSH2a2zNHP0bAVzdREn9SqBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrpsY8PQvFQQyn+YUU4kE6I7ZCH8d9pLtahZyw2TLeV1vzOS7v
	xhNyQyqZqaklIseQcQc5jHNAPiaNMLbVnruAaOs2+IUWJIhsYFYyFnFQImdG+g4=
X-Gm-Gg: ASbGnctCID57KAeAd+CS81ZsTLXR050ZbloYVjAiVap4Hyw7QskbgePRfJXHQKF7hR9
	oS8+qYd3o1f1g6dfzgSZ35oEunJNLgdCzCOv93yaLcs8X7syWc6299Z/cbm8mwr1i6OGuwURjdj
	tUUpepELLdSzu3P52/FtdoHLsiuacHJtcj/owAbrqsOQEFi5UXSlcHeJmjT3YF12DvarFds6UMe
	A7oZkbCXjDx7f0XNUYOw+XVuk30fL1Zbj5bx2FX/DiOfjmLXRmtT12d4ehSMZyqQjcxGNZPWPf8
	I7kVQ39l8vymgdhagR9Se65aOSrbnOwkjITuuoFXOV9tDqhr8dtkk7Fs+QHTpIE=
X-Google-Smtp-Source: AGHT+IFqu8ojOTnhEF4HKyFdc0yN4q+/NQI7lPzrfCLv+6d557zDM0nA6BiAAW+1s5Fbihn5L1GVhw==
X-Received: by 2002:a17:90b:1c91:b0:2ee:f59a:94d3 with SMTP id 98e67ed59e1d1-3087ba5ccbamr8020134a91.0.1745329672828;
        Tue, 22 Apr 2025 06:47:52 -0700 (PDT)
Received: from MGG23TF6W0.corp.ebay.com ([202.76.247.146])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3087e05b2bbsm8695214a91.42.2025.04.22.06.47.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Apr 2025 06:47:52 -0700 (PDT)
From: Jianlin Lv <iecedge@gmail.com>
X-Google-Original-From: Jianlin Lv <jianlv@ebay.com>
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
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	iecedge@gmail.com,
	jianlv@ebay.com
Subject: [RFC PATCH  bpf-next 2/2] Export irq_time_read for BPF module usage
Date: Tue, 22 Apr 2025 21:47:27 +0800
Message-Id: <75aef5f2b9d9292ae919f2af9f82a8618f9b191e.1745250534.git.iecedge@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1745250534.git.iecedge@gmail.com>
References: <cover.1745250534.git.iecedge@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianlin Lv <iecedge@gmail.com>

Move irq_time_read function to kernel/sched/core.c and export for
external use when CONFIG_IRQ_TIME_ACCOUNTING is enabled.

Signed-off-by: Jianlin Lv <iecedge@gmail.com>
---
 include/linux/sched.h |  4 ++++
 kernel/sched/core.c   | 22 ++++++++++++++++++++++
 kernel/sched/sched.h  | 19 -------------------
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f96ac1982893..3b83ac99b533 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2281,4 +2281,8 @@ static __always_inline void alloc_tag_restore(struct alloc_tag *tag, struct allo
 #define alloc_tag_restore(_tag, _old)		do {} while (0)
 #endif
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+extern inline u64 irq_time_read(int cpu);
+#endif
+
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cfaca3040b2f..c840d1ffdaca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10747,3 +10747,25 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
 		set_next_task(rq, ctx->p);
 }
 #endif	/* CONFIG_SCHED_CLASS_EXT */
+
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+/*
+ * Returns the irqtime minus the softirq time computed by ksoftirqd.
+ * Otherwise ksoftirqd's sum_exec_runtime is subtracted its own runtime
+ * and never move forward.
+ */
+inline u64 irq_time_read(int cpu)
+{
+	struct irqtime *irqtime = &per_cpu(cpu_irqtime, cpu);
+	unsigned int seq;
+	u64 total;
+
+	do {
+		seq = __u64_stats_fetch_begin(&irqtime->sync);
+		total = irqtime->total;
+	} while (__u64_stats_fetch_retry(&irqtime->sync, seq));
+
+	return total;
+}
+EXPORT_SYMBOL(irq_time_read);
+#endif /* CONFIG_IRQ_TIME_ACCOUNTING */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 47972f34ea70..d2fd3772114e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3209,25 +3209,6 @@ static inline int irqtime_enabled(void)
 	return sched_clock_irqtime;
 }
 
-/*
- * Returns the irqtime minus the softirq time computed by ksoftirqd.
- * Otherwise ksoftirqd's sum_exec_runtime is subtracted its own runtime
- * and never move forward.
- */
-static inline u64 irq_time_read(int cpu)
-{
-	struct irqtime *irqtime = &per_cpu(cpu_irqtime, cpu);
-	unsigned int seq;
-	u64 total;
-
-	do {
-		seq = __u64_stats_fetch_begin(&irqtime->sync);
-		total = irqtime->total;
-	} while (__u64_stats_fetch_retry(&irqtime->sync, seq));
-
-	return total;
-}
-
 #else
 
 static inline int irqtime_enabled(void)
-- 
2.34.1


