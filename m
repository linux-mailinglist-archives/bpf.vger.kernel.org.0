Return-Path: <bpf+bounces-70918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD71BDAFB7
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 20:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CEC3B23B6
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE0E2BDC3E;
	Tue, 14 Oct 2025 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpmjEh/E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C8627A10F
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760468233; cv=none; b=ldW0mfiSm3uzNVQ2BQEUUOns8/IpkQjiETgR2fXqUDN+kQHKwFxxIPZjts0ezNiH/8rAWC/l4zeFOek2x7hcM77XEJZ/DbH8sIuB25DU//EXNP/kKHtpK+vZIsIpsgtRPNenMw3ksAVERLkMw3IAssNA6BYUiqFt7dh2i9AdCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760468233; c=relaxed/simple;
	bh=sDXCB1ulMoV5LQ6HT00MveBpWgGiQNmThbSEWHeD4sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKFn8lGj09zozupTEOAZj0nXuqpO6weOYp9mQXaR+ZIgdU3Zgl5aTCBbG5lpcZGW+MmpR7KMzStQ5TJDiHm9KuPMg5Z/8ptCklMKbi2vB/cm3cUIm2TLbiuUl+E+8pNGh4a/IQMZhpXjiv72sPAtW3u7JS29vpXuzt6qlP4Of1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpmjEh/E; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f5d497692so6948790b3a.1
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 11:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760468230; x=1761073030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W5mrZAsDpAhtZR5O1zq3S2ijwHx8kAoyyKQakBDbrcg=;
        b=SpmjEh/EDF3keLH3WmcU4Tmqi6sQ4aEsJj4PkHxg1XA4hTXRb847IvH6EvQYzhyK85
         CD3W4026oh+IVi7qxUrqCwCS2MFjqq78j2aTUMBuMVLs6uPQVPipaMXKCtfMzDb83Ubs
         4UYYcmKsTz+qGbTZuGbBDxxfoHDl0xYLIgnzQy/nbgUNFkBX4cVnNu2JZCdoEVJaeks6
         vAkWl+ycGHl/KKQM+yCtYFx4wGCSyqeEuFRSlWpwVRq/fg9Ea6dpq0FYqvTmbBWMVFqJ
         OVf+SSZoLTxAVuceHEPaBejA3jE5nBmrB/dhZpZtBarWw2NbDLSOEwIS/++iV81uHl6c
         Afvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760468230; x=1761073030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5mrZAsDpAhtZR5O1zq3S2ijwHx8kAoyyKQakBDbrcg=;
        b=eJ7s8W+/vK8NPoKMhGC9g7LPtAOU/gYf1Fq8OFfpl6gvM8oiPZnKCEmxddRKgO0ob3
         2KwFRQISSEtiymT2Mg526CkGjya8f6PmD7DWtxAnwjLP1NcYJSj1E3ZqLU+muMVxHvjS
         TDdN/yG7iYGahgLcWpVyxQlW2+GOMvVko/UxRWx9MWvMm22mCfM0EMGtMiJST2V/Gl1h
         LuouwTFOIbdLpUJkJ5Qj5jTvXWHKWyJOesj0Yd+sUB+eutDPAizUMzKF6bAaPtM0/q68
         8TOchdL9XgkUrZLI3owGUHqzovsj1gplxOuWO8EyISsjnEd5HjAckqTQ/vLHuLnw1gLw
         rxyg==
X-Forwarded-Encrypted: i=1; AJvYcCWTdc7ueLMzWdsiZwRNHEqI4gs0GTEP9lmETaGhnV1U3lhoU3bCX1In3TlyujxG0NsGFIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqzLy1pcQQ45sWf1MIPdljhxrvoYxD5BEyzGmOm+EEYAwb7knW
	+asVbBQCo5ijpbVOwFl6XyIn0tKnNY0516TiiTT33XUnLVk+VPnc+rvJ
X-Gm-Gg: ASbGnct9UKYCoiJUZ52mSiTSeZj9xP1ZGSUjuDb8OGTaMVQ+QU96xXVzbn+YFiRNYxX
	XCVyRW6M61+jpi8jrzRPX6/FhVOCsp9qHizDagNIVrECJ8hwsKgVSHR/YQ2kLvCwz8zVV/Gsb7o
	6vPBo2erODNGNN9o73uJLD6nKWQzgyAWYiwSlpXCAzhxZjtsXT3QwLyoEYJQVAjF1oX7/uzNSdL
	egn4kVp8rvEp+Wsypj/hrCbezJV2FFh8XcQu2xx170Xdr6Ar2s67jp3o4UnuAyaee3YgznaszeL
	NZ0McpAojDxPlgyqf1Gpc1c+OD8n4a9YedC349cjBVASrWTibuLEL7m+LU2gQLwuHq5eE0XvdAR
	pKgWNU/kvZ/dOY2EkDtH4Aj6mY1I+fYrkwy++0A==
X-Google-Smtp-Source: AGHT+IEVyOo0FrjyhZVVq9/2fX+LJMs4jIoVjtjMGxxZu+xZ6Du4Fih8Cs0w6FJ5Gi8yI6H19r0zUQ==
X-Received: by 2002:a05:6a00:b92:b0:77f:3db0:630f with SMTP id d2e1a72fcca58-7938772bc12mr34643816b3a.28.1760468230128;
        Tue, 14 Oct 2025 11:57:10 -0700 (PDT)
Received: from fedora ([182.77.76.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7992d0c349csm15953171b3a.50.2025.10.14.11.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 11:57:09 -0700 (PDT)
From: Sahil Chandna <chandna.sahil@gmail.com>
To: ast@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	menglong.dong@linux.dev
Cc: Sahil Chandna <chandna.sahil@gmail.com>,
	syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com,
	Brahmajit Das <listout@listout.xyz>
Subject: [PATCH bpf-next v3] bpf: test_run: Fix sleep-in-atomic BUG in timer path with RT kernel
Date: Wed, 15 Oct 2025 00:26:35 +0530
Message-ID: <20251014185635.10300-1-chandna.sahil@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timer mode is initialized to NO_PREEMPT mode by default,
this disable preemption and force execution in atomic context
causing issue on PREEMPT_RT configurations when invoking
spin_lock_bh(), leading to the following warning:

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6107, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 1
Preemption disabled at:
[<ffffffff891fce58>] bpf_test_timer_enter+0xf8/0x140 net/bpf/test_run.c:42

Fix this, by removing NO_PREEMPT/NO_MIGRATE mode check.
Also, the test timer context no longer needs explicit calls to
migrate_disable()/migrate_enable() with rcu_read_lock()/rcu_read_unlock().
Use helpers rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate()
instead.

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Suggested-by: Menglong Dong <menglong.dong@linux.dev>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Co-developed-by: Brahmajit Das <listout@listout.xyz>
Signed-off-by: Brahmajit Das <listout@listout.xyz>
Signed-off-by: Sahil Chandna <chandna.sahil@gmail.com>

---
Changes since v2:
- Fix uninitialized struct bpf_test_timer

Changes since v1:
- Dropped `enum { NO_PREEMPT, NO_MIGRATE } mode` from `struct bpf_test_timer`.
- Removed all conditional preempt/migrate disable logic.
- Unified timer handling to use `migrate_disable()` / `migrate_enable()` universally.

Link to v2: https://lore.kernel.org/all/20251010075923.408195-1-chandna.linuxkernel@gmail.com/
Link to v1: https://lore.kernel.org/all/20251006054320.159321-1-chandna.linuxkernel@gmail.com/

Testing:
- Reproduced syzbot bug locally using the provided reproducer.
- Observed `BUG: sleeping function called from invalid context` on v1.
- Confirmed bug disappears after applying this patch.
- Validated normal functionality of `bpf_prog_test_run_*` helpers with C
  reproducer.
---
 net/bpf/test_run.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfb03ee0bb62..f1719ea7a037 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -29,7 +29,6 @@
 #include <trace/events/bpf_test_run.h>
 
 struct bpf_test_timer {
-	enum { NO_PREEMPT, NO_MIGRATE } mode;
 	u32 i;
 	u64 time_start, time_spent;
 };
@@ -37,12 +36,7 @@ struct bpf_test_timer {
 static void bpf_test_timer_enter(struct bpf_test_timer *t)
 	__acquires(rcu)
 {
-	rcu_read_lock();
-	if (t->mode == NO_PREEMPT)
-		preempt_disable();
-	else
-		migrate_disable();
-
+	rcu_read_lock_dont_migrate();
 	t->time_start = ktime_get_ns();
 }
 
@@ -50,12 +44,7 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
 	__releases(rcu)
 {
 	t->time_start = 0;
-
-	if (t->mode == NO_PREEMPT)
-		preempt_enable();
-	else
-		migrate_enable();
-	rcu_read_unlock();
+	rcu_read_unlock_migrate();
 }
 
 static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
@@ -374,7 +363,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,
 
 {
 	struct xdp_test_data xdp = { .batch_size = batch_size };
-	struct bpf_test_timer t = { .mode = NO_MIGRATE };
+	struct bpf_test_timer t = {};
 	int ret;
 
 	if (!repeat)
@@ -404,7 +393,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 	struct bpf_prog_array_item item = {.prog = prog};
 	struct bpf_run_ctx *old_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	struct bpf_test_timer t = { NO_MIGRATE };
+	struct bpf_test_timer t = {};
 	enum bpf_cgroup_storage_type stype;
 	int ret;
 
@@ -1377,7 +1366,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				     const union bpf_attr *kattr,
 				     union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t = {};
 	u32 size = kattr->test.data_size_in;
 	struct bpf_flow_dissector ctx = {};
 	u32 repeat = kattr->test.repeat;
@@ -1445,7 +1434,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kattr,
 				union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t = {};
 	struct bpf_prog_array *progs = NULL;
 	struct bpf_sk_lookup_kern ctx = {};
 	u32 repeat = kattr->test.repeat;
-- 
2.50.1


