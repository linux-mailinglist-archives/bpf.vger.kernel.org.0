Return-Path: <bpf+bounces-65307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AB8B1F838
	for <lists+bpf@lfdr.de>; Sun, 10 Aug 2025 05:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB9917AB38
	for <lists+bpf@lfdr.de>; Sun, 10 Aug 2025 03:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7B819F40B;
	Sun, 10 Aug 2025 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exYXhdii"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFAE17333F;
	Sun, 10 Aug 2025 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754795150; cv=none; b=tmq/2pDoSR/NbuWfmDO8hheQeEbsaLhlr8x03eW+OlNUcQx4All0P+nbDNA7UlH79opiTEZUuEVjcJYsV8GDFCf+GMX229B4kHH7ND8u/1kTmjJi3EuVWoumYwxiiPH4h2MnkTMjnBtZsuzy3WLYktWAY/r0HFqDFbFhUGrzI8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754795150; c=relaxed/simple;
	bh=kVXO32XWFGFryq+9u4jMGw/2BQMQgJzRVyV+Y/D478Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfNyBD0WsRuFRIhv3a8LWM0uAyYfw5ogyk05XSwmWnsVUJT5USv4lpt61hqAQgyFCGr5lBpHP07sY0zQRpD+xxRIb60YfsED/vQFimzGfvwYQk9x31ZiK57aaZAWdBUffdkm2Q5dYlSETEtpBA1Qb2P3L7DFExT6YeXrbWnEVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exYXhdii; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7698e914cd2so4385353b3a.3;
        Sat, 09 Aug 2025 20:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754795148; x=1755399948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/lWdjE3fEvYN7U+VU8qdCr2mZquMa68Yf5oLPz/zjM=;
        b=exYXhdii9sU3dH8OXIsCfC8jSw1z4/SZDe7d7ICOBLgKGe5D8XS7i79z+v9MqrQwPm
         8+EqjvaVnv+qMtURWVYy4LpZMv+AkiSVTkVHeYVOjd5cU+c4edIClzLA3IQ+KK4EnYrK
         CCBG5QiC5948kCOq+22hgXXa+hfrUbyAFawpSn1C7O0+/2Tsq/94v0iMj8MRpCRuge+S
         I8naxgO+DTFab3bCFjsqCSILBOuCx5EIZq2rHpacJOdNaDSkp/n955nnUdE8RIiR52P8
         O6Pxk1WSk7YmlQz23YefTaaag50TV3RkcaDP/1klNvVQTKq2kGLvszHCI7uMe1pA1iqO
         5nuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754795148; x=1755399948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/lWdjE3fEvYN7U+VU8qdCr2mZquMa68Yf5oLPz/zjM=;
        b=V8oxCkJ6a+vq5tels9NC4KZcIfHMcM2qXsH2Fa9LhllmCMf8g/FYPGNg9MTBKT/Y0t
         /rjP/Aw8U79bBN0yJCNy3xS1k8Y+f5oXQCJ2W6K0ClX7ySfo5s+Na0z+d2t/Kz3qRZpc
         qkWfcy+G6IwlJJ6M09MujHhl2V0Cr3Qs4C2xpCMGX4xqS9U283dnQMIBovgiuslaGGoJ
         PZnT4rKT26jaydM51feybdJkVvIVoMQwie4ivAIu3Iwt8fi3ea6Vl+obHiR3a4mjmjBx
         H17+e9ZKSpdAt9TSJIwUTNVnefoWPZnPtGrLhFmamvSo/KlC0oXUpky3oRQgQhNc1ooo
         hixw==
X-Forwarded-Encrypted: i=1; AJvYcCUgEDxS5n+kYrlTjfi7WGNiIZsCX+lgPPgAlVdX6fHB+QSQNWx0/uVJ6Sbv58uKENErJG0=@vger.kernel.org, AJvYcCVSWvG/1e1kkLxLSiJcWh0k+lQE4bEQ9Id7bO9C81/gw8tIoDM8e8wbNSzvOZSZASYgLQjDVW7qKBTegDNS@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdkkzRxRUiIwGNI4fO7JbRefURS02qg+T+FERtxwtH7JBc978
	52xF/ZcCzwy9chPtLrIb3/+/mmSic8xg+ujdR46zRkQpoIrutSq7aimc
X-Gm-Gg: ASbGnctef11rl2s/MpAeWlB/i3HcW+NN9D16wDpb2D+sAuxaDIdydwNM7A9w53QBZ91
	xkWDakumvCtEN4PzHJWD9N2kG18sWCr03fwJxKBIGAJKGpYmiDGpwTRbNZobKXkSrbT2yaNbPiI
	6ZdIHKR83TUXrWFXqiGSjS7k2iNXz26mIEf5skRk/mZ4tnZP8pEAs7HosHVaoIyuh+ExILnU3LV
	HRceCsN8kCbPnDXSvXY6Htx3//07aVUpHOlA2nEQNmlmK1CrRidsXzsF2nfOlIKAcrfSIRXRroL
	Me1SfGycHtqoROKktoOD/1zu7j0CRjUaPaaZkv/cFn9j5tUb0lc0HpzkznyFHrjalmD9nY7HEDL
	41tulaClU8QDWSNAuNa8=
X-Google-Smtp-Source: AGHT+IGpQgcJ07Rb0COrFVRfwZ1+k4jjANaMerJrGc10MFgaKDK94feNSeCO72ZP1Id+CGk4jqhMnw==
X-Received: by 2002:a05:6a00:2d14:b0:76b:caa2:5bd8 with SMTP id d2e1a72fcca58-76c4617fc32mr12233675b3a.13.1754795148132;
        Sat, 09 Aug 2025 20:05:48 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdd2725c9sm21276265b3a.6.2025.08.09.20.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 20:05:47 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	alexei.starovoitov@gmail.com
Cc: mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	ast@kernel.org,
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
	jani.nikula@intel.com,
	simona.vetter@ffwll.ch,
	tzimmermann@suse.de,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH tip 3/3] sched: fix some typos in include/linux/preempt.h
Date: Sun, 10 Aug 2025 11:04:42 +0800
Message-ID: <20250810030442.246974-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810030442.246974-1-dongml2@chinatelecom.cn>
References: <20250810030442.246974-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some typos in the comments of migrate in
include/linux/preempt.h:

  elegible -> eligible
  it's -> its
  migirate_disable -> migrate_disable
  abritrary -> arbitrary

Just fix them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/preempt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 92237c319035..102202185d7a 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -372,7 +372,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 /*
  * Migrate-Disable and why it is undesired.
  *
- * When a preempted task becomes elegible to run under the ideal model (IOW it
+ * When a preempted task becomes eligible to run under the ideal model (IOW it
  * becomes one of the M highest priority tasks), it might still have to wait
  * for the preemptee's migrate_disable() section to complete. Thereby suffering
  * a reduction in bandwidth in the exact duration of the migrate_disable()
@@ -387,7 +387,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
  * - a lower priority tasks; which under preempt_disable() could've instantly
  *   migrated away when another CPU becomes available, is now constrained
  *   by the ability to push the higher priority task away, which might itself be
- *   in a migrate_disable() section, reducing it's available bandwidth.
+ *   in a migrate_disable() section, reducing its available bandwidth.
  *
  * IOW it trades latency / moves the interference term, but it stays in the
  * system, and as long as it remains unbounded, the system is not fully
@@ -399,7 +399,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
  * PREEMPT_RT breaks a number of assumptions traditionally held. By forcing a
  * number of primitives into becoming preemptible, they would also allow
  * migration. This turns out to break a bunch of per-cpu usage. To this end,
- * all these primitives employ migirate_disable() to restore this implicit
+ * all these primitives employ migrate_disable() to restore this implicit
  * assumption.
  *
  * This is a 'temporary' work-around at best. The correct solution is getting
@@ -407,7 +407,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
  * per-cpu locking or short preempt-disable regions.
  *
  * The end goal must be to get rid of migrate_disable(), alternatively we need
- * a schedulability theory that does not depend on abritrary migration.
+ * a schedulability theory that does not depend on arbitrary migration.
  *
  *
  * Notes on the implementation.
-- 
2.50.1


