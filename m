Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D433EC7D0
	for <lists+bpf@lfdr.de>; Sun, 15 Aug 2021 09:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhHOHHC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 15 Aug 2021 03:07:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63186 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234351AbhHOHHB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Aug 2021 03:07:01 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17F6xxna004015
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:32 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aed56b89a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:32 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 15 Aug 2021 00:06:30 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id E42403D405A0; Sun, 15 Aug 2021 00:06:26 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>
Subject: [PATCH v5 bpf-next 08/16] libbpf: remove unused bpf_link's destroy operation, but add dealloc
Date:   Sun, 15 Aug 2021 00:06:01 -0700
Message-ID: <20210815070609.987780-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210815070609.987780-1-andrii@kernel.org>
References: <20210815070609.987780-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: QMEREBhop9BLpM3aaN1JEva5tNkO7Cis
X-Proofpoint-GUID: QMEREBhop9BLpM3aaN1JEva5tNkO7Cis
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-15_02:2021-08-13,2021-08-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 mlxlogscore=920 phishscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 clxscore=1034 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108150048
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
index ff3c0ee79d85..d30e3282bfc7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8810,7 +8810,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 
 struct bpf_link {
 	int (*detach)(struct bpf_link *link);
-	int (*destroy)(struct bpf_link *link);
+	void (*dealloc)(struct bpf_link *link);
 	char *pin_path;		/* NULL, if not pinned */
 	int fd;			/* hook FD, -1 if not applicable */
 	bool disconnected;
@@ -8849,11 +8849,12 @@ int bpf_link__destroy(struct bpf_link *link)
 
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

