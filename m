Return-Path: <bpf+bounces-16317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719227FFA6A
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 19:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2630928189F
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 18:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505AC5A11D;
	Thu, 30 Nov 2023 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143C194
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 10:53:23 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUIpax2031231
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 10:53:22 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uphtvwe70-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 10:53:22 -0800
Received: from twshared15232.14.prn3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 10:53:19 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id ACFA63C6029B4; Thu, 30 Nov 2023 10:53:08 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v12 bpf-next 17/17] bpf,selinux: allocate bpf_security_struct per BPF token
Date: Thu, 30 Nov 2023 10:52:29 -0800
Message-ID: <20231130185229.2688956-18-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130185229.2688956-1-andrii@kernel.org>
References: <20231130185229.2688956-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qjBvD90sOBLrSYC_qjRE0p12C6d3Y0qF
X-Proofpoint-GUID: qjBvD90sOBLrSYC_qjRE0p12C6d3Y0qF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_18,2023-11-30_01,2023-05-22_02

Utilize newly added bpf_token_create/bpf_token_free LSM hooks to
allocate struct bpf_security_struct for each BPF token object in
SELinux. This just follows similar pattern for BPF prog and map.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 security/selinux/hooks.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 002351ab67b7..1501e95366a1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6828,6 +6828,29 @@ static void selinux_bpf_prog_free(struct bpf_prog =
*prog)
 	prog->aux->security =3D NULL;
 	kfree(bpfsec);
 }
+
+static int selinux_bpf_token_create(struct bpf_token *token, union bpf_a=
ttr *attr,
+				    struct path *path)
+{
+	struct bpf_security_struct *bpfsec;
+
+	bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
+	if (!bpfsec)
+		return -ENOMEM;
+
+	bpfsec->sid =3D current_sid();
+	token->security =3D bpfsec;
+
+	return 0;
+}
+
+static void selinux_bpf_token_free(struct bpf_token *token)
+{
+	struct bpf_security_struct *bpfsec =3D token->security;
+
+	token->security =3D NULL;
+	kfree(bpfsec);
+}
 #endif
=20
 struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
@@ -7183,6 +7206,7 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
 	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
 	LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
 	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
+	LSM_HOOK_INIT(bpf_token_free, selinux_bpf_token_free),
 #endif
=20
 #ifdef CONFIG_PERF_EVENTS
@@ -7241,6 +7265,7 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
 #ifdef CONFIG_BPF_SYSCALL
 	LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
 	LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
+	LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
 #endif
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
--=20
2.34.1


