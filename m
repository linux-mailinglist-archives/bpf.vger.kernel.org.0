Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09A94E6DC0
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 06:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352996AbiCYFbi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 25 Mar 2022 01:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354767AbiCYFbh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 01:31:37 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7B57B1D
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 22:30:03 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22P0daNJ011288
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 22:30:02 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f13d0125u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 22:30:02 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 22:30:00 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5EE3714CB0B85; Thu, 24 Mar 2022 22:29:49 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 2/7] libbpf: wire up USDT API and bpf_link integration
Date:   Thu, 24 Mar 2022 22:29:36 -0700
Message-ID: <20220325052941.3526715-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220325052941.3526715-1-andrii@kernel.org>
References: <20220325052941.3526715-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qUaBNA8CuHDGyQTg4cnMsYSKUQKVxmz2
X-Proofpoint-GUID: qUaBNA8CuHDGyQTg4cnMsYSKUQKVxmz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_01,2022-03-24_01,2022-02-23_01
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

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Build             |   3 +-
 tools/lib/bpf/libbpf.c          |  92 ++++++++++-
 tools/lib/bpf/libbpf.h          |  15 ++
 tools/lib/bpf/libbpf.map        |   1 +
 tools/lib/bpf/libbpf_internal.h |  19 +++
 tools/lib/bpf/usdt.c            | 270 ++++++++++++++++++++++++++++++++
 6 files changed, 391 insertions(+), 9 deletions(-)
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
index 809fe209cdcc..8841499f5f12 100644
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
@@ -10599,6 +10615,66 @@ struct bpf_link *bpf_program__attach_uprobe(const struct bpf_program *prog,
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
+	/* USDT manager is instantiated lazily on first USDT attach. It will
+	 * be destroyed together with BPF object in bpf_object__close().
+	 */
+	if (!obj->usdt_man) {
+		obj->usdt_man = usdt_manager_new(obj);
+		if (!obj->usdt_man)
+			return libbpf_err_ptr(-ENOMEM);
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
+
+	sec_name = bpf_program__section_name(prog);
+	if (strcmp(sec_name, "usdt") == 0) {
+		/* no auto-attach for just SEC("usdt") */
+		*link = NULL;
+		return 0;
+	}
+
+	if (3 != sscanf(sec_name, "usdt/%m[^:]:%m[^:]:%m[^:]", &path, &provider, &name)) {
+		pr_warn("invalid section '%s', expected SEC(\"usdt/<path>:<provider>:<name>\")\n",
+			sec_name);
+		free(path);
+		free(provider);
+		free(name);
+		return -EINVAL;
+	}
+
+	*link = bpf_program__attach_usdt(prog, -1 /* any process */, path,
+					 provider, name, NULL);
+	free(path);
+	free(provider);
+	free(name);
+	return libbpf_get_error(*link);
+}
+
 static int determine_tracepoint_id(const char *tp_category,
 				   const char *tp_name)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 05dde85e19a6..318eecaa14e7 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -503,6 +503,21 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
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
index 000000000000..8481e300598e
--- /dev/null
+++ b/tools/lib/bpf/usdt.c
@@ -0,0 +1,270 @@
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
+#define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
+
+struct usdt_target {
+	long abs_ip;
+	long rel_ip;
+	long sema_off;
+};
+
+struct usdt_manager {
+	struct bpf_map *specs_map;
+	struct bpf_map *ip_to_id_map;
+
+	bool has_bpf_cookie;
+	bool has_sema_refcnt;
+};
+
+struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
+{
+	static const char *ref_ctr_sysfs_path = "/sys/bus/event_source/devices/uprobe/format/ref_ctr_offset";
+	struct usdt_manager *man;
+	struct bpf_map *specs_map, *ip_to_id_map;
+
+	specs_map = bpf_object__find_map_by_name(obj, "__bpf_usdt_specs");
+	ip_to_id_map = bpf_object__find_map_by_name(obj, "__bpf_usdt_specs_ip_to_id");
+	if (!specs_map || !ip_to_id_map) {
+		pr_warn("usdt: failed to find USDT support BPF maps, did you forget to include bpf/usdt.bpf.h?\n");
+		return NULL;
+	}
+
+	man = calloc(1, sizeof(*man));
+	if (!man)
+		return NULL;
+
+	man->specs_map = specs_map;
+	man->ip_to_id_map = ip_to_id_map;
+
+        /* Detect if BPF cookie is supported for kprobes.
+	 * We don't need IP-to-ID mapping if we can use BPF cookies.
+         * Added in: 7adfc6c9b315 ("bpf: Add bpf_get_attach_cookie() BPF helper to access bpf_cookie value")
+         */
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
+	if (!man)
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
+	if (bpf_program__fd(prog) < 0) {
+		pr_warn("prog '%s': can't attach BPF program w/o FD (did you load it?)\n",
+			bpf_program__name(prog));
+		return libbpf_err_ptr(-EINVAL);
+	}
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
+		err = libbpf_get_error(link);
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

