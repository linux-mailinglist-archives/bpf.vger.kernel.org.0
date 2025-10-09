Return-Path: <bpf+bounces-70701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A04BCB174
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 00:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C9C1A64C2D
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 22:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCDF286435;
	Thu,  9 Oct 2025 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="MqDuSsN9"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3290285CBC;
	Thu,  9 Oct 2025 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760048940; cv=none; b=lRXkK1ru+yf+hOf3Y5vsbkX4xZSU6exU4sXhSg19GIQPGN+BMAcGkVFaBTXcS0Iye9jOEeCS/1QdnbLzhKECyx9g84pcverbUxOBLtd4AkH1poltHd9Q5etxiIN4072es4cMcrxqxUg8ABm4he2ythrTd10rIMCO2ubYiKXCIng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760048940; c=relaxed/simple;
	bh=mWNH/1Ia/jQ1Fkeaxgm/zfLHBP0yt7b9R++MIlzB0IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEhV0HK6hpkDaiye+usR5DdFrpmNOwo1+/ahDi8fDum8HztoFWzw0xbHu3DHlIQ5Dzc5iU2tZY5ruTTtRp90mMJ2m5DXNcF0SnC9Kc9xv6ttmEg7fF1sLR90u+BFwoSWt47RqlbK36jhz7j6PZ4llhbZOBHbHPaZKbRjZoM1a/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=MqDuSsN9; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cjPfs6NCgz9tRY;
	Fri, 10 Oct 2025 00:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1760048933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTorUxREnIdVsEG21ZBpKCwrqhNoGSkeBmzl2OWZcZ8=;
	b=MqDuSsN9nBJTZVBU36QdhkLmJDcYDhhHJwYFhkC7/fiOsn2SnhlBk8p3HMjXvG5U/bMmRb
	QZ0K7gBNZww2psPYGpEurs/CbTIEfKeUxzH8XmGj4pDsgGNSitmDusbviHkWD1+I5k80zQ
	ku+UG1sKYdx3Ix90/YRWdhZ1lb6Phcbbi6Xb4ERSzZvTMD6KQ4S7CRIV25GtkVs9dXvwFi
	yggCJz++jesp7DmrxjlHjtoHlYVplY8QguFJ0idBSpziGWORlAkmCtNQ/JkJcoD2fiwTwl
	V6q//V2UloV+21a5bBpNX1PU9sshnNffkgtjB/+41DEDvHPqFFgkCeMOil1LYg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: Brahmajit Das <listout@listout.xyz>
To: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Cc: ast@kernel.org,
	listout@listout.xyz,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH] bpf: avoid sleeping in invalid context during sock_map_delete_elem path
Date: Fri, 10 Oct 2025 03:58:36 +0530
Message-ID: <20251009222836.1433789-1-listout@listout.xyz>
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
X-Rspamd-Queue-Id: 4cjPfs6NCgz9tRY

#syz test

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
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 net/bpf/test_run.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfb03ee0bb62..07ffe7d92c1c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -38,10 +38,7 @@ static void bpf_test_timer_enter(struct bpf_test_timer *t)
 	__acquires(rcu)
 {
 	rcu_read_lock();
-	if (t->mode == NO_PREEMPT)
-		preempt_disable();
-	else
-		migrate_disable();
+	migrate_disable();
 
 	t->time_start = ktime_get_ns();
 }
@@ -51,10 +48,7 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
 {
 	t->time_start = 0;
 
-	if (t->mode == NO_PREEMPT)
-		preempt_enable();
-	else
-		migrate_enable();
+	migrate_enable();
 	rcu_read_unlock();
 }
 
-- 
2.51.0


