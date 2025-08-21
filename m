Return-Path: <bpf+bounces-66163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF87B2F362
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E860F6880EC
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A972F066A;
	Thu, 21 Aug 2025 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQokETEg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AFA2D3743;
	Thu, 21 Aug 2025 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767210; cv=none; b=Bmvanx0boGZQ/T3hJTmO+ddevgXhwAwZOKSn2nDplRMljKkiQiyPKesGFh26AeqkKvykrpYyDmjRrEoHwhIMc+rsFyPglkG6HiFE//XaZ0aeHQRqWLk55czJ1YGY5cXMZA2Z3B9rtc9cE78rBlS48H3qfMnhgJXTlsMRdZOzfAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767210; c=relaxed/simple;
	bh=eqO46c3pAN3PfhGNOqY8l83f0ewMbPj8kQ9DK6CPRUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z32dPQvA2z2922eAxX7MgduoICS8j6QEPsQh/k8S/vBY3mo2trMs5YPQDVKWi75o93sLYfMcAZZdRhKUPhCFbNV7tRhD+KwICp4ICOBYrUgSjmbTxKpBV0XVAInNTSvlBOqB1Ygf6lmcPFnIXNC02mNOiq2lrcYvrvf+KlXlU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQokETEg; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76e2ebe86ecso992122b3a.3;
        Thu, 21 Aug 2025 02:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755767208; x=1756372008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=861OdxVnWv8IWFvxkcYe5tkgp3QAasS1lAYJfLFgMx4=;
        b=EQokETEg+O4W+MHbMDIvL+HCMw2eNf/XnJphfRNDMCNhvRCG75l86FgHhYdI2H8jG7
         FuCiDIL3UoSsGH4UpQ7jREBZCHuamNYST2DP4oJhI1JqrYdKifEwGrMb8nlDWRqytDo0
         D2yn3rfwzWQhSMfc0xqWsGU0+NtBpJr/tMO579srAh9uofFW4JISedVFh9mAb8m2znJM
         JUb6yHdHrOyzxC9bKm20a5CpBGITUuM5iyArFkNIDoY2xcQk08MkZtYeJCRJ9Kr+GJkf
         C/kF8vZ4TQ9w42Rcm4Ly2mfXKuGYsrFOHWLBNDB/OUc8OKuV8g3IB/Lz/kBpY0ue6gjV
         yetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767208; x=1756372008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=861OdxVnWv8IWFvxkcYe5tkgp3QAasS1lAYJfLFgMx4=;
        b=uqj3OboPvgUriaTThGg1pbIXKMSxsnRyf8Ppmf5TDOIQeTLtjCyWaCr62hopqAovdZ
         GrVTUfTZHbd9d8WXgH1H0+8I2+kzpJimwOnRCwcMaixogBqY/5+9yOTN81k0tnODVpya
         9SdDCK0lll/w+wjTI5p6f0UZlGhfmY0b9dTRnZ44FqFprDv1ohTnH9fBPfBiEtyzNex+
         qVaaZKa6t1rWu/bIYhhl0Y0L+EUoPALdhKCtNM8mfGKuLVo6uhMbQ77sSwU4G94pQnWh
         V58YDbLLYym2eESKEH9/QQWlZ9xlj6a6WmYKA33937xcEjQRItftkUAa88QRhiY4vXqR
         hPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuaLAiwaP/O4eAGxEjiFw/xTify3RMcSWQip7fQq7oKSaZO7UWenDQvjJVZ6w6U01PzPdG@vger.kernel.org, AJvYcCWCNcLLuKOjxW/RS9fpmWZAjY1EoxYKieeaNhaOBY9831suk3v0RfeAe34mSm2to4HqgJFKW7fQXR5hOYdK@vger.kernel.org, AJvYcCWnc1if8N+VSThDWnG7pxLNC1gprH2ImwkQ3iPdZLTt5Z7UaAa3ZhcKsq7oHr5Pgu18H7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIA4TColM9R8MbQ08nWMp5M7X20BlnIFWahc40DiwtOXRD9sls
	oeU4a1XKuKlwu8Dw3JyH3diIJnMnqEuXvds2HgVB2SY2mKfEEJMVqjfx
X-Gm-Gg: ASbGncs79xzwrmP6ZoVOaU1+ctma+6YwHC44kXL82AYlJIakLK5EaZz2atLz/O8lbjP
	BR0IhLJHQnV5IbuQcT7pSwUpfYyembgtp6+wbQ8WWxnl2YXqARM11isdEb+hA59pOBtCRCnEmsw
	Bzsio/aEqq0P6Cv3o0/BlwP1nNfXX9soljKgaSJCBTCrZch3kp1/i2I6L7Kqg/dIHyij8x9m9PS
	r0SOJP94pNgU1Vqrc/pUh47OvgEkID+4FRQnhHqvRmVz7fc8eKeb3Q/jU3ANOjLqqYWpE2Y/OSS
	DmTInLf9TPrOHnlsLAmiib0mKudKLna/ASBhGY18qlpfeN4fQVnsiaYjV2pV4FyJKjTJuDAGUVn
	pIjFZBvjIkH/kTccxBevS8dpJCysxH78iiA==
X-Google-Smtp-Source: AGHT+IHbFHBs2bkiQYDlXGS3VRmYlPSUwRBoe4kn5EMWdgE3xPMdKnwf0IZRHj5qQa2vZc81N7rGDg==
X-Received: by 2002:a05:6a20:5483:b0:240:1ad8:17f1 with SMTP id adf61e73a8af0-243308364bcmr2503050637.21.1755767208009;
        Thu, 21 Aug 2025 02:06:48 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76ea0c16351sm1708937b3a.14.2025.08.21.02.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:06:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/7] bpf: use rcu_read_lock_dont_migrate() for bpf_iter_run_prog()
Date: Thu, 21 Aug 2025 17:06:06 +0800
Message-ID: <20250821090609.42508-5-dongml2@chinatelecom.cn>
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

Use rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate() in
bpf_iter_run_prog to obtain better performance when PREEMPT_RCU is
not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- use rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
---
 kernel/bpf/bpf_iter.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 0cbcae727079..6ac35430c573 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -705,13 +705,11 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
 		migrate_enable();
 		rcu_read_unlock_trace();
 	} else {
-		rcu_read_lock();
-		migrate_disable();
+		rcu_read_lock_dont_migrate();
 		old_run_ctx = bpf_set_run_ctx(&run_ctx);
 		ret = bpf_prog_run(prog, ctx);
 		bpf_reset_run_ctx(old_run_ctx);
-		migrate_enable();
-		rcu_read_unlock();
+		rcu_read_unlock_migrate();
 	}
 
 	/* bpf program can only return 0 or 1:
-- 
2.50.1


