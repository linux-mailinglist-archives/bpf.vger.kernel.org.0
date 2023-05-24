Return-Path: <bpf+bounces-1189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1370FF98
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 23:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2496281440
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 21:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E782262E;
	Wed, 24 May 2023 21:03:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238D182A2
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 21:03:10 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5D6C1
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:03:05 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34OHhskq013226
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:03:05 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3qs8emy3t9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:03:04 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 14:03:02 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 7E04331486DAE; Wed, 24 May 2023 14:02:51 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH RFC bpf-next 3/3] libbpf: use new bpf_xxx_attr structs for bpf() commands
Date: Wed, 24 May 2023 14:02:43 -0700
Message-ID: <20230524210243.605832-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524210243.605832-1-andrii@kernel.org>
References: <20230524210243.605832-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Zd2_JkbaIENDB9hmUaUMEAViGQ82UarU
X-Proofpoint-GUID: Zd2_JkbaIENDB9hmUaUMEAViGQ82UarU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_15,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adapt libbpf code to new named bpf_attr substructs. The only exception
is skel_internal.h which is left as is to not harm users that might have
old system-wide bpf.h UAPI headers installed.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c             | 355 ++++++++++++++++----------------
 tools/lib/bpf/gen_loader.c      |  78 +++----
 tools/lib/bpf/libbpf.c          |   4 +-
 tools/lib/bpf/libbpf_internal.h |   2 +-
 4 files changed, 219 insertions(+), 220 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ed86b37d8024..ab69fb2a4b24 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -69,13 +69,13 @@ static inline __u64 ptr_to_u64(const void *ptr)
 	return (__u64) (unsigned long) ptr;
 }
=20
-static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
+static inline int sys_bpf(enum bpf_cmd cmd, void *attr,
 			  unsigned int size)
 {
 	return syscall(__NR_bpf, cmd, attr, size);
 }
=20
-static inline int sys_bpf_fd(enum bpf_cmd cmd, union bpf_attr *attr,
+static inline int sys_bpf_fd(enum bpf_cmd cmd, void *attr,
 			     unsigned int size)
 {
 	int fd;
@@ -84,7 +84,7 @@ static inline int sys_bpf_fd(enum bpf_cmd cmd, union bp=
f_attr *attr,
 	return ensure_good_fd(fd);
 }
=20
-int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attem=
pts)
+int sys_bpf_prog_load(struct bpf_prog_load_attr *attr, unsigned int size=
, int attempts)
 {
 	int fd;
=20
@@ -105,13 +105,13 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigne=
d int size, int attempts)
  */
 int probe_memcg_account(void)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, attach_btf_obj_fd)=
;
+	const size_t attr_sz =3D offsetofend(struct bpf_prog_load_attr, attach_=
btf_obj_fd);
 	struct bpf_insn insns[] =3D {
 		BPF_EMIT_CALL(BPF_FUNC_ktime_get_coarse_ns),
 		BPF_EXIT_INSN(),
 	};
 	size_t insn_cnt =3D ARRAY_SIZE(insns);
-	union bpf_attr attr;
+	struct bpf_prog_load_attr attr;
 	int prog_fd;
=20
 	/* attempt loading freplace trying to use custom BTF */
@@ -169,17 +169,16 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 max_entries,
 		   const struct bpf_map_create_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, map_extra);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_map_create_attr, map_ex=
tra);
+	struct bpf_map_create_attr attr;
 	int fd;
=20
-	bump_rlimit_memlock();
-
-	memset(&attr, 0, attr_sz);
-
 	if (!OPTS_VALID(opts, bpf_map_create_opts))
 		return libbpf_err(-EINVAL);
=20
+	bump_rlimit_memlock();
+
+	memset(&attr, 0, attr_sz);
 	attr.map_type =3D map_type;
 	if (map_name && kernel_supports(NULL, FEAT_PROG_NAME))
 		libbpf_strlcpy(attr.map_name, map_name, sizeof(attr.map_name));
@@ -232,20 +231,20 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 		  const struct bpf_insn *insns, size_t insn_cnt,
 		  struct bpf_prog_load_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, log_true_size);
+	const size_t attr_sz =3D offsetofend(struct bpf_prog_load_attr, log_tru=
e_size);
 	void *finfo =3D NULL, *linfo =3D NULL;
 	const char *func_info, *line_info;
 	__u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
 	__u32 func_info_rec_size, line_info_rec_size;
 	int fd, attempts;
-	union bpf_attr attr;
+	struct bpf_prog_load_attr attr;
 	char *log_buf;
=20
-	bump_rlimit_memlock();
-
 	if (!OPTS_VALID(opts, bpf_prog_load_opts))
 		return libbpf_err(-EINVAL);
=20
+	bump_rlimit_memlock();
+
 	attempts =3D OPTS_GET(opts, attempts, 0);
 	if (attempts < 0)
 		return libbpf_err(-EINVAL);
@@ -380,8 +379,8 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
 int bpf_map_update_elem(int fd, const void *key, const void *value,
 			__u64 flags)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_map_elem_attr, flags);
+	struct bpf_map_elem_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
@@ -396,8 +395,8 @@ int bpf_map_update_elem(int fd, const void *key, cons=
t void *value,
=20
 int bpf_map_lookup_elem(int fd, const void *key, void *value)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_map_elem_attr, flags);
+	struct bpf_map_elem_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
@@ -411,8 +410,8 @@ int bpf_map_lookup_elem(int fd, const void *key, void=
 *value)
=20
 int bpf_map_lookup_elem_flags(int fd, const void *key, void *value, __u6=
4 flags)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_map_elem_attr, flags);
+	struct bpf_map_elem_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
@@ -427,8 +426,8 @@ int bpf_map_lookup_elem_flags(int fd, const void *key=
, void *value, __u64 flags)
=20
 int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_map_elem_attr, flags);
+	struct bpf_map_elem_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
@@ -442,8 +441,8 @@ int bpf_map_lookup_and_delete_elem(int fd, const void=
 *key, void *value)
=20
 int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *=
value, __u64 flags)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_map_elem_attr, flags);
+	struct bpf_map_elem_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
@@ -458,8 +457,8 @@ int bpf_map_lookup_and_delete_elem_flags(int fd, cons=
t void *key, void *value, _
=20
 int bpf_map_delete_elem(int fd, const void *key)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_map_elem_attr, flags);
+	struct bpf_map_elem_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
@@ -472,8 +471,8 @@ int bpf_map_delete_elem(int fd, const void *key)
=20
 int bpf_map_delete_elem_flags(int fd, const void *key, __u64 flags)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, flags);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_map_elem_attr, flags);
+	struct bpf_map_elem_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
@@ -487,8 +486,8 @@ int bpf_map_delete_elem_flags(int fd, const void *key=
, __u64 flags)
=20
 int bpf_map_get_next_key(int fd, const void *key, void *next_key)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, next_key);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_map_next_key_attr, next=
_key);
+	struct bpf_map_next_key_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
@@ -502,8 +501,8 @@ int bpf_map_get_next_key(int fd, const void *key, voi=
d *next_key)
=20
 int bpf_map_freeze(int fd)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, map_fd);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_map_freeze_attr, map_fd=
);
+	struct bpf_map_freeze_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
@@ -518,25 +517,25 @@ static int bpf_map_batch_common(int cmd, int fd, vo=
id  *in_batch,
 				__u32 *count,
 				const struct bpf_map_batch_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, batch);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_map_batch_attr, flags);
+	struct bpf_map_batch_attr attr;
 	int ret;
=20
 	if (!OPTS_VALID(opts, bpf_map_batch_opts))
 		return libbpf_err(-EINVAL);
=20
 	memset(&attr, 0, attr_sz);
-	attr.batch.map_fd =3D fd;
-	attr.batch.in_batch =3D ptr_to_u64(in_batch);
-	attr.batch.out_batch =3D ptr_to_u64(out_batch);
-	attr.batch.keys =3D ptr_to_u64(keys);
-	attr.batch.values =3D ptr_to_u64(values);
-	attr.batch.count =3D *count;
-	attr.batch.elem_flags  =3D OPTS_GET(opts, elem_flags, 0);
-	attr.batch.flags =3D OPTS_GET(opts, flags, 0);
+	attr.map_fd =3D fd;
+	attr.in_batch =3D ptr_to_u64(in_batch);
+	attr.out_batch =3D ptr_to_u64(out_batch);
+	attr.keys =3D ptr_to_u64(keys);
+	attr.values =3D ptr_to_u64(values);
+	attr.count =3D *count;
+	attr.elem_flags  =3D OPTS_GET(opts, elem_flags, 0);
+	attr.flags =3D OPTS_GET(opts, flags, 0);
=20
 	ret =3D sys_bpf(cmd, &attr, attr_sz);
-	*count =3D attr.batch.count;
+	*count =3D attr.count;
=20
 	return libbpf_err_errno(ret);
 }
@@ -574,8 +573,8 @@ int bpf_map_update_batch(int fd, const void *keys, co=
nst void *values, __u32 *co
=20
 int bpf_obj_pin_opts(int fd, const char *pathname, const struct bpf_obj_=
pin_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, path_fd);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_obj_pin_attr, path_fd);
+	struct bpf_obj_pin_attr attr;
 	int ret;
=20
 	if (!OPTS_VALID(opts, bpf_obj_pin_opts))
@@ -584,7 +583,7 @@ int bpf_obj_pin_opts(int fd, const char *pathname, co=
nst struct bpf_obj_pin_opts
 	memset(&attr, 0, attr_sz);
 	attr.path_fd =3D OPTS_GET(opts, path_fd, 0);
 	attr.pathname =3D ptr_to_u64((void *)pathname);
-	attr.file_flags =3D OPTS_GET(opts, file_flags, 0);
+	attr.flags =3D OPTS_GET(opts, file_flags, 0);
 	attr.bpf_fd =3D fd;
=20
 	ret =3D sys_bpf(BPF_OBJ_PIN, &attr, attr_sz);
@@ -603,8 +602,8 @@ int bpf_obj_get(const char *pathname)
=20
 int bpf_obj_get_opts(const char *pathname, const struct bpf_obj_get_opts=
 *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, path_fd);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_obj_get_attr, path_fd);
+	struct bpf_obj_get_attr attr;
 	int fd;
=20
 	if (!OPTS_VALID(opts, bpf_obj_get_opts))
@@ -613,7 +612,7 @@ int bpf_obj_get_opts(const char *pathname, const stru=
ct bpf_obj_get_opts *opts)
 	memset(&attr, 0, attr_sz);
 	attr.path_fd =3D OPTS_GET(opts, path_fd, 0);
 	attr.pathname =3D ptr_to_u64((void *)pathname);
-	attr.file_flags =3D OPTS_GET(opts, file_flags, 0);
+	attr.flags =3D OPTS_GET(opts, file_flags, 0);
=20
 	fd =3D sys_bpf_fd(BPF_OBJ_GET, &attr, attr_sz);
 	return libbpf_err_errno(fd);
@@ -633,8 +632,8 @@ int bpf_prog_attach_opts(int prog_fd, int target_fd,
 			  enum bpf_attach_type type,
 			  const struct bpf_prog_attach_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, replace_bpf_fd);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_prog_attach_attr, repla=
ce_bpf_fd);
+	struct bpf_prog_attach_attr attr;
 	int ret;
=20
 	if (!OPTS_VALID(opts, bpf_prog_attach_opts))
@@ -653,8 +652,8 @@ int bpf_prog_attach_opts(int prog_fd, int target_fd,
=20
 int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, replace_bpf_fd);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_prog_detach_attr, attac=
h_type);
+	struct bpf_prog_detach_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
@@ -667,13 +666,13 @@ int bpf_prog_detach(int target_fd, enum bpf_attach_=
type type)
=20
 int bpf_prog_detach2(int prog_fd, int target_fd, enum bpf_attach_type ty=
pe)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, replace_bpf_fd);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_prog_detach_attr, attac=
h_type);
+	struct bpf_prog_detach_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
-	attr.target_fd	 =3D target_fd;
-	attr.attach_bpf_fd =3D prog_fd;
+	attr.target_fd  =3D target_fd;
+	attr.prog_fd =3D prog_fd;
 	attr.attach_type =3D type;
=20
 	ret =3D sys_bpf(BPF_PROG_DETACH, &attr, attr_sz);
@@ -684,9 +683,9 @@ int bpf_link_create(int prog_fd, int target_fd,
 		    enum bpf_attach_type attach_type,
 		    const struct bpf_link_create_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, link_create);
+	const size_t attr_sz =3D sizeof(struct bpf_link_create_attr);
 	__u32 target_btf_id, iter_info_len;
-	union bpf_attr attr;
+	struct bpf_link_create_attr attr;
 	int fd, err;
=20
 	if (!OPTS_VALID(opts, bpf_link_create_opts))
@@ -704,32 +703,32 @@ int bpf_link_create(int prog_fd, int target_fd,
 	}
=20
 	memset(&attr, 0, attr_sz);
-	attr.link_create.prog_fd =3D prog_fd;
-	attr.link_create.target_fd =3D target_fd;
-	attr.link_create.attach_type =3D attach_type;
-	attr.link_create.flags =3D OPTS_GET(opts, flags, 0);
+	attr.prog_fd =3D prog_fd;
+	attr.target_fd =3D target_fd;
+	attr.attach_type =3D attach_type;
+	attr.flags =3D OPTS_GET(opts, flags, 0);
=20
 	if (target_btf_id) {
-		attr.link_create.target_btf_id =3D target_btf_id;
+		attr.target_btf_id =3D target_btf_id;
 		goto proceed;
 	}
=20
 	switch (attach_type) {
 	case BPF_TRACE_ITER:
-		attr.link_create.iter_info =3D ptr_to_u64(OPTS_GET(opts, iter_info, (v=
oid *)0));
-		attr.link_create.iter_info_len =3D iter_info_len;
+		attr.iter_info =3D ptr_to_u64(OPTS_GET(opts, iter_info, (void *)0));
+		attr.iter_info_len =3D iter_info_len;
 		break;
 	case BPF_PERF_EVENT:
-		attr.link_create.perf_event.bpf_cookie =3D OPTS_GET(opts, perf_event.b=
pf_cookie, 0);
+		attr.perf_event.bpf_cookie =3D OPTS_GET(opts, perf_event.bpf_cookie, 0=
);
 		if (!OPTS_ZEROED(opts, perf_event))
 			return libbpf_err(-EINVAL);
 		break;
 	case BPF_TRACE_KPROBE_MULTI:
-		attr.link_create.kprobe_multi.flags =3D OPTS_GET(opts, kprobe_multi.fl=
ags, 0);
-		attr.link_create.kprobe_multi.cnt =3D OPTS_GET(opts, kprobe_multi.cnt,=
 0);
-		attr.link_create.kprobe_multi.syms =3D ptr_to_u64(OPTS_GET(opts, kprob=
e_multi.syms, 0));
-		attr.link_create.kprobe_multi.addrs =3D ptr_to_u64(OPTS_GET(opts, kpro=
be_multi.addrs, 0));
-		attr.link_create.kprobe_multi.cookies =3D ptr_to_u64(OPTS_GET(opts, kp=
robe_multi.cookies, 0));
+		attr.kprobe_multi.flags =3D OPTS_GET(opts, kprobe_multi.flags, 0);
+		attr.kprobe_multi.cnt =3D OPTS_GET(opts, kprobe_multi.cnt, 0);
+		attr.kprobe_multi.syms =3D ptr_to_u64(OPTS_GET(opts, kprobe_multi.syms=
, 0));
+		attr.kprobe_multi.addrs =3D ptr_to_u64(OPTS_GET(opts, kprobe_multi.add=
rs, 0));
+		attr.kprobe_multi.cookies =3D ptr_to_u64(OPTS_GET(opts, kprobe_multi.c=
ookies, 0));
 		if (!OPTS_ZEROED(opts, kprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
@@ -737,7 +736,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
 	case BPF_LSM_MAC:
-		attr.link_create.tracing.cookie =3D OPTS_GET(opts, tracing.cookie, 0);
+		attr.tracing.cookie =3D OPTS_GET(opts, tracing.cookie, 0);
 		if (!OPTS_ZEROED(opts, tracing))
 			return libbpf_err(-EINVAL);
 		break;
@@ -760,7 +759,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	/* if user used features not supported by
 	 * BPF_RAW_TRACEPOINT_OPEN command, then just give up immediately
 	 */
-	if (attr.link_create.target_fd || attr.link_create.target_btf_id)
+	if (attr.target_fd || attr.target_btf_id)
 		return libbpf_err(err);
 	if (!OPTS_ZEROED(opts, sz))
 		return libbpf_err(err);
@@ -783,12 +782,12 @@ int bpf_link_create(int prog_fd, int target_fd,
=20
 int bpf_link_detach(int link_fd)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, link_detach);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_link_detach_attr, link_=
fd);
+	struct bpf_link_detach_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
-	attr.link_detach.link_fd =3D link_fd;
+	attr.link_fd =3D link_fd;
=20
 	ret =3D sys_bpf(BPF_LINK_DETACH, &attr, attr_sz);
 	return libbpf_err_errno(ret);
@@ -797,8 +796,8 @@ int bpf_link_detach(int link_fd)
 int bpf_link_update(int link_fd, int new_prog_fd,
 		    const struct bpf_link_update_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, link_update);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_link_update_attr, old_p=
rog_fd);
+	struct bpf_link_update_attr attr;
 	int ret;
=20
 	if (!OPTS_VALID(opts, bpf_link_update_opts))
@@ -808,13 +807,13 @@ int bpf_link_update(int link_fd, int new_prog_fd,
 		return libbpf_err(-EINVAL);
=20
 	memset(&attr, 0, attr_sz);
-	attr.link_update.link_fd =3D link_fd;
-	attr.link_update.new_prog_fd =3D new_prog_fd;
-	attr.link_update.flags =3D OPTS_GET(opts, flags, 0);
+	attr.link_fd =3D link_fd;
+	attr.new_prog_fd =3D new_prog_fd;
+	attr.flags =3D OPTS_GET(opts, flags, 0);
 	if (OPTS_GET(opts, old_prog_fd, 0))
-		attr.link_update.old_prog_fd =3D OPTS_GET(opts, old_prog_fd, 0);
+		attr.old_prog_fd =3D OPTS_GET(opts, old_prog_fd, 0);
 	else if (OPTS_GET(opts, old_map_fd, 0))
-		attr.link_update.old_map_fd =3D OPTS_GET(opts, old_map_fd, 0);
+		attr.old_map_fd =3D OPTS_GET(opts, old_map_fd, 0);
=20
 	ret =3D sys_bpf(BPF_LINK_UPDATE, &attr, attr_sz);
 	return libbpf_err_errno(ret);
@@ -822,12 +821,12 @@ int bpf_link_update(int link_fd, int new_prog_fd,
=20
 int bpf_iter_create(int link_fd)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, iter_create);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_iter_create_attr, flags=
);
+	struct bpf_iter_create_attr attr;
 	int fd;
=20
 	memset(&attr, 0, attr_sz);
-	attr.iter_create.link_fd =3D link_fd;
+	attr.link_fd =3D link_fd;
=20
 	fd =3D sys_bpf_fd(BPF_ITER_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
@@ -837,8 +836,8 @@ int bpf_prog_query_opts(int target_fd,
 			enum bpf_attach_type type,
 			struct bpf_prog_query_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, query);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_prog_query_attr, prog_a=
ttach_flags);
+	struct bpf_prog_query_attr attr;
 	int ret;
=20
 	if (!OPTS_VALID(opts, bpf_prog_query_opts))
@@ -846,17 +845,17 @@ int bpf_prog_query_opts(int target_fd,
=20
 	memset(&attr, 0, attr_sz);
=20
-	attr.query.target_fd	=3D target_fd;
-	attr.query.attach_type	=3D type;
-	attr.query.query_flags	=3D OPTS_GET(opts, query_flags, 0);
-	attr.query.prog_cnt	=3D OPTS_GET(opts, prog_cnt, 0);
-	attr.query.prog_ids	=3D ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
-	attr.query.prog_attach_flags =3D ptr_to_u64(OPTS_GET(opts, prog_attach_=
flags, NULL));
+	attr.target_fd	=3D target_fd;
+	attr.attach_type	=3D type;
+	attr.query_flags	=3D OPTS_GET(opts, query_flags, 0);
+	attr.prog_cnt	=3D OPTS_GET(opts, prog_cnt, 0);
+	attr.prog_ids	=3D ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
+	attr.prog_attach_flags =3D ptr_to_u64(OPTS_GET(opts, prog_attach_flags,=
 NULL));
=20
 	ret =3D sys_bpf(BPF_PROG_QUERY, &attr, attr_sz);
=20
-	OPTS_SET(opts, attach_flags, attr.query.attach_flags);
-	OPTS_SET(opts, prog_cnt, attr.query.prog_cnt);
+	OPTS_SET(opts, attach_flags, attr.attach_flags);
+	OPTS_SET(opts, prog_cnt, attr.prog_cnt);
=20
 	return libbpf_err_errno(ret);
 }
@@ -882,43 +881,43 @@ int bpf_prog_query(int target_fd, enum bpf_attach_t=
ype type, __u32 query_flags,
=20
 int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, test);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_prog_run_attr, batch_si=
ze);
+	struct bpf_prog_run_attr attr;
 	int ret;
=20
 	if (!OPTS_VALID(opts, bpf_test_run_opts))
 		return libbpf_err(-EINVAL);
=20
 	memset(&attr, 0, attr_sz);
-	attr.test.prog_fd =3D prog_fd;
-	attr.test.batch_size =3D OPTS_GET(opts, batch_size, 0);
-	attr.test.cpu =3D OPTS_GET(opts, cpu, 0);
-	attr.test.flags =3D OPTS_GET(opts, flags, 0);
-	attr.test.repeat =3D OPTS_GET(opts, repeat, 0);
-	attr.test.duration =3D OPTS_GET(opts, duration, 0);
-	attr.test.ctx_size_in =3D OPTS_GET(opts, ctx_size_in, 0);
-	attr.test.ctx_size_out =3D OPTS_GET(opts, ctx_size_out, 0);
-	attr.test.data_size_in =3D OPTS_GET(opts, data_size_in, 0);
-	attr.test.data_size_out =3D OPTS_GET(opts, data_size_out, 0);
-	attr.test.ctx_in =3D ptr_to_u64(OPTS_GET(opts, ctx_in, NULL));
-	attr.test.ctx_out =3D ptr_to_u64(OPTS_GET(opts, ctx_out, NULL));
-	attr.test.data_in =3D ptr_to_u64(OPTS_GET(opts, data_in, NULL));
-	attr.test.data_out =3D ptr_to_u64(OPTS_GET(opts, data_out, NULL));
+	attr.prog_fd =3D prog_fd;
+	attr.batch_size =3D OPTS_GET(opts, batch_size, 0);
+	attr.cpu =3D OPTS_GET(opts, cpu, 0);
+	attr.flags =3D OPTS_GET(opts, flags, 0);
+	attr.repeat =3D OPTS_GET(opts, repeat, 0);
+	attr.duration =3D OPTS_GET(opts, duration, 0);
+	attr.ctx_size_in =3D OPTS_GET(opts, ctx_size_in, 0);
+	attr.ctx_size_out =3D OPTS_GET(opts, ctx_size_out, 0);
+	attr.data_size_in =3D OPTS_GET(opts, data_size_in, 0);
+	attr.data_size_out =3D OPTS_GET(opts, data_size_out, 0);
+	attr.ctx_in =3D ptr_to_u64(OPTS_GET(opts, ctx_in, NULL));
+	attr.ctx_out =3D ptr_to_u64(OPTS_GET(opts, ctx_out, NULL));
+	attr.data_in =3D ptr_to_u64(OPTS_GET(opts, data_in, NULL));
+	attr.data_out =3D ptr_to_u64(OPTS_GET(opts, data_out, NULL));
=20
 	ret =3D sys_bpf(BPF_PROG_TEST_RUN, &attr, attr_sz);
=20
-	OPTS_SET(opts, data_size_out, attr.test.data_size_out);
-	OPTS_SET(opts, ctx_size_out, attr.test.ctx_size_out);
-	OPTS_SET(opts, duration, attr.test.duration);
-	OPTS_SET(opts, retval, attr.test.retval);
+	OPTS_SET(opts, data_size_out, attr.data_size_out);
+	OPTS_SET(opts, ctx_size_out, attr.ctx_size_out);
+	OPTS_SET(opts, duration, attr.duration);
+	OPTS_SET(opts, retval, attr.retval);
=20
 	return libbpf_err_errno(ret);
 }
=20
 static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, open_flags);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_obj_next_id_attr, next_=
id);
+	struct bpf_obj_next_id_attr attr;
 	int err;
=20
 	memset(&attr, 0, attr_sz);
@@ -954,16 +953,16 @@ int bpf_link_get_next_id(__u32 start_id, __u32 *nex=
t_id)
 int bpf_prog_get_fd_by_id_opts(__u32 id,
 			       const struct bpf_get_fd_by_id_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, open_flags);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_obj_fd_by_id_attr, flag=
s);
+	struct bpf_obj_fd_by_id_attr attr;
 	int fd;
=20
 	if (!OPTS_VALID(opts, bpf_get_fd_by_id_opts))
 		return libbpf_err(-EINVAL);
=20
 	memset(&attr, 0, attr_sz);
-	attr.prog_id =3D id;
-	attr.open_flags =3D OPTS_GET(opts, open_flags, 0);
+	attr.obj_id =3D id;
+	attr.flags =3D OPTS_GET(opts, open_flags, 0);
=20
 	fd =3D sys_bpf_fd(BPF_PROG_GET_FD_BY_ID, &attr, attr_sz);
 	return libbpf_err_errno(fd);
@@ -977,16 +976,16 @@ int bpf_prog_get_fd_by_id(__u32 id)
 int bpf_map_get_fd_by_id_opts(__u32 id,
 			      const struct bpf_get_fd_by_id_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, open_flags);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_obj_fd_by_id_attr, flag=
s);
+	struct bpf_obj_fd_by_id_attr attr;
 	int fd;
=20
 	if (!OPTS_VALID(opts, bpf_get_fd_by_id_opts))
 		return libbpf_err(-EINVAL);
=20
 	memset(&attr, 0, attr_sz);
-	attr.map_id =3D id;
-	attr.open_flags =3D OPTS_GET(opts, open_flags, 0);
+	attr.obj_id =3D id;
+	attr.flags =3D OPTS_GET(opts, open_flags, 0);
=20
 	fd =3D sys_bpf_fd(BPF_MAP_GET_FD_BY_ID, &attr, attr_sz);
 	return libbpf_err_errno(fd);
@@ -1000,16 +999,16 @@ int bpf_map_get_fd_by_id(__u32 id)
 int bpf_btf_get_fd_by_id_opts(__u32 id,
 			      const struct bpf_get_fd_by_id_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, open_flags);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_obj_fd_by_id_attr, flag=
s);
+	struct bpf_obj_fd_by_id_attr attr;
 	int fd;
=20
 	if (!OPTS_VALID(opts, bpf_get_fd_by_id_opts))
 		return libbpf_err(-EINVAL);
=20
 	memset(&attr, 0, attr_sz);
-	attr.btf_id =3D id;
-	attr.open_flags =3D OPTS_GET(opts, open_flags, 0);
+	attr.obj_id =3D id;
+	attr.flags =3D OPTS_GET(opts, open_flags, 0);
=20
 	fd =3D sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, attr_sz);
 	return libbpf_err_errno(fd);
@@ -1023,16 +1022,16 @@ int bpf_btf_get_fd_by_id(__u32 id)
 int bpf_link_get_fd_by_id_opts(__u32 id,
 			       const struct bpf_get_fd_by_id_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, open_flags);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_obj_fd_by_id_attr, flag=
s);
+	struct bpf_obj_fd_by_id_attr attr;
 	int fd;
=20
 	if (!OPTS_VALID(opts, bpf_get_fd_by_id_opts))
 		return libbpf_err(-EINVAL);
=20
 	memset(&attr, 0, attr_sz);
-	attr.link_id =3D id;
-	attr.open_flags =3D OPTS_GET(opts, open_flags, 0);
+	attr.obj_id =3D id;
+	attr.flags =3D OPTS_GET(opts, open_flags, 0);
=20
 	fd =3D sys_bpf_fd(BPF_LINK_GET_FD_BY_ID, &attr, attr_sz);
 	return libbpf_err_errno(fd);
@@ -1045,18 +1044,18 @@ int bpf_link_get_fd_by_id(__u32 id)
=20
 int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, info);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_obj_info_by_fd_attr, in=
fo);
+	struct bpf_obj_info_by_fd_attr attr;
 	int err;
=20
 	memset(&attr, 0, attr_sz);
-	attr.info.bpf_fd =3D bpf_fd;
-	attr.info.info_len =3D *info_len;
-	attr.info.info =3D ptr_to_u64(info);
+	attr.bpf_fd =3D bpf_fd;
+	attr.info_len =3D *info_len;
+	attr.info =3D ptr_to_u64(info);
=20
 	err =3D sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, attr_sz);
 	if (!err)
-		*info_len =3D attr.info.info_len;
+		*info_len =3D attr.info_len;
 	return libbpf_err_errno(err);
 }
=20
@@ -1082,13 +1081,13 @@ int bpf_link_get_info_by_fd(int link_fd, struct b=
pf_link_info *info, __u32 *info
=20
 int bpf_raw_tracepoint_open(const char *name, int prog_fd)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, raw_tracepoint);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_raw_tp_open_attr, prog_=
fd);
+	struct bpf_raw_tp_open_attr attr;
 	int fd;
=20
 	memset(&attr, 0, attr_sz);
-	attr.raw_tracepoint.name =3D ptr_to_u64(name);
-	attr.raw_tracepoint.prog_fd =3D prog_fd;
+	attr.name =3D ptr_to_u64(name);
+	attr.prog_fd =3D prog_fd;
=20
 	fd =3D sys_bpf_fd(BPF_RAW_TRACEPOINT_OPEN, &attr, attr_sz);
 	return libbpf_err_errno(fd);
@@ -1096,20 +1095,20 @@ int bpf_raw_tracepoint_open(const char *name, int=
 prog_fd)
=20
 int bpf_btf_load(const void *btf_data, size_t btf_size, struct bpf_btf_l=
oad_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, btf_log_true_size)=
;
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_btf_load_attr, log_true=
_size);
+	struct bpf_btf_load_attr attr;
 	char *log_buf;
 	size_t log_size;
 	__u32 log_level;
 	int fd;
=20
+	if (!OPTS_VALID(opts, bpf_btf_load_opts))
+		return libbpf_err(-EINVAL);
+
 	bump_rlimit_memlock();
=20
 	memset(&attr, 0, attr_sz);
=20
-	if (!OPTS_VALID(opts, bpf_btf_load_opts))
-		return libbpf_err(-EINVAL);
-
 	log_buf =3D OPTS_GET(opts, log_buf, NULL);
 	log_size =3D OPTS_GET(opts, log_size, 0);
 	log_level =3D OPTS_GET(opts, log_level, 0);
@@ -1127,20 +1126,20 @@ int bpf_btf_load(const void *btf_data, size_t btf=
_size, struct bpf_btf_load_opts
 	 * APIs within libbpf and provides a sensible behavior in practice
 	 */
 	if (log_level) {
-		attr.btf_log_buf =3D ptr_to_u64(log_buf);
-		attr.btf_log_size =3D (__u32)log_size;
-		attr.btf_log_level =3D log_level;
+		attr.log_buf =3D ptr_to_u64(log_buf);
+		attr.log_size =3D (__u32)log_size;
+		attr.log_level =3D log_level;
 	}
=20
 	fd =3D sys_bpf_fd(BPF_BTF_LOAD, &attr, attr_sz);
 	if (fd < 0 && log_buf && log_level =3D=3D 0) {
-		attr.btf_log_buf =3D ptr_to_u64(log_buf);
-		attr.btf_log_size =3D (__u32)log_size;
-		attr.btf_log_level =3D 1;
+		attr.log_buf =3D ptr_to_u64(log_buf);
+		attr.log_size =3D (__u32)log_size;
+		attr.log_level =3D 1;
 		fd =3D sys_bpf_fd(BPF_BTF_LOAD, &attr, attr_sz);
 	}
=20
-	OPTS_SET(opts, log_true_size, attr.btf_log_true_size);
+	OPTS_SET(opts, log_true_size, attr.log_true_size);
 	return libbpf_err_errno(fd);
 }
=20
@@ -1148,36 +1147,36 @@ int bpf_task_fd_query(int pid, int fd, __u32 flag=
s, char *buf, __u32 *buf_len,
 		      __u32 *prog_id, __u32 *fd_type, __u64 *probe_offset,
 		      __u64 *probe_addr)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, task_fd_query);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_task_fd_query_attr, pro=
be_addr);
+	struct bpf_task_fd_query_attr attr;
 	int err;
=20
 	memset(&attr, 0, attr_sz);
-	attr.task_fd_query.pid =3D pid;
-	attr.task_fd_query.fd =3D fd;
-	attr.task_fd_query.flags =3D flags;
-	attr.task_fd_query.buf =3D ptr_to_u64(buf);
-	attr.task_fd_query.buf_len =3D *buf_len;
+	attr.pid =3D pid;
+	attr.fd =3D fd;
+	attr.flags =3D flags;
+	attr.buf =3D ptr_to_u64(buf);
+	attr.buf_len =3D *buf_len;
=20
 	err =3D sys_bpf(BPF_TASK_FD_QUERY, &attr, attr_sz);
=20
-	*buf_len =3D attr.task_fd_query.buf_len;
-	*prog_id =3D attr.task_fd_query.prog_id;
-	*fd_type =3D attr.task_fd_query.fd_type;
-	*probe_offset =3D attr.task_fd_query.probe_offset;
-	*probe_addr =3D attr.task_fd_query.probe_addr;
+	*buf_len =3D attr.buf_len;
+	*prog_id =3D attr.prog_id;
+	*fd_type =3D attr.fd_type;
+	*probe_offset =3D attr.probe_offset;
+	*probe_addr =3D attr.probe_addr;
=20
 	return libbpf_err_errno(err);
 }
=20
 int bpf_enable_stats(enum bpf_stats_type type)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, enable_stats);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_enable_stats_attr, type=
);
+	struct bpf_enable_stats_attr attr;
 	int fd;
=20
 	memset(&attr, 0, attr_sz);
-	attr.enable_stats.type =3D type;
+	attr.type =3D type;
=20
 	fd =3D sys_bpf_fd(BPF_ENABLE_STATS, &attr, attr_sz);
 	return libbpf_err_errno(fd);
@@ -1186,17 +1185,17 @@ int bpf_enable_stats(enum bpf_stats_type type)
 int bpf_prog_bind_map(int prog_fd, int map_fd,
 		      const struct bpf_prog_bind_opts *opts)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, prog_bind_map);
-	union bpf_attr attr;
+	const size_t attr_sz =3D offsetofend(struct bpf_prog_bind_map_attr, fla=
gs);
+	struct bpf_prog_bind_map_attr attr;
 	int ret;
=20
 	if (!OPTS_VALID(opts, bpf_prog_bind_opts))
 		return libbpf_err(-EINVAL);
=20
 	memset(&attr, 0, attr_sz);
-	attr.prog_bind_map.prog_fd =3D prog_fd;
-	attr.prog_bind_map.map_fd =3D map_fd;
-	attr.prog_bind_map.flags =3D OPTS_GET(opts, flags, 0);
+	attr.prog_fd =3D prog_fd;
+	attr.map_fd =3D map_fd;
+	attr.flags =3D OPTS_GET(opts, flags, 0);
=20
 	ret =3D sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
 	return libbpf_err_errno(ret);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index cf3323fd47b8..f6c540fb6250 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -417,9 +417,9 @@ void bpf_gen__free(struct bpf_gen *gen)
 void bpf_gen__load_btf(struct bpf_gen *gen, const void *btf_raw_data,
 		       __u32 btf_raw_size)
 {
-	int attr_size =3D offsetofend(union bpf_attr, btf_log_level);
+	int attr_size =3D offsetofend(struct bpf_btf_load_attr, log_level);
 	int btf_data, btf_load_attr;
-	union bpf_attr attr;
+	struct bpf_btf_load_attr attr;
=20
 	memset(&attr, 0, attr_size);
 	pr_debug("gen: load_btf: size %d\n", btf_raw_size);
@@ -429,14 +429,14 @@ void bpf_gen__load_btf(struct bpf_gen *gen, const v=
oid *btf_raw_data,
 	btf_load_attr =3D add_data(gen, &attr, attr_size);
=20
 	/* populate union bpf_attr with user provided log details */
-	move_ctx2blob(gen, attr_field(btf_load_attr, btf_log_level), 4,
+	move_ctx2blob(gen, attr_field(btf_load_attr, btf_load.log_level), 4,
 		      offsetof(struct bpf_loader_ctx, log_level), false);
-	move_ctx2blob(gen, attr_field(btf_load_attr, btf_log_size), 4,
+	move_ctx2blob(gen, attr_field(btf_load_attr, btf_load.log_size), 4,
 		      offsetof(struct bpf_loader_ctx, log_size), false);
-	move_ctx2blob(gen, attr_field(btf_load_attr, btf_log_buf), 8,
+	move_ctx2blob(gen, attr_field(btf_load_attr, btf_load.log_buf), 8,
 		      offsetof(struct bpf_loader_ctx, log_buf), false);
 	/* populate union bpf_attr with a pointer to the BTF data */
-	emit_rel_store(gen, attr_field(btf_load_attr, btf), btf_data);
+	emit_rel_store(gen, attr_field(btf_load_attr, btf_load.btf), btf_data);
 	/* emit BTF_LOAD command */
 	emit_sys_bpf(gen, BPF_BTF_LOAD, btf_load_attr, attr_size);
 	debug_ret(gen, "btf_load size %d", btf_raw_size);
@@ -451,10 +451,10 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 			 __u32 key_size, __u32 value_size, __u32 max_entries,
 			 struct bpf_map_create_opts *map_attr, int map_idx)
 {
-	int attr_size =3D offsetofend(union bpf_attr, map_extra);
+	int attr_size =3D offsetofend(struct bpf_map_create_attr, map_extra);
 	bool close_inner_map_fd =3D false;
 	int map_create_attr, idx;
-	union bpf_attr attr;
+	struct bpf_map_create_attr attr;
=20
 	memset(&attr, 0, attr_size);
 	attr.map_type =3D map_type;
@@ -476,12 +476,12 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 	map_create_attr =3D add_data(gen, &attr, attr_size);
 	if (attr.btf_value_type_id)
 		/* populate union bpf_attr with btf_fd saved in the stack earlier */
-		move_stack2blob(gen, attr_field(map_create_attr, btf_fd), 4,
+		move_stack2blob(gen, attr_field(map_create_attr, map_create.btf_fd), 4=
,
 				stack_off(btf_fd));
 	switch (attr.map_type) {
 	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
 	case BPF_MAP_TYPE_HASH_OF_MAPS:
-		move_stack2blob(gen, attr_field(map_create_attr, inner_map_fd), 4,
+		move_stack2blob(gen, attr_field(map_create_attr, map_create.inner_map_=
fd), 4,
 				stack_off(inner_map_fd));
 		close_inner_map_fd =3D true;
 		break;
@@ -490,7 +490,7 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 	}
 	/* conditionally update max_entries */
 	if (map_idx >=3D 0)
-		move_ctx2blob(gen, attr_field(map_create_attr, max_entries), 4,
+		move_ctx2blob(gen, attr_field(map_create_attr, map_create.max_entries)=
, 4,
 			      sizeof(struct bpf_loader_ctx) +
 			      sizeof(struct bpf_map_desc) * map_idx +
 			      offsetof(struct bpf_map_desc, max_entries),
@@ -937,8 +937,8 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 			struct bpf_prog_load_opts *load_attr, int prog_idx)
 {
 	int prog_load_attr, license_off, insns_off, func_info, line_info, core_=
relos;
-	int attr_size =3D offsetofend(union bpf_attr, core_relo_rec_size);
-	union bpf_attr attr;
+	int attr_size =3D offsetofend(struct bpf_prog_load_attr, core_relo_rec_=
size);
+	struct bpf_prog_load_attr attr;
=20
 	memset(&attr, 0, attr_size);
 	pr_debug("gen: prog_load: type %d insns_cnt %zd progi_idx %d\n",
@@ -975,32 +975,32 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	prog_load_attr =3D add_data(gen, &attr, attr_size);
=20
 	/* populate union bpf_attr with a pointer to license */
-	emit_rel_store(gen, attr_field(prog_load_attr, license), license_off);
+	emit_rel_store(gen, attr_field(prog_load_attr, prog_load.license), lice=
nse_off);
=20
 	/* populate union bpf_attr with a pointer to instructions */
-	emit_rel_store(gen, attr_field(prog_load_attr, insns), insns_off);
+	emit_rel_store(gen, attr_field(prog_load_attr, prog_load.insns), insns_=
off);
=20
 	/* populate union bpf_attr with a pointer to func_info */
-	emit_rel_store(gen, attr_field(prog_load_attr, func_info), func_info);
+	emit_rel_store(gen, attr_field(prog_load_attr, prog_load.func_info), fu=
nc_info);
=20
 	/* populate union bpf_attr with a pointer to line_info */
-	emit_rel_store(gen, attr_field(prog_load_attr, line_info), line_info);
+	emit_rel_store(gen, attr_field(prog_load_attr, prog_load.line_info), li=
ne_info);
=20
 	/* populate union bpf_attr with a pointer to core_relos */
-	emit_rel_store(gen, attr_field(prog_load_attr, core_relos), core_relos)=
;
+	emit_rel_store(gen, attr_field(prog_load_attr, prog_load.core_relos), c=
ore_relos);
=20
 	/* populate union bpf_attr fd_array with a pointer to data where map_fd=
s are saved */
-	emit_rel_store(gen, attr_field(prog_load_attr, fd_array), gen->fd_array=
);
+	emit_rel_store(gen, attr_field(prog_load_attr, prog_load.fd_array), gen=
->fd_array);
=20
 	/* populate union bpf_attr with user provided log details */
-	move_ctx2blob(gen, attr_field(prog_load_attr, log_level), 4,
+	move_ctx2blob(gen, attr_field(prog_load_attr, prog_load.log_level), 4,
 		      offsetof(struct bpf_loader_ctx, log_level), false);
-	move_ctx2blob(gen, attr_field(prog_load_attr, log_size), 4,
+	move_ctx2blob(gen, attr_field(prog_load_attr, prog_load.log_size), 4,
 		      offsetof(struct bpf_loader_ctx, log_size), false);
-	move_ctx2blob(gen, attr_field(prog_load_attr, log_buf), 8,
+	move_ctx2blob(gen, attr_field(prog_load_attr, prog_load.log_buf), 8,
 		      offsetof(struct bpf_loader_ctx, log_buf), false);
 	/* populate union bpf_attr with btf_fd saved in the stack earlier */
-	move_stack2blob(gen, attr_field(prog_load_attr, prog_btf_fd), 4,
+	move_stack2blob(gen, attr_field(prog_load_attr, prog_load.prog_btf_fd),=
 4,
 			stack_off(btf_fd));
 	if (gen->attach_kind) {
 		emit_find_attach_target(gen);
@@ -1008,10 +1008,10 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
 						 0, 0, 0, prog_load_attr));
 		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7,
-				      offsetof(union bpf_attr, attach_btf_id)));
+				      offsetof(union bpf_attr, prog_load.attach_btf_id)));
 		emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_7, 32));
 		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7,
-				      offsetof(union bpf_attr, attach_btf_obj_fd)));
+				      offsetof(union bpf_attr, prog_load.attach_btf_obj_fd)));
 	}
 	emit_relos(gen, insns_off);
 	/* emit PROG_LOAD command */
@@ -1021,7 +1021,7 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	cleanup_relos(gen, insns_off);
 	if (gen->attach_kind) {
 		emit_sys_close_blob(gen,
-				    attr_field(prog_load_attr, attach_btf_obj_fd));
+				    attr_field(prog_load_attr, prog_load.attach_btf_obj_fd));
 		gen->attach_kind =3D 0;
 	}
 	emit_check_err(gen);
@@ -1034,9 +1034,9 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pv=
alue,
 			      __u32 value_size)
 {
-	int attr_size =3D offsetofend(union bpf_attr, flags);
+	int attr_size =3D offsetofend(struct bpf_map_elem_attr, flags);
 	int map_update_attr, value, key;
-	union bpf_attr attr;
+	struct bpf_map_elem_attr attr;
 	int zero =3D 0;
=20
 	memset(&attr, 0, attr_size);
@@ -1068,10 +1068,10 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen=
, int map_idx, void *pvalue,
 	emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
=20
 	map_update_attr =3D add_data(gen, &attr, attr_size);
-	move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
+	move_blob2blob(gen, attr_field(map_update_attr, map_elem.map_fd), 4,
 		       blob_fd_array_off(gen, map_idx));
-	emit_rel_store(gen, attr_field(map_update_attr, key), key);
-	emit_rel_store(gen, attr_field(map_update_attr, value), value);
+	emit_rel_store(gen, attr_field(map_update_attr, map_elem.key), key);
+	emit_rel_store(gen, attr_field(map_update_attr, map_elem.value), value)=
;
 	/* emit MAP_UPDATE_ELEM command */
 	emit_sys_bpf(gen, BPF_MAP_UPDATE_ELEM, map_update_attr, attr_size);
 	debug_ret(gen, "update_elem idx %d value_size %d", map_idx, value_size)=
;
@@ -1081,9 +1081,9 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, =
int map_idx, void *pvalue,
 void bpf_gen__populate_outer_map(struct bpf_gen *gen, int outer_map_idx,=
 int slot,
 				 int inner_map_idx)
 {
-	int attr_size =3D offsetofend(union bpf_attr, flags);
+	int attr_size =3D offsetofend(struct bpf_map_elem_attr, flags);
 	int map_update_attr, key;
-	union bpf_attr attr;
+	struct bpf_map_elem_attr attr;
=20
 	memset(&attr, 0, attr_size);
 	pr_debug("gen: populate_outer_map: outer %d key %d inner %d\n",
@@ -1092,10 +1092,10 @@ void bpf_gen__populate_outer_map(struct bpf_gen *=
gen, int outer_map_idx, int slo
 	key =3D add_data(gen, &slot, sizeof(slot));
=20
 	map_update_attr =3D add_data(gen, &attr, attr_size);
-	move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
+	move_blob2blob(gen, attr_field(map_update_attr, map_elem.map_fd), 4,
 		       blob_fd_array_off(gen, outer_map_idx));
-	emit_rel_store(gen, attr_field(map_update_attr, key), key);
-	emit_rel_store(gen, attr_field(map_update_attr, value),
+	emit_rel_store(gen, attr_field(map_update_attr, map_elem.key), key);
+	emit_rel_store(gen, attr_field(map_update_attr, map_elem.value),
 		       blob_fd_array_off(gen, inner_map_idx));
=20
 	/* emit MAP_UPDATE_ELEM command */
@@ -1107,14 +1107,14 @@ void bpf_gen__populate_outer_map(struct bpf_gen *=
gen, int outer_map_idx, int slo
=20
 void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx)
 {
-	int attr_size =3D offsetofend(union bpf_attr, map_fd);
+	int attr_size =3D offsetofend(struct bpf_map_freeze_attr, map_fd);
 	int map_freeze_attr;
-	union bpf_attr attr;
+	struct bpf_map_freeze_attr attr;
=20
 	memset(&attr, 0, attr_size);
 	pr_debug("gen: map_freeze: idx %d\n", map_idx);
 	map_freeze_attr =3D add_data(gen, &attr, attr_size);
-	move_blob2blob(gen, attr_field(map_freeze_attr, map_fd), 4,
+	move_blob2blob(gen, attr_field(map_freeze_attr, map_freeze.map_fd), 4,
 		       blob_fd_array_off(gen, map_idx));
 	/* emit MAP_FREEZE command */
 	emit_sys_bpf(gen, BPF_MAP_FREEZE, map_freeze_attr, attr_size);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5cca00979aae..113dbe9cb240 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4525,12 +4525,12 @@ static int probe_fd(int fd)
=20
 static int probe_kern_prog_name(void)
 {
-	const size_t attr_sz =3D offsetofend(union bpf_attr, prog_name);
+	const size_t attr_sz =3D offsetofend(struct bpf_prog_load_attr, prog_na=
me);
 	struct bpf_insn insns[] =3D {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	};
-	union bpf_attr attr;
+	struct bpf_prog_load_attr attr;
 	int ret;
=20
 	memset(&attr, 0, attr_sz);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index e4d05662a96c..9a809c610f36 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -575,6 +575,6 @@ static inline bool is_pow_of_2(size_t x)
 }
=20
 #define PROG_LOAD_ATTEMPTS 5
-int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attem=
pts);
+int sys_bpf_prog_load(struct bpf_prog_load_attr *attr, unsigned int size=
, int attempts);
=20
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
--=20
2.34.1


