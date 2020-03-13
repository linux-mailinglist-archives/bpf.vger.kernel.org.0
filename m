Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 385F2183DD3
	for <lists+bpf@lfdr.de>; Fri, 13 Mar 2020 01:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCMAVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Mar 2020 20:21:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42028 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbgCMAVg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Mar 2020 20:21:36 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02D0JuVn010489
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 17:21:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=fvcRNntQMMkTA/GVquF6OBoXfs3H9zh3ARF8GXcr6Ww=;
 b=W5F22ZVPtxVBCozbCV7lt3zNzMUWhj4nUbU/bet0m3AoeBnaQ/hdZpKlMGm1xd+oFDFQ
 aWmjTfrgWX7h/w4XLLzuV0yFJ5w5dt0kc/xyGDJH4mG5JMyG4eq5/A2VVlOIBnPAby58
 9CewRK0iOkEngQI9Czx7ShGThcTTIhO0yK4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yqt7fhmg2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2020 17:21:35 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 12 Mar 2020 17:21:34 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id B4CD02EC2E74; Thu, 12 Mar 2020 17:21:30 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next] bpf: abstract away entire bpf_link clean up procedure
Date:   Thu, 12 Mar 2020 17:21:28 -0700
Message-ID: <20200313002128.2028680-1-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_19:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=765
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=8
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003130000
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of requiring users to do three steps for cleaning up bpf_link, its
anon_inode file, and unused fd, abstract that away into bpf_link_cleanup()
helper. bpf_link_defunct() is removed, as it shouldn't be needed as an
individual operation anymore.

v1->v2:
- keep bpf_link_cleanup() static for now (Daniel).

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 include/linux/bpf.h  |  1 -
 kernel/bpf/syscall.c | 18 +++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4fd91b7c95ea..49389ddb948f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1075,7 +1075,6 @@ struct bpf_link_ops {
 
 void bpf_link_init(struct bpf_link *link, const struct bpf_link_ops *ops,
 		   struct bpf_prog *prog);
-void bpf_link_defunct(struct bpf_link *link);
 void bpf_link_inc(struct bpf_link *link);
 void bpf_link_put(struct bpf_link *link);
 int bpf_link_new_fd(struct bpf_link *link);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b2f73ecacced..85567a6ea5f9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2188,9 +2188,17 @@ void bpf_link_init(struct bpf_link *link, const struct bpf_link_ops *ops,
 	link->prog = prog;
 }
 
-void bpf_link_defunct(struct bpf_link *link)
+/* Clean up bpf_link and corresponding anon_inode file and FD. After
+ * anon_inode is created, bpf_link can't be just kfree()'d due to deferred
+ * anon_inode's release() call. This helper manages marking bpf_link as
+ * defunct, releases anon_inode file and puts reserved FD.
+ */
+static void bpf_link_cleanup(struct bpf_link *link, struct file *link_file,
+			     int link_fd)
 {
 	link->prog = NULL;
+	fput(link_file);
+	put_unused_fd(link_fd);
 }
 
 void bpf_link_inc(struct bpf_link *link)
@@ -2383,9 +2391,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
 
 	err = bpf_trampoline_link_prog(prog);
 	if (err) {
-		bpf_link_defunct(&link->link);
-		fput(link_file);
-		put_unused_fd(link_fd);
+		bpf_link_cleanup(&link->link, link_file, link_fd);
 		goto out_put_prog;
 	}
 
@@ -2498,9 +2504,7 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 
 	err = bpf_probe_register(link->btp, prog);
 	if (err) {
-		bpf_link_defunct(&link->link);
-		fput(link_file);
-		put_unused_fd(link_fd);
+		bpf_link_cleanup(&link->link, link_file, link_fd);
 		goto out_put_btp;
 	}
 
-- 
2.17.1

