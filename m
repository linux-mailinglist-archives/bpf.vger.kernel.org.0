Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8468E4709E7
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 20:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343536AbhLJTNv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 14:13:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57052 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233988AbhLJTNv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 14:13:51 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAE9aHg014713
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 11:10:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=z5cXmI0VAAc+RDmnfOKdnICs7WQMjWnfmXTS98SuXZQ=;
 b=WrJRLZ99v8Biy9PlbyWgUZZo6iE1H/HV07To10egdw/O2G033iBcaZs3paFxv90k5nWd
 Vt9TrVc96sgLHX2Iq27F+7aiT6hh5SA+G6eNR2/CIubx/KrPf3PSC5piOxtsyMBFXc5w
 ZBlzCu+WloYbnyHaPwxbyU3NxYjbMn89OwI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cv41wby36-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 11:10:14 -0800
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 11:09:52 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 72DF4F0FC23; Fri, 10 Dec 2021 11:09:50 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <ast@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 1/4] selftests/bpf: Stop using bpf_object__find_program_by_title API.
Date:   Fri, 10 Dec 2021 11:08:53 -0800
Message-ID: <20211210190855.1369060-2-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210190855.1369060-1-kuifeng@fb.com>
References: <20211210190855.1369060-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 2EnzIe1jtjCDGfI-fVagBE81uZOETsEh
X-Proofpoint-ORIG-GUID: 2EnzIe1jtjCDGfI-fVagBE81uZOETsEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112100105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_object__find_program_by_title is going to be deprecated.  Replace
all use cases in tools/testing/selftests/bpf with
bpf_object__find_program_by_name.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_obj_id.c     |  4 +-
 .../bpf/prog_tests/connect_force_port.c       | 18 ++---
 .../selftests/bpf/prog_tests/core_reloc.c     | 79 +++++++++++++------
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 46 +++++------
 .../bpf/prog_tests/get_stack_raw_tp.c         |  4 +-
 .../bpf/prog_tests/sockopt_inherit.c          | 15 ++--
 .../selftests/bpf/prog_tests/stacktrace_map.c |  4 +-
 .../bpf/prog_tests/stacktrace_map_raw_tp.c    |  4 +-
 .../selftests/bpf/prog_tests/test_overhead.c  | 20 ++---
 .../bpf/prog_tests/trampoline_count.c         |  6 +-
 10 files changed, 112 insertions(+), 88 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_obj_id.c
index 0a6c5f00abd4..dbe56fa8582d 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
@@ -65,8 +65,8 @@ void serial_test_bpf_obj_id(void)
 		if (CHECK_FAIL(err))
 			goto done;
=20
-		prog =3D bpf_object__find_program_by_title(objs[i],
-							 "raw_tp/sys_enter");
+		prog =3D bpf_object__find_program_by_name(objs[i],
+							"test_obj_id");
 		if (CHECK_FAIL(!prog))
 			goto done;
 		links[i] =3D bpf_program__attach(prog);
diff --git a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c =
b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
index ca574e1e30e6..9c4325f4aef2 100644
--- a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
+++ b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
@@ -67,9 +67,9 @@ static int run_test(int cgroup_fd, int server_fd, int f=
amily, int type)
 		goto close_bpf_object;
 	}
=20
-	prog =3D bpf_object__find_program_by_title(obj, v4 ?
-						 "cgroup/connect4" :
-						 "cgroup/connect6");
+	prog =3D bpf_object__find_program_by_name(obj, v4 ?
+						"connect4" :
+						"connect6");
 	if (CHECK(!prog, "find_prog", "connect prog not found\n")) {
 		err =3D -EIO;
 		goto close_bpf_object;
@@ -83,9 +83,9 @@ static int run_test(int cgroup_fd, int server_fd, int f=
amily, int type)
 		goto close_bpf_object;
 	}
=20
-	prog =3D bpf_object__find_program_by_title(obj, v4 ?
-						 "cgroup/getpeername4" :
-						 "cgroup/getpeername6");
+	prog =3D bpf_object__find_program_by_name(obj, v4 ?
+						"getpeername4" :
+						"getpeername6");
 	if (CHECK(!prog, "find_prog", "getpeername prog not found\n")) {
 		err =3D -EIO;
 		goto close_bpf_object;
@@ -99,9 +99,9 @@ static int run_test(int cgroup_fd, int server_fd, int f=
amily, int type)
 		goto close_bpf_object;
 	}
=20
-	prog =3D bpf_object__find_program_by_title(obj, v4 ?
-						 "cgroup/getsockname4" :
-						 "cgroup/getsockname6");
+	prog =3D bpf_object__find_program_by_name(obj, v4 ?
+						"getsockname4" :
+						"getsockname6");
 	if (CHECK(!prog, "find_prog", "getsockname prog not found\n")) {
 		err =3D -EIO;
 		goto close_bpf_object;
diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/=
testing/selftests/bpf/prog_tests/core_reloc.c
index 44a9868c70ea..1283339b85a8 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -10,7 +10,7 @@ static int duration =3D 0;
=20
 #define STRUCT_TO_CHAR_PTR(struct_name) (const char *)&(struct struct_na=
me)
=20
-#define MODULES_CASE(name, sec_name, tp_name) {				\
+#define MODULES_CASE(name, prog_name, tp_name) {			\
 	.case_name =3D name,						\
 	.bpf_obj_file =3D "test_core_reloc_module.o",			\
 	.btf_src_file =3D NULL, /* find in kernel module BTFs */		\
@@ -28,7 +28,7 @@ static int duration =3D 0;
 		.comm_len =3D sizeof("test_progs"),			\
 	},								\
 	.output_len =3D sizeof(struct core_reloc_module_output),		\
-	.prog_sec_name =3D sec_name,					\
+	.prog_name =3D prog_name,						\
 	.raw_tp_name =3D tp_name,						\
 	.trigger =3D __trigger_module_test_read,				\
 	.needs_testmod =3D true,						\
@@ -43,7 +43,9 @@ static int duration =3D 0;
 #define FLAVORS_CASE_COMMON(name)					\
 	.case_name =3D #name,						\
 	.bpf_obj_file =3D "test_core_reloc_flavors.o",			\
-	.btf_src_file =3D "btf__core_reloc_" #name ".o"			\
+	.btf_src_file =3D "btf__core_reloc_" #name ".o",			\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_flavors"				\
=20
 #define FLAVORS_CASE(name) {						\
 	FLAVORS_CASE_COMMON(name),					\
@@ -66,7 +68,9 @@ static int duration =3D 0;
 #define NESTING_CASE_COMMON(name)					\
 	.case_name =3D #name,						\
 	.bpf_obj_file =3D "test_core_reloc_nesting.o",			\
-	.btf_src_file =3D "btf__core_reloc_" #name ".o"
+	.btf_src_file =3D "btf__core_reloc_" #name ".o",			\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_nesting"				\
=20
 #define NESTING_CASE(name) {						\
 	NESTING_CASE_COMMON(name),					\
@@ -91,7 +95,9 @@ static int duration =3D 0;
 #define ARRAYS_CASE_COMMON(name)					\
 	.case_name =3D #name,						\
 	.bpf_obj_file =3D "test_core_reloc_arrays.o",			\
-	.btf_src_file =3D "btf__core_reloc_" #name ".o"
+	.btf_src_file =3D "btf__core_reloc_" #name ".o",			\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_arrays"					\
=20
 #define ARRAYS_CASE(name) {						\
 	ARRAYS_CASE_COMMON(name),					\
@@ -123,7 +129,9 @@ static int duration =3D 0;
 #define PRIMITIVES_CASE_COMMON(name)					\
 	.case_name =3D #name,						\
 	.bpf_obj_file =3D "test_core_reloc_primitives.o",			\
-	.btf_src_file =3D "btf__core_reloc_" #name ".o"
+	.btf_src_file =3D "btf__core_reloc_" #name ".o",			\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_primitives"				\
=20
 #define PRIMITIVES_CASE(name) {						\
 	PRIMITIVES_CASE_COMMON(name),					\
@@ -158,6 +166,8 @@ static int duration =3D 0;
 		.e =3D 5, .f =3D 6, .g =3D 7, .h =3D 8,				\
 	},								\
 	.output_len =3D sizeof(struct core_reloc_mods_output),		\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_mods",					\
 }
=20
 #define PTR_AS_ARR_CASE(name) {						\
@@ -174,6 +184,8 @@ static int duration =3D 0;
 		.a =3D 3,							\
 	},								\
 	.output_len =3D sizeof(struct core_reloc_ptr_as_arr),		\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_ptr_as_arr",				\
 }
=20
 #define INTS_DATA(struct_name) STRUCT_TO_CHAR_PTR(struct_name) {	\
@@ -190,7 +202,9 @@ static int duration =3D 0;
 #define INTS_CASE_COMMON(name)						\
 	.case_name =3D #name,						\
 	.bpf_obj_file =3D "test_core_reloc_ints.o",			\
-	.btf_src_file =3D "btf__core_reloc_" #name ".o"
+	.btf_src_file =3D "btf__core_reloc_" #name ".o",			\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_ints"
=20
 #define INTS_CASE(name) {						\
 	INTS_CASE_COMMON(name),						\
@@ -208,7 +222,9 @@ static int duration =3D 0;
 #define FIELD_EXISTS_CASE_COMMON(name)					\
 	.case_name =3D #name,						\
 	.bpf_obj_file =3D "test_core_reloc_existence.o",			\
-	.btf_src_file =3D "btf__core_reloc_" #name ".o"			\
+	.btf_src_file =3D "btf__core_reloc_" #name ".o",			\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_existence"
=20
 #define BITFIELDS_CASE_COMMON(objfile, test_name_prefix,  name)		\
 	.case_name =3D test_name_prefix#name,				\
@@ -223,6 +239,8 @@ static int duration =3D 0;
 	.output =3D STRUCT_TO_CHAR_PTR(core_reloc_bitfields_output)	\
 		__VA_ARGS__,						\
 	.output_len =3D sizeof(struct core_reloc_bitfields_output),	\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_bitfields",				\
 }, {									\
 	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_direct.o",	\
 			      "direct:", name),				\
@@ -231,7 +249,7 @@ static int duration =3D 0;
 	.output =3D STRUCT_TO_CHAR_PTR(core_reloc_bitfields_output)	\
 		__VA_ARGS__,						\
 	.output_len =3D sizeof(struct core_reloc_bitfields_output),	\
-	.prog_sec_name =3D "tp_btf/sys_enter",				\
+	.prog_name =3D "test_core_bitfields_direct",			\
 }
=20
=20
@@ -239,17 +257,21 @@ static int duration =3D 0;
 	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_probed.o",	\
 			      "probed:", name),				\
 	.fails =3D true,							\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_bitfields",				\
 }, {									\
 	BITFIELDS_CASE_COMMON("test_core_reloc_bitfields_direct.o",	\
 			      "direct:", name),				\
-	.prog_sec_name =3D "tp_btf/sys_enter",				\
 	.fails =3D true,							\
+	.prog_name =3D "test_core_bitfields_direct",			\
 }
=20
 #define SIZE_CASE_COMMON(name)						\
 	.case_name =3D #name,						\
 	.bpf_obj_file =3D "test_core_reloc_size.o",			\
-	.btf_src_file =3D "btf__core_reloc_" #name ".o"
+	.btf_src_file =3D "btf__core_reloc_" #name ".o",			\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_size"
=20
 #define SIZE_OUTPUT_DATA(type)						\
 	STRUCT_TO_CHAR_PTR(core_reloc_size_output) {			\
@@ -277,8 +299,10 @@ static int duration =3D 0;
=20
 #define TYPE_BASED_CASE_COMMON(name)					\
 	.case_name =3D #name,						\
-	.bpf_obj_file =3D "test_core_reloc_type_based.o",		\
-	.btf_src_file =3D "btf__core_reloc_" #name ".o"			\
+	.bpf_obj_file =3D "test_core_reloc_type_based.o",			\
+	.btf_src_file =3D "btf__core_reloc_" #name ".o",			\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_type_based"
=20
 #define TYPE_BASED_CASE(name, ...) {					\
 	TYPE_BASED_CASE_COMMON(name),					\
@@ -295,7 +319,9 @@ static int duration =3D 0;
 #define TYPE_ID_CASE_COMMON(name)					\
 	.case_name =3D #name,						\
 	.bpf_obj_file =3D "test_core_reloc_type_id.o",			\
-	.btf_src_file =3D "btf__core_reloc_" #name ".o"			\
+	.btf_src_file =3D "btf__core_reloc_" #name ".o",			\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_type_id"
=20
 #define TYPE_ID_CASE(name, setup_fn) {					\
 	TYPE_ID_CASE_COMMON(name),					\
@@ -312,7 +338,9 @@ static int duration =3D 0;
 #define ENUMVAL_CASE_COMMON(name)					\
 	.case_name =3D #name,						\
 	.bpf_obj_file =3D "test_core_reloc_enumval.o",			\
-	.btf_src_file =3D "btf__core_reloc_" #name ".o"			\
+	.btf_src_file =3D "btf__core_reloc_" #name ".o",			\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_enumval"
=20
 #define ENUMVAL_CASE(name, ...) {					\
 	ENUMVAL_CASE_COMMON(name),					\
@@ -342,7 +370,7 @@ struct core_reloc_test_case {
 	bool fails;
 	bool needs_testmod;
 	bool relaxed_core_relocs;
-	const char *prog_sec_name;
+	const char *prog_name;
 	const char *raw_tp_name;
 	setup_test_fn setup;
 	trigger_test_fn trigger;
@@ -497,11 +525,13 @@ static struct core_reloc_test_case test_cases[] =3D=
 {
 			.comm_len =3D sizeof("test_progs"),
 		},
 		.output_len =3D sizeof(struct core_reloc_kernel_output),
+		.raw_tp_name =3D "sys_enter",
+		.prog_name =3D "test_core_kernel",
 	},
=20
 	/* validate we can find kernel module BTF types for relocs/attach */
-	MODULES_CASE("module_probed", "raw_tp/bpf_testmod_test_read", "bpf_test=
mod_test_read"),
-	MODULES_CASE("module_direct", "tp_btf/bpf_testmod_test_read", NULL),
+	MODULES_CASE("module_probed", "test_core_module_probed", "bpf_testmod_t=
est_read"),
+	MODULES_CASE("module_direct", "test_core_module_direct", NULL),
=20
 	/* validate BPF program can use multiple flavors to match against
 	 * single target BTF type
@@ -580,6 +610,8 @@ static struct core_reloc_test_case test_cases[] =3D {
 			.c =3D 0, /* BUG in clang, should be 3 */
 		},
 		.output_len =3D sizeof(struct core_reloc_misc_output),
+		.raw_tp_name =3D "sys_enter",
+		.prog_name =3D "test_core_misc",
 	},
=20
 	/* validate field existence checks */
@@ -848,14 +880,9 @@ void test_core_reloc(void)
 		if (!ASSERT_OK_PTR(obj, "obj_open"))
 			goto cleanup;
=20
-		probe_name =3D "raw_tracepoint/sys_enter";
-		tp_name =3D "sys_enter";
-		if (test_case->prog_sec_name) {
-			probe_name =3D test_case->prog_sec_name;
-			tp_name =3D test_case->raw_tp_name; /* NULL for tp_btf */
-		}
-
-		prog =3D bpf_object__find_program_by_title(obj, probe_name);
+		probe_name =3D test_case->prog_name;
+		tp_name =3D test_case->raw_tp_name; /* NULL for tp_btf */
+		prog =3D bpf_object__find_program_by_name(obj, probe_name);
 		if (CHECK(!prog, "find_probe",
 			  "prog '%s' not found\n", probe_name))
 			goto cleanup;
diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index fdd603ebda28..148de5347638 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -101,15 +101,11 @@ static void test_fexit_bpf2bpf_common(const char *o=
bj_file,
=20
 	for (i =3D 0; i < prog_cnt; i++) {
 		struct bpf_link_info link_info;
-		char *tgt_name;
 		__s32 btf_id;
=20
-		tgt_name =3D strstr(prog_name[i], "/");
-		if (!ASSERT_OK_PTR(tgt_name, "tgt_name"))
-			goto close_prog;
-		btf_id =3D btf__find_by_name_kind(btf, tgt_name + 1, BTF_KIND_FUNC);
+		btf_id =3D btf__find_by_name_kind(btf, prog_name[i], BTF_KIND_FUNC);
=20
-		prog[i] =3D bpf_object__find_program_by_title(obj, prog_name[i]);
+		prog[i] =3D bpf_object__find_program_by_name(obj, prog_name[i]);
 		if (!ASSERT_OK_PTR(prog[i], prog_name[i]))
 			goto close_prog;
=20
@@ -158,7 +154,7 @@ static void test_fexit_bpf2bpf_common(const char *obj=
_file,
 static void test_target_no_callees(void)
 {
 	const char *prog_name[] =3D {
-		"fexit/test_pkt_md_access",
+		"test_main2"
 	};
 	test_fexit_bpf2bpf_common("./fexit_bpf2bpf_simple.o",
 				  "./test_pkt_md_access.o",
@@ -169,10 +165,10 @@ static void test_target_no_callees(void)
 static void test_target_yes_callees(void)
 {
 	const char *prog_name[] =3D {
-		"fexit/test_pkt_access",
-		"fexit/test_pkt_access_subprog1",
-		"fexit/test_pkt_access_subprog2",
-		"fexit/test_pkt_access_subprog3",
+		"test_main",
+		"test_subprog1",
+		"test_subprog2",
+		"test_subprog3",
 	};
 	test_fexit_bpf2bpf_common("./fexit_bpf2bpf.o",
 				  "./test_pkt_access.o",
@@ -183,14 +179,14 @@ static void test_target_yes_callees(void)
 static void test_func_replace(void)
 {
 	const char *prog_name[] =3D {
-		"fexit/test_pkt_access",
-		"fexit/test_pkt_access_subprog1",
-		"fexit/test_pkt_access_subprog2",
-		"fexit/test_pkt_access_subprog3",
-		"freplace/get_skb_len",
-		"freplace/get_skb_ifindex",
-		"freplace/get_constant",
-		"freplace/test_pkt_write_access_subprog",
+		"test_main",
+		"test_subprog1",
+		"test_subprog2",
+		"test_subprog3",
+		"new_get_skb_len",
+		"new_get_skb_ifindex",
+		"new_get_constant",
+		"new_test_pkt_write_access_subprog",
 	};
 	test_fexit_bpf2bpf_common("./fexit_bpf2bpf.o",
 				  "./test_pkt_access.o",
@@ -201,7 +197,7 @@ static void test_func_replace(void)
 static void test_func_replace_verify(void)
 {
 	const char *prog_name[] =3D {
-		"freplace/do_bind",
+		"new_do_bind",
 	};
 	test_fexit_bpf2bpf_common("./freplace_connect4.o",
 				  "./connect4_prog.o",
@@ -211,8 +207,8 @@ static void test_func_replace_verify(void)
=20
 static int test_second_attach(struct bpf_object *obj)
 {
-	const char *prog_name =3D "freplace/get_constant";
-	const char *tgt_name =3D prog_name + 9; /* cut off freplace/ */
+	const char *prog_name =3D "security_new_get_constant";
+	const char *tgt_name =3D "get_constant";
 	const char *tgt_obj_file =3D "./test_pkt_access.o";
 	struct bpf_program *prog =3D NULL;
 	struct bpf_object *tgt_obj;
@@ -220,7 +216,7 @@ static int test_second_attach(struct bpf_object *obj)
 	struct bpf_link *link;
 	int err =3D 0, tgt_fd;
=20
-	prog =3D bpf_object__find_program_by_title(obj, prog_name);
+	prog =3D bpf_object__find_program_by_name(obj, prog_name);
 	if (CHECK(!prog, "find_prog", "prog %s not found\n", prog_name))
 		return -ENOENT;
=20
@@ -254,7 +250,7 @@ static int test_second_attach(struct bpf_object *obj)
 static void test_func_replace_multi(void)
 {
 	const char *prog_name[] =3D {
-		"freplace/get_constant",
+		"security_new_get_constant",
 	};
 	test_fexit_bpf2bpf_common("./freplace_get_constant.o",
 				  "./test_pkt_access.o",
@@ -321,7 +317,7 @@ static void test_fmod_ret_freplace(void)
 static void test_func_sockmap_update(void)
 {
 	const char *prog_name[] =3D {
-		"freplace/cls_redirect",
+		"freplace_cls_redirect_test",
 	};
 	test_fexit_bpf2bpf_common("./freplace_cls_redirect.o",
 				  "./test_cls_redirect.o",
diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/=
tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
index 977ab433a946..e834a01de16a 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
@@ -89,7 +89,7 @@ void test_get_stack_raw_tp(void)
 {
 	const char *file =3D "./test_get_stack_rawtp.o";
 	const char *file_err =3D "./test_get_stack_rawtp_err.o";
-	const char *prog_name =3D "raw_tracepoint/sys_enter";
+	const char *prog_name =3D "bpf_prog1";
 	int i, err, prog_fd, exp_cnt =3D MAX_CNT_RAWTP;
 	struct perf_buffer *pb =3D NULL;
 	struct bpf_link *link =3D NULL;
@@ -107,7 +107,7 @@ void test_get_stack_raw_tp(void)
 	if (CHECK(err, "prog_load raw tp", "err %d errno %d\n", err, errno))
 		return;
=20
-	prog =3D bpf_object__find_program_by_title(obj, prog_name);
+	prog =3D bpf_object__find_program_by_name(obj, prog_name);
 	if (CHECK(!prog, "find_probe", "prog '%s' not found\n", prog_name))
 		goto close_prog;
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/t=
ools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 6a953f4adfdc..8ed78a9383ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -136,7 +136,8 @@ static int start_server(void)
 	return fd;
 }
=20
-static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char=
 *title)
+static int prog_attach(struct bpf_object *obj, int cgroup_fd, const char=
 *title,
+		       const char *prog_name)
 {
 	enum bpf_attach_type attach_type;
 	enum bpf_prog_type prog_type;
@@ -145,20 +146,20 @@ static int prog_attach(struct bpf_object *obj, int =
cgroup_fd, const char *title)
=20
 	err =3D libbpf_prog_type_by_name(title, &prog_type, &attach_type);
 	if (err) {
-		log_err("Failed to deduct types for %s BPF program", title);
+		log_err("Failed to deduct types for %s BPF program", prog_name);
 		return -1;
 	}
=20
-	prog =3D bpf_object__find_program_by_title(obj, title);
+	prog =3D bpf_object__find_program_by_name(obj, prog_name);
 	if (!prog) {
-		log_err("Failed to find %s BPF program", title);
+		log_err("Failed to find %s BPF program", prog_name);
 		return -1;
 	}
=20
 	err =3D bpf_prog_attach(bpf_program__fd(prog), cgroup_fd,
 			      attach_type, 0);
 	if (err) {
-		log_err("Failed to attach %s BPF program", title);
+		log_err("Failed to attach %s BPF program", prog_name);
 		return -1;
 	}
=20
@@ -181,11 +182,11 @@ static void run_test(int cgroup_fd)
 	if (!ASSERT_OK(err, "obj_load"))
 		goto close_bpf_object;
=20
-	err =3D prog_attach(obj, cgroup_fd, "cgroup/getsockopt");
+	err =3D prog_attach(obj, cgroup_fd, "cgroup/getsockopt", "_getsockopt")=
;
 	if (CHECK_FAIL(err))
 		goto close_bpf_object;
=20
-	err =3D prog_attach(obj, cgroup_fd, "cgroup/setsockopt");
+	err =3D prog_attach(obj, cgroup_fd, "cgroup/setsockopt", "_setsockopt")=
;
 	if (CHECK_FAIL(err))
 		goto close_bpf_object;
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/to=
ols/testing/selftests/bpf/prog_tests/stacktrace_map.c
index 337493d74ec5..313f0a66232e 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
@@ -4,7 +4,7 @@
 void test_stacktrace_map(void)
 {
 	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
-	const char *prog_name =3D "tracepoint/sched/sched_switch";
+	const char *prog_name =3D "oncpu";
 	int err, prog_fd, stack_trace_len;
 	const char *file =3D "./test_stacktrace_map.o";
 	__u32 key, val, duration =3D 0;
@@ -16,7 +16,7 @@ void test_stacktrace_map(void)
 	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
 		return;
=20
-	prog =3D bpf_object__find_program_by_title(obj, prog_name);
+	prog =3D bpf_object__find_program_by_name(obj, prog_name);
 	if (CHECK(!prog, "find_prog", "prog '%s' not found\n", prog_name))
 		goto close_prog;
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp=
.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
index 063a14a2060d..1cb8dd36bd8f 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
@@ -3,7 +3,7 @@
=20
 void test_stacktrace_map_raw_tp(void)
 {
-	const char *prog_name =3D "tracepoint/sched/sched_switch";
+	const char *prog_name =3D "oncpu";
 	int control_map_fd, stackid_hmap_fd, stackmap_fd;
 	const char *file =3D "./test_stacktrace_map.o";
 	__u32 key, val, duration =3D 0;
@@ -16,7 +16,7 @@ void test_stacktrace_map_raw_tp(void)
 	if (CHECK(err, "prog_load raw tp", "err %d errno %d\n", err, errno))
 		return;
=20
-	prog =3D bpf_object__find_program_by_title(obj, prog_name);
+	prog =3D bpf_object__find_program_by_name(obj, prog_name);
 	if (CHECK(!prog, "find_prog", "prog '%s' not found\n", prog_name))
 		goto close_prog;
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/test_overhead.c b/too=
ls/testing/selftests/bpf/prog_tests/test_overhead.c
index 123c68c1917d..05acb376f74d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_overhead.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
@@ -56,11 +56,11 @@ static void setaffinity(void)
=20
 void test_test_overhead(void)
 {
-	const char *kprobe_name =3D "kprobe/__set_task_comm";
-	const char *kretprobe_name =3D "kretprobe/__set_task_comm";
-	const char *raw_tp_name =3D "raw_tp/task_rename";
-	const char *fentry_name =3D "fentry/__set_task_comm";
-	const char *fexit_name =3D "fexit/__set_task_comm";
+	const char *kprobe_name =3D "prog1";
+	const char *kretprobe_name =3D "prog2";
+	const char *raw_tp_name =3D "prog3";
+	const char *fentry_name =3D "prog4";
+	const char *fexit_name =3D "prog5";
 	const char *kprobe_func =3D "__set_task_comm";
 	struct bpf_program *kprobe_prog, *kretprobe_prog, *raw_tp_prog;
 	struct bpf_program *fentry_prog, *fexit_prog;
@@ -76,23 +76,23 @@ void test_test_overhead(void)
 	if (!ASSERT_OK_PTR(obj, "obj_open_file"))
 		return;
=20
-	kprobe_prog =3D bpf_object__find_program_by_title(obj, kprobe_name);
+	kprobe_prog =3D bpf_object__find_program_by_name(obj, kprobe_name);
 	if (CHECK(!kprobe_prog, "find_probe",
 		  "prog '%s' not found\n", kprobe_name))
 		goto cleanup;
-	kretprobe_prog =3D bpf_object__find_program_by_title(obj, kretprobe_nam=
e);
+	kretprobe_prog =3D bpf_object__find_program_by_name(obj, kretprobe_name=
);
 	if (CHECK(!kretprobe_prog, "find_probe",
 		  "prog '%s' not found\n", kretprobe_name))
 		goto cleanup;
-	raw_tp_prog =3D bpf_object__find_program_by_title(obj, raw_tp_name);
+	raw_tp_prog =3D bpf_object__find_program_by_name(obj, raw_tp_name);
 	if (CHECK(!raw_tp_prog, "find_probe",
 		  "prog '%s' not found\n", raw_tp_name))
 		goto cleanup;
-	fentry_prog =3D bpf_object__find_program_by_title(obj, fentry_name);
+	fentry_prog =3D bpf_object__find_program_by_name(obj, fentry_name);
 	if (CHECK(!fentry_prog, "find_probe",
 		  "prog '%s' not found\n", fentry_name))
 		goto cleanup;
-	fexit_prog =3D bpf_object__find_program_by_title(obj, fexit_name);
+	fexit_prog =3D bpf_object__find_program_by_name(obj, fexit_name);
 	if (CHECK(!fexit_prog, "find_probe",
 		  "prog '%s' not found\n", fexit_name))
 		goto cleanup;
diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/=
tools/testing/selftests/bpf/prog_tests/trampoline_count.c
index fc146671b20a..9c795ee52b7b 100644
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
+++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
@@ -35,7 +35,7 @@ static struct bpf_link *load(struct bpf_object *obj, co=
nst char *name)
 	struct bpf_program *prog;
 	int duration =3D 0;
=20
-	prog =3D bpf_object__find_program_by_title(obj, name);
+	prog =3D bpf_object__find_program_by_name(obj, name);
 	if (CHECK(!prog, "find_probe", "prog '%s' not found\n", name))
 		return ERR_PTR(-EINVAL);
 	return bpf_program__attach_trace(prog);
@@ -44,8 +44,8 @@ static struct bpf_link *load(struct bpf_object *obj, co=
nst char *name)
 /* TODO: use different target function to run in concurrent mode */
 void serial_test_trampoline_count(void)
 {
-	const char *fentry_name =3D "fentry/__set_task_comm";
-	const char *fexit_name =3D "fexit/__set_task_comm";
+	const char *fentry_name =3D "prog1";
+	const char *fexit_name =3D "prog2";
 	const char *object =3D "test_trampoline_count.o";
 	struct inst inst[MAX_TRAMP_PROGS] =3D {};
 	int err, i =3D 0, duration =3D 0;
--=20
2.30.2

