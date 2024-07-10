Return-Path: <bpf+bounces-34394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F492D3FD
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 16:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313571F23AF6
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB9D19344A;
	Wed, 10 Jul 2024 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dYQERx8p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xnJGo62A"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8A4404;
	Wed, 10 Jul 2024 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720620997; cv=none; b=Ef7i2/vuPt9c9WqXrTKK595IvrGqLw9pjT5iBlV1gsFMME3ddUIRaHt4zTtVSNtA5t1RVpjNO1pFttm8VcdXRqJHGbvK2wMCch5SiVolqc+5wedudVhGb70/ByusOgZMBvIq+uQlCTUzIj9wfZODlh2DzOCXzfrXT3wfVCXfwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720620997; c=relaxed/simple;
	bh=I3LclCEl+iPHOLA/luM/1qJqwlMpZUGS9T48wyi2u2w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UqgV3QrFpjg6aJ+Wdn0WbFj2iyIKO1y1QXcfMvRDp7bL4P4D0Mq/F1leB3HQaz2SnDBG0bAaxSvUhb0dY13K3n3XC4e17n101pBCCzOnPRChEeYvQFmtzq855UaPrbguc82Z28rtoCT/Wu8BzyWotvLDpsjHTwArv70dSI1nnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dYQERx8p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xnJGo62A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:16:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720620993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=eLmcpkKhKAQk39bPg7qLzxeLwPCy1GHAGCHT+PZimZ4=;
	b=dYQERx8psL+bZCDPElEjmrYNAoaMZqk0Sd1nwPd5bJUAUot+ibm3IqM64diV7EBVp1EOSG
	4H28ooGrln/ZbdqBKv2AcawVSRoq3YkpimkMT5obWUK0xS1BuObFNc4q0FLXi0YoOdgSJ2
	Jo3acBLW30AhiBHfYg1sxUKwXvUzVtN48aMj4ZMdvZ2SVY7y1XeXt2VIUc+80bLObXl0XW
	iHc5DWv0NyfgaEkWHMy1qN93K3HrwfZYfXapUINFYCJ6gMSo46hpMrRmwmj331CdNfGyIp
	Cn5mYT58j0cHAAdIvHmiGATnsuxpdI4PkyDewRJUgyE4QT9DpE3h42KKT704eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720620993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=eLmcpkKhKAQk39bPg7qLzxeLwPCy1GHAGCHT+PZimZ4=;
	b=xnJGo62AeIp4G49xvTL+2IiOAOVe0or1Th9pnHePW0nfU22RtZcmeQ1Go94X5g3APhG56f
	/XpEMrER64m1mNDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: syzbot <syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	dsahern@kernel.org, eddyz87@gmail.com, edumazet@google.com,
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
	kpsingh@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	sdf@fomichev.me, sdf@google.com, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Mathieu Xhonneux <m.xhonneux@gmail.com>,
	David Lebrun <dlebrun@google.com>
Subject: [PATCH bpf-next] bpf: Remove tst_run from lwt_seg6local_prog_ops.
Message-ID: <20240710141631.FbmHcQaX@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The syzbot reported that the lwt_seg6 related BPF ops can be invoked
via bpf_test_run() without without entering input_action_end_bpf()
first.

Martin KaFai Lau said that self test for BPF_PROG_TYPE_LWT_SEG6LOCAL
probably didn't work since it was introduced in commit 04d4b274e2a
("ipv6: sr: Add seg6local action End.BPF"). The reason is that the
per-CPU variable seg6_bpf_srh_states::srh is never assigned in the self
test case but each BPF function expects it.

Remove test_run for BPF_PROG_TYPE_LWT_SEG6LOCAL.

Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
Reported-by: syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com
Fixes: d1542d4ae4df ("seg6: Use nested-BH locking for seg6_bpf_srh_states.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/filter.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index d767880c276d9..4cf1d34f76172 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11053,7 +11053,6 @@ const struct bpf_verifier_ops lwt_seg6local_verifier_ops = {
 };
 
 const struct bpf_prog_ops lwt_seg6local_prog_ops = {
-	.test_run		= bpf_prog_test_run_skb,
 };
 
 const struct bpf_verifier_ops cg_sock_verifier_ops = {
-- 
2.45.2


