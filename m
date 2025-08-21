Return-Path: <bpf+bounces-66170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B899B2F43B
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530F6603F33
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB4B2F4A13;
	Thu, 21 Aug 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZDaSrq5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369D2F4A14;
	Thu, 21 Aug 2025 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769116; cv=none; b=mAu4L5jmqUwG840rvtz156aCkI8YakxjfWVgJnSXFiQ6QcF07WmOeWpIUtmmCsGZmBRkqGngkzcEv+pupGnRDw+2aXQ+YZIceami01eT3GcRQoZgO+SeHbf+9nwDn+GHZ5Wn7FB36DN0IJplaIhDlSC6ey8y1Pqm+eWObfKjQIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769116; c=relaxed/simple;
	bh=kVXO32XWFGFryq+9u4jMGw/2BQMQgJzRVyV+Y/D478Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTmQkq25fnPTU+QBN5QaJIs4wrGojXZtoSPCGNCD8+H93exbp1bp8yFY3iYTpTUn0chKtfg4UAE0TsoJEPOJ4+ZLmknsQrk1fAKqs7O2JKmP5E0DVgzGKMhaJrG2MMiZaDaRkFpXXdeLm4oSvShbDhlESof3/gWcgbDiJhLnVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZDaSrq5; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-244581caca6so6379715ad.2;
        Thu, 21 Aug 2025 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755769114; x=1756373914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/lWdjE3fEvYN7U+VU8qdCr2mZquMa68Yf5oLPz/zjM=;
        b=IZDaSrq5FFVvx+rCVrIhJRPy+2ZkwD+o75EmZ+6hZeo8uHUFNOO5h3InsuSpmE0bLQ
         oxpGneq/V01b1b65sEfLdinpOwlO2N9kBkdoLFTZ5bFxPKDrdkAMSoDIhsI1H+pGaWdw
         AyGQmhnEQF70BSEX/+Ikf5dHJebJq+AD0H7aUeZ0t3Rk+AfOu60pQr9ppeBGj6rRwjhj
         qGh2dAUNVSD9cJHxqyL6rUsUeTUTnIItAHWMxtmKtmMAl2EswWOiGeF1J/UXSLcK4OKA
         vT31mID+hjmeSb1G6gwXA5pAxS5mYnBBP/IzI067C2xB+I/ugMvCWxV4rRybN8KxYrDv
         PZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769114; x=1756373914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/lWdjE3fEvYN7U+VU8qdCr2mZquMa68Yf5oLPz/zjM=;
        b=mlgRN7/GtofK/NqghkwjCT7v3+BS96IiSh4jmhlhTgIbsqO+hMbR5MNNNgNnEi+Nne
         ztvsOwRmVcJBjideNssfPThaOOo2AG0ggpIiWyhzhjw6BofGAO3J93cbno6YIIbuCZUs
         E02aEqEflBGGy2QH5WjsUe1axj1eALbshChW5cg2k02ZXw1x3DggUwsRfC0+W5zDrdQ+
         XMonAd6JmWSSM2qzdk6X3WJVvBzYlmjmcOoPyvhCFk1Fxip0B4F9DQ1l9HtYASvZ78fU
         zn654FUloniMBOX6wU5n+RBGbR+p89PsczECmsEzlcRp2RHI8UN6fmBx1AoULrUuFh+h
         OppA==
X-Forwarded-Encrypted: i=1; AJvYcCV4sCa+fWFIZSU/qixf1ZczR4HN8FAPpMxQ5YnKyV3hJGBlkBFaTCYe9tmTGWQujhkiQMg=@vger.kernel.org, AJvYcCVJeFP+zUUa9Xyw23cTvp8kvR0MICQO59xceGd2pg0yAsgDi4iuujwJJ79hVebAHaPCTctEVcBxRNMec4p+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxly9lLEIL9SHgLwwhHOVFvNOXCdAdqU0PBzaXSOBSENeyDVjqI
	6Y1E63I6NhCjnqjsH6wlPTanbzk6ZCvdGpTzwEOxMagzrpG0eUXcFAGuWpwibFGi
X-Gm-Gg: ASbGncsfvzzX1jRs+y0+DB0gKGfYi6/iacKBLN+CVlEVPetPe+KeD2jo6TfNlcbeaDc
	2/u5eehqM6HW7ZdMNzeACJT3wHO6a9sVopl2CacDmkifYBfiUJLDKJ8MsEhd9pqC9zOrXJhw2u/
	7LAFgFfSr2LYdC485julXRByiF2Bfq/45QHl/iSQnUrCz2AtqnfGn40MyrLQvlT2Y3vAOdaaEa0
	3MML01ptKxC3DnUGC/ebazFGiDrRWRRkLvfMgan2bsn1FJw6Vywk7GIqsww5U9b7GmmNKi/3UU1
	kGyuTfCjaaYsczQmkmpp92N1RAuH/n8FCRV4rXIoMLva3W47euWH80pStplngrrR3ps3kcDP0Ke
	COEzLMoz38BGPcb25r4LKd74=
X-Google-Smtp-Source: AGHT+IFg5WiwDVY+YqJgz3hCr/DxdpPlyKu+8s5WFfAqsg+aZ9RaMMCbOibd0/vf98BiHnos1oXBoQ==
X-Received: by 2002:a17:902:f605:b0:246:570:2d9c with SMTP id d9443c01a7336-24605703291mr21256755ad.61.1755769113885;
        Thu, 21 Aug 2025 02:38:33 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed540040sm49652085ad.163.2025.08.21.02.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:38:33 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org
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
	tzimmermann@suse.de,
	simona.vetter@ffwll.ch,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 3/3] sched: fix some typos in include/linux/preempt.h
Date: Thu, 21 Aug 2025 17:38:07 +0800
Message-ID: <20250821093807.49750-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821093807.49750-1-dongml2@chinatelecom.cn>
References: <20250821093807.49750-1-dongml2@chinatelecom.cn>
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


