Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6F012598F
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 03:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfLSCUm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 21:20:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16620 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726700AbfLSCUm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 21:20:42 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBJ2IMIh019077
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 18:20:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=2j1bjPUzrEYgDVZgAt65XwSniFueFlCVFDpnkzSnY0A=;
 b=OCkMpX8C6x6dvqwYrI/puwZqnn3tzc6Tdu9pxbRBh3EX7pIQgE0W9qzFJWZ5DQN3nS4V
 2gt+ofVCIsauRHg1XUGPsbuAQ7oJd+T1m8ELVf6BfD9oUTNl6FQ3ddjyNmZ7ZCWslcqc
 Xa5HLcqCoiNo1tMwuhKjWGWDC1eRsXtM16U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2wyc7tdfss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 18:20:41 -0800
Received: from intmgw002.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 18:20:39 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id A98CC3711476; Wed, 18 Dec 2019 17:56:25 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <andriin@fb.com>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 bpf-next 2/6] bpf: Remove unused new_flags in hierarchy_allows_attach()
Date:   Wed, 18 Dec 2019 17:55:59 -0800
Message-ID: <2c49b30ab750f93cfef04a1e40b097d70c3a39a1.1576720240.git.rdna@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576720240.git.rdna@fb.com>
References: <cover.1576720240.git.rdna@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_08:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=13 clxscore=1015 priorityscore=1501 mlxscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=479
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190017
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

new_flags is unused, remove it.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 kernel/bpf/cgroup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index e8cbdd1be687..283efe3ce052 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -103,8 +103,7 @@ static u32 prog_list_length(struct list_head *head)
  * if parent has overridable or multi-prog, allow attaching
  */
 static bool hierarchy_allows_attach(struct cgroup *cgrp,
-				    enum bpf_attach_type type,
-				    u32 new_flags)
+				    enum bpf_attach_type type)
 {
 	struct cgroup *p;
 
@@ -303,7 +302,7 @@ int __cgroup_bpf_attach(struct cgroup *cgrp, struct bpf_prog *prog,
 		/* invalid combination */
 		return -EINVAL;
 
-	if (!hierarchy_allows_attach(cgrp, type, flags))
+	if (!hierarchy_allows_attach(cgrp, type))
 		return -EPERM;
 
 	if (!list_empty(progs) && cgrp->bpf.flags[type] != flags)
-- 
2.17.1

