Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E643631518
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 17:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKTQPW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 11:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKTQPV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 11:15:21 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B7E1B7A3
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 08:15:20 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AKDbVOb021359
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 08:15:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=S3W75C8gHyzu/9wEnsmuToL5y6VP0ZKvYifnlw69OFs=;
 b=Hh5uM3CIizM8j5qbmJD2noOMi/FL3IyKvLsgWS8C7QhhQP8eRsrpJ9OLjobwe5pi1qJm
 Yt3szc+9izZK4vk1zET3UP6YGU5L6BkG/wdNZaNGxbtSUh7BrIVp+eAvtRuSKEffsE5H
 9wKWK338WNkJcgcof4NSjNHV6Gb6EOpLIaI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kxv2qy8sf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 08:15:20 -0800
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 08:15:19 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 2BA9A127558B6; Sun, 20 Nov 2022 08:15:17 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 1/4] bpf: Add support for kfunc set with common btf_ids
Date:   Sun, 20 Nov 2022 08:15:17 -0800
Message-ID: <20221120161517.832281-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120161511.831691-1-yhs@fb.com>
References: <20221120161511.831691-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JJ9NJ1yvJYZ_lGlmflxIPSCSlvD9qiXu
X-Proofpoint-GUID: JJ9NJ1yvJYZ_lGlmflxIPSCSlvD9qiXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_11,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Later on, we will introduce kfuncs bpf_cast_to_kern_ctx() and
bpf_rdonly_cast() which apply to all program types. Currently kfunc set
only supports individual prog types. This patch added support for kfunc
applying to all program types.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/btf.c     |  8 ++++++++
 kernel/bpf/helpers.c | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7d5fab61535..0a3abbe56c5d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -199,6 +199,7 @@ DEFINE_IDR(btf_idr);
 DEFINE_SPINLOCK(btf_idr_lock);
=20
 enum btf_kfunc_hook {
+	BTF_KFUNC_HOOK_COMMON,
 	BTF_KFUNC_HOOK_XDP,
 	BTF_KFUNC_HOOK_TC,
 	BTF_KFUNC_HOOK_STRUCT_OPS,
@@ -7523,6 +7524,8 @@ static u32 *__btf_kfunc_id_set_contains(const struc=
t btf *btf,
 static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 {
 	switch (prog_type) {
+	case BPF_PROG_TYPE_UNSPEC:
+		return BTF_KFUNC_HOOK_COMMON;
 	case BPF_PROG_TYPE_XDP:
 		return BTF_KFUNC_HOOK_XDP;
 	case BPF_PROG_TYPE_SCHED_CLS:
@@ -7551,6 +7554,11 @@ u32 *btf_kfunc_id_set_contains(const struct btf *b=
tf,
 			       u32 kfunc_btf_id)
 {
 	enum btf_kfunc_hook hook;
+	u32 *kfunc_flags;
+
+	kfunc_flags =3D __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON,=
 kfunc_btf_id);
+	if (kfunc_flags)
+		return kfunc_flags;
=20
 	hook =3D bpf_prog_type_to_kfunc_hook(prog_type);
 	return __btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 212e791d7452..eaae7f474eda 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1843,6 +1843,14 @@ static const struct btf_kfunc_id_set generic_kfunc=
_set =3D {
 	.set   =3D &generic_btf_ids,
 };
=20
+BTF_SET8_START(common_btf_ids)
+BTF_SET8_END(common_btf_ids)
+
+static const struct btf_kfunc_id_set common_kfunc_set =3D {
+	.owner =3D THIS_MODULE,
+	.set   =3D &common_btf_ids,
+};
+
 static int __init kfunc_init(void)
 {
 	int ret;
@@ -1850,7 +1858,10 @@ static int __init kfunc_init(void)
 	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc=
_set);
 	if (ret)
 		return ret;
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfun=
c_set);
+	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfu=
nc_set);
+	if (ret)
+		return ret;
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_kfunc_se=
t);
 }
=20
 late_initcall(kfunc_init);
--=20
2.30.2

