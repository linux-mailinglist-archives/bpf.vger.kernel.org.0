Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D060F3268AA
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 21:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBZUY7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 15:24:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230270AbhBZUYE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 15:24:04 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QK4B69061111;
        Fri, 26 Feb 2021 15:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pWgbQeingpKrlMuDfpZMUVSSVFCqKzHf26z1oCJnHsE=;
 b=dsQRRnzj1c7v5iUIbGPqhMdDKzS0i1BAb0rH8L6Oa75FG5h0ZgZKc3vTHiOspiSELUb4
 cbirtR62m94TGcnQUekSpfe4Kaim4zqhqKn9edylccLdzlL6fx3KW6hpUo6W7gkRqGCO
 jPJnmalarbIdNVYRokhJROBicHoDIG6FoFA/vuuFxeaq+1tlK86sK3tOEt/HEKpmwe5x
 RSS/GSLkEFXjT0ez7ikqntWTFn/epB5weeGIPceyZV6yxi2do1vrdUNmtwJjpNkyDnmd
 /lvV61oDd7hjU6IgGWsG8LWiaj4+rOrn6AZrS+Bv4QwcfvNgXi4yIqwelVz39LEGOtJ5 nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36y209m5kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 15:23:07 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11QK5da8064687;
        Fri, 26 Feb 2021 15:23:07 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36y209m5k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 15:23:06 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QKMS5X026280;
        Fri, 26 Feb 2021 20:23:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt285mns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 20:23:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QKN2Eg918122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 20:23:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16C8611C04A;
        Fri, 26 Feb 2021 20:23:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F02511C052;
        Fri, 26 Feb 2021 20:23:01 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 20:23:01 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v7 bpf-next 02/10] libbpf: Fix whitespace in btf_add_composite() comment
Date:   Fri, 26 Feb 2021 21:22:48 +0100
Message-Id: <20210226202256.116518-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210226202256.116518-1-iii@linux.ibm.com>
References: <20210226202256.116518-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_09:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260143
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove trailing space.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 6058fbadbee4..313f62a78626 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1910,7 +1910,7 @@ static int btf_add_composite(struct btf *btf, int kind, const char *name, __u32
  *   - *byte_sz* - size of the struct, in bytes;
  *
  * Struct initially has no fields in it. Fields can be added by
- * btf__add_field() right after btf__add_struct() succeeds. 
+ * btf__add_field() right after btf__add_struct() succeeds.
  *
  * Returns:
  *   - >0, type ID of newly added BTF type;
-- 
2.29.2

