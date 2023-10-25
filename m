Return-Path: <bpf+bounces-13277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2FC7D76F0
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 23:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8821C20F09
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 21:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF363347DD;
	Wed, 25 Oct 2023 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="c7oYC/Ho"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372534CD9
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 21:41:36 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578D6132
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:35 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39PLfYYL022768
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=fWMy3WPfU9HIqCEARJcl8Hn3fppMinNBvu2J8VEkDEk=;
 b=c7oYC/HoJnukyepDS/ztJbtLeexdiJsSetBDISdcwcNsDMsH1GM3k4ZMGxS5zEJHbfx3
 mW2hlagCKbPAoC10LQap5k4FZnp70SAemUqOJ24SEsgPzOPiQwUQvIkxCkcZyM1uZLgZ
 REe7AOKuf/Ti4MEKAMYPcqIYRXK10pwuwUc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3ty557k6s9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:41:33 -0700
Received: from twshared20079.02.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 14:40:26 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 7C24B264D46D1; Wed, 25 Oct 2023 14:40:10 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 2/6] selftests/bpf: Add test passing MAYBE_NULL reg to bpf_refcount_acquire
Date: Wed, 25 Oct 2023 14:40:03 -0700
Message-ID: <20231025214007.2920506-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025214007.2920506-1-davemarchevsky@fb.com>
References: <20231025214007.2920506-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ooububjia_6DtiQP8x7ZMlhdfEu4jNro
X-Proofpoint-GUID: ooububjia_6DtiQP8x7ZMlhdfEu4jNro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_11,2023-10-25_01,2023-05-22_02

The test added in this patch exercises the logic fixed in the previous
patch in this series. Before the previous patch's changes,
bpf_refcount_acquire accepts MAYBE_NULL local kptrs; after the change
the verifier correctly rejects the such a call.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../bpf/progs/refcounted_kptr_fail.c          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/t=
ools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
index 1ef07f6ee580..1553b9c16aa7 100644
--- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
@@ -53,6 +53,25 @@ long rbtree_refcounted_node_ref_escapes(void *ctx)
 	return 0;
 }
=20
+SEC("?tc")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+long refcount_acquire_maybe_null(void *ctx)
+{
+	struct node_acquire *n, *m;
+
+	n =3D bpf_obj_new(typeof(*n));
+	/* Intentionally not testing !n
+	 * it's MAYBE_NULL for refcount_acquire
+	 */
+	m =3D bpf_refcount_acquire(n);
+	if (m)
+		bpf_obj_drop(m);
+	if (n)
+		bpf_obj_drop(n);
+
+	return 0;
+}
+
 SEC("?tc")
 __failure __msg("Unreleased reference id=3D3 alloc_insn=3D9")
 long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
--=20
2.34.1


