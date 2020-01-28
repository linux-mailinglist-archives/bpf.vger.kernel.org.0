Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFFB14BCCE
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2020 16:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgA1P14 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jan 2020 10:27:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43366 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgA1P1z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jan 2020 10:27:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SFPE0v163707;
        Tue, 28 Jan 2020 15:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=WcLyX1UMG6Kg6oHwrdXVffPNT7Y4MkPcD5QG5ETvnRs=;
 b=JaWHNw8eNuWyb6qCiCvH0wRTnG33BCaFS63Vnlig3GKtn3SVeKCOgxickiFJJzVytNuc
 YzeuPbcdpGGedRyKcRdc1pp9mSgvIa0tRb9vdngo795tO9MgjDp1yf90RCGDYih54FFM
 zmqOW+pf1eP6SrkE5U3jcnCWP8V9oUhlQjBYatuknZHvcH1xiOmBBU5NiIQKVEC9Urkn
 l06M546WMqukbsgqp1qx/mekaFEE+2ZCbZqD8ZR3Jcd55YJD0EaDxB1sRI15uEcVLUhF
 X+ttiSrGxOEVqeK/aam8YuMWLrV1da344+fFXKGjukGgdD4CegqaNU61ciLnIHx+tZnS 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xrear6vwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 15:27:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SFLJHo033398;
        Tue, 28 Jan 2020 15:27:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xta8hyfgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 15:27:18 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00SFRD0k029151;
        Tue, 28 Jan 2020 15:27:13 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jan 2020 07:27:12 -0800
Date:   Tue, 28 Jan 2020 18:27:03 +0300
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
Subject: [PATCH v3] um: Fix some error handling in uml_vector_user_bpf()
Message-ID: <20200128151000.kx2bwayuuxpuqn6t@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001280122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001280122
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
v3: Fix screwed up subject.  Sorry.  Not my most shining hour.
v2: The first version broke the build.  Shame upon me.

 arch/um/drivers/vector_user.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index ddcd917be0af..1403cbadf92b 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -732,13 +732,14 @@ void *uml_vector_user_bpf(char *filename)
 
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
+	if (bpf_prog == NULL)
+		return NULL;
+	bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
+	bpf_prog->filter = NULL;
+
 	ffd = os_open_file(filename, of_read(OPENFLAGS()), 0);
 	if (ffd < 0) {
 		printk(KERN_ERR "Error %d opening bpf file", -errno);
-- 
2.11.0

