Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D41442390
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 23:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhKAWtL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 18:49:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45702 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhKAWtL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Nov 2021 18:49:11 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1GobZs005512
        for <bpf@vger.kernel.org>; Mon, 1 Nov 2021 15:46:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=YSGS1ORfMzkyGD9dWeEMqSZACMjxXEONOk6xA+x7o6E=;
 b=LmG/7UUOAp+v9y4lbkGpaazO/3/tb0vljyvS+ROlrmGpRDY+jV8Xb0wRMN8B5hQK7t3j
 WXrsr3AdB3fdATDvQSZUa2DX/O7cp1rUqRqLuAbEWRj1SOGBr9TWHhFTiWck9Lc00kZW
 I8wQJr4SP7lFUAfIxzY0rrDPV40VZ62hVZc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c2dp1n3xa-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 15:46:37 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 15:46:23 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 642968EEEAFB; Mon,  1 Nov 2021 15:44:01 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 2/4] bpftool: use bpf_obj_get_info_by_fd directly
Date:   Mon, 1 Nov 2021 15:43:55 -0700
Message-ID: <20211101224357.2651181-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211101224357.2651181-1-davemarchevsky@fb.com>
References: <20211101224357.2651181-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: T9lX6YyiC2zCNsh7QdMHZez5TTFt28Fm
X-Proofpoint-GUID: T9lX6YyiC2zCNsh7QdMHZez5TTFt28Fm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_07,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=682 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111010119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To prepare for impending deprecation of libbpf's
bpf_program__get_prog_info_linear, migrate uses of this function to use
bpf_obj_get_info_by_fd.

Since the profile_target_name and dump_prog_id_as_func_ptr helpers were
only looking at the first func_info, avoid grabbing the rest to save a
malloc. For do_dump, add a more full-featured helper, but avoid
free/realloc of buffer when possible for multi-prog dumps.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/bpf/bpftool/btf_dumper.c |  40 +++++----
 tools/bpf/bpftool/prog.c       | 158 ++++++++++++++++++++++++++-------
 2 files changed, 148 insertions(+), 50 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumpe=
r.c
index 6934e8634b94..f5dddf8ef404 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -32,14 +32,16 @@ static int dump_prog_id_as_func_ptr(const struct btf_=
dumper *d,
 				    const struct btf_type *func_proto,
 				    __u32 prog_id)
 {
-	struct bpf_prog_info_linear *prog_info =3D NULL;
 	const struct btf_type *func_type;
+	int prog_fd =3D -1, func_sig_len;
+	struct bpf_prog_info info =3D {};
+	__u32 info_len =3D sizeof(info);
 	const char *prog_name =3D NULL;
-	struct bpf_func_info *finfo;
 	struct btf *prog_btf =3D NULL;
-	struct bpf_prog_info *info;
-	int prog_fd, func_sig_len;
+	struct bpf_func_info finfo;
+	__u32 finfo_rec_size;
 	char prog_str[1024];
+	int err;
=20
 	/* Get the ptr's func_proto */
 	func_sig_len =3D btf_dump_func(d->btf, prog_str, func_proto, NULL, 0,
@@ -55,22 +57,27 @@ static int dump_prog_id_as_func_ptr(const struct btf_=
dumper *d,
 	if (prog_fd < 0)
 		goto print;
=20
-	prog_info =3D bpf_program__get_prog_info_linear(prog_fd,
-						1UL << BPF_PROG_INFO_FUNC_INFO);
-	close(prog_fd);
-	if (IS_ERR(prog_info)) {
-		prog_info =3D NULL;
+	err =3D bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	if (err)
 		goto print;
-	}
-	info =3D &prog_info->info;
=20
-	if (!info->btf_id || !info->nr_func_info)
+	if (!info.btf_id || !info.nr_func_info)
+		goto print;
+
+	finfo_rec_size =3D info.func_info_rec_size;
+	memset(&info, 0, sizeof(info));
+	info.nr_func_info =3D 1;
+	info.func_info_rec_size =3D finfo_rec_size;
+	info.func_info =3D ptr_to_u64(&finfo);
+
+	err =3D bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	if (err)
 		goto print;
-	prog_btf =3D btf__load_from_kernel_by_id(info->btf_id);
+
+	prog_btf =3D btf__load_from_kernel_by_id(info.btf_id);
 	if (libbpf_get_error(prog_btf))
 		goto print;
-	finfo =3D u64_to_ptr(info->func_info);
-	func_type =3D btf__type_by_id(prog_btf, finfo->type_id);
+	func_type =3D btf__type_by_id(prog_btf, finfo.type_id);
 	if (!func_type || !btf_is_func(func_type))
 		goto print;
=20
@@ -92,7 +99,8 @@ static int dump_prog_id_as_func_ptr(const struct btf_du=
mper *d,
 	prog_str[sizeof(prog_str) - 1] =3D '\0';
 	jsonw_string(d->jw, prog_str);
 	btf__free(prog_btf);
-	free(prog_info);
+	if (prog_fd >=3D 0)
+		close(prog_fd);
 	return 0;
 }
=20
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 515d22952602..0b6f1534d583 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -100,6 +100,76 @@ static enum bpf_attach_type parse_attach_type(const =
char *str)
 	return __MAX_BPF_ATTACH_TYPE;
 }
=20
+static int prep_prog_info(struct bpf_prog_info *const info, enum dump_mo=
de mode,
+			  void **info_data, size_t *const info_data_sz)
+{
+	struct bpf_prog_info holder =3D {};
+	size_t needed =3D 0;
+	void *ptr;
+
+	if (mode =3D=3D DUMP_JITED) {
+		holder.jited_prog_len =3D info->jited_prog_len;
+		needed +=3D info->jited_prog_len;
+	} else {
+		holder.xlated_prog_len =3D info->xlated_prog_len;
+		needed +=3D info->xlated_prog_len;
+	}
+
+	holder.nr_jited_ksyms =3D info->nr_jited_ksyms;
+	needed +=3D info->nr_jited_ksyms * sizeof(__u64);
+
+	holder.nr_jited_func_lens =3D info->nr_jited_func_lens;
+	needed +=3D info->nr_jited_func_lens * sizeof(__u32);
+
+	holder.nr_func_info =3D info->nr_func_info;
+	holder.func_info_rec_size =3D info->func_info_rec_size;
+	needed +=3D info->nr_func_info * info->func_info_rec_size;
+
+	holder.nr_line_info =3D info->nr_line_info;
+	holder.line_info_rec_size =3D info->line_info_rec_size;
+	needed +=3D info->nr_line_info * info->line_info_rec_size;
+
+	holder.nr_jited_line_info =3D info->nr_jited_line_info;
+	holder.jited_line_info_rec_size =3D info->jited_line_info_rec_size;
+	needed +=3D info->nr_jited_line_info * info->jited_line_info_rec_size;
+
+	if (needed > *info_data_sz) {
+		ptr =3D realloc(*info_data, needed);
+		if (!ptr)
+			return -1;
+
+		*info_data =3D ptr;
+		*info_data_sz =3D needed;
+	}
+	ptr =3D *info_data;
+
+	if (mode =3D=3D DUMP_JITED) {
+		holder.jited_prog_insns =3D ptr_to_u64(ptr);
+		ptr +=3D holder.jited_prog_len;
+	} else {
+		holder.xlated_prog_insns =3D ptr_to_u64(ptr);
+		ptr +=3D holder.xlated_prog_len;
+	}
+
+	holder.jited_ksyms =3D ptr_to_u64(ptr);
+	ptr +=3D holder.nr_jited_ksyms * sizeof(__u64);
+
+	holder.jited_func_lens =3D ptr_to_u64(ptr);
+	ptr +=3D holder.nr_jited_func_lens * sizeof(__u32);
+
+	holder.func_info =3D ptr_to_u64(ptr);
+	ptr +=3D holder.nr_func_info * holder.func_info_rec_size;
+
+	holder.line_info =3D ptr_to_u64(ptr);
+	ptr +=3D holder.nr_line_info * holder.line_info_rec_size;
+
+	holder.jited_line_info =3D ptr_to_u64(ptr);
+	ptr +=3D holder.nr_jited_line_info * holder.jited_line_info_rec_size;
+
+	*info =3D holder;
+	return 0;
+}
+
 static void print_boot_time(__u64 nsecs, char *buf, unsigned int size)
 {
 	struct timespec real_time_ts, boot_time_ts;
@@ -803,16 +873,18 @@ prog_dump(struct bpf_prog_info *info, enum dump_mod=
e mode,
=20
 static int do_dump(int argc, char **argv)
 {
-	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info info =3D {};
+	__u32 info_len =3D sizeof(info);
+	size_t info_data_sz =3D 0;
+	void *info_data =3D NULL;
 	char *filepath =3D NULL;
 	bool opcodes =3D false;
 	bool visual =3D false;
 	enum dump_mode mode;
 	bool linum =3D false;
-	int *fds =3D NULL;
 	int nb_fds, i =3D 0;
+	int *fds =3D NULL;
 	int err =3D -1;
-	__u64 arrays;
=20
 	if (is_prefix(*argv, "jited")) {
 		if (disasm_init())
@@ -872,46 +944,46 @@ static int do_dump(int argc, char **argv)
 		goto exit_close;
 	}
=20
-	if (mode =3D=3D DUMP_JITED)
-		arrays =3D 1UL << BPF_PROG_INFO_JITED_INSNS;
-	else
-		arrays =3D 1UL << BPF_PROG_INFO_XLATED_INSNS;
-
-	arrays |=3D 1UL << BPF_PROG_INFO_JITED_KSYMS;
-	arrays |=3D 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
-	arrays |=3D 1UL << BPF_PROG_INFO_FUNC_INFO;
-	arrays |=3D 1UL << BPF_PROG_INFO_LINE_INFO;
-	arrays |=3D 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
-
 	if (json_output && nb_fds > 1)
 		jsonw_start_array(json_wtr);	/* root array */
 	for (i =3D 0; i < nb_fds; i++) {
-		info_linear =3D bpf_program__get_prog_info_linear(fds[i], arrays);
-		if (IS_ERR_OR_NULL(info_linear)) {
+		err =3D bpf_obj_get_info_by_fd(fds[i], &info, &info_len);
+		if (err) {
+			p_err("can't get prog info: %s", strerror(errno));
+			break;
+		}
+
+		err =3D prep_prog_info(&info, mode, &info_data, &info_data_sz);
+		if (err) {
+			p_err("can't grow prog info_data");
+			break;
+		}
+
+		err =3D bpf_obj_get_info_by_fd(fds[i], &info, &info_len);
+		if (err) {
 			p_err("can't get prog info: %s", strerror(errno));
 			break;
 		}
=20
 		if (json_output && nb_fds > 1) {
 			jsonw_start_object(json_wtr);	/* prog object */
-			print_prog_header_json(&info_linear->info);
+			print_prog_header_json(&info);
 			jsonw_name(json_wtr, "insns");
 		} else if (nb_fds > 1) {
-			print_prog_header_plain(&info_linear->info);
+			print_prog_header_plain(&info);
 		}
=20
-		err =3D prog_dump(&info_linear->info, mode, filepath, opcodes,
-				visual, linum);
+		err =3D prog_dump(&info, mode, filepath, opcodes, visual, linum);
=20
 		if (json_output && nb_fds > 1)
 			jsonw_end_object(json_wtr);	/* prog object */
 		else if (i !=3D nb_fds - 1 && nb_fds > 1)
 			printf("\n");
=20
-		free(info_linear);
 		if (err)
 			break;
 		close(fds[i]);
+		memset(&info, 0, sizeof(info));
 	}
 	if (json_output && nb_fds > 1)
 		jsonw_end_array(json_wtr);	/* root array */
@@ -920,6 +992,7 @@ static int do_dump(int argc, char **argv)
 	for (; i < nb_fds; i++)
 		close(fds[i]);
 exit_free:
+	free(info_data);
 	free(fds);
 	return err;
 }
@@ -2016,41 +2089,58 @@ static void profile_print_readings(void)
=20
 static char *profile_target_name(int tgt_fd)
 {
-	struct bpf_prog_info_linear *info_linear;
-	struct bpf_func_info *func_info;
+	struct bpf_func_info func_info;
+	struct bpf_prog_info info =3D {};
+	__u32 info_len =3D sizeof(info);
 	const struct btf_type *t;
+	__u32 func_info_rec_size;
 	struct btf *btf =3D NULL;
 	char *name =3D NULL;
+	int err;
=20
-	info_linear =3D bpf_program__get_prog_info_linear(
-		tgt_fd, 1UL << BPF_PROG_INFO_FUNC_INFO);
-	if (IS_ERR_OR_NULL(info_linear)) {
-		p_err("failed to get info_linear for prog FD %d", tgt_fd);
-		return NULL;
+	err =3D bpf_obj_get_info_by_fd(tgt_fd, &info, &info_len);
+	if (err) {
+		p_err("failed to bpf_obj_get_info_by_fd for prog FD %d", tgt_fd);
+		goto out;
 	}
=20
-	if (info_linear->info.btf_id =3D=3D 0) {
+	if (info.btf_id =3D=3D 0) {
 		p_err("prog FD %d doesn't have valid btf", tgt_fd);
 		goto out;
 	}
=20
-	btf =3D btf__load_from_kernel_by_id(info_linear->info.btf_id);
+	func_info_rec_size =3D info.func_info_rec_size;
+	if (info.nr_func_info =3D=3D 0) {
+		p_err("bpf_obj_get_info_by_fd for prog FD %d found 0 func_info", tgt_f=
d);
+		goto out;
+	}
+
+	memset(&info, 0, sizeof(info));
+	info.nr_func_info =3D 1;
+	info.func_info_rec_size =3D func_info_rec_size;
+	info.func_info =3D ptr_to_u64(&func_info);
+
+	err =3D bpf_obj_get_info_by_fd(tgt_fd, &info, &info_len);
+	if (err) {
+		p_err("failed to get func_info for prog FD %d", tgt_fd);
+		goto out;
+	}
+
+	btf =3D btf__load_from_kernel_by_id(info.btf_id);
 	if (libbpf_get_error(btf)) {
 		p_err("failed to load btf for prog FD %d", tgt_fd);
 		goto out;
 	}
=20
-	func_info =3D u64_to_ptr(info_linear->info.func_info);
-	t =3D btf__type_by_id(btf, func_info[0].type_id);
+	t =3D btf__type_by_id(btf, func_info.type_id);
 	if (!t) {
 		p_err("btf %d doesn't have type %d",
-		      info_linear->info.btf_id, func_info[0].type_id);
+		      info.btf_id, func_info.type_id);
 		goto out;
 	}
 	name =3D strdup(btf__name_by_offset(btf, t->name_off));
 out:
 	btf__free(btf);
-	free(info_linear);
 	return name;
 }
=20
--=20
2.30.2

