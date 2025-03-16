Return-Path: <bpf+bounces-54130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93224A6339C
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC707A9335
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D30F1991BF;
	Sun, 16 Mar 2025 04:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgBOUI2s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1058194A66;
	Sun, 16 Mar 2025 04:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097966; cv=none; b=CXQLVtGLUe+W8o1JnrK8pjP5EskwMMQG4BsVJabldJFtBYgKFqqcdS9CwfmJ3KnxoVZyqUmNbjt/vquuoNe3DtESdgUd/COi9d2YOlVj7G9tOC5bPcPo0oHsK+mlHt0pmQCB42l2mFwpLr9e4QMr2xhWK+fCJp1pWu+oYR9/ta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097966; c=relaxed/simple;
	bh=mHarWyQwszN5GN3f/z3j87BhPIW1TR13hflSsKwjB3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXR7GpQ2unuq5ub3JI4WpXV8r/e6pQVRA8yXSOFT2b53BAHf7Z/2G8E+k9WBoqdoEcPijpy7P0DsJ+jGnKRs8CgbCYlsJureqqhUcpDHgeRRU4x3I8NpJjGIgrEl+ewRaDmAZSkhtNgrxxpBSO4c1hN5pc8RVhE7xmfZLTl6nQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgBOUI2s; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso2176578f8f.2;
        Sat, 15 Mar 2025 21:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097963; x=1742702763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUCAEDGBHb6/0D9rNwLR8XLz0vdrsmnhtv+wLj43xrw=;
        b=IgBOUI2sm3nzSyqViFa3zqyDPPZKARw4lrj0rLamrGhYlCjBrC2EaWCWz/NylsfasD
         8Xi0F5PDjl9MeOmU/4AGNLqzG1kHnLXiNutnWbOboOHuJsuclBHKlwSFhfV4wxSGxwsa
         2bmlkZ6eWOxEA62gZq3MzmyTtVB6yHOIljxOsG/ZNphloHlowmuVUfGgl2D0/f4bhHBb
         SxEiTF292fqb4pJ2jLFpTqEOBWRaYvsDGfhq2rLm1iE5TSzAcbp5b1lzuEDpG+angLYq
         6EzsMtlgUWvjd7H6a3elx3TC+n9EoWa+ksHTTZhR3k2bnrSRVVJjpTaD9nfCsZtU6EHg
         ngQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097963; x=1742702763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUCAEDGBHb6/0D9rNwLR8XLz0vdrsmnhtv+wLj43xrw=;
        b=WgnH5aJ1H68kfTcmkXm9epA7JcNnMR49QH2ENidpvB6+l8VabcHOe8tt518Iv5IkX0
         y26I0/1dvhsQ1321p9tavQx1yx+I4CDF/4WZcCFexafRI44/25dbmDIfOxBlceNzfYWb
         SWEkXL9dFifjWSwomHpIcJreW74rJWUWKiz6jvAi04EhVbRNuOrUz22i8NvBACRCJu2p
         opbyHPZAH4EDSBQGWg8xV4M4Xk+8DmZVP8DENuZeS2TnWhUvss6SZjKt/fF6A4ktHWYh
         M42ehX9NaAKmNFm3E1rX+sCa62iG3ZT1/dgXU4qfPxFJWE0Llzz0H0kpSOZBDKPo6fNr
         WaQw==
X-Forwarded-Encrypted: i=1; AJvYcCW3Q4Vuej743ponsWg7LNqHiYHvGfMI596oO73Q9Vq479d0PeVjZQWzbK1ZMTw6qYWGcJSmbfvGoVxmWH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGhL3s1Cwoe7L4NIR4gNzJQ+qQVay+OTTy052Yl0e8CKguCYD
	B3Or7jBz+kvuPD5aPaPBTwLRsO1D4/lmsJQpHOeKPcLUwqhI1viv0nTK0dLKPjs=
X-Gm-Gg: ASbGncsd0GSIbDJYu3b6fKxT/mYauQbw7pYUqMEPYLiSzJ1UVM+OplBB8LKPBM7F33b
	xtEdj1hphSXaB1awXDy0mxD5X3Bi8u31rZxlPX2ZRrbJcZa8WuJpsOPPemd9l4U3m5mi+Xii/ii
	LZd+pkdCS2apB323nXTN29daKJQw6muqWCTptV8J3pyN8vkhcsXW/iwyCXIgm3ZjBGZCMfe4Y8e
	Iw+lOMUnlM5KvIBySZ4p/3Fiteh9vYAJvR/9apLkN4boFSg/Oqzr2fflzVsQR8UvBqyiSWwMoTu
	4VFK0L9cacOJPSWvQQpZaAhbsnU/6ZjTPgk=
X-Google-Smtp-Source: AGHT+IH1QUcBVLxG3+dHXNVouxh8ZnGD/jGRFx3laH54pFhC0UFA/apB3TrLa3WvvXdMcVjhfYlapw==
X-Received: by 2002:a05:6000:1789:b0:391:29f:4f87 with SMTP id ffacd0b85a97d-3971fadef12mr8962187f8f.49.1742097962702;
        Sat, 15 Mar 2025 21:06:02 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:74::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df344dsm11217081f8f.10.2025.03.15.21.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:06:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 15/25] rqspinlock: Add helper to print a splat on timeout or deadlock
Date: Sat, 15 Mar 2025 21:05:31 -0700
Message-ID: <20250316040541.108729-16-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105; h=from:subject; bh=mHarWyQwszN5GN3f/z3j87BhPIW1TR13hflSsKwjB3k=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3dhiQsKeYiA7FvlWbRSOujsyykBVeLrqG6gNLF YBDPA3+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3QAKCRBM4MiGSL8Rynm4EA C7H/n0q49/3AIp2C9KPljoZUU6s3o4IV5coN6RHcn0nxNkwVlUMUqOmO9viCbAZR7x0xMkUUmESdVT d6RNwHM/sq7WZtekq1OVAesNrzsND00uiegqn4MdL6uYpmvesuXJil3K3FhyYPLgN1JEHEqn3q3PBv xEs6tpCRF2FogvO8Tfpo6OUlBQnqsAMOrv/J8wqR1Gx7BEvoiegfsOIGmpZAokPBs4GJs6KAPSQClK HxiqImv6qIUN2ImtcFSFuFx06FDW/ZuZn9aAOOuM6yq2wUZRxJdk8jnj4FSWZ07IPxAyPRIP2+TY/n 0PxAmhbVU6mwE2FD91sqm9V8TimYDCc4sNi992SQfyyqJjkx/kGNPQtDvAdPwpyBgxyyzjdR95KB+e BFMmApqGZMvfh6jlwMum3F21CCRWHLRpNkz5ljBnZMAjdTg89tJD5sv4Ou6blclSsNG2BCuW8lf3lA 7ZB2YghW4IzPDw26l5e8nshAHdm5PjP4WKtdJIn0qnNsB5Ola4jYzwK17AyivSL0eKjEJJ/w+R6zJ5 KgZ0wYVgXs+bAMtfs3VFbCbhWwu/+hDk1SvRy5bdwaGvHJO+1LyPBdOPEIJFkP1mI+vfxEE/9UTaJs 7wEdv4wf2t1oJZEUzmrqwj+FYMxpA5vyu9CskwLFQ1+b395NhYuHMPNuVNCA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Whenever a timeout and a deadlock occurs, we would want to print a
message to the dmesg console, including the CPU where the event
occurred, the list of locks in the held locks table, and the stack trace
of the caller, which allows determining where exactly in the slow path
the waiter timed out or detected a deadlock.

Splats are limited to atmost one per-CPU during machine uptime, and a
lock is acquired to ensure that no interleaving occurs when a concurrent
set of CPUs conflict and enter a deadlock situation and start printing
data.

Later patches will use this to inspect return value of rqspinlock API
and then report a violation if necessary.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/rqspinlock.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index ed21ee010063..ad0fc35c647e 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -196,6 +196,35 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask,
 	return 0;
 }
 
+static DEFINE_PER_CPU(int, report_nest_cnt);
+static DEFINE_PER_CPU(bool, report_flag);
+static arch_spinlock_t report_lock;
+
+static void rqspinlock_report_violation(const char *s, void *lock)
+{
+	struct rqspinlock_held *rqh = this_cpu_ptr(&rqspinlock_held_locks);
+
+	if (this_cpu_inc_return(report_nest_cnt) != 1) {
+		this_cpu_dec(report_nest_cnt);
+		return;
+	}
+	if (this_cpu_read(report_flag))
+		goto end;
+	this_cpu_write(report_flag, true);
+	arch_spin_lock(&report_lock);
+
+	pr_err("CPU %d: %s", smp_processor_id(), s);
+	pr_info("Held locks: %d\n", rqh->cnt + 1);
+	pr_info("Held lock[%2d] = 0x%px\n", 0, lock);
+	for (int i = 0; i < min(RES_NR_HELD, rqh->cnt); i++)
+		pr_info("Held lock[%2d] = 0x%px\n", i + 1, rqh->locks[i]);
+	dump_stack();
+
+	arch_spin_unlock(&report_lock);
+end:
+	this_cpu_dec(report_nest_cnt);
+}
+
 static noinline int check_deadlock(rqspinlock_t *lock, u32 mask,
 				   struct rqspinlock_timeout *ts)
 {
-- 
2.47.1


