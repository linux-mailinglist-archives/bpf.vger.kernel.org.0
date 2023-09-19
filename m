Return-Path: <bpf+bounces-10410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950FD7A6D72
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 23:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927541C209D2
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 21:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84193C699;
	Tue, 19 Sep 2023 21:48:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11AB3B2B2
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 21:48:46 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64535110
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 14:48:42 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 38JL4nOY020471
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 14:48:41 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3t718e0964-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 14:48:41 -0700
Received: from twshared2123.40.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 19 Sep 2023 14:48:21 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B1F97385A5F65; Tue, 19 Sep 2023 14:48:17 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v5 bpf-next 08/13] bpf: consistenly use BPF token throughout BPF verifier logic
Date: Tue, 19 Sep 2023 14:47:55 -0700
Message-ID: <20230919214800.3803828-9-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919214800.3803828-1-andrii@kernel.org>
References: <20230919214800.3803828-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: F8TwJz8a7qtLaI9nOZrHpwOh_VDlOqan
X-Proofpoint-GUID: F8TwJz8a7qtLaI9nOZrHpwOh_VDlOqan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove remaining direct queries to perfmon_capable() and bpf_capable()
in BPF verifier logic and instead use BPF token (if available) to make
decisions about privileges.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h    | 16 ++++++++--------
 include/linux/filter.h |  2 +-
 kernel/bpf/arraymap.c  |  2 +-
 kernel/bpf/core.c      |  2 +-
 kernel/bpf/verifier.c  | 13 ++++++-------
 net/core/filter.c      |  4 ++--
 6 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 966581a9d9a0..d9e047f28d13 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2178,24 +2178,24 @@ extern int sysctl_unprivileged_bpf_disabled;
=20
 bool bpf_token_capable(const struct bpf_token *token, int cap);
=20
-static inline bool bpf_allow_ptr_leaks(void)
+static inline bool bpf_allow_ptr_leaks(const struct bpf_token *token)
 {
-	return perfmon_capable();
+	return bpf_token_capable(token, CAP_PERFMON);
 }
=20
-static inline bool bpf_allow_uninit_stack(void)
+static inline bool bpf_allow_uninit_stack(const struct bpf_token *token)
 {
-	return perfmon_capable();
+	return bpf_token_capable(token, CAP_PERFMON);
 }
=20
-static inline bool bpf_bypass_spec_v1(void)
+static inline bool bpf_bypass_spec_v1(const struct bpf_token *token)
 {
-	return perfmon_capable();
+	return bpf_token_capable(token, CAP_PERFMON);
 }
=20
-static inline bool bpf_bypass_spec_v4(void)
+static inline bool bpf_bypass_spec_v4(const struct bpf_token *token)
 {
-	return perfmon_capable();
+	return bpf_token_capable(token, CAP_PERFMON);
 }
=20
 int bpf_map_new_fd(struct bpf_map *map, int flags);
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 27406aee2d40..bab6d369677a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1145,7 +1145,7 @@ static inline bool bpf_jit_blinding_enabled(struct =
bpf_prog *prog)
 		return false;
 	if (!bpf_jit_harden)
 		return false;
-	if (bpf_jit_harden =3D=3D 1 && bpf_capable())
+	if (bpf_jit_harden =3D=3D 1 && bpf_token_capable(prog->aux->token, CAP_=
BPF))
 		return false;
=20
 	return true;
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 2058e89b5ddd..f0c64df6b6ff 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -82,7 +82,7 @@ static struct bpf_map *array_map_alloc(union bpf_attr *=
attr)
 	bool percpu =3D attr->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY;
 	int numa_node =3D bpf_map_attr_numa_node(attr);
 	u32 elem_size, index_mask, max_entries;
-	bool bypass_spec_v1 =3D bpf_bypass_spec_v1();
+	bool bypass_spec_v1 =3D bpf_bypass_spec_v1(NULL);
 	u64 array_size, mask64;
 	struct bpf_array *array;
=20
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index fc8de25b7948..ce307440fa8d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -675,7 +675,7 @@ static bool bpf_prog_kallsyms_candidate(const struct =
bpf_prog *fp)
 void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 {
 	if (!bpf_prog_kallsyms_candidate(fp) ||
-	    !bpf_capable())
+	    !bpf_token_capable(fp->aux->token, CAP_BPF))
 		return;
=20
 	bpf_prog_ksym_set_addr(fp);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 38f8718f1602..664d7e638f57 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20135,7 +20135,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
 	env->prog =3D *prog;
 	env->ops =3D bpf_verifier_ops[env->prog->type];
 	env->fd_array =3D make_bpfptr(attr->fd_array, uattr.is_kernel);
-	is_priv =3D bpf_capable();
+
+	env->allow_ptr_leaks =3D bpf_allow_ptr_leaks(env->prog->aux->token);
+	env->allow_uninit_stack =3D bpf_allow_uninit_stack(env->prog->aux->toke=
n);
+	env->bypass_spec_v1 =3D bpf_bypass_spec_v1(env->prog->aux->token);
+	env->bypass_spec_v4 =3D bpf_bypass_spec_v4(env->prog->aux->token);
+	env->bpf_capable =3D is_priv =3D bpf_token_capable(env->prog->aux->toke=
n, CAP_BPF);
=20
 	bpf_get_btf_vmlinux();
=20
@@ -20167,12 +20172,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
 	if (attr->prog_flags & BPF_F_ANY_ALIGNMENT)
 		env->strict_alignment =3D false;
=20
-	env->allow_ptr_leaks =3D bpf_allow_ptr_leaks();
-	env->allow_uninit_stack =3D bpf_allow_uninit_stack();
-	env->bypass_spec_v1 =3D bpf_bypass_spec_v1();
-	env->bypass_spec_v4 =3D bpf_bypass_spec_v4();
-	env->bpf_capable =3D bpf_capable();
-
 	if (is_priv)
 		env->test_state_freq =3D attr->prog_flags & BPF_F_TEST_STATE_FREQ;
=20
diff --git a/net/core/filter.c b/net/core/filter.c
index 6f0aa4095543..b4f4041541c3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8514,7 +8514,7 @@ static bool cg_skb_is_valid_access(int off, int siz=
e,
 		return false;
 	case bpf_ctx_range(struct __sk_buff, data):
 	case bpf_ctx_range(struct __sk_buff, data_end):
-		if (!bpf_capable())
+		if (!bpf_token_capable(prog->aux->token, CAP_BPF))
 			return false;
 		break;
 	}
@@ -8526,7 +8526,7 @@ static bool cg_skb_is_valid_access(int off, int siz=
e,
 		case bpf_ctx_range_till(struct __sk_buff, cb[0], cb[4]):
 			break;
 		case bpf_ctx_range(struct __sk_buff, tstamp):
-			if (!bpf_capable())
+			if (!bpf_token_capable(prog->aux->token, CAP_BPF))
 				return false;
 			break;
 		default:
--=20
2.34.1


