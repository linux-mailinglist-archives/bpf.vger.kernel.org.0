Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE32350BEC
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhDABZH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 21:25:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49620 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233305AbhDABYn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 21:24:43 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1311EqKZ025079
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 18:24:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=h4THE0/9fbDn1aXbRW92YOWzXrO29vrfFzqDAbzbqWc=;
 b=ZYmYwezexXXy09wAgxStTR5EV5o3/ew0YXd3Uio3oe9FjJ7LbBmY57hvZjVglWWA+w/r
 QiA3ab8z5kbfQu+pw1UxJTP9TZlK06l+Xm30M/n8SlHS0hYGpwgxN3O1pzUJIHrdwQ6o
 ByUYPSZ+U1WTZ6ruAAT5pOo8XdcBhZXuASI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37n28mgktc-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 18:24:43 -0700
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 18:24:15 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 6DEA5EB0C72; Wed, 31 Mar 2021 18:24:12 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <linux-kbuild@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH kbuild v3 1/2] kbuild: move LINUX_ELFNOTE_BUILD_SALT to elfnote.h
Date:   Wed, 31 Mar 2021 18:24:11 -0700
Message-ID: <20210401012411.1801610-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401012406.1800957-1-yhs@fb.com>
References: <20210401012406.1800957-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UmQqcx6AH7XBd9mFCMy3kpiefMBgjZHn
X-Proofpoint-GUID: UmQqcx6AH7XBd9mFCMy3kpiefMBgjZHn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_11:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=776 suspectscore=0 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move LINUX_ELFNOTE_BUILD_SALT to elfnote.h so we have
a central place for all types with "Linux" owner.
This will make add more types easier.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/build-salt.h | 2 --
 include/linux/elfnote.h    | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/build-salt.h b/include/linux/build-salt.h
index bb007bd05e7a..6ab1db1d7f44 100644
--- a/include/linux/build-salt.h
+++ b/include/linux/build-salt.h
@@ -3,8 +3,6 @@
=20
 #include <linux/elfnote.h>
=20
-#define LINUX_ELFNOTE_BUILD_SALT       0x100
-
 #ifdef __ASSEMBLER__
=20
 #define BUILD_SALT \
diff --git a/include/linux/elfnote.h b/include/linux/elfnote.h
index 69b136e4dd2b..04af7ac40b1a 100644
--- a/include/linux/elfnote.h
+++ b/include/linux/elfnote.h
@@ -96,4 +96,9 @@
 #define ELFNOTE64(name, type, desc) ELFNOTE(64, name, type, desc)
 #endif	/* __ASSEMBLER__ */
=20
+/*
+ * The types for "Linux" owned notes.
+ */
+#define LINUX_ELFNOTE_BUILD_SALT	0x100
+
 #endif /* _LINUX_ELFNOTE_H */
--=20
2.30.2

