Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186E54EFD70
	for <lists+bpf@lfdr.de>; Sat,  2 Apr 2022 02:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbiDBAb7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 1 Apr 2022 20:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiDBAb6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 20:31:58 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDE81A6E68
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 17:30:06 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2320C1Nh026579
        for <bpf@vger.kernel.org>; Fri, 1 Apr 2022 17:30:05 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f5gpf2n5t-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 17:30:05 -0700
Received: from twshared10896.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 17:30:03 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 9884515EB5193; Fri,  1 Apr 2022 17:29:49 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 bpf-next 2/7] libbpf: wire up USDT API and bpf_link integration
Date:   Fri, 1 Apr 2022 17:29:39 -0700
Message-ID: <20220402002944.382019-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220402002944.382019-1-andrii@kernel.org>
References: <20220402002944.382019-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RUgdfuUqz2r8U4mfxSCvprtogUhq2Kn_
X-Proofpoint-GUID: RUgdfuUqz2r8U4mfxSCvprtogUhq2Kn_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_08,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wire up libbpf USDT support APIs without yet implementing all the
nitty-gritty details of USDT discovery, spec parsing, and BPF map
initialization.

User-visible user-space API is simple and is conceptually very similar
to uprobe API.

bpf_program__attach_usdt() API allows to programmatically attach given
BPF program to a USDT, specified through binary path (executable or
shared lib), USDT provider and name. Also, just like in uprobe case, PID
filter is specified (0 - self, -1 - any process, or specific PID).
Optionally, USDT cookie value can be specified. Such single API
invocation will try to discover given USDT in specified binary and will
use (potentially many) BPF uprobes to attach this program in correct
locations.

Just like any bpf_program__attach_xxx() APIs, bpf_link is returned that
represents this attachment. It is a virtual BPF link that doesn't have
direct kernel object, as it can consist of multiple underlying BPF
uprobe links. As such, attachment is not atomic operation and there can
be brief moment when some USDT call sites are attached while others are
still in the process of attaching. This should be taken into
consideration by user. But bpf_program__attach_usdt() guarantees that
in the case of success all USDT call sites are successfully attached, or
all the successfuly attachments will be detached as soon as some USDT
call sites failed to be attached. So, in theory, there could be cases of
failed bpf_program__attach_usdt() call which did trigger few USDT
program invocations. This is unavoidable due to multi-uprobe nature of
USDT and has to be handled by user, if it's important to create an
illusion of atomicity.

USDT BPF programs themselves are marked in BPF source code as either
SEC("usdt"), in which case they won't be auto-attached through
skeleton's <skel>__attach() method, or it can have a full definition,
which follows the spirit of fully-specified uprobes:
SEC("usdt/<path>:<provider>:<name>"). In the latter case skeleton's
attach method will attempt auto-attachment. Similarly, generic
bpf_program__attach() will have enought information to go off of for
parameterless attachment.

USDT BPF programs are actually uprobes, and as such for kernel they are
marked as BPF_PROG_TYPE_KPROBE.

Another part of this patch is USDT-related feature probing:
  - BPF cookie support detection from user-space;
  - detection of kernel support for auto-refcounting of USDT semaphore.

The latter is optional. If kernel doesn't support such feature and USDT
doesn't rely on USDT semaphores, no error is returned. But if libbpf
detects that USDT requires setting semaphores and kernel doesn't support
this, libbpf errors out with explicit pr_warn() message. Libbpf doesn't
support poking process's memory directly to increment semaphore value,
like BCC does on legacy kernels, due to inherent raciness and danger of
such process memory manipulation. Libbpf let's kernel take care of this
properly or gives up.

Logistically, all the extra USDT-related infrastructure of libbpf is put
into a separate usdt.c file and abstracted behind struct usdt_manager.
Each bpf_object has lazily-initialized usdt_manager pointer, which is
only instantiated if USDT programs are attempted to be attached. Closing
BPF object frees up usdt_manager resources. usdt_manager keeps track of
USDT spec ID assignment and few other small things.

Subsequent patches will fill out remaining missing pieces of USDT
initialization and setup logic.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Build             |   3 +-
 tools/lib/bpf/libbpf.c          | 100 +++++++-
 tools/lib/bpf/libbpf.h          |  31 +++
 tools/lib/bpf/libbpf.map        |   1 +
 tools/lib/bpf/libbpf_internal.h |  19 ++
 tools/lib/bpf/usdt.c            | 426 ++++++++++++++++++++++++++++++++
 6 files changed, 571 insertions(+), 9 deletions(-)
 create mode 100644 tools/lib/bpf/usdt.c

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index 94f0a146bb7b..31a1a9015902 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,3 +1,4 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o xsk.o hashmap.o \
-	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o
+	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
+	    usdt.o
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 809fe209cdcc..ed0f2ff61561 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -483,6 +483,8 @@ struct elf_state {
 	int st_ops_shndx;
 };
 
+struct usdt_manager;
+
 struct bpf_object {
 	char name[BPF_OBJ_NAME_LEN];
 	char license[64];
@@ -545,6 +547,8 @@ struct bpf_object {
 	size_t fd_array_cap;
 	size_t fd_array_cnt;
 
+	struct usdt_manager *usdt_man;
+
 	char path[];
 };
 
@@ -4678,6 +4682,18 @@ static int probe_perf_link(void)
 	return link_fd < 0 && err == -EBADF;
 }
 
+static int probe_kern_bpf_cookie(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_attach_cookie),
+		BPF_EXIT_INSN(),
+	};
+	int ret, insn_cnt = ARRAY_SIZE(insns);
+
+	ret = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns, insn_cnt, NULL);
+	return probe_fd(ret);
+}
+
 enum kern_feature_result {
 	FEAT_UNKNOWN = 0,
 	FEAT_SUPPORTED = 1,
@@ -4740,6 +4756,9 @@ static struct kern_feature_desc {
 	[FEAT_MEMCG_ACCOUNT] = {
 		"memcg-based memory accounting", probe_memcg_account,
 	},
+	[FEAT_BPF_COOKIE] = {
+		"BPF cookie support", probe_kern_bpf_cookie,
+	},
 };
 
 bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
@@ -8200,6 +8219,9 @@ void bpf_object__close(struct bpf_object *obj)
 	if (obj->clear_priv)
 		obj->clear_priv(obj, obj->priv);
 
+	usdt_manager_free(obj->usdt_man);
+	obj->usdt_man = NULL;
+
 	bpf_gen__free(obj->gen_loader);
 	bpf_object__elf_finish(obj);
 	bpf_object_unload(obj);
@@ -8630,6 +8652,7 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
 }
 
 static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_usdt(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
@@ -8647,6 +8670,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("uretprobe/",		KPROBE, 0, SEC_NONE),
 	SEC_DEF("kprobe.multi/",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kretprobe.multi/",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
+	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
 	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE),
 	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE | SEC_SLOPPY_PFX | SEC_DEPRECATED),
 	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE | SEC_SLOPPY_PFX),
@@ -9692,14 +9716,6 @@ int bpf_prog_load_deprecated(const char *file, enum bpf_prog_type type,
 	return bpf_prog_load_xattr2(&attr, pobj, prog_fd);
 }
 
-struct bpf_link {
-	int (*detach)(struct bpf_link *link);
-	void (*dealloc)(struct bpf_link *link);
-	char *pin_path;		/* NULL, if not pinned */
-	int fd;			/* hook FD, -1 if not applicable */
-	bool disconnected;
-};
-
 /* Replace link's underlying BPF program with the new one */
 int bpf_link__update_program(struct bpf_link *link, struct bpf_program *prog)
 {
@@ -10599,6 +10615,74 @@ struct bpf_link *bpf_program__attach_uprobe(const struct bpf_program *prog,
 	return bpf_program__attach_uprobe_opts(prog, pid, binary_path, func_offset, &opts);
 }
 
+struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
+					  pid_t pid, const char *binary_path,
+					  const char *usdt_provider, const char *usdt_name,
+					  const struct bpf_usdt_opts *opts)
+{
+	struct bpf_object *obj = prog->obj;
+	struct bpf_link *link;
+	long usdt_cookie;
+	int err;
+
+	if (!OPTS_VALID(opts, bpf_uprobe_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	if (bpf_program__fd(prog) < 0) {
+		pr_warn("prog '%s': can't attach BPF program w/o FD (did you load it?)\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	/* USDT manager is instantiated lazily on first USDT attach. It will
+	 * be destroyed together with BPF object in bpf_object__close().
+	 */
+	if (IS_ERR(obj->usdt_man))
+		return libbpf_ptr(obj->usdt_man);
+	if (!obj->usdt_man) {
+		obj->usdt_man = usdt_manager_new(obj);
+		if (IS_ERR(obj->usdt_man))
+			return libbpf_ptr(obj->usdt_man);
+	}
+
+	usdt_cookie = OPTS_GET(opts, usdt_cookie, 0);
+	link = usdt_manager_attach_usdt(obj->usdt_man, prog, pid, binary_path,
+				        usdt_provider, usdt_name, usdt_cookie);
+	err = libbpf_get_error(link);
+	if (err)
+		return libbpf_err_ptr(err);
+	return link;
+}
+
+static int attach_usdt(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	char *path = NULL, *provider = NULL, *name = NULL;
+	const char *sec_name;
+	int n, err;
+
+	sec_name = bpf_program__section_name(prog);
+	if (strcmp(sec_name, "usdt") == 0) {
+		/* no auto-attach for just SEC("usdt") */
+		*link = NULL;
+		return 0;
+	}
+
+	n = sscanf(sec_name, "usdt/%m[^:]:%m[^:]:%m[^:]", &path, &provider, &name);
+	if (n != 3) {
+		pr_warn("invalid section '%s', expected SEC(\"usdt/<path>:<provider>:<name>\")\n",
+			sec_name);
+		err = -EINVAL;
+	} else {
+		*link = bpf_program__attach_usdt(prog, -1 /* any process */, path,
+						 provider, name, NULL);
+		err = libbpf_get_error(*link);
+	}
+	free(path);
+	free(provider);
+	free(name);
+	return err;
+}
+
 static int determine_tracepoint_id(const char *tp_category,
 				   const char *tp_name)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 05dde85e19a6..66d346cd2069 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -503,6 +503,37 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 				const char *binary_path, size_t func_offset,
 				const struct bpf_uprobe_opts *opts);
 
+struct bpf_usdt_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	/* custom user-provided value accessible through usdt_cookie() */
+	__u64 usdt_cookie;
+	size_t :0;
+};
+#define bpf_usdt_opts__last_field usdt_cookie
+
+/**
+ * @brief **bpf_program__attach_usdt()** is just like
+ * bpf_program__attach_uprobe_opts() except it covers USDT (User-space
+ * Statically Defined Tracepoint) attachment, instead of attaching to
+ * user-space function entry or exit.
+ *
+ * @param prog BPF program to attach
+ * @param pid Process ID to attach the uprobe to, 0 for self (own process),
+ * -1 for all processes
+ * @param binary_path Path to binary that contains provided USDT probe
+ * @param usdt_provider USDT provider name
+ * @param usdt_name USDT probe name
+ * @param opts Options for altering program attachment
+ * @return Reference to the newly created BPF link; or NULL is returned on error,
+ * error code is stored in errno
+ */
+LIBBPF_API struct bpf_link *
+bpf_program__attach_usdt(const struct bpf_program *prog,
+			 pid_t pid, const char *binary_path,
+			 const char *usdt_provider, const char *usdt_name,
+			 const struct bpf_usdt_opts *opts);
+
 struct bpf_tracepoint_opts {
 	/* size of this struct, for forward/backward compatiblity */
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index dd35ee58bfaa..82f6d62176dd 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -444,6 +444,7 @@ LIBBPF_0.8.0 {
 	global:
 		bpf_object__destroy_subskeleton;
 		bpf_object__open_subskeleton;
+		bpf_program__attach_usdt;
 		libbpf_register_prog_handler;
 		libbpf_unregister_prog_handler;
 		bpf_program__attach_kprobe_multi_opts;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index b6247dc7f8eb..dd0d4ccfa649 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -148,6 +148,15 @@ do {				\
 #ifndef __has_builtin
 #define __has_builtin(x) 0
 #endif
+
+struct bpf_link {
+	int (*detach)(struct bpf_link *link);
+	void (*dealloc)(struct bpf_link *link);
+	char *pin_path;		/* NULL, if not pinned */
+	int fd;			/* hook FD, -1 if not applicable */
+	bool disconnected;
+};
+
 /*
  * Re-implement glibc's reallocarray() for libbpf internal-only use.
  * reallocarray(), unfortunately, is not available in all versions of glibc,
@@ -329,6 +338,8 @@ enum kern_feature_id {
 	FEAT_BTF_TYPE_TAG,
 	/* memcg-based accounting for BPF maps and progs */
 	FEAT_MEMCG_ACCOUNT,
+	/* BPF cookie (bpf_get_attach_cookie() BPF helper) support */
+	FEAT_BPF_COOKIE,
 	__FEAT_CNT,
 };
 
@@ -543,4 +554,12 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
 		       struct bpf_core_cand_list *cands);
 void bpf_core_free_cands(struct bpf_core_cand_list *cands);
 
+struct usdt_manager *usdt_manager_new(struct bpf_object *obj);
+void usdt_manager_free(struct usdt_manager *man);
+struct bpf_link * usdt_manager_attach_usdt(struct usdt_manager *man,
+					   const struct bpf_program *prog,
+					   pid_t pid, const char *path,
+					   const char *usdt_provider, const char *usdt_name,
+					   long usdt_cookie);
+
 #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
new file mode 100644
index 000000000000..9476f7a15769
--- /dev/null
+++ b/tools/lib/bpf/usdt.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#include <ctype.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <libelf.h>
+#include <gelf.h>
+#include <unistd.h>
+#include <linux/ptrace.h>
+#include <linux/kernel.h>
+
+#include "bpf.h"
+#include "libbpf.h"
+#include "libbpf_common.h"
+#include "libbpf_internal.h"
+#include "hashmap.h"
+
+/* libbpf's USDT support consists of BPF-side state/code and user-space
+ * state/code working together in concert. BPF-side parts are defined in
+ * usdt.bpf.h header library. User-space state is encapsulated by struct
+ * usdt_manager and all the supporting code centered around usdt_manager.
+ *
+ * usdt.bpf.h defines two BPF maps that usdt_manager expects: USDT spec map
+ * and IP-to-spec-ID map, which is auxiliary map necessary for kernels that
+ * don't support BPF cookie (see below). These two maps are implicitly
+ * embedded into user's end BPF object file when user's code included
+ * usdt.bpf.h. This means that libbpf doesn't do anything special to create
+ * these USDT support maps. They are created by normal libbpf logic of
+ * instantiating BPF maps when opening and loading BPF object.
+ *
+ * As such, libbpf is basically unaware of the need to do anything
+ * USDT-related until the very first call to bpf_program__attach_usdt(), which
+ * can be called by user explicitly or happen automatically during skeleton
+ * attach (or, equivalently, through generic bpf_program__attach() call). At
+ * this point, libbpf will instantiate and initialize struct usdt_manager and
+ * store it in bpf_object. USDT manager is per-BPF object construct, as each
+ * independent BPF object might or might not have USDT programs, and thus all
+ * the expected USDT-related state. There is no coordination between two
+ * bpf_object in parts of USDT attachment, they are oblivious of each other's
+ * existence and libbpf is just oblivious, dealing with bpf_object-specific
+ * USDT state.
+ *
+ * Quick crash course on USDTs.
+ *
+ * From user-space application's point of view, USDT is essentially just
+ * a slightly special function call that normally has zero overhead, unless it
+ * is being traced by some external entity (e.g, BPF-based tool). Here's how
+ * a typical application can trigger USDT probe:
+ *
+ * #include <sys/sdt.h>  // provided by systemtap-sdt-devel package
+ * // folly also provide similar functionality in folly/tracing/StaticTracepoint.h
+ *
+ * STAP_PROBE3(my_usdt_provider, my_usdt_probe_name, 123, x, &y);
+ *
+ * USDT is identified by it's <provider-name>:<probe-name> pair of names. Each
+ * individual USDT has a fixed number of arguments (3 in the above example)
+ * and specifies values of each argument as if it was a function call.
+ *
+ * USDT call is actually not a function call, but is instead replaced by
+ * a single NOP instruction (thus zero overhead, effectively). But in addition
+ * to that, those USDT macros generate special SHT_NOTE ELF records in
+ * .note.stapsdt ELF section. Here's an example USDT definition as emitted by
+ * `readelf -n <binary>`:
+ *
+ *   stapsdt              0x00000089       NT_STAPSDT (SystemTap probe descriptors)
+ *   Provider: test
+ *   Name: usdt12
+ *   Location: 0x0000000000549df3, Base: 0x00000000008effa4, Semaphore: 0x0000000000a4606e
+ *   Arguments: -4@-1204(%rbp) -4@%edi -8@-1216(%rbp) -8@%r8 -4@$5 -8@%r9 8@%rdx 8@%r10 -4@$-9 -2@%cx -2@%ax -1@%sil
+ *
+ * In this case we have USDT test:usdt12 with 12 arguments.
+ *
+ * Location and base are offsets used to calculate absolute IP address of that
+ * NOP instruction that kernel can replace with an interrupt instruction to
+ * trigger instrumentation code (BPF program for all that we care about).
+ *
+ * Semaphore above is and optional feature. It records an address of a 2-byte
+ * refcount variable (normally in '.probes' ELF section) used for signaling if
+ * there is anything that is attached to USDT. This is useful for user
+ * applications if, for example, they need to prepare some arguments that are
+ * passed only to USDTs and preparation is expensive. By checking if USDT is
+ * "activated", an application can avoid paying those costs unnecessarily.
+ * Recent enough kernel has built-in support for automatically managing this
+ * refcount, which libbpf expects and relies on. If USDT is defined without
+ * associated semaphore, this value will be zero. See selftests for semaphore
+ * examples.
+ *
+ * Arguments is the most interesting part. This USDT specification string is
+ * providing information about all the USDT arguments and their locations. The
+ * part before @ sign defined byte size of the argument (1, 2, 4, or 8) and
+ * whether the argument is singed or unsigned (negative size means signed).
+ * The part after @ sign is assembly-like definition of argument location.
+ * Technically, assembler can provide some pretty advanced definitions, but
+ * libbpf is currently supporting three most common cases:
+ *   1) immediate constant, see 5th and 9th args above (-4@$5 and -4@-9);
+ *   2) register value, e.g., 8@%rdx, which means "unsigned 8-byte integer
+ *      whose value is in register %rdx";
+ *   3) memory dereference addressed by register, e.g., -4@-1204(%rbp), which
+ *      specifies signed 32-bit integer stored at offset -1204 bytes from
+ *      memory address stored in %rbp.
+ *
+ * During attachment, libbpf parses all the relevant USDT specifications and
+ * prepares `struct usdt_spec` (USDT spec), which is then provided to BPF-side
+ * code through spec map. This allows BPF applications to quickly fetch the
+ * actual value at runtime using a simple BPF-side code.
+ *
+ * With basics out of the way, let's go over less immeditately obvious aspects
+ * of supporting USDTs.
+ *
+ * First, there is no special USDT BPF program type. It is actually just
+ * a uprobe BPF program (which for kernel, at least currently, is just a kprobe
+ * program, so BPF_PROG_TYPE_KPROBE program type). With the only difference
+ * that uprobe is usually attached at the function entry, while USDT will
+ * normally will be somewhere inside the function. But it should always be
+ * pointing to NOP instruction, which makes such uprobes the fastest uprobe
+ * kind.
+ *
+ * Second, it's important to realize that such STAP_PROBEn(provider, name, ...)
+ * macro invocations can end up being inlined many-many times, depending on
+ * specifics of each individual user application. So single conceptual USDT
+ * (identified by provider:name pair of identifiers) is, generally speaking,
+ * multiple uprobe locations (USDT call sites) in different places in user
+ * application. Further, again due to inlining, each USDT call site might end
+ * up having the same argument #N be located in a different place. In one call
+ * site it could be a constant, in another will end up in a register, and in
+ * yet another could be some other register or even somewhere on the stack.
+ *
+ * As such, "attaching to USDT" means (in general case) attaching the same
+ * uprobe BPF program to multiple target locations in user application, each
+ * potentially having a completely different USDT spec associated with it.
+ * To wire all this up together libbpf allocates a unique integer spec ID for
+ * each unique USDT spec. Spec IDs are allocated as sequential small integers
+ * so that they can be used as keys in array BPF map (for performance reasons).
+ * Spec ID allocation and accounting is big part of what usdt_manager is
+ * about. This state has to be maintained per-BPF object and coordinate
+ * between different USDT attachments within the same BPF object.
+ *
+ * Spec ID is the key in spec BPF map, value is the actual USDT spec layed out
+ * as struct usdt_spec. Each invocation of BPF program at runtime needs to
+ * know its associated spec ID. It gets it either through BPF cookie, which
+ * libbpf sets to spec ID during attach time, or, if kernel is too old to
+ * support BPF cookie, through IP-to-spec-ID map that libbpf maintains in such
+ * case. The latter means that some modes of operation can't be supported
+ * without BPF cookie. Such mode is attaching to shared library "generically",
+ * without specifying target process. In such case, it's impossible to
+ * calculate absolute IP addresses for IP-to-spec-ID map, and thus such mode
+ * is not supported without BPF cookie support.
+ *
+ * Note that libbpf is using BPF cookie functionality for its own internal
+ * needs, so user itself can't rely on BPF cookie feature. To that end, libbpf
+ * provides conceptually equivalent USDT cookie support. It's still u64
+ * user-provided value that can be associated with USDT attachment. Note that
+ * this will be the same value for all USDT call sites within the same single
+ * *logical* USDT attachment. This makes sense because to user attaching to
+ * USDT is a single BPF program triggered for singular USDT probe. The fact
+ * that this is done at multiple actual locations is a mostly hidden
+ * implementation details. This USDT cookie value can be fetched with
+ * bpf_usdt_cookie(ctx) API provided by usdt.bpf.h
+ *
+ * Lastly, while single USDT can have tons of USDT call sites, it doesn't
+ * necessarily have that many different USDT specs. It very well might be
+ * that 1000 USDT call sites only need 5 different USDT specs, because all the
+ * arguments are typically contained in a small set of registers or stack
+ * locations. As such, it's wasteful to allocate as many USDT spec IDs as
+ * there are USDT call sites. So libbpf tries to be frugal and performs
+ * on-the-fly deduplication during a single USDT attachment to only allocate
+ * the minimal required amount of unique USDT specs (and thus spec IDs). This
+ * is trivially achieved by using USDT spec string (Arguments string from USDT
+ * note) as a lookup key in a hashmap. USDT spec string uniquely defines
+ * everything about how to fetch USDT arguments, so two USDT call sites
+ * sharing USDT spec string can safely share the same USDT spec and spec ID.
+ * Note, this spec string deduplication is happening only during the same USDT
+ * attachment, so each USDT spec shares the same USDT cookie value. This is
+ * not generally true for other USDT attachments within the same BPF object,
+ * as even if USDT spec string is the same, USDT cookie value can be
+ * different. It was deemed excessive to try to deduplicate across independent
+ * USDT attachments by taking into account USDT spec string *and* USDT cookie
+ * value, which would complicated spec ID accounting significantly for little
+ * gain.
+ */
+
+struct usdt_target {
+	long abs_ip;
+	long rel_ip;
+	long sema_off;
+};
+
+struct usdt_manager {
+	struct bpf_map *specs_map;
+	struct bpf_map *ip_to_spec_id_map;
+
+	bool has_bpf_cookie;
+	bool has_sema_refcnt;
+};
+
+struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
+{
+	static const char *ref_ctr_sysfs_path = "/sys/bus/event_source/devices/uprobe/format/ref_ctr_offset";
+	struct usdt_manager *man;
+	struct bpf_map *specs_map, *ip_to_spec_id_map;
+
+	specs_map = bpf_object__find_map_by_name(obj, "__bpf_usdt_specs");
+	ip_to_spec_id_map = bpf_object__find_map_by_name(obj, "__bpf_usdt_ip_to_spec_id");
+	if (!specs_map || !ip_to_spec_id_map) {
+		pr_warn("usdt: failed to find USDT support BPF maps, did you forget to include bpf/usdt.bpf.h?\n");
+		return ERR_PTR(-ESRCH);
+	}
+
+	man = calloc(1, sizeof(*man));
+	if (!man)
+		return ERR_PTR(-ENOMEM);
+
+	man->specs_map = specs_map;
+	man->ip_to_spec_id_map = ip_to_spec_id_map;
+
+	/* Detect if BPF cookie is supported for kprobes.
+	 * We don't need IP-to-ID mapping if we can use BPF cookies.
+	 * Added in: 7adfc6c9b315 ("bpf: Add bpf_get_attach_cookie() BPF helper to access bpf_cookie value")
+	 */
+	man->has_bpf_cookie = kernel_supports(obj, FEAT_BPF_COOKIE);
+
+	/* Detect kernel support for automatic refcounting of USDT semaphore.
+	 * If this is not supported, USDTs with semaphores will not be supported.
+	 * Added in: a6ca88b241d5 ("trace_uprobe: support reference counter in fd-based uprobe")
+	 */
+	man->has_sema_refcnt = access(ref_ctr_sysfs_path, F_OK) == 0;
+
+	return man;
+}
+
+void usdt_manager_free(struct usdt_manager *man)
+{
+	if (IS_ERR_OR_NULL(man))
+		return;
+
+	free(man);
+}
+
+static int sanity_check_usdt_elf(Elf *elf, const char *path)
+{
+	GElf_Ehdr ehdr;
+	int endianness;
+
+	if (elf_kind(elf) != ELF_K_ELF) {
+		pr_warn("usdt: unrecognized ELF kind %d for '%s'\n", elf_kind(elf), path);
+		return -EBADF;
+	}
+
+	switch (gelf_getclass(elf)) {
+	case ELFCLASS64:
+		if (sizeof(void *) != 8) {
+			pr_warn("usdt: attaching to 64-bit ELF binary '%s' is not supported\n", path);
+			return -EBADF;
+		}
+		break;
+	case ELFCLASS32:
+		if (sizeof(void *) != 4) {
+			pr_warn("usdt: attaching to 32-bit ELF binary '%s' is not supported\n", path);
+			return -EBADF;
+		}
+		break;
+	default:
+		pr_warn("usdt: unsupported ELF class for '%s'\n", path);
+		return -EBADF;
+	}
+
+	if (!gelf_getehdr(elf, &ehdr))
+		return -EINVAL;
+
+	if (ehdr.e_type != ET_EXEC && ehdr.e_type != ET_DYN) {
+		pr_warn("usdt: unsupported type of ELF binary '%s' (%d), only ET_EXEC and ET_DYN are supported\n",
+			path, ehdr.e_type);
+		return -EBADF;
+	}
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	endianness = ELFDATA2LSB;
+#elif __BYTE_ORDER == __BIG_ENDIAN
+	endianness = ELFDATA2MSB;
+#else
+# error "Unrecognized __BYTE_ORDER__"
+#endif
+	if (endianness != ehdr.e_ident[EI_DATA]) {
+		pr_warn("usdt: ELF endianness mismatch for '%s'\n", path);
+		return -EBADF;
+	}
+
+	return 0;
+}
+
+static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *path, pid_t pid,
+				const char *usdt_provider, const char *usdt_name, long usdt_cookie,
+				struct usdt_target **out_targets, size_t *out_target_cnt)
+{
+	return -ENOTSUP;
+}
+
+struct bpf_link_usdt {
+	struct bpf_link link;
+
+	struct usdt_manager *usdt_man;
+
+	size_t uprobe_cnt;
+	struct {
+		long abs_ip;
+		struct bpf_link *link;
+	} *uprobes;
+};
+
+static int bpf_link_usdt_detach(struct bpf_link *link)
+{
+	struct bpf_link_usdt *usdt_link = container_of(link, struct bpf_link_usdt, link);
+	int i;
+
+	for (i = 0; i < usdt_link->uprobe_cnt; i++) {
+		/* detach underlying uprobe link */
+		bpf_link__destroy(usdt_link->uprobes[i].link);
+	}
+
+	return 0;
+}
+
+static void bpf_link_usdt_dealloc(struct bpf_link *link)
+{
+	struct bpf_link_usdt *usdt_link = container_of(link, struct bpf_link_usdt, link);
+
+	free(usdt_link->uprobes);
+	free(usdt_link);
+}
+
+struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct bpf_program *prog,
+					  pid_t pid, const char *path,
+					  const char *usdt_provider, const char *usdt_name,
+					  long usdt_cookie)
+{
+	int i, fd, err;
+	LIBBPF_OPTS(bpf_uprobe_opts, opts);
+	struct bpf_link_usdt *link = NULL;
+	struct usdt_target *targets = NULL;
+	size_t target_cnt;
+	Elf *elf;
+
+	/* TODO: perform path resolution similar to uprobe's */
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		err = -errno;
+		pr_warn("usdt: failed to open ELF binary '%s': %d\n", path, err);
+		return libbpf_err_ptr(err);
+	}
+
+	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
+	if (!elf) {
+		err = -EBADF;
+		pr_warn("usdt: failed to parse ELF binary '%s': %s\n", path, elf_errmsg(-1));
+		goto err_out;
+	}
+
+	err = sanity_check_usdt_elf(elf, path);
+	if (err)
+		goto err_out;
+
+	/* normalize PID filter */
+	if (pid < 0)
+		pid = -1;
+	else if (pid == 0)
+		pid = getpid();
+
+	/* discover USDT in given binary, optionally limiting
+	 * activations to a given PID, if pid > 0
+	 */
+	err = collect_usdt_targets(man, elf, path, pid, usdt_provider, usdt_name,
+				   usdt_cookie, &targets, &target_cnt);
+	if (err <= 0) {
+		err = (err == 0) ? -ENOENT : err;
+		goto err_out;
+	}
+
+	link = calloc(1, sizeof(*link));
+	if (!link) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	link->usdt_man = man;
+	link->link.detach = &bpf_link_usdt_detach;
+	link->link.dealloc = &bpf_link_usdt_dealloc;
+
+	link->uprobes = calloc(target_cnt, sizeof(*link->uprobes));
+	if (!link->uprobes) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	for (i = 0; i < target_cnt; i++) {
+		struct usdt_target *target = &targets[i];
+		struct bpf_link *uprobe_link;
+
+		opts.ref_ctr_offset = target->sema_off;
+		uprobe_link = bpf_program__attach_uprobe_opts(prog, pid, path,
+							      target->rel_ip, &opts);
+		err = libbpf_get_error(uprobe_link);
+		if (err) {
+			pr_warn("usdt: failed to attach uprobe #%d for '%s:%s' in '%s': %d\n",
+				i, usdt_provider, usdt_name, path, err);
+			goto err_out;
+		}
+
+		link->uprobes[i].link = uprobe_link;
+		link->uprobes[i].abs_ip = target->abs_ip;
+		link->uprobe_cnt++;
+	}
+
+	elf_end(elf);
+	close(fd);
+
+	return &link->link;
+
+err_out:
+	bpf_link__destroy(&link->link);
+
+	if (elf)
+		elf_end(elf);
+	close(fd);
+	return libbpf_err_ptr(err);
+}
-- 
2.30.2

