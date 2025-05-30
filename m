Return-Path: <bpf+bounces-59363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF75AC94D7
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 19:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DBE1C07719
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 17:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B07E243367;
	Fri, 30 May 2025 17:38:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159A23C8AA
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626712; cv=none; b=FdRW6J/jLr6VAHjspVuCEx6ckoHoKIY+rxf80bmSB/jPDvQvZciHA48fhzLCCBvhBnsQbo9gdf2PjmOasvhxreZAtzzgu/+Brz9gDXrNgdxVZ11AJWSQnIBDgfTHT8ckTOLz+9aU/I1C4awGGx0POEbPo2uqKen0Xlykrhqs4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626712; c=relaxed/simple;
	bh=MGoStATA3ngYU/7c7cMvbVk/UvgIiC2kr1wlfVWv9xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsKctkKK8Yb0RzYmzfT901Ry3B+1opAokCCXMP+11FrtZoYcix9cSeikDbk+R7q+ausvkwy5SDlLcaaCsxFMp+ofzV9Wuj1KYpy/nrILyoKYHM0rY8tKcPXEyevaQrNvJ4VnsdTc2MX1LrCkn9mIiLT/VqHETt2jC4C/f1cmeBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CD4E788B38D6; Fri, 30 May 2025 10:38:17 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 1/5] cgroup: Add bpf prog revisions to struct cgroup_bpf
Date: Fri, 30 May 2025 10:38:17 -0700
Message-ID: <20250530173817.1823858-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250530173812.1823479-1-yonghong.song@linux.dev>
References: <20250530173812.1823479-1-yonghong.song@linux.dev>
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
index a723b7dc6e4e..312c6a8b55bb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2074,6 +2074,11 @@ static void init_cgroup_housekeeping(struct cgroup=
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


