Return-Path: <bpf+bounces-66166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054ADB2F366
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93AD725C17
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AA42F49F5;
	Thu, 21 Aug 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao1n+ecf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0572D3A6A;
	Thu, 21 Aug 2025 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767228; cv=none; b=f22Uy2s8e6LRcRnd4xfUKAELwWSEWVKDT6x0/oJbV1sE/FwchapFTLsLnRsMF5qmewaDMbZMerHjLgX4U8pRLP8eOkeUXuyO+qrs3/bUlAREPSQ1oPPBzTqXASL2o+DeOOQk2WeDpdf/m0IxCksiCsWFXBJ6QCeTsZHRfqUKrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767228; c=relaxed/simple;
	bh=6Lh4b5LMBBzYETFNUKgsMw+Mg8slBT6PgN9WlZyKi/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQ3OlDwRM0txVK9HnyN0N8pfzQfWCxaxriKaIl39MvMw/P4UmDziwqxMAV3RKsMi6SfZDt6+1It/KrA1yNou0ST5MnJ7XiBqWw63sWTKFtStuIcgjGfi77q9fcT+40dToHEku0epKoSC5kxxkHNCJd1q4eU+lt/+8qD9y8ZMwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao1n+ecf; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso729468b3a.1;
        Thu, 21 Aug 2025 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755767226; x=1756372026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA6vzGkbuWAEnBwZb/6LL/xPx2BmZVoZP3qls2M6vww=;
        b=Ao1n+ecfl6Q43XMXVjN2memkN7Ay8VLhMyhZTFIxkqu1Sm2suh84xXLQtFCi2Vr8zr
         HT/Yd4XG6d4m5YwPZDdYggk5YMNPIpaSPID1/Nnoko098FdZjqevmgthdcuDoV14hqDe
         Jnxj32Qyg/nwcFdTzyEnnZXodufdm7/9N7EWpf4SvBic4+pY5FULUXzOEw4C/4eVsos7
         AwYOT5QSVtR+xZT+2TDFlcT3tFyJk/cYY6KzAvm4sHQ0QxSfZErgdl2FviRObjwUFhsw
         neLyJabsR9g0chB+yAKl+w2bFPmipQcgs2a8eDWZruPIqF0EuuczEkC1RcIPJKz78LjM
         8C2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767226; x=1756372026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA6vzGkbuWAEnBwZb/6LL/xPx2BmZVoZP3qls2M6vww=;
        b=YV3lyBvM8y6OxXLro501VdU8zGXDasO2rxYSJ1WHZe88jrJTcsEXk/Z8hlLerKzK7d
         eQaJSWshQSpzFVjfJTz5GaLv8vIdTqsfltbx+zfSwRZf22hmIbVLOjr2rAF8QE9Vhumh
         cB6pgaTIpoZhkfwKlBGv/T2dZK9qVro/lcUagLCqf8usX1ZGd3lNHV5kMsae7YBAWsKf
         4VYTc6mlIeLMXCTAl+ElsXnI3pkGrN8JKKsLv6h2/g/IaFcMrbyHhaQOLy+kpanlMowX
         RarpPuMp+TpGIdCdin+5SmHQ3Sr5S47fU3r9YuoaLIg274l/Urx79HxeCVixCUF2ixtw
         Mjug==
X-Forwarded-Encrypted: i=1; AJvYcCUYt4qww6PttfpzUV+SLtHqtLjXuxLnCyuIrCUt3HiB6lyOFS/KwVYuUr6GSh3+W5PRlIAxJjC5yFW3jRkc@vger.kernel.org, AJvYcCVrv4vD8oO6IHt/KpDSEFLo0eIbXTbdaDFDgauOkhJpn3GkxxpDUKAHZNWI6GNp9F1duEJy@vger.kernel.org, AJvYcCWjtACkGMJW1xXQSFoWWr7XstjfP0DcQMpST0k/E//5oj/hoSdHJfQHdNj7rJBiyE9Fbx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuG/fo4nY0nXKYjlyNAxHXodcHJddhTYBpTcCOHaBKI8MnpSq7
	Cl0RxoP5+sofzdKiEV31b0R7h6D5zCxWAab8pMRo53AwDpuk9B5gWhCj
X-Gm-Gg: ASbGncuvSx11eqtFIzzq8ij2cbn17cpNlFygZ42so8QHWtEf7egdLAD20mikjKroZ7/
	1A4NMRs5h1wMsrKvK4picAzjW/aHa5IG105U0yByjY30G5xMN9m33kiRyD37R8uS1ZCEI1kSW2l
	TodcAhK/aDMCA0yVXLp1nAWc2y2yXRG/bGY3T6hqObsmj2eDSl0633zmK0N6MoTo2oFNvjIwrF5
	sYKiQ2BohAUWxOh2ynrp3CdQWov062l4iBwH9o5PGheKgBiXbDjts0AWZGpNHZIHo1houGRoQ5c
	+oBIVqm/RHq1PmAGffGp29DBUA/L9YQmvySsilu/DMU39nKNivbmHOgbXPntkBm1Uz2U+b9C0RG
	IbooPvRXEeSjdd361LgeKazA=
X-Google-Smtp-Source: AGHT+IFAxs155WkEAovxKXV2Qp7o7Ce69E4eJSaP9vrtG7bqjEQH//jftMOatslb46rp0Rv4pxscWQ==
X-Received: by 2002:a05:6a00:190a:b0:76b:f73a:4457 with SMTP id d2e1a72fcca58-76ea314f59fmr2162223b3a.6.1755767226418;
        Thu, 21 Aug 2025 02:07:06 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76ea0c16351sm1708937b3a.14.2025.08.21.02.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:07:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 7/7] bpf: use rcu_read_lock_dont_migrate() for trampoline.c
Date: Thu, 21 Aug 2025 17:06:09 +0800
Message-ID: <20250821090609.42508-8-dongml2@chinatelecom.cn>
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
trampoline.c to obtain better performance when PREEMPT_RCU is not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- use rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
---
 kernel/bpf/trampoline.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 0e364614c3a2..5949095e51c3 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -899,8 +899,7 @@ static __always_inline u64 notrace bpf_prog_start_time(void)
 static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
-	rcu_read_lock();
-	migrate_disable();
+	rcu_read_lock_dont_migrate();
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
@@ -949,8 +948,7 @@ static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 
 	update_prog_stats(prog, start);
 	this_cpu_dec(*(prog->active));
-	migrate_enable();
-	rcu_read_unlock();
+	rcu_read_unlock_migrate();
 }
 
 static u64 notrace __bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog,
@@ -960,8 +958,7 @@ static u64 notrace __bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog,
 	/* Runtime stats are exported via actual BPF_LSM_CGROUP
 	 * programs, not the shims.
 	 */
-	rcu_read_lock();
-	migrate_disable();
+	rcu_read_lock_dont_migrate();
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
@@ -974,8 +971,7 @@ static void notrace __bpf_prog_exit_lsm_cgroup(struct bpf_prog *prog, u64 start,
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
-	migrate_enable();
-	rcu_read_unlock();
+	rcu_read_unlock_migrate();
 }
 
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
@@ -1033,8 +1029,7 @@ static u64 notrace __bpf_prog_enter(struct bpf_prog *prog,
 				    struct bpf_tramp_run_ctx *run_ctx)
 	__acquires(RCU)
 {
-	rcu_read_lock();
-	migrate_disable();
+	rcu_read_lock_dont_migrate();
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
@@ -1048,8 +1043,7 @@ static void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start,
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
-	migrate_enable();
-	rcu_read_unlock();
+	rcu_read_unlock_migrate();
 }
 
 void notrace __bpf_tramp_enter(struct bpf_tramp_image *tr)
-- 
2.50.1


