Return-Path: <bpf+bounces-14062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4397DFF0F
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 07:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49436281E04
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 06:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3856FB5;
	Fri,  3 Nov 2023 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361BD7461
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 06:11:02 +0000 (UTC)
X-Greylist: delayed 1103 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 23:10:56 PDT
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D641B4
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 23:10:56 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 051132942BA2C; Thu,  2 Nov 2023 22:52:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Vadim Fedorenko <vadfed@meta.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [RFC PATCH bpf-next] libbpf: bpftool : Emit aligned(8) attr for empty struct in btf source dump
Date: Thu,  2 Nov 2023 22:52:18 -0700
Message-Id: <20231103055218.2395034-1-yonghong.song@linux.dev>
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
may choose a different alignment by considering other variables.

In [1], the verification failure happens because variable 'algo' is alloc=
ated
on the stack with alignment 4 (fp-28). But the verifer wants its alignmen=
t
to be 8.

To fix the issue, the aligned(8) attribute should be emitted for those
special uapi structs (bpf_dynptr etc.) whose values will be used by
kernel helpers or kfuncs. For example, the following bpf_dynptr type
will be generated in vmlinux.h:
  struct bpf_dynptr {
        long: 64;
        long: 64;
} __attribute__((aligned(8)));

There are a few ways to do this:
  (1). this patch added an option 'empty_struct_align8' in 'btf_dump_opts=
',
       and bpftool will enable this option so libbpf will emit aligned(8)
       for empty structs. The only drawback is that some other non-bpf-ua=
pi
       empty structs may be marked as well but this does not have any rea=
l impact.
  (2). Only add aligned(8) if the struct having 'bpf_' prefix. Similar to=
 (1),
       the action is controlled with an option in 'btf_dump_opts'.

Also, not sure whether adding an option in 'btf_dump_opts' is the best so=
lution
or not. Another possibility is to add an option to btf_dump__dump_type() =
with
a different function name, e.g., btf_dump__dump_type_opts() but it makes =
the
function is not consistent with btf_dump__emit_type_decl().

So send this patch as RFC due to above different implementation choices.

  [1] https://lore.kernel.org/bpf/1b100f73-7625-4c1f-3ae5-50ecf84d3ff0@li=
nux.dev/

Cc: Vadim Fedorenko <vadfed@meta.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/bpf/bpftool/btf.c  | 5 ++++-
 tools/lib/bpf/btf.h      | 7 ++++++-
 tools/lib/bpf/btf_dump.c | 7 ++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..c9061d476f7d 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -463,10 +463,13 @@ static void __printf(2, 0) btf_dump_printf(void *ct=
x,
 static int dump_btf_c(const struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt)
 {
+	LIBBPF_OPTS(btf_dump_opts, opts,
+		.empty_struct_align8 =3D true,
+	);
 	struct btf_dump *d;
 	int err =3D 0, i;
=20
-	d =3D btf_dump__new(btf, btf_dump_printf, NULL, NULL);
+	d =3D btf_dump__new(btf, btf_dump_printf, NULL, &opts);
 	if (!d)
 		return -errno;
=20
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d91c84..af88563fe0ff 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -235,8 +235,13 @@ struct btf_dump;
=20
 struct btf_dump_opts {
 	size_t sz;
+	/* emit '__attribute__((aligned(8)))' for empty struct, i.e.,
+	 * the struct has no named member.
+	 */
+	bool empty_struct_align8;
+	size_t :0;
 };
-#define btf_dump_opts__last_field sz
+#define btf_dump_opts__last_field empty_struct_align8
=20
 typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list=
 args);
=20
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 4d9f30bf7f01..fe386d20a43a 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -83,6 +83,7 @@ struct btf_dump {
 	int ptr_sz;
 	bool strip_mods;
 	bool skip_anon_defs;
+	bool empty_struct_align8;
 	int last_id;
=20
 	/* per-type auxiliary state */
@@ -167,6 +168,7 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 	d->printf_fn =3D printf_fn;
 	d->cb_ctx =3D ctx;
 	d->ptr_sz =3D btf__pointer_size(btf) ? : sizeof(void *);
+	d->empty_struct_align8 =3D OPTS_GET(opts, empty_struct_align8, false);
=20
 	d->type_names =3D hashmap__new(str_hash_fn, str_equal_fn, NULL);
 	if (IS_ERR(d->type_names)) {
@@ -808,7 +810,10 @@ static void btf_dump_emit_type(struct btf_dump *d, _=
_u32 id, __u32 cont_id)
=20
 		if (top_level_def) {
 			btf_dump_emit_struct_def(d, id, t, 0);
-			btf_dump_printf(d, ";\n\n");
+			if (kind =3D=3D BTF_KIND_UNION || btf_vlen(t) || !d->empty_struct_ali=
gn8)
+				btf_dump_printf(d, ";\n\n");
+			else
+				btf_dump_printf(d, " __attribute__((aligned(8)));\n\n");
 			tstate->emit_state =3D EMITTED;
 		} else {
 			tstate->emit_state =3D NOT_EMITTED;
--=20
2.34.1


