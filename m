Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8641ED570
	for <lists+bpf@lfdr.de>; Wed,  3 Jun 2020 19:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgFCRzh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jun 2020 13:55:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46194 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgFCRzh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jun 2020 13:55:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053HpaX6169343;
        Wed, 3 Jun 2020 17:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=e3o2KK1m1OUhdKXLk8BYlIuJm7LXmY0Qn2D/qITDM5E=;
 b=GiImnz3CmN5ZP2W3igK7dVc0I16LpzBR9xrO0Jnr/5XqR2x2Z9qNaH07bJ4bSzRxH7wG
 FhqTMkMqgfh1kcnlpE838nawzQvq8qXIUs1I+tlYBmQaSHgb82VDIvmbi8sj96ORC0XA
 /cfj6ZqTsp+cvBHnn8qvqJTF5Ggnid2erR+TrsTgxEtRCa/1+17GXRr+b4UzGVhB85nE
 H58mqJ87YTn+n+XUWGYKbg8rmWz8BM/j0wJ+taWcw7l2++DqpGau986q9k/SqCmH61VS
 N3xPWShzc6m1S3VJvMRJjMywLR92aI3+J25rWUR9vMdl+KYmPu+giMA/S43v39IFcY9b sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31bewr2r0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 03 Jun 2020 17:55:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053HrKit083778;
        Wed, 3 Jun 2020 17:55:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31c1e0dbm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jun 2020 17:55:18 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 053HtHI4019731;
        Wed, 3 Jun 2020 17:55:17 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 10:55:17 -0700
Date:   Wed, 3 Jun 2020 20:55:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Fix an error code in check_btf_func()
Message-ID: <20200603175509.GE18931@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=996
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=2 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=2 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030138
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This code returns success if kcalloc() but it should return -ENOMEM.

Fixes: 8c1b6e69dcc1 ("bpf: Compare BTF types of functions arguments with actual types")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c7bbaac81ef9..25363f134bf0c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7581,8 +7581,10 @@ static int check_btf_func(struct bpf_verifier_env *env,
 	if (!krecord)
 		return -ENOMEM;
 	info_aux = kcalloc(nfuncs, sizeof(*info_aux), GFP_KERNEL | __GFP_NOWARN);
-	if (!info_aux)
+	if (!info_aux) {
+		ret = -ENOMEM;
 		goto err_free;
+	}
 
 	for (i = 0; i < nfuncs; i++) {
 		ret = bpf_check_uarg_tail_zero(urecord, krec_size, urec_size);
-- 
2.26.2

