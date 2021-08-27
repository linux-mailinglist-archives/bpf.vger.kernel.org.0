Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3A53F9862
	for <lists+bpf@lfdr.de>; Fri, 27 Aug 2021 13:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhH0LUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Aug 2021 07:20:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20402 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233082AbhH0LUS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Aug 2021 07:20:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17RBE6gv125544;
        Fri, 27 Aug 2021 07:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=o0a0/cpNKmT5KeoHBklw2qRTT+iHRvaHA7SHnXnwf88=;
 b=cjXvVcDIEuGdmSKlMcHS2/LGEDYZOFBGtHmBStXqA513vXuqJNbfb/Ep3BieY/Oy70QM
 Z7t7QiQwup6tJ7MXj2iKGkYtJ0tOJ89M/zyLS+81bMMhAeA0gklVdW2lY8kdSVa1xT0m
 nN06iLInaH0iEpa7at1o6IplgHKIEfFSJRqwZwWbYJwLOH/WV4xjfcFmUdPwvJehzG5s
 eOemOMenaFRduyNsIxLwoy/8w4kMeOiMJxKHXiwnTIy01Tn2gV7SM2bP/K5ajLYWZeqv
 Iv21bGg21zviWuZTE1Ys7OoaRZuYkBCk4lhtd4ZFram0a80P+wFXS/cEEC786obKJYEV 3A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3apy0d83a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 07:19:13 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17RBE8jn013287;
        Fri, 27 Aug 2021 11:19:11 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3ajs48hh07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 11:19:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17RBJ8k944040670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 11:19:09 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D37E911C090;
        Fri, 27 Aug 2021 11:19:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADDD111C06E;
        Fri, 27 Aug 2021 11:19:06 +0000 (GMT)
Received: from tpad450.ibmuc.com (unknown [9.43.13.169])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Aug 2021 11:19:06 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        naveen.n.rao@linux.ibm.com, mpe@ellerman.id.au
Subject: [PATCH] MAINTAINERS: Remove self from powerpc BPF JIT
Date:   Fri, 27 Aug 2021 16:49:05 +0530
Message-Id: <20210827111905.396145-1-sandipan@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -jjgGWw_DClqHVh561FenHhIWtERTDw7
X-Proofpoint-ORIG-GUID: -jjgGWw_DClqHVh561FenHhIWtERTDw7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-27_03:2021-08-26,2021-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=852 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108270070
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stepping down as I haven't had a chance to look into the
powerpc BPF JIT compilers for a while.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7b4f32875a9..d6609aa91bd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3409,7 +3409,6 @@ F:	drivers/net/ethernet/netronome/nfp/bpf/
 
 BPF JIT for POWERPC (32-BIT AND 64-BIT)
 M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
-M:	Sandipan Das <sandipan@linux.ibm.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
-- 
2.31.1

