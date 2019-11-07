Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD1EF3139
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 15:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbfKGOU3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 09:20:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbfKGOU3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 Nov 2019 09:20:29 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7EKLF5103225
        for <bpf@vger.kernel.org>; Thu, 7 Nov 2019 09:20:28 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w4jw4pr2t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 09:20:25 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 7 Nov 2019 14:18:46 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Nov 2019 14:18:43 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7EIf2224182974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Nov 2019 14:18:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92B9DA4040;
        Thu,  7 Nov 2019 14:18:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F847A4051;
        Thu,  7 Nov 2019 14:18:41 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.99.204])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Nov 2019 14:18:41 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next] s390/bpf: use kvcalloc for addrs array
Date:   Thu,  7 Nov 2019 15:18:38 +0100
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110714-0008-0000-0000-0000032C6E55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110714-0009-0000-0000-00004A4B73B7
Message-Id: <20191107141838.92202-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070142
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A BPF program may consist of 1m instructions, which means JIT
instruction-address mapping can be as large as 4m. s390 has
FORCE_MAX_ZONEORDER=9 (for memory hotplug reasons), which means maximum
kmalloc size is 1m. This makes it impossible to JIT programs with more
than 256k instructions.

Fix by using kvcalloc, which falls back to vmalloc for larger
allocations. An alternative would be to use a radix tree, but that is
not supported by bpf_prog_fill_jited_linfo.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/net/bpf_jit_comp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index ce88211b9c6c..c8c16b5eed6b 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -23,6 +23,7 @@
 #include <linux/filter.h>
 #include <linux/init.h>
 #include <linux/bpf.h>
+#include <linux/mm.h>
 #include <asm/cacheflush.h>
 #include <asm/dis.h>
 #include <asm/facility.h>
@@ -1369,7 +1370,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	}
 
 	memset(&jit, 0, sizeof(jit));
-	jit.addrs = kcalloc(fp->len + 1, sizeof(*jit.addrs), GFP_KERNEL);
+	jit.addrs = kvcalloc(fp->len + 1, sizeof(*jit.addrs), GFP_KERNEL);
 	if (jit.addrs == NULL) {
 		fp = orig_fp;
 		goto out;
@@ -1422,7 +1423,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	if (!fp->is_func || extra_pass) {
 		bpf_prog_fill_jited_linfo(fp, jit.addrs + 1);
 free_addrs:
-		kfree(jit.addrs);
+		kvfree(jit.addrs);
 		kfree(jit_data);
 		fp->aux->jit_data = NULL;
 	}
-- 
2.23.0

