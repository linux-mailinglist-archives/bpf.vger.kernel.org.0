Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F2470BA8
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 21:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242769AbhLJURV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 10 Dec 2021 15:17:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8716 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238375AbhLJURV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 15:17:21 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1BAEao5Z030850
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 12:13:45 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3cv8t4tqwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 12:13:45 -0800
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 12:13:44 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 6949AC91EBE3; Fri, 10 Dec 2021 12:13:37 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 1/2] libbpf: auto-bump RLIMIT_MEMLOCK if kernel needs it for BPF
Date:   Fri, 10 Dec 2021 12:13:32 -0800
Message-ID: <20211210201333.896276-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210201333.896276-1-andrii@kernel.org>
References: <20211210201333.896276-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: R5oztehjrWEuBRN38XgrXgloE8HUY-Up
X-Proofpoint-GUID: R5oztehjrWEuBRN38XgrXgloE8HUY-Up
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_08,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112100111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The need to increase RLIMIT_MEMLOCK to do anything useful with BPF is
one of the first extremely frustrating gotchas that all new BPF users go
through and in some cases have to learn it a very hard way.

Luckily, starting with upstream Linux kernel version 5.11, BPF subsystem
dropped the dependency on memlock and uses memcg-based memory accounting
instead. Unfortunately, detecting memcg-based BPF memory accounting is
far from trivial (as can be evidenced by this patch), so in practice
most BPF applications still do unconditional RLIMIT_MEMLOCK increase.

As we move towards libbpf 1.0, it would be good to allow users to forget
about RLIMIT_MEMLOCK vs memcg and let libbpf do the sensible adjustment
automatically. This patch paves the way forward in this matter. Libbpf
will do feature detection of memcg-based accounting, and if detected,
will do nothing. But if the kernel is too old, just like BCC, libbpf
will automatically increase RLIMIT_MEMLOCK on behalf of user
application ([0]).

As this is technically a breaking change, during the transition period
applications have to opt into libbpf 1.0 mode by setting
LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK bit when calling
libbpf_set_strict_mode().

Libbpf allows to control the exact amount of set RLIMIT_MEMLOCK limit
with libbpf_set_memlock_rlim_max() API. Passing 0 will make libbpf do
nothing with RLIMIT_MEMLOCK. libbpf_set_memlock_rlim_max() has to be
called before the first bpf_prog_load(), bpf_btf_load(), or
bpf_object__load() call, otherwise it has no effect and will return
-EBUSY.

  [0] Closes: https://github.com/libbpf/libbpf/issues/369

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c             | 121 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h             |   2 +
 tools/lib/bpf/libbpf.c          |  47 +++----------
 tools/lib/bpf/libbpf.map        |   1 +
 tools/lib/bpf/libbpf_internal.h |  39 ++++++++++
 tools/lib/bpf/libbpf_legacy.h   |  12 +++-
 6 files changed, 183 insertions(+), 39 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 6b2407e12060..7c82136979bf 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -29,6 +29,7 @@
 #include <errno.h>
 #include <linux/bpf.h>
 #include <limits.h>
+#include <sys/resource.h>
 #include "bpf.h"
 #include "libbpf.h"
 #include "libbpf_internal.h"
@@ -94,6 +95,118 @@ static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int
 	return fd;
 }
 
+/* Probe whether kernel switched from memlock-based (RLIMIT_MEMLOCK) to
+ * memcg-based memory accounting for BPF maps and progs. This was done in [0],
+ * but it's not straightforward to detect those changes from the user-space.
+ * So instead we'll try to detect whether [1] is in the kernel, which follows
+ * [0] almost immediately and made it into the upstream kernel in the same
+ * release.
+ *
+ * For this, we'll upload a trivial BTF into the kernel and will try to load
+ * a trivial BPF program with attach_btf_obj_fd pointing to our BTF. If it
+ * returns anything but -ENOTSUPP, we'll assume we still need RLIMIT_MEMLOCK.
+ *
+ *   [0] https://lore.kernel.org/bpf/20201201215900.3569844-1-guro@fb.com/
+ *   [1] Fixes: 8bdd8e275ede ("bpf: Return -ENOTSUPP when attaching to non-kernel BTF")
+ */
+int probe_memcg_account(void)
+{
+	const size_t bpf_load_attr_sz = offsetofend(union bpf_attr, attach_btf_obj_fd);
+	const size_t btf_load_attr_sz = offsetofend(union bpf_attr, btf_log_level);
+	int prog_fd = -1, btf_fd = -1, err;
+	struct bpf_insn insns[1] = {}; /* instructions don't matter */
+	const void *btf_data;
+	union bpf_attr attr;
+	__u32 btf_data_sz;
+	struct btf *btf;
+
+	/* create the simplest BTF object and upload it into the kernel */
+	btf = btf__new_empty();
+	err = libbpf_get_error(btf);
+	if (err)
+		return err;
+	err = btf__add_int(btf, "int", 4, 0);
+	btf_data = btf__raw_data(btf, &btf_data_sz);
+	if (!btf_data) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+
+	/* we won't use bpf_btf_load() or bpf_prog_load() because they will
+	 * be trying to detect this feature and will cause an infinite loop
+	 */
+	memset(&attr, 0, btf_load_attr_sz);
+	attr.btf = ptr_to_u64(btf_data);
+	attr.btf_size = btf_data_sz;
+	btf_fd = sys_bpf_fd(BPF_BTF_LOAD, &attr, btf_load_attr_sz);
+	if (btf_fd < 0) {
+		err = -errno;
+		goto cleanup;
+	}
+
+	/* attempt loading freplace trying to use custom BTF */
+	memset(&attr, 0, bpf_load_attr_sz);
+	attr.prog_type = BPF_PROG_TYPE_TRACING;
+	attr.expected_attach_type = BPF_TRACE_FENTRY;
+	attr.insns = ptr_to_u64(insns);
+	attr.insn_cnt = sizeof(insns) / sizeof(insns[0]);
+	attr.license = ptr_to_u64("GPL");
+	attr.attach_btf_obj_fd = btf_fd;
+
+	prog_fd = sys_bpf_fd(BPF_PROG_LOAD, &attr, bpf_load_attr_sz);
+	if (prog_fd >= 0)
+		/* bug? we shouldn't be able to successfully load program */
+		err = -EFAULT;
+	else
+		/* assume memcg accounting is supported if we get -ENOTSUPP */
+		err = errno == 524 /* ENOTSUPP */ ? 1 : 0;
+
+cleanup:
+	btf__free(btf);
+	if (btf_fd >= 0)
+		close(btf_fd);
+	if (prog_fd >= 0)
+		close(prog_fd);
+	return err;
+}
+
+static bool memlock_bumped;
+static rlim_t memlock_rlim_max = RLIM_INFINITY;
+
+int libbpf_set_memlock_rlim_max(size_t memlock_max)
+{
+	if (memlock_bumped)
+		return libbpf_err(-EBUSY);
+
+	memlock_rlim_max = memlock_max;
+	return 0;
+}
+
+int bump_rlimit_memlock(void)
+{
+	struct rlimit rlim;
+
+	/* this the default in libbpf 1.0, but for now user has to opt-in explicitly */
+	if (!(libbpf_mode & LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK))
+		return 0;
+
+	/* if kernel supports memcg-based accounting, skip bumping RLIMIT_MEMLOCK */
+	if (memlock_bumped || kernel_supports(NULL, FEAT_MEMCG_ACCOUNT))
+		return 0;
+
+	memlock_bumped = true;
+
+	/* zero memlock_rlim_max disables auto-bumping RLIMIT_MEMLOCK */
+	if (memlock_rlim_max == 0)
+		return 0;
+
+	rlim.rlim_cur = rlim.rlim_max = memlock_rlim_max;
+	if (setrlimit(RLIMIT_MEMLOCK, &rlim))
+		return -errno;
+
+	return 0;
+}
+
 int bpf_map_create(enum bpf_map_type map_type,
 		   const char *map_name,
 		   __u32 key_size,
@@ -105,6 +218,8 @@ int bpf_map_create(enum bpf_map_type map_type,
 	union bpf_attr attr;
 	int fd;
 
+	bump_rlimit_memlock();
+
 	memset(&attr, 0, attr_sz);
 
 	if (!OPTS_VALID(opts, bpf_map_create_opts))
@@ -251,6 +366,8 @@ int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
 	union bpf_attr attr;
 	char *log_buf;
 
+	bump_rlimit_memlock();
+
 	if (!OPTS_VALID(opts, bpf_prog_load_opts))
 		return libbpf_err(-EINVAL);
 
@@ -456,6 +573,8 @@ int bpf_verify_program(enum bpf_prog_type type, const struct bpf_insn *insns,
 	union bpf_attr attr;
 	int fd;
 
+	bump_rlimit_memlock();
+
 	memset(&attr, 0, sizeof(attr));
 	attr.prog_type = type;
 	attr.insn_cnt = (__u32)insns_cnt;
@@ -1056,6 +1175,8 @@ int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf_btf_loa
 	__u32 log_level;
 	int fd;
 
+	bump_rlimit_memlock();
+
 	memset(&attr, 0, attr_sz);
 
 	if (!OPTS_VALID(opts, bpf_btf_load_opts))
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 94e553a0ff9d..752c076e9bb8 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -35,6 +35,8 @@
 extern "C" {
 #endif
 
+int libbpf_set_memlock_rlim_max(size_t memlock_max);
+
 struct bpf_map_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d027e1d620fc..4e842ce14080 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -187,42 +187,6 @@ const char *libbpf_version_string(void)
 #undef __S
 }
 
-enum kern_feature_id {
-	/* v4.14: kernel support for program & map names. */
-	FEAT_PROG_NAME,
-	/* v5.2: kernel support for global data sections. */
-	FEAT_GLOBAL_DATA,
-	/* BTF support */
-	FEAT_BTF,
-	/* BTF_KIND_FUNC and BTF_KIND_FUNC_PROTO support */
-	FEAT_BTF_FUNC,
-	/* BTF_KIND_VAR and BTF_KIND_DATASEC support */
-	FEAT_BTF_DATASEC,
-	/* BTF_FUNC_GLOBAL is supported */
-	FEAT_BTF_GLOBAL_FUNC,
-	/* BPF_F_MMAPABLE is supported for arrays */
-	FEAT_ARRAY_MMAP,
-	/* kernel support for expected_attach_type in BPF_PROG_LOAD */
-	FEAT_EXP_ATTACH_TYPE,
-	/* bpf_probe_read_{kernel,user}[_str] helpers */
-	FEAT_PROBE_READ_KERN,
-	/* BPF_PROG_BIND_MAP is supported */
-	FEAT_PROG_BIND_MAP,
-	/* Kernel support for module BTFs */
-	FEAT_MODULE_BTF,
-	/* BTF_KIND_FLOAT support */
-	FEAT_BTF_FLOAT,
-	/* BPF perf link support */
-	FEAT_PERF_LINK,
-	/* BTF_KIND_DECL_TAG support */
-	FEAT_BTF_DECL_TAG,
-	/* BTF_KIND_TYPE_TAG support */
-	FEAT_BTF_TYPE_TAG,
-	__FEAT_CNT,
-};
-
-static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id);
-
 enum reloc_type {
 	RELO_LD64,
 	RELO_CALL,
@@ -4354,6 +4318,10 @@ bpf_object__probe_loading(struct bpf_object *obj)
 	if (obj->gen_loader)
 		return 0;
 
+	ret = bump_rlimit_memlock();
+	if (ret)
+		pr_warn("Failed to bump RLIMIT_MEMLOCK (err = %d), you might need to do it explicitly!\n", ret);
+
 	/* make sure basic loading works */
 	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
 	if (ret < 0)
@@ -4720,14 +4688,17 @@ static struct kern_feature_desc {
 	[FEAT_BTF_TYPE_TAG] = {
 		"BTF_KIND_TYPE_TAG support", probe_kern_btf_type_tag,
 	},
+	[FEAT_MEMCG_ACCOUNT] = {
+		"memcg-based memory accounting", probe_memcg_account,
+	},
 };
 
-static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
+bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 {
 	struct kern_feature_desc *feat = &feature_probes[feat_id];
 	int ret;
 
-	if (obj->gen_loader)
+	if (obj && obj->gen_loader)
 		/* To generate loader program assume the latest kernel
 		 * to avoid doing extra prog_load, map_create syscalls.
 		 */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 4d483af7dba6..b3938b3f8fc9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -427,4 +427,5 @@ LIBBPF_0.7.0 {
 		bpf_program__log_level;
 		bpf_program__set_log_buf;
 		bpf_program__set_log_level;
+		libbpf_set_memlock_rlim_max;
 };
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 355c41019aed..0a6754606234 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -272,6 +272,45 @@ static inline bool libbpf_validate_opts(const char *opts,
 					(opts)->sz - __off);		      \
 })
 
+enum kern_feature_id {
+	/* v4.14: kernel support for program & map names. */
+	FEAT_PROG_NAME,
+	/* v5.2: kernel support for global data sections. */
+	FEAT_GLOBAL_DATA,
+	/* BTF support */
+	FEAT_BTF,
+	/* BTF_KIND_FUNC and BTF_KIND_FUNC_PROTO support */
+	FEAT_BTF_FUNC,
+	/* BTF_KIND_VAR and BTF_KIND_DATASEC support */
+	FEAT_BTF_DATASEC,
+	/* BTF_FUNC_GLOBAL is supported */
+	FEAT_BTF_GLOBAL_FUNC,
+	/* BPF_F_MMAPABLE is supported for arrays */
+	FEAT_ARRAY_MMAP,
+	/* kernel support for expected_attach_type in BPF_PROG_LOAD */
+	FEAT_EXP_ATTACH_TYPE,
+	/* bpf_probe_read_{kernel,user}[_str] helpers */
+	FEAT_PROBE_READ_KERN,
+	/* BPF_PROG_BIND_MAP is supported */
+	FEAT_PROG_BIND_MAP,
+	/* Kernel support for module BTFs */
+	FEAT_MODULE_BTF,
+	/* BTF_KIND_FLOAT support */
+	FEAT_BTF_FLOAT,
+	/* BPF perf link support */
+	FEAT_PERF_LINK,
+	/* BTF_KIND_DECL_TAG support */
+	FEAT_BTF_DECL_TAG,
+	/* BTF_KIND_TYPE_TAG support */
+	FEAT_BTF_TYPE_TAG,
+	/* memcg-based accounting for BPF maps and progs */
+	FEAT_MEMCG_ACCOUNT,
+	__FEAT_CNT,
+};
+
+int probe_memcg_account(void);
+bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id);
+int bump_rlimit_memlock(void);
 
 int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz);
 int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);
diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legacy.h
index bb03c568af7b..79131f761a27 100644
--- a/tools/lib/bpf/libbpf_legacy.h
+++ b/tools/lib/bpf/libbpf_legacy.h
@@ -45,7 +45,6 @@ enum libbpf_strict_mode {
 	 * (positive) error code.
 	 */
 	LIBBPF_STRICT_DIRECT_ERRS = 0x02,
-
 	/*
 	 * Enforce strict BPF program section (SEC()) names.
 	 * E.g., while prefiously SEC("xdp_whatever") or SEC("perf_event_blah") were
@@ -63,6 +62,17 @@ enum libbpf_strict_mode {
 	 * Clients can maintain it on their own if it is valuable for them.
 	 */
 	LIBBPF_STRICT_NO_OBJECT_LIST = 0x08,
+	/*
+	 * Automatically bump RLIMIT_MEMLOCK using setrlimit() before the
+	 * first BPF program or map creation operation. This is done only if
+	 * kernel is too old to support memcg-based memory accounting for BPF
+	 * subsystem. By default, RLIMIT_MEMLOCK limit is set to RLIM_INFINITY,
+	 * but it can be overriden with libbpf_set_memlock_rlim_max() API.
+	 * Note that libbpf_set_memlock_rlim_max() needs to be called before
+	 * the very first bpf_prog_load(), bpf_map_create() or bpf_object__load()
+	 * operation.
+	 */
+	LIBBPF_STRICT_AUTO_RLIMIT_MEMLOCK = 0x10,
 
 	__LIBBPF_STRICT_LAST,
 };
-- 
2.30.2

