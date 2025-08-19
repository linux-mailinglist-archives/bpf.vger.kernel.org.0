Return-Path: <bpf+bounces-65955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3862AB2B684
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 03:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BA017E534
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 01:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585AC2868AD;
	Tue, 19 Aug 2025 01:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbQzycVQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FBE2877CA;
	Tue, 19 Aug 2025 01:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568740; cv=none; b=BjZYnvTJUtd9sXOk/6FttAJF10opDxolbD2yVkhlEd/xqX5aLZlK50SWWs7fJFnJ/kqD7JfDCTbwe7zDXToe3lmRAfejMYpsIfhY0tkS1zgItTfuP8Aldf8eoWo98tbqTM/7DN1665x1Do7FjvtRSDIQsEGxh18VZYvaCJsuxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568740; c=relaxed/simple;
	bh=kVXO32XWFGFryq+9u4jMGw/2BQMQgJzRVyV+Y/D478Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sk1PzszbAkMYoqXzgoLt8S/jQeqVhfKZLS0zLjIbWGwWZ6JEkBuK/wdzLU4/uKo5eU8cnTuJnwT9sTJ1SHs2T3Q3kOWk6XPQ9CI83zxpC/5h0Bq8gsYL6n/fwYP8aqhixXQp6SXIezZJrGQCcWhlWg2Ib5uW0FW3/6uMod7luD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbQzycVQ; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76e1ff326bbso4340499b3a.1;
        Mon, 18 Aug 2025 18:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755568739; x=1756173539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/lWdjE3fEvYN7U+VU8qdCr2mZquMa68Yf5oLPz/zjM=;
        b=fbQzycVQ95VPs28McHqnhyW0d/YJgHxyK8EGtfS5XepqAKEgGA4EjBo24F4MiHrCoW
         HyOLsU2VG8V8MWnfLtMS3AzuaoHalT5mvOVWPBNbN5NwDuHSUORJFXQO3/KYha2Sypmx
         iZ20PC9ffRK57bhjx2ZV2N0OEKevLmcLlSLg9JAQ2RZkVihvHU6hbC2S0iKdQ4IxuDaQ
         PMw2oY081+IsfdHdkdWw/Bf81sNmPfuL6C1yQXD4zWBfceYB3kNmpub1PvCZlIU7XTD1
         WgySwJ0Q+n7zNi1BQS1MojMaGWK4oIbDdS98X1nn8g9/1ZSuShpjrHQgu+V63GJ/Q+0X
         KdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755568739; x=1756173539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/lWdjE3fEvYN7U+VU8qdCr2mZquMa68Yf5oLPz/zjM=;
        b=IsapnPjJXKCktkmPyXoOYrLQQ1Bg0iCSSRkgGxQZcosfnwZhDk/E2ydMsykOV78fbD
         RYlIAgT+2ZKvmf3kul82knqXNfzjJGWTod9BTmjrzR1BW6OBlF9aF9Gtxg623Ho+I39q
         C2txENEeDHaqAiHRIck11cXKsDaB7I+D7KzL5JhTji2lJSzb8BPOscILb0XD6lXM0Hcb
         7XB2rNJ25HyEZnxKN9bOxS4Pl+L6qEa8eps8xBmTLg6ujrH2/1b3lQ4U57zSyi/T1npC
         tvg87IafBeACrAgJ89FNwUgmvO+mlvHd19b23HruIBxQ0aqBg+7TUfsMwzwH1CYAQHpN
         0o/g==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9WHQnlg4IVUKZeBC9BYG2mx4i+hS4IgeZEfoqFqH+dE5Or1rkR0MAnx+rwVpdV7pFRs=@vger.kernel.org, AJvYcCWpn6CMWtqTl8x/BybFkyAD+nVeeMcE7+VoeN8AIsHA/usTCiQ0vwkIYaxm3/h30/4KbVvfFPS1XRt0G4pP@vger.kernel.org
X-Gm-Message-State: AOJu0YxknL9xvCQQeIFn00/I1J0AREzLSzbPydrx1RxwXu+v2TbjQc/4
	biTc0iAwj9kcNVrY2xzQdI3BQ1n5Algmyik4IsaR2TU/Nf9Y3E4SBR06
X-Gm-Gg: ASbGncsfE1IczyjvNknSrRmQ8D3julFRUuaTJHCIrkCXV8deWbhPv4XuU0VyxoHP2rW
	4POydURHzXRQpcQ9qiHDb3F611pgjG7h8mMPkVBN0SP+5+VHIN/6qBG939oHOIzbgZCkSdaHx9p
	BDeVG4swCYJzjbcn/FEo5ybMphSSQIBjXh8zPr+8xZgq1j610sb4P+UTYo8ALcnWCBB88oVM7zA
	4Fs9U6uZHi/No20hTbLojWA95ohyz00hnMBWOO1+Rdizq7CuYZHem77nycu78XcL3R4DWuXqksk
	ZvUllnH1riKMdRgHFSPOQU9UnoDGeAxgcDNgzbHa94hTYLi3WkpubGTG+W/ZuaXM3C1rapO/m6w
	cS8rWQiFSvxO49LnB2GI=
X-Google-Smtp-Source: AGHT+IG66QPzdkJycJt460PXwtNbK0vYpj513keLIcDkGGVvfMb0R4fxvIXAGn8E5IdOozpRmx8q8w==
X-Received: by 2002:a05:6a20:6a03:b0:243:78a:82ce with SMTP id adf61e73a8af0-2430db1ace5mr753877637.27.1755568738625;
        Mon, 18 Aug 2025 18:58:58 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b474f22665bsm1952013a12.20.2025.08.18.18.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 18:58:58 -0700 (PDT)
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
	simona.vetter@ffwll.ch,
	tzimmermann@suse.de,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 3/3] sched: fix some typos in include/linux/preempt.h
Date: Tue, 19 Aug 2025 09:58:32 +0800
Message-ID: <20250819015832.11435-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819015832.11435-1-dongml2@chinatelecom.cn>
References: <20250819015832.11435-1-dongml2@chinatelecom.cn>
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


