Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED974EFD6E
	for <lists+bpf@lfdr.de>; Sat,  2 Apr 2022 02:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiDBAb5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 1 Apr 2022 20:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiDBAby (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Apr 2022 20:31:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D091A6362
        for <bpf@vger.kernel.org>; Fri,  1 Apr 2022 17:30:02 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2320C4BN010055
        for <bpf@vger.kernel.org>; Fri, 1 Apr 2022 17:30:02 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3f5gpcjnfb-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 01 Apr 2022 17:30:02 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 17:29:59 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 8606C15EB518B; Fri,  1 Apr 2022 17:29:47 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 bpf-next 1/7] libbpf: add BPF-side of USDT support
Date:   Fri, 1 Apr 2022 17:29:38 -0700
Message-ID: <20220402002944.382019-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220402002944.382019-1-andrii@kernel.org>
References: <20220402002944.382019-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 02wxvTJ26Wnup3ZzOUSdfD2EAIaQrc4w
X-Proofpoint-GUID: 02wxvTJ26Wnup3ZzOUSdfD2EAIaQrc4w
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

Add BPF-side implementation of libbpf-provided USDT support. This
consists of single header library, usdt.bpf.h, which is meant to be used
from user's BPF-side source code. This header is added to the list of
installed libbpf header, along bpf_helpers.h and others.

BPF-side implementation consists of two BPF maps:
  - spec map, which contains "a USDT spec" which encodes information
    necessary to be able to fetch USDT arguments and other information
    (argument count, user-provided cookie value, etc) at runtime;
  - IP-to-spec-ID map, which is only used on kernels that don't support
    BPF cookie feature. It allows to lookup spec ID based on the place
    in user application that triggers USDT program.

These maps have default sizes, 256 and 1024, which are chosen
conservatively to not waste a lot of space, but handling a lot of common
cases. But there could be cases when user application needs to either
trace a lot of different USDTs, or USDTs are heavily inlined and their
arguments are located in a lot of differing locations. For such cases it
might be necessary to size those maps up, which libbpf allows to do by
overriding BPF_USDT_MAX_SPEC_CNT and BPF_USDT_MAX_IP_CNT macros.

It is an important aspect to keep in mind. Single USDT (user-space
equivalent of kernel tracepoint) can have multiple USDT "call sites".
That is, single logical USDT is triggered from multiple places in user
application. This can happen due to function inlining. Each such inlined
instance of USDT invocation can have its own unique USDT argument
specification (instructions about the location of the value of each of
USDT arguments). So while USDT looks very similar to usual uprobe or
kernel tracepoint, under the hood it's actually a collection of uprobes,
each potentially needing different spec to know how to fetch arguments.

User-visible API consists of three helper functions:
  - bpf_usdt_arg_cnt(), which returns number of arguments of current USDT;
  - bpf_usdt_arg(), which reads value of specified USDT argument (by
    it's zero-indexed position) and returns it as 64-bit value;
  - bpf_usdt_cookie(), which functions like BPF cookie for USDT
    programs; this is necessary as libbpf doesn't allow specifying actual
    BPF cookie and utilizes it internally for USDT support implementation.

Each bpf_usdt_xxx() APIs expect struct pt_regs * context, passed into
BPF program. On kernels that don't support BPF cookie it is used to
fetch absolute IP address of the underlying uprobe.

usdt.bpf.h also provides BPF_USDT() macro, which functions like
BPF_PROG() and BPF_KPROBE() and allows much more user-friendly way to
get access to USDT arguments, if USDT definition is static and known to
the user. It is expected that majority of use cases won't have to use
bpf_usdt_arg_cnt() and bpf_usdt_arg() directly and BPF_USDT() will cover
all their needs.

Last, usdt.bpf.h is utilizing BPF CO-RE for one single purpose: to
detect kernel support for BPF cookie. If BPF CO-RE dependency is
undesirable, user application can redefine BPF_USDT_HAS_BPF_COOKIE to
either a boolean constant (or equivalently zero and non-zero), or even
point it to its own .rodata variable that can be specified from user's
application user-space code. It is important that
BPF_USDT_HAS_BPF_COOKIE is known to BPF verifier as static value (thus
.rodata and not just .data), as otherwise BPF code will still contain
bpf_get_attach_cookie() BPF helper call and will fail validation at
runtime, if not dead-code eliminated.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/Makefile   |   2 +-
 tools/lib/bpf/usdt.bpf.h | 256 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 257 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/bpf/usdt.bpf.h

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index b8b37fe76006..b4fbe8bed555 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -239,7 +239,7 @@ install_lib: all_cmd
 
 SRC_HDRS := bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h xsk.h	     \
 	    bpf_helpers.h bpf_tracing.h bpf_endian.h bpf_core_read.h	     \
-	    skel_internal.h libbpf_version.h
+	    skel_internal.h libbpf_version.h usdt.bpf.h
 GEN_HDRS := $(BPF_GENERATED)
 
 INSTALL_PFX := $(DESTDIR)$(prefix)/include/bpf
diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
new file mode 100644
index 000000000000..0941c915d58d
--- /dev/null
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -0,0 +1,256 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+#ifndef __USDT_BPF_H__
+#define __USDT_BPF_H__
+
+#include <linux/errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+/* Below types and maps are internal implementation details of libbpf's USDT
+ * support and are subjects to change. Also, usdt_xxx() API helpers should be
+ * considered an unstable API as well and might be adjusted based on user
+ * feedback from using libbpf's USDT support in production.
+ */
+
+/* User can override BPF_USDT_MAX_SPEC_CNT to change default size of internal
+ * map that keeps track of USDT argument specifications. This might be
+ * necessary if there are a lot of USDT attachments.
+ */
+#ifndef BPF_USDT_MAX_SPEC_CNT
+#define BPF_USDT_MAX_SPEC_CNT 256
+#endif
+/* User can override BPF_USDT_MAX_IP_CNT to change default size of internal
+ * map that keeps track of IP (memory address) mapping to USDT argument
+ * specification.
+ * Note, if kernel supports BPF cookies, this map is not used and could be
+ * resized all the way to 1 to save a bit of memory.
+ */
+#ifndef BPF_USDT_MAX_IP_CNT
+#define BPF_USDT_MAX_IP_CNT (4 * BPF_USDT_MAX_SPEC_CNT)
+#endif
+/* We use BPF CO-RE to detect support for BPF cookie from BPF side. This is
+ * the only dependency on CO-RE, so if it's undesirable, user can override
+ * BPF_USDT_HAS_BPF_COOKIE to specify whether to BPF cookie is supported or not.
+ */
+#ifndef BPF_USDT_HAS_BPF_COOKIE
+#define BPF_USDT_HAS_BPF_COOKIE \
+	bpf_core_enum_value_exists(enum bpf_func_id___usdt, BPF_FUNC_get_attach_cookie___usdt)
+#endif
+
+enum __bpf_usdt_arg_type {
+	BPF_USDT_ARG_CONST,
+	BPF_USDT_ARG_REG,
+	BPF_USDT_ARG_REG_DEREF,
+};
+
+struct __bpf_usdt_arg_spec {
+	/* u64 scalar interpreted depending on arg_type, see below */
+	__u64 val_off;
+	/* arg location case, see bpf_udst_arg() for details */
+	enum __bpf_usdt_arg_type arg_type;
+	/* offset of referenced register within struct pt_regs */
+	short reg_off;
+	/* whether arg should be interpreted as signed value */
+	bool arg_signed;
+	/* number of bits that need to be cleared and, optionally,
+	 * sign-extended to cast arguments that are 1, 2, or 4 bytes
+	 * long into final 8-byte u64/s64 value returned to user
+	 */
+	char arg_bitshift;
+};
+
+/* should match USDT_MAX_ARG_CNT in usdt.c exactly */
+#define BPF_USDT_MAX_ARG_CNT 12
+struct __bpf_usdt_spec {
+	struct __bpf_usdt_arg_spec args[BPF_USDT_MAX_ARG_CNT];
+	__u64 usdt_cookie;
+	short arg_cnt;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, BPF_USDT_MAX_SPEC_CNT);
+	__type(key, int);
+	__type(value, struct __bpf_usdt_spec);
+} __bpf_usdt_specs SEC(".maps") __weak;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, BPF_USDT_MAX_IP_CNT);
+	__type(key, long);
+	__type(value, __u32);
+} __bpf_usdt_ip_to_spec_id SEC(".maps") __weak;
+
+/* don't rely on user's BPF code to have latest definition of bpf_func_id */
+enum bpf_func_id___usdt {
+	BPF_FUNC_get_attach_cookie___usdt = 0xBAD, /* value doesn't matter */
+};
+
+static __always_inline
+int __bpf_usdt_spec_id(struct pt_regs *ctx)
+{
+	if (!BPF_USDT_HAS_BPF_COOKIE) {
+		long ip = PT_REGS_IP(ctx);
+		int *spec_id_ptr;
+
+		spec_id_ptr = bpf_map_lookup_elem(&__bpf_usdt_ip_to_spec_id, &ip);
+		return spec_id_ptr ? *spec_id_ptr : -ESRCH;
+	}
+
+	return bpf_get_attach_cookie(ctx);
+}
+
+/* Return number of USDT arguments defined for currently traced USDT. */
+static inline __noinline
+int bpf_usdt_arg_cnt(struct pt_regs *ctx)
+{
+	struct __bpf_usdt_spec *spec;
+	int spec_id;
+
+	spec_id = __bpf_usdt_spec_id(ctx);
+	if (spec_id < 0)
+		return -ESRCH;
+
+	spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
+	if (!spec)
+		return -ESRCH;
+
+	return spec->arg_cnt;
+}
+
+/* Fetch USDT argument #*arg_num* (zero-indexed) and put its value into *res.
+ * Returns 0 on success; negative error, otherwise.
+ * On error *res is guaranteed to be set to zero.
+ */
+static inline __noinline
+int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
+{
+	struct __bpf_usdt_spec *spec;
+	struct __bpf_usdt_arg_spec *arg_spec;
+	unsigned long val;
+	int err, spec_id;
+
+	*res = 0;
+
+	spec_id = __bpf_usdt_spec_id(ctx);
+	if (spec_id < 0)
+		return -ESRCH;
+
+	spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
+	if (!spec)
+		return -ESRCH;
+
+	if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec->arg_cnt)
+		return -ENOENT;
+
+	arg_spec = &spec->args[arg_num];
+	switch (arg_spec->arg_type) {
+	case BPF_USDT_ARG_CONST:
+		/* Arg is just a constant ("-4@$-9" in USDT arg spec).
+		 * value is recorded in arg_spec->val_off directly.
+		 */
+		val = arg_spec->val_off;
+		break;
+	case BPF_USDT_ARG_REG:
+		/* Arg is in a register (e.g, "8@%rax" in USDT arg spec),
+		 * so we read the contents of that register directly from
+		 * struct pt_regs. To keep things simple user-space parts
+		 * record offsetof(struct pt_regs, <regname>) in arg_spec->reg_off.
+		 */
+		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
+		if (err)
+			return err;
+		break;
+	case BPF_USDT_ARG_REG_DEREF:
+		/* Arg is in memory addressed by register, plus some offset
+		 * (e.g., "-4@-1204(%rbp)" in USDT arg spec). Register is
+		 * identified lik with BPF_USDT_ARG_REG case, and the offset
+		 * is in arg_spec->val_off. We first fetch register contents
+		 * from pt_regs, then do another user-space probe read to
+		 * fetch argument value itself.
+		 */
+		err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
+		if (err)
+			return err;
+		err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec->val_off);
+		if (err)
+			return err;
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
+ * bpf_usdt_opts.usdt_cookie. This serves the same purpose as BPF cookie
+ * returned by bpf_get_attach_cookie(). Libbpf's support for USDT is itself
+ * utilizaing BPF cookies internally, so user can't use BPF cookie directly
+ * for USDT programs and has to use bpf_usdt_cookie() API instead.
+ */
+static inline __noinline
+long bpf_usdt_cookie(struct pt_regs *ctx)
+{
+	struct __bpf_usdt_spec *spec;
+	int spec_id;
+
+	spec_id = __bpf_usdt_spec_id(ctx);
+	if (spec_id < 0)
+		return 0;
+
+	spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
+	if (!spec)
+		return 0;
+
+	return spec->usdt_cookie;
+}
+
+/* we rely on ___bpf_apply() and ___bpf_narg() macros already defined in bpf_tracing.h */
+#define ___bpf_usdt_args0() ctx
+#define ___bpf_usdt_args1(x) ___bpf_usdt_args0(), ({ long _x; bpf_usdt_arg(ctx, 0, &_x); (void *)_x; })
+#define ___bpf_usdt_args2(x, args...) ___bpf_usdt_args1(args), ({ long _x; bpf_usdt_arg(ctx, 1, &_x); (void *)_x; })
+#define ___bpf_usdt_args3(x, args...) ___bpf_usdt_args2(args), ({ long _x; bpf_usdt_arg(ctx, 2, &_x); (void *)_x; })
+#define ___bpf_usdt_args4(x, args...) ___bpf_usdt_args3(args), ({ long _x; bpf_usdt_arg(ctx, 3, &_x); (void *)_x; })
+#define ___bpf_usdt_args5(x, args...) ___bpf_usdt_args4(args), ({ long _x; bpf_usdt_arg(ctx, 4, &_x); (void *)_x; })
+#define ___bpf_usdt_args6(x, args...) ___bpf_usdt_args5(args), ({ long _x; bpf_usdt_arg(ctx, 5, &_x); (void *)_x; })
+#define ___bpf_usdt_args7(x, args...) ___bpf_usdt_args6(args), ({ long _x; bpf_usdt_arg(ctx, 6, &_x); (void *)_x; })
+#define ___bpf_usdt_args8(x, args...) ___bpf_usdt_args7(args), ({ long _x; bpf_usdt_arg(ctx, 7, &_x); (void *)_x; })
+#define ___bpf_usdt_args9(x, args...) ___bpf_usdt_args8(args), ({ long _x; bpf_usdt_arg(ctx, 8, &_x); (void *)_x; })
+#define ___bpf_usdt_args10(x, args...) ___bpf_usdt_args9(args), ({ long _x; bpf_usdt_arg(ctx, 9, &_x); (void *)_x; })
+#define ___bpf_usdt_args11(x, args...) ___bpf_usdt_args10(args), ({ long _x; bpf_usdt_arg(ctx, 10, &_x); (void *)_x; })
+#define ___bpf_usdt_args12(x, args...) ___bpf_usdt_args11(args), ({ long _x; bpf_usdt_arg(ctx, 11, &_x); (void *)_x; })
+#define ___bpf_usdt_args(args...) ___bpf_apply(___bpf_usdt_args, ___bpf_narg(args))(args)
+
+/*
+ * BPF_USDT serves the same purpose for USDT handlers as BPF_PROG for
+ * tp_btf/fentry/fexit BPF programs and BPF_KPROBE for kprobes.
+ * Original struct pt_regs * context is preserved as 'ctx' argument.
+ */
+#define BPF_USDT(name, args...)						    \
+name(struct pt_regs *ctx);						    \
+static __attribute__((always_inline)) typeof(name(0))			    \
+____##name(struct pt_regs *ctx, ##args);				    \
+typeof(name(0)) name(struct pt_regs *ctx)				    \
+{									    \
+        _Pragma("GCC diagnostic push")					    \
+        _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")		    \
+        return ____##name(___bpf_usdt_args(args));			    \
+        _Pragma("GCC diagnostic pop")					    \
+}									    \
+static __attribute__((always_inline)) typeof(name(0))			    \
+____##name(struct pt_regs *ctx, ##args)
+
+#endif /* __USDT_BPF_H__ */
-- 
2.30.2

