Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B5C572B16
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 03:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiGMBxR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 12 Jul 2022 21:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiGMBxQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 21:53:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C359CD4BC7
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:53:15 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CLjqoj007849
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:53:15 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h9h5f91m0-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:53:15 -0700
Received: from twshared3657.05.prn5.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 12 Jul 2022 18:53:12 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D5DC21C4081D8; Tue, 12 Jul 2022 18:53:07 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 1/5] libbpf: generalize virtual __kconfig externs and use it for USDT
Date:   Tue, 12 Jul 2022 18:53:00 -0700
Message-ID: <20220713015304.3375777-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713015304.3375777-1-andrii@kernel.org>
References: <20220713015304.3375777-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Tv9rU6l6Hqn-LwrOPbGUi1Y5JRipcZjh
X-Proofpoint-ORIG-GUID: Tv9rU6l6Hqn-LwrOPbGUi1Y5JRipcZjh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-12_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Libbpf supports single virtual __kconfig extern currently: LINUX_KERNEL_VERSION.
LINUX_KERNEL_VERSION isn't coming from /proc/kconfig.gz and is intead
customly filled out by libbpf.

This patch generalizes this approach to support more such virtual
__kconfig externs. One such extern added in this patch is
LINUX_HAS_BPF_COOKIE which is used for BPF-side USDT supporting code in
usdt.bpf.h instead of using CO-RE-based enum detection approach for
detecting bpf_get_attach_cookie() BPF helper. This allows to remove
otherwise not needed CO-RE dependency and keeps user-space and BPF-side
parts of libbpf's USDT support strictly in sync in terms of their
feature detection.

We'll use similar approach for syscall wrapper detection for
BPF_KSYSCALL() BPF-side macro in follow up patch.

Generally, currently libbpf reserves CONFIG_ prefix for Kconfig values
and LINUX_ for virtual libbpf-backed externs. In the future we might
extend the set of prefixes that are supported. This can be done without
any breaking changes, as currently any __kconfig extern with
unrecognized name is rejected.

For LINUX_xxx externs we support the normal "weak rule": if libbpf
doesn't recognize given LINUX_xxx extern but such extern is marked as
__weak, it is not rejected and defaults to zero.  This follows
CONFIG_xxx handling logic and will allow BPF applications to
opportunistically use newer libbpf virtual externs without breaking on
older libbpf versions unnecessarily.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c   | 69 +++++++++++++++++++++++++++++-----------
 tools/lib/bpf/usdt.bpf.h | 16 ++--------
 2 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cb49408eb298..4bae67767f82 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1800,11 +1800,18 @@ static bool is_kcfg_value_in_range(const struct extern_desc *ext, __u64 v)
 static int set_kcfg_value_num(struct extern_desc *ext, void *ext_val,
 			      __u64 value)
 {
-	if (ext->kcfg.type != KCFG_INT && ext->kcfg.type != KCFG_CHAR) {
-		pr_warn("extern (kcfg) %s=%llu should be integer\n",
+	if (ext->kcfg.type != KCFG_INT && ext->kcfg.type != KCFG_CHAR &&
+	    ext->kcfg.type != KCFG_BOOL) {
+		pr_warn("extern (kcfg) %s=%llu should be integer, char or boolean\n",
 			ext->name, (unsigned long long)value);
 		return -EINVAL;
 	}
+	if (ext->kcfg.type == KCFG_BOOL && value > 1) {
+		pr_warn("extern (kcfg) %s=%llu value isn't boolean\n",
+			ext->name, (unsigned long long)value);
+		return -EINVAL;
+
+	}
 	if (!is_kcfg_value_in_range(ext, value)) {
 		pr_warn("extern (kcfg) %s=%llu value doesn't fit in %d bytes\n",
 			ext->name, (unsigned long long)value, ext->kcfg.sz);
@@ -1870,10 +1877,13 @@ static int bpf_object__process_kconfig_line(struct bpf_object *obj,
 		/* assume integer */
 		err = parse_u64(value, &num);
 		if (err) {
-			pr_warn("extern (kcfg) %s=%s should be integer\n",
-				ext->name, value);
+			pr_warn("extern (kcfg) %s=%s should be integer\n", ext->name, value);
 			return err;
 		}
+		if (ext->kcfg.type != KCFG_INT && ext->kcfg.type != KCFG_CHAR) {
+			pr_warn("extern (kcfg) %s=%s should be integer\n", ext->name, value);
+			return -EINVAL;
+		}
 		err = set_kcfg_value_num(ext, ext_val, num);
 		break;
 	}
@@ -7493,26 +7503,47 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 	for (i = 0; i < obj->nr_extern; i++) {
 		ext = &obj->externs[i];
 
-		if (ext->type == EXT_KCFG &&
-		    strcmp(ext->name, "LINUX_KERNEL_VERSION") == 0) {
-			void *ext_val = kcfg_data + ext->kcfg.data_off;
-			__u32 kver = get_kernel_version();
+		if (ext->type == EXT_KSYM) {
+			if (ext->ksym.type_id)
+				need_vmlinux_btf = true;
+			else
+				need_kallsyms = true;
+			continue;
+		} else if (ext->type == EXT_KCFG) {
+			void *ext_ptr = kcfg_data + ext->kcfg.data_off;
+			__u64 value = 0;
+
+			/* Kconfig externs need actual /proc/config.gz */
+			if (str_has_pfx(ext->name, "CONFIG_")) {
+				need_config = true;
+				continue;
+			}
 
-			if (!kver) {
-				pr_warn("failed to get kernel version\n");
+			/* Virtual kcfg externs are customly handled by libbpf */
+			if (strcmp(ext->name, "LINUX_KERNEL_VERSION") == 0) {
+				value = get_kernel_version();
+				if (!value) {
+					pr_warn("extern (kcfg) '%s': failed to get kernel version\n", ext->name);
+					return -EINVAL;
+				}
+			} else if (strcmp(ext->name, "LINUX_HAS_BPF_COOKIE") == 0) {
+				value = kernel_supports(obj, FEAT_BPF_COOKIE);
+			} else if (!str_has_pfx(ext->name, "LINUX_") || !ext->is_weak) {
+				/* Currently libbpf supports only CONFIG_ and LINUX_ prefixed
+				 * __kconfig externs, where LINUX_ ones are virtual and filled out
+				 * customly by libbpf (their values don't come from Kconfig).
+				 * If LINUX_xxx variable is not recognized by libbpf, but is marked
+				 * __weak, it defaults to zero value, just like for CONFIG_xxx
+				 * externs.
+				 */
+				pr_warn("extern (kcfg) '%s': unrecognized virtual extern\n", ext->name);
 				return -EINVAL;
 			}
-			err = set_kcfg_value_num(ext, ext_val, kver);
+
+			err = set_kcfg_value_num(ext, ext_ptr, value);
 			if (err)
 				return err;
-			pr_debug("extern (kcfg) %s=0x%x\n", ext->name, kver);
-		} else if (ext->type == EXT_KCFG && str_has_pfx(ext->name, "CONFIG_")) {
-			need_config = true;
-		} else if (ext->type == EXT_KSYM) {
-			if (ext->ksym.type_id)
-				need_vmlinux_btf = true;
-			else
-				need_kallsyms = true;
+			pr_debug("extern (kcfg) %s=0x%llx\n", ext->name, (long long)value);
 		} else {
 			pr_warn("unrecognized extern '%s'\n", ext->name);
 			return -EINVAL;
diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
index 4181fddb3687..4f2adc0bd6ca 100644
--- a/tools/lib/bpf/usdt.bpf.h
+++ b/tools/lib/bpf/usdt.bpf.h
@@ -6,7 +6,6 @@
 #include <linux/errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include <bpf/bpf_core_read.h>
 
 /* Below types and maps are internal implementation details of libbpf's USDT
  * support and are subjects to change. Also, bpf_usdt_xxx() API helpers should
@@ -30,14 +29,6 @@
 #ifndef BPF_USDT_MAX_IP_CNT
 #define BPF_USDT_MAX_IP_CNT (4 * BPF_USDT_MAX_SPEC_CNT)
 #endif
-/* We use BPF CO-RE to detect support for BPF cookie from BPF side. This is
- * the only dependency on CO-RE, so if it's undesirable, user can override
- * BPF_USDT_HAS_BPF_COOKIE to specify whether to BPF cookie is supported or not.
- */
-#ifndef BPF_USDT_HAS_BPF_COOKIE
-#define BPF_USDT_HAS_BPF_COOKIE \
-	bpf_core_enum_value_exists(enum bpf_func_id___usdt, BPF_FUNC_get_attach_cookie___usdt)
-#endif
 
 enum __bpf_usdt_arg_type {
 	BPF_USDT_ARG_CONST,
@@ -83,15 +74,12 @@ struct {
 	__type(value, __u32);
 } __bpf_usdt_ip_to_spec_id SEC(".maps") __weak;
 
-/* don't rely on user's BPF code to have latest definition of bpf_func_id */
-enum bpf_func_id___usdt {
-	BPF_FUNC_get_attach_cookie___usdt = 0xBAD, /* value doesn't matter */
-};
+extern const _Bool LINUX_HAS_BPF_COOKIE __kconfig;
 
 static __always_inline
 int __bpf_usdt_spec_id(struct pt_regs *ctx)
 {
-	if (!BPF_USDT_HAS_BPF_COOKIE) {
+	if (!LINUX_HAS_BPF_COOKIE) {
 		long ip = PT_REGS_IP(ctx);
 		int *spec_id_ptr;
 
-- 
2.30.2

