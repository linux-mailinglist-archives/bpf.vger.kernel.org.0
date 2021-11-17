Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EA8454EAD
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 21:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhKQUmX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 15:42:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14064 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229899AbhKQUmX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Nov 2021 15:42:23 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1AHJvkwK015507
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 12:39:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Klq+czeme1epCOq7zE4Yy+b5gyDkMw6F8TxUd6VIsr0=;
 b=Yd/BnOHVXVJaFs+XmnxGGGo4FEvMLuAxvM2tliblpo9JSiV0oJqBIP01LAvzaXet4vVx
 5yjEU/RsOsP/uaS6Xhq67b3OaEErms4/ftUBjLE3USSqc47Ab8qeyq7BE5GCiDl+UpTh
 LYZQa861svQG6TXxpW4KKrEBKloAiQMKoEE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3cd3ahtv03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 12:39:23 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 17 Nov 2021 12:39:22 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 615AE28FDBF6; Wed, 17 Nov 2021 12:39:19 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 1/3] compiler_types: define __user as __attribute__((btf_type_tag("user")))
Date:   Wed, 17 Nov 2021 12:39:19 -0800
Message-ID: <20211117203919.3356040-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117203914.3355618-1-yhs@fb.com>
References: <20211117203914.3355618-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: ZOsMgOxhtRL6XanmccQf-Ir1CyUxpCV5
X-Proofpoint-ORIG-GUID: ZOsMgOxhtRL6XanmccQf-Ir1CyUxpCV5
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_07,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170092
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

