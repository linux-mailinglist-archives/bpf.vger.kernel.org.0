Return-Path: <bpf+bounces-2556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AA772EF85
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 00:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9232811E3
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 22:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102C724E93;
	Tue, 13 Jun 2023 22:35:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC513ADF
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 22:35:51 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51F31BE3
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:35:49 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DI4cWN025521
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:35:49 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r6ngb5r9y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 15:35:49 -0700
Received: from twshared35445.38.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:35:46 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id ADCE332D46381; Tue, 13 Jun 2023 15:35:36 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 1/4] bpf: move unprivileged checks into map_create() and bpf_prog_load()
Date: Tue, 13 Jun 2023 15:35:30 -0700
Message-ID: <20230613223533.3689589-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613223533.3689589-1-andrii@kernel.org>
References: <20230613223533.3689589-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SLjaulVoofA5gnN35zYz8PLqp2eD4SKI
X-Proofpoint-GUID: SLjaulVoofA5gnN35zYz8PLqp2eD4SKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_22,2023-06-12_02,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make each bpf() syscall command a bit more self-contained, making it
easier to further enhance it. We move sysctl_unprivileged_bpf_disabled
handling down to map_create() and bpf_prog_load(), two special commands
in this regard.

Also swap the order of checks, calling bpf_capable() only if
sysctl_unprivileged_bpf_disabled is true, avoiding unnecessary audit
messages.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 92a57efc77de..1cc590101e19 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1157,6 +1157,15 @@ static int map_create(union bpf_attr *attr)
 	     !node_online(numa_node)))
 		return -EINVAL;
=20
+	/* Intent here is for unprivileged_bpf_disabled to block BPF map
+	 * creation for unprivileged users; other actions depend
+	 * on fd availability and access to bpffs, so are dependent on
+	 * object creation success. Even with unprivileged BPF disabled,
+	 * capability checks are still carried out.
+	 */
+	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
+		return -EPERM;
+
 	/* find map type and init map: hashtable vs rbtree vs bloom vs ... */
 	map =3D find_and_alloc_map(attr);
 	if (IS_ERR(map))
@@ -2532,6 +2541,16 @@ static int bpf_prog_load(union bpf_attr *attr, bpf=
ptr_t uattr, u32 uattr_size)
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
 	is_gpl =3D license_is_gpl_compatible(license);
=20
+	/* Intent here is for unprivileged_bpf_disabled to block BPF program
+	 * creation for unprivileged users; other actions depend
+	 * on fd availability and access to bpffs, so are dependent on
+	 * object creation success. Even with unprivileged BPF disabled,
+	 * capability checks are still carried out for these
+	 * and other operations.
+	 */
+	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
+		return -EPERM;
+
 	if (attr->insn_cnt =3D=3D 0 ||
 	    attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS : BPF_=
MAXINSNS))
 		return -E2BIG;
@@ -5027,23 +5046,8 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
-	bool capable;
 	int err;
=20
-	capable =3D bpf_capable() || !sysctl_unprivileged_bpf_disabled;
-
-	/* Intent here is for unprivileged_bpf_disabled to block key object
-	 * creation commands for unprivileged users; other actions depend
-	 * of fd availability and access to bpffs, so are dependent on
-	 * object creation success.  Capabilities are later verified for
-	 * operations such as load and map create, so even with unprivileged
-	 * BPF disabled, capability checks are still carried out for these
-	 * and other operations.
-	 */
-	if (!capable &&
-	    (cmd =3D=3D BPF_MAP_CREATE || cmd =3D=3D BPF_PROG_LOAD))
-		return -EPERM;
-
 	err =3D bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
 	if (err)
 		return err;
--=20
2.34.1


