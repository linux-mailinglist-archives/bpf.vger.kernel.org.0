Return-Path: <bpf+bounces-58452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160FEABAB19
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315119E379C
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA1F207A20;
	Sat, 17 May 2025 16:27:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF7155CBD
	for <bpf@vger.kernel.org>; Sat, 17 May 2025 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747499260; cv=none; b=Azi3+ItFoOoht4mF9WDl852Ws/Gf3UO+5idycu5IF9H0zUgOBUuhSjmekJ5O0ZiV4KJXotKlZQKKnTRWd0o7GjMdI9pIgFMsylrhjnIiGfXoAyl/h/falGB+wGz9Q5MMXkdlKIuRjHk1W+B3693ce6xM8+4Yprvp66WQyv0Qcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747499260; c=relaxed/simple;
	bh=MZzE+I4VWL+PQ9ZEavjQprDhwb8lXvhe8B2XrrjLXeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+XLuQMJrtk7MCIGKg+a24NVWKFTGno48RBcLnrTUFInW5/BqliuL0Bi9yvlRaa8u1bcY4iBsY6K2/CIfYFYmxF+/lQN9vdXNSPNSQfM6b7JB4NDGTOAfXaslg8RBN7p9AjxJehZQjHwnY2Sv//wMvSrxju2yW8V2GoeftRmD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1A3CC7A25969; Sat, 17 May 2025 09:27:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 1/5] cgroup: Add bpf prog revisions to struct cgroup_bpf
Date: Sat, 17 May 2025 09:27:26 -0700
Message-ID: <20250517162726.4078372-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250517162720.4077882-1-yonghong.song@linux.dev>
References: <20250517162720.4077882-1-yonghong.song@linux.dev>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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


