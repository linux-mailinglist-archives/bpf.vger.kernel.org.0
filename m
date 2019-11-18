Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 783D1100B17
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2019 19:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfKRSEa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 13:04:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726317AbfKRSEa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 18 Nov 2019 13:04:30 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAII2boX080671
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:04:28 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2way6a28f6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 13:04:28 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 18 Nov 2019 18:04:26 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Nov 2019 18:04:23 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAII4Ljg40304868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 18:04:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA398AE056;
        Mon, 18 Nov 2019 18:04:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 761CDAE051;
        Mon, 18 Nov 2019 18:04:21 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.97.207])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 18:04:21 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next 6/6] s390/bpf: remove JITed image size limitations
Date:   Mon, 18 Nov 2019 19:03:40 +0100
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118180340.68373-1-iii@linux.ibm.com>
References: <20191118180340.68373-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111818-4275-0000-0000-0000038125FE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111818-4276-0000-0000-000038949710
Message-Id: <20191118180340.68373-7-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_05:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=2 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911180154
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that jump and long displacement ranges are no longer a problem,
remove the limit on JITed image size. In practice it's still limited by
2G, but with verifier allowing "only" 1M instructions, it's not an
issue.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 3398cd939496..8d2134136290 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -52,8 +52,6 @@ struct bpf_jit {
 	int labels[1];		/* Labels for local jumps */
 };
 
-#define BPF_SIZE_MAX	0xffff	/* Max size for program (16 bit branches) */
-
 #define SEEN_MEM	BIT(0)		/* use mem[] for temporary storage */
 #define SEEN_LITERAL	BIT(1)		/* code uses literals */
 #define SEEN_FUNC	BIT(2)		/* calls C functions */
@@ -1631,11 +1629,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	/*
 	 * Final pass: Allocate and generate program
 	 */
-	if (jit.size >= BPF_SIZE_MAX) {
-		fp = orig_fp;
-		goto free_addrs;
-	}
-
 	header = bpf_jit_binary_alloc(jit.size, &jit.prg_buf, 8, jit_fill_hole);
 	if (!header) {
 		fp = orig_fp;
-- 
2.23.0

