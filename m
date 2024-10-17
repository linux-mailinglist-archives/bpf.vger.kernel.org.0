Return-Path: <bpf+bounces-42345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC889A30CF
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 00:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543DF285FEA
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 22:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172801D7E52;
	Thu, 17 Oct 2024 22:35:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0FD1D79A7
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204500; cv=none; b=fJSW2T+RW/8xuM7kFsmVOUsTu9J26LL5eki6WF3K4HCGsXBJh4FqDpC5L0NPnRLKNaaDlzq87fxQqIqD5KN8XqpK2RRIlrvCQAEmd98mjqeM+X2Ps9ilQ0w9etp2so/czfFdiALoTep5rsGWl3XC/4t9pp02kLs6Ht69Xn9p7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204500; c=relaxed/simple;
	bh=fFyIp6W/9niIhq5mtAeHflCjRRSGawqx/UouEdV8bYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjJpHjfu/Po1q7lNI94GMyKZ2lNaamIzAZtRTHtsPGMSwgvVOiISgNK3T2yhz1uEh1H9xLAFG0d5vPgoUvQHYXuc0R6igaQ96p57Unh712fT2YQAkcqYUm+LUBcRZNjdb6mdCw+8llzVlXsIPqqBIijQKzZte1AyVzsK5J27qeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 23595A2F07D2; Thu, 17 Oct 2024 15:31:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v5 3/9] sched-ext: Allow sched-ext progs to use private stack
Date: Thu, 17 Oct 2024 15:31:54 -0700
Message-ID: <20241017223154.3176602-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017223138.3175885-1-yonghong.song@linux.dev>
References: <20241017223138.3175885-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow sched-ext struct_ops bpf progs to use private stack. In later
jit, there will be some recursion checking if private stack is used
such that if the same prog is run again in the same cpu, then
that second prog run will be skipped.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/sched/ext.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3cd7c50a51c5..f186cf7cac90 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5370,10 +5370,16 @@ bpf_scx_get_func_proto(enum bpf_func_id func_id, =
const struct bpf_prog *prog)
 	}
 }
=20
+static bool bpf_scx_priv_stack_allowed(void)
+{
+	return true;
+}
+
 static const struct bpf_verifier_ops bpf_scx_verifier_ops =3D {
 	.get_func_proto =3D bpf_scx_get_func_proto,
 	.is_valid_access =3D bpf_scx_is_valid_access,
 	.btf_struct_access =3D bpf_scx_btf_struct_access,
+	.priv_stack_allowed =3D bpf_scx_priv_stack_allowed,
 };
=20
 static int bpf_scx_init_member(const struct btf_type *t,
--=20
2.43.5


