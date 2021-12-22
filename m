Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB02E47D8E3
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 22:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhLVVjj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 22 Dec 2021 16:39:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3376 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240670AbhLVVjf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Dec 2021 16:39:35 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BMHx4sO006787
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 13:39:35 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d47tm1rfu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 13:39:35 -0800
Received: from twshared4941.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 13:39:34 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7951FDE5B0A8; Wed, 22 Dec 2021 13:39:25 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Kenta Tada <Kenta.Tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 1/2] libbpf: normalize PT_REGS_xxx() macro definitions
Date:   Wed, 22 Dec 2021 13:39:23 -0800
Message-ID: <20211222213924.1869758-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: OucRrTooAYcaxH5FYJ8P5ffP_DrFbXK-
X-Proofpoint-GUID: OucRrTooAYcaxH5FYJ8P5ffP_DrFbXK-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220112
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor PT_REGS macros definitions in  bpf_tracing.h to avoid excessive
duplication. We currently have classic PT_REGS_xxx() and CO-RE-enabled
PT_REGS_xxx_CORE(). We are about to add also _SYSCALL variants, which
would require excessive copying of all the per-architecture definitions.

Instead, separate architecture-specific field/register names from the
final macro that utilize them. That way for upcoming _SYSCALL variants
we'll be able to just define x86_64 exception and otherwise have one
common set of _SYSCALL macro definitions common for all architectures.

Cc: Kenta Tada <Kenta.Tada@sony.com>
Cc: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Björn Töpel <bjorn@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 377 +++++++++++++++---------------------
 1 file changed, 152 insertions(+), 225 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index db05a5937105..20fe06d0acd9 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -66,277 +66,204 @@
 
 #if defined(__KERNEL__) || defined(__VMLINUX_H__)
 
-#define PT_REGS_PARM1(x) ((x)->di)
-#define PT_REGS_PARM2(x) ((x)->si)
-#define PT_REGS_PARM3(x) ((x)->dx)
-#define PT_REGS_PARM4(x) ((x)->cx)
-#define PT_REGS_PARM5(x) ((x)->r8)
-#define PT_REGS_RET(x) ((x)->sp)
-#define PT_REGS_FP(x) ((x)->bp)
-#define PT_REGS_RC(x) ((x)->ax)
-#define PT_REGS_SP(x) ((x)->sp)
-#define PT_REGS_IP(x) ((x)->ip)
-
-#define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), di)
-#define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), si)
-#define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), dx)
-#define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), cx)
-#define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), r8)
-#define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), sp)
-#define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), bp)
-#define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), ax)
-#define PT_REGS_SP_CORE(x) BPF_CORE_READ((x), sp)
-#define PT_REGS_IP_CORE(x) BPF_CORE_READ((x), ip)
+#define __PT_PARM1_REG di
+#define __PT_PARM2_REG si
+#define __PT_PARM3_REG dx
+#define __PT_PARM4_REG cx
+#define __PT_PARM5_REG r8
+#define __PT_RET_REG sp
+#define __PT_FP_REG bp
+#define __PT_RC_REG ax
+#define __PT_SP_REG sp
+#define __PT_IP_REG ip
 
 #else
 
 #ifdef __i386__
-/* i386 kernel is built with -mregparm=3 */
-#define PT_REGS_PARM1(x) ((x)->eax)
-#define PT_REGS_PARM2(x) ((x)->edx)
-#define PT_REGS_PARM3(x) ((x)->ecx)
-#define PT_REGS_PARM4(x) 0
-#define PT_REGS_PARM5(x) 0
-#define PT_REGS_RET(x) ((x)->esp)
-#define PT_REGS_FP(x) ((x)->ebp)
-#define PT_REGS_RC(x) ((x)->eax)
-#define PT_REGS_SP(x) ((x)->esp)
-#define PT_REGS_IP(x) ((x)->eip)
-
-#define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), eax)
-#define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), edx)
-#define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), ecx)
-#define PT_REGS_PARM4_CORE(x) 0
-#define PT_REGS_PARM5_CORE(x) 0
-#define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), esp)
-#define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), ebp)
-#define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), eax)
-#define PT_REGS_SP_CORE(x) BPF_CORE_READ((x), esp)
-#define PT_REGS_IP_CORE(x) BPF_CORE_READ((x), eip)
-
-#else
 
-#define PT_REGS_PARM1(x) ((x)->rdi)
-#define PT_REGS_PARM2(x) ((x)->rsi)
-#define PT_REGS_PARM3(x) ((x)->rdx)
-#define PT_REGS_PARM4(x) ((x)->rcx)
-#define PT_REGS_PARM5(x) ((x)->r8)
-#define PT_REGS_RET(x) ((x)->rsp)
-#define PT_REGS_FP(x) ((x)->rbp)
-#define PT_REGS_RC(x) ((x)->rax)
-#define PT_REGS_SP(x) ((x)->rsp)
-#define PT_REGS_IP(x) ((x)->rip)
-
-#define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), rdi)
-#define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), rsi)
-#define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), rdx)
-#define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), rcx)
-#define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), r8)
-#define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), rsp)
-#define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), rbp)
-#define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), rax)
-#define PT_REGS_SP_CORE(x) BPF_CORE_READ((x), rsp)
-#define PT_REGS_IP_CORE(x) BPF_CORE_READ((x), rip)
-
-#endif
-#endif
+#define __PT_PARM1_REG eax
+#define __PT_PARM2_REG edx
+#define __PT_PARM3_REG ecx
+/* i386 kernel is built with -mregparm=3 */
+#define __PT_PARM4_REG __unsupported__
+#define __PT_PARM5_REG __unsupported__
+#define __PT_RET_REG esp
+#define __PT_FP_REG ebp
+#define __PT_RC_REG eax
+#define __PT_SP_REG esp
+#define __PT_IP_REG eip
+
+#else /* __i386__ */
+
+#define __PT_PARM1_REG rdi
+#define __PT_PARM2_REG rsi
+#define __PT_PARM3_REG rdx
+#define __PT_PARM4_REG rcx
+#define __PT_PARM5_REG r8
+#define __PT_RET_REG rsp
+#define __PT_FP_REG rbp
+#define __PT_RC_REG rax
+#define __PT_SP_REG rsp
+#define __PT_IP_REG rip
+
+#endif /* __i386__ */
+
+#endif /* __KERNEL__ || __VMLINUX_H__ */
 
 #elif defined(bpf_target_s390)
 
 /* s390 provides user_pt_regs instead of struct pt_regs to userspace */
-struct pt_regs;
-#define PT_REGS_S390 const volatile user_pt_regs
-#define PT_REGS_PARM1(x) (((PT_REGS_S390 *)(x))->gprs[2])
-#define PT_REGS_PARM2(x) (((PT_REGS_S390 *)(x))->gprs[3])
-#define PT_REGS_PARM3(x) (((PT_REGS_S390 *)(x))->gprs[4])
-#define PT_REGS_PARM4(x) (((PT_REGS_S390 *)(x))->gprs[5])
-#define PT_REGS_PARM5(x) (((PT_REGS_S390 *)(x))->gprs[6])
-#define PT_REGS_RET(x) (((PT_REGS_S390 *)(x))->gprs[14])
-/* Works only with CONFIG_FRAME_POINTER */
-#define PT_REGS_FP(x) (((PT_REGS_S390 *)(x))->gprs[11])
-#define PT_REGS_RC(x) (((PT_REGS_S390 *)(x))->gprs[2])
-#define PT_REGS_SP(x) (((PT_REGS_S390 *)(x))->gprs[15])
-#define PT_REGS_IP(x) (((PT_REGS_S390 *)(x))->psw.addr)
-
-#define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((PT_REGS_S390 *)(x), gprs[2])
-#define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((PT_REGS_S390 *)(x), gprs[3])
-#define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((PT_REGS_S390 *)(x), gprs[4])
-#define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((PT_REGS_S390 *)(x), gprs[5])
-#define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((PT_REGS_S390 *)(x), gprs[6])
-#define PT_REGS_RET_CORE(x) BPF_CORE_READ((PT_REGS_S390 *)(x), gprs[14])
-#define PT_REGS_FP_CORE(x) BPF_CORE_READ((PT_REGS_S390 *)(x), gprs[11])
-#define PT_REGS_RC_CORE(x) BPF_CORE_READ((PT_REGS_S390 *)(x), gprs[2])
-#define PT_REGS_SP_CORE(x) BPF_CORE_READ((PT_REGS_S390 *)(x), gprs[15])
-#define PT_REGS_IP_CORE(x) BPF_CORE_READ((PT_REGS_S390 *)(x), psw.addr)
+#define __PT_REGS_CAST(x) ((const user_pt_regs *)(x))
+#define __PT_PARM1_REG gprs[2]
+#define __PT_PARM2_REG gprs[3]
+#define __PT_PARM3_REG gprs[4]
+#define __PT_PARM4_REG gprs[5]
+#define __PT_PARM5_REG gprs[6]
+#define __PT_RET_REG grps[14]
+#define __PT_FP_REG gprs[11]	/* Works only with CONFIG_FRAME_POINTER */
+#define __PT_RC_REG gprs[2]
+#define __PT_SP_REG gprs[15]
+#define __PT_IP_REG psw.addr
 
 #elif defined(bpf_target_arm)
 
-#define PT_REGS_PARM1(x) ((x)->uregs[0])
-#define PT_REGS_PARM2(x) ((x)->uregs[1])
-#define PT_REGS_PARM3(x) ((x)->uregs[2])
-#define PT_REGS_PARM4(x) ((x)->uregs[3])
-#define PT_REGS_PARM5(x) ((x)->uregs[4])
-#define PT_REGS_RET(x) ((x)->uregs[14])
-#define PT_REGS_FP(x) ((x)->uregs[11]) /* Works only with CONFIG_FRAME_POINTER */
-#define PT_REGS_RC(x) ((x)->uregs[0])
-#define PT_REGS_SP(x) ((x)->uregs[13])
-#define PT_REGS_IP(x) ((x)->uregs[12])
-
-#define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), uregs[0])
-#define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), uregs[1])
-#define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), uregs[2])
-#define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), uregs[3])
-#define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), uregs[4])
-#define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), uregs[14])
-#define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), uregs[11])
-#define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), uregs[0])
-#define PT_REGS_SP_CORE(x) BPF_CORE_READ((x), uregs[13])
-#define PT_REGS_IP_CORE(x) BPF_CORE_READ((x), uregs[12])
+#define __PT_PARM1_REG uregs[0]
+#define __PT_PARM2_REG uregs[1]
+#define __PT_PARM3_REG uregs[2]
+#define __PT_PARM4_REG uregs[3]
+#define __PT_PARM5_REG uregs[4]
+#define __PT_RET_REG uregs[14]
+#define __PT_FP_REG uregs[11]	/* Works only with CONFIG_FRAME_POINTER */
+#define __PT_RC_REG uregs[0]
+#define __PT_SP_REG uregs[13]
+#define __PT_IP_REG uregs[12]
 
 #elif defined(bpf_target_arm64)
 
 /* arm64 provides struct user_pt_regs instead of struct pt_regs to userspace */
-struct pt_regs;
-#define PT_REGS_ARM64 const volatile struct user_pt_regs
-#define PT_REGS_PARM1(x) (((PT_REGS_ARM64 *)(x))->regs[0])
-#define PT_REGS_PARM2(x) (((PT_REGS_ARM64 *)(x))->regs[1])
-#define PT_REGS_PARM3(x) (((PT_REGS_ARM64 *)(x))->regs[2])
-#define PT_REGS_PARM4(x) (((PT_REGS_ARM64 *)(x))->regs[3])
-#define PT_REGS_PARM5(x) (((PT_REGS_ARM64 *)(x))->regs[4])
-#define PT_REGS_RET(x) (((PT_REGS_ARM64 *)(x))->regs[30])
-/* Works only with CONFIG_FRAME_POINTER */
-#define PT_REGS_FP(x) (((PT_REGS_ARM64 *)(x))->regs[29])
-#define PT_REGS_RC(x) (((PT_REGS_ARM64 *)(x))->regs[0])
-#define PT_REGS_SP(x) (((PT_REGS_ARM64 *)(x))->sp)
-#define PT_REGS_IP(x) (((PT_REGS_ARM64 *)(x))->pc)
-
-#define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((PT_REGS_ARM64 *)(x), regs[0])
-#define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((PT_REGS_ARM64 *)(x), regs[1])
-#define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((PT_REGS_ARM64 *)(x), regs[2])
-#define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((PT_REGS_ARM64 *)(x), regs[3])
-#define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((PT_REGS_ARM64 *)(x), regs[4])
-#define PT_REGS_RET_CORE(x) BPF_CORE_READ((PT_REGS_ARM64 *)(x), regs[30])
-#define PT_REGS_FP_CORE(x) BPF_CORE_READ((PT_REGS_ARM64 *)(x), regs[29])
-#define PT_REGS_RC_CORE(x) BPF_CORE_READ((PT_REGS_ARM64 *)(x), regs[0])
-#define PT_REGS_SP_CORE(x) BPF_CORE_READ((PT_REGS_ARM64 *)(x), sp)
-#define PT_REGS_IP_CORE(x) BPF_CORE_READ((PT_REGS_ARM64 *)(x), pc)
+#define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
+#define __PT_PARM1_REG regs[0]
+#define __PT_PARM2_REG regs[1]
+#define __PT_PARM3_REG regs[2]
+#define __PT_PARM4_REG regs[3]
+#define __PT_PARM5_REG regs[4]
+#define __PT_RET_REG regs[30]
+#define __PT_FP_REG regs[29]	/* Works only with CONFIG_FRAME_POINTER */
+#define __PT_RC_REG regs[0]
+#define __PT_SP_REG sp
+#define __PT_IP_REG pc
 
 #elif defined(bpf_target_mips)
 
-#define PT_REGS_PARM1(x) ((x)->regs[4])
-#define PT_REGS_PARM2(x) ((x)->regs[5])
-#define PT_REGS_PARM3(x) ((x)->regs[6])
-#define PT_REGS_PARM4(x) ((x)->regs[7])
-#define PT_REGS_PARM5(x) ((x)->regs[8])
-#define PT_REGS_RET(x) ((x)->regs[31])
-#define PT_REGS_FP(x) ((x)->regs[30]) /* Works only with CONFIG_FRAME_POINTER */
-#define PT_REGS_RC(x) ((x)->regs[2])
-#define PT_REGS_SP(x) ((x)->regs[29])
-#define PT_REGS_IP(x) ((x)->cp0_epc)
-
-#define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), regs[4])
-#define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), regs[5])
-#define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), regs[6])
-#define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), regs[7])
-#define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), regs[8])
-#define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), regs[31])
-#define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), regs[30])
-#define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), regs[2])
-#define PT_REGS_SP_CORE(x) BPF_CORE_READ((x), regs[29])
-#define PT_REGS_IP_CORE(x) BPF_CORE_READ((x), cp0_epc)
+#define __PT_PARM1_REG regs[4]
+#define __PT_PARM2_REG regs[5]
+#define __PT_PARM3_REG regs[6]
+#define __PT_PARM4_REG regs[7]
+#define __PT_PARM5_REG regs[8]
+#define __PT_RET_REG regs[31]
+#define __PT_FP_REG regs[30]	/* Works only with CONFIG_FRAME_POINTER */
+#define __PT_RC_REG regs[2]
+#define __PT_SP_REG regs[29]
+#define __PT_IP_REG cp0_epc
 
 #elif defined(bpf_target_powerpc)
 
-#define PT_REGS_PARM1(x) ((x)->gpr[3])
-#define PT_REGS_PARM2(x) ((x)->gpr[4])
-#define PT_REGS_PARM3(x) ((x)->gpr[5])
-#define PT_REGS_PARM4(x) ((x)->gpr[6])
-#define PT_REGS_PARM5(x) ((x)->gpr[7])
-#define PT_REGS_RC(x) ((x)->gpr[3])
-#define PT_REGS_SP(x) ((x)->sp)
-#define PT_REGS_IP(x) ((x)->nip)
-
-#define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), gpr[3])
-#define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), gpr[4])
-#define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), gpr[5])
-#define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), gpr[6])
-#define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), gpr[7])
-#define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), gpr[3])
-#define PT_REGS_SP_CORE(x) BPF_CORE_READ((x), sp)
-#define PT_REGS_IP_CORE(x) BPF_CORE_READ((x), nip)
+#define __PT_PARM1_REG gpr[3]
+#define __PT_PARM2_REG gpr[4]
+#define __PT_PARM3_REG gpr[5]
+#define __PT_PARM4_REG gpr[6]
+#define __PT_PARM5_REG gpr[7]
+#define __PT_RET_REG regs[31]
+#define __PT_FP_REG __unsupported__
+#define __PT_RC_REG gpr[3]
+#define __PT_SP_REG sp
+#define __PT_IP_REG nip
 
 #elif defined(bpf_target_sparc)
 
-#define PT_REGS_PARM1(x) ((x)->u_regs[UREG_I0])
-#define PT_REGS_PARM2(x) ((x)->u_regs[UREG_I1])
-#define PT_REGS_PARM3(x) ((x)->u_regs[UREG_I2])
-#define PT_REGS_PARM4(x) ((x)->u_regs[UREG_I3])
-#define PT_REGS_PARM5(x) ((x)->u_regs[UREG_I4])
-#define PT_REGS_RET(x) ((x)->u_regs[UREG_I7])
-#define PT_REGS_RC(x) ((x)->u_regs[UREG_I0])
-#define PT_REGS_SP(x) ((x)->u_regs[UREG_FP])
-
-#define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((x), u_regs[UREG_I0])
-#define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((x), u_regs[UREG_I1])
-#define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((x), u_regs[UREG_I2])
-#define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((x), u_regs[UREG_I3])
-#define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), u_regs[UREG_I4])
-#define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), u_regs[UREG_I7])
-#define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), u_regs[UREG_I0])
-#define PT_REGS_SP_CORE(x) BPF_CORE_READ((x), u_regs[UREG_FP])
-
+#define __PT_PARM1_REG u_regs[UREG_I0]
+#define __PT_PARM2_REG u_regs[UREG_I1]
+#define __PT_PARM3_REG u_regs[UREG_I2]
+#define __PT_PARM4_REG u_regs[UREG_I3]
+#define __PT_PARM5_REG u_regs[UREG_I4]
+#define __PT_RET_REG u_regs[UREG_I7]
+#define __PT_FP_REG __unsupported__
+#define __PT_RC_REG u_regs[UREG_I0]
+#define __PT_SP_REG u_regs[UREG_FP]
 /* Should this also be a bpf_target check for the sparc case? */
 #if defined(__arch64__)
-#define PT_REGS_IP(x) ((x)->tpc)
-#define PT_REGS_IP_CORE(x) BPF_CORE_READ((x), tpc)
+#define __PT_IP_REG tpc
 #else
-#define PT_REGS_IP(x) ((x)->pc)
-#define PT_REGS_IP_CORE(x) BPF_CORE_READ((x), pc)
+#define __PT_IP_REG pc
 #endif
 
 #elif defined(bpf_target_riscv)
 
+#define __PT_REGS_CAST(x) ((const struct user_regs_struct *)(x))
+#define __PT_PARM1_REG a0
+#define __PT_PARM2_REG a1
+#define __PT_PARM3_REG a2
+#define __PT_PARM4_REG a3
+#define __PT_PARM5_REG a4
+#define __PT_RET_REG ra
+#define __PT_FP_REG fp
+#define __PT_RC_REG a5
+#define __PT_SP_REG sp
+#define __PT_IP_REG epc
+
+#endif
+
+#if defined(bpf_target_defined)
+
 struct pt_regs;
-#define PT_REGS_RV const volatile struct user_regs_struct
-#define PT_REGS_PARM1(x) (((PT_REGS_RV *)(x))->a0)
-#define PT_REGS_PARM2(x) (((PT_REGS_RV *)(x))->a1)
-#define PT_REGS_PARM3(x) (((PT_REGS_RV *)(x))->a2)
-#define PT_REGS_PARM4(x) (((PT_REGS_RV *)(x))->a3)
-#define PT_REGS_PARM5(x) (((PT_REGS_RV *)(x))->a4)
-#define PT_REGS_RET(x) (((PT_REGS_RV *)(x))->ra)
-#define PT_REGS_FP(x) (((PT_REGS_RV *)(x))->s5)
-#define PT_REGS_RC(x) (((PT_REGS_RV *)(x))->a5)
-#define PT_REGS_SP(x) (((PT_REGS_RV *)(x))->sp)
-#define PT_REGS_IP(x) (((PT_REGS_RV *)(x))->epc)
-
-#define PT_REGS_PARM1_CORE(x) BPF_CORE_READ((PT_REGS_RV *)(x), a0)
-#define PT_REGS_PARM2_CORE(x) BPF_CORE_READ((PT_REGS_RV *)(x), a1)
-#define PT_REGS_PARM3_CORE(x) BPF_CORE_READ((PT_REGS_RV *)(x), a2)
-#define PT_REGS_PARM4_CORE(x) BPF_CORE_READ((PT_REGS_RV *)(x), a3)
-#define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((PT_REGS_RV *)(x), a4)
-#define PT_REGS_RET_CORE(x) BPF_CORE_READ((PT_REGS_RV *)(x), ra)
-#define PT_REGS_FP_CORE(x) BPF_CORE_READ((PT_REGS_RV *)(x), fp)
-#define PT_REGS_RC_CORE(x) BPF_CORE_READ((PT_REGS_RV *)(x), a5)
-#define PT_REGS_SP_CORE(x) BPF_CORE_READ((PT_REGS_RV *)(x), sp)
-#define PT_REGS_IP_CORE(x) BPF_CORE_READ((PT_REGS_RV *)(x), epc)
 
+/* allow some architecutres to override `struct pt_regs` */
+#ifndef __PT_REGS_CAST
+#define __PT_REGS_CAST(x) (x)
 #endif
 
+#define PT_REGS_PARM1(x) (__PT_REGS_CAST(x)->__PT_PARM1_REG)
+#define PT_REGS_PARM2(x) (__PT_REGS_CAST(x)->__PT_PARM2_REG)
+#define PT_REGS_PARM3(x) (__PT_REGS_CAST(x)->__PT_PARM3_REG)
+#define PT_REGS_PARM4(x) (__PT_REGS_CAST(x)->__PT_PARM4_REG)
+#define PT_REGS_PARM5(x) (__PT_REGS_CAST(x)->__PT_PARM5_REG)
+#define PT_REGS_RET(x) (__PT_REGS_CAST(x)->__PT_RET_REG)
+#define PT_REGS_FP(x) (__PT_REGS_CAST(x)->__PT_FP_REG)
+#define PT_REGS_RC(x) (__PT_REGS_CAST(x)->__PT_RC_REG)
+#define PT_REGS_SP(x) (__PT_REGS_CAST(x)->__PT_SP_REG)
+#define PT_REGS_IP(x) (__PT_REGS_CAST(x)->__PT_IP_REG)
+
+#define PT_REGS_PARM1_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM1_REG)
+#define PT_REGS_PARM2_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM2_REG)
+#define PT_REGS_PARM3_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM3_REG)
+#define PT_REGS_PARM4_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM4_REG)
+#define PT_REGS_PARM5_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_PARM5_REG)
+#define PT_REGS_RET_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_RET_REG)
+#define PT_REGS_FP_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_FP_REG)
+#define PT_REGS_RC_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_RC_REG)
+#define PT_REGS_SP_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_SP_REG)
+#define PT_REGS_IP_CORE(x) BPF_CORE_READ(__PT_REGS_CAST(x), __PT_IP_REG)
+
 #if defined(bpf_target_powerpc)
+
 #define BPF_KPROBE_READ_RET_IP(ip, ctx)		({ (ip) = (ctx)->link; })
 #define BPF_KRETPROBE_READ_RET_IP		BPF_KPROBE_READ_RET_IP
+
 #elif defined(bpf_target_sparc)
+
 #define BPF_KPROBE_READ_RET_IP(ip, ctx)		({ (ip) = PT_REGS_RET(ctx); })
 #define BPF_KRETPROBE_READ_RET_IP		BPF_KPROBE_READ_RET_IP
-#elif defined(bpf_target_defined)
+
+#else
+
 #define BPF_KPROBE_READ_RET_IP(ip, ctx)					    \
 	({ bpf_probe_read_kernel(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx)); })
 #define BPF_KRETPROBE_READ_RET_IP(ip, ctx)				    \
-	({ bpf_probe_read_kernel(&(ip), sizeof(ip),			    \
-			  (void *)(PT_REGS_FP(ctx) + sizeof(ip))); })
+	({ bpf_probe_read_kernel(&(ip), sizeof(ip), (void *)(PT_REGS_FP(ctx) + sizeof(ip))); })
+
 #endif
 
-#if !defined(bpf_target_defined)
+#else /* defined(bpf_target_defined) */
 
 #define PT_REGS_PARM1(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define PT_REGS_PARM2(x) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
@@ -363,7 +290,7 @@ struct pt_regs;
 #define BPF_KPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 #define BPF_KRETPROBE_READ_RET_IP(ip, ctx) ({ _Pragma(__BPF_TARGET_MISSING); 0l; })
 
-#endif /* !defined(bpf_target_defined) */
+#endif /* defined(bpf_target_defined) */
 
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
-- 
2.30.2

