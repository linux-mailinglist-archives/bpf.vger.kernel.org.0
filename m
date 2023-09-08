Return-Path: <bpf+bounces-9489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F227987D1
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3582809E3
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B592A63AF;
	Fri,  8 Sep 2023 13:28:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EE63AB
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 13:28:19 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58741FC1
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 06:28:14 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388DKfva023951;
	Fri, 8 Sep 2023 13:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=e1pzRfIsQNWviwQZR119p94RiwEd51lnuBA/9kOUYQ8=;
 b=bIx8G1ajBo9Syc9MCJY0kaXaQGknXEkxzZrrrn79+JPkeMquYjTj6gWvslKMjGDiEks3
 3usPYeVjA0MwCAE3JeKmF3Cj2LpKOabO/XiK+2hahosVPQcsx6jmJB/uEilgsBNHjTqi
 J6diEGRXhXxaLEXKfDWIIHhzKunPn7RUgLYN+3c3v9/rIS2Z93afuPPaceJsNu8/u0hV
 2w/ImtHPnEy5qFcK5in76M4vomjUndIclkVv0Iqy5xIkaM3V3PpX/L4exi6yRT5NJSp9
 U4Iuq/hARzX63tjFnULmd8Zzd7Y3ItyQBpWUnnUDfklYDZ0CHMATSrWRM7DvvAnLO1ZQ gA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t04dsg6f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Sep 2023 13:27:52 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 388DNKIl026759;
	Fri, 8 Sep 2023 13:27:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcp3vwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Sep 2023 13:27:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 388DRnSN5178062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Sep 2023 13:27:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 803822004B;
	Fri,  8 Sep 2023 13:27:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F4AF20040;
	Fri,  8 Sep 2023 13:27:47 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.29.230])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Sep 2023 13:27:47 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 2/5] powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
Date: Fri,  8 Sep 2023 18:57:37 +0530
Message-ID: <20230908132740.718103-3-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908132740.718103-1-hbathini@linux.ibm.com>
References: <20230908132740.718103-1-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lIud_GT87QPnqlLvPEp84QaNENWEjzhI
X-Proofpoint-GUID: lIud_GT87QPnqlLvPEp84QaNENWEjzhI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_09,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=893 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement bpf_arch_text_invalidate and use it to fill unused part of
the bpf_prog_pack with trap instructions when a BPF program is freed.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 4f896222c579..c0036eb171f0 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -313,3 +313,18 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 
 	return ret;
 }
+
+int bpf_arch_text_invalidate(void *dst, size_t len)
+{
+	u32 insn = BREAKPOINT_INSTRUCTION;
+	void *ret;
+
+	if (WARN_ON_ONCE(core_kernel_text((unsigned long)dst)))
+		return -EINVAL;
+
+	mutex_lock(&text_mutex);
+	ret = bpf_patch_instructions(dst, &insn, len, true);
+	mutex_unlock(&text_mutex);
+
+	return IS_ERR(ret) ? PTR_ERR(ret) : 0;
+}
-- 
2.41.0


