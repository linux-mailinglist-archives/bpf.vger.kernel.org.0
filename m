Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A931D1CC367
	for <lists+bpf@lfdr.de>; Sat,  9 May 2020 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgEIR7J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 May 2020 13:59:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36420 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728314AbgEIR7J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 9 May 2020 13:59:09 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 049HuRQn026183
        for <bpf@vger.kernel.org>; Sat, 9 May 2020 10:59:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=VjcbeQyupxxr7TBBM42dTgTHtKEbd0k1bvjvsKdwakE=;
 b=Jl7L+QY4J2KERPoTnruEKfk6S9SZ0fYnMQIGR6uzuOLBz74eaP+XNRhFxgDj4MVm22kA
 K7L0RlXPA4zvdCmxcbCF/uKJ3CSC+ETFWqshPgipm8wk07MYdno+FCITYv1IKxJ3njPI
 D0kmN8wBpNNVJFuawJRgi8J5EUmxjivn1mE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30wsbq1haw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 09 May 2020 10:59:08 -0700
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Sat, 9 May 2020 10:59:07 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 86B5237008E2; Sat,  9 May 2020 10:59:00 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, <netdev@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v4 02/21] bpf: allow loading of a bpf_iter program
Date:   Sat, 9 May 2020 10:59:00 -0700
Message-ID: <20200509175900.2474947-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200509175859.2474608-1-yhs@fb.com>
References: <20200509175859.2474608-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-09_06:2020-05-08,2020-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005090155
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A bpf_iter program is a tracing program with attach type
BPF_TRACE_ITER. The load attribute
  attach_btf_id
is used by the verifier against a particular kernel function,
which represents a target, e.g., __bpf_iter__bpf_map
for target bpf_map which is implemented later.

The program return value must be 0 or 1 for now.
  0 : successful, except potential seq_file buffer overflow
      which is handled by seq_file reader.
  1 : request to restart the same object

In the future, other return values may be used for filtering or
teminating the iterator.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/bpf.h            |  3 +++
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/bpf_iter.c          | 36 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 21 ++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 5 files changed, 62 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 40c78b86fe38..f28bdd714754 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1127,6 +1127,8 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
 int bpf_obj_get_user(const char __user *pathname, int flags);
=20
+#define BPF_ITER_FUNC_PREFIX "__bpf_iter__"
+
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data);
 typedef void (*bpf_iter_fini_seq_priv_t)(void *private_data);
=20
@@ -1140,6 +1142,7 @@ struct bpf_iter_reg {
=20
 int bpf_iter_reg_target(struct bpf_iter_reg *reg_info);
 void bpf_iter_unreg_target(const char *target);
+bool bpf_iter_prog_supported(struct bpf_prog *prog);
=20
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value);
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6e5e7caa3739..c8a5325cc8d0 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -218,6 +218,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FEXIT,
 	BPF_MODIFY_RETURN,
 	BPF_LSM_MAC,
+	BPF_TRACE_ITER,
 	__MAX_BPF_ATTACH_TYPE
 };
=20
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 5a8119d17d14..dec182d8395a 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -12,6 +12,7 @@ struct bpf_iter_target_info {
 	bpf_iter_init_seq_priv_t init_seq_private;
 	bpf_iter_fini_seq_priv_t fini_seq_private;
 	u32 seq_priv_size;
+	u32 btf_id;	/* cached value */
 };
=20
 static struct list_head targets =3D LIST_HEAD_INIT(targets);
@@ -57,3 +58,38 @@ void bpf_iter_unreg_target(const char *target)
=20
 	WARN_ON(found =3D=3D false);
 }
+
+static void cache_btf_id(struct bpf_iter_target_info *tinfo,
+			 struct bpf_prog *prog)
+{
+	tinfo->btf_id =3D prog->aux->attach_btf_id;
+}
+
+bool bpf_iter_prog_supported(struct bpf_prog *prog)
+{
+	const char *attach_fname =3D prog->aux->attach_func_name;
+	u32 prog_btf_id =3D prog->aux->attach_btf_id;
+	const char *prefix =3D BPF_ITER_FUNC_PREFIX;
+	struct bpf_iter_target_info *tinfo;
+	int prefix_len =3D strlen(prefix);
+	bool supported =3D false;
+
+	if (strncmp(attach_fname, prefix, prefix_len))
+		return false;
+
+	mutex_lock(&targets_mutex);
+	list_for_each_entry(tinfo, &targets, list) {
+		if (tinfo->btf_id && tinfo->btf_id =3D=3D prog_btf_id) {
+			supported =3D true;
+			break;
+		}
+		if (!strcmp(attach_fname + prefix_len, tinfo->target)) {
+			cache_btf_id(tinfo, prog);
+			supported =3D true;
+			break;
+		}
+	}
+	mutex_unlock(&targets_mutex);
+
+	return supported;
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 70ad009577f8..d725ff7d11db 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7101,6 +7101,10 @@ static int check_return_code(struct bpf_verifier_e=
nv *env)
 			return 0;
 		range =3D tnum_const(0);
 		break;
+	case BPF_PROG_TYPE_TRACING:
+		if (env->prog->expected_attach_type !=3D BPF_TRACE_ITER)
+			return 0;
+		break;
 	default:
 		return 0;
 	}
@@ -10481,6 +10485,7 @@ static int check_attach_btf_id(struct bpf_verifie=
r_env *env)
 	struct bpf_prog *tgt_prog =3D prog->aux->linked_prog;
 	u32 btf_id =3D prog->aux->attach_btf_id;
 	const char prefix[] =3D "btf_trace_";
+	struct btf_func_model fmodel;
 	int ret =3D 0, subprog =3D -1, i;
 	struct bpf_trampoline *tr;
 	const struct btf_type *t;
@@ -10622,6 +10627,22 @@ static int check_attach_btf_id(struct bpf_verifi=
er_env *env)
 		prog->aux->attach_func_proto =3D t;
 		prog->aux->attach_btf_trace =3D true;
 		return 0;
+	case BPF_TRACE_ITER:
+		if (!btf_type_is_func(t)) {
+			verbose(env, "attach_btf_id %u is not a function\n",
+				btf_id);
+			return -EINVAL;
+		}
+		t =3D btf_type_by_id(btf, t->type);
+		if (!btf_type_is_func_proto(t))
+			return -EINVAL;
+		prog->aux->attach_func_name =3D tname;
+		prog->aux->attach_func_proto =3D t;
+		if (!bpf_iter_prog_supported(prog))
+			return -EINVAL;
+		ret =3D btf_distill_func_proto(&env->log, btf, t,
+					     tname, &fmodel);
+		return ret;
 	default:
 		if (!prog_extension)
 			return -EINVAL;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 6e5e7caa3739..c8a5325cc8d0 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -218,6 +218,7 @@ enum bpf_attach_type {
 	BPF_TRACE_FEXIT,
 	BPF_MODIFY_RETURN,
 	BPF_LSM_MAC,
+	BPF_TRACE_ITER,
 	__MAX_BPF_ATTACH_TYPE
 };
=20
--=20
2.24.1

