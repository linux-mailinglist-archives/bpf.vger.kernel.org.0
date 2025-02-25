Return-Path: <bpf+bounces-52588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000C5A4504D
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 23:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFB83B5059
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B219194A44;
	Tue, 25 Feb 2025 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btCnrTsC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2821129E;
	Tue, 25 Feb 2025 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522737; cv=none; b=rsr94eEgwtBnOwjbLPv2i7A4b6eDYtkRNo8UCakvDN4RheUF9PDdQ+e6jpDBKQfy3mUsH9vAOukAPoBUbNTPo74sJop7kfuAesPhW+mST442SYA7glkrWDrY0DkCTr8k0jqkR45FwUCbEuvmCe7rZmiFxSF3D0l89lxV5wzzTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522737; c=relaxed/simple;
	bh=o+i9nObUcHywXRlODRiDLTHO7kajo7zEsnp5EZ0py7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkjIHhuDNIGP1ErEyyrWzyw2E/KRkKqNYjS8Ds1xwvZApHVvnLNwpTqzq7tw665llU7iY4AWHo3Ns+9MHcpnT2hbDMssVgqRh6e3l4QA7cX3B4AakTkZnE8l+l2wgp6kBfAGsHW9LXE4mCQz5ApGFooeXsCpQqlGwlJYfa7hfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btCnrTsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29161C4CEDD;
	Tue, 25 Feb 2025 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740522737;
	bh=o+i9nObUcHywXRlODRiDLTHO7kajo7zEsnp5EZ0py7A=;
	h=From:To:Cc:Subject:Date:From;
	b=btCnrTsCT4QMrPdQ+utkCFD6AUiS4pY6njhHEIWv+/KyXHXHSxPf50eRa3gN3gHOM
	 P7uz7gnsyv8JMHgrYOdL1RxA09/QfhzOYHdwMe/1yjjUHjL+9eADQeflKQ2UZBE31x
	 fST4WvyXkavTGMmnzfAfE4un7kELsLLd0MhrO9bU+oUiwnxTNE8S4o1PDNlqNsKkQF
	 zOfJejQejojFnZM7g0tL8/l7U63R8PwGnX11UgY0T+PI5Fd55Pbh795QIS8rYS0/ek
	 h4z5K0C6QdS7lmNcwrGTjqH4Yh2grJ6+IG8t31BUJxY3Slb5soEotxfrQWfb8FAIIm
	 S6mdI63m5yrkQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@kernel.org
Cc: oleg@redhat.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	kernel-team@meta.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH perf/core] uprobes: remove too strict lockdep_assert() condition in hprobe_expire()
Date: Tue, 25 Feb 2025 14:32:14 -0800
Message-ID: <20250225223214.2970740-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hprobe_expire() is used to atomically switch pending uretprobe instance
(struct return_instance) from being SRCU protected to be refcounted.
This can be done from background timer thread, or synchronously within
current thread when task is forked.

In the former case, return_instance has to be protected through RCU read
lock, and that's what hprobe_expire() used to check with
lockdep_assert(rcu_read_lock_held()).

But in the latter case (hprobe_expire() called from dup_utask()) there
is no RCU lock being held, and it's both unnecessary and incovenient.
Inconvenient due to the intervening memory allocations inside
dup_return_instance()'s loop. Unnecessary because dup_utask() is called
synchronously in current thread, and no uretprobe can run at that point,
so return_instance can't be freed either.

So drop rcu_read_lock_held() condition, and expand corresponding comment
to explain necessary lifetime guarantees. lockdep_assert()-detected
issue is a false positive.

Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with timeout)")
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/events/uprobes.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e783da1d1762..4d2140cab7ec 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -762,10 +762,14 @@ static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
 	enum hprobe_state hstate;
 
 	/*
-	 * return_instance's hprobe is protected by RCU.
-	 * Underlying uprobe is itself protected from reuse by SRCU.
+	 * Caller should guarantee that return_instance is not going to be
+	 * freed from under us. This can be achieved either through holding
+	 * rcu_read_lock() or by owning return_instance in the first place.
+	 *
+	 * Underlying uprobe is itself protected from reuse by SRCU, so ensure
+	 * SRCU lock is held properly.
 	 */
-	lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu));
+	lockdep_assert(srcu_read_lock_held(&uretprobes_srcu));
 
 	hstate = READ_ONCE(hprobe->state);
 	switch (hstate) {
-- 
2.43.5


