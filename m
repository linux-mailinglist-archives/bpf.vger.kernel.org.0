Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB49B38F924
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 06:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhEYEBc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 25 May 2021 00:01:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60978 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230412AbhEYEBX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 May 2021 00:01:23 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 14P3iwdx017142
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 20:59:54 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 38rjdmahf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 20:59:54 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 20:59:53 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 3680A2EDBE05; Mon, 24 May 2021 20:59:49 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH v2 bpf-next 5/5] bpftool: set errno on skeleton failures and propagate errors
Date:   Mon, 24 May 2021 20:59:35 -0700
Message-ID: <20210525035935.1461796-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210525035935.1461796-1-andrii@kernel.org>
References: <20210525035935.1461796-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: jTltiTZC7in0LiaecG-IglN2H9PVbJxW
X-Proofpoint-GUID: jTltiTZC7in0LiaecG-IglN2H9PVbJxW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_02:2021-05-24,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Follow libbpf's error handling conventions and pass through errors and errno
properly. Skeleton code always returned NULL on errors (not ERR_PTR(err)), so
there are no backwards compatibility concerns. But now we also set errno
properly, so it's possible to distinguish different reasons for failure, if
necessary.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
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

