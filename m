Return-Path: <bpf+bounces-12828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 384B97D114C
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 16:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94EE1F242CD
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 14:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAF01D538;
	Fri, 20 Oct 2023 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JdLYyT9T"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA21E1D531
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 14:14:34 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D955D46
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 07:14:33 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39KEA46v010078;
	Fri, 20 Oct 2023 14:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aEXE2FvgIvyDlm4pygNpRc8xZbsqC2qpviemhbPCaXY=;
 b=JdLYyT9TkdMgj0yL5iGl9F4khhZ6Y141E5L9m0ZF7Byr3YCoyNUs8IUS51Rwq3myFj8l
 QDEBGSpGISV0jejcq5BQvv3FD9/Pi7+8+Gj5OuvA4DOsef2aek28rUPCiHpGU3lEKcKT
 lkBSGWXV5vv0PeGHqkKLy5d8CbBXLEdTQSkW9CQWkOPHOl0zaWHN/nugMA/OwF/z0nyO
 mrgiLr1ruGrx2r0AmwWeedE6y7ljvTi9e9hnxsj9lsOxXI71SZbZMIVmRlpeelMSsG7Y
 cOsNsVNa2DIGu3sSe/vs7cD29oOSuUr1ju3rMh9uYswCeDVtE5NygKbfQjdHFxYpxdUa fw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tuu2w84jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 14:14:11 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39KCKg90029802;
	Fri, 20 Oct 2023 14:14:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc47n0h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 14:14:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39KEE8Wo19858034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Oct 2023 14:14:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F191720040;
	Fri, 20 Oct 2023 14:14:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C50C20043;
	Fri, 20 Oct 2023 14:14:05 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.18.181])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Oct 2023 14:14:05 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>
Subject: [PATCH v7 2/5] powerpc/bpf: implement bpf_arch_text_copy
Date: Fri, 20 Oct 2023 19:43:55 +0530
Message-ID: <20231020141358.643575-3-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020141358.643575-1-hbathini@linux.ibm.com>
References: <20231020141358.643575-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hAehcHJt65OCOX7QW8VX8oZRZs83Nwi_
X-Proofpoint-ORIG-GUID: hAehcHJt65OCOX7QW8VX8oZRZs83Nwi_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200116

bpf_arch_text_copy is used to dump JITed binary to RX page, allowing
multiple BPF programs to share the same page. Use the newly introduced
patch_instructions() to implement it.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Song Liu <song@kernel.org>
---

* No changes in v7.


 arch/powerpc/net/bpf_jit_comp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 37043dfc1add..c740eac8d584 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -13,9 +13,13 @@
 #include <linux/netdevice.h>
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
-#include <asm/kprobes.h>
+#include <linux/kernel.h>
+#include <linux/memory.h>
 #include <linux/bpf.h>
 
+#include <asm/kprobes.h>
+#include <asm/code-patching.h>
+
 #include "bpf_jit.h"
 
 static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
@@ -274,3 +278,17 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, int pass, struct code
 	ctx->exentry_idx++;
 	return 0;
 }
+
+void *bpf_arch_text_copy(void *dst, void *src, size_t len)
+{
+	int err;
+
+	if (WARN_ON_ONCE(core_kernel_text((unsigned long)dst)))
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&text_mutex);
+	err = patch_instructions(dst, src, len, false);
+	mutex_unlock(&text_mutex);
+
+	return err ? ERR_PTR(err) : dst;
+}
-- 
2.41.0


