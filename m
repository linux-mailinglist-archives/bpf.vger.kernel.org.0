Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02723247A2
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 00:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhBXXqw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 18:46:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233606AbhBXXqu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Feb 2021 18:46:50 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ONYL6j014918;
        Wed, 24 Feb 2021 18:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pWgbQeingpKrlMuDfpZMUVSSVFCqKzHf26z1oCJnHsE=;
 b=KOQ0pktQKCtBqhzojXo1gwZhoAWLUj1bLOZlyeQsJVDIYq3F1VcDfM0Z5oikcUaLqcRA
 3l4r/+4Ecfm9cbyv5Dpo1UjA3nfeDNaONM5Ir5foWIKrA7Vaw/12F7Iio/yVZqjeCleX
 fBNqtdamjMwkIE+E2JSWZFGLQ9zOaTZqekTWiB4hOUVLJBXCFsc7Ve1wbmTiyi4hP1OM
 jCzH24PDHJ7sy8H4+roWwTkxbAb6cErUamAHQvaOlDrPmxjgUV8Ic/hiJZcwjnU+7eSl
 iLQWMpa5ISMjPU/YOcxWk5TvfmSEV9NhvQkSZa1tC6tUJwu2J6ytBx32zy77srP+atfe QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wx8xkpkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:45:53 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11ONZN2V019499;
        Wed, 24 Feb 2021 18:45:53 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36wx8xkpju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 18:45:53 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ONhPpG027859;
        Wed, 24 Feb 2021 23:45:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 36tt28a2rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 23:45:50 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11ONjlhW38273330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 23:45:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F09642041;
        Wed, 24 Feb 2021 23:45:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5CB74203F;
        Wed, 24 Feb 2021 23:45:46 +0000 (GMT)
Received: from vm.lan (unknown [9.145.151.190])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 23:45:46 +0000 (GMT)
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
Subject: [PATCH v6 bpf-next 2/9] libbpf: Fix whitespace in btf_add_composite() comment
Date:   Thu, 25 Feb 2021 00:45:28 +0100
Message-Id: <20210224234535.106970-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224234535.106970-1-iii@linux.ibm.com>
References: <20210224234535.106970-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_13:2021-02-24,2021-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240184
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

