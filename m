Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289AE3DB2E2
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 07:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhG3Fep convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 30 Jul 2021 01:34:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62836 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234733AbhG3Fep (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 30 Jul 2021 01:34:45 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U5TmoT026631
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 22:34:41 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a3ecntauv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 22:34:41 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Jul 2021 22:34:40 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 9ED6F3D405B3; Thu, 29 Jul 2021 22:34:32 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>
Subject: [PATCH v3 bpf-next 08/14] libbpf: remove unused bpf_link's destroy operation, but add dealloc
Date:   Thu, 29 Jul 2021 22:34:07 -0700
Message-ID: <20210730053413.1090371-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730053413.1090371-1-andrii@kernel.org>
References: <20210730053413.1090371-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: XpAGZLlXPeEViGyZSVE-M2XT-fuEotiK
X-Proofpoint-ORIG-GUID: XpAGZLlXPeEViGyZSVE-M2XT-fuEotiK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_03:2021-07-29,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=924 bulkscore=0 clxscore=1034 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_link->destroy() isn't used by any code, so remove it. Instead, add ability
to override deallocation procedure, with default doing plain free(link). This
is necessary for cases when we want to "subclass" struct bpf_link to keep
extra information, as is the case in the next patch adding struct
bpf_link_perf.

Cc: Rafael David Tinoco <rafaeldtinoco@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 313883179919..9654b2569ed0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8808,7 +8808,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 
 struct bpf_link {
 	int (*detach)(struct bpf_link *link);
-	int (*destroy)(struct bpf_link *link);
+	void (*dealloc)(struct bpf_link *link);
 	char *pin_path;		/* NULL, if not pinned */
 	int fd;			/* hook FD, -1 if not applicable */
 	bool disconnected;
@@ -8847,11 +8847,12 @@ int bpf_link__destroy(struct bpf_link *link)
 
 	if (!link->disconnected && link->detach)
 		err = link->detach(link);
-	if (link->destroy)
-		link->destroy(link);
 	if (link->pin_path)
 		free(link->pin_path);
-	free(link);
+	if (link->dealloc)
+		link->dealloc(link);
+	else
+		free(link);
 
 	return libbpf_err(err);
 }
-- 
2.30.2

