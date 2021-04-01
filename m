Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B3C35238A
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 01:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbhDAX13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 19:27:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23832 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235696AbhDAX13 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Apr 2021 19:27:29 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131NJl4A032421
        for <bpf@vger.kernel.org>; Thu, 1 Apr 2021 16:27:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=YcRUCnQnduEELtvtPydWK4q4fQeOEDsuZr9Ueyetu7E=;
 b=gdRwV4DnSfKoLRvD+058MYnTWQ1I3rLyQ8CsumVeNXyegCxWXX8+xWr852ZiEZI4qDm5
 k5Lo4v8o7ATch6Mzcxa8IJp31P54q88lpP1Ck5gWQ3/yt7Ifq0oZI5xp9QYhajLCdDsC
 J0L4q/zDQ9Ldty0SaHdF4ytHvu+/SVcrz4g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37ng353n6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 16:27:28 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 16:27:27 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id ACCC4F35686; Thu,  1 Apr 2021 16:27:23 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <linux-kbuild@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH kbuild v4] kbuild: add an elfnote for whether vmlinux is built with lto
Date:   Thu, 1 Apr 2021 16:27:23 -0700
Message-ID: <20210401232723.3571287-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: O_qQX8mHBCOVySRFWWTlIUmYs9myXlhL
X-Proofpoint-ORIG-GUID: O_qQX8mHBCOVySRFWWTlIUmYs9myXlhL
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_14:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103310000 definitions=main-2104010151
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, clang LTO built vmlinux won't work with pahole.
LTO introduced cross-cu dwarf tag references and broke
current pahole model which handles one cu as a time.
The solution is to merge all cu's as one pahole cu as in [1].
We would like to do this merging only if cross-cu dwarf
references happens. The LTO build mode is a pretty good
indication for that.

In earlier version of this patch ([2]), clang flag
-grecord-gcc-switches is proposed to add to compilation flags
so pahole could detect "-flto" and then merging cu's.
This will increate the binary size of 1% without LTO though.

Arnaldo suggested to use a note to indicate the vmlinux
is built with LTO. Such a cheap way to get whether the vmlinux
is built with LTO or not helps pahole but is also useful
for tracing as LTO may inline/delete/demote global functions,
promote static functions, etc.

So this patch added an elfnote with a new type LINUX_ELFNOTE_LTO_INFO.
The owner of the note is "Linux".

With gcc 8.4.1 and clang trunk, without LTO, I got
  $ readelf -n vmlinux
  Displaying notes found in: .notes
    Owner                Data size        Description
  ...
    Linux                0x00000004       func
     description data: 00 00 00 00
  ...
With "readelf -x ".notes" vmlinux", I can verify the above "func"
with type code 0x101.

With clang thin-LTO, I got the same as above except the following:
     description data: 01 00 00 00
which indicates the vmlinux is built with LTO.

  [1] https://lore.kernel.org/bpf/20210325065316.3121287-1-yhs@fb.com/
  [2] https://lore.kernel.org/bpf/20210331001623.2778934-1-yhs@fb.com/

Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/elfnote-lto.h | 14 ++++++++++++++
 init/version.c              |  2 ++
 scripts/mod/modpost.c       |  2 ++
 3 files changed, 18 insertions(+)
 create mode 100644 include/linux/elfnote-lto.h

Changelogs:
  v3 -> v4:
    . put new lto note in its own header file similar to
      build-salt.h. (Nick)
  v2 -> v3:
    . abandoned the approach of adding -grecord-gcc-switches,
      instead create a note to indicate whether it is a lto build
      or not. The note definition is in compiler.h. (Arnaldo)
  v1 -> v2:
    . limited to add -grecord-gcc-switches for LTO_CLANG
      instead of all clang build

diff --git a/include/linux/elfnote-lto.h b/include/linux/elfnote-lto.h
new file mode 100644
index 000000000000..d4635a3ecc4f
--- /dev/null
+++ b/include/linux/elfnote-lto.h
@@ -0,0 +1,14 @@
+#ifndef __ELFNOTE_LTO_H
+#define __ELFNOTE_LTO_H
+
+#include <linux/elfnote.h>
+
+#define LINUX_ELFNOTE_LTO_INFO	0x101
+
+#ifdef CONFIG_LTO
+#define BUILD_LTO_INFO	ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 1)
+#else
+#define BUILD_LTO_INFO	ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 0)
+#endif
+
+#endif /* __ELFNOTE_LTO_H */
diff --git a/init/version.c b/init/version.c
index 92afc782b043..1a356f5493e8 100644
--- a/init/version.c
+++ b/init/version.c
@@ -9,6 +9,7 @@
=20
 #include <generated/compile.h>
 #include <linux/build-salt.h>
+#include <linux/elfnote-lto.h>
 #include <linux/export.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
@@ -45,3 +46,4 @@ const char linux_proc_banner[] =3D
 	" (" LINUX_COMPILER ") %s\n";
=20
 BUILD_SALT;
+BUILD_LTO_INFO;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 24725e50c7b4..98fb2bb024db 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2191,10 +2191,12 @@ static void add_header(struct buffer *b, struct mod=
ule *mod)
 	 */
 	buf_printf(b, "#define INCLUDE_VERMAGIC\n");
 	buf_printf(b, "#include <linux/build-salt.h>\n");
+	buf_printf(b, "#include <linux/elfnote-lto.h>\n");
 	buf_printf(b, "#include <linux/vermagic.h>\n");
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
 	buf_printf(b, "BUILD_SALT;\n");
+	buf_printf(b, "BUILD_LTO_INFO;\n");
 	buf_printf(b, "\n");
 	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
 	buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
--=20
2.30.2

