Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8DB620A82
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiKHHmC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiKHHlc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:41:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC56613F61
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:41:22 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A80COrT029642
        for <bpf@vger.kernel.org>; Mon, 7 Nov 2022 23:41:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=D93K/Todg/2FMN4Np5Is9cQBLvrEsE32LFl2lWP4jIs=;
 b=ZOvYHXVuogE9O4nvrVSnyZzhzfMFRmRlK7pXK0EwMgCFtO9RgAlkv5v3k/BEjka1mJfh
 QhkNxu5AQAQlDb/cvW8ufCm42kyeqwdCZg1gOsOWK9bAcXA/VVsQ4eoMjioSfFw1ByDs
 b3L7agl4S11B12Jq56Ma0YL1m9AeeilFlPE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kqcc5jgas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:41:22 -0800
Received: from twshared6758.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 23:41:13 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 8E37411D233CC; Mon,  7 Nov 2022 23:41:09 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 4/8] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Date:   Mon, 7 Nov 2022 23:41:09 -0800
Message-ID: <20221108074109.263773-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108074047.261848-1-yhs@fb.com>
References: <20221108074047.261848-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eKgEA_AOX-XwG4Aa_XN83Q8pUdlPqP4P
X-Proofpoint-GUID: eKgEA_AOX-XwG4Aa_XN83Q8pUdlPqP4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
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

The kfunc bpf_rcu_read_lock() is tagged with new flag KF_RCU_LOCK and
bpf_rcu_read_unlock() with new flag KF_RCU_UNLOCK. These two new flags
are used by the verifier to identify these two helpers.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h  |  3 +++
 include/linux/btf.h  |  2 ++
 kernel/bpf/btf.c     |  8 ++++++++
 kernel/bpf/helpers.c | 25 ++++++++++++++++++++++++-
 4 files changed, 37 insertions(+), 1 deletion(-)

For new kfuncs, I added KF_RCU_LOCK and KF_RCU_UNLOCK flags to
indicate a helper could be bpf_rcu_read_lock/unlock(). This could
be a waste for kfunc flag space as the flag is used to identify
one helper. Alternatively, we might identify kfunc based on
btf_id. Any suggestions are welcome.

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5011cb50abf1..b4bbcafd1c9b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2118,6 +2118,9 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog =
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
diff --git a/include/linux/btf.h b/include/linux/btf.h
index d80345fa566b..8783ca7e6079 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -51,6 +51,8 @@
 #define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arg=
uments */
 #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions *=
/
+#define KF_RCU_LOCK     (1 << 7) /* kfunc does rcu_read_lock() */
+#define KF_RCU_UNLOCK   (1 << 8) /* kfunc does rcu_read_unlock() */
=20
 /*
  * Return the name of the passed struct, if exists, or halt the build if=
 for
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index cf16c0ead9f4..d2ee1669a2f3 100644
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
@@ -7498,6 +7499,8 @@ static u32 *__btf_kfunc_id_set_contains(const struc=
t btf *btf,
 static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 {
 	switch (prog_type) {
+	case BPF_PROG_TYPE_UNSPEC:
+		return BTF_KFUNC_HOOK_GENERIC;
 	case BPF_PROG_TYPE_XDP:
 		return BTF_KFUNC_HOOK_XDP;
 	case BPF_PROG_TYPE_SCHED_CLS:
@@ -7526,6 +7529,11 @@ u32 *btf_kfunc_id_set_contains(const struct btf *b=
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
index 283f55bbeb70..f364d01e9d93 100644
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
+BTF_ID_FLAGS(func, bpf_rcu_read_lock, KF_RCU_LOCK)
+BTF_ID_FLAGS(func, bpf_rcu_read_unlock, KF_RCU_UNLOCK)
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

