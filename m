Return-Path: <bpf+bounces-70700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1CABCAEBC
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 23:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03506481D68
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 21:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4EA2848AC;
	Thu,  9 Oct 2025 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="nRammiyv"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3195284678
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045192; cv=none; b=jZjKKQUOLFnP6YyglA6gSaeHsGFIPLZwvwCOziMdR7Oe35a2YrN6kWQbD8LTh4EckJgOWwQEoLG6nOkKSAkhzCqehbQgoGrXJc0eaHaqNuyHXipNpzrRQECYx3zVE+iOElt7XiYcPUg3kZqB3f1Hd+bqRtnuUb0II1WdsGi7aTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045192; c=relaxed/simple;
	bh=5cetBHi68f37hYc1AepHn/yJw87ScPau0jYUeg5N5E4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hmeHBAW+ORW7DD1ucJJbkPgUG4+wmeA3ux4oQjl5G7tO13L8j/ma1N1IdC4UQO22sXb9gvggIz65gAvmDi9xHNljfYfl5w4fZ7DQvQf8wVcP5o6wz23vs5iVFYHOeT785ytqYJ1ZqA1PdjICY9m8J+LBc9F7CqyjzaGI9vWq9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=nRammiyv; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cjNGh4FKsz9srG;
	Thu,  9 Oct 2025 23:26:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1760045180; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=CUJP6LRxzy/5YLhoHmtsl05yJPxNnBthBvnes6XLdNQ=;
	b=nRammiyvY4CjJ6FRjIJHRUbKBV2sQ7J3otMl/5VcGMH2T0keF1Ma+u8EkTfVizHmERIxZT
	wd6ODqhUJK6R/sn8NMDBbpfBQiZRB2y35Dm6faZK+ui8lWTC8ZL5Ol80LICvdQL0DgDYsQ
	ZfNL9iQhOyIeohxwlS5g53MUcK+RYL2z62h+m5GWm3DdBp5AX8LU111xgj2J/eb+xHOAAI
	0f/y6AHZE/7uealU3zFsNd8p6lmShzDSgSpHjOKPoV3hCcm5JVLb8ni52xGHVWHWeLxngI
	7cxOFIRzp1VzJGUZ9hLemGmt+eJcuLvudCP0IdWuBC7ywaBfTpJE/D0uk+RMPw==
Date: Fri, 10 Oct 2025 02:56:10 +0530
From: Brahmajit Das <listout@listout.xyz>
To: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Cc: bpf@vger.kernel.org
Subject: Re: [bpf?] [net?] BUG: sleeping function called from invalid context
 in sock_map_delete_elem
Message-ID: <h545bb77v5thrxyp2d6tqkazozyjnd3bs44j4hrkrrp2lxvadx@q25uxgdpktg4>
Reply-To: 68af9b2b.a00a0220.2929dc.0008.GAE@google.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

#syz test

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
Regards,
listout

