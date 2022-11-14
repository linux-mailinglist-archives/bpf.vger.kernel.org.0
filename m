Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56F9628517
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 17:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiKNQXz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 11:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiKNQXq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 11:23:46 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799E01A238
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 08:23:43 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AEDCGoA021793
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 08:23:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GIOPVYANIh5/SoEjThzxEI8av4MZ2smET9JEQkOMJYc=;
 b=X3M9UyXQgzGL4wlQR75bEJLNGDqIZzLg+zE0+T2BEfSMPjosDASwa2Zsy2p2Bmaf+8Ad
 ZQct6EBUDqGmEtJ48HKBmdHk2EDGTyjEh4mCUMjBejmUfDvrIZjiKSWD3GRAi9mgxSoM
 ji4paelrjaIRtPCHNH87qYylfNF9zWY/nq4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kupbjste5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 08:23:43 -0800
Received: from twshared28932.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 08:23:42 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id B7CE712265E74; Mon, 14 Nov 2022 08:23:34 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH bpf-next 1/3] bpf: Add support for kfunc set with generic btf_ids
Date:   Mon, 14 Nov 2022 08:23:34 -0800
Message-ID: <20221114162334.624056-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221114162328.622665-1-yhs@fb.com>
References: <20221114162328.622665-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zLNt5-OlZJ0CatVnJR3w4z10mwe5-14W
X-Proofpoint-ORIG-GUID: zLNt5-OlZJ0CatVnJR3w4z10mwe5-14W
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Later on, we will introduce a kfunc bpf_get_kern_btf_id() which
applies to all program types. Currently kfunc set only supports
individual prog types. This patch added support for a kfunc
applying to all program types. The implementation is identical
to [1].

  [1] https://lore.kernel.org/bpf/20221111165750.2526371-1-yhs@fb.com/

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/btf.c     |  8 ++++++++
 kernel/bpf/helpers.c | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5579ff3a5b54..84f09235857c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -199,6 +199,7 @@ DEFINE_IDR(btf_idr);
 DEFINE_SPINLOCK(btf_idr_lock);
=20
 enum btf_kfunc_hook {
+	BTF_KFUNC_HOOK_GENERIC,
 	BTF_KFUNC_HOOK_XDP,
 	BTF_KFUNC_HOOK_TC,
 	BTF_KFUNC_HOOK_STRUCT_OPS,
@@ -7499,6 +7500,8 @@ static u32 *__btf_kfunc_id_set_contains(const struct =
btf *btf,
 static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 {
 	switch (prog_type) {
+	case BPF_PROG_TYPE_UNSPEC:
+		return BTF_KFUNC_HOOK_GENERIC;
 	case BPF_PROG_TYPE_XDP:
 		return BTF_KFUNC_HOOK_XDP;
 	case BPF_PROG_TYPE_SCHED_CLS:
@@ -7527,6 +7530,11 @@ u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 			       u32 kfunc_btf_id)
 {
 	enum btf_kfunc_hook hook;
+	u32 *kfunc_flags;
+
+	kfunc_flags =3D __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_GENERIC, =
kfunc_btf_id);
+	if (kfunc_flags)
+		return kfunc_flags;
=20
 	hook =3D bpf_prog_type_to_kfunc_hook(prog_type);
 	return __btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 283f55bbeb70..2f11e22eefba 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1717,9 +1717,20 @@ static const struct btf_kfunc_id_set tracing_kfunc_s=
et =3D {
 	.set   =3D &tracing_btf_ids,
 };
=20
+BTF_SET8_START(generic_btf_ids)
+BTF_SET8_END(generic_btf_ids)
+
+static const struct btf_kfunc_id_set generic_kfunc_set =3D {
+	.owner =3D THIS_MODULE,
+	.set   =3D &generic_btf_ids,
+};
+
 static int __init kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_se=
t);
+	int ret;
+
+	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_s=
et);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &generic_kf=
unc_set);
 }
=20
 late_initcall(kfunc_init);
--=20
2.30.2

