Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAA14562E7
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 19:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhKRSv0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 13:51:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2660 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229929AbhKRSv0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 13:51:26 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIGecFA019123
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 10:48:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Klq+czeme1epCOq7zE4Yy+b5gyDkMw6F8TxUd6VIsr0=;
 b=NCUY0h6FhDHXhspzdCtGx3uQwM+MWwqVuhD/Qs4dioIuYeVKtneMyJEPgR+bSAmKuvR8
 ArLHFfgoNtmj0aeMRdY1DgQRN7PYU5iy9lwrXSRVvhXPh0HbLN/jFEptYgY9DYTTnSCN
 ZzmbzQnFUF2gZheY614yVWn8dGYR+L2TUC8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cdfr9weur-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 10:48:25 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 10:48:20 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 21E4829A3E85; Thu, 18 Nov 2021 10:48:16 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next v2 1/3] compiler_types: define __user as __attribute__((btf_type_tag("user")))
Date:   Thu, 18 Nov 2021 10:48:16 -0800
Message-ID: <20211118184816.1847689-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211118184810.1846996-1-yhs@fb.com>
References: <20211118184810.1846996-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: D9iQh91Ua-ktTMT3am2SImdJG3iTiYHP
X-Proofpoint-ORIG-GUID: D9iQh91Ua-ktTMT3am2SImdJG3iTiYHP
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If pahole and compiler supports btf_type_tag attributes,
during kernel build, we can define __user as
__attribute__((btf_type_tag("user"))). This will encode __user
information in BTF. Such information, encoded in BTF
as BTF_KIND_TYPE_TAG, can help bpf verifier to
ensure proper memory dereference mechanism depending
on user memory or kernel memory.

The encoded __user info is also useful for other tracing
facility where instead of to require user to specify
kernel/user address type, the kernel can detect it
by itself with btf.

The following is an example with latest upstream clang
(clang14, [1]) and latest pahole:
  [$ ~] cat test.c
  #define __tag1 __attribute__((btf_type_tag("tag1")))
  int foo(int __tag1 *arg) {
          return *arg;
  }
  [$ ~] clang -O2 -g -c test.c
  [$ ~] pahole -JV test.o
  ...
  [1] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
  [2] TYPE_TAG tag1 type_id=3D1
  [3] PTR (anon) type_id=3D2
  [4] FUNC_PROTO (anon) return=3D1 args=3D(3 arg)
  [5] FUNC foo type_id=3D4
  [$ ~]

You can see for the function argument "int __tag1 *arg",
its type is described as
  PTR -> TYPE_TAG(tag1) -> INT

The kernel can take advantage of this information
to bpf verification or other use cases.

Current btf_type_tag is only supported in clang (>=3D clang14).
gcc support is also proposed and under development ([2]).

  [1] https://reviews.llvm.org/D111199
  [2] https://www.spinics.net/lists/bpf/msg45773.html

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/compiler_types.h | 2 ++
 lib/Kconfig.debug              | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1d32f4c03c9e..65725e183a38 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -31,6 +31,8 @@ static inline void __chk_io_ptr(const volatile void __iom=
em *ptr) { }
 # define __kernel
 # ifdef STRUCTLEAK_PLUGIN
 #  define __user	__attribute__((user))
+# elif defined(CONFIG_PAHOLE_HAS_BTF_TAG) && __has_attribute(btf_type_tag)
+#  define __user	__attribute__((btf_type_tag("user")))
 # else
 #  define __user
 # endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ef7ce18b4f5..bf21b501c66d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -324,6 +324,11 @@ config DEBUG_INFO_BTF
 config PAHOLE_HAS_SPLIT_BTF
 	def_bool $(success, test `$(PAHOLE) --version | sed -E 's/v([0-9]+)\.([0-=
9]+)/\1\2/'` -ge "119")
=20
+config PAHOLE_HAS_BTF_TAG
+	depends on DEBUG_INFO_BTF
+	depends on CC_IS_CLANG
+	def_bool $(success, test `$(PAHOLE) --version | sed -E 's/v([0-9]+)\.([0-=
9]+)/\1\2/'` -ge "122")
+
 config DEBUG_INFO_BTF_MODULES
 	def_bool y
 	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
--=20
2.30.2

