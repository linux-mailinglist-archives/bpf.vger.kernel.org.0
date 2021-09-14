Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE2940A2CE
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 03:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhINBtH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 13 Sep 2021 21:49:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16640 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236449AbhINBtC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 21:49:02 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18DM9ZtI003397
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 18:47:45 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3b1sqryu2a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 18:47:45 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 18:47:44 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 194A43F9D7BE; Mon, 13 Sep 2021 18:47:39 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 2/4] libbpf: ensure BPF prog types are set before relocations
Date:   Mon, 13 Sep 2021 18:47:31 -0700
Message-ID: <20210914014733.2768-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914014733.2768-1-andrii@kernel.org>
References: <20210914014733.2768-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: Q6CPbr_ckiPQPTEnuOQGrKpQ0qwF_y34
X-Proofpoint-GUID: Q6CPbr_ckiPQPTEnuOQGrKpQ0qwF_y34
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_09,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor bpf_object__open() sequencing to perform BPF program type
detection based on SEC() definitions before we get to relocations
collection. This allows to have more information about BPF program by
the time we get to, say, struct_ops relocation gathering. This,
subsequently, simplifies struct_ops logic and removes the need to
perform extra find_sec_def() resolution.

With this patch libbpf will require all struct_ops BPF programs to be
marked with SEC("struct_ops") or SEC("struct_ops/xxx") annotations.
Real-world applications are already doing that through something like
selftests's BPF_STRUCT_OPS() macro. This change streamlines libbpf's
internal handling of SEC() definitions and is in the sprit of
upcoming libbpf-1.0 section strictness changes ([0]).

  [0] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter-and-more-uniform-bpf-program-section-name-sec-handling

Cc: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 93 +++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8f579c6666b2..c8a751d03b22 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6373,12 +6373,37 @@ bpf_object__load_progs(struct bpf_object *obj, int log_level)
 
 static const struct bpf_sec_def *find_sec_def(const char *sec_name);
 
+static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object_open_opts *opts)
+{
+	struct bpf_program *prog;
+
+	bpf_object__for_each_program(prog, obj) {
+		prog->sec_def = find_sec_def(prog->sec_name);
+		if (!prog->sec_def) {
+			/* couldn't guess, but user might manually specify */
+			pr_debug("prog '%s': unrecognized ELF section name '%s'\n",
+				prog->name, prog->sec_name);
+			continue;
+		}
+
+		if (prog->sec_def->is_sleepable)
+			prog->prog_flags |= BPF_F_SLEEPABLE;
+		bpf_program__set_type(prog, prog->sec_def->prog_type);
+		bpf_program__set_expected_attach_type(prog, prog->sec_def->expected_attach_type);
+
+		if (prog->sec_def->prog_type == BPF_PROG_TYPE_TRACING ||
+		    prog->sec_def->prog_type == BPF_PROG_TYPE_EXT)
+			prog->attach_prog_fd = OPTS_GET(opts, attach_prog_fd, 0);
+	}
+
+	return 0;
+}
+
 static struct bpf_object *
 __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 		   const struct bpf_object_open_opts *opts)
 {
 	const char *obj_name, *kconfig, *btf_tmp_path;
-	struct bpf_program *prog;
 	struct bpf_object *obj;
 	char tmp_name[64];
 	int err;
@@ -6436,30 +6461,12 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 	err = err ? : bpf_object__collect_externs(obj);
 	err = err ? : bpf_object__finalize_btf(obj);
 	err = err ? : bpf_object__init_maps(obj, opts);
+	err = err ? : bpf_object_init_progs(obj, opts);
 	err = err ? : bpf_object__collect_relos(obj);
 	if (err)
 		goto out;
-	bpf_object__elf_finish(obj);
 
-	bpf_object__for_each_program(prog, obj) {
-		prog->sec_def = find_sec_def(prog->sec_name);
-		if (!prog->sec_def) {
-			/* couldn't guess, but user might manually specify */
-			pr_debug("prog '%s': unrecognized ELF section name '%s'\n",
-				prog->name, prog->sec_name);
-			continue;
-		}
-
-		if (prog->sec_def->is_sleepable)
-			prog->prog_flags |= BPF_F_SLEEPABLE;
-		bpf_program__set_type(prog, prog->sec_def->prog_type);
-		bpf_program__set_expected_attach_type(prog,
-				prog->sec_def->expected_attach_type);
-
-		if (prog->sec_def->prog_type == BPF_PROG_TYPE_TRACING ||
-		    prog->sec_def->prog_type == BPF_PROG_TYPE_EXT)
-			prog->attach_prog_fd = OPTS_GET(opts, attach_prog_fd, 0);
-	}
+	bpf_object__elf_finish(obj);
 
 	return obj;
 out:
@@ -8250,35 +8257,37 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 			return -EINVAL;
 		}
 
-		if (prog->type == BPF_PROG_TYPE_UNSPEC) {
-			const struct bpf_sec_def *sec_def;
-
-			sec_def = find_sec_def(prog->sec_name);
-			if (sec_def &&
-			    sec_def->prog_type != BPF_PROG_TYPE_STRUCT_OPS) {
-				/* for pr_warn */
-				prog->type = sec_def->prog_type;
-				goto invalid_prog;
-			}
+		/* prevent the use of BPF prog with invalid type */
+		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS) {
+			pr_warn("struct_ops reloc %s: prog %s is not struct_ops BPF program\n",
+				map->name, prog->name);
+			return -EINVAL;
+		}
 
-			prog->type = BPF_PROG_TYPE_STRUCT_OPS;
+		/* if we haven't yet processed this BPF program, record proper
+		 * attach_btf_id and member_idx
+		 */
+		if (!prog->attach_btf_id) {
 			prog->attach_btf_id = st_ops->type_id;
 			prog->expected_attach_type = member_idx;
-		} else if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
-			   prog->attach_btf_id != st_ops->type_id ||
-			   prog->expected_attach_type != member_idx) {
-			goto invalid_prog;
 		}
+
+		/* struct_ops BPF prog can be re-used between multiple
+		 * .struct_ops as long as it's the same struct_ops struct
+		 * definition and the same function pointer field
+		 */
+		if (prog->attach_btf_id != st_ops->type_id ||
+		    prog->expected_attach_type != member_idx) {
+			pr_warn("struct_ops reloc %s: cannot use prog %s in sec %s with type %u attach_btf_id %u expected_attach_type %u for func ptr %s\n",
+				map->name, prog->name, prog->sec_name, prog->type,
+				prog->attach_btf_id, prog->expected_attach_type, name);
+			return -EINVAL;
+		}
+
 		st_ops->progs[member_idx] = prog;
 	}
 
 	return 0;
-
-invalid_prog:
-	pr_warn("struct_ops reloc %s: cannot use prog %s in sec %s with type %u attach_btf_id %u expected_attach_type %u for func ptr %s\n",
-		map->name, prog->name, prog->sec_name, prog->type,
-		prog->attach_btf_id, prog->expected_attach_type, name);
-	return -EINVAL;
 }
 
 #define BTF_TRACE_PREFIX "btf_trace_"
-- 
2.30.2

