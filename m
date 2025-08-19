Return-Path: <bpf+bounces-65980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A18A4B2BD7D
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E50A684E2A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F96631B105;
	Tue, 19 Aug 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSgVELyh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43F31B125;
	Tue, 19 Aug 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596089; cv=none; b=Gcen1ArMwF9FMtAta27iz+poavD+KR2BUKjSq7wLNJ3LhIzmErgxFVzx5un69/3dwSmXt+4kNt0UR5deiVx3hHWfiLPP3f5+vjG65ltpE+BPHseWdKz7fpT5Z2wlRF+OZnfVuQ/lVQdVwXklblQbDMOWzdx74MBa7fhmYPm438s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596089; c=relaxed/simple;
	bh=bTIHaC7j+7J/bMwGU/BkRIOcDtOKJIMEeRQy/KliUC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHMYkYN+Y2UcqssHMUXZ9j1fuqcYXZrHPX/TB4rYAXeakr5zVjBQ7BY+vA792aZa7f+za67HriYoc+pcZoVNqUN97NXNTN21EIENv95OIra6Cj6CnrVhrwC4F9GItPyniixxOa4XZslYpx2kppqXuMYMfiMRijxRKBKaJotjYTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSgVELyh; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e2e6038cfso6032632b3a.0;
        Tue, 19 Aug 2025 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596088; x=1756200888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuCltBuqWN/DSCHw6nPVx35dtf5n5wtufyyXilS2WWQ=;
        b=NSgVELyhU3tpSs5vW9/N8FjFZm13ogYnwZoKxqNvoiGOuTOPr06IXGMXEh/mSDOspo
         PpilO5J3AwS+oMvZXgUvFXmV83aSvJv6M0A/mRoj1317iFZrxkfJ07BJi9Zsj1Cklhqg
         f8YUYC1r6zpSPyaOMD60cbgGK83Ottjk/mRkZifluRJhHe/5nfhUmXk1h1FuHBl/cn0q
         DGJO4XuTNv7pclCRLN4hYDgOxceS+M7LJ+ugOa04W/KO0KcreIlKUxmyJKioo5I2CH5L
         ipNyemhLpZIdyahrqa7W7Cwirb16GBnDfXQ7TFEiMQd8xbwyWI2is6bC9R4Lewu2R8KP
         /7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596088; x=1756200888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuCltBuqWN/DSCHw6nPVx35dtf5n5wtufyyXilS2WWQ=;
        b=Vz1t48adS5kzsMQ20I+nMxpU5v5AJhD1q+M9QVs2ysrBut3cV3gjV+GbwPnxgMBYmy
         VDYPw50PRfhcFIwV2AZ4uffU5h3W0Wu171pzGeAzNX3cjjkNv3xvcZrjzv3aqJd+jO2j
         ZYpxJYyEjK5wLDzCXdDrbB9A+2OFsAPZe6EdU/X2Z9DuDq6h1NsjBXGfKaBNw5WdsEi1
         jmi/F7tR7t3DybX8HtFVBFShIIKqKUsrckzC/3mdEGqLrjVtAPU9bC5nL92SP0qO3zKu
         /Lql2b6zwM3FHW+vXRL8i/r06Ryn2+XOTcZrnpc9EYALqpWPORqpueuKmfTqyb8LFVtT
         CKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQY9ac5CEnyXtXfctzFQ595GIczXnobfBpV4uUzmcH+nlZX6VpUOZuHYXzVGwf5YAqpts=@vger.kernel.org, AJvYcCWMJKedk924rAT/hVZxOVesDRoKWeFQJok5+5Yw3c2s94i0ryfq5Ryrvyw4hT634sWGsaM33A4hrT7fJ+ks@vger.kernel.org, AJvYcCXpfTn/BhWB0bpW4B1cgI3KtcV+k6ErTn8bAn3MBeZUjOl44Pd8+nI7khHkh1sR882ZB9Gp@vger.kernel.org
X-Gm-Message-State: AOJu0YwMn35otF6nZb5xYWFPhkV7RArWeHTjdnM5UhbmKzd6cTg8zXAP
	VFuIraWAGsYNRfBg2qGZpwymXBA6h0SMS3Ff71bNYDwytFeg1xhbLQ7p
X-Gm-Gg: ASbGnctUqVDeKJh075fiL/2S9ZVjuFVkfQDo5nVwn57duFF5zhbmHiYqQA8s18fTG+s
	B+IATxoWxn7umrYOuDWaxLZop7BWh6buqRtg+3kF+82kglB5GzvJtEqwwNEUyis0wotDqIEHkwu
	f6+7z328bV/zahIq7hZr8TvjsBiYEabb7c5D1EXpwCsVdb3sJeWC3U3DW792Njg8TlLGawANAY0
	9fzEXGnNt2aukQF2f74OtcLm1EQQQR+S8P9Igr96oWzg6dj/gpb0AhRAhI5bMNCGU8n1u87RW1c
	cqak6T2h7J8g4lD56LfsPA4kGzBR8q88APOERVElkE3c6Fu1npCjVpxV1xgdnC2RgxenDzOZl2T
	//YhR76kx0tyOLCCtxBQ=
X-Google-Smtp-Source: AGHT+IEWDXMb2Z+W99ZoDxKTIlJ16JU5fmBRmoDh0U1K3FBxgJBIF0YoVmhCPXKCDJPP62gTuqMl4w==
X-Received: by 2002:a05:6a00:1399:b0:73c:a55c:6cdf with SMTP id d2e1a72fcca58-76e80eacd4cmr2178971b3a.1.1755596087532;
        Tue, 19 Aug 2025 02:34:47 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1314a4sm1990945b3a.41.2025.08.19.02.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:34:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/7] bpf: use rcu_read_lock_dont_migrate() for bpf_cgrp_storage_free()
Date: Tue, 19 Aug 2025 17:34:19 +0800
Message-ID: <20250819093424.1011645-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
References: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate() in
bpf_cgrp_storage_free to obtain better performance when PREEMPT_RCU is
not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- use rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
---
 kernel/bpf/bpf_cgrp_storage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 148da8f7ff36..0687a760974a 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -45,8 +45,7 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 	struct bpf_local_storage *local_storage;
 
-	migrate_disable();
-	rcu_read_lock();
+	rcu_read_lock_dont_migrate();
 	local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
 	if (!local_storage)
 		goto out;
@@ -55,8 +54,7 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 	bpf_local_storage_destroy(local_storage);
 	bpf_cgrp_storage_unlock();
 out:
-	rcu_read_unlock();
-	migrate_enable();
+	rcu_read_unlock_migrate();
 }
 
 static struct bpf_local_storage_data *
-- 
2.50.1


