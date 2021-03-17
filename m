Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF05B33E870
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 05:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCQE3o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 00:29:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37866 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229472AbhCQE3L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 17 Mar 2021 00:29:11 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12H4Opcw012659
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 21:29:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=fC0RzO767vZqCdi7OUb6lxOyRO+SBf2oMXPmW7kxQgY=;
 b=kGFEzccbELK+GKzuw9DGHpiWmC98GR48kbttDjbkrww+ADX4jDS+ttdeDBTqIu2czHur
 ATIxQdEjEtZ/f/HrHqsW5jkOGinb+/QA4NZvvZrxI1DKK8RKAFHolqsDhVvPid2rTfif
 RkN2ou1jLcBqqVRncm1q2/xFeJ29UOcb+f4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 379e11g0k5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 21:29:11 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 21:29:09 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id F01AA67F30D; Tue, 16 Mar 2021 21:29:06 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v2] bpf: net: emit anonymous enum with BPF_TCP_CLOSE value explicitly
Date:   Tue, 16 Mar 2021 21:29:06 -0700
Message-ID: <20210317042906.1011232-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-17_01:2021-03-16,2021-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103170033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The selftest failed to compile with clang-built bpf-next.
Adding LLVM=3D1 to your vmlinux and selftest build will use clang.
The error message is:
  progs/test_sk_storage_tracing.c:38:18: error: use of undeclared identif=
ier 'BPF_TCP_CLOSE'
          if (newstate =3D=3D BPF_TCP_CLOSE)
                          ^
  1 error generated.
  make: *** [Makefile:423: /bpf-next/tools/testing/selftests/bpf/test_sk_=
storage_tracing.o] Error 1

The reason for the failure is that BPF_TCP_CLOSE, a value of
an anonymous enum defined in uapi bpf.h, is not defined in
vmlinux.h. gcc does not have this problem. Since vmlinux.h
is derived from BTF which is derived from vmlinux DWARF,
that means gcc-produced vmlinux DWARF has BPF_TCP_CLOSE
while llvm-produced vmlinux DWARF does not have.

BPF_TCP_CLOSE is referenced in net/ipv4/tcp.c as
  BUILD_BUG_ON((int)BPF_TCP_CLOSE !=3D (int)TCP_CLOSE);
The following test mimics the above BUILD_BUG_ON, preprocessed
with clang compiler, and shows gcc DWARF contains BPF_TCP_CLOSE while
llvm DWARF does not.

  $ cat t.c
  enum {
    BPF_TCP_ESTABLISHED =3D 1,
    BPF_TCP_CLOSE =3D 7,
  };
  enum {
    TCP_ESTABLISHED =3D 1,
    TCP_CLOSE =3D 7,
  };

  int test() {
    do {
      extern void __compiletime_assert_767(void) ;
      if ((int)BPF_TCP_CLOSE !=3D (int)TCP_CLOSE) __compiletime_assert_76=
7();
    } while (0);
    return 0;
  }
  $ clang t.c -O2 -c -g && llvm-dwarfdump t.o | grep BPF_TCP_CLOSE
  $ gcc t.c -O2 -c -g && llvm-dwarfdump t.o | grep BPF_TCP_CLOSE
                    DW_AT_name    ("BPF_TCP_CLOSE")

Further checking clang code find clang actually tried to
evaluate condition at compile time. If it is definitely
true/false, it will perform optimization and the whole if condition
will be removed before generating IR/debuginfo.

This patch explicited add an expression like
  (void)BPF_TCP_ESTABLISHED
to enable generation of debuginfo for the anonymous
enum which also includes BPF_TCP_CLOSE. I put
this explicit type generation in kernel/bpf/core.c
to (1) avoid polute net/ipv4/tcp.c and more importantly
(2) provide a central place to add other types (e.g. in
bpf/btf uapi header) if they are not referenced in the kernel
or generated in vmlinux DWARF.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 include/linux/btf.h |  1 +
 kernel/bpf/core.c   | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

Changelog:
  v1 -> v2:
    use DWARF instead of dwarf for better consistency with
    other usages. (Andrii)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 7fabf1428093..9c1b52738bbe 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -9,6 +9,7 @@
 #include <uapi/linux/bpf.h>
=20
 #define BTF_TYPE_EMIT(type) ((void)(type *)0)
+#define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
=20
 struct btf;
 struct btf_member;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3a283bf97f2f..9550d883ef9b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2378,3 +2378,22 @@ EXPORT_SYMBOL(bpf_stats_enabled_key);
=20
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_exception);
 EXPORT_TRACEPOINT_SYMBOL_GPL(xdp_bulk_tx);
+
+static int __init bpf_emit_btf_type(void)
+{
+	/* bpf uapi header bpf.h defines an anonymous enum with values
+	 * BPF_TCP_* used by bpf programs. Currently gcc built vmlinux
+	 * is able to emit this enum in DWARF due to the following
+	 * BUILD_BUG_ON test in net/ipv4/tcp.c:
+	 *   BUILD_BUG_ON((int)BPF_TCP_ESTABLISHED !=3D (int)TCP_ESTABLISHED);
+	 * clang built vmlinux does not have this enum in DWARF
+	 * since clang removes the above code before generating IR/debuginfo.
+	 * Let us explicitly emit the type debuginfo to ensure the
+	 * above-mentioned anonymous enum in the vmlinux DWARF and hence BTF
+	 * regardless of which compiler is used.
+	 */
+	BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
+
+	return 0;
+}
+late_initcall(bpf_emit_btf_type);
--=20
2.30.2

