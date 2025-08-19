Return-Path: <bpf+bounces-65985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC09CB2BD88
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C497AAEBE
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63481320CB8;
	Tue, 19 Aug 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9vBKoTf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94A317718;
	Tue, 19 Aug 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596121; cv=none; b=M9RjjsEvcZiLNBwmzbwqD6SeDo/wi15q5aZvn4XDvRpBqtZTrgynrnju6Tw99HHzskrVQt25XnbDzR2gvz9zR0qlYHoAdHSBWYCt1pP+/iIEHg8TgZ4tVZ0acdD1gg0QU449uWl9JhuGHUJr6RTWxYuMUiq44N74fL9ltRUOsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596121; c=relaxed/simple;
	bh=6Lh4b5LMBBzYETFNUKgsMw+Mg8slBT6PgN9WlZyKi/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGhpqJBUh7uUrc3Y0CNzbWCMyhKFTGbOibCw+ngcM8IUvkRyfwiBmSe6WdGGEoIrbOa6TrxOotEh5CKFuvdInvj5ckTk6oDzFxoItT70jH1fA1+Z5Pj32B/X054gLzhO51E9yJHBH3SmnDAE85Y8SwDzjnmdjbMkYtPKzu8ibPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9vBKoTf; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e39ec6e05so3200455b3a.2;
        Tue, 19 Aug 2025 02:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596120; x=1756200920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA6vzGkbuWAEnBwZb/6LL/xPx2BmZVoZP3qls2M6vww=;
        b=g9vBKoTfHBG+JtoN2O9z6FEuX4tLbyr/H4MhGzfUtW7vTI+y7wIRklJMzHDSrefN4y
         V1TwK+Dv/dwXVqNYpn1Ds6PdX0pEzMlQLvfDfBiTtDAo0GybTCbUq/Utb08xMrmDHdC6
         zIxzH37USPWVD0LohFNz08rT0bTk0b0hriktlCddZrLeU0gDgff9ccDf/4wm1uEuszLO
         g+uKVykUmekDCtbEdIWetc6Ciq46teXJei4WrGwfvIC0JCdV2eM4valrV9lZpstR6koW
         qmVo2bmERYkhyiRyQ2r+SJeweAKtY0Jk4JhrU3uJNDe+GvAy7Vj5NopqngxFojt97pDC
         7jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596120; x=1756200920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA6vzGkbuWAEnBwZb/6LL/xPx2BmZVoZP3qls2M6vww=;
        b=FbCxCubkl3+8dd4fzPo0/h919LF+h2fHHxfVbYxhDGMDletKvPfEFwrRrHA4AJkmjK
         nOYLaIo3Hwtfy4cnKySMqMdt334gXsdzNwoyzJ+PxKYvkMnie472j60B85FAtMiFfI2P
         WM/ti6qOwe/arvsDuvkVX+k9mQy4CbfqXOSdvnXs0KRAbfmi0RI/bHxL2BNLm5ARev9T
         6TC6Gu/x570/GH8QYnQZt3EI0aCVKPOYrMThtb/CxDnBmAA/3J4/pgp/jvcpCHfmzZSq
         i08J/Q16UYICiuPqSFCvphTRdRRSzSLZqH6+ou8k7W8MkxaU/1EcKNGW3iMd7RP51ho3
         Nh2w==
X-Forwarded-Encrypted: i=1; AJvYcCU72TMCiM4wna0UWFZCTgOWcdHW8QWdtyQtMzglmSmgABma7J5aSH1s6trr7KkvQP0yFps0@vger.kernel.org, AJvYcCUgxE49tPkchbIpylyFgIvEr3pyOFJ/Tp65+kldq9CFyL2q/sBl+WuV+fHiW6hhG740Zh+n7e7O83qyExC+@vger.kernel.org, AJvYcCXxyDHj/H1/KFeD3X7LTsHFXk8gd1jZ8AB7aPL0JhLZJFEPAGNtrDLa/7FZGzSCNG/4PNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUq1UxJ5orHoqZKpbiaPTVfkOBzUkNvVvApOoX07G3dtVAZz2Q
	wgEHx8iM/zEhIkgM4CF09GgzddnULe0AXvGGiQcBgVXbti3FOkCwTReb
X-Gm-Gg: ASbGnctj+px5LeH9y5hFFtnIc8NGPvexhn2qHXQYaF+hi4I35wzQYZeoc1VZN9BBAoT
	KOgHabS+b/JnSJC4tMGb7sNR/DCHH7jYqV4q+aRxtHf2K6mFkeUq4Ka3YpGSXuHv5m5IC272Vuj
	SFYZqpQK4pukEzJxk9eDCHgMfVU9DOcBSYzLGtN9mqx8eSHGXLyfRJOtG1sBwcZn1i2S05Ei5IG
	KD2hIe94YwwKNi6lbvoVrYal2kd6AIArr0AhQe26xKNTlyGvDbABfA7S5/EAd2UiNF9s/QS0+aE
	0xjLF6E4fcnxoqmdjOEr5UVRDzXa4UMzTacxcGtUWM1mTJgddFNbpex+R8Z7mTa0reKPd4rNL3C
	Ljk8fCfgLIrmERKtmVEI=
X-Google-Smtp-Source: AGHT+IHyvkNhcELUFuNuzdPlQf7oSQL8a7T9dDNgx5dj4V4tyR5eYQmpfnvhrcwDfRqeq+KLqRJInw==
X-Received: by 2002:a05:6a00:4fc2:b0:76b:d93a:6a02 with SMTP id d2e1a72fcca58-76e80da230bmr2035364b3a.0.1755596119672;
        Tue, 19 Aug 2025 02:35:19 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1314a4sm1990945b3a.41.2025.08.19.02.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:35:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 7/7] bpf: use rcu_read_lock_dont_migrate() for trampoline.c
Date: Tue, 19 Aug 2025 17:34:24 +0800
Message-ID: <20250819093424.1011645-8-dongml2@chinatelecom.cn>
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


