Return-Path: <bpf+bounces-14197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F87E0D57
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 03:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEABDB214B7
	for <lists+bpf@lfdr.de>; Sat,  4 Nov 2023 02:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332E61C3D;
	Sat,  4 Nov 2023 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9B15B1
	for <bpf@vger.kernel.org>; Sat,  4 Nov 2023 02:49:16 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C841BD
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 19:49:14 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B446A294BFC5F; Fri,  3 Nov 2023 19:49:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Vadim Fedorenko <vadfed@meta.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next] bpf: Use named fields for certain bpf uapi structs
Date: Fri,  3 Nov 2023 19:49:00 -0700
Message-Id: <20231104024900.1539182-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Martin and Vadim reported a verifier failure with bpf_dynptr usage.
The issue is mentioned but Vadim workarounded the issue with source
change ([1]). The below describes what is the issue and why there
is a verification failure.

  int BPF_PROG(skb_crypto_setup) {
    struct bpf_dynptr algo, key;
    ...

    bpf_dynptr_from_mem(..., ..., 0, &algo);
    ...
  }

The bpf program is using vmlinux.h, so we have the following definition i=
n
vmlinux.h:
  struct bpf_dynptr {
        long: 64;
        long: 64;
  };
Note that in uapi header bpf.h, we have
  struct bpf_dynptr {
        long: 64;
        long: 64;
} __attribute__((aligned(8)));

So we lost alignment information for struct bpf_dynptr by using vmlinux.h=
.
Let us take a look at a simple program below:
  $ cat align.c
  typedef unsigned long long __u64;
  struct bpf_dynptr_no_align {
        __u64 :64;
        __u64 :64;
  };
  struct bpf_dynptr_yes_align {
        __u64 :64;
        __u64 :64;
  } __attribute__((aligned(8)));

  void bar(void *, void *);
  int foo() {
    struct bpf_dynptr_no_align a;
    struct bpf_dynptr_yes_align b;
    bar(&a, &b);
    return 0;
  }
  $ clang --target=3Dbpf -O2 -S -emit-llvm align.c

Look at the generated IR file align.ll:
  ...
  %a =3D alloca %struct.bpf_dynptr_no_align, align 1
  %b =3D alloca %struct.bpf_dynptr_yes_align, align 8
  ...

The compiler dictates the alignment for struct bpf_dynptr_no_align is 1 a=
nd
the alignment for struct bpf_dynptr_yes_align is 8. So theoretically comp=
iler
could allocate variable %a with alignment 1 although in reallity the comp=
iler
may choose a different alignment by considering other local variables.

In [1], the verification failure happens because variable 'algo' is alloc=
ated
on the stack with alignment 4 (fp-28). But the verifer wants its alignmen=
t
to be 8.

To fix the issue, the RFC patch ([1]) tried to add '__attribute__((aligne=
d(8)))'
to struct bpf_dynptr plus other similar structs. Andrii suggested that
we could directly modify uapi struct with named fields like struct 'bpf_i=
ter_num':
  struct bpf_iter_num {
        /* opaque iterator state; having __u64 here allows to preserve co=
rrect
         * alignment requirements in vmlinux.h, generated from BTF
         */
        __u64 __opaque[1];
  } __attribute__((aligned(8)));

Indeed, adding named fields for those affected structs in this patch can =
preserve
alignment when bpf program references them in vmlinux.h. With this patch,
the verification failure in [1] can also be resolved.

  [1] https://lore.kernel.org/bpf/1b100f73-7625-4c1f-3ae5-50ecf84d3ff0@li=
nux.dev/
  [2] https://lore.kernel.org/bpf/20231103055218.2395034-1-yonghong.song@=
linux.dev/

Cc: Vadim Fedorenko <vadfed@meta.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/uapi/linux/bpf.h       | 23 +++++++----------------
 tools/include/uapi/linux/bpf.h | 23 +++++++----------------
 2 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0f6cdf52b1da..095ca7238ac2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7151,40 +7151,31 @@ struct bpf_spin_lock {
 };
=20
 struct bpf_timer {
-	__u64 :64;
-	__u64 :64;
+	__u64 __opaque[2];
 } __attribute__((aligned(8)));
=20
 struct bpf_dynptr {
-	__u64 :64;
-	__u64 :64;
+	__u64 __opaque[2];
 } __attribute__((aligned(8)));
=20
 struct bpf_list_head {
-	__u64 :64;
-	__u64 :64;
+	__u64 __opaque[2];
 } __attribute__((aligned(8)));
=20
 struct bpf_list_node {
-	__u64 :64;
-	__u64 :64;
-	__u64 :64;
+	__u64 __opaque[3];
 } __attribute__((aligned(8)));
=20
 struct bpf_rb_root {
-	__u64 :64;
-	__u64 :64;
+	__u64 __opaque[2];
 } __attribute__((aligned(8)));
=20
 struct bpf_rb_node {
-	__u64 :64;
-	__u64 :64;
-	__u64 :64;
-	__u64 :64;
+	__u64 __opaque[4];
 } __attribute__((aligned(8)));
=20
 struct bpf_refcount {
-	__u32 :32;
+	__u32 __opaque[1];
 } __attribute__((aligned(4)));
=20
 struct bpf_sysctl {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 0f6cdf52b1da..095ca7238ac2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7151,40 +7151,31 @@ struct bpf_spin_lock {
 };
=20
 struct bpf_timer {
-	__u64 :64;
-	__u64 :64;
+	__u64 __opaque[2];
 } __attribute__((aligned(8)));
=20
 struct bpf_dynptr {
-	__u64 :64;
-	__u64 :64;
+	__u64 __opaque[2];
 } __attribute__((aligned(8)));
=20
 struct bpf_list_head {
-	__u64 :64;
-	__u64 :64;
+	__u64 __opaque[2];
 } __attribute__((aligned(8)));
=20
 struct bpf_list_node {
-	__u64 :64;
-	__u64 :64;
-	__u64 :64;
+	__u64 __opaque[3];
 } __attribute__((aligned(8)));
=20
 struct bpf_rb_root {
-	__u64 :64;
-	__u64 :64;
+	__u64 __opaque[2];
 } __attribute__((aligned(8)));
=20
 struct bpf_rb_node {
-	__u64 :64;
-	__u64 :64;
-	__u64 :64;
-	__u64 :64;
+	__u64 __opaque[4];
 } __attribute__((aligned(8)));
=20
 struct bpf_refcount {
-	__u32 :32;
+	__u32 __opaque[1];
 } __attribute__((aligned(4)));
=20
 struct bpf_sysctl {
--=20
2.34.1


