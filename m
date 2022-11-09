Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FF06235A8
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 22:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiKIVUL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 16:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKIVUK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 16:20:10 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA8713DFF
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 13:20:10 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9KWMKi032579
        for <bpf@vger.kernel.org>; Wed, 9 Nov 2022 13:20:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Em/LHiN9t8Yi46+1Thh1R9aX+wsPId5UQwGHRJGjuTE=;
 b=EDfA+4GfehcQaY5Jv0gCn/PG1Bp/7O7KoomppsAH1H+iKiA426GXcr3IgZmCRT0+yRSN
 7cs2uoRxte2WjcEx9huqqJfg6rk5dbPZWAUEAZ6tOEvSplhRgiZpPI4lj7AcUJVy4/WZ
 TEowJbL+mZLcBOFk1niUImdMV4cXdp/Zzv8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kr3a3yv1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 13:20:09 -0800
Received: from twshared9088.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 13:20:09 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 1C83111E72E89; Wed,  9 Nov 2022 13:20:00 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 3/7] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Date:   Wed, 9 Nov 2022 13:20:00 -0800
Message-ID: <20221109212000.3214822-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109211944.3213817-1-yhs@fb.com>
References: <20221109211944.3213817-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 9_N3UiyaF8JjMd6IsxjrEjksCXhZ5_9f
X-Proofpoint-ORIG-GUID: 9_N3UiyaF8JjMd6IsxjrEjksCXhZ5_9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add two kfunc's bpf_rcu_read_lock() and bpf_rcu_read_unlock(). These two =
kfunc's
can be used for all program types. A new kfunc hook type BTF_KFUNC_HOOK_G=
ENERIC
is added which corresponds to prog type BPF_PROG_TYPE_UNSPEC, indicating =
the
kfunc intends to be used for all prog types.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h  |  3 +++
 kernel/bpf/btf.c     |  8 ++++++++
 kernel/bpf/helpers.c | 25 ++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 798aec816970..3ed817cf191d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2113,6 +2113,9 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog =
*prog);
 const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn);
+void bpf_rcu_read_lock(void);
+void bpf_rcu_read_unlock(void);
+
 struct bpf_core_ctx {
 	struct bpf_verifier_log *log;
 	const struct btf *btf;
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
@@ -7499,6 +7500,8 @@ static u32 *__btf_kfunc_id_set_contains(const struc=
t btf *btf,
 static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 {
 	switch (prog_type) {
+	case BPF_PROG_TYPE_UNSPEC:
+		return BTF_KFUNC_HOOK_GENERIC;
 	case BPF_PROG_TYPE_XDP:
 		return BTF_KFUNC_HOOK_XDP;
 	case BPF_PROG_TYPE_SCHED_CLS:
@@ -7527,6 +7530,11 @@ u32 *btf_kfunc_id_set_contains(const struct btf *b=
tf,
 			       u32 kfunc_btf_id)
 {
 	enum btf_kfunc_hook hook;
+	u32 *kfunc_flags;
+
+	kfunc_flags =3D __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_GENERIC=
, kfunc_btf_id);
+	if (kfunc_flags)
+		return kfunc_flags;
=20
 	hook =3D bpf_prog_type_to_kfunc_hook(prog_type);
 	return __btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 283f55bbeb70..0c8382103625 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1717,9 +1717,32 @@ static const struct btf_kfunc_id_set tracing_kfunc=
_set =3D {
 	.set   =3D &tracing_btf_ids,
 };
=20
+void bpf_rcu_read_lock(void)
+{
+	rcu_read_lock();
+}
+
+void bpf_rcu_read_unlock(void)
+{
+	rcu_read_unlock();
+}
+
+BTF_SET8_START(generic_btf_ids)
+BTF_ID_FLAGS(func, bpf_rcu_read_lock)
+BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
+BTF_SET8_END(generic_btf_ids)
+
+static const struct btf_kfunc_id_set generic_kfunc_set =3D {
+	.owner =3D THIS_MODULE,
+	.set   =3D &generic_btf_ids,
+};
+
 static int __init kfunc_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc_=
set);
+	int ret;
+
+	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &tracing_kfunc=
_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &generic_=
kfunc_set);
 }
=20
 late_initcall(kfunc_init);
--=20
2.30.2

