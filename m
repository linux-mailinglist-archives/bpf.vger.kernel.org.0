Return-Path: <bpf+bounces-44943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A559CDD91
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 12:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D731F22EDE
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9E1B86E4;
	Fri, 15 Nov 2024 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n6WxlFLk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C99D1B85D1;
	Fri, 15 Nov 2024 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670608; cv=none; b=eVdTBL7sPhGxYTXbtHD9pQT4vcZKKZP22M2CSov7C7Hx6sDK0Eg+ICOLT5aZECoFF9OWnPM/fodLGV6gPxklEEKO+CtctFAIvMhedS9sdpTS39b6RNltSGIT5jv/5RUJ1rG9IoqbEJaxMGdQJWEc2dWL6ZtVPX3mNJInvf1mya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670608; c=relaxed/simple;
	bh=9D5vNGHLmKhFuC6ytxJwUWJ51do5mulIB2TFCCBBJZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKo7T/dTspoLUxvou4hTlXfkhx7F2fWXzWmHG6Pfdc2K5z37Q9gyfNDuwolObEpgM1fjcIes67HJEIxT8+lkrtXInpflPhRU7/Xp/7h1ui6PxhqQ5h3LIRuNb9Mwnw4VUVm33kVqUWnI7BGqptAA5vSl98tdaTe057FeeTHkKmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n6WxlFLk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAH1g4014178;
	Fri, 15 Nov 2024 11:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=LD+B4
	3l8SW5UtEkNpqxu1bSIIAELtozHJuhGjrSTRYI=; b=n6WxlFLkPokT886KIhCRa
	wOt+SE2Y67RRhCScEyDZ699yiMYZbW0+aeqN3/r/VnX/ou8xNr5ERfLN+rPZ8V6P
	TIdv7wepb2TWg0157Y3UBgoBPxBuHtTMFukvAsaUhZXmL8dnhYTjwih63LVI5/PF
	bTFO1LKaMkkWslawfv3jopRLEsyZjwrPtNEayfwnAtCgdIRs9vb27rVkYd/qZMnp
	1OdAgJqEcwmG2uk5iGk/SyoqHW75WrerEk439PRw0JgXmrS2WlweQy3VADDnDEVj
	j4orKWVo8ojgH4UpzBcxO1Mr0lnEhaZMQElH9Ecb6zpKTGoyEF/LtSDefXH3EpTb
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5k3d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 11:36:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFBLaYM035901;
	Fri, 15 Nov 2024 11:36:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c38bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 11:36:12 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AFBa9PH010008;
	Fri, 15 Nov 2024 11:36:12 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-214-128.vpn.oracle.com [10.175.214.128])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42sx6c388q-2;
	Fri, 15 Nov 2024 11:36:12 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, song@kernel.org, eddyz87@gmail.com,
        olsajiri@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 1/2] dwarf_loader: Check DW_OP_[GNU_]entry_value for possible parameter matching
Date: Fri, 15 Nov 2024 11:36:04 +0000
Message-ID: <20241115113605.1504796-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241115113605.1504796-1-alan.maguire@oracle.com>
References: <20241115113605.1504796-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150099
X-Proofpoint-ORIG-GUID: fI58DbZIiHLzONgvfDkYw0omvIja288c
X-Proofpoint-GUID: fI58DbZIiHLzONgvfDkYw0omvIja288c

From: Eduard Zingerman <eddyz87@gmail.com>

Song Liu reported that a kernel func (perf_event_read()) cannot be traced
in certain situations since the func is not in vmlinux bTF. This happens
in kernels 6.4, 6.9 and 6.11 and the kernel is built with pahole 1.27.

The perf_event_read() signature in kernel (kernel/events/core.c):
   static int perf_event_read(struct perf_event *event, bool group)

Adding '-V' to pahole command line, and the following error msg can be found:
   skipping addition of 'perf_event_read'(perf_event_read) due to unexpected register used for parameter

Eventually the error message is attributed to the setting
(parm->unexpected_reg = 1) in parameter__new() function.

The following is the dwarf representation for perf_event_read():
    0x0334c034:   DW_TAG_subprogram
                DW_AT_low_pc    (0xffffffff812c6110)
                DW_AT_high_pc   (0xffffffff812c640a)
                DW_AT_frame_base        (DW_OP_reg7 RSP)
                DW_AT_GNU_all_call_sites        (true)
                DW_AT_name      ("perf_event_read")
                DW_AT_decl_file ("/rw/compile/kernel/events/core.c")
                DW_AT_decl_line (4641)
                DW_AT_prototyped        (true)
                DW_AT_type      (0x03324f6a "int")
    0x0334c04e:     DW_TAG_formal_parameter
                  DW_AT_location        (0x007de9fd:
                     [0xffffffff812c6115, 0xffffffff812c6141): DW_OP_reg5 RDI
                     [0xffffffff812c6141, 0xffffffff812c6323): DW_OP_reg14 R14
                     [0xffffffff812c6323, 0xffffffff812c63fe): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
                     [0xffffffff812c63fe, 0xffffffff812c6405): DW_OP_reg14 R14
                     [0xffffffff812c6405, 0xffffffff812c640a): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
                  DW_AT_name    ("event")
                  DW_AT_decl_file       ("/rw/compile/kernel/events/core.c")
                  DW_AT_decl_line       (4641)
                  DW_AT_type    (0x0333aac2 "perf_event *")
    0x0334c05e:     DW_TAG_formal_parameter
                  DW_AT_location        (0x007dea82:
                     [0xffffffff812c6137, 0xffffffff812c63f2): DW_OP_reg12 R12
                     [0xffffffff812c63f2, 0xffffffff812c63fe): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
                     [0xffffffff812c63fe, 0xffffffff812c640a): DW_OP_reg12 R12)
                  DW_AT_name    ("group")
                  DW_AT_decl_file       ("/rw/compile/kernel/events/core.c")
                  DW_AT_decl_line       (4641)
                  DW_AT_type    (0x03327059 "bool")

By inspecting the binary, the second argument ("bool group") is used
in the function. The following are the disasm code:
    ffffffff812c6110 <perf_event_read>:
    ffffffff812c6110: 0f 1f 44 00 00        nopl    (%rax,%rax)
    ffffffff812c6115: 55                    pushq   %rbp
    ffffffff812c6116: 41 57                 pushq   %r15
    ffffffff812c6118: 41 56                 pushq   %r14
    ffffffff812c611a: 41 55                 pushq   %r13
    ffffffff812c611c: 41 54                 pushq   %r12
    ffffffff812c611e: 53                    pushq   %rbx
    ffffffff812c611f: 48 83 ec 18           subq    $24, %rsp
    ffffffff812c6123: 41 89 f4              movl    %esi, %r12d
    <=========== NOTE that here '%esi' is used and moved to '%r12d'.
    ffffffff812c6126: 49 89 fe              movq    %rdi, %r14
    ffffffff812c6129: 65 48 8b 04 25 28 00 00 00    movq    %gs:40, %rax
    ffffffff812c6132: 48 89 44 24 10        movq    %rax, 16(%rsp)
    ffffffff812c6137: 8b af a8 00 00 00     movl    168(%rdi), %ebp
    ffffffff812c613d: 85 ed                 testl   %ebp, %ebp
    ffffffff812c613f: 75 3f                 jne     0xffffffff812c6180 <perf_event_read+0x70>
    ffffffff812c6141: 66 2e 0f 1f 84 00 00 00 00 00 nopw    %cs:(%rax,%rax)
    ffffffff812c614b: 0f 1f 44 00 00        nopl    (%rax,%rax)
    ffffffff812c6150: 49 8b 9e 28 02 00 00  movq    552(%r14), %rbx
    ffffffff812c6157: 48 89 df              movq    %rbx, %rdi
    ffffffff812c615a: e8 c1 a0 d7 00        callq   0xffffffff82040220 <_raw_spin_lock_irqsave>
    ffffffff812c615f: 49 89 c7              movq    %rax, %r15
    ffffffff812c6162: 41 8b ae a8 00 00 00  movl    168(%r14), %ebp
    ffffffff812c6169: 85 ed                 testl   %ebp, %ebp
    ffffffff812c616b: 0f 84 9a 00 00 00     je      0xffffffff812c620b <perf_event_read+0xfb>
    ffffffff812c6171: 48 89 df              movq    %rbx, %rdi
    ffffffff812c6174: 4c 89 fe              movq    %r15, %rsi
    <=========== NOTE: %rsi is overwritten
    ......
    ffffffff812c63f0: 41 5c                 popq    %r12
    <============ POP r12
    ffffffff812c63f2: 41 5d                 popq    %r13
    ffffffff812c63f4: 41 5e                 popq    %r14
    ffffffff812c63f6: 41 5f                 popq    %r15
    ffffffff812c63f8: 5d                    popq    %rbp
    ffffffff812c63f9: e9 e2 a8 d7 00        jmp     0xffffffff82040ce0 <__x86_return_thunk>
    ffffffff812c63fe: 31 c0                 xorl    %eax, %eax
    ffffffff812c6400: e9 be fe ff ff        jmp     0xffffffff812c62c3 <perf_event_read+0x1b3>

It is not clear why dwarf didn't encode %rsi in locations. But
DW_OP_GNU_entry_value(DW_OP_reg4 RSI) tells us that RSI is live at
the entry of perf_event_read(). So this patch tries to search
DW_OP_GNU_entry_value/DW_OP_entry_value location/expression so if
the expected parameter register matches the register in
DW_OP_GNU_entry_value/DW_OP_entry_value, then the original parameter
is not optimized.

For one of internal 6.11 kernel, there are 62498 functions in BTF and
perf_event_read() is not there. With this patch, there are 62552 functions
in BTF and perf_event_read() is included.

Reported-by: Song Liu <song@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 106 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 23 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ec8641b..4789967 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1157,16 +1157,90 @@ static struct template_parameter_pack *template_parameter_pack__new(Dwarf_Die *d
 	return pack;
 }
 
+/* Returns number of locations found or negative value for errors. */
+static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
+				      ptrdiff_t offset, Dwarf_Addr *basep,
+				      Dwarf_Addr *startp, Dwarf_Addr *endp,
+				      Dwarf_Op **expr, size_t *exprlen)
+{
+	int ret;
+
+#if _ELFUTILS_PREREQ(0, 157)
+	ret = dwarf_getlocations(attr, offset, basep, startp, endp, expr, exprlen);
+#else
+	if (offset == 0) {
+		ret = dwarf_getlocation(attr, expr, exprlen);
+		if (ret == 0)
+			ret = 1;
+	}
+#endif
+	return ret;
+}
+
+/* For DW_AT_location 'attr':
+ * - if first location is DW_OP_regXX with expected number, return the register;
+ *   otherwise save the register for later return
+ * - if location DW_OP_entry_value(DW_OP_regXX) with expected number is in the
+ *   list, return the register; otherwise save register for later return
+ * - otherwise if no register was found for locations, return -1.
+ */
+static int parameter__reg(Dwarf_Attribute *attr, int expected_reg)
+{
+	Dwarf_Addr base, start, end;
+	Dwarf_Op *expr, *entry_ops;
+	Dwarf_Attribute entry_attr;
+	size_t exprlen, entry_len;
+	ptrdiff_t offset = 0;
+	int loc_num = -1;
+	int ret = -1;
+
+	while ((offset = __dwarf_getlocations(attr, offset, &base, &start, &end, &expr, &exprlen)) > 0) {
+		loc_num++;
+
+		/* Convert expression list (XX DW_OP_stack_value) -> (XX).
+		 * DW_OP_stack_value instructs interpreter to pop current value from
+		 * DWARF expression evaluation stack, and thus is not important here.
+		 */
+		if (exprlen > 1 && expr[exprlen - 1].atom == DW_OP_stack_value)
+			exprlen--;
+
+		if (exprlen != 1)
+			continue;
+
+		switch (expr->atom) {
+		/* match DW_OP_regXX at first location */
+		case DW_OP_reg0 ... DW_OP_reg31:
+			if (loc_num != 0)
+				break;
+			ret = expr->atom;
+			if (ret == expected_reg)
+				goto out;
+			break;
+		/* match DW_OP_entry_value(DW_OP_regXX) at any location */
+		case DW_OP_entry_value:
+		case DW_OP_GNU_entry_value:
+			if (dwarf_getlocation_attr(attr, expr, &entry_attr) == 0 &&
+			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
+			    entry_len == 1) {
+				ret = entry_ops->atom;
+				if (ret == expected_reg)
+					goto out;
+			}
+			break;
+		}
+	}
+out:
+	return ret;
+}
+
 static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 					struct conf_load *conf, int param_idx)
 {
 	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
 
 	if (parm != NULL) {
-		Dwarf_Addr base, start, end;
 		bool has_const_value;
 		Dwarf_Attribute attr;
-		struct location loc;
 
 		tag__init(&parm->tag, cu, die);
 		parm->name = attr_string(die, DW_AT_name, conf);
@@ -1208,35 +1282,21 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 		 */
 		has_const_value = dwarf_attr(die, DW_AT_const_value, &attr) != NULL;
 		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
-		/* dwarf_getlocations() handles location lists; here we are
-		 * only interested in the first expr.
-		 */
-		if (parm->has_loc &&
-#if _ELFUTILS_PREREQ(0, 157)
-		    dwarf_getlocations(&attr, 0, &base, &start, &end,
-				       &loc.expr, &loc.exprlen) > 0 &&
-#else
-		    dwarf_getlocation(&attr, &loc.expr, &loc.exprlen) == 0 &&
-#endif
-			loc.exprlen != 0) {
+
+		if (parm->has_loc) {
 			int expected_reg = cu->register_params[param_idx];
-			Dwarf_Op *expr = loc.expr;
+			int actual_reg = parameter__reg(&attr, expected_reg);
 
-			switch (expr->atom) {
-			case DW_OP_reg0 ... DW_OP_reg31:
+			if (actual_reg < 0)
+				parm->optimized = 1;
+			else if (expected_reg >= 0 && expected_reg != actual_reg)
 				/* mark parameters that use an unexpected
 				 * register to hold a parameter; these will
 				 * be problematic for users of BTF as they
 				 * violate expectations about register
 				 * contents.
 				 */
-				if (expected_reg >= 0 && expected_reg != expr->atom)
-					parm->unexpected_reg = 1;
-				break;
-			default:
-				parm->optimized = 1;
-				break;
-			}
+				parm->unexpected_reg = 1;
 		} else if (has_const_value) {
 			parm->optimized = 1;
 		}
-- 
2.31.1


