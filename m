Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5125CB0E
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 22:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgICUhz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 16:37:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61888 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729532AbgICUf6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Sep 2020 16:35:58 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 083KWeVJ032202
        for <bpf@vger.kernel.org>; Thu, 3 Sep 2020 13:35:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=fe+0NLZeQepAV0FyiXPM+p5K2uHFBYyrk6bRFfW1isg=;
 b=K2nbK+FYrK3oU/RmtivBwsKVROmsZ/oC3mB0hudUEMkko0M1TKakKYkw7az5WYz2vPjE
 ci3QQqtBSo/60XMfeA1AVgGNrmW0FexnvQKNGuLURhAXCBYqdwObO4Lz8U8YGrMJWw9w
 4bUJoPEojqTOTeRT4JkfsfInUbuuHF1qZOk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 33b4crs71p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2020 13:35:56 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Sep 2020 13:35:55 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 3F2572EC6814; Thu,  3 Sep 2020 13:35:54 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH v3 bpf-next 05/14] libbpf: implement generalized .BTF.ext func/line info adjustment
Date:   Thu, 3 Sep 2020 13:35:33 -0700
Message-ID: <20200903203542.15944-6-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200903203542.15944-1-andriin@fb.com>
References: <20200903203542.15944-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_13:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=25 priorityscore=1501
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030183
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Complete multi-prog sections and multi sub-prog support in libbpf by prop=
erly
adjusting .BTF.ext's line and function information. Mark exposed
btf_ext__reloc_func_info() and btf_ext__reloc_func_info() APIs as depreca=
ted.
These APIs have simplistic assumption that all sub-programs are going to =
be
appended to all main BPF programs, which doesn't hold in real life. It's
unlikely there are any users of this API, as it's very libbpf
internals-specific.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf.h           |  18 +--
 tools/lib/bpf/libbpf.c        | 217 ++++++++++++++++++++++------------
 tools/lib/bpf/libbpf_common.h |   2 +
 3 files changed, 153 insertions(+), 84 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 91f0ad0e0325..2a55320d87d0 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -57,14 +57,16 @@ LIBBPF_API struct btf_ext *btf_ext__new(__u8 *data, _=
_u32 size);
 LIBBPF_API void btf_ext__free(struct btf_ext *btf_ext);
 LIBBPF_API const void *btf_ext__get_raw_data(const struct btf_ext *btf_e=
xt,
 					     __u32 *size);
-LIBBPF_API int btf_ext__reloc_func_info(const struct btf *btf,
-					const struct btf_ext *btf_ext,
-					const char *sec_name, __u32 insns_cnt,
-					void **func_info, __u32 *cnt);
-LIBBPF_API int btf_ext__reloc_line_info(const struct btf *btf,
-					const struct btf_ext *btf_ext,
-					const char *sec_name, __u32 insns_cnt,
-					void **line_info, __u32 *cnt);
+LIBBPF_API LIBBPF_DEPRECATED("btf_ext__reloc_func_info was never meant a=
s a public API and has wrong assumptions embedded in it; it will be remov=
ed in the future libbpf versions")
+int btf_ext__reloc_func_info(const struct btf *btf,
+			     const struct btf_ext *btf_ext,
+			     const char *sec_name, __u32 insns_cnt,
+			     void **func_info, __u32 *cnt);
+LIBBPF_API LIBBPF_DEPRECATED("btf_ext__reloc_line_info was never meant a=
s a public API and has wrong assumptions embedded in it; it will be remov=
ed in the future libbpf versions")
+int btf_ext__reloc_line_info(const struct btf *btf,
+			     const struct btf_ext *btf_ext,
+			     const char *sec_name, __u32 insns_cnt,
+			     void **line_info, __u32 *cnt);
 LIBBPF_API __u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_e=
xt);
 LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_e=
xt);
=20
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4e32a1028379..ca2b5c9145da 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4241,75 +4241,6 @@ bpf_object__create_maps(struct bpf_object *obj)
 	return err;
 }
=20
-static int
-check_btf_ext_reloc_err(struct bpf_program *prog, int err,
-			void *btf_prog_info, const char *info_name)
-{
-	if (err !=3D -ENOENT) {
-		pr_warn("Error in loading %s for sec %s.\n",
-			info_name, prog->section_name);
-		return err;
-	}
-
-	/* err =3D=3D -ENOENT (i.e. prog->section_name not found in btf_ext) */
-
-	if (btf_prog_info) {
-		/*
-		 * Some info has already been found but has problem
-		 * in the last btf_ext reloc. Must have to error out.
-		 */
-		pr_warn("Error in relocating %s for sec %s.\n",
-			info_name, prog->section_name);
-		return err;
-	}
-
-	/* Have problem loading the very first info. Ignore the rest. */
-	pr_warn("Cannot find %s for main program sec %s. Ignore all %s.\n",
-		info_name, prog->section_name, info_name);
-	return 0;
-}
-
-static int
-bpf_program_reloc_btf_ext(struct bpf_program *prog, struct bpf_object *o=
bj,
-			  const char *section_name,  __u32 insn_offset)
-{
-	int err;
-
-	if (!insn_offset || prog->func_info) {
-		/*
-		 * !insn_offset =3D> main program
-		 *
-		 * For sub prog, the main program's func_info has to
-		 * be loaded first (i.e. prog->func_info !=3D NULL)
-		 */
-		err =3D btf_ext__reloc_func_info(obj->btf, obj->btf_ext,
-					       section_name, insn_offset,
-					       &prog->func_info,
-					       &prog->func_info_cnt);
-		if (err)
-			return check_btf_ext_reloc_err(prog, err,
-						       prog->func_info,
-						       "bpf_func_info");
-
-		prog->func_info_rec_size =3D btf_ext__func_info_rec_size(obj->btf_ext)=
;
-	}
-
-	if (!insn_offset || prog->line_info) {
-		err =3D btf_ext__reloc_line_info(obj->btf, obj->btf_ext,
-					       section_name, insn_offset,
-					       &prog->line_info,
-					       &prog->line_info_cnt);
-		if (err)
-			return check_btf_ext_reloc_err(prog, err,
-						       prog->line_info,
-						       "bpf_line_info");
-
-		prog->line_info_rec_size =3D btf_ext__line_info_rec_size(obj->btf_ext)=
;
-	}
-
-	return 0;
-}
-
 #define BPF_CORE_SPEC_MAX_LEN 64
=20
 /* represents BPF CO-RE field or array element accessor */
@@ -5855,6 +5786,147 @@ bpf_object__relocate_data(struct bpf_object *obj,=
 struct bpf_program *prog)
 	return 0;
 }
=20
+static int adjust_prog_btf_ext_info(const struct bpf_object *obj,
+				    const struct bpf_program *prog,
+				    const struct btf_ext_info *ext_info,
+				    void **prog_info, __u32 *prog_rec_cnt,
+				    __u32 *prog_rec_sz)
+{
+	void *copy_start =3D NULL, *copy_end =3D NULL;
+	void *rec, *rec_end, *new_prog_info;
+	const struct btf_ext_info_sec *sec;
+	size_t old_sz, new_sz;
+	const char *sec_name;
+	int i, off_adj;
+
+	for_each_btf_ext_sec(ext_info, sec) {
+		sec_name =3D btf__name_by_offset(obj->btf, sec->sec_name_off);
+		if (!sec_name)
+			return -EINVAL;
+		if (strcmp(sec_name, prog->section_name) !=3D 0)
+			continue;
+
+		for_each_btf_ext_rec(ext_info, sec, i, rec) {
+			__u32 insn_off =3D *(__u32 *)rec / BPF_INSN_SZ;
+
+			if (insn_off < prog->sec_insn_off)
+				continue;
+			if (insn_off >=3D prog->sec_insn_off + prog->sec_insn_cnt)
+				break;
+
+			if (!copy_start)
+				copy_start =3D rec;
+			copy_end =3D rec + ext_info->rec_size;
+		}
+
+		if (!copy_start)
+			return -ENOENT;
+
+		/* append func/line info of a given (sub-)program to the main
+		 * program func/line info
+		 */
+		old_sz =3D (*prog_rec_cnt) * ext_info->rec_size;
+		new_sz =3D old_sz + (copy_end - copy_start);
+		new_prog_info =3D realloc(*prog_info, new_sz);
+		if (!new_prog_info)
+			return -ENOMEM;
+		*prog_info =3D new_prog_info;
+		*prog_rec_cnt =3D new_sz / ext_info->rec_size;
+		memcpy(new_prog_info + old_sz, copy_start, copy_end - copy_start);
+
+		/* Kernel instruction offsets are in units of 8-byte
+		 * instructions, while .BTF.ext instruction offsets generated
+		 * by Clang are in units of bytes. So convert Clang offsets
+		 * into kernel offsets and adjust offset according to program
+		 * relocated position.
+		 */
+		off_adj =3D prog->sub_insn_off - prog->sec_insn_off;
+		rec =3D new_prog_info + old_sz;
+		rec_end =3D new_prog_info + new_sz;
+		for (; rec < rec_end; rec +=3D ext_info->rec_size) {
+			__u32 *insn_off =3D rec;
+
+			*insn_off =3D *insn_off / BPF_INSN_SZ + off_adj;
+		}
+		*prog_rec_sz =3D ext_info->rec_size;
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int
+reloc_prog_func_and_line_info(const struct bpf_object *obj,
+			      struct bpf_program *main_prog,
+			      const struct bpf_program *prog)
+{
+	int err;
+
+	/* no .BTF.ext relocation if .BTF.ext is missing or kernel doesn't
+	 * supprot func/line info
+	 */
+	if (!obj->btf_ext || !kernel_supports(FEAT_BTF_FUNC))
+		return 0;
+
+	/* only attempt func info relocation if main program's func_info
+	 * relocation was successful
+	 */
+	if (main_prog !=3D prog && !main_prog->func_info)
+		goto line_info;
+
+	err =3D adjust_prog_btf_ext_info(obj, prog, &obj->btf_ext->func_info,
+				       &main_prog->func_info,
+				       &main_prog->func_info_cnt,
+				       &main_prog->func_info_rec_size);
+	if (err) {
+		if (err !=3D -ENOENT) {
+			pr_warn("prog '%s': error relocating .BTF.ext function info: %d\n",
+				prog->name, err);
+			return err;
+		}
+		if (main_prog->func_info) {
+			/*
+			 * Some info has already been found but has problem
+			 * in the last btf_ext reloc. Must have to error out.
+			 */
+			pr_warn("prog '%s': missing .BTF.ext function info.\n", prog->name);
+			return err;
+		}
+		/* Have problem loading the very first info. Ignore the rest. */
+		pr_warn("prog '%s': missing .BTF.ext function info for the main progra=
m, skipping all of .BTF.ext func info.\n",
+			prog->name);
+	}
+
+line_info:
+	/* don't relocate line info if main program's relocation failed */
+	if (main_prog !=3D prog && !main_prog->line_info)
+		return 0;
+
+	err =3D adjust_prog_btf_ext_info(obj, prog, &obj->btf_ext->line_info,
+				       &main_prog->line_info,
+				       &main_prog->line_info_cnt,
+				       &main_prog->line_info_rec_size);
+	if (err) {
+		if (err !=3D -ENOENT) {
+			pr_warn("prog '%s': error relocating .BTF.ext line info: %d\n",
+				prog->name, err);
+			return err;
+		}
+		if (main_prog->line_info) {
+			/*
+			 * Some info has already been found but has problem
+			 * in the last btf_ext reloc. Must have to error out.
+			 */
+			pr_warn("prog '%s': missing .BTF.ext line info.\n", prog->name);
+			return err;
+		}
+		/* Have problem loading the very first info. Ignore the rest. */
+		pr_warn("prog '%s': missing .BTF.ext line info for the main program, s=
kipping all of .BTF.ext line info.\n",
+			prog->name);
+	}
+	return 0;
+}
+
 static int cmp_relo_by_insn_idx(const void *key, const void *elem)
 {
 	size_t insn_idx =3D *(const size_t *)key;
@@ -6064,13 +6136,6 @@ bpf_object__relocate_calls(struct bpf_object *obj,=
 struct bpf_program *prog)
 	struct bpf_program *subprog;
 	int i, j, err;
=20
-	if (obj->btf_ext) {
-		err =3D bpf_program_reloc_btf_ext(prog, obj,
-						prog->section_name, 0);
-		if (err)
-			return err;
-	}
-
 	/* mark all subprogs as not relocated (yet) within the context of
 	 * current main program
 	 */
diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.=
h
index a23ae1ac27eb..947d8bd8a7bb 100644
--- a/tools/lib/bpf/libbpf_common.h
+++ b/tools/lib/bpf/libbpf_common.h
@@ -15,6 +15,8 @@
 #define LIBBPF_API __attribute__((visibility("default")))
 #endif
=20
+#define LIBBPF_DEPRECATED(msg) __attribute__((deprecated(msg)))
+
 /* Helper macro to declare and initialize libbpf options struct
  *
  * This dance with uninitialized declaration, followed by memset to zero=
,
--=20
2.24.1

