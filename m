Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAC26C8938
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 00:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjCXX2D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 24 Mar 2023 19:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjCXX2C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 19:28:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF2CCC08
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:27:57 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OMZuwW022579
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:27:57 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pgxmqf8c7-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:27:56 -0700
Received: from twshared29091.48.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Mar 2023 16:27:55 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id BAD9E2BC9C96D; Fri, 24 Mar 2023 16:27:52 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 3/3] veristat: guess and substitue underlying program type for freplace (EXT) progs
Date:   Fri, 24 Mar 2023 16:27:45 -0700
Message-ID: <20230324232745.3959567-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324232745.3959567-1-andrii@kernel.org>
References: <20230324232745.3959567-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: TCvQjzKEaa6RTWJvCHeEtp-gLzw1xXib
X-Proofpoint-ORIG-GUID: TCvQjzKEaa6RTWJvCHeEtp-gLzw1xXib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.5 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SEC("freplace") (i.e., BPF_PROG_TYPE_EXT) programs are not loadable as
is through veristat, as kernel expects actual program's FD during
BPF_PROG_LOAD time, which veristat has no way of knowing.

Unfortunately, freplace programs are a pretty important class of
programs, especially when dealing with XDP chaining solutions, which
rely on EXT programs.

So let's do our best and teach veristat to try to guess the original
program type, based on program's context argument type. And if guessing
process succeeds, we manually override freplace/EXT with guessed program
type using bpf_program__set_type() setter to increase chances of proper
BPF verification.

We rely on BTF and maintain a simple lookup table. This process is
obviously not 100% bulletproof, as valid program might not use context
and thus wouldn't have to specify correct type. Also, __sk_buff is very
ambiguous and is the context type across many different program types.
We pick BPF_PROG_TYPE_CGROUP_SKB for now, which seems to work fine in
practice so far. Similarly, some program types require specifying attach
type, and so we pick one out of possible few variants.

Best effort at its best. But this makes veristat even more widely
applicable.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 118 ++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 263df32fbda8..a422fa986dc4 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -15,6 +15,7 @@
 #include <sys/sysinfo.h>
 #include <sys/stat.h>
 #include <bpf/libbpf.h>
+#include <bpf/btf.h>
 #include <libelf.h>
 #include <gelf.h>
 #include <float.h>
@@ -778,7 +779,59 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 	return 0;
 }
 
-static void fixup_obj(struct bpf_object *obj)
+static int guess_prog_type_by_ctx_name(const char *ctx_name,
+				       enum bpf_prog_type *prog_type,
+				       enum bpf_attach_type *attach_type)
+{
+	/* We need to guess program type based on its declared context type.
+	 * This guess can't be perfect as many different program types might
+	 * share the same context type.  So we can only hope to reasonably
+	 * well guess this and get lucky.
+	 *
+	 * Just in case, we support both UAPI-side type names and
+	 * kernel-internal names.
+	 */
+	static struct {
+		const char *uapi_name;
+		const char *kern_name;
+		enum bpf_prog_type prog_type;
+		enum bpf_attach_type attach_type;
+	} ctx_map[] = {
+		/* __sk_buff is most ambiguous, for now we assume cgroup_skb */
+		{ "__sk_buff", "sk_buff", BPF_PROG_TYPE_CGROUP_SKB, BPF_CGROUP_INET_INGRESS },
+		{ "bpf_sock", "sock", BPF_PROG_TYPE_CGROUP_SOCK, BPF_CGROUP_INET4_POST_BIND },
+		{ "bpf_sock_addr", "bpf_sock_addr_kern",  BPF_PROG_TYPE_CGROUP_SOCK_ADDR, BPF_CGROUP_INET4_BIND },
+		{ "bpf_sock_ops", "bpf_sock_ops_kern", BPF_PROG_TYPE_SOCK_OPS, BPF_CGROUP_SOCK_OPS },
+		{ "sk_msg_md", "sk_msg", BPF_PROG_TYPE_SK_MSG, BPF_SK_MSG_VERDICT },
+		{ "bpf_cgroup_dev_ctx", "bpf_cgroup_dev_ctx", BPF_PROG_TYPE_CGROUP_DEVICE, BPF_CGROUP_DEVICE },
+		{ "bpf_sysctl", "bpf_sysctl_kern", BPF_PROG_TYPE_CGROUP_SYSCTL, BPF_CGROUP_SYSCTL },
+		{ "bpf_sockopt", "bpf_sockopt_kern", BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT },
+		{ "sk_reuseport_md", "sk_reuseport_kern", BPF_PROG_TYPE_SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE },
+		{ "bpf_sk_lookup", "bpf_sk_lookup_kern", BPF_PROG_TYPE_SK_LOOKUP, BPF_SK_LOOKUP },
+		{ "xdp_md", "xdp_buff", BPF_PROG_TYPE_XDP, BPF_XDP },
+		/* tracing types with no expected attach type */
+		{ "bpf_user_pt_regs_t", "pt_regs", BPF_PROG_TYPE_KPROBE },
+		{ "bpf_perf_event_data", "bpf_perf_event_data_kern", BPF_PROG_TYPE_PERF_EVENT },
+		{ "bpf_raw_tracepoint_args", NULL, BPF_PROG_TYPE_RAW_TRACEPOINT },
+	};
+	int i;
+
+	if (!ctx_name)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(ctx_map); i++) {
+		if (strcmp(ctx_map[i].uapi_name, ctx_name) == 0 ||
+		    (!ctx_map[i].kern_name || strcmp(ctx_map[i].kern_name, ctx_name) == 0)) {
+			*prog_type = ctx_map[i].prog_type;
+			*attach_type = ctx_map[i].attach_type;
+			return 0;
+		}
+	}
+
+	return -ESRCH;
+}
+
+static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const char *filename)
 {
 	struct bpf_map *map;
 
@@ -798,18 +851,75 @@ static void fixup_obj(struct bpf_object *obj)
 				bpf_map__set_max_entries(map, 1);
 		}
 	}
+
+	/* SEC(freplace) programs can't be loaded with veristat as is,
+	 * but we can try guessing their target program's expected type by
+	 * looking at the type of program's first argument and substituting
+	 * corresponding program type
+	 */
+	if (bpf_program__type(prog) == BPF_PROG_TYPE_EXT) {
+		const struct btf *btf = bpf_object__btf(obj);
+		const char *prog_name = bpf_program__name(prog);
+		enum bpf_prog_type prog_type;
+		enum bpf_attach_type attach_type;
+		const struct btf_type *t;
+		const char *ctx_name;
+		int id;
+
+		if (!btf)
+			goto skip_freplace_fixup;
+
+		id = btf__find_by_name_kind(btf, prog_name, BTF_KIND_FUNC);
+		t = btf__type_by_id(btf, id);
+		t = btf__type_by_id(btf, t->type);
+		if (!btf_is_func_proto(t) || btf_vlen(t) != 1)
+			goto skip_freplace_fixup;
+
+		/* context argument is a pointer to a struct/typedef */
+		t = btf__type_by_id(btf, btf_params(t)[0].type);
+		while (t && btf_is_mod(t))
+			t = btf__type_by_id(btf, t->type);
+		if (!t || !btf_is_ptr(t))
+			goto skip_freplace_fixup;
+		t = btf__type_by_id(btf, t->type);
+		while (t && btf_is_mod(t))
+			t = btf__type_by_id(btf, t->type);
+		if (!t)
+			goto skip_freplace_fixup;
+
+		ctx_name = btf__name_by_offset(btf, t->name_off);
+
+		if (guess_prog_type_by_ctx_name(ctx_name, &prog_type, &attach_type) == 0) {
+			bpf_program__set_type(prog, prog_type);
+			bpf_program__set_expected_attach_type(prog, attach_type);
+
+			if (!env.quiet) {
+				printf("Using guessed program type '%s' for %s/%s...\n",
+					libbpf_bpf_prog_type_str(prog_type),
+					filename, prog_name);
+			}
+		} else {
+			if (!env.quiet) {
+				printf("Failed to guess program type for freplace program with context type name '%s' for %s/%s. Consider using canonical type names to help veristat...\n",
+					ctx_name, filename, prog_name);
+			}
+		}
+	}
+skip_freplace_fixup:
+	return;
 }
 
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *prog_name = bpf_program__name(prog);
+	const char *base_filename = basename(filename);
 	size_t buf_sz = sizeof(verif_log_buf);
 	char *buf = verif_log_buf;
 	struct verif_stats *stats;
 	int err = 0;
 	void *tmp;
 
-	if (!should_process_file_prog(basename(filename), bpf_program__name(prog))) {
+	if (!should_process_file_prog(base_filename, bpf_program__name(prog))) {
 		env.progs_skipped++;
 		return 0;
 	}
@@ -835,12 +945,12 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	verif_log_buf[0] = '\0';
 
 	/* increase chances of successful BPF object loading */
-	fixup_obj(obj);
+	fixup_obj(obj, prog, base_filename);
 
 	err = bpf_object__load(obj);
 	env.progs_processed++;
 
-	stats->file_name = strdup(basename(filename));
+	stats->file_name = strdup(base_filename);
 	stats->prog_name = strdup(bpf_program__name(prog));
 	stats->stats[VERDICT] = err == 0; /* 1 - success, 0 - failure */
 	parse_verif_log(buf, buf_sz, stats);
-- 
2.34.1

