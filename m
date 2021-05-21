Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75238D21B
	for <lists+bpf@lfdr.de>; Sat, 22 May 2021 01:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhEUXom convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 21 May 2021 19:44:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43418 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230221AbhEUXoi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 21 May 2021 19:44:38 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LNf1o5022591
        for <bpf@vger.kernel.org>; Fri, 21 May 2021 16:43:15 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38p4yt5qkq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 21 May 2021 16:43:15 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 16:43:13 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 4AD0C2ED15F6; Fri, 21 May 2021 16:43:10 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 5/5] bpftool: set errno on skeleton failures and propagate errors
Date:   Fri, 21 May 2021 16:43:08 -0700
Message-ID: <20210521234308.1290190-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YaQ7QYyfrPhnYV97ViiHrEKDcehf5xxC
X-Proofpoint-GUID: YaQ7QYyfrPhnYV97ViiHrEKDcehf5xxC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_11:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1034 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105210136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Follow libbpf's error handling conventions and pass through errors and errno
properly. Skeleton code always returned NULL on errors (not ERR_PTR(err)), so
there are no backwards compatibility concerns. But now we also set errno
properly, so it's possible to distinguish different reasons for failure, if
necessary.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 13b0aa789178..1d71ff8c52fa 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -713,6 +713,7 @@ static int do_skeleton(int argc, char **argv)
 		#ifndef %2$s						    \n\
 		#define %2$s						    \n\
 									    \n\
+		#include <errno.h>					    \n\
 		#include <stdlib.h>					    \n\
 		#include <bpf/libbpf.h>					    \n\
 									    \n\
@@ -793,18 +794,23 @@ static int do_skeleton(int argc, char **argv)
 		%1$s__open_opts(const struct bpf_object_open_opts *opts)    \n\
 		{							    \n\
 			struct %1$s *obj;				    \n\
+			int err;					    \n\
 									    \n\
 			obj = (struct %1$s *)calloc(1, sizeof(*obj));	    \n\
-			if (!obj)					    \n\
+			if (!obj) {					    \n\
+				errno = ENOMEM;				    \n\
 				return NULL;				    \n\
-			if (%1$s__create_skeleton(obj))			    \n\
-				goto err;				    \n\
-			if (bpf_object__open_skeleton(obj->skeleton, opts)) \n\
-				goto err;				    \n\
+			}						    \n\
+									    \n\
+			err = %1$s__create_skeleton(obj);		    \n\
+			err = err ?: bpf_object__open_skeleton(obj->skeleton, opts);\n\
+			if (err)					    \n\
+				goto err_out;				    \n\
 									    \n\
 			return obj;					    \n\
-		err:							    \n\
+		err_out:						    \n\
 			%1$s__destroy(obj);				    \n\
+			errno = -err;					    \n\
 			return NULL;					    \n\
 		}							    \n\
 									    \n\
@@ -824,12 +830,15 @@ static int do_skeleton(int argc, char **argv)
 		%1$s__open_and_load(void)				    \n\
 		{							    \n\
 			struct %1$s *obj;				    \n\
+			int err;					    \n\
 									    \n\
 			obj = %1$s__open();				    \n\
 			if (!obj)					    \n\
 				return NULL;				    \n\
-			if (%1$s__load(obj)) {				    \n\
+			err = %1$s__load(obj);				    \n\
+			if (err) {					    \n\
 				%1$s__destroy(obj);			    \n\
+				errno = -err;				    \n\
 				return NULL;				    \n\
 			}						    \n\
 			return obj;					    \n\
@@ -860,7 +869,7 @@ static int do_skeleton(int argc, char **argv)
 									    \n\
 			s = (struct bpf_object_skeleton *)calloc(1, sizeof(*s));\n\
 			if (!s)						    \n\
-				return -1;				    \n\
+				goto err;				    \n\
 			obj->skeleton = s;				    \n\
 									    \n\
 			s->sz = sizeof(*s);				    \n\
@@ -949,7 +958,7 @@ static int do_skeleton(int argc, char **argv)
 			return 0;					    \n\
 		err:							    \n\
 			bpf_object__destroy_skeleton(s);		    \n\
-			return -1;					    \n\
+			return -ENOMEM;					    \n\
 		}							    \n\
 									    \n\
 		#endif /* %s */						    \n\
-- 
2.30.2

