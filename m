Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CC334BEBB
	for <lists+bpf@lfdr.de>; Sun, 28 Mar 2021 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhC1UOc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Mar 2021 16:14:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20590 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231318AbhC1UOQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Mar 2021 16:14:16 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12SKA8YY022829
        for <bpf@vger.kernel.org>; Sun, 28 Mar 2021 13:14:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=5odDVdYYI/8PzenuyCpC/SaN9GY4og5+JdgYC4CoXEw=;
 b=bofQjAvD41+T+ayx6XqOC2PqnDBErdfhfwZyW4ZSSHaUt4SAwMYlwCxAyG80vb2500o6
 1G2+vS2/bp0p3maXHeF4uQAJv1unuAUuHR9pno2IHJu8RMei/skNj9OSYjZRC+Kiaho9
 n6IVGllTFOhUu+jW7Tt81zHivTR8tjy+4XA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37j27scsf6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 28 Mar 2021 13:14:12 -0700
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 28 Mar 2021 13:14:11 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 43AC8CDDC96; Sun, 28 Mar 2021 13:14:00 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH dwarves v3 0/3] permit merging all dwarf cu's for clang lto built binary
Date:   Sun, 28 Mar 2021 13:14:00 -0700
Message-ID: <20210328201400.1426437-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GDStTTHKWBc-OCPN9H529KY7OD4gXuT5
X-Proofpoint-GUID: GDStTTHKWBc-OCPN9H529KY7OD4gXuT5
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_12:2021-03-26,2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=959
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280154
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

This patch set depends on kernel patch [2]
to emit compilation flags for clang lto build so pahole
can properly discover whether to merge cu's or not.

Patch #1 and #2 are refactoring the existing code and
Patch #3 added logic to premit merging all debuginfo cu's
into one pahole cu. The detection for whether merging is
desirable is done by checking the existence of
"clang" compiler and its "lto" option in dwarf producer tag.

[1] https://lore.kernel.org/bpf/20210212211607.2890660-1-morbo@google.com/
[2] https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/

Changelogs:
  v2 -> v3:
    . change "return 1" to "return DWARF_CB_ABORT" in
      cus__merge_and_process_cu().
    . add kbuild/bpf link (above [2]) for kernel patch reference.
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

