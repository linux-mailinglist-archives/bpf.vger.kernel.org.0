Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C783A350BEB
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 03:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhDABZG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 21:25:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19800 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233173AbhDABYf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 21:24:35 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1311FSrX030963
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 18:24:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=J71BE9RoPiHh1SugZt8jJTFl8tcrLgSSpv9QcXnD2cw=;
 b=AthmvRUZIipNzMMRBBH9Yei7uAgWcDPj/6nW3l+8U0JgjAV4nMvEaCL9dhJDmBGHk6xX
 TlUeXq2+B0w/o/o5MRT8UOQ8rb3KnlYAtb0C7WFR9gKKmEAka+TcBD5CkHg5isTIK8rC
 ylEnFKXjrwfrGiOkM4hyMghvHVtHdYRkxxk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37n2810kkq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 18:24:34 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 18:24:33 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id AB83AEB0CE5; Wed, 31 Mar 2021 18:24:17 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <linux-kbuild@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH kbuild v3 2/2] kbuild: add an elfnote with type BUILD_COMPILER_LTO_INFO
Date:   Wed, 31 Mar 2021 18:24:17 -0700
Message-ID: <20210401012417.1802681-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401012406.1800957-1-yhs@fb.com>
References: <20210401012406.1800957-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: mBhDopQCJZt8aq_XImBVpMmM4XY532fo
X-Proofpoint-ORIG-GUID: mBhDopQCJZt8aq_XImBVpMmM4XY532fo
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_11:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010006
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

So this patch added an elfnote with type BUILD_COMPILER_LTO_INFO.
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

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/compiler.h | 8 ++++++++
 include/linux/elfnote.h  | 1 +
 init/version.c           | 2 ++
 scripts/mod/modpost.c    | 1 +
 4 files changed, 12 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index df5b405e6305..b92930877277 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -245,6 +245,14 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define prevent_tail_call_optimization()	mb()
=20
+#include <linux/elfnote.h>
+
+#ifdef CONFIG_LTO
+#define BUILD_COMPILER_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_BUILD_LTO=
, 1)
+#else
+#define BUILD_COMPILER_LTO_INFO ELFNOTE32("Linux", LINUX_ELFNOTE_BUILD_LTO=
, 0)
+#endif
+
 #include <asm/rwonce.h>
=20
 #endif /* __LINUX_COMPILER_H */
diff --git a/include/linux/elfnote.h b/include/linux/elfnote.h
index 04af7ac40b1a..f5ec2b50ab7d 100644
--- a/include/linux/elfnote.h
+++ b/include/linux/elfnote.h
@@ -100,5 +100,6 @@
  * The types for "Linux" owned notes.
  */
 #define LINUX_ELFNOTE_BUILD_SALT	0x100
+#define LINUX_ELFNOTE_BUILD_LTO		0x101
=20
 #endif /* _LINUX_ELFNOTE_H */
diff --git a/init/version.c b/init/version.c
index 92afc782b043..a4f74b06fe78 100644
--- a/init/version.c
+++ b/init/version.c
@@ -9,6 +9,7 @@
=20
 #include <generated/compile.h>
 #include <linux/build-salt.h>
+#include <linux/compiler.h>
 #include <linux/export.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
@@ -45,3 +46,4 @@ const char linux_proc_banner[] =3D
 	" (" LINUX_COMPILER ") %s\n";
=20
 BUILD_SALT;
+BUILD_COMPILER_LTO_INFO;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 24725e50c7b4..713c0d5d5525 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2195,6 +2195,7 @@ static void add_header(struct buffer *b, struct modul=
e *mod)
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
 	buf_printf(b, "BUILD_SALT;\n");
+	buf_printf(b, "BUILD_COMPILER_LTO_INFO;\n");
 	buf_printf(b, "\n");
 	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
 	buf_printf(b, "MODULE_INFO(name, KBUILD_MODNAME);\n");
--=20
2.30.2

