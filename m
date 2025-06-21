Return-Path: <bpf+bounces-61229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6240AE2770
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 06:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2E117F00A
	for <lists+bpf@lfdr.de>; Sat, 21 Jun 2025 04:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B795B18DB26;
	Sat, 21 Jun 2025 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3/5QXrK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A25258;
	Sat, 21 Jun 2025 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750481829; cv=none; b=TUdM+oRVeOPOc8SFSINA+asEs2VwrDeVLGkPwEsTc5A0G7z2wYUcdlNlKm7wyOwHBMatmRUsjBejA11ExQgMtoZtEhWAWX57HRHfjGEavk4jJR++L0Ax0Gkh6X5uNG7CpFgyNyv/Nk68gq9pgzXpdX1/fQDghaj/XIRJ00GaDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750481829; c=relaxed/simple;
	bh=SZMVQplISMRTt/KEL+/WHBkKFvZGfIuPgMGfMq6ma8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h3MAExkkeP4z+fzo1NMMuISwob5X/VnxWBzHDOXo2+quh9o4b1Q1YM27YZUUuVwBqkEtMQCd7TRAU3ymvEKwxJT/7UOLcC4bTtqAeEZtbq4Dqu8oJjk/tUImhcPfYJCKDeQV6h+t5jVP92Kd7u1peVR9mh083lrmlw8JZOeNhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3/5QXrK; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-af51596da56so2089656a12.0;
        Fri, 20 Jun 2025 21:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750481825; x=1751086625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Gk9KzOnDrveEvUaMvbrRa1a7xuC2txgmZLY22etVjU=;
        b=C3/5QXrKu9RZYgpk7k1dfdPE6sFIF63t03NBWlwMVyHCWFj2c9SXsTf8mdGdRvMlMl
         xhAIX0OgO9DCaywANuyUEkuKKdxJMAWLCrGW6a5B7aAxNwpkw84q4DBGkVPEwReJ3rve
         JCcAqqgJ9tezz3GJC/0pGlDnEUS/7H+GJA/NZUSyGcsnOhXbi4qPMyQtul2SREm2tdfb
         NxBPYa6dR/ff/uWHLiZMSuY80cEXSZE/EN526xBZPjq2O19hQuZ/njwFiAfJ/SLK/XYh
         Ti75XrF6Uf1mtQEjKgdDQnIdKYBwYkayb6WYiBpPLoGnkhxAtCuiMzp3pb9aDmNiq41K
         2hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750481825; x=1751086625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Gk9KzOnDrveEvUaMvbrRa1a7xuC2txgmZLY22etVjU=;
        b=RbmoSjToRcrV3vD5vzDAjZIPmFVbpFs5BR2Ep5ppuB5EyWQLJp+MCGBn5pFIjlnc91
         tWyYNc1cOSu/uFFp0IGFx9mM4ggt7POBSVbhkZqavaWbU7RdoacX32GSeE/DDvCgS9tp
         3uCvZePQ62GhH9L2PIY/YZDHjh5IPkQpoGQbHi5cRSBoV/aRbhfYu2qxZYue8pOrbJ9H
         sUAZhz9CWyQu7Vz0jygFJsOWZpeGPR+90aosbi2l581iN1s93B93YlEQxCpp3i0wnScs
         MjVARH4uISBZzvkiVun/mVuqS78X/WbCQ/yo2t1keroxB+kAclvA331lFfg8YjSJBgiV
         Zkfg==
X-Forwarded-Encrypted: i=1; AJvYcCUwFSswbrkG+FsFL6Xdyn9tbR2j10f6QWCMoW+aze+C3a22Km2pxoW5l36abZoKLWjEXdLxIFIv8DX9CZrq@vger.kernel.org, AJvYcCVpnShyDFz3t69kjaE27XZP0wYL5lmYvuJuszQY2Y6QxtRHtRLEHWgJcRpezLHOnfQSJbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmBAvpZefs5SChI9unjzsbZ1NJonNxeKn9Ogr6O6q+ImoLfaSY
	dt98/LCUMJymQbPWUuXo7uaRut23LYnLw2pVS7efZQDrTfGjYBqeYm1c
X-Gm-Gg: ASbGncuexoLoulZZU0La1tjPkVHOkpq9JDhVqkKzTrfTY9GsHxagHc7osZPCn76aafp
	YW09J3G6jVCNGw3ga9OFwaMJa5K6qEqz9x9BAaXsD0pTU10y+7OCx4gobQ+k3w+LKPBwgknZ64N
	g5oGV+c42Jto5v8Y5kSH1Hh3wqe4wp7Fq8IjERJmFIKtbYkkWf/AOeXSz9zMSlxw39jtb6Tw4J0
	cCv1zHtwmKONU2MQZTExMyqBdy5DcYHPXXaAyapWN9EbozZzh7Z46YD/BSDk1p9cdebDBTavY+E
	iX+07M4utiv2m/qimwGNyI6MTn9eaNi6o9uHYfqqwz+Q7t7OG4PPmQyBN9oDwoJKGjbbYhQArH4
	D090=
X-Google-Smtp-Source: AGHT+IHFsyBci8OAgKje9b5uzYUXjzK7zIS6C+PIkxYu+QCnmHONTiB7jHCMRL82Q/cufbSMYuCUEw==
X-Received: by 2002:a05:6a20:ce43:b0:21e:f2c4:7743 with SMTP id adf61e73a8af0-22026d5f209mr9090570637.7.1750481824780;
        Fri, 20 Jun 2025 21:57:04 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1242bfasm2433134a12.46.2025.06.20.21.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 21:57:04 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH bpf-next v2] bpf: make update_prog_stats always_inline
Date: Sat, 21 Jun 2025 12:55:01 +0800
Message-Id: <20250621045501.101187-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function update_prog_stats() will be called in the bpf trampoline.
In most cases, it will be optimized by the compiler by making it inline.
However, we can't rely on the compiler all the time, and just make it
__always_inline to reduce the possible overhead.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- split out __update_prog_stats() and make update_prog_stats()
  __always_inline, as Alexei's advice
---
 kernel/bpf/trampoline.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index c4b1a98ff726..1f92246117eb 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -911,18 +911,16 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tram
 	return bpf_prog_start_time();
 }
 
-static void notrace update_prog_stats(struct bpf_prog *prog,
-				      u64 start)
+static void notrace __update_prog_stats(struct bpf_prog *prog, u64 start)
 {
 	struct bpf_prog_stats *stats;
 
-	if (static_branch_unlikely(&bpf_stats_enabled_key) &&
-	    /* static_key could be enabled in __bpf_prog_enter*
-	     * and disabled in __bpf_prog_exit*.
-	     * And vice versa.
-	     * Hence check that 'start' is valid.
-	     */
-	    start > NO_START_TIME) {
+	/* static_key could be enabled in __bpf_prog_enter*
+	 * and disabled in __bpf_prog_exit*.
+	 * And vice versa.
+	 * Hence check that 'start' is valid.
+	 */
+	if (start > NO_START_TIME) {
 		u64 duration = sched_clock() - start;
 		unsigned long flags;
 
@@ -934,6 +932,13 @@ static void notrace update_prog_stats(struct bpf_prog *prog,
 	}
 }
 
+static __always_inline void notrace update_prog_stats(struct bpf_prog *prog,
+						      u64 start)
+{
+	if (static_branch_unlikely(&bpf_stats_enabled_key))
+		__update_prog_stats(prog, start);
+}
+
 static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 start,
 					  struct bpf_tramp_run_ctx *run_ctx)
 	__releases(RCU)
-- 
2.39.5


