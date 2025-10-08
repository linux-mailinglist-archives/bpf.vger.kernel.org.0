Return-Path: <bpf+bounces-70613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF6FBC629A
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357663A6EA8
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394F2BF019;
	Wed,  8 Oct 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G/RRsWjS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F162BEFFD
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944979; cv=none; b=BfYdk3nvTnO/+oJ98QssCt7UyLAkjmd5gSfRvgD0bInZbN0pAIlRxpnl00+DiavrYUF60ofpazzYgn4CaMcB6Ij6wYfXwFhAn+8OPdE+NNT7A/RX1zLzyyJbmQmHmkCFfo88nH51+Mf6lp7jkAI0D60DNIvPULw38WaWy6gkfOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944979; c=relaxed/simple;
	bh=y/T9j4D9sEPk25z7C3aewP1OLeRv0vzwkZOvO/tonMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nx0P2UUa9zQ6OyF77RLfW2qWVVgDkdRSDSt/ELlvvWkrhIAaYfXP3TBpGvD6z055DzwzckKXhvh31LKXhbNgTEp6vm0EKnE8bizUzAFsywcNQGJlJ3Kg4WGDhEflEx5NPhUbRQ+P3amIWudBYuqZJkFLqOipcTGR+bm1SSybgF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G/RRsWjS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HEYKt014154;
	Wed, 8 Oct 2025 17:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=TRXQM
	m553cyUpoJzx9WONxDoJgzr69DnWAUpZopoN4w=; b=G/RRsWjSc/rsIAP548Nw3
	Du6lgKBklMvbvnyfvpfuGeT3E/kLsk4WQPoHcN2GY1Ib1gKQYvPlgCZiLBrdgokv
	TiJznyCr2HUiNOBjWc+BgwBXXu7JNbA4dZV62dwo+SkWstDulVAWq4IM+tXTgwxL
	X0ph13QQ2IkWc2D8M+PZG6vuI3Md8uJiNNy2+MHI4kCaazpHw/5no59cM6gYkJ/8
	ci9Ko7NpOMpa/Nz3VGL8CKSyVwxu776ODhdnfLxKIKcgj8iKt8tzp+np26ilmz5j
	tQTtffMBnrk10H+UizJrv0/V/M1N9tqXQtQ1vnwFt5FzYnWMWBGDsNzfgRW+Cdvb
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6c81dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HE0gY037273;
	Wed, 8 Oct 2025 17:35:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rq4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:54 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFVA031138;
	Wed, 8 Oct 2025 17:35:53 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-15;
	Wed, 08 Oct 2025 17:35:53 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 14/15] libbpf: add support for BTF location attachment
Date: Wed,  8 Oct 2025 18:35:10 +0100
Message-ID: <20251008173512.731801-15-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080123
X-Proofpoint-GUID: C_YYbzN-5Ng6EaIDWS1iqUSiBLSfXmG8
X-Proofpoint-ORIG-GUID: C_YYbzN-5Ng6EaIDWS1iqUSiBLSfXmG8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX22/VfkzokYid
 WjjXjsGZM9ZC0W/ecLxks3EAOIu5zCd3F5YsiLqUPdgw4q0RzToRTBBI0I3Z9fVD/jhZoVKOgWz
 rxx8SezAHSaowaRTQFtE/EKTygOyOzgpQOX97T/761aPxazRMrfvoGvVCBNFasJWZWkIKtcqNKP
 NHZuaCzj/eeur+yoz5fL/fcD6OyaCF7IZQmsgSeiHESmWAnQekODG/mDLAaHp+ROpMxs3mCnI02
 EPHIAno5swuRAPbJSYTvAFd3GLT3y9KsdE5vSPcTGFnjlACMFH8IP9g+rNGnIJQBSmVvltXCYq4
 FUxmEqOq3ldvmVVQ+gqdwIUEC25/WJXt1mUw+pToLCC5Ecl5IIeVXUNPXmNhyhprim73Oj25rAS
 skBew2Ykg9yQfQ90JFT8AbNeQK26/2RTcvMdA8N3h3PJxCQfzzY=
X-Authority-Analysis: v=2.4 cv=FYA6BZ+6 c=1 sm=1 tr=0 ts=68e6a0fb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=uAvHrn_jeXS3C8njofcA:9 cc=ntf
 awl=host:13625

Add support for BTF-based location attachment via multiple kprobes
attaching to each instance of an inline site. Note this is not kprobe
multi attach since that requires fprobe on entry and sites are within
functions. Implementation similar to USDT manager where we use BTF
to create a location manager and populate expected arg values with
metadata based upon BTF_KIND_LOC_PARAM/LOC_PROTOs.

Add new auto-attach SEC("kloc/module:name") where the module is
vmlinux/kernel module and the name is the name of the associated
location; all sites associated with that name will be attached via
kprobes for tracing.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/Build             |   2 +-
 tools/lib/bpf/Makefile          |   2 +-
 tools/lib/bpf/libbpf.c          |  76 +++-
 tools/lib/bpf/libbpf.h          |  27 ++
 tools/lib/bpf/libbpf.map        |   1 +
 tools/lib/bpf/libbpf_internal.h |   7 +
 tools/lib/bpf/loc.bpf.h         | 297 +++++++++++++++
 tools/lib/bpf/loc.c             | 653 ++++++++++++++++++++++++++++++++
 8 files changed, 1062 insertions(+), 3 deletions(-)
 create mode 100644 tools/lib/bpf/loc.bpf.h
 create mode 100644 tools/lib/bpf/loc.c

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index c80204bb72a2..df216ccb015b 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_utils.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
-	    usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o
+	    usdt.o zip.o elf.o features.o btf_iter.o btf_relocate.o loc.o
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 168140f8e646..b22be124edc3 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -234,7 +234,7 @@ install_lib: all_cmd
 
 SRC_HDRS := bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h	     \
 	    bpf_helpers.h bpf_tracing.h bpf_endian.h bpf_core_read.h	     \
-	    skel_internal.h libbpf_version.h usdt.bpf.h
+	    skel_internal.h libbpf_version.h usdt.bpf.h loc.bpf.h
 GEN_HDRS := $(BPF_GENERATED)
 
 INSTALL_PFX := $(DESTDIR)$(prefix)/include/bpf
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dd3b2f57082d..1605b95844cf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -407,6 +407,7 @@ enum sec_def_flags {
 	SEC_XDP_FRAGS = 16,
 	/* Setup proper attach type for usdt probes. */
 	SEC_USDT = 32,
+	SEC_LOC = 33,
 };
 
 struct bpf_sec_def {
@@ -671,6 +672,8 @@ struct elf_state {
 
 struct usdt_manager;
 
+struct loc_manager;
+
 enum bpf_object_state {
 	OBJ_OPEN,
 	OBJ_PREPARED,
@@ -733,6 +736,7 @@ struct bpf_object {
 	size_t fd_array_cnt;
 
 	struct usdt_manager *usdt_man;
+	struct loc_manager *loc_man;
 
 	int arena_map_idx;
 	void *arena_data;
@@ -9190,6 +9194,8 @@ void bpf_object__close(struct bpf_object *obj)
 
 	usdt_manager_free(obj->usdt_man);
 	obj->usdt_man = NULL;
+	loc_manager_free(obj->loc_man);
+	obj->loc_man = NULL;
 
 	bpf_gen__free(obj->gen_loader);
 	bpf_object__elf_finish(obj);
@@ -9561,6 +9567,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie, st
 static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_kloc(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 
 static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
@@ -9666,6 +9673,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 	SEC_DEF("netfilter",		NETFILTER, BPF_NETFILTER, SEC_NONE),
+	SEC_DEF("kloc+",		KPROBE, 0, SEC_NONE, attach_kloc),
 };
 
 int libbpf_register_prog_handler(const char *sec,
@@ -11155,7 +11163,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	attr.size = attr_sz;
 	attr.type = type;
 	attr.config |= (__u64)ref_ctr_off << PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
-	attr.config1 = ptr_to_u64(name); /* kprobe_func or uprobe_path */
+	attr.config1 = name ? ptr_to_u64(name) : 0; /* kprobe_func or uprobe_path */
 	attr.config2 = offset;		 /* kprobe_addr or probe_offset */
 
 	/* pid filter is meaningful only for uprobes */
@@ -12601,6 +12609,72 @@ static int attach_usdt(const struct bpf_program *prog, long cookie, struct bpf_l
 	return err;
 }
 
+struct bpf_link *bpf_program__attach_kloc(const struct bpf_program *prog,
+					 const char *module, const char *name,
+					 const struct bpf_kloc_opts *opts)
+{
+	struct bpf_object *obj = prog->obj;
+	struct bpf_link *link;
+	__u64 loc_cookie;
+	int err;
+
+	if (!OPTS_VALID(opts, bpf_kloc_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	if (bpf_program__fd(prog) < 0) {
+		pr_warn("prog '%s': can't attach BPF program without FD (was it loaded?)\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+	if (!module || !name)
+		return libbpf_err_ptr(-EINVAL);
+
+	/* loc manager is instantiated lazily on first loc attach. It will
+	 * be destroyed together with BPF object in bpf_object__close().
+	 */
+	if (IS_ERR(obj->loc_man))
+		return libbpf_ptr(obj->loc_man);
+	if (!obj->loc_man) {
+		obj->loc_man = loc_manager_new(obj);
+		if (IS_ERR(obj->loc_man))
+			return libbpf_ptr(obj->loc_man);
+	}
+
+	loc_cookie = OPTS_GET(opts, loc_cookie, 0);
+	link = loc_manager_attach_kloc(obj->loc_man, prog, module, name, loc_cookie);
+	err = libbpf_get_error(link);
+	if (err)
+		return libbpf_err_ptr(err);
+	return link;
+}
+
+static int attach_kloc(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	char *module = NULL, *name = NULL;
+	const char *sec_name;
+	int n, err;
+
+	sec_name = bpf_program__section_name(prog);
+	if (strcmp(sec_name, "kloc") == 0) {
+		/* no auto-attach for just SEC("kloc") */
+		*link = NULL;
+		return 0;
+	}
+
+	n = sscanf(sec_name, "kloc/%m[^:]:%m[^:]", &module, &name);
+	if (n != 2) {
+		pr_warn("invalid section '%s', expected SEC(\"kloc/<module>:<name>\")\n",
+			sec_name);
+		err = -EINVAL;
+	} else {
+		*link = bpf_program__attach_kloc(prog, module, name, NULL);
+		err = libbpf_get_error(*link);
+	}
+	free(module);
+	free(name);
+	return err;
+}
+
 static int determine_tracepoint_id(const char *tp_category,
 				   const char *tp_name)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5118d0a90e24..3a5b7ef212a5 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -799,6 +799,33 @@ bpf_program__attach_usdt(const struct bpf_program *prog,
 			 const char *usdt_provider, const char *usdt_name,
 			 const struct bpf_usdt_opts *opts);
 
+struct bpf_kloc_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	/* custom user-provided value fetchable through loc_cookie() */
+	__u64 loc_cookie;
+	size_t:0;
+};
+#define bpf_kloc_opts__last_field loc_cookie
+
+/**
+ * @brief **bpf_program__attach_kloc()** attaches to the location
+ * named *name* in *module* (which can be "vmlinux" or a module name).
+ * Attaches to all locations associated with *name*.
+ *
+ * @param prog BPF program to attach
+ * @param module name
+ * @param name Location name
+ * @param opts Options for altering program attachment
+ * @return Reference to the newly created BPF link: or NULL is returned on error
+ *
+ * error code is stored in errno
+ */
+LIBBPF_API struct bpf_link *
+bpf_program__attach_kloc(const struct bpf_program *prog,
+			 const char *module, const char *name,
+			 const struct bpf_kloc_opts *opts);
+
 struct bpf_tracepoint_opts {
 	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 5f5cf9773205..94f8a6f8e00f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -457,4 +457,5 @@ LIBBPF_1.7.0 {
 		btf__add_locsec;
 		btf__add_locsec_loc;
 		btf__load_btf_extra;
+		bpf_program__attach_kloc;
 } LIBBPF_1.6.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 2a05518265e9..654337524bdc 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -719,6 +719,13 @@ struct bpf_link * usdt_manager_attach_usdt(struct usdt_manager *man,
 					   const char *usdt_provider, const char *usdt_name,
 					   __u64 usdt_cookie);
 
+struct loc_manager *loc_manager_new(struct bpf_object *obj);
+void loc_manager_free(struct loc_manager *man);
+struct bpf_link *loc_manager_attach_kloc(struct loc_manager *man,
+					 const struct bpf_program *prog,
+					 const char *loc_mod, const char *loc_name,
+					 __u64 loc_cookie);
+
 static inline bool is_pow_of_2(size_t x)
 {
 	return x && (x & (x - 1)) == 0;
diff --git a/tools/lib/bpf/loc.bpf.h b/tools/lib/bpf/loc.bpf.h
new file mode 100644
index 000000000000..65dcff3ea513
--- /dev/null
+++ b/tools/lib/bpf/loc.bpf.h
@@ -0,0 +1,297 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/* Copyright (c) 2025, Oracle and/or its affiliates. */
+#ifndef __LOC_BPF_H__
+#define __LOC_BPF_H__
+
+#include <linux/errno.h>
+#include "bpf_helpers.h"
+#include "bpf_tracing.h"
+
+/* Below types and maps are internal implementation details of libbpf's loc
+ * support and are subjects to change. Also, bpf_loc_xxx() API helpers should
+ * be considered an unstable API as well and might be adjusted based on user
+ * feedback from using libbpf's location support in production.
+ *
+ * This is based heavily upon usdt.bpf.h.
+ */
+
+/* User can override BPF_LOC_MAX_SPEC_CNT to change default size of internal
+ * map that keeps track of location argument specifications. This might be
+ * necessary if there are a lot of location attachments.
+ */
+#ifndef BPF_LOC_MAX_SPEC_CNT
+#define BPF_LOC_MAX_SPEC_CNT 256
+#endif
+/* User can override BPF_LOC_MAX_IP_CNT to change default size of internal
+ * map that keeps track of IP (memory address) mapping to loc argument
+ * specification.
+ * Note, if kernel supports BPF cookies, this map is not used and could be
+ * resized all the way to 1 to save a bit of memory.
+ */
+#ifndef BPF_LOC_MAX_IP_CNT
+#define BPF_LOC_MAX_IP_CNT (4 * BPF_LOC_MAX_SPEC_CNT)
+#endif
+
+enum __bpf_loc_arg_type {
+	BPF_LOC_ARG_UNAVAILABLE,
+	BPF_LOC_ARG_CONST,
+	BPF_LOC_ARG_REG,
+	BPF_LOC_ARG_REG_DEREF,
+	BPF_LOC_ARG_REG_MULTI,
+};
+
+struct __bpf_loc_arg_spec {
+	/* u64 scalar interpreted depending on arg_type, see below */
+	__u64 val_off;
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	enum __bpf_loc_arg_type arg_type: 8;
+	/* reserved for future use, keeps reg_off offset stable */
+	__u32 __reserved: 24;
+#else
+	__u32 __reserved: 24;
+	enum __bpf_loc_arg_type arg_type: 8;
+#endif
+	/* offset of referenced register within struct pt_regs */
+	union {
+		short reg_off;
+		short reg_offs[2];
+	};
+	/* whether arg should be interpreted as signed value */
+	bool arg_signed;
+	/* number of bits that need to be cleared and, optionally,
+	 * sign-extended to cast arguments that are 1, 2, or 4 bytes
+	 * long into final 8-byte u64/s64 value returned to user
+	 */
+	char arg_bitshift;
+};
+
+/* should match LOC_MAX_ARG_CNT in loc.c exactly */
+#define BPF_LOC_MAX_ARG_CNT 12
+struct __bpf_loc_spec {
+	struct __bpf_loc_arg_spec args[BPF_LOC_MAX_ARG_CNT];
+	__u64 loc_cookie;
+	short arg_cnt;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, BPF_LOC_MAX_SPEC_CNT);
+	__type(key, int);
+	__type(value, struct __bpf_loc_spec);
+} __bpf_loc_specs SEC(".maps") __weak;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, BPF_LOC_MAX_IP_CNT);
+	__type(key, long);
+	__type(value, __u32);
+} __bpf_loc_ip_to_spec_id SEC(".maps") __weak;
+
+extern const _Bool LINUX_HAS_BPF_COOKIE __kconfig;
+
+static __always_inline
+int __bpf_loc_spec_id(struct pt_regs *ctx)
+{
+	if (!LINUX_HAS_BPF_COOKIE) {
+		long ip = PT_REGS_IP(ctx);
+		int *spec_id_ptr;
+
+		spec_id_ptr = bpf_map_lookup_elem(&__bpf_loc_ip_to_spec_id, &ip);
+		return spec_id_ptr ? *spec_id_ptr : -ESRCH;
+	}
+
+	return bpf_get_attach_cookie(ctx);
+}
+
+/* Return number of loc arguments defined for currently traced loc. */
+__weak __hidden
+int bpf_loc_arg_cnt(struct pt_regs *ctx)
+{
+	struct __bpf_loc_spec *spec;
+	int spec_id;
+
+	spec_id = __bpf_loc_spec_id(ctx);
+	if (spec_id < 0)
+		return -ESRCH;
+
+	spec = bpf_map_lookup_elem(&__bpf_loc_specs, &spec_id);
+	if (!spec)
+		return -ESRCH;
+
+	return spec->arg_cnt;
+}
+
+/* Returns the size in bytes of the #*arg_num* (zero-indexed) loc argument.
+ * Returns negative error if argument is not found or arg_num is invalid.
+ */
+static __always_inline
+int bpf_loc_arg_size(struct pt_regs *ctx, __u64 arg_num)
+{
+	struct __bpf_loc_arg_spec *arg_spec;
+	struct __bpf_loc_spec *spec;
+	int spec_id;
+
+	spec_id = __bpf_loc_spec_id(ctx);
+	if (spec_id < 0)
+		return -ESRCH;
+
+	spec = bpf_map_lookup_elem(&__bpf_loc_specs, &spec_id);
+	if (!spec)
+		return -ESRCH;
+
+	if (arg_num >= BPF_LOC_MAX_ARG_CNT)
+		return -ENOENT;
+	barrier_var(arg_num);
+	if (arg_num >= spec->arg_cnt)
+		return -ENOENT;
+
+	arg_spec = &spec->args[arg_num];
+
+	/* arg_spec->arg_bitshift = 64 - arg_sz * 8
+	 * so: arg_sz = (64 - arg_spec->arg_bitshift) / 8
+	 */
+	return (unsigned int)(64 - arg_spec->arg_bitshift) / 8;
+}
+
+/* Fetch loc argument #*arg_num* (zero-indexed) and put its value into *res.
+ * Returns 0 on success; negative error, otherwise.
+ * On error *res is guaranteed to be set to zero.
+ */
+__weak __hidden
+int bpf_loc_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
+{
+	struct __bpf_loc_spec *spec;
+	struct __bpf_loc_arg_spec *arg_spec;
+	unsigned long val;
+	int err, spec_id;
+
+	*res = 0;
+
+	spec_id = __bpf_loc_spec_id(ctx);
+	if (spec_id < 0)
+		return -ESRCH;
+
+	spec = bpf_map_lookup_elem(&__bpf_loc_specs, &spec_id);
+	if (!spec)
+		return -ESRCH;
+
+	if (arg_num >= BPF_LOC_MAX_ARG_CNT)
+		return -ENOENT;
+	barrier_var(arg_num);
+	if (arg_num >= spec->arg_cnt)
+		return -ENOENT;
+
+	arg_spec = &spec->args[arg_num];
+	switch (arg_spec->arg_type) {
+	case BPF_LOC_ARG_UNAVAILABLE:
+		*res = 0;
+		return -ENOENT;
+	case BPF_LOC_ARG_CONST:
+		/* Arg is just a constant ("-4@$-9" in loc arg spec).
+		 * value is recorded in arg_spec->val_off directly.
+		 */
+		val = arg_spec->val_off;
+		break;
+	case BPF_LOC_ARG_REG:
+		/* Arg is stored directly in a register, so we read the
+		 * contents of that register directly from struct pt_regs.
+		 * To keep things simple user-space parts record
+		 * offsetof(struct pt_regs, <regname>) in arg_spec->reg_off.
+		 */
+		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
+		if (err)
+			return err;
+		break;
+	case BPF_LOC_ARG_REG_DEREF:
+		/* Arg is in memory addressed by register, plus some offset
+		 * Register is identified like with BPF_LOC_ARG_REG case,
+		 * and the offset is in arg_spec->val_off. We first fetch
+		 * register contents from pt_regs, then do another probe read
+		 * to fetch argument value itself.
+		 */
+		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
+		if (err)
+			return err;
+		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)val + arg_spec->val_off);
+		if (err)
+			return err;
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+		val >>= arg_spec->arg_bitshift;
+#endif
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* cast arg from 1, 2, or 4 bytes to final 8 byte size clearing
+	 * necessary upper arg_bitshift bits, with sign extension if argument
+	 * is signed
+	 */
+	val <<= arg_spec->arg_bitshift;
+	if (arg_spec->arg_signed)
+		val = ((long)val) >> arg_spec->arg_bitshift;
+	else
+		val = val >> arg_spec->arg_bitshift;
+	*res = val;
+	return 0;
+}
+
+/* Retrieve user-specified cookie value provided during attach as
+ * bpf_loc_opts.loc_cookie. This serves the same purpose as BPF cookie
+ * returned by bpf_get_attach_cookie(). Libbpf's support for locs is itself
+ * utilizing BPF cookies internally, so user can't use BPF cookie directly
+ * for loc programs and has to use bpf_loc_cookie() API instead.
+ */
+__weak __hidden
+long bpf_loc_cookie(struct pt_regs *ctx)
+{
+	struct __bpf_loc_spec *spec;
+	int spec_id;
+
+	spec_id = __bpf_loc_spec_id(ctx);
+	if (spec_id < 0)
+		return 0;
+
+	spec = bpf_map_lookup_elem(&__bpf_loc_specs, &spec_id);
+	if (!spec)
+		return 0;
+
+	return spec->loc_cookie;
+}
+
+/* we rely on ___bpf_apply() and ___bpf_narg() macros already defined in bpf_tracing.h */
+#define ___bpf_loc_args0() ctx
+#define ___bpf_loc_args1(x) ___bpf_loc_args0(), ({ long _x; bpf_loc_arg(ctx, 0, &_x); _x; })
+#define ___bpf_loc_args2(x, args...) ___bpf_loc_args1(args), ({ long _x; bpf_loc_arg(ctx, 1, &_x); _x; })
+#define ___bpf_loc_args3(x, args...) ___bpf_loc_args2(args), ({ long _x; bpf_loc_arg(ctx, 2, &_x); _x; })
+#define ___bpf_loc_args4(x, args...) ___bpf_loc_args3(args), ({ long _x; bpf_loc_arg(ctx, 3, &_x); _x; })
+#define ___bpf_loc_args5(x, args...) ___bpf_loc_args4(args), ({ long _x; bpf_loc_arg(ctx, 4, &_x); _x; })
+#define ___bpf_loc_args6(x, args...) ___bpf_loc_args5(args), ({ long _x; bpf_loc_arg(ctx, 5, &_x); _x; })
+#define ___bpf_loc_args7(x, args...) ___bpf_loc_args6(args), ({ long _x; bpf_loc_arg(ctx, 6, &_x); _x; })
+#define ___bpf_loc_args8(x, args...) ___bpf_loc_args7(args), ({ long _x; bpf_loc_arg(ctx, 7, &_x); _x; })
+#define ___bpf_loc_args9(x, args...) ___bpf_loc_args8(args), ({ long _x; bpf_loc_arg(ctx, 8, &_x); _x; })
+#define ___bpf_loc_args10(x, args...) ___bpf_loc_args9(args), ({ long _x; bpf_loc_arg(ctx, 9, &_x); _x; })
+#define ___bpf_loc_args11(x, args...) ___bpf_loc_args10(args), ({ long _x; bpf_loc_arg(ctx, 10, &_x); _x; })
+#define ___bpf_loc_args12(x, args...) ___bpf_loc_args11(args), ({ long _x; bpf_loc_arg(ctx, 11, &_x); _x; })
+#define ___bpf_loc_args(args...) ___bpf_apply(___bpf_loc_args, ___bpf_narg(args))(args)
+
+/*
+ * BPF_KLOC serves the same purpose for loc handlers as BPF_PROG for
+ * tp_btf/fentry/fexit BPF programs and BPF_KPROBE for kprobes.
+ * Original struct pt_regs * context is preserved as 'ctx' argument.
+ */
+#define BPF_KLOC(name, args...)						    \
+name(struct pt_regs *ctx);						    \
+static __always_inline typeof(name(0))					    \
+____##name(struct pt_regs *ctx, ##args);				    \
+typeof(name(0)) name(struct pt_regs *ctx)				    \
+{									    \
+	_Pragma("GCC diagnostic push")					    \
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")		    \
+	return ____##name(___bpf_loc_args(args));			    \
+	_Pragma("GCC diagnostic pop")					    \
+}									    \
+static __always_inline typeof(name(0))					    \
+____##name(struct pt_regs *ctx, ##args)
+
+#endif /* __LOC_BPF_H__ */
diff --git a/tools/lib/bpf/loc.c b/tools/lib/bpf/loc.c
new file mode 100644
index 000000000000..345b248bb52e
--- /dev/null
+++ b/tools/lib/bpf/loc.c
@@ -0,0 +1,653 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+/* Copyright (c) 2025, Oracle and/or its affiliates. */
+#include <ctype.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/ptrace.h>
+#include <linux/kernel.h>
+
+/* s8 will be marked as poison while it's a reg of riscv */
+#if defined(__riscv)
+#define rv_s8 s8
+#endif
+
+#include "bpf.h"
+#include "btf.h"
+#include "libbpf.h"
+#include "libbpf_common.h"
+#include "libbpf_internal.h"
+
+/* Location implementation is very similar to usdt.c; key difference
+ * is the data specifying how to retrieve parameters for a target is
+ * in BTF.
+ */
+
+/* should match exactly enum __bpf_loc_arg_type from loc.bpf.h */
+enum loc_arg_type {
+	BPF_LOC_ARG_UNAVAILABLE,
+	BPF_LOC_ARG_CONST,
+	BPF_LOC_ARG_REG,
+	BPF_LOC_ARG_REG_DEREF,
+	BPF_LOC_ARG_REG_MULTI,
+};
+
+/* should match exactly struct __bpf_loc_arg_spec from loc.bpf.h */
+struct loc_arg_spec {
+	/* u64 scalar interpreted depending on arg_type, see below */
+	__u64 val_off;
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	enum loc_arg_type arg_type: 8;
+	/* reserved for future use, keeps reg_off offset stable */
+	__u32 __reserved: 24;
+#else
+	__u32 __reserved: 24;
+	enum loc_arg_type arg_type: 8;
+#endif
+	/* offset of referenced register within struct pt_regs */
+	union {
+		short reg_off;
+		short reg_offs[2];
+	};
+	/* whether arg should be interpreted as signed value */
+	bool arg_signed;
+	/* number of bits that need to be cleared and, optionally,
+	 * sign-extended to cast arguments that are 1, 2, or 4 bytes
+	 * long into final 8-byte u64/s64 value returned to user
+	 */
+	char arg_bitshift;
+};
+
+#define LOC_MAX_ARG_CNT 12
+struct loc_spec {
+	struct loc_arg_spec args[LOC_MAX_ARG_CNT];
+	__u64 loc_cookie;
+	short arg_cnt;
+};
+
+struct loc_target {
+	long abs_ip;
+	struct loc_spec spec;
+};
+
+struct loc_manager {
+	struct bpf_map *specs_map;
+	struct bpf_map *ip_to_spec_id_map;
+	int *free_spec_ids;
+	size_t free_spec_cnt;
+	size_t next_free_spec_id;
+	struct loc_target *targets;
+	size_t target_cnt;
+	bool has_bpf_cookie;
+};
+
+static int get_base_addr(const char *mod, __u64 *base_addr)
+{
+	bool is_vmlinux = strcmp(mod, "vmlinux") == 0;
+	const char *file = is_vmlinux ? "/proc/kallsyms" : "/proc/modules";
+	char name[PATH_MAX], type;
+	int err = -ENOENT;
+	FILE *f = NULL;
+	long addr;
+
+	*base_addr = 0;
+
+	f = fopen(file, "r");
+	if (!f) {
+		pr_warn("loc: cannot open '%s' (err %s)\n", file, errstr(-errno));
+		return -errno;
+	}
+	if (is_vmlinux) {
+		while (fscanf(f, "%lx %c %499s%*[^\n]\n", &addr, &type, name) == 3) {
+			if (strcmp(name, "_text") != 0)
+				continue;
+			*base_addr = addr;
+			err = 0;
+			break;
+		}
+	} else {
+		while (fscanf(f, "%s %*s %*s %*s %*s 0x%lx\n", name, &addr) == 5) {
+			if (strcmp(name, mod) != 0)
+				continue;
+			*base_addr = addr;
+			err = 0;
+			break;
+		}
+	}
+	fclose(f);
+	if (err)
+		pr_warn("loc: could not find base addr for '%s'\n", mod);
+	return err;
+}
+
+void loc_manager_free(struct loc_manager *man)
+{
+	if (IS_ERR_OR_NULL(man))
+		return;
+
+	free(man->free_spec_ids);
+	free(man);
+}
+
+struct loc_manager *loc_manager_new(struct bpf_object *obj)
+{
+	struct loc_manager *man = NULL;
+	struct bpf_map *specs_map, *ip_to_spec_id_map;
+
+	specs_map = bpf_object__find_map_by_name(obj, "__bpf_loc_specs");
+	ip_to_spec_id_map = bpf_object__find_map_by_name(obj, "__bpf_loc_ip_to_spec_id");
+	if (!specs_map || !ip_to_spec_id_map) {
+		pr_warn("loc: failed to find location support BPF maps, did you forget to include bpf/loc.bpf.h?\n");
+		return ERR_PTR(-ESRCH);
+	}
+
+	man = calloc(1, sizeof(*man));
+	if (!man)
+		return ERR_PTR(-ENOMEM);
+	man->specs_map = specs_map;
+	man->ip_to_spec_id_map = ip_to_spec_id_map;
+
+	/* Detect if BPF cookie is supported for kprobes.
+	 * We don't need IP-to-ID mapping if we can use BPF cookies.
+	 * Added in: 7adfc6c9b315 ("bpf: Add bpf_get_attach_cookie() BPF helper to access bpf_cookie value")
+	 */
+	man->has_bpf_cookie = kernel_supports(obj, FEAT_BPF_COOKIE);
+
+	return man;
+}
+
+struct bpf_link_loc {
+	struct bpf_link link;
+
+	struct loc_manager *loc_man;
+
+	size_t spec_cnt;
+	int *spec_ids;
+
+	size_t kprobe_cnt;
+	struct {
+		long abs_ip;
+		struct bpf_link *link;
+	} *kprobes;
+};
+
+static int bpf_link_loc_detach(struct bpf_link *link)
+{
+	struct bpf_link_loc *loc_link = container_of(link, struct bpf_link_loc, link);
+	struct loc_manager *man = loc_link->loc_man;
+	int i;
+
+	for (i = 0; i < loc_link->kprobe_cnt; i++) {
+		/* detach underlying kprobe link */
+		bpf_link__destroy(loc_link->kprobes[i].link);
+		/* there is no need to update specs map because it will be
+		 * unconditionally overwritten on subsequent loc attaches,
+		 * but if BPF cookies are not used we need to remove entry
+		 * from ip_to_spec_id map, otherwise we'll run into false
+		 * conflicting IP errors
+		 */
+		if (!man->has_bpf_cookie) {
+			/* not much we can do about errors here */
+			(void)bpf_map_delete_elem(bpf_map__fd(man->ip_to_spec_id_map),
+						  &loc_link->kprobes[i].abs_ip);
+		}
+	}
+
+	/* try to return the list of previously used spec IDs to loc_manager
+	 * for future reuse for subsequent loc attaches
+	 */
+	if (!man->free_spec_ids) {
+		/* if there were no free spec IDs yet, just transfer our IDs */
+		man->free_spec_ids = loc_link->spec_ids;
+		man->free_spec_cnt = loc_link->spec_cnt;
+		loc_link->spec_ids = NULL;
+	} else {
+		/* otherwise concat IDs */
+		size_t new_cnt = man->free_spec_cnt + loc_link->spec_cnt;
+		int *new_free_ids;
+
+		new_free_ids = libbpf_reallocarray(man->free_spec_ids, new_cnt,
+						   sizeof(*new_free_ids));
+		/* If we couldn't resize free_spec_ids, we'll just leak
+		 * a bunch of free IDs; this is very unlikely to happen and if
+		 * system is so exhausted on memory, it's the least of user's
+		 * concerns, probably.
+		 * So just do our best here to return those IDs to usdt_manager.
+		 * Another edge case when we can legitimately get NULL is when
+		 * new_cnt is zero, which can happen in some edge cases, so we
+		 * need to be careful about that.
+		 */
+		if (new_free_ids || new_cnt == 0) {
+			memcpy(new_free_ids + man->free_spec_cnt, loc_link->spec_ids,
+			       loc_link->spec_cnt * sizeof(*loc_link->spec_ids));
+			man->free_spec_ids = new_free_ids;
+			man->free_spec_cnt = new_cnt;
+		}
+	}
+
+	return 0;
+}
+
+static void bpf_link_loc_dealloc(struct bpf_link *link)
+{
+	struct bpf_link_loc *loc_link = container_of(link, struct bpf_link_loc, link);
+
+	free(loc_link->spec_ids);
+	free(loc_link->kprobes);
+	free(loc_link);
+}
+
+static int allocate_spec_id(struct loc_manager *man, struct bpf_link_loc *link,
+			    struct loc_target *target, int *spec_id, bool *is_new)
+{
+	void *new_ids;
+
+	new_ids = libbpf_reallocarray(link->spec_ids, link->spec_cnt + 1, sizeof(*link->spec_ids));
+	if (!new_ids)
+		return -ENOMEM;
+	link->spec_ids = new_ids;
+
+	/* get next free spec ID, giving preference to free list, if not empty */
+	if (man->free_spec_cnt) {
+		*spec_id = man->free_spec_ids[man->free_spec_cnt - 1];
+		man->free_spec_cnt--;
+	} else {
+		/* don't allocate spec ID bigger than what fits in specs map */
+		if (man->next_free_spec_id >= bpf_map__max_entries(man->specs_map))
+			return -E2BIG;
+
+		*spec_id = man->next_free_spec_id;
+		man->next_free_spec_id++;
+	}
+
+	/* remember new spec ID in the link for later return back to free list on detach */
+	link->spec_ids[link->spec_cnt] = *spec_id;
+	link->spec_cnt++;
+	*is_new = true;
+	return 0;
+}
+
+static int collect_loc_targets(struct loc_manager *man, const char *mod, const char *name,
+			       __u64 loc_cookie, struct loc_target **out_targets,
+			       size_t *out_target_cnt);
+
+struct bpf_link *loc_manager_attach_kloc(struct loc_manager *man, const struct bpf_program *prog,
+					 const char *loc_mod, const char *loc_name,
+					 __u64 loc_cookie)
+{
+	int i, err, spec_map_fd, ip_map_fd;
+
+	LIBBPF_OPTS(bpf_kprobe_opts, opts);
+	struct bpf_link_loc *link = NULL;
+	struct loc_target *targets = NULL;
+	__u64 *cookies = NULL;
+	size_t target_cnt = 0;
+
+	spec_map_fd = bpf_map__fd(man->specs_map);
+	ip_map_fd = bpf_map__fd(man->ip_to_spec_id_map);
+
+	err = collect_loc_targets(man, loc_mod, loc_name, loc_cookie, &targets, &target_cnt);
+	if (err <= 0) {
+		err = (err == 0) ? -ENOENT : err;
+		goto err_out;
+	}
+	err = 0;
+
+	link = calloc(1, sizeof(*link));
+	if (!link) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	link->loc_man = man;
+	link->link.detach = &bpf_link_loc_detach;
+	link->link.dealloc = &bpf_link_loc_dealloc;
+
+	link->kprobes = calloc(target_cnt, sizeof(*link->kprobes));
+	if (!link->kprobes) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	for (i = 0; i < target_cnt; i++) {
+		struct loc_target *target = &targets[i];
+		struct bpf_link *kprobe_link;
+		bool is_new;
+		int spec_id;
+
+		/* Spec ID can be either reused or newly allocated. */
+		err = allocate_spec_id(man, link, target, &spec_id, &is_new);
+		if (err)
+			goto err_out;
+
+		if (is_new && bpf_map_update_elem(spec_map_fd, &spec_id, &target->spec, BPF_ANY)) {
+			err = -errno;
+			pr_warn("loc: failed to set loc spec #%d for '%s:%s' in : %s\n",
+				spec_id, loc_mod, loc_name, errstr(err));
+			goto err_out;
+		}
+		if (!man->has_bpf_cookie &&
+		    bpf_map_update_elem(ip_map_fd, &target->abs_ip, &spec_id, BPF_NOEXIST)) {
+			err = -errno;
+			if (err == -EEXIST) {
+				pr_warn("loc: IP collision detected for spec #%d for '%s:%s''\n",
+					spec_id, loc_mod, loc_name);
+			} else {
+				pr_warn("loc: failed to map IP 0x%lx to spec #%d for '%s:%s': %s\n",
+					target->abs_ip, spec_id, loc_mod, loc_name,
+					errstr(err));
+			}
+			goto err_out;
+		}
+
+
+		opts.bpf_cookie = man->has_bpf_cookie ? spec_id : 0;
+		opts.offset = target->abs_ip;
+		kprobe_link = bpf_program__attach_kprobe_opts(prog, NULL, &opts);
+		err = libbpf_get_error(kprobe_link);
+		if (err) {
+			pr_warn("loc: failed to attach kprobe #%d for '%s:%s': %s\n",
+				i, loc_mod, loc_name, errstr(err));
+				goto err_out;
+		}
+
+		link->kprobes[i].link = kprobe_link;
+		link->kprobes[i].abs_ip = target->abs_ip;
+		link->kprobe_cnt++;
+	}
+
+	return &link->link;
+
+err_out:
+	pr_warn("loc: failed to attach to all loc targets for '%s:%s': %d\n",
+		loc_mod, loc_name, err);
+	free(cookies);
+
+	if (link)
+		bpf_link__destroy(&link->link);
+	free(targets);
+	return libbpf_err_ptr(err);
+}
+
+/* Architecture-specific logic for parsing location info */
+
+#if defined(__x86_64__) || defined(__i386__)
+
+static int calc_pt_regs_off(uint16_t num)
+{
+	size_t reg_map[] = {
+#ifdef __x86_64__
+#define reg_off(reg64, reg32) offsetof(struct pt_regs, reg64)
+#else
+#define reg_off(reg64, reg32) offsetof(struct pt_regs, reg32)
+#endif
+		reg_off(rax, eax),
+		reg_off(rdx, edx),
+		reg_off(rcx, ecx),
+		reg_off(rbx, ebx),
+		reg_off(rsi, esi),
+		reg_off(rdi, edi),
+		reg_off(rbp, ebp),
+		reg_off(rsp, esp),
+		offsetof(struct pt_regs, r8),
+		offsetof(struct pt_regs, r9),
+		offsetof(struct pt_regs, r10),
+		offsetof(struct pt_regs, r11),
+		offsetof(struct pt_regs, r12),
+		offsetof(struct pt_regs, r13),
+		offsetof(struct pt_regs, r14),
+		offsetof(struct pt_regs, r15),
+		-ENOENT,	
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		-ENOENT,
+		reg_off(rbp, ebp)
+	};
+
+	if (num > ARRAY_SIZE(reg_map) || reg_map[num] == -ENOENT) {
+		pr_warn("loc: unsupported register '%d'\n", num);
+		return -ENOENT;
+	}
+	return reg_map[num];
+}
+
+#elif defined(__aarch64__)
+
+static int calc_pt_regs_off(int num)
+{
+	if (num >= 0 && num < 31)
+		return offsetof(struct user_pt_regs, regs[reg_num]);
+	else if (num == 33)
+		return offsetof(struct user_pt_regs, sp);
+	pr_warn("loc: unsupported register '%d'\n", num);
+	return -ENOENT;
+}
+
+#else
+static int calc_pt_regs_off(int num)
+{
+	pr_warn("loc: unsupported platform (register '%d')\n", num);
+	return -ENOENT;
+}
+#endif
+
+static int parse_loc_arg(const struct btf_type *t, __u64 base_addr, short arg_num, struct loc_arg_spec *arg)
+{
+	const struct btf_loc_param *lp = t ? btf_loc_param(t) : NULL;
+	int reg_off, arg_sz;
+	bool is_const;
+
+	if (!t) {
+		arg->arg_type = BPF_LOC_ARG_UNAVAILABLE;
+		return 0;
+	}
+	is_const = btf_kflag(t);
+	arg_sz = BTF_TYPE_LOC_PARAM_SIZE(t);
+	if (arg_sz < 0) {
+		arg->arg_signed = true;
+		arg_sz = -arg_sz;
+	}
+	switch (arg_sz) {
+	case 1: case 2: case 4: case 8:
+		arg->arg_bitshift = 64 - arg_sz * 8;
+		break;
+	default:
+		pr_warn("loc: unsupported arg #%d size: %d\n",
+			arg_num, arg_sz);
+		return -EINVAL;
+	}
+
+	if (is_const) {
+		arg->arg_type = BPF_LOC_ARG_CONST;
+		arg->val_off = lp->val_lo32 | ((__u64)lp->val_hi32 << 32);
+		if (arg_sz == 8)
+			arg->val_off += base_addr;
+	} else {
+		reg_off = calc_pt_regs_off(lp->reg);
+		if (reg_off < 0)
+			return reg_off;
+		if (arg->arg_type == BPF_LOC_ARG_REG_MULTI) {
+			arg->reg_offs[1] = reg_off;
+		} else {
+			if (lp->flags & BTF_LOC_FLAG_CONTINUE)
+				arg->arg_type = BPF_LOC_ARG_REG_MULTI;
+			else
+				arg->arg_type = BPF_LOC_ARG_REG;
+			arg->reg_off = reg_off;
+		}
+		arg->val_off = 0;
+		if (lp->flags & BTF_LOC_FLAG_REG_DEREF) {
+			arg->arg_type = BPF_LOC_ARG_REG_DEREF;
+			arg->val_off = lp->offset;
+		}
+	}
+	if (lp->flags & BTF_LOC_FLAG_CONTINUE)
+		return 1;
+	return 0;
+}
+
+static int parse_loc_spec(struct btf *btf, __u64 base_addr, const char *name,
+			  __u32 func_proto, __u32 loc_proto, __u32 offset,
+			  __u64 loc_cookie, struct loc_spec *spec)
+{
+	struct loc_arg_spec *arg;
+	const struct btf_param *p;
+	const struct btf_type *t;
+	int ret, i;
+	__u32 *l;
+
+	pr_debug("loc: parsing spec for '%s': func_proto_id %u loc_proto_id %u abs_ip 0x%llx\n",
+		 name, func_proto, loc_proto, base_addr + offset);
+	spec->loc_cookie = loc_cookie;
+
+	t = btf__type_by_id(btf, func_proto);
+	if (!t) {
+		pr_warn("loc: unknown func proto %u for '%s'\n", func_proto, name);
+		return -EINVAL;
+	}
+	spec->arg_cnt = btf_vlen(t);
+	if (spec->arg_cnt >= LOC_MAX_ARG_CNT) {
+		pr_warn("loc: too many loc arguments (> %d) for '%s'\n",
+			LOC_MAX_ARG_CNT, name);
+		return -E2BIG;
+	}
+	p = btf_params(t);
+
+	t = btf__type_by_id(btf, loc_proto);
+	if (!t) {
+		pr_warn("loc: unknown loc proto %u for '%s'\n", func_proto, name);
+		return -EINVAL;
+	}
+	l = btf_loc_proto_params(t);
+
+	for (i = 0 ; i < spec->arg_cnt; i++, l++, p++) {
+		__u64 addr = 0;
+
+		arg = &spec->args[i];
+		if (*l == 0) {
+			t = NULL;
+		} else {
+			__u32 id;
+
+			/* use func proto to determine if the value
+			 * is an address; if so we need to add base addr
+			 * to value.
+			 */
+			for (id = p->type;
+			     (t = btf__type_by_id(btf, id)) != NULL;
+			     id = t->type) {
+				if (!btf_is_mod(t) && !btf_is_typedef(t))
+					break;
+			}
+			if (t && btf_is_ptr(t))
+				addr = base_addr;
+
+			t = btf__type_by_id(btf, *l);
+			if (!t) {
+				pr_warn("loc: unknown type id %u for '%s'\n",
+					*l, name);
+				return -EINVAL;
+			}
+		}
+		ret = parse_loc_arg(t, addr, i, arg);
+		if (ret < 0)
+			return ret;
+		/* multi-reg location param? */
+		if (ret > 0) {
+			l++;
+			t = btf__type_by_id(btf, *l);
+
+			ret = parse_loc_arg(t, addr, i, arg);
+		}
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static int collect_loc_targets(struct loc_manager *man, const char *mod, const char *name,
+			       __u64 loc_cookie, struct loc_target **out_targets,
+			       size_t *out_target_cnt)
+{
+	struct loc_target *tmp, *targets = NULL;
+	struct btf *base_btf, *btf = NULL;
+	__u32 start_id, type_cnt;
+	size_t target_cnt = 0;
+	__u64 base_addr = 0;
+	int err = 0;
+	__u32 i, j;
+
+	base_btf = btf__load_vmlinux_btf();
+	if (!IS_ERR(base_btf) && strcmp(mod, "vmlinux") != 0)
+		base_btf = btf__load_module_btf(mod, base_btf);
+	if (IS_ERR(base_btf))
+		return PTR_ERR(base_btf);
+	btf = btf__load_btf_extra(mod, base_btf);
+	if (IS_ERR(btf)) {
+		btf__free(base_btf);
+		return PTR_ERR(btf);
+	}
+
+	start_id = base_btf ? btf__type_cnt(base_btf) : 1;
+	type_cnt = btf__type_cnt(btf);
+
+	err = get_base_addr(mod, &base_addr);
+	if (err)
+		goto err_out;
+
+	for (i = start_id; i < type_cnt; i++) {
+		struct loc_target *target;
+		const struct btf_type *t;
+		const struct btf_loc *l;
+		const char *locname;
+		int vlen;
+
+		t = btf__type_by_id(btf, i);
+		if (!btf_is_locsec(t))
+			continue;
+		vlen = btf_vlen(t);
+		l = btf_locsec_locs(t);
+
+		for (j = 0; j < vlen; j++, l++) {
+			locname = btf__name_by_offset(btf, l->name_off);
+			if (!locname || strcmp(name, locname) != 0)
+				continue;
+			tmp = libbpf_reallocarray(targets, target_cnt + 1, sizeof(*targets));
+			if (!tmp) {
+				err = -ENOMEM;
+				goto err_out;
+			}
+			targets = tmp;
+			target = &targets[target_cnt];
+			memset(target, 0, sizeof(*target));
+			target->abs_ip = base_addr + l->offset;
+			err = parse_loc_spec(btf, base_addr, locname,
+					     l->func_proto, l->loc_proto, l->offset,
+					     loc_cookie, &target->spec);
+			if (err)
+				goto err_out;
+			target_cnt++;
+
+		}
+	}
+	*out_targets = targets;
+	*out_target_cnt = target_cnt;
+	return target_cnt;
+err_out:
+	free(targets);
+	return err;
+}
-- 
2.39.3


