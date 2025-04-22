Return-Path: <bpf+bounces-56412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C532FA96D60
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 15:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E5F1883874
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0483283CAD;
	Tue, 22 Apr 2025 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVoz7Avm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37714C85;
	Tue, 22 Apr 2025 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329669; cv=none; b=WpxPQpOqMXQ/6dAx4ZHNgOqId2wTuyn5mqHIT4Dpxc+qN5KnhcnenQbOqWBpIEKHxdFrc2DDst0vm9qBZaNQJXAX/Zgmwurv6SnQ/bcjTdLOW64vj2FGV/DcMc2D1th6xDcrU3/raVWZEGdI9btUoq5++krPib3EaCp1+FmXacM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329669; c=relaxed/simple;
	bh=rihYLSUzxeuZAJ3jukl1xScoPoA5Pkb6Z1BYdQxPJX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDuq4fNcNh4mSIBUkkK6jhMMV/D0rZ1Lv0JlfzdlmIJh2e85VHZQXL78OvwPoIx7ObySTlAww9duoVk2fdFSWSwi/WvMvLlj9b3r6rlL6nTcvGltSSzRJ0E507w8+PPMdi48ko2D0/SYXtlkIL47baA5QpEfPkFBDmowJ52nhO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVoz7Avm; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff67f44fcaso1147850a91.3;
        Tue, 22 Apr 2025 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745329666; x=1745934466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSIs1Ai8/oR/BRxFfkqnndhf7X1ZjCjQIqFS36x91Ck=;
        b=QVoz7AvmyrrK3DAzZLjsGbDuuIoCYqfErTWncLRiYaFk0QzNt12GPhS0QFFwT/n66s
         /kGMTQM/1WXmPd64pZiFyDVLzm5qGf3bnylB/YQ1Pyf8DgE38XLge9j7Hd1wlqoO1+QB
         y9VINpf43ctNUyp+P9N63ASc1e3v/VZb/5ojHR3X59at4UK2P110o1VK7hxhaqwltEyk
         KumRB99BGp7qdEgcRE7cptqqEvlL71BE6ilBlzng1wSkeemznLGijxwnnQddcKPP/ZIu
         B0pZBTg9ycLJE60Lnf1Tjf66Z5HOQpXEUEmlZe1zTCcdb7zWN5RnnIRhLmUM6fTe2ZJE
         I7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329666; x=1745934466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSIs1Ai8/oR/BRxFfkqnndhf7X1ZjCjQIqFS36x91Ck=;
        b=cnJeLUVtDvscEAn7URgwW09V55dSnuJ8+cHRX33kQJcnWNOkGQbOKzck96Q52BZxOi
         gNZtU6bvdtcMmGGYqLNeCF5rMPBngaMHpKSLT+bihDSSflCj4LAaUU2qFWRln4LdfItf
         iOnepBijyGlXR+C83j80zJTnvvHyiSE7t1Z2iKG/07sXeTBEzF600Tmh2VVWtJ5ZXwR0
         ZpJvoylnUXzR1Sx7m3x6CK6kr2Sw0dcugwZr0opaPgHRxnH8nl68V7W0fhGj4C8SNkj6
         mAZgJ5pLe8Nyzocnz2VDehQ6+AGoY4uv6Zk7ErFlSOYONj4m5+0RydI7n+kpYcF97A6N
         01aA==
X-Forwarded-Encrypted: i=1; AJvYcCUsPWpCyC5M/UUYhefh1YYiydRssL5vTZ6vDsnbmZ5Otnso63WqQg3B4a1I4sa8YEecT4c9o8Syr1C8R8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR5e3Fk6Iz+tH1+6gq0n69pT7nzwfFw1qwOnFxFuk5gWfRfDEj
	mhI97/C3w6ETTOMW8opcR4KntdhvGGZHEAHaLWJhTZu4bsbMpTW2Ob1oZbu7kdo=
X-Gm-Gg: ASbGncsu9nLd0G1qDqFE4EAQITJfZKFfkG4X87Yxt4FoqZ1EX92JNGDDxkxglTZD7D1
	eE20SjVT6J5LuyKVn3de9a8PeOPKz+BD7LnoKEEpK9EUYOESQ/aEpzdjArRmAJSaVHRNfjQEwxf
	dg+OaMnFg0eNa109cB291sBXqtBNaab1eRMvFta4lwhe6tI9iJJ9Ec5qHvw+h7dlE4lEwlbjpka
	rXqrb20A0Dx+VktLQaiUDsmUsSkSl+V3MqnTp3nxLcY5wDsTpDWRLcWG+e4LS8MzocxJ03PP+2J
	TuVNIICKywVGO5OdIsFR2r+TbDQiDIT3NR7PihAOX+L5EmkbU6D4lruib0sIB0M=
X-Google-Smtp-Source: AGHT+IEIXnLU/LiQqCvB+iD2Kr7qAeNMDx8ndPjJodX/aRk8gAMlbo/Ec7dFUU+hiw23QjCIpta0cQ==
X-Received: by 2002:a17:90b:3e85:b0:301:1c11:aa7a with SMTP id 98e67ed59e1d1-3087bba8573mr8635622a91.3.1745329665853;
        Tue, 22 Apr 2025 06:47:45 -0700 (PDT)
Received: from MGG23TF6W0.corp.ebay.com ([202.76.247.146])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3087e05b2bbsm8695214a91.42.2025.04.22.06.47.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Apr 2025 06:47:45 -0700 (PDT)
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
Subject: [RFC PATCH  bpf-next 1/2] Enhance BPF execution timing by excluding IRQ time
Date: Tue, 22 Apr 2025 21:47:26 +0800
Message-Id: <73fdbbf9aafd3e24e12bb58f89c70959fb3a37f1.1745250534.git.iecedge@gmail.com>
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

This commit excludes IRQ time from the total execution duration of BPF
programs. When CONFIG_IRQ_TIME_ACCOUNTING is enabled, IRQ time is
accounted for separately, offering a more accurate assessment of CPU
usage for BPF programs.

Signed-off-by: Jianlin Lv <iecedge@gmail.com>
---
 include/linux/filter.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5cf4d35d83e..3e0f975176a6 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -703,12 +703,32 @@ static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 	cant_migrate();
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
 		struct bpf_prog_stats *stats;
-		u64 duration, start = sched_clock();
+		u64 duration, start, start_time, end_time, irq_delta;
 		unsigned long flags;
+		unsigned int cpu;
 
-		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
+		#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+		if (in_task()) {
+			cpu = get_cpu();
+			put_cpu();
+			start_time = irq_time_read(cpu);
+		}
+		#endif
 
+		start = sched_clock();
+		ret = dfunc(ctx, prog->insnsi, prog->bpf_func);
 		duration = sched_clock() - start;
+
+		#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+		if (in_task()) {
+			end_time = irq_time_read(cpu);
+			if (end_time > start_time) {
+				irq_delta = end_time - start_time;
+				duration -= irq_delta;
+			}
+		}
+		#endif
+
 		stats = this_cpu_ptr(prog->stats);
 		flags = u64_stats_update_begin_irqsave(&stats->syncp);
 		u64_stats_inc(&stats->cnt);
-- 
2.34.1


