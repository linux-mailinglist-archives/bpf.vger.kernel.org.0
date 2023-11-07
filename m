Return-Path: <bpf+bounces-14386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94957E3708
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 09:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852FE280F68
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE83111A4;
	Tue,  7 Nov 2023 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="f8TgjJKj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FBBDF72
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 08:57:00 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC14FA
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 00:56:59 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6NHsQ7009020
	for <bpf@vger.kernel.org>; Tue, 7 Nov 2023 00:56:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=fWMy3WPfU9HIqCEARJcl8Hn3fppMinNBvu2J8VEkDEk=;
 b=f8TgjJKj5ufR+sfTbHQdzteXk1lcqiYC1ehFa89jMQG0KvWjL0cSVbvCWfU1ow1ykLSh
 alZqz7ceENegWMBWWHvnTBeYYQM07Mv2RaQ++FO6IbLN2FWdHfbdvPnyQYJkElX2M8gR
 8y7VOsDXzmyHPBErlBchB+jhXB21Gy7fY2g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u79h5k60e-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 00:56:58 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 00:56:55 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 3A5AB26E3B70F; Tue,  7 Nov 2023 00:56:43 -0800 (PST)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Yonghong Song
	<yonghong.song@linux.dev>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v2 bpf-next 2/6] selftests/bpf: Add test passing MAYBE_NULL reg to bpf_refcount_acquire
Date: Tue, 7 Nov 2023 00:56:35 -0800
Message-ID: <20231107085639.3016113-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107085639.3016113-1-davemarchevsky@fb.com>
References: <20231107085639.3016113-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: I4s4fIVUNNO7OOYDDEmlhB3EiXxfCMRJ
X-Proofpoint-ORIG-GUID: I4s4fIVUNNO7OOYDDEmlhB3EiXxfCMRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02

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


