Return-Path: <bpf+bounces-64618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A35B14C33
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF32543A9A
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B29728C025;
	Tue, 29 Jul 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk9/9OIX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01B28B3F8;
	Tue, 29 Jul 2025 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784994; cv=none; b=gjLu9JLTi4Sq/rl3Rt/alNOfoOeRfdSRxa/6tumtlcrkNyFgjtTkOE53WNVN0tg2lSOqy+TY8DsPeXp0kFoksW+EYXbyIN3d2BZNVetPe41bqaqjQfjTun/ighK7mcepc0u3gyHn/JVthUS9d4SQqyiyX9AP709Q6KQjeP9lptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784994; c=relaxed/simple;
	bh=UFgBnii1sdnMHWK81UnyXcALAP0f+Ry5dK/qMV1lLOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fq93kWfM4EonUIwrRTe2I5228bIzrOGNvgCGVNsO8ML/TLJ3VhVS11CPbK+utnOAtFvWN5+tNlTT/cnZ6RU6NBObr91j20DZtBI4tMVoEVunHIHtlg+mu39EihRrnjhPQPT9Yl0IOPnB5yzF7U8BQttnyNNgNVe+E8pEj3BHnAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk9/9OIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D41DC4CEEF;
	Tue, 29 Jul 2025 10:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753784994;
	bh=UFgBnii1sdnMHWK81UnyXcALAP0f+Ry5dK/qMV1lLOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qk9/9OIXssyCgo9MwjG36TdZkK76F6foHCZOoraayhJ+SrW6vtIs9CmDiHWXO6FMJ
	 xQt8jMV/GonZ01c8wf/1TquBLjawrFzDnkBaDctTYiqSl2o/IqBb28MsxZpy/K05Ry
	 bmXdUD+NMWK5LJ4R1tOYvTY+8evd7RVzA46HwRoNyKIFcihfGaI/MXYhhXeCrveZLN
	 j6xIBINpzVSzMgg76g1A/9thAccmLeHh2ctr27T3yhmFGSRFTJp7TAySEqBbUBklGy
	 GorVHY7RnIrLvc+xHbWqEX0dttAddWiaITK136lnlTj/Iied4dOe/vjwg5pk/OeNCB
	 cBJxEpgz/ZcPA==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>,
	Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [RFC 09/10] bpf: Remove ftrace_ops from bpf_trampoline object
Date: Tue, 29 Jul 2025 12:28:12 +0200
Message-ID: <20250729102813.1531457-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729102813.1531457-1-jolsa@kernel.org>
References: <20250729102813.1531457-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We no longer need ftrace_ops in each bpf_trampoline object,
we can manage with just single ftrace_ops for all direct
trampoline attachments.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h     |  1 -
 kernel/bpf/trampoline.c | 34 ++++++++++------------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c14bde400d97..bad29fe38a12 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1257,7 +1257,6 @@ struct bpf_trampoline {
 	struct hlist_node hlist_key;
 	/* hlist for trampoline_ip_table */
 	struct hlist_node hlist_ip;
-	struct ftrace_ops *fops;
 	/* serializes access to fields of this trampoline */
 	struct mutex mutex;
 	refcount_t refcnt;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 398c1a722d83..e6a0e7b20bb6 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -175,16 +175,6 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 	tr = kzalloc(sizeof(*tr), GFP_KERNEL);
 	if (!tr)
 		goto out;
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-	tr->fops = kzalloc(sizeof(struct ftrace_ops), GFP_KERNEL);
-	if (!tr->fops) {
-		kfree(tr);
-		tr = NULL;
-		goto out;
-	}
-	tr->fops->private = tr;
-	tr->fops->ops_func = bpf_tramp_ftrace_ops_func;
-#endif
 
 	tr->key = key;
 	tr->ip = ip;
@@ -202,13 +192,19 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned long ip)
 	return tr;
 }
 
+struct ftrace_ops direct_ops = {
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+       .ops_func = bpf_tramp_ftrace_ops_func,
+#endif
+};
+
 static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 {
 	void *ip = tr->func.addr;
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = unregister_ftrace_direct(tr->fops, (unsigned long) ip, (long)old_addr, false);
+		ret = unregister_ftrace_direct(&direct_ops, (unsigned long) ip, (long)old_addr, false);
 	else
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
 
@@ -222,7 +218,7 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 	int ret;
 
 	if (tr->func.ftrace_managed) {
-		ret = modify_ftrace_direct(tr->fops, (unsigned long) ip, (long)new_addr, lock_direct_mutex);
+		ret = modify_ftrace_direct(&direct_ops, (unsigned long) ip, (long)new_addr, lock_direct_mutex);
 	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, new_addr);
 	}
@@ -237,14 +233,11 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	int ret;
 
 	faddr = ftrace_location((unsigned long)ip);
-	if (faddr) {
-		if (!tr->fops)
-			return -ENOTSUPP;
+	if (faddr)
 		tr->func.ftrace_managed = true;
-	}
 
 	if (tr->func.ftrace_managed) {
-		ret = register_ftrace_direct(tr->fops, (unsigned long)ip, (long)new_addr);
+		ret = register_ftrace_direct(&direct_ops, (unsigned long)ip, (long)new_addr);
 	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
 	}
@@ -502,9 +495,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		 * BPF_TRAMP_F_SHARE_IPMODIFY is set, we can generate the
 		 * trampoline again, and retry register.
 		 */
-		/* reset fops->func and fops->trampoline for re-register */
-		tr->fops->func = NULL;
-		tr->fops->trampoline = 0;
 
 		/* free im memory and reallocate later */
 		bpf_tramp_image_free(im);
@@ -885,10 +875,6 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 */
 	hlist_del(&tr->hlist_key);
 	hlist_del(&tr->hlist_ip);
-	if (tr->fops) {
-		ftrace_free_filter(tr->fops);
-		kfree(tr->fops);
-	}
 	kfree(tr);
 out:
 	mutex_unlock(&trampoline_mutex);
-- 
2.50.1


