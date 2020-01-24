Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79116147E9C
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 11:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgAXKR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 05:17:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45802 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgAXKR7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 05:17:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OADBEW055164;
        Fri, 24 Jan 2020 10:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=5hxTBTG6Mu7hZsPfWtdleEXaVRIuzNQLCWb5b2m8Ros=;
 b=Vp4RaNfm9g7aNmv+7hwNw/IT8vdoQmBxQ5puaO/sQ8440mAdxlrQBqk+3tmpubfC+CaI
 dRLa7zGTIoN2dNen/q+K+S5TMzZMDGWPjkRgdEkT4Jlfq+x8fxnJzvCqkJR7XomUkt6Z
 iCC39WXMfvVDdAFSVbfgM39IwkOOfMivz627fCbmrZu7d2l/4mD2ukpCmARqxzCGIECX
 z4YGSVn0zIZ9jsUMmioZUATD8Mocu9Cbs3568wFj/SCD3rmhzB2fCBr7KJGFRuAUEuTQ
 i7EoYSebanfA+bGtBhCcfGZobOvOAT/4gfL93cyUXPXYJpWkxrivrC7Zme64n4aDI9tU WQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xktnrqypy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 10:17:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00OADxTn067060;
        Fri, 24 Jan 2020 10:15:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xqmuenna6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 10:15:10 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00OAF1ZM012262;
        Fri, 24 Jan 2020 10:15:07 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jan 2020 02:15:01 -0800
Date:   Fri, 24 Jan 2020 13:14:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jeff Dike <jdike@addtoit.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alex Dewar <alex.dewar@gmx.co.uk>,
        linux-um@lists.infradead.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] um: Fix some error handling in uml_vector_user_bpf()
Message-ID: <20200124101450.jxfzsh6sz7v324hv@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001240084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001240084
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

1) The uml_vector_user_bpf() returns pointers so it should return NULL
   instead of false.
2) If the "bpf_prog" allocation failed, it would have eventually lead to
   a crash.  We can't succeed after the error happens so it should just
   return.

Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 arch/um/drivers/vector_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index ddcd917be0af..88483f5b034c 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -732,13 +732,13 @@ void *uml_vector_user_bpf(char *filename)
 
 	if (stat(filename, &statbuf) < 0) {
 		printk(KERN_ERR "Error %d reading bpf file", -errno);
-		return false;
+		return NULL;
 	}
 	bpf_prog = uml_kmalloc(sizeof(struct sock_fprog), UM_GFP_KERNEL);
-	if (bpf_prog != NULL) {
-		bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
-		bpf_prog->filter = NULL;
-	}
+	if (!pfg_prog)
+		return NULL;
+	bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
+	bpf_prog->filter = NULL;
 	ffd = os_open_file(filename, of_read(OPENFLAGS()), 0);
 	if (ffd < 0) {
 		printk(KERN_ERR "Error %d opening bpf file", -errno);
-- 
2.11.0

