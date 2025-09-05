Return-Path: <bpf+bounces-67562-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED72B4597D
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 15:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF231BC3452
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 13:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F22D350D50;
	Fri,  5 Sep 2025 13:47:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29627145329;
	Fri,  5 Sep 2025 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080072; cv=none; b=KzHUdTYee5xaRwEzH3PzjiHWXOsi9BCgzdfKjt1wpg2KYD6B83+I6mgb86WdL1b4QGvwv3zGfaKkhFW/9W7dkQLd1ZB8Hh2T3HUcZPG+lAUGxyOLvbNg7fzvKehGatjNtLZFy/BTqBp4l2+v5MzVvzVRtfch61lDSSJw8qLptPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080072; c=relaxed/simple;
	bh=dMr3k8fCBTflgGlM42DueGYKRLfKm9pILbayKlTokBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NKYoJBk9vospvWVtXnzvphfwg0a/gZKR0LKufXLkfT2oV9+SDTzUpbarkjbvlm7fLOkmwsREVhmkQ8ekpipj2mfnOCXHsDVQdPyysjH3sjHgs4NEYOIEmmJHsz6Yny6ixM3eg0dOzGim8OAVda6rVdnGBYlPwN+F7TF3bkK77Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from 7cf34ddaca59.ant.amazon.com (unknown [IPv6:2a01:e0a:3e8:c0d0:24ce:2523:e0d0:1c47])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id A7981420EC;
	Fri,  5 Sep 2025 13:47:47 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a01:e0a:3e8:c0d0:24ce:2523:e0d0:1c47) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=7cf34ddaca59.ant.amazon.com
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud lecomte <contact@arnaud-lcm.com>
To: alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	song@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCH bpf-next v8 2/3] bpf: clean-up bounds checking in
 __bpf_get_stack
Date: Fri,  5 Sep 2025 15:47:33 +0200
Message-Id: <20250905134733.26589-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250905134625.26531-1-contact@arnaud-lcm.com>
References: <20250905134625.26531-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175708006831.27452.11845896327155267463@Plesk>
X-PPP-Vhost: arnaud-lcm.com

From: Arnaud Lecomte <contact@arnaud-lcm.com>

Clean-up bounds checking for trace->nr in
__bpf_get_stack by limiting it only to
max_depth.

Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
Acked-by: Song Liu <song@kernel.org>
Cc: Song Liu <song@kernel.org>
---
 kernel/bpf/stackmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index ed707bc07173..9f3ae426ddc3 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -462,13 +462,15 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (may_fault)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
 
-	if (trace_in)
+	if (trace_in) {
 		trace = trace_in;
-	else if (kernel && task)
+		trace->nr = min_t(u32, trace->nr, max_depth);
+	} else if (kernel && task) {
 		trace = get_callchain_entry_for_task(task, max_depth);
-	else
+	} else {
 		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
 					   crosstask, false);
+	}
 
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
@@ -477,7 +479,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
-	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-- 
2.47.3


