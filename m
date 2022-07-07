Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB905696FC
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 02:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiGGAlc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 6 Jul 2022 20:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiGGAlb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 20:41:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF9F2E683
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 17:41:30 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266L6pQ1010649
        for <bpf@vger.kernel.org>; Wed, 6 Jul 2022 17:41:30 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4ubv2mjn-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 17:41:30 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub103.TheFacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 6 Jul 2022 17:41:28 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 6 Jul 2022 17:41:28 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5F7AD1BFE3621; Wed,  6 Jul 2022 17:41:24 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Kenta Tada <kenta.tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH RFC bpf-next 2/3] libbpf: add ksyscall/kretsyscall sections support for syscall kprobes
Date:   Wed, 6 Jul 2022 17:41:17 -0700
Message-ID: <20220707004118.298323-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707004118.298323-1-andrii@kernel.org>
References: <20220707004118.298323-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RdC0Znpd-_ZHrj_cI-hmt-405rf2YPJZ
X-Proofpoint-GUID: RdC0Znpd-_ZHrj_cI-hmt-405rf2YPJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_14,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add SEC("ksyscall")/SEC("ksyscall/<syscall_name>") and corresponding
kretsyscall variants (for return kprobes) to allow users to kprobe
syscall functions in kernel. These special sections allow to ignore
complexities and differences between kernel versions and host
architectures when it comes to syscall wrapper and corresponding
__<arch>_sys_<syscall> vs __se_sys_<syscall> differences, depending on
CONFIG_ARCH_HAS_SYSCALL_WRAPPER.

Combined with the use of BPF_KSYSCALL() macro, this allows to just
specify intended syscall name and expected input arguments and leave
dealing with all the variations to libbpf.

In addition to SEC("ksyscall+") and SEC("kretsyscall+") add
bpf_program__attach_ksyscall() API which allows to specify syscall name
at runtime and provide associated BPF cookie value.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c          | 109 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h          |  16 +++++
 tools/lib/bpf/libbpf.map        |   1 +
 tools/lib/bpf/libbpf_internal.h |   2 +
 4 files changed, 128 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cb49408eb298..4749fb84e33d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4654,6 +4654,65 @@ static int probe_kern_btf_enum64(void)
 					     strs, sizeof(strs)));
 }
 
+static const char *arch_specific_syscall_pfx(void)
+{
+#if defined(__x86_64__)
+	return "x64";
+#elif defined(__i386__)
+	return "ia32";
+#elif defined(__s390x__)
+	return "s390x";
+#elif defined(__s390__)
+	return "s390";
+#elif defined(__arm__)
+	return "arm";
+#elif defined(__aarch64__)
+	return "arm64";
+#elif defined(__mips__)
+	return "mips";
+#elif defined(__riscv)
+	return "riscv";
+#else
+	return NULL;
+#endif
+}
+
+static int probe_kern_syscall_wrapper(void)
+{
+	/* available_filter_functions is a few times smaller than
+	 * /proc/kallsyms and has simpler format, so we use it as a faster way
+	 * to check that __<arch>_sys_bpf symbol exists, which is a sign that
+	 * kernel was built with CONFIG_ARCH_HAS_SYSCALL_WRAPPER and uses
+	 * syscall wrappers
+	 */
+	static const char *kprobes_file = "/sys/kernel/tracing/available_filter_functions";
+	char func_name[128], syscall_name[128];
+	const char *ksys_pfx;
+	FILE *f;
+	int cnt;
+
+	ksys_pfx = arch_specific_syscall_pfx();
+	if (!ksys_pfx)
+		return 0;
+
+	f = fopen(kprobes_file, "r");
+	if (!f)
+		return 0;
+
+	snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys_pfx);
+
+	/* check if bpf() syscall wrapper is listed as possible kprobe */
+	while ((cnt = fscanf(f, "%127s%*[^\n]\n", func_name)) == 1) {
+		if (strcmp(func_name, syscall_name) == 0) {
+			fclose(f);
+			return 1;
+		}
+	}
+
+	fclose(f);
+	return 0;
+}
+
 enum kern_feature_result {
 	FEAT_UNKNOWN = 0,
 	FEAT_SUPPORTED = 1,
@@ -4722,6 +4781,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_ENUM64] = {
 		"BTF_KIND_ENUM64 support", probe_kern_btf_enum64,
 	},
+	[FEAT_SYSCALL_WRAPPER] = {
+		"Kernel using syscall wrapper", probe_kern_syscall_wrapper,
+	},
 };
 
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
@@ -8381,6 +8443,7 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
 
 static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_ksyscall(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_usdt(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
@@ -8401,6 +8464,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
 	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
+	SEC_DEF("ksyscall+",		KPROBE,	0, SEC_NONE, attach_ksyscall),
+	SEC_DEF("kretsyscall+",		KPROBE, 0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
 	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE),
 	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE),
@@ -9990,6 +10055,29 @@ struct bpf_link *bpf_program__attach_kprobe(const struct bpf_program *prog,
 	return bpf_program__attach_kprobe_opts(prog, func_name, &opts);
 }
 
+struct bpf_link *bpf_program__attach_ksyscall(const struct bpf_program *prog,
+					      const char *syscall_name,
+					      const struct bpf_ksyscall_opts *opts)
+{
+	LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
+	char func_name[128];
+
+	if (!OPTS_VALID(opts, bpf_ksyscall_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	if (kernel_supports(prog->obj, FEAT_SYSCALL_WRAPPER)) {
+		snprintf(func_name, sizeof(func_name), "__%s_sys_%s",
+			 arch_specific_syscall_pfx(), syscall_name);
+	} else {
+		snprintf(func_name, sizeof(func_name), "__se_sys_%s", syscall_name);
+	}
+
+	kprobe_opts.retprobe = OPTS_GET(opts, retprobe, false);
+	kprobe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
+
+	return bpf_program__attach_kprobe_opts(prog, func_name, &kprobe_opts);
+}
+
 /* Adapted from perf/util/string.c */
 static bool glob_match(const char *str, const char *pat)
 {
@@ -10160,6 +10248,27 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
 	return libbpf_get_error(*link);
 }
 
+static int attach_ksyscall(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	LIBBPF_OPTS(bpf_ksyscall_opts, opts);
+	const char *syscall_name;
+
+	*link = NULL;
+
+	/* no auto-attach for SEC("ksyscall") and SEC("kretsyscall") */
+	if (strcmp(prog->sec_name, "ksyscall") == 0 || strcmp(prog->sec_name, "kretsyscall") == 0)
+		return 0;
+
+	opts.retprobe = str_has_pfx(prog->sec_name, "kretsyscall/");
+	if (opts.retprobe)
+		syscall_name = prog->sec_name + sizeof("kretsyscall/") - 1;
+	else
+		syscall_name = prog->sec_name + sizeof("ksyscall/") - 1;
+
+	*link = bpf_program__attach_ksyscall(prog, syscall_name, &opts);
+	return *link ? 0 : -errno;
+}
+
 static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e4d5353f757b..90633ada4b40 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -457,6 +457,22 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
 				      const char *pattern,
 				      const struct bpf_kprobe_multi_opts *opts);
 
+struct bpf_ksyscall_opts {
+	/* size of this struct, for forward/backward compatiblity */
+	size_t sz;
+	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
+	__u64 bpf_cookie;
+	/* attach as return probe? */
+	bool retprobe;
+	size_t :0;
+};
+#define bpf_ksyscall_opts__last_field retprobe
+
+LIBBPF_API struct bpf_link *
+bpf_program__attach_ksyscall(const struct bpf_program *prog,
+			     const char *syscall_name,
+			     const struct bpf_ksyscall_opts *opts);
+
 struct bpf_uprobe_opts {
 	/* size of this struct, for forward/backward compatiblity */
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 94b589ecfeaa..63c059a02a0d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -356,6 +356,7 @@ LIBBPF_0.8.0 {
 LIBBPF_1.0.0 {
 	global:
 		bpf_prog_query_opts;
+		bpf_program__attach_ksyscall;
 		btf__add_enum64;
 		btf__add_enum64_value;
 		libbpf_bpf_attach_type_str;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 9cd7829cbe41..f01dbab49da9 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -352,6 +352,8 @@ enum kern_feature_id {
 	FEAT_BPF_COOKIE,
 	/* BTF_KIND_ENUM64 support and BTF_KIND_ENUM kflag support */
 	FEAT_BTF_ENUM64,
+	/* Kernel uses syscall wrapper (CONFIG_ARCH_HAS_SYSCALL_WRAPPER) */
+	FEAT_SYSCALL_WRAPPER,
 	__FEAT_CNT,
 };
 
-- 
2.30.2

