Return-Path: <bpf+bounces-57809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 767C8AB0600
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 00:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC347B2E0D
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C37D22A4E9;
	Thu,  8 May 2025 22:35:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DDE24B28
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746743744; cv=none; b=pIQnhUCdLVeJZ0tmoC/23kx3czdUCz4b2XBidQAJSYtmBzfcx7pdLW+F2jJjchJEj0gpRRRAVI3GfG6BDpJKsHzf2ELP5NcRLilO/TpyNnHxFz1GCc7bKwT3LZAgqPFW2ZV+1fD9CUPPaGBlP8RPklHjBjqVFgeoie/RfSLTfBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746743744; c=relaxed/simple;
	bh=Ks5zMotgV8KOUyx/ZnvE6x6sQa94Z8/PlgjKRRGrjfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AS6WBSLbTIS8U8nE0p0vv6WrWlOcbm5dgmsd+kGqW1rBTBXsmKuHl4hHci3IyVD41P1IPyHEhcN0S9z55SSg3DcLX60Qm9WBOw2ORGL1d8fbyKk5X0MKLZKnxBXeTkDn6Y5SnRIBznxltWjDIgM1O2bDzNG1/xvMfaI/8xV6UU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 457E0722319E; Thu,  8 May 2025 15:35:29 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/4] cgroup: Add bpf prog revisions to struct cgroup_bpf
Date: Thu,  8 May 2025 15:35:29 -0700
Message-ID: <20250508223529.488295-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508223524.487875-1-yonghong.song@linux.dev>
References: <20250508223524.487875-1-yonghong.song@linux.dev>
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
 kernel/cgroup/cgroup.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-d=
efs.h
index 0985221d5478..c9e6b26abab6 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -63,6 +63,7 @@ struct cgroup_bpf {
 	 */
 	struct hlist_head progs[MAX_CGROUP_BPF_ATTACH_TYPE];
 	u8 flags[MAX_CGROUP_BPF_ATTACH_TYPE];
+	u64 revisions[MAX_CGROUP_BPF_ATTACH_TYPE];
=20
 	/* list of cgroup shared storages */
 	struct list_head storages;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 63e5b90da1f3..260ce8fc4ea4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2071,6 +2071,11 @@ static void init_cgroup_housekeeping(struct cgroup=
 *cgrp)
 	for_each_subsys(ss, ssid)
 		INIT_LIST_HEAD(&cgrp->e_csets[ssid]);
=20
+#ifdef CONFIG_CGROUP_BPF
+	for (int i =3D 0; i < ARRAY_SIZE(cgrp->bpf.revisions); i++)
+		cgrp->bpf.revisions[i] =3D 1;
+#endif
+
 	init_waitqueue_head(&cgrp->offline_waitq);
 	INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
 }
--=20
2.47.1


