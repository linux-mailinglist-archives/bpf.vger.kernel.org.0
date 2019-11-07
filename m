Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C82F2BC4
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 11:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbfKGKEm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 05:04:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726866AbfKGKEm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Nov 2019 05:04:42 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA79uuBC084070
        for <bpf@vger.kernel.org>; Thu, 7 Nov 2019 05:04:40 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w4eg5xak9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 05:04:27 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 7 Nov 2019 10:04:06 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Nov 2019 10:04:04 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7A42Ob53280996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Nov 2019 10:04:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B15B0A4051;
        Thu,  7 Nov 2019 10:04:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D80BA4055;
        Thu,  7 Nov 2019 10:04:02 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.99.204])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Nov 2019 10:04:02 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] tools, bpf_asm: warn when jumps are out of range
Date:   Thu,  7 Nov 2019 11:03:49 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110710-0012-0000-0000-0000036182D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110710-0013-0000-0000-0000219CE317
Message-Id: <20191107100349.88976-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070101
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When compiling larger programs with bpf_asm, it's possible to
accidentally exceed jt/jf range, in which case it won't complain, but
rather silently emit a truncated offset, leading to a "happy debugging"
situation.

Add a warning to help detecting such issues. It could be made an error
instead, but this might break compilation of existing code (which might
be working by accident).

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/bpf/bpf_exp.y | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpf_exp.y b/tools/bpf/bpf_exp.y
index 56ba1de50784..8d48e896be50 100644
--- a/tools/bpf/bpf_exp.y
+++ b/tools/bpf/bpf_exp.y
@@ -545,6 +545,16 @@ static void bpf_reduce_k_jumps(void)
 	}
 }
 
+static uint8_t bpf_encode_jt_jf_offset(int off, int i)
+{
+	int delta = off - i - 1;
+
+	if (delta < 0 || delta > 255)
+		fprintf(stderr, "warning: insn #%d jumps to insn #%d, "
+				"which is out of range\n", i, off);
+	return (uint8_t) delta;
+}
+
 static void bpf_reduce_jt_jumps(void)
 {
 	int i;
@@ -552,7 +562,7 @@ static void bpf_reduce_jt_jumps(void)
 	for (i = 0; i < curr_instr; i++) {
 		if (labels_jt[i]) {
 			int off = bpf_find_insns_offset(labels_jt[i]);
-			out[i].jt = (uint8_t) (off - i -1);
+			out[i].jt = bpf_encode_jt_jf_offset(off, i);
 		}
 	}
 }
@@ -564,7 +574,7 @@ static void bpf_reduce_jf_jumps(void)
 	for (i = 0; i < curr_instr; i++) {
 		if (labels_jf[i]) {
 			int off = bpf_find_insns_offset(labels_jf[i]);
-			out[i].jf = (uint8_t) (off - i - 1);
+			out[i].jf = bpf_encode_jt_jf_offset(off, i);
 		}
 	}
 }
-- 
2.23.0

