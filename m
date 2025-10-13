Return-Path: <bpf+bounces-70829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14F3BD57E6
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 19:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE513E6448
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D682C0F79;
	Mon, 13 Oct 2025 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="eyLEq8e0"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49CE29D266;
	Mon, 13 Oct 2025 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375511; cv=none; b=cSiR9s72t3V5rqp0TvkpXsVNxLpIOMBHoo30/ML21Vhhn9sSUNcrmvsyUNZTx++ApRvusNEPqE3JyBj5uUT0Hp1HjghyhLmhH/5YtaKHSxDAQovKOZVkmD7CgvZrOx3eYkJEo0Of7y2MxuYKEGxkYdYzBW312EvRy2R2tWHIf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375511; c=relaxed/simple;
	bh=40CFjh9kzA9585REHD+cA2lYowQDDOU8sCgEpVNrgYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDy+U6Uci1J51TIhNCGlbyHNdOYF/BBkxQozU7FPLXfYlxl8kRxlvHu9ulp5eKa84diXXtlxsjWEN869fiHVaM+XuXWl/ZBg0krj3XVtMXGpzCwxAWrwxD/tajc0hgb6AvRy7dGF9w03esoW1cSdS6Iz/cVfZC1qJ8/5AWHO9u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=eyLEq8e0; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4clkQy4k8Tz9tQS;
	Mon, 13 Oct 2025 19:11:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1760375498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wOr6yUFCcqirizRFMqUeU95gmF6JtVB3tD/YiBrl5s=;
	b=eyLEq8e0zwq7q1RjPRySRc4b6mZTc5fcaHVaUopkm66qJlDOVuYfLay8kf71/Dm/iNFgHu
	cHkuYBMF3DlzMUS8Q3lHvEs5vB6XDzyra4rQnyUFSGQRO6S1AyY7dfoWvbnsRlxkzlS5G4
	zgzDghCo87CXTvOQztMSVt12BoxU7ddMq2BMiJkN9IG0WBWs7q+aIL/4xIi3lLmcknRnBL
	ZbvpzuVVmvqpYZ2NhZ421WmGDDQRBdDll4iH2ueourg4dIfqWBKxkeYurftTR6NqfjhlIn
	BotItPmc9oKj8yzYimBbUqBIQoloBbytVsvXJ52wOU65UkGY+NaJSZChnF01Tw==
From: Brahmajit Das <listout@listout.xyz>
To: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Cc: listout@listout.xyz,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	haoluo@google.com,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev,
	Menglong Dong <menglong.dong@linux.dev>,
	Sahil Chandna <chandna.linuxkernel@gmail.com>
Subject: [PATCH v2] bpf: avoid sleeping in invalid context during sock_map_delete_elem path
Date: Mon, 13 Oct 2025 22:41:22 +0530
Message-ID: <20251013171122.1403859-1-listout@listout.xyz>
In-Reply-To: <68af9b2b.a00a0220.2929dc.0008.GAE@google.com>
References: <68af9b2b.a00a0220.2929dc.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The syzkaller report exposed a BUG: “sleeping function called from
invalid context” in sock_map_delete_elem, which happens when
`bpf_test_timer_enter()` disables preemption but the delete path later
invokes a sleeping function while still in that context. Specifically:

- The crash trace shows `bpf_test_timer_enter()` acquiring a
  preempt_disable path (via t->mode == NO_PREEMPT), but the symmetric
  release path always calls migrate_enable(), mismatching the earlier
  disable.
- As a result, preemption remains disabled across the
  sock_map_delete_elem path, leading to a sleeping call under an invalid
  context. :contentReference[oaicite:0]{index=0}

To fix this, normalize the disable/enable pairing: always use
migrate_disable()/migrate_enable() regardless of t->mode. This ensures
that we never remain with preemption disabled unintentionally when
entering the delete path, and avoids invalid-context sleeping.

Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Suggested-by: Menglong Dong <menglong.dong@linux.dev>
Co-authored-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
Changes in v2:
        - remove enum { NO_PREEMPT, NO_MIGRATE } mode
        - Using rcu_read_lock_dont_migrate/rcu_read_unlock_migrate

Changes in v1:
        - Changes on top of Sahil's initial work based on feedback from
        Yonghong's. i.e. remove NO_PREEMPT/NO_MIGRATE in test_run.c and use
        migrate_disable()/migrate_enable() universally.
        Link: https://lore.kernel.org/all/d0fdced7-a9a5-473e-991f-4f5e4c13f616@linux.dev/

Please also find Sahil's v2 patch:
        Link: https://lore.kernel.org/all/20251010075923.408195-1-chandna.linuxkernel@gmail.com/T/
---
 net/bpf/test_run.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfb03ee0bb62..83f97ee34419 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -29,7 +29,6 @@
 #include <trace/events/bpf_test_run.h>
 
 struct bpf_test_timer {
-	enum { NO_PREEMPT, NO_MIGRATE } mode;
 	u32 i;
 	u64 time_start, time_spent;
 };
@@ -37,11 +36,7 @@ struct bpf_test_timer {
 static void bpf_test_timer_enter(struct bpf_test_timer *t)
 	__acquires(rcu)
 {
-	rcu_read_lock();
-	if (t->mode == NO_PREEMPT)
-		preempt_disable();
-	else
-		migrate_disable();
+	rcu_read_lock_dont_migrate();
 
 	t->time_start = ktime_get_ns();
 }
@@ -51,11 +46,7 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
 {
 	t->time_start = 0;
 
-	if (t->mode == NO_PREEMPT)
-		preempt_enable();
-	else
-		migrate_enable();
-	rcu_read_unlock();
+	rcu_read_unlock_migrate();
 }
 
 static bool bpf_test_timer_continue(struct bpf_test_timer *t, int iterations,
@@ -374,7 +365,7 @@ static int bpf_test_run_xdp_live(struct bpf_prog *prog, struct xdp_buff *ctx,
 
 {
 	struct xdp_test_data xdp = { .batch_size = batch_size };
-	struct bpf_test_timer t = { .mode = NO_MIGRATE };
+	struct bpf_test_timer t = {};
 	int ret;
 
 	if (!repeat)
@@ -404,7 +395,7 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 	struct bpf_prog_array_item item = {.prog = prog};
 	struct bpf_run_ctx *old_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	struct bpf_test_timer t = { NO_MIGRATE };
+	struct bpf_test_timer t = {};
 	enum bpf_cgroup_storage_type stype;
 	int ret;
 
@@ -1377,7 +1368,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 				     const union bpf_attr *kattr,
 				     union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t = {};
 	u32 size = kattr->test.data_size_in;
 	struct bpf_flow_dissector ctx = {};
 	u32 repeat = kattr->test.repeat;
@@ -1445,7 +1436,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kattr,
 				union bpf_attr __user *uattr)
 {
-	struct bpf_test_timer t = { NO_PREEMPT };
+	struct bpf_test_timer t = {};
 	struct bpf_prog_array *progs = NULL;
 	struct bpf_sk_lookup_kern ctx = {};
 	u32 repeat = kattr->test.repeat;
-- 
2.51.0


