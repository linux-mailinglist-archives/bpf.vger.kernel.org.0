Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B58449E67C
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 16:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiA0PqL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 10:46:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243097AbiA0PqK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 10:46:10 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20RFTYjv014963
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 07:46:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Qoobx9OpCcbYldQHUKTl8vE59QjYH0uo3SnRNURRwr8=;
 b=Ju6E7B0onWSQLPqrxvOnVinQGBE0PZX23gEKoa4+28pZtVn47YVWThzW6mqn2bvzgNO3
 ouvn015gLcIPG9FU515n7kDugTxALAJNQ+uzlrLUp/lXG7l3u6dxjtqUDtICPcR/6xGB
 sUQB7dfiT9a5Bs0OzxdPdTgfa7xCSOC8YWA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3dujwbbd65-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 07:46:09 -0800
Received: from twshared3205.02.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 27 Jan 2022 07:46:07 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 1452C5A22B65; Thu, 27 Jan 2022 07:46:00 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next v3 1/6] compiler_types: define __user as __attribute__((btf_type_tag("user")))
Date:   Thu, 27 Jan 2022 07:46:00 -0800
Message-ID: <20220127154600.652613-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127154555.650886-1-yhs@fb.com>
References: <20220127154555.650886-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: urGYSPsH-w-5wfC5vjrluCroYnFrVghz
X-Proofpoint-ORIG-GUID: urGYSPsH-w-5wfC5vjrluCroYnFrVghz
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=919 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201270095
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The __user attribute is currently mainly used by sparse for type checking.
The attribute indicates whether a memory access is in user memory address
space or not. Such information is important during tracing kernel
internal functions or data structures as accessing user memory often
has different mechanisms compared to accessing kernel memory. For example,
the perf-probe needs explicit command line specification to indicate a
particular argument or string in user-space memory ([1], [2], [3]).
Currently, vmlinux BTF is available in kernel with many distributions.
If __user attribute information is available in vmlinux BTF, the explicit
user memory access information from users will not be necessary as
the kernel can figure it out by itself with vmlinux BTF.

Besides the above possible use for perf/probe, another use case is
for bpf verifier. Currently, for bpf BPF_PROG_TYPE_TRACING type of bpf
programs, users can write direct code like
  p->m1->m2
and "p" could be a function parameter. Without __user information in BTF,
the verifier will assume p->m1 accessing kernel memory and will generate
normal loads. Let us say "p" actually tagged with __user in the source
code.  In such cases, p->m1 is actually accessing user memory and direct
load is not right and may produce incorrect result. For such cases,
bpf_probe_read_user() will be the correct way to read p->m1.

To support encoding __user information in BTF, a new attribute
  __attribute__((btf_type_tag("<arbitrary_string>")))
is implemented in clang ([4]). For example, if we have
  #define __user __attribute__((btf_type_tag("user")))
during kernel compilation, the attribute "user" information will
be preserved in dwarf. After pahole converting dwarf to BTF, __user
information will be available in vmlinux BTF.

The following is an example with latest upstream clang (clang14) and
pahole 1.23:

  [$ ~] cat test.c
  #define __user __attribute__((btf_type_tag("user")))
  int foo(int __user *arg) {
          return *arg;
  }
  [$ ~] clang -O2 -g -c test.c
  [$ ~] pahole -JV test.o
  ...
  [1] INT int size=3D4 nr_bits=3D32 encoding=3DSIGNED
  [2] TYPE_TAG user type_id=3D1
  [3] PTR (anon) type_id=3D2
  [4] FUNC_PROTO (anon) return=3D1 args=3D(3 arg)
  [5] FUNC foo type_id=3D4
  [$ ~]

You can see for the function argument "int __user *arg", its type is
described as
  PTR -> TYPE_TAG(user) -> INT
The kernel can use this information for bpf verification or other
use cases.

Current btf_type_tag is only supported in clang (>=3D clang14) and
pahole (>=3D 1.23). gcc support is also proposed and under development ([5]=
).

  [1] http://lkml.kernel.org/r/155789874562.26965.10836126971405890891.stgi=
t@devnote2
  [2] http://lkml.kernel.org/r/155789872187.26965.4468456816590888687.stgit=
@devnote2
  [3] http://lkml.kernel.org/r/155789871009.26965.14167558859557329331.stgi=
t@devnote2
  [4] https://reviews.llvm.org/D111199
  [5] https://lore.kernel.org/bpf/0cbeb2fb-1a18-f690-e360-24b1c90c2a91@fb.c=
om/

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/compiler_types.h | 3 +++
 lib/Kconfig.debug              | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3c1795fdb568..3f31ff400432 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -31,6 +31,9 @@ static inline void __chk_io_ptr(const volatile void __iom=
em *ptr) { }
 # define __kernel
 # ifdef STRUCTLEAK_PLUGIN
 #  define __user	__attribute__((user))
+# elif defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG=
) && \
+	__has_attribute(btf_type_tag)
+#  define __user	__attribute__((btf_type_tag("user")))
 # else
 #  define __user
 # endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14b89aa37c5c..6159859769fa 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -325,6 +325,14 @@ config DEBUG_INFO_BTF
 config PAHOLE_HAS_SPLIT_BTF
 	def_bool $(success, test `$(PAHOLE) --version | sed -E 's/v([0-9]+)\.([0-=
9]+)/\1\2/'` -ge "119")
=20
+config PAHOLE_HAS_BTF_TAG
+	def_bool $(success, test `$(PAHOLE) --version | sed -E 's/v([0-9]+)\.([0-=
9]+)/\1\2/'` -ge "123")
+	depends on CC_IS_CLANG
+	help
+	  Decide whether pahole emits btf_tag attributes (btf_type_tag and
+	  btf_decl_tag) or not. Currently only clang compiler implements
+	  these attributes, so make the config depend on CC_IS_CLANG.
+
 config DEBUG_INFO_BTF_MODULES
 	def_bool y
 	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
--=20
2.30.2

