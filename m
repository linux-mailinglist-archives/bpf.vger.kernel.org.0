Return-Path: <bpf+bounces-65721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF792B2790E
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F99518930E5
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5229721FF58;
	Fri, 15 Aug 2025 06:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM74U2gp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678BF2C0F6E;
	Fri, 15 Aug 2025 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238744; cv=none; b=EP23stiJ12FPq57tCpzUS7sYwgeDmNy+figCbYtf9HVdbUEHQpLyVWfnE1qGEH5H3JO4AlHF5P1YnTAbLHH9E9EphhoaC3VrFet/Zr6xuK+vRc6pxMhB7dezDiDsqRH2Pyb70lsFlHrp96R57VDzFv3nUPpt/lUQ095cr6MJE90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238744; c=relaxed/simple;
	bh=SUj70jwKD1YJWvHj/lmbBVeF62EZ5vaRAX/pOH2XWOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLUu5vvIIHFN9zHe6ghkh9x5DvCIdqR7am9Js5dgT52v8+k9FMNcdZ6gS0tJStCzlrG40BFAryBptCwKzwHaQbJMisuM4+Xk3nk6x8V3w+6uOqwvjO19jHD1QP9PvTDpRdFllfMLjFFgXGIJAcur5I+4cgKgXylKgWQdrTGvDb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fM74U2gp; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1665596b3a.1;
        Thu, 14 Aug 2025 23:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238743; x=1755843543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biaR6krtJBdyRWUCr4TpqQjC9azJSYTfDqHuCAG64dE=;
        b=fM74U2gpJzENqaOmMaZVy6cUgV1F0qkf2mkhOr+Nr4pU1kClgy+tPwBzd+7Y30bZEt
         5tl6oRadqzbQTnmDVXOljV5hEvjdaDXkzMntGmG0XlCjaAmAum8Xcygt29kssKgIXydF
         OL+08ijuH6nKKNhK6WlnVaounbbe9sj1aiRWptbKkzipijih1AyY9AdqWHrKzsdDgcvq
         v0ra1DYXlrHxXae1D4WTtQC1iFXw9EJkXlA6IUUYhzhw8QhuQhb5MKWfb8q2JOy5QoiX
         7uQhcW0sZF9sDT7Rdv7kwq+LwKXVakVcqPCJfuNwCP118HNUhHG+KTdhcxzVuUnDhzeE
         uCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238743; x=1755843543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biaR6krtJBdyRWUCr4TpqQjC9azJSYTfDqHuCAG64dE=;
        b=mULXJS9xga6e1zR+3c2pOjdBZFumT0N+3bL3i39100La+a2kbXGwhmZlmvUh8dZf6W
         nDCYDBV/4L0b/bhuGshzhcwY+OgSeCP/5UqagZlxyEMTuzb3+0cLk6zsTws0bDQJVS1V
         W9rheIg0Necodh4AcJm25ASubYjwYkFbnHS6GCC0Ad7O6byR619Z9AOb/0zv3T7R3brm
         nemkX0dbkSJW++jr4v63V0WZOk/LbFn0033bPCqyrpa80d5030Q/AoJSK5dy2it3Yxfn
         AJw1vV/XWqtU7qUdhsKcofAIqAFJ7BGE6BYKm5md3lTo3qGaXKtS/4uWHcvVlChQp/bX
         hx5w==
X-Forwarded-Encrypted: i=1; AJvYcCVU+4TJRqhUKnafjq0gOuWnu9X8hA8q++OsuvgKi+Z0EOV/xaGmVqCCqFBfiNVtKJMdrmU=@vger.kernel.org, AJvYcCWEI2vcwS7v2Crswr8PERr8rLsoApVRbSl5GNik07o/LlVnEuOJ4Us4XDR86x87qu8HoSCpVd6CajMTs0lW@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvD0TC/MeJfEHKTpcidsgC+13xAaqO+3Q05UE8vow7WJB2nO8
	4FXFQNyPFkBRvZRlVC1fZPPYU53i/xrndSVo92k1XmzFawpk+IABnisN
X-Gm-Gg: ASbGncvjBqbixjkqYyTfSMZOU6r2AvqPVmgiAgDMjtDljlhUigcuLJBMoxW/oErTx9C
	VUlKCvruX6sfnQxeefSVeTI2PaNsMPgQ+KWNV67Sl8dCijzV5iHsquHekCaz8obQa9cKXUQ0Njs
	66ILVN/4jrMvwSktZWDZnBXYfnJlwHLUibU3aaxXA96itdn+ZFExnKuEX/z6VwvzChA8oKkVZZM
	3gpRwqJQCzrbiSVSK0fmV+EDennO84k561SrftwOZ8f0jQQRlT0+/xVVktBIVNtINaloWj0avGr
	wvlg3lw8Yy/5Avot1SoBsVtA/OcbfLDhU8hBUejAorCTpXQdQz0Pm4BbqQDF5FAAMR6HFzpOAdn
	5V0YedddKc6wcKttvmg4Iabpa1XW33A==
X-Google-Smtp-Source: AGHT+IE27qqZar5VEXjDF36q37jqNIiBeBtrvOFfZ4MxCuj+OiymsPKpASTZhLqXm/licsP3jYZJjQ==
X-Received: by 2002:a05:6a20:3ca6:b0:220:898b:2ca1 with SMTP id adf61e73a8af0-240d29c7302mr1798883637.21.1755238742779;
        Thu, 14 Aug 2025 23:19:02 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4558ae7bsm408607b3a.95.2025.08.14.23.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:19:02 -0700 (PDT)
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
Subject: [PATCH bpf-next 7/7] bpf: use rcu_migrate_* for trampoline.c
Date: Fri, 15 Aug 2025 14:18:24 +0800
Message-ID: <20250815061824.765906-8-dongml2@chinatelecom.cn>
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
rcu_migrate_disable/rcu_migrate_enable in trampoline.c to obtain better
performance when PREEMPT_RCU is not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/trampoline.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 0e364614c3a2..a0608152c394 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -900,7 +900,7 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tram
 	__acquires(RCU)
 {
 	rcu_read_lock();
-	migrate_disable();
+	rcu_migrate_disable();
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
@@ -949,7 +949,7 @@ static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 
 	update_prog_stats(prog, start);
 	this_cpu_dec(*(prog->active));
-	migrate_enable();
+	rcu_migrate_enable();
 	rcu_read_unlock();
 }
 
@@ -961,7 +961,7 @@ static u64 notrace __bpf_prog_enter_lsm_cgroup(struct bpf_prog *prog,
 	 * programs, not the shims.
 	 */
 	rcu_read_lock();
-	migrate_disable();
+	rcu_migrate_disable();
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
@@ -974,7 +974,7 @@ static void notrace __bpf_prog_exit_lsm_cgroup(struct bpf_prog *prog, u64 start,
 {
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
-	migrate_enable();
+	rcu_migrate_enable();
 	rcu_read_unlock();
 }
 
@@ -1034,7 +1034,7 @@ static u64 notrace __bpf_prog_enter(struct bpf_prog *prog,
 	__acquires(RCU)
 {
 	rcu_read_lock();
-	migrate_disable();
+	rcu_migrate_disable();
 
 	run_ctx->saved_run_ctx = bpf_set_run_ctx(&run_ctx->run_ctx);
 
@@ -1048,7 +1048,7 @@ static void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start,
 	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
 
 	update_prog_stats(prog, start);
-	migrate_enable();
+	rcu_migrate_enable();
 	rcu_read_unlock();
 }
 
-- 
2.50.1


