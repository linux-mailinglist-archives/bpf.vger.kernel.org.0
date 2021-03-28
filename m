Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484DD34BB3D
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 08:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhC1GQ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 02:16:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11980 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229503AbhC1GQv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Mar 2021 02:16:51 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 12S6CdOf001873
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 23:16:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=vyd1KNPn1JtH1s7YFLdMyt8KI4USe/h/X3+k6FR8tV0=;
 b=A6qUUBqlWQzdjmG0Q2D5qS/r74n3l3ASkRFSSBd6H7DvylSN5lXswJOAwk8t57DgmHk1
 vjcEoyZuDthfrLnbUqL6RDmkgewl+uEQ9r6VRfLaVLnOcZEb8dXWupOqYhjqgPBGRA85
 HUM6k08QS2/BeSr1vQoRjwkTYY90t9V/Z9U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 37j0cpk9aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 27 Mar 2021 23:16:50 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 27 Mar 2021 23:16:49 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 5F0E3C8F3BD; Sat, 27 Mar 2021 23:16:46 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH dwarves v2 0/3] permit merging all dwarf cu's for clang lto built binary
Date:   Sat, 27 Mar 2021 23:16:46 -0700
Message-ID: <20210328061646.1955678-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YNfZ4BFuS764YyKEGJml3ruoDSG7iiq-
X-Proofpoint-ORIG-GUID: YNfZ4BFuS764YyKEGJml3ruoDSG7iiq-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_04:2021-03-26,2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For vmlinux built with clang thin-lto or lto for latest bpf-next,
there exist cross cu debuginfo type references. For example,
      compile unit 1:
         tag 10:  type A
      compile unit 2:
         ...
           refer to type A (tag 10 in compile unit 1)
I only checked a few but have seen type A may be a simple type
like "unsigned char" or a complex type like an array of base types.
I am using latest llvm trunk and bpf-next. I suspect llvm12 or
linus tree >=3D 5.12 rc2 should be able to exhibit the issue as well.
Both thin-lto and lto have the same issues.

Current pahole cannot handle this. It will report types cannot
be found error. Bill Wendling has attempted to fix the issue
with [1] by permitting all tags/types are hashed to the same
hash table and then process cu's one by one. This does not
really work. The reason is that each cu resolves types locally
so for the above example we may have
  compile unit 1:
    type A : type_id =3D 10
  compile unit 2:
    refer to type A : type A will be resolved as type id =3D 10
But id 10 refers to compile unit 1, we will get either out
of bound type id or incorrect one.

This patch set is a continuation of Bill's work. We still
increase the hashtable size and traverse all cu's before
recoding and finalization. But instead of creating one-to-one
mapping between debuginfo cu and pahole cu, we just create
one pahole cu, which should solve the above incorrect type
id issue.

Patch #1 and #2 are refactoring the existing code and
Patch #3 added logic to premit merging all debuginfo cu's
into one pahole cu. The detection for whether merging is
desirable is done by checking the existence of
"clang" compiler and its "lto" option in dwarf producer tag.

The following linux patch is needed to put clang compiler
flags into dwarf. It will be submitted separately

diff --git a/Makefile b/Makefile
index d4784d181123..ab0119beb42d 100644
--- a/Makefile
+++ b/Makefile
@@ -839,6 +839,12 @@ dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) :=3D 5
 DEBUG_CFLAGS   +=3D -gdwarf-$(dwarf-version-y)
 endif
=20
+# gcc emits compilation flags in dwarf DW_AT_producer by default
+# while clang needs explicit flag. Add this flag explicitly.
+ifdef CONFIG_CC_IS_CLANG
+DEBUG_CFLAGS   +=3D -grecord-gcc-switches
+endif
+
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS   +=3D $(call cc-option, -femit-struct-debug-baseonly) \
                   $(call cc-option,-fno-var-tracking)

Changelogs:
  v1 -> v2:
    . removed "--merge_cus" option, relied on detections on
      clang compiler and its lto flags.

Yonghong Song (3):
  dwarf_loader: permits flexible HASHTAGS__BITS
  dwarf_loader: factor out common code to initialize a cu
  dwarf_loader: permit merging all dwarf cu's for clang lto built binary

 dwarf_loader.c | 209 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 175 insertions(+), 34 deletions(-)

--=20
2.30.2

