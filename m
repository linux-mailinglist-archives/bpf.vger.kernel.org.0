Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE4744238D
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 23:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhKAWtB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 18:49:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53250 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229848AbhKAWtB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Nov 2021 18:49:01 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A1GoVCt031629
        for <bpf@vger.kernel.org>; Mon, 1 Nov 2021 15:46:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=0uN2Hy21bKHzL9lOtrb2h/KfMS/PFh0cJqYjPnyCYns=;
 b=USHK61yluciq5bwBTb5phXCRTWpskMzgKdgLLAp704nR1Rwt4MkZbjvCazYH0rk8qctr
 pFUEeYSvc+gTuNyWeG3W8spjisEjmJpvux9XX3qFfYjqu6TRxJWPic7uQ/+30q3faCfS
 6jiUkGIWR+9zqjBmVHsSU2UZGtL8EdV3eNI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3c2datw68a-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 15:46:26 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 15:46:22 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 8EF9A8EEEB00; Mon,  1 Nov 2021 15:44:02 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 3/4] perf: pull in bpf_program__get_prog_info_linear
Date:   Mon, 1 Nov 2021 15:43:56 -0700
Message-ID: <20211101224357.2651181-4-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211101224357.2651181-1-davemarchevsky@fb.com>
References: <20211101224357.2651181-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: k9N_MmdKuem8olEaHKrRa96mAWar3fu6
X-Proofpoint-ORIG-GUID: k9N_MmdKuem8olEaHKrRa96mAWar3fu6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_07,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111010119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To prepare for impending deprecation of libbpf's
bpf_program__get_prog_info_linear, pull in the function and associated
helpers into the perf codebase and migrate existing uses to the perf
copy.

Since libbpf's deprecated definitions will still be visible to perf, it
is necessary to rename perf's definitions.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 .../Documentation/perf.data-file-format.txt   |   2 +-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/annotate.c                    |   3 +-
 tools/perf/util/bpf-event.c                   |  41 ++-
 tools/perf/util/bpf-event.h                   |   2 +-
 tools/perf/util/bpf-utils.c                   | 261 ++++++++++++++++++
 tools/perf/util/bpf-utils.h                   |  76 +++++
 tools/perf/util/bpf_counter.c                 |   6 +-
 tools/perf/util/dso.c                         |   1 +
 tools/perf/util/env.c                         |   1 +
 tools/perf/util/header.c                      |  13 +-
 11 files changed, 374 insertions(+), 33 deletions(-)
 create mode 100644 tools/perf/util/bpf-utils.c
 create mode 100644 tools/perf/util/bpf-utils.h

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/p=
erf/Documentation/perf.data-file-format.txt
index e6ff8c898ada..f56d0e0fbff6 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -346,7 +346,7 @@ to special needs.
=20
         HEADER_BPF_PROG_INFO =3D 25,
=20
-struct bpf_prog_info_linear, which contains detailed information about
+struct perf_bpil, which contains detailed information about
 a BPF program, including type, id, tag, jited/xlated instructions, etc.
=20
         HEADER_BPF_BTF =3D 26,
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index f2914d5bed6e..ee42da1d3639 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -201,6 +201,7 @@ endif
 perf-y +=3D perf-hooks.o
=20
 perf-$(CONFIG_LIBBPF) +=3D bpf-event.o
+perf-$(CONFIG_LIBBPF) +=3D bpf-utils.o
=20
 perf-$(CONFIG_CXX) +=3D c++/
=20
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0bae061b2d6d..f0e5a236b7e3 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -28,6 +28,7 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "bpf-event.h"
+#include "bpf-utils.h"
 #include "block-range.h"
 #include "string2.h"
 #include "util/event.h"
@@ -1700,12 +1701,12 @@ static int symbol__disassemble_bpf(struct symbol =
*sym,
 {
 	struct annotation *notes =3D symbol__annotation(sym);
 	struct annotation_options *opts =3D args->options;
-	struct bpf_prog_info_linear *info_linear;
 	struct bpf_prog_linfo *prog_linfo =3D NULL;
 	struct bpf_prog_info_node *info_node;
 	int len =3D sym->end - sym->start;
 	disassembler_ftype disassemble;
 	struct map *map =3D args->ms.map;
+	struct perf_bpil *info_linear;
 	struct disassemble_info info;
 	struct dso *dso =3D map->dso;
 	int pc =3D 0, count, sub_id;
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 388847bab6d9..a27badb0a53a 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -10,6 +10,7 @@
 #include <internal/lib.h>
 #include <symbol/kallsyms.h>
 #include "bpf-event.h"
+#include "bpf-utils.h"
 #include "debug.h"
 #include "dso.h"
 #include "symbol.h"
@@ -32,8 +33,6 @@ struct btf * __weak btf__load_from_kernel_by_id(__u32 i=
d)
        return err ? ERR_PTR(err) : btf;
 }
=20
-#define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
-
 static int snprintf_hex(char *buf, size_t size, unsigned char *data, siz=
e_t len)
 {
 	int ret =3D 0;
@@ -48,9 +47,9 @@ static int machine__process_bpf_event_load(struct machi=
ne *machine,
 					   union perf_event *event,
 					   struct perf_sample *sample __maybe_unused)
 {
-	struct bpf_prog_info_linear *info_linear;
 	struct bpf_prog_info_node *info_node;
 	struct perf_env *env =3D machine->env;
+	struct perf_bpil *info_linear;
 	int id =3D event->bpf.id;
 	unsigned int i;
=20
@@ -175,9 +174,9 @@ static int perf_event__synthesize_one_bpf_prog(struct=
 perf_session *session,
 {
 	struct perf_record_ksymbol *ksymbol_event =3D &event->ksymbol;
 	struct perf_record_bpf_event *bpf_event =3D &event->bpf;
-	struct bpf_prog_info_linear *info_linear;
 	struct perf_tool *tool =3D session->tool;
 	struct bpf_prog_info_node *info_node;
+	struct perf_bpil *info_linear;
 	struct bpf_prog_info *info;
 	struct btf *btf =3D NULL;
 	struct perf_env *env;
@@ -191,15 +190,15 @@ static int perf_event__synthesize_one_bpf_prog(stru=
ct perf_session *session,
 	 */
 	env =3D session->data ? &session->header.env : &perf_env;
=20
-	arrays =3D 1UL << BPF_PROG_INFO_JITED_KSYMS;
-	arrays |=3D 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
-	arrays |=3D 1UL << BPF_PROG_INFO_FUNC_INFO;
-	arrays |=3D 1UL << BPF_PROG_INFO_PROG_TAGS;
-	arrays |=3D 1UL << BPF_PROG_INFO_JITED_INSNS;
-	arrays |=3D 1UL << BPF_PROG_INFO_LINE_INFO;
-	arrays |=3D 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
+	arrays =3D 1UL << PERF_BPIL_JITED_KSYMS;
+	arrays |=3D 1UL << PERF_BPIL_JITED_FUNC_LENS;
+	arrays |=3D 1UL << PERF_BPIL_FUNC_INFO;
+	arrays |=3D 1UL << PERF_BPIL_PROG_TAGS;
+	arrays |=3D 1UL << PERF_BPIL_JITED_INSNS;
+	arrays |=3D 1UL << PERF_BPIL_LINE_INFO;
+	arrays |=3D 1UL << PERF_BPIL_JITED_LINE_INFO;
=20
-	info_linear =3D bpf_program__get_prog_info_linear(fd, arrays);
+	info_linear =3D get_bpf_prog_info_linear(fd, arrays);
 	if (IS_ERR_OR_NULL(info_linear)) {
 		info_linear =3D NULL;
 		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
@@ -452,8 +451,8 @@ int perf_event__synthesize_bpf_events(struct perf_ses=
sion *session,
=20
 static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 {
-	struct bpf_prog_info_linear *info_linear;
 	struct bpf_prog_info_node *info_node;
+	struct perf_bpil *info_linear;
 	struct btf *btf =3D NULL;
 	u64 arrays;
 	u32 btf_id;
@@ -463,15 +462,15 @@ static void perf_env__add_bpf_info(struct perf_env =
*env, u32 id)
 	if (fd < 0)
 		return;
=20
-	arrays =3D 1UL << BPF_PROG_INFO_JITED_KSYMS;
-	arrays |=3D 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
-	arrays |=3D 1UL << BPF_PROG_INFO_FUNC_INFO;
-	arrays |=3D 1UL << BPF_PROG_INFO_PROG_TAGS;
-	arrays |=3D 1UL << BPF_PROG_INFO_JITED_INSNS;
-	arrays |=3D 1UL << BPF_PROG_INFO_LINE_INFO;
-	arrays |=3D 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
+	arrays =3D 1UL << PERF_BPIL_JITED_KSYMS;
+	arrays |=3D 1UL << PERF_BPIL_JITED_FUNC_LENS;
+	arrays |=3D 1UL << PERF_BPIL_FUNC_INFO;
+	arrays |=3D 1UL << PERF_BPIL_PROG_TAGS;
+	arrays |=3D 1UL << PERF_BPIL_JITED_INSNS;
+	arrays |=3D 1UL << PERF_BPIL_LINE_INFO;
+	arrays |=3D 1UL << PERF_BPIL_JITED_LINE_INFO;
=20
-	info_linear =3D bpf_program__get_prog_info_linear(fd, arrays);
+	info_linear =3D get_bpf_prog_info_linear(fd, arrays);
 	if (IS_ERR_OR_NULL(info_linear)) {
 		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
 		goto out;
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 68f315c3df5b..144a8a24cc69 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -19,7 +19,7 @@ struct evlist;
 struct target;
=20
 struct bpf_prog_info_node {
-	struct bpf_prog_info_linear	*info_linear;
+	struct perf_bpil		*info_linear;
 	struct rb_node			rb_node;
 };
=20
diff --git a/tools/perf/util/bpf-utils.c b/tools/perf/util/bpf-utils.c
new file mode 100644
index 000000000000..e271e05e51bc
--- /dev/null
+++ b/tools/perf/util/bpf-utils.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <errno.h>
+#include <stdlib.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <bpf/bpf.h>
+#include "bpf-utils.h"
+#include "debug.h"
+
+struct bpil_array_desc {
+	int	array_offset;	/* e.g. offset of jited_prog_insns */
+	int	count_offset;	/* e.g. offset of jited_prog_len */
+	int	size_offset;	/* > 0: offset of rec size,
+				 * < 0: fix size of -size_offset
+				 */
+};
+
+static struct bpil_array_desc bpil_array_desc[] =3D {
+	[PERF_BPIL_JITED_INSNS] =3D {
+		offsetof(struct bpf_prog_info, jited_prog_insns),
+		offsetof(struct bpf_prog_info, jited_prog_len),
+		-1,
+	},
+	[PERF_BPIL_XLATED_INSNS] =3D {
+		offsetof(struct bpf_prog_info, xlated_prog_insns),
+		offsetof(struct bpf_prog_info, xlated_prog_len),
+		-1,
+	},
+	[PERF_BPIL_MAP_IDS] =3D {
+		offsetof(struct bpf_prog_info, map_ids),
+		offsetof(struct bpf_prog_info, nr_map_ids),
+		-(int)sizeof(__u32),
+	},
+	[PERF_BPIL_JITED_KSYMS] =3D {
+		offsetof(struct bpf_prog_info, jited_ksyms),
+		offsetof(struct bpf_prog_info, nr_jited_ksyms),
+		-(int)sizeof(__u64),
+	},
+	[PERF_BPIL_JITED_FUNC_LENS] =3D {
+		offsetof(struct bpf_prog_info, jited_func_lens),
+		offsetof(struct bpf_prog_info, nr_jited_func_lens),
+		-(int)sizeof(__u32),
+	},
+	[PERF_BPIL_FUNC_INFO] =3D {
+		offsetof(struct bpf_prog_info, func_info),
+		offsetof(struct bpf_prog_info, nr_func_info),
+		offsetof(struct bpf_prog_info, func_info_rec_size),
+	},
+	[PERF_BPIL_LINE_INFO] =3D {
+		offsetof(struct bpf_prog_info, line_info),
+		offsetof(struct bpf_prog_info, nr_line_info),
+		offsetof(struct bpf_prog_info, line_info_rec_size),
+	},
+	[PERF_BPIL_JITED_LINE_INFO] =3D {
+		offsetof(struct bpf_prog_info, jited_line_info),
+		offsetof(struct bpf_prog_info, nr_jited_line_info),
+		offsetof(struct bpf_prog_info, jited_line_info_rec_size),
+	},
+	[PERF_BPIL_PROG_TAGS] =3D {
+		offsetof(struct bpf_prog_info, prog_tags),
+		offsetof(struct bpf_prog_info, nr_prog_tags),
+		-(int)sizeof(__u8) * BPF_TAG_SIZE,
+	},
+
+};
+
+static __u32 bpf_prog_info_read_offset_u32(struct bpf_prog_info *info,
+					   int offset)
+{
+	__u32 *array =3D (__u32 *)info;
+
+	if (offset >=3D 0)
+		return array[offset / sizeof(__u32)];
+	return -(int)offset;
+}
+
+static __u64 bpf_prog_info_read_offset_u64(struct bpf_prog_info *info,
+					   int offset)
+{
+	__u64 *array =3D (__u64 *)info;
+
+	if (offset >=3D 0)
+		return array[offset / sizeof(__u64)];
+	return -(int)offset;
+}
+
+static void bpf_prog_info_set_offset_u32(struct bpf_prog_info *info, int=
 offset,
+					 __u32 val)
+{
+	__u32 *array =3D (__u32 *)info;
+
+	if (offset >=3D 0)
+		array[offset / sizeof(__u32)] =3D val;
+}
+
+static void bpf_prog_info_set_offset_u64(struct bpf_prog_info *info, int=
 offset,
+					 __u64 val)
+{
+	__u64 *array =3D (__u64 *)info;
+
+	if (offset >=3D 0)
+		array[offset / sizeof(__u64)] =3D val;
+}
+
+struct perf_bpil *
+get_bpf_prog_info_linear(int fd, __u64 arrays)
+{
+	struct bpf_prog_info info =3D {};
+	struct perf_bpil *info_linear;
+	__u32 info_len =3D sizeof(info);
+	__u32 data_len =3D 0;
+	int i, err;
+	void *ptr;
+
+	if (arrays >> PERF_BPIL_LAST_ARRAY)
+		return ERR_PTR(-EINVAL);
+
+	/* step 1: get array dimensions */
+	err =3D bpf_obj_get_info_by_fd(fd, &info, &info_len);
+	if (err) {
+		pr_debug("can't get prog info: %s", strerror(errno));
+		return ERR_PTR(-EFAULT);
+	}
+
+	/* step 2: calculate total size of all arrays */
+	for (i =3D PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
+		bool include_array =3D (arrays & (1UL << i)) > 0;
+		struct bpil_array_desc *desc;
+		__u32 count, size;
+
+		desc =3D bpil_array_desc + i;
+
+		/* kernel is too old to support this field */
+		if (info_len < desc->array_offset + sizeof(__u32) ||
+		    info_len < desc->count_offset + sizeof(__u32) ||
+		    (desc->size_offset > 0 && info_len < (__u32)desc->size_offset))
+			include_array =3D false;
+
+		if (!include_array) {
+			arrays &=3D ~(1UL << i);	/* clear the bit */
+			continue;
+		}
+
+		count =3D bpf_prog_info_read_offset_u32(&info, desc->count_offset);
+		size  =3D bpf_prog_info_read_offset_u32(&info, desc->size_offset);
+
+		data_len +=3D count * size;
+	}
+
+	/* step 3: allocate continuous memory */
+	data_len =3D roundup(data_len, sizeof(__u64));
+	info_linear =3D malloc(sizeof(struct perf_bpil) + data_len);
+	if (!info_linear)
+		return ERR_PTR(-ENOMEM);
+
+	/* step 4: fill data to info_linear->info */
+	info_linear->arrays =3D arrays;
+	memset(&info_linear->info, 0, sizeof(info));
+	ptr =3D info_linear->data;
+
+	for (i =3D PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
+		struct bpil_array_desc *desc;
+		__u32 count, size;
+
+		if ((arrays & (1UL << i)) =3D=3D 0)
+			continue;
+
+		desc  =3D bpil_array_desc + i;
+		count =3D bpf_prog_info_read_offset_u32(&info, desc->count_offset);
+		size  =3D bpf_prog_info_read_offset_u32(&info, desc->size_offset);
+		bpf_prog_info_set_offset_u32(&info_linear->info,
+					     desc->count_offset, count);
+		bpf_prog_info_set_offset_u32(&info_linear->info,
+					     desc->size_offset, size);
+		bpf_prog_info_set_offset_u64(&info_linear->info,
+					     desc->array_offset,
+					     ptr_to_u64(ptr));
+		ptr +=3D count * size;
+	}
+
+	/* step 5: call syscall again to get required arrays */
+	err =3D bpf_obj_get_info_by_fd(fd, &info_linear->info, &info_len);
+	if (err) {
+		pr_debug("can't get prog info: %s", strerror(errno));
+		free(info_linear);
+		return ERR_PTR(-EFAULT);
+	}
+
+	/* step 6: verify the data */
+	for (i =3D PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
+		struct bpil_array_desc *desc;
+		__u32 v1, v2;
+
+		if ((arrays & (1UL << i)) =3D=3D 0)
+			continue;
+
+		desc =3D bpil_array_desc + i;
+		v1 =3D bpf_prog_info_read_offset_u32(&info, desc->count_offset);
+		v2 =3D bpf_prog_info_read_offset_u32(&info_linear->info,
+						   desc->count_offset);
+		if (v1 !=3D v2)
+			pr_warning("%s: mismatch in element count\n", __func__);
+
+		v1 =3D bpf_prog_info_read_offset_u32(&info, desc->size_offset);
+		v2 =3D bpf_prog_info_read_offset_u32(&info_linear->info,
+						   desc->size_offset);
+		if (v1 !=3D v2)
+			pr_warning("%s: mismatch in rec size\n", __func__);
+	}
+
+	/* step 7: update info_len and data_len */
+	info_linear->info_len =3D sizeof(struct bpf_prog_info);
+	info_linear->data_len =3D data_len;
+
+	return info_linear;
+}
+
+void bpil_addr_to_offs(struct perf_bpil *info_linear)
+{
+	int i;
+
+	for (i =3D PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
+		struct bpil_array_desc *desc;
+		__u64 addr, offs;
+
+		if ((info_linear->arrays & (1UL << i)) =3D=3D 0)
+			continue;
+
+		desc =3D bpil_array_desc + i;
+		addr =3D bpf_prog_info_read_offset_u64(&info_linear->info,
+						     desc->array_offset);
+		offs =3D addr - ptr_to_u64(info_linear->data);
+		bpf_prog_info_set_offset_u64(&info_linear->info,
+					     desc->array_offset, offs);
+	}
+}
+
+void bpil_offs_to_addr(struct perf_bpil *info_linear)
+{
+	int i;
+
+	for (i =3D PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
+		struct bpil_array_desc *desc;
+		__u64 addr, offs;
+
+		if ((info_linear->arrays & (1UL << i)) =3D=3D 0)
+			continue;
+
+		desc =3D bpil_array_desc + i;
+		offs =3D bpf_prog_info_read_offset_u64(&info_linear->info,
+						     desc->array_offset);
+		addr =3D offs + ptr_to_u64(info_linear->data);
+		bpf_prog_info_set_offset_u64(&info_linear->info,
+					     desc->array_offset, addr);
+	}
+}
diff --git a/tools/perf/util/bpf-utils.h b/tools/perf/util/bpf-utils.h
new file mode 100644
index 000000000000..86a5055cdfad
--- /dev/null
+++ b/tools/perf/util/bpf-utils.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+
+#ifndef __PERF_BPF_UTILS_H
+#define __PERF_BPF_UTILS_H
+
+#define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
+
+#ifdef HAVE_LIBBPF_SUPPORT
+
+#include <bpf/libbpf.h>
+
+/*
+ * Get bpf_prog_info in continuous memory
+ *
+ * struct bpf_prog_info has multiple arrays. The user has option to choo=
se
+ * arrays to fetch from kernel. The following APIs provide an uniform wa=
y to
+ * fetch these data. All arrays in bpf_prog_info are stored in a single
+ * continuous memory region. This makes it easy to store the info in a
+ * file.
+ *
+ * Before writing perf_bpil to files, it is necessary to
+ * translate pointers in bpf_prog_info to offsets. Helper functions
+ * bpil_addr_to_offs() and bpil_offs_to_addr()
+ * are introduced to switch between pointers and offsets.
+ *
+ * Examples:
+ *   # To fetch map_ids and prog_tags:
+ *   __u64 arrays =3D (1UL << PERF_BPIL_MAP_IDS) |
+ *           (1UL << PERF_BPIL_PROG_TAGS);
+ *   struct perf_bpil *info_linear =3D
+ *           get_bpf_prog_info_linear(fd, arrays);
+ *
+ *   # To save data in file
+ *   bpil_addr_to_offs(info_linear);
+ *   write(f, info_linear, sizeof(*info_linear) + info_linear->data_len)=
;
+ *
+ *   # To read data from file
+ *   read(f, info_linear, <proper_size>);
+ *   bpil_offs_to_addr(info_linear);
+ */
+enum perf_bpil_array_types {
+	PERF_BPIL_FIRST_ARRAY =3D 0,
+	PERF_BPIL_JITED_INSNS =3D 0,
+	PERF_BPIL_XLATED_INSNS,
+	PERF_BPIL_MAP_IDS,
+	PERF_BPIL_JITED_KSYMS,
+	PERF_BPIL_JITED_FUNC_LENS,
+	PERF_BPIL_FUNC_INFO,
+	PERF_BPIL_LINE_INFO,
+	PERF_BPIL_JITED_LINE_INFO,
+	PERF_BPIL_PROG_TAGS,
+	PERF_BPIL_LAST_ARRAY,
+};
+
+struct perf_bpil {
+	/* size of struct bpf_prog_info, when the tool is compiled */
+	__u32			info_len;
+	/* total bytes allocated for data, round up to 8 bytes */
+	__u32			data_len;
+	/* which arrays are included in data */
+	__u64			arrays;
+	struct bpf_prog_info	info;
+	__u8			data[];
+};
+
+struct perf_bpil *
+get_bpf_prog_info_linear(int fd, __u64 arrays);
+
+void
+bpil_addr_to_offs(struct perf_bpil *info_linear);
+
+void
+bpil_offs_to_addr(struct perf_bpil *info_linear);
+
+#endif /* HAVE_LIBBPF_SUPPORT */
+#endif /* __PERF_BPF_UTILS_H */
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.=
c
index ba0f20853651..2b04df8c5f87 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -13,6 +13,7 @@
 #include <perf/bpf_perf.h>
=20
 #include "bpf_counter.h"
+#include "bpf-utils.h"
 #include "counts.h"
 #include "debug.h"
 #include "evsel.h"
@@ -61,14 +62,13 @@ static int bpf_program_profiler__destroy(struct evsel=
 *evsel)
=20
 static char *bpf_target_prog_name(int tgt_fd)
 {
-	struct bpf_prog_info_linear *info_linear;
 	struct bpf_func_info *func_info;
+	struct perf_bpil *info_linear;
 	const struct btf_type *t;
 	struct btf *btf =3D NULL;
 	char *name =3D NULL;
=20
-	info_linear =3D bpf_program__get_prog_info_linear(
-		tgt_fd, 1UL << BPF_PROG_INFO_FUNC_INFO);
+	info_linear =3D get_bpf_prog_info_linear(tgt_fd, 1UL << PERF_BPIL_FUNC_=
INFO);
 	if (IS_ERR_OR_NULL(info_linear)) {
 		pr_debug("failed to get info_linear for prog FD %d\n", tgt_fd);
 		return NULL;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 9ed9a5676d35..9cc8a1772b4b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -14,6 +14,7 @@
 #ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/libbpf.h>
 #include "bpf-event.h"
+#include "bpf-utils.h"
 #endif
 #include "compress.h"
 #include "env.h"
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index cf773f0dec38..17f1dd0680b4 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -16,6 +16,7 @@ struct perf_env perf_env;
=20
 #ifdef HAVE_LIBBPF_SUPPORT
 #include "bpf-event.h"
+#include "bpf-utils.h"
 #include <bpf/libbpf.h>
=20
 void perf_env__insert_bpf_prog_info(struct perf_env *env,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1c7414f66655..56511db8fa03 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -48,6 +48,7 @@
 #include "util/util.h" // perf_exe()
 #include "cputopo.h"
 #include "bpf-event.h"
+#include "bpf-utils.h"
 #include "clockid.h"
 #include "pmu-hybrid.h"
=20
@@ -1006,17 +1007,17 @@ static int write_bpf_prog_info(struct feat_fd *ff=
,
=20
 		node =3D rb_entry(next, struct bpf_prog_info_node, rb_node);
 		next =3D rb_next(&node->rb_node);
-		len =3D sizeof(struct bpf_prog_info_linear) +
+		len =3D sizeof(struct perf_bpil) +
 			node->info_linear->data_len;
=20
 		/* before writing to file, translate address to offset */
-		bpf_program__bpil_addr_to_offs(node->info_linear);
+		bpil_addr_to_offs(node->info_linear);
 		ret =3D do_write(ff, node->info_linear, len);
 		/*
 		 * translate back to address even when do_write() fails,
 		 * so that this function never changes the data.
 		 */
-		bpf_program__bpil_offs_to_addr(node->info_linear);
+		bpil_offs_to_addr(node->info_linear);
 		if (ret < 0)
 			goto out;
 	}
@@ -3018,9 +3019,9 @@ static int process_dir_format(struct feat_fd *ff,
 #ifdef HAVE_LIBBPF_SUPPORT
 static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_=
unused)
 {
-	struct bpf_prog_info_linear *info_linear;
 	struct bpf_prog_info_node *info_node;
 	struct perf_env *env =3D &ff->ph->env;
+	struct perf_bpil *info_linear;
 	u32 count, i;
 	int err =3D -1;
=20
@@ -3049,7 +3050,7 @@ static int process_bpf_prog_info(struct feat_fd *ff=
, void *data __maybe_unused)
 			goto out;
 		}
=20
-		info_linear =3D malloc(sizeof(struct bpf_prog_info_linear) +
+		info_linear =3D malloc(sizeof(struct perf_bpil) +
 				     data_len);
 		if (!info_linear)
 			goto out;
@@ -3071,7 +3072,7 @@ static int process_bpf_prog_info(struct feat_fd *ff=
, void *data __maybe_unused)
 			goto out;
=20
 		/* after reading from file, translate offset to address */
-		bpf_program__bpil_offs_to_addr(info_linear);
+		bpil_offs_to_addr(info_linear);
 		info_node->info_linear =3D info_linear;
 		perf_env__insert_bpf_prog_info(env, info_node);
 	}
--=20
2.30.2

