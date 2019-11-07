Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E134F353F
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 18:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfKGRAs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 12:00:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61404 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729871AbfKGRAs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Nov 2019 12:00:48 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA7H0PTG017608
        for <bpf@vger.kernel.org>; Thu, 7 Nov 2019 09:00:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=avIRl9XeV7c4k+uNNc06+tyWDEIPw7yFMXmVDuTIaj8=;
 b=VrWT6n80G3+PNtBSjBMKOwBHkbwCpY+OkuVizqw8pkdzAg8VZsm/tWlMbOAXqSsyaRMD
 sFyRpnH1EM9+sryWJ4JdjaD7Kp+YrrnInIPlT+zAeoMrIcXeCQ+nVzKl5L/H5amuU+HG
 6BhZyUyxJdpERmQkp+JXyXf8PgiD6iiEKOk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2w41ue659u-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 09:00:46 -0800
Received: from 2401:db00:2120:80e1:face:0:29:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 Nov 2019 09:00:46 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 2F0C737013B7; Thu,  7 Nov 2019 09:00:45 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next v2] [tools/bpf] workaround a verifier failure for test_progs
Date:   Thu, 7 Nov 2019 09:00:45 -0800
Message-ID: <20191107170045.2503480-1-yhs@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_05:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=670 suspectscore=13 adultscore=0
 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911070160
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With latest llvm compiler, running test_progs will have
the following verifier failure for test_sysctl_loop1.o:
  libbpf: load bpf program failed: Permission denied
  libbpf: -- BEGIN DUMP LOG ---
  libbpf:
  invalid indirect read from stack var_off (0x0; 0xff)+196 size 7
  ...
  libbpf: -- END LOG --
  libbpf: failed to load program 'cgroup/sysctl'
  libbpf: failed to load object 'test_sysctl_loop1.o'

The related bytecodes look below:
  0000000000000308 LBB0_8:
      97:       r4 = r10
      98:       r4 += -288
      99:       r4 += r7
     100:       w8 &= 255
     101:       r1 = r10
     102:       r1 += -488
     103:       r1 += r8
     104:       r2 = 7
     105:       r3 = 0
     106:       call 106
     107:       w1 = w0
     108:       w1 += -1
     109:       if w1 > 6 goto -24 <LBB0_5>
     110:       w0 += w8
     111:       r7 += 8
     112:       w8 = w0
     113:       if r7 != 224 goto -17 <LBB0_8>
and source code:
     for (i = 0; i < ARRAY_SIZE(tcp_mem); ++i) {
             ret = bpf_strtoul(value + off, MAX_ULONG_STR_LEN, 0,
                               tcp_mem + i);
             if (ret <= 0 || ret > MAX_ULONG_STR_LEN)
                     return 0;
             off += ret & MAX_ULONG_STR_LEN;
     }
Current verifier is not able to conclude register w0 before '+'
at insn 110 has a range of 1 to 7 and thinks it is from 0 - 255.
This leads to more conservative range for w8 at insn 112,
and later verifier complaint.

Let us workaound this issue until we found a compiler and/or
verifier solution. The workaround in this patch is
to make variable 'ret' volatile, which will force a reload
and then '&' operation to ensure better value range.
With this patch, I got the below byte code for the loop,
  0000000000000328 LBB0_9:
     101:       r4 = r10
     102:       r4 += -288
     103:       r4 += r7
     104:       w8 &= 255
     105:       r1 = r10
     106:       r1 += -488
     107:       r1 += r8
     108:       r2 = 7
     109:       r3 = 0
     110:       call 106
     111:       *(u32 *)(r10 - 64) = r0
     112:       r1 = *(u32 *)(r10 - 64)
     113:       if w1 s< 1 goto -28 <LBB0_5>
     114:       r1 = *(u32 *)(r10 - 64)
     115:       if w1 s> 7 goto -30 <LBB0_5>
     116:       r1 = *(u32 *)(r10 - 64)
     117:       w1 &= 7
     118:       w1 += w8
     119:       r7 += 8
     120:       w8 = w1
     121:       if r7 != 224 goto -21 <LBB0_9>
Insn 117 did the '&' operation and we got more precise
value range for 'w8' at insn 120.
The test is happy then.
  #3/17 test_sysctl_loop1.o:OK

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/test_sysctl_loop1.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Changelog:
  v1 -> v2:
    - Added byte codes after the code change in the commit message

diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
index 608a06871572..d22e438198cf 100644
--- a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
+++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
@@ -44,7 +44,10 @@ int sysctl_tcp_mem(struct bpf_sysctl *ctx)
 	unsigned long tcp_mem[TCP_MEM_LOOPS] = {};
 	char value[MAX_VALUE_STR_LEN];
 	unsigned char i, off = 0;
-	int ret;
+	/* a workaround to prevent compiler from generating
+	 * codes verifier cannot handle yet.
+	 */
+	volatile int ret;
 
 	if (ctx->write)
 		return 0;
-- 
2.17.1

