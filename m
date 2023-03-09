Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2936B2C81
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 19:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCISBa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 13:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCISB2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 13:01:28 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885A8FCBC9
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 10:01:27 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 329HSYwa000472
        for <bpf@vger.kernel.org>; Thu, 9 Mar 2023 10:01:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Id/r4s5mJd2mQenKi8bgbByhZbf4l6O+REmiiD8pQWg=;
 b=flHs9E3cewh4axlTo9x28YFBXoU7WjQlfz2IRG06hZQXb+4qK9m5u5uxlkxheDJtG/2c
 UGywYTeqOjK9HcPwEr2hsK+5AGPB48qMYMnLw1Vj6D+qv4WRKkEIRC5VMH7Ywf//8e7c
 kB+9BqWd84XdikutEJlsrcp4SHEHvlk2yRI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p6ffung6c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 10:01:25 -0800
Received: from twshared8612.02.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 9 Mar 2023 10:01:22 -0800
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
        id 2C99218E84D29; Thu,  9 Mar 2023 10:01:15 -0800 (PST)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, <tj@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 1/6] bpf: verifier: Rename kernel_type_name helper to btf_type_name
Date:   Thu, 9 Mar 2023 10:01:06 -0800
Message-ID: <20230309180111.1618459-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309180111.1618459-1-davemarchevsky@fb.com>
References: <20230309180111.1618459-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wn0ym4SUjAopihZa8i78mJ57XaJLCKxl
X-Proofpoint-ORIG-GUID: wn0ym4SUjAopihZa8i78mJ57XaJLCKxl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_09,2023-03-09_01,2023-02-09_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

kernel_type_name was introduced in commit 9e15db66136a ("bpf: Implement a=
ccurate raw_tp context access via BTF")
with type signature:

  const char *kernel_type_name(u32 id)

At that time the function used global btf_vmlinux BTF for all id lookups.=
 Later,
in commit 22dc4a0f5ed1 ("bpf: Remove hard-coded btf_vmlinux assumption fr=
om BPF verifier"),
the type signature was changed to:

  static const char *kernel_type_name(const struct btf* btf, u32 id)

With the btf parameter used for lookups instead of global btf_vmlinux.

The helper will function as expected for type name lookup using non-kerne=
l BTFs,
and will be used for such in further patches in the series. Let's rename =
it to
avoid incorrect assumptions that might arise when seeing the current name=
.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45a082284464..cdf1ba65821b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -752,7 +752,7 @@ static int iter_get_spi(struct bpf_verifier_env *env,=
 struct bpf_reg_state *reg,
 	return stack_slot_obj_get_spi(env, reg, "iter", nr_slots);
 }
=20
-static const char *kernel_type_name(const struct btf* btf, u32 id)
+static const char *btf_type_name(const struct btf *btf, u32 id)
 {
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
 }
@@ -782,7 +782,7 @@ static const char *iter_type_str(const struct btf *bt=
f, u32 btf_id)
 		return "<invalid>";
=20
 	/* we already validated that type is valid and has conforming name */
-	return kernel_type_name(btf, btf_id) + sizeof(ITER_PREFIX) - 1;
+	return btf_type_name(btf, btf_id) + sizeof(ITER_PREFIX) - 1;
 }
=20
 static const char *iter_state_str(enum bpf_iter_state state)
@@ -1349,7 +1349,7 @@ static void print_verifier_state(struct bpf_verifie=
r_env *env,
=20
 			verbose(env, "%s", reg_type_str(env, t));
 			if (base_type(t) =3D=3D PTR_TO_BTF_ID)
-				verbose(env, "%s", kernel_type_name(reg->btf, reg->btf_id));
+				verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
 			verbose(env, "(");
 /*
  * _a stands for append, was shortened to avoid multiline statements bel=
ow.
@@ -4518,7 +4518,7 @@ static int map_kptr_match_type(struct bpf_verifier_=
env *env,
 			       struct btf_field *kptr_field,
 			       struct bpf_reg_state *reg, u32 regno)
 {
-	const char *targ_name =3D kernel_type_name(kptr_field->kptr.btf, kptr_f=
ield->kptr.btf_id);
+	const char *targ_name =3D btf_type_name(kptr_field->kptr.btf, kptr_fiel=
d->kptr.btf_id);
 	int perm_flags =3D PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
 	const char *reg_name =3D "";
=20
@@ -4534,7 +4534,7 @@ static int map_kptr_match_type(struct bpf_verifier_=
env *env,
 		return -EINVAL;
 	}
 	/* We need to verify reg->type and reg->btf, before accessing reg->btf =
*/
-	reg_name =3D kernel_type_name(reg->btf, reg->btf_id);
+	reg_name =3D btf_type_name(reg->btf, reg->btf_id);
=20
 	/* For ref_ptr case, release function check should ensure we get one
 	 * referenced PTR_TO_BTF_ID, and that its fixed offset is 0. For the
@@ -7177,8 +7177,8 @@ static int check_reg_type(struct bpf_verifier_env *=
env, u32 regno,
 						  btf_vmlinux, *arg_btf_id,
 						  strict_type_match)) {
 				verbose(env, "R%d is of type %s but %s is expected\n",
-					regno, kernel_type_name(reg->btf, reg->btf_id),
-					kernel_type_name(btf_vmlinux, *arg_btf_id));
+					regno, btf_type_name(reg->btf, reg->btf_id),
+					btf_type_name(btf_vmlinux, *arg_btf_id));
 				return -EACCES;
 			}
 		}
@@ -7248,7 +7248,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env =
*env,
 			verbose(env, "R%d must have zero offset when passed to release func\n=
",
 				regno);
 			verbose(env, "No graph node or root found at R%d type:%s off:%d\n", r=
egno,
-				kernel_type_name(reg->btf, reg->btf_id), reg->off);
+				btf_type_name(reg->btf, reg->btf_id), reg->off);
 			return -EINVAL;
 		}
=20
--=20
2.34.1

