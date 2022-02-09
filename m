Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F42A4AE688
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 03:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbiBICjW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 21:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244859AbiBICSP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 21:18:15 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D538C06157B
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 18:18:15 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2190WSCO007258;
        Wed, 9 Feb 2022 02:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kQ6Z0QxvS1qQbNa23IiwLGU+rujxVU0u7T2rdztkayg=;
 b=iZBPw7NpJUQpTwg8qbUyHXtbpzeCgaDHMQwaGiNgKhIQTS/rf3D2xLiDh4Mh9EptO1zx
 aRWX3u9eQ5imacIbGUS9HePd+rFTf7GbFOB3JHh/HWJrQ0zgbSCrpSk4IzqNczqh2XdF
 65BHj58kY5QKN22F+8XbAT9/SYs21G3TmUUV6sVdBGNhyGJ3vYAyIpPkD1juyvO+EXQ7
 PIN9seHn8rOhfAYViwvlY0HVJTavgHw/jD9ox4EkhvQpBweHX5Xo9OQeBsYrAYaA2jMd
 B/LPNVXYGCGqV85qU1HgIpo9BaZeRu1N3Yzos8JRXmlq1R1eYy5IPGtnzyyNbziiUOFk Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3yq2e0q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:18:03 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21929JNv005277;
        Wed, 9 Feb 2022 02:18:02 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3yq2e0pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:18:02 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2192CuPh002263;
        Wed, 9 Feb 2022 02:18:00 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3e1gv9h610-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 02:18:00 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2192Hv3u42336678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Feb 2022 02:17:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 571FAA405C;
        Wed,  9 Feb 2022 02:17:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD858A405B;
        Wed,  9 Feb 2022 02:17:56 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.78.41])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Feb 2022 02:17:56 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bpf@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v5 09/10] libbpf: Fix accessing the first syscall argument on arm64
Date:   Wed,  9 Feb 2022 03:17:44 +0100
Message-Id: <20220209021745.2215452-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209021745.2215452-1-iii@linux.ibm.com>
References: <20220209021745.2215452-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HGLFKAnx0VyNdojdJ-Q3lCCmix49m26o
X-Proofpoint-GUID: P23O6g_05JR0cQridHpd2M_9b3_IPX61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_08,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On arm64, the first syscall argument should be accessed via orig_x0
(see arch/arm64/include/asm/syscall.h). Currently regs[0] is used
instead, leading to bpf_syscall_macro test failure.

orig_x0 cannot be added to struct user_pt_regs, since its layout is a
part of the ABI. Therefore provide access to it only through
PT_REGS_PARM1_CORE_SYSCALL() by using a struct pt_regs flavor.

Reported-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index f364f1f4710e..928f85f7961c 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -142,8 +142,18 @@
 
 #elif defined(bpf_target_arm64)
 
+struct pt_regs___arm64 {
+	unsigned long orig_x0;
+} __attribute__((preserve_access_index));
+
 /* arm64 provides struct user_pt_regs instead of struct pt_regs to userspace */
 #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
+#define PT_REGS_PARM1_SYSCALL(x) ({ \
+	_Pragma("GCC error \"PT_REGS_PARM1_SYSCALL() is not supported on arm64, use PT_REGS_PARM1_CORE_SYSCALL() instead\""); \
+	0l; \
+})
+#define PT_REGS_PARM1_CORE_SYSCALL(x) \
+	BPF_CORE_READ((const struct pt_regs___arm64 *)(x), orig_x0)
 #define __PT_PARM1_REG regs[0]
 #define __PT_PARM2_REG regs[1]
 #define __PT_PARM3_REG regs[2]
-- 
2.34.1

