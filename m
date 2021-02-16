Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F8D31D109
	for <lists+bpf@lfdr.de>; Tue, 16 Feb 2021 20:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhBPTiA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Feb 2021 14:38:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34932 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBPTiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Feb 2021 14:38:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GJSsZS056676;
        Tue, 16 Feb 2021 19:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Fyq+yfbGVzplz+I8WdwkPE4BKdkEHW8hMijJ/C45SIE=;
 b=MF5DHR12vrllVI/oOcx15bIJxNF1980OI+HmZyNFRlqQbRdW+PGszqgQPuh/P7TyYq0W
 F5qtDEAr+m4g2ULWdYsj9IZoRskfljD1ADpogvc/+4pZyo4wHUDFI/5t9uSEffc8Vg0o
 QMkT7Ox5eW0GlRhK6FpNMrkMpKbHB4VcRluu0kmSOn3OS8AX5MgGhXKLfWlrtC0ygLF+
 x+TZUJn7M+t+9Qsdo5Z1B8t0uCWqvEIwNimahGfYvahhuUlrpO5dZVMpN0hoWDhiRnmv
 x94K7lJWH/WyY3zSQZqgK3DM9PPkmoBTzNd4PYlg4rvkfu5g9vn9q/rGbKSlfLOf4QUX PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36p66r034n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 19:36:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11GJU2sk028125;
        Tue, 16 Feb 2021 19:36:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 36prpx7prh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Feb 2021 19:36:56 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11GJaot6025782;
        Tue, 16 Feb 2021 19:36:50 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Feb 2021 11:36:50 -0800
Date:   Tue, 16 Feb 2021 22:36:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] bpf: fix a warning message in mark_ptr_not_null_reg()
Message-ID: <YCwewjRBJIBm0sew@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102160162
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9897 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102160162
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The WARN_ON() argument is a condition, and it generates a stack trace
but it doesn't print the warning.

Fixes: 4ddb74165ae5 ("bpf: Extract nullable reg type conversion into a helper function")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 056df6be3e30..bd4d1dfca73c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1120,7 +1120,7 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 		reg->type = PTR_TO_RDWR_BUF;
 		break;
 	default:
-		WARN_ON("unknown nullable register type");
+		WARN(1, "unknown nullable register type");
 	}
 }
 
-- 
2.30.0

