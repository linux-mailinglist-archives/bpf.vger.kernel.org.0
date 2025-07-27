Return-Path: <bpf+bounces-64467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DFEB13240
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 00:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172AF174FB9
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0192505A5;
	Sun, 27 Jul 2025 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="d93UOtEd"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29C1C5499
	for <bpf@vger.kernel.org>; Sun, 27 Jul 2025 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753655554; cv=none; b=plZmqxa37AkbuejeR0j7EjzwuxiC6ogusAhiZm55v8xtFIqT2xPJ1CLCqxpEgBj6pZka/BU2+OMJA0Tpuc46aUu378rhxHzb8b1zRFq5aIsJ9TBANowPkOsaXKZ5wQy8t0K6PFBM8k1O6COCglwOxgQcEY4yjgof4Y+BKoXpefc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753655554; c=relaxed/simple;
	bh=/6X3zJHal456AJTMN9nYOcTwgfsjUDKxwIwjoqyYgr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6WPGdRG6aQM9zT40C8YRyFmHREwZI5BGiiPXpFUArOl6ahV2bEGOBCmu4BG1GjTRt8l/I1x4sB2NdiAXKYSJvjDzO1UmB+cfO+Q4chC0mIaTX/KEsGzalh+tcOeZd+SIf5Xj/5rYwePJQuqDV7To/qk+npmzRLm7cgfGC4VmHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=d93UOtEd; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=I+r98XfPVKqR3b9khnQ1cwgUdL+sbCbPLqKhSM9u2xk=; b=d93UOtEdWdWMTqwpDQ6VEphVix
	IpcSSi7UJ+0ZW4X0qylefcma6XS1CnlGxHc0tDPeU/yphFGUKDLJE1fTgJk+4C9yrtS87RpznKGZI
	kN0IDWYd/DARBqij2ouJecRYNi1gltdrEGnKsnvh48/4Vb6thhBK5hrOnsZnKyHWrjKjezPaNYjQ6
	jJRA0jkGgHplCxZQ+L4v1Gc2i3iYNiqLWW4BndCldr8dabVqiYbfwAW485j6F4elke3mv4SSkGtTV
	ZehTXCgXub2+mVkZNY1jC4zlpKXyFLewFwC6C07tXnFNNerKZtYH2SJ2L35rEC6mk9vwXItnRmjJb
	+vQUpzBA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ug9ur-000NM0-1E;
	Mon, 28 Jul 2025 00:32:25 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 3/4] bpf: Move cgroup iterator helpers to bpf.h
Date: Mon, 28 Jul 2025 00:32:22 +0200
Message-ID: <20250727223223.510058-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727223223.510058-1-daniel@iogearbox.net>
References: <20250727223223.510058-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27712/Sun Jul 27 10:35:17 2025)

Move them into bpf.h given we also need them in core code, add also
for_each_cgroup_storage_type_cond() which we'll be using in a
subsequent change.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf-cgroup.h |  3 ---
 include/linux/bpf.h        | 20 ++++++++++++--------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 082ccd8ad96b..d1f01d1168a1 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -77,9 +77,6 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
 extern struct static_key_false cgroup_bpf_enabled_key[MAX_CGROUP_BPF_ATTACH_TYPE];
 #define cgroup_bpf_enabled(atype) static_branch_unlikely(&cgroup_bpf_enabled_key[atype])
 
-#define for_each_cgroup_storage_type(stype) \
-	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
-
 struct bpf_cgroup_storage_map;
 
 struct bpf_storage_buffer {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a87646cc5398..a41dff574327 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -208,6 +208,18 @@ enum btf_field_type {
 	BPF_RES_SPIN_LOCK = (1 << 12),
 };
 
+enum bpf_cgroup_storage_type {
+	BPF_CGROUP_STORAGE_SHARED,
+	BPF_CGROUP_STORAGE_PERCPU,
+	__BPF_CGROUP_STORAGE_MAX
+#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
+};
+
+#define for_each_cgroup_storage_type(stype) \
+	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
+#define for_each_cgroup_storage_type_cond(stype, cond) \
+	for (stype = 0; (cond) && stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
+
 typedef void (*btf_dtor_kfunc_t)(void *);
 
 struct btf_field_kptr {
@@ -1085,14 +1097,6 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
 
-enum bpf_cgroup_storage_type {
-	BPF_CGROUP_STORAGE_SHARED,
-	BPF_CGROUP_STORAGE_PERCPU,
-	__BPF_CGROUP_STORAGE_MAX
-};
-
-#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
-
 /* The longest tracepoint has 12 args.
  * See include/trace/bpf_probe.h
  */
-- 
2.43.0


