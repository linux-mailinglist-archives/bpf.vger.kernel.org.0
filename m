Return-Path: <bpf+bounces-55702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B24A8511F
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 03:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1297B3A87
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 01:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA8526FA78;
	Fri, 11 Apr 2025 01:15:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F581D63F2
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334142; cv=none; b=mn3iIvIpKANsN521lJkuTrVbjtrDITmR3UfUrRnX52RKrOwzNnESeNce+0LeWHTu6iGDy75tVmUoi1ZMNpVdRLCID4OyRHHzuwmUJ3EtrogxkKEOiL1Uw0xugZRg+GA6B87y8lKEmLnBUVg7tiD8U502c9ZGWCh+WEMqTYa3CPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334142; c=relaxed/simple;
	bh=HlpJbFWQSK4GdSFFIdu2d5/CsFtPN5/54Gjc2byDmcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eL/UbbLNMFGc6HGqBBKFlRgfGMoQFagEspdxZLXXSznAolYxI3oR5iVe2T5pzF8dY+L1tCa+Q5O6moNPd+uDOG8m3pfP/UJCOaoSyuV63kM/y3cGs/Ol8MmhXGTG25Y73zxv47VgKOQKUOaMa31YIOjbQLIfkSSQvG6uNz5L6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DF9445149052; Thu, 10 Apr 2025 18:15:28 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [RFC PATCH bpf-next 1/4] cgroup: Add bpf prog revisions to struct cgroup_bpf
Date: Thu, 10 Apr 2025 18:15:28 -0700
Message-ID: <20250411011528.1839359-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411011523.1838771-1-yonghong.song@linux.dev>
References: <20250411011523.1838771-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

One of key items in mprog API is revision for prog list. The revision
number will be increased if the prog list changed, e.g., attach, detach
or replace.

Add 'revisions' field to struct cgroup_bpf, representing revisions for
all cgroup related attachment types. The initial revision value is
set to 1, the same as kernel mprog implementations.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf-cgroup-defs.h | 1 +
 kernel/cgroup/cgroup.c          | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-d=
efs.h
index 0985221d5478..a3cbbd00731a 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -62,6 +62,7 @@ struct cgroup_bpf {
 	 * when BPF_F_ALLOW_MULTI the list can have up to BPF_CGROUP_MAX_PROGS
 	 */
 	struct hlist_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
+	atomic64_t revisions[MAX_CGROUP_BPF_ATTACH_TYPE];
 	u8 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
=20
 	/* list of cgroup shared storages */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ac2db99941ca..dea7d12c8927 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2053,7 +2053,7 @@ static int cgroup_reconfigure(struct fs_context *fc=
)
 static void init_cgroup_housekeeping(struct cgroup *cgrp)
 {
 	struct cgroup_subsys *ss;
-	int ssid;
+	int i, ssid;
=20
 	INIT_LIST_HEAD(&cgrp->self.sibling);
 	INIT_LIST_HEAD(&cgrp->self.children);
@@ -2071,6 +2071,9 @@ static void init_cgroup_housekeeping(struct cgroup =
*cgrp)
 	for_each_subsys(ss, ssid)
 		INIT_LIST_HEAD(&cgrp->e_csets[ssid]);
=20
+	for (i =3D 0; i < ARRAY_SIZE(cgrp->bpf.revisions); i++)
+		atomic64_set(&cgrp->bpf.revisions[i], 1);
+
 	init_waitqueue_head(&cgrp->offline_waitq);
 	INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
 }
--=20
2.47.1


