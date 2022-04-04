Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC874F2123
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 06:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiDECil convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 4 Apr 2022 22:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiDECi3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 22:38:29 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2CB31CF3C
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 18:38:12 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234NPExM022550
        for <bpf@vger.kernel.org>; Mon, 4 Apr 2022 16:42:31 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f7x4xdg0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 16:42:30 -0700
Received: from twshared31479.05.prn5.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 4 Apr 2022 16:42:29 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id ACD631661B525; Mon,  4 Apr 2022 16:42:13 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v3 bpf-next 5/7] libbpf: add x86-specific USDT arg spec parsing logic
Date:   Mon, 4 Apr 2022 16:42:00 -0700
Message-ID: <20220404234202.331384-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404234202.331384-1-andrii@kernel.org>
References: <20220404234202.331384-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rlhbieAsbGgtJZjk0rP5rNsF9_HmVgXg
X-Proofpoint-ORIG-GUID: rlhbieAsbGgtJZjk0rP5rNsF9_HmVgXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_09,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add x86/x86_64-specific USDT argument specification parsing. Each
architecture will require their own logic, as all this is arch-specific
assembly-based notation. Architectures that libbpf doesn't support for
USDTs will pr_warn() with specific error and return -ENOTSUP.

We use sscanf() as a very powerful and easy to use string parser. Those
spaces in sscanf's format string mean "skip any whitespaces", which is
pretty nifty (and somewhat little known) feature.

All this was tested on little-endian architecture, so bit shifts are
probably off on big-endian, which our CI will hopefully prove.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/usdt.c | 105 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 2799387c5465..1bce2eab5e89 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -1168,8 +1168,113 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
 	return 0;
 }
 
+/* Architecture-specific logic for parsing USDT argument location specs */
+
+#if defined(__x86_64__) || defined(__i386__)
+
+static int calc_pt_regs_off(const char *reg_name)
+{
+	static struct {
+		const char *names[4];
+		size_t pt_regs_off;
+	} reg_map[] = {
+#if __x86_64__
+#define reg_off(reg64, reg32) offsetof(struct pt_regs, reg64)
+#else
+#define reg_off(reg64, reg32) offsetof(struct pt_regs, reg32)
+#endif
+		{ {"rip", "eip", "", ""}, reg_off(rip, eip) },
+		{ {"rax", "eax", "ax", "al"}, reg_off(rax, eax) },
+		{ {"rbx", "ebx", "bx", "bl"}, reg_off(rbx, ebx) },
+		{ {"rcx", "ecx", "cx", "cl"}, reg_off(rcx, ecx) },
+		{ {"rdx", "edx", "dx", "dl"}, reg_off(rdx, edx) },
+		{ {"rsi", "esi", "si", "sil"}, reg_off(rsi, esi) },
+		{ {"rdi", "edi", "di", "dil"}, reg_off(rdi, edi) },
+		{ {"rbp", "ebp", "bp", "bpl"}, reg_off(rbp, ebp) },
+		{ {"rsp", "esp", "sp", "spl"}, reg_off(rsp, esp) },
+#undef reg_off
+#if __x86_64__
+		{ {"r8", "r8d", "r8w", "r8b"}, offsetof(struct pt_regs, r8) },
+		{ {"r9", "r9d", "r9w", "r9b"}, offsetof(struct pt_regs, r9) },
+		{ {"r10", "r10d", "r10w", "r10b"}, offsetof(struct pt_regs, r10) },
+		{ {"r11", "r11d", "r11w", "r11b"}, offsetof(struct pt_regs, r11) },
+		{ {"r12", "r12d", "r12w", "r12b"}, offsetof(struct pt_regs, r12) },
+		{ {"r13", "r13d", "r13w", "r13b"}, offsetof(struct pt_regs, r13) },
+		{ {"r14", "r14d", "r14w", "r14b"}, offsetof(struct pt_regs, r14) },
+		{ {"r15", "r15d", "r15w", "r15b"}, offsetof(struct pt_regs, r15) },
+#endif
+	};
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(reg_map); i++) {
+		for (j = 0; j < ARRAY_SIZE(reg_map[i].names); j++) {
+			if (strcmp(reg_name, reg_map[i].names[j]) == 0)
+				return reg_map[i].pt_regs_off;
+		}
+	}
+
+	pr_warn("usdt: unrecognized register '%s'\n", reg_name);
+	return -ENOENT;
+}
+
+static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
+{
+	char *reg_name = NULL;
+	int arg_sz, len, reg_off;
+	long off;
+
+	if (sscanf(arg_str, " %d @ %ld ( %%%m[^)] ) %n", &arg_sz, &off, &reg_name, &len) == 3) {
+		/* Memory dereference case, e.g., -4@-20(%rbp) */
+		arg->arg_type = USDT_ARG_REG_DEREF;
+		arg->val_off = off;
+		reg_off = calc_pt_regs_off(reg_name);
+		free(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off = reg_off;
+	} else if (sscanf(arg_str, " %d @ %%%ms %n", &arg_sz, &reg_name, &len) == 2) {
+		/* Register read case, e.g., -4@%eax */
+		arg->arg_type = USDT_ARG_REG;
+		arg->val_off = 0;
+
+		reg_off = calc_pt_regs_off(reg_name);
+		free(reg_name);
+		if (reg_off < 0)
+			return reg_off;
+		arg->reg_off = reg_off;
+	} else if (sscanf(arg_str, " %d @ $%ld %n", &arg_sz, &off, &len) == 2) {
+		/* Constant value case, e.g., 4@$71 */
+		arg->arg_type = USDT_ARG_CONST;
+		arg->val_off = off;
+		arg->reg_off = 0;
+	} else {
+		pr_warn("usdt: unrecognized arg #%d spec '%s'\n", arg_num, arg_str);
+		return -EINVAL;
+	}
+
+	arg->arg_signed = arg_sz < 0;
+	if (arg_sz < 0)
+		arg_sz = -arg_sz;
+
+	switch (arg_sz) {
+	case 1: case 2: case 4: case 8:
+		arg->arg_bitshift = 64 - arg_sz * 8;
+		break;
+	default:
+		pr_warn("usdt: unsupported arg #%d (spec '%s') size: %d\n",
+			arg_num, arg_str, arg_sz);
+		return -EINVAL;
+	}
+
+	return len;
+}
+
+#else
+
 static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg)
 {
 	pr_warn("usdt: libbpf doesn't support USDTs on current architecture\n");
 	return -ENOTSUP;
 }
+
+#endif
-- 
2.30.2

