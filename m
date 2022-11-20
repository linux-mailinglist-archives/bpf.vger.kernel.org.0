Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD24631615
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 20:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiKTTyi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 14:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKTTyh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 14:54:37 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5A213D1F
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:54:36 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AKJin7L025439
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:54:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=o4Aykg9aJJ/R7+obUPcjbJM6fpi8T8nKPPUXfvCkXws=;
 b=qJ5efpF6DdmvtM8/ZRPMfZ50m11XgWIW52FAkfKxKg8sI+dQ7xn2UzHfo3mITxe2j9w8
 3WDSmANrr/KRk7g97R0x2yynAayhKxwYYQ0a/51AynwtQJHG18EuUk4+xXk3ykaP2K/x
 QsdU+7d7zf+IqwupOowz1T0xtmclzkPKBPg= 
Received: from maileast.thefacebook.com ([163.114.130.8])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kxwj3yyyf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:54:35 -0800
Received: from twshared3131.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 11:54:34 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id DEE9612774472; Sun, 20 Nov 2022 11:54:26 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 1/4] bpf: Add support for kfunc set with common btf_ids
Date:   Sun, 20 Nov 2022 11:54:26 -0800
Message-ID: <20221120195426.3113828-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120195421.3112414-1-yhs@fb.com>
References: <20221120195421.3112414-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Hb7ase9I-gyTVDcu9pzPvY7xa6RVZbDQ
X-Proofpoint-ORIG-GUID: Hb7ase9I-gyTVDcu9pzPvY7xa6RVZbDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-20_13,2022-11-18_01,2022-06-22_01
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
 kernel/bpf/helpers.c | 12 +++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d52054ec69c9..1c78d4df9e18 100644
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
@@ -7531,6 +7532,8 @@ static u32 *__btf_kfunc_id_set_contains(const struc=
t btf *btf,
 static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 {
 	switch (prog_type) {
+	case BPF_PROG_TYPE_UNSPEC:
+		return BTF_KFUNC_HOOK_COMMON;
 	case BPF_PROG_TYPE_XDP:
 		return BTF_KFUNC_HOOK_XDP;
 	case BPF_PROG_TYPE_SCHED_CLS:
@@ -7559,6 +7562,11 @@ u32 *btf_kfunc_id_set_contains(const struct btf *b=
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
index 89a95f3d854c..6b2de097b950 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1903,10 +1903,19 @@ static const struct btf_kfunc_id_set generic_kfun=
c_set =3D {
 	.set   =3D &generic_btf_ids,
 };
=20
+
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release)
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
@@ -1920,9 +1929,10 @@ static int __init kfunc_init(void)
 	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc=
_set);
 	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &gene=
ric_kfunc_set);
 	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &gen=
eric_kfunc_set);
-	return ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
+	ret =3D ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &common_k=
func_set);
 }
=20
 late_initcall(kfunc_init);
--=20
2.30.2

