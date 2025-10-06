Return-Path: <bpf+bounces-70415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EABBBD15F
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 07:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 488813452B3
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 05:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC292494D8;
	Mon,  6 Oct 2025 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut29Izpw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBDF1C5D55
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759729411; cv=none; b=eQySkDufKIRsssYGNFUH2FoThqjK8BrTQf3VFoMWVFNL/kKWL71GfQpR2TZbB1aLk/zaBbRrdoMFqpaPyeuDcM39pQ7qU2Up2YNHQs5hE/QmVkLstftibmf+79z0QcVNH0luemvWPttR6jtUZ7Z2zgyv+WXjn6Rv023gO4DhQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759729411; c=relaxed/simple;
	bh=RE+zGZ8yF4o1w8jWuzVSUSVxDNM3CJztkem+rcfkWWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i05VUJPypvwQ5oK9TCvD0khQDkDxaFDU0dQ/GdnYKmkv5e6FWYGJWMvt+YPNr+dRpTuK1GvlqekL3eWJh7lyTos5xobvtahYRt0EPVoQHKgLjn46uMWaoK80+m3Aq/qOtrg8DJczZiVoR6AaGatqhUV3X245M9tKrYhMlUsDsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut29Izpw; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2698e4795ebso43255395ad.0
        for <bpf@vger.kernel.org>; Sun, 05 Oct 2025 22:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759729409; x=1760334209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UeAUDJn0BeGNQx3vn077OGP4xs5barO9XuqG13SWPJU=;
        b=Ut29IzpwbyB3AnjvP2qVIJ0/q4dqUGJL1md0vwMxedDAkrjOnEbwQg84xBD3tRGWUh
         exinCSEajTz7Ham1ToXtgS0y1939/95+GAIpjg9gPHvnWcEdTjE3N4tej6Dp+O470yBP
         GcONRIeitkhdPIuATeXN8rRfKFA+XsuRaS3clXxfELOUSmNk88w9Gh0dzZQsyyDs3mTw
         6MAo6+YKyT9dAaLGiWIkiLIV0jxNLW4ZVDLIt2+mWenKqGDp81/hYpopAxgyZq7clUZY
         Hd6fW5zVQRq++pPjh+mCfBaVrzgwoTRe0rJ8IU/zdkil6wJHUlv4j0XyzdUE9DY2pjv5
         S+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759729409; x=1760334209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeAUDJn0BeGNQx3vn077OGP4xs5barO9XuqG13SWPJU=;
        b=aDQvbA9hDqnt7DR2PaTWhvIVPubo5Wk+ZLFjPmQrZfYNgs04KBQJU2+8bkcYAn6pw2
         wUXHle4y3Dn8z6Nwde8Q8wPyvN/e3WAjTyvmfTI3p4eGnV1f1LXMx5X49XXONqadlc5z
         yxtgBCRT7MMvsOMoVt6lnkCxm+QIS35ac67kvoFrC7P/hEz/+1Gcxt2y0HqXKxEjElKb
         eaL8f5uIFdc7jmljRRHlNoekNoaF7O3Ai+I2N2v1lPJ38eiIrk6AnGFZxJqUsG1AzcPk
         jBRS35Af2XWJQGGUV/giQx+izENQmEzpXWJGjSVaeRvpoqSjyeL+U8BWhcMDf3yKL9xo
         e0Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVRRWIqRfqXyGXZ2Fp+VYi6XGxKAkc3p5n9Lboa0uhv1EqI40GAlk2Nv0UdxpzhfJEdkdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX4oDMq0aLniCR8o6a3QMCeFiE0d3dRJPdsfvqle2x/QQXUSeL
	+8KZ+jpY5Jk4NGH2LTTHAkPzNlyDqWaeT9cLObzWtKW59VnWjE8rK3kB
X-Gm-Gg: ASbGnct7avyOPY9SnKc5eMP8JHe+7Aty1vRoWfiF89SUgaiiusnuGhsWA2R8eLTBvCH
	gSbl20SOhueWGowJ7RdhKY3v0O2Glh4gJT4pIq1rYLqAhhJ9oOReU7jAAFyhqU5EXaDtNQOl9yF
	hKE1Slggj3LRMsuGSBFUpwZB3neMYNOT8TXW1oqsE81IIwB9TXHU67AIs7qDNU+hpXR30K4asNj
	IwtCPdaTCefq0YcoIgS+nu36dgnDJQhoK5YaMnIrPRhqgj9vNJ9PAaQYP0sF8cUlvr+dZ8WsWVh
	ZhkNooF3ipjDkJsDzT0p2NjddhKa5198EExQ6w59zwFm9I7ISsRQXnyJbifRrth41HTr+ssJh0j
	GhoCaz0akevuyYjFq5FGzHcYHr1YHhJZ9wqbSFd+chTTXg3mKtrsStGiZT0WoMn7/9ukW4yC4ug
	SdKxCJBuhmT89XAUkqbloNkEA=
X-Google-Smtp-Source: AGHT+IEgWCXbq557PGaex/0bq+zmROsO2U11LOaA2gdlP8UhSWMYUL72C92P/f2n/UgOF18aD+TRlw==
X-Received: by 2002:a17:903:2c10:b0:265:89c:251b with SMTP id d9443c01a7336-28e9a68fdfdmr122698305ad.29.1759729409388;
        Sun, 05 Oct 2025 22:43:29 -0700 (PDT)
Received: from chandna.localdomain ([182.77.76.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d125ed2sm119549815ad.35.2025.10.05.22.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 22:43:28 -0700 (PDT)
From: Sahil Chandna <chandna.linuxkernel@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	Sahil Chandna <chandna.linuxkernel@gmail.com>,
	syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Subject: [PATCH] bpf: test_run: Fix timer mode initialization to NO_MIGRATE mode
Date: Mon,  6 Oct 2025 11:13:20 +0530
Message-ID: <20251006054320.159321-1-chandna.linuxkernel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default, the timer mode is being initialized to `NO_PREEMPT`.
This disables preemption and forces execution in atomic context.
This can cause issue with PREEMPT_RT when calling spin_lock_bh() due
to sleeping nature of the lock.
...
BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6107, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 1
Preemption disabled at:
[<ffffffff891fce58>] bpf_test_timer_enter+0xf8/0x140 net/bpf/test_run.c:42
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8957
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock_bh include/linux/spinlock_rt.h:88 [inline]
 __sock_map_delete net/core/sock_map.c:421 [inline]
 sock_map_delete_elem+0xb7/0x170 net/core/sock_map.c:452
 bpf_prog_2c29ac5cdc6b1842+0x43/0x4b
 bpf_dispatcher_nop_func include/linux/bpf.h:1332 [inline]
...
Change initialization to NO_MIGRATE mode to prevent this.

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
---
 net/bpf/test_run.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 4a862d605386..daf966dfed69 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1368,7 +1368,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				     const union bpf_attr *kattr,
 				     union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t = { NO_MIGRATE };
 	u32 size = kattr->test.data_size_in;
 	struct bpf_flow_dissector ctx = {};
 	u32 repeat = kattr->test.repeat;
@@ -1436,7 +1436,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kattr,
 				union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t = { NO_MIGRATE };
 	struct bpf_prog_array *progs = NULL;
 	struct bpf_sk_lookup_kern ctx = {};
 	u32 repeat = kattr->test.repeat;
-- 
2.50.1


