Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E231D5DE
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 08:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhBQHqi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 02:46:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51454 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhBQHqi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 02:46:38 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11H7i1t8188011;
        Wed, 17 Feb 2021 07:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=/pArH5tMaRMpY8eyf0TKcZn37e4pAHh3sJz76jbmFIs=;
 b=PtVGR3+vE3kCGQqYlmKtn9cimXF3HCZjE1UB9g3TaQ6P4wfrMuojSQ2rxJ57/Pcd1CIN
 NtbDETgTvFZCg372A8PJ6qvzI30xAk+aIvI+okwGRemsCQbGEIEwvLuKpElUtryJN3SK
 Qi3aw2I1W+eKKtvUmWRd/KSgNcccLgAxilfuF86bxWuyOBjptMUpXTCOi5dRkrGNVgJo
 XZESmyg0EsJFwn1m6K1vWO7cjEeYuyHClto+7LajRacM/s4LqBkSLWQ+jA7chRAQFEro
 Okr9JcrZPQglQM0TjkxZMezh9meOaWbp0JNlSGQmPw0rT2FbIrrBo68MVPKYMJUTNSbs 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36pd9a8ur0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Feb 2021 07:45:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11H7jYGn059452;
        Wed, 17 Feb 2021 07:45:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 36prhsj3br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Feb 2021 07:45:38 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11H7jY5s018703;
        Wed, 17 Feb 2021 07:45:34 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Feb 2021 07:45:34 +0000
Date:   Wed, 17 Feb 2021 10:45:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Dmitrii Banshchikov <me@ubique.spb.ru>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 bpf-next] bpf: fix a warning message in
 mark_ptr_not_null_reg()
Message-ID: <YCzJlV3hnF/t1Pk4@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04c60ed2-1a96-2835-9ae1-0ba84f482362@iogearbox.net>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102170056
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170056
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The WARN_ON() argument is a condition, not an error message.  So this
code will print a stack trace but will not print the warning message.
Fix that and also change it to only WARN_ONCE().

Fixes: 4ddb74165ae5 ("bpf: Extract nullable reg type conversion into a helper function")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2:  Use WARN_ONCE().

 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1dda9d81f12c..3d34ba492d46 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1120,7 +1120,7 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 		reg->type = PTR_TO_RDWR_BUF;
 		break;
 	default:
-		WARN_ON("unknown nullable register type");
+		WARN_ONCE(1, "unknown nullable register type");
 	}
 }
 
-- 
2.30.0

