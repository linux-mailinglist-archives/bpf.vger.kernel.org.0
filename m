Return-Path: <bpf+bounces-65720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4222B2790C
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5123188B870
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E252C0307;
	Fri, 15 Aug 2025 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrPKInVY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6642BF3C5;
	Fri, 15 Aug 2025 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238740; cv=none; b=JSHmW/Jt5pErxqSM23K5Da0+4ewgy5vNXbmsK8lxRTCvpuGQ+p7akjNRYpZJ8EiE01OwJUtHbGT5jFDgWCTP/dPNipFhzQoAk7eVD09px3XBHuz58LRl0PHkxn/NMs0RLKpf94Iy+kKiyMixaWU0gCeBnP6DT9L7W8NQ8SPTck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238740; c=relaxed/simple;
	bh=SNruwWdpjfWXEUmdcJGLbAJaSFT15pLLauu5/KGhBA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjpVcBdVcSywnh785F4+AEHTV1tuFjnBcUp52U0xPaj1sVhGmeUzfuT1+co4CGvRJW2wiyAS9mBB6rwRVoqYAXsyf4ZgBYynfj91gkXV5m6snaUeXuAHp2R3uFz/EoWDPvTNuc8KCFOxPhg+6umRYNV8aeSFL9WVh+onR8H2IrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrPKInVY; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e2eb4a171so2366853b3a.3;
        Thu, 14 Aug 2025 23:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238739; x=1755843539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxDb7VtzlRm5Ny+o2TRQ0jpYfl6LPm/O+U74ZNbAScg=;
        b=BrPKInVY0Xo2BDfAi+FWeNsxr8aJtuaMJ2ir0hdw8eecZFeodXJOjqcgK8lbAov1tO
         3YtGMtx0M75+XZ6vdhcdKl+c8T1i9OhpuYm6hLh3R4oobKrePHlPSRxZxKeHtu+KN3s9
         //1m+kt2CwOry1Kw7CQ2oHCz75caXSiQuf0xOk63M594VGMQpI7zH4F23UPUvmy5ChHq
         Xk4+NYwtWpeiiZjDRKSo4MQsQbdaEpjBmY6gxk1N+/XN6OCgRqZen8UeUPZp/Rif+uK1
         eNPb3vb6o/KmYindXc2GQIHRQYsmf0INZtm99azFtfoec/ugqKteDDHgMpdQ/0GSpyv8
         Hthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238739; x=1755843539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxDb7VtzlRm5Ny+o2TRQ0jpYfl6LPm/O+U74ZNbAScg=;
        b=IAEFu6Nw4tY9zxgM+Y3EIJwNUhbBNwZ2z5hOYYxQVp4F5+fVc74OHlObQwYAS2nstA
         z11zOUeYuna73N7GaaL+rYSeF0PDHtcAU2Ysb6t3fDsDk2hEBbFYBBA7EVY2f/WSsZRG
         tQD23v9qYJPnV8tuowodUFVi98mXpaBxz5w481uPbKCrtrj6INqyB/fs84riBch14n7m
         KGteO78rVNJ4AzrKfeDcJMQkK5q+4TZdWVT1//iA+kT9JffGj5U1pK3Na6Y97fdURkxZ
         9QH1DRoZIXl7o1TJDgv0MhkC7wubzXRrqywkimLgCS5XhTLccAgICd5qnAEaUK7z0/NU
         ncSw==
X-Forwarded-Encrypted: i=1; AJvYcCVcbziKN0N0V0NCYvB0eAic9P8KdQ4A+T7YGr9nq72/q6ojHev01aL+RAIoSbSY7y0+JRYwEkdTZ1v8cn1b@vger.kernel.org, AJvYcCXHcR4UgL3u204DgoHqQt4TC8JMwhjrpe4zTa2syLjMI3PinE4/k8UTErTQ6SnRFG35/Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGB6i6XIWfGt9MCu8M2yd+a+edMInPev4+zYllQwMxqwFW/P9T
	dpHtt6tGMyHSaq+msom9sM2csDd2Z94UTMagAV+Uw8LAHLJHsaX/OKmG
X-Gm-Gg: ASbGnctL0SiJ60heBQp6Lg9K8BBqJG0neXwVUpzIfxZB2E8oXOLvYW1GW0QagpmqZjG
	cws6XOWjjsb5TMn/6brWaZbQxacdz+UcDRGMjJG01fYqRVRIYYlBaLRqK4wuQH328Dcbh123DwO
	eBu3dy5yIAemgGLOhlTTc8s5HtwH+UfMHTGsuNXYzVAubnxgBkcdPPPQhTpXvF7YQlTU1AYMt4w
	E4mclz2HCF1EIMn8TaYSb6Ae40gKksYguikvqkGpOzqbEojqe4k5jUEhrve9pU/wSYJegIseSg5
	zHjLuP0zmF7+Kpr/o61Vb7TF0nPHnrQRmU6Bd2E5ceMF+HNibCE/vTscnqEs6c5wiEKM6f7nBPV
	Q40zUPzJ9twX+TeiJhHQ=
X-Google-Smtp-Source: AGHT+IGHzJYc1b8aDYJWk7Oedt+80knVWvfTd5tT3z4XLOl2atN3JAUuQkm707sPiHl14JZtY/hoNQ==
X-Received: by 2002:a05:6a00:4fcb:b0:76b:f828:34e4 with SMTP id d2e1a72fcca58-76e446c575amr1104030b3a.6.1755238738586;
        Thu, 14 Aug 2025 23:18:58 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4558ae7bsm408607b3a.95.2025.08.14.23.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:18:58 -0700 (PDT)
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
Subject: [PATCH bpf-next 6/7] bpf: use rcu_migrate_* for bpf_prog_run_array_cg()
Date: Fri, 15 Aug 2025 14:18:23 +0800
Message-ID: <20250815061824.765906-7-dongml2@chinatelecom.cn>
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

Replace the migrate_disable/migrate_enable with
rcu_migrate_disable/rcu_migrate_enable in bpf_prog_run_array_cg to obtain
better performance when PREEMPT_RCU is not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 180b630279b9..694635699d46 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -71,7 +71,7 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
 	u32 func_ret;
 
 	run_ctx.retval = retval;
-	migrate_disable();
+	rcu_migrate_disable();
 	rcu_read_lock();
 	array = rcu_dereference(cgrp->effective[atype]);
 	item = &array->items[0];
@@ -89,7 +89,7 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
 	}
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock();
-	migrate_enable();
+	rcu_migrate_enable();
 	return run_ctx.retval;
 }
 
-- 
2.50.1


