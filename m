Return-Path: <bpf+bounces-70704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B7BCB247
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 00:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349F01A63A7F
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 22:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95AF286D7B;
	Thu,  9 Oct 2025 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="jOyt+c4M"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40901917ED;
	Thu,  9 Oct 2025 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760050251; cv=none; b=SyovHUhqCCa/Nix6cOVsxYlqn4SCv+vNXX535BF5iP5NgklCLCMkNsO6apZ5BfOi8NxLwRB0XNmnsFeBN7c0e9RChZ7CXzfrjr3Kip1iAa/VhSr6HOUcB0a0zneMFztSHYwyAP3HJFWVo1yK4P/VvzMwtl1rARcY8vs6aGaxjwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760050251; c=relaxed/simple;
	bh=XbJedgmhkJtOekQneCzxJsZCCbUo49qZL6p4o6oH19g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ofiIMdpX/IHMyLH7pvBhOsAydo1Gcxo7N8rvdJWt7Vr7C1/rzvscNxN/H4MfNuN1/U788swKAREZG+H1WzIekF0jUOUo3MopUtfrQWSfeXs20Nz4Q22UfznrKH23DB0lno9c6SxpEX+VtV6abHb8OQKdCHbHdZ1SP2ajlbpEvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=jOyt+c4M; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cjQ7z3wzQz9sps;
	Fri, 10 Oct 2025 00:50:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1760050239; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=REBP0pZoZjJIp9SzI7KkL4L6YDer5eMi/RCcJfMWSn4=;
	b=jOyt+c4MIEJjMIJtLegwO61hDZx1zacDSkYtXstg2rGTVWXOkYIYy/5EMqxGPUiELZtooF
	20D2KXwsImX9E8i0Dpf22Tj/ICRsCeUtHo8pGwe2J0A+im8R3PRXKp4DKSzuXEjbOiJeXw
	ajcep5L0rpIDKDTMl2BLx93Wp/Nzl13tyYd4dctQq+DAuz8lhQfm84/KiKcp/Uzd0rXBTV
	mzBl/ItIniRWy5hEYNYpIPH3N6AnR83xvpnYsd0XW2ayFYAYus7S8B84nihNk6HLvJrm3E
	e91PWaevm3ZDz7LOxpbsg3OmzLE7wWppXC34EqKFSWJAJR4nrgm5ZRpkKg3Y5Q==
Date: Fri, 10 Oct 2025 04:20:31 +0530
From: Brahmajit Das <listout@listout.xyz>
To: yonghong.song@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	chandna.linuxkernel@gmail.com, daniel@iogearbox.net, david.hunter.linux@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, khalid@kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, skhan@linuxfoundation.org, 
	song@kernel.org, syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
Subject: Re: [PATCH] bpf: test_run: Fix timer mode initialization to
 NO_MIGRATE mode
Message-ID: <lm4q7sgtfqabpuzkr73fz7xx7jinhwpwtdnhafoknngqvpduyn@srhrp6cnmnza>
Reply-To: d0fdced7-a9a5-473e-991f-4f5e4c13f616@linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Yonghong Song,

> So I suspect that we can remove NO_PREEMPT/NO_MIGRATE in test_run.c
> and use migrate_disable()/migrate_enable() universally.
Would something like this work?

--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -38,10 +38,7 @@ static void bpf_test_timer_enter(struct bpf_test_timer *t)
        __acquires(rcu)
 {
        rcu_read_lock();
-       if (t->mode == NO_PREEMPT)
-               preempt_disable();
-       else
-               migrate_disable();
+       migrate_disable();

        t->time_start = ktime_get_ns();
 }
@@ -51,10 +48,7 @@ static void bpf_test_timer_leave(struct bpf_test_timer *t)
 {
        t->time_start = 0;

-       if (t->mode == NO_PREEMPT)
-               preempt_enable();
-       else
-               migrate_enable();
+       migrate_enable();
        rcu_read_unlock();
 }

-- 
Regards,
listout

