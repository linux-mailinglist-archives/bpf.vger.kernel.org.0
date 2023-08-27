Return-Path: <bpf+bounces-8800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CFC789FF1
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 17:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C137B280F7E
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA9E11199;
	Sun, 27 Aug 2023 15:28:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E647EE
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 15:28:22 +0000 (UTC)
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30A2EC
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 08:28:20 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 5BF14257ECF93; Sun, 27 Aug 2023 08:28:05 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 07/13] selftests/bpf: Add bpf_percpu_obj_{new,drop}() macro in bpf_experimental.h
Date: Sun, 27 Aug 2023 08:28:05 -0700
Message-Id: <20230827152805.1999417-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827152729.1995219-1-yonghong.song@linux.dev>
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The new macro bpf_percpu_obj_{new/drop}() is very similar to bpf_obj_{new=
,drop}()
as they both take a type as the argument.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
index 209811b1993a..4494eaa9937e 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -131,4 +131,35 @@ extern int bpf_rbtree_add_impl(struct bpf_rb_root *r=
oot, struct bpf_rb_node *nod
  */
 extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __=
ksym;
=20
+/* Description
+ *	Allocates a percpu object of the type represented by 'local_type_id' =
in
+ *	program BTF. User may use the bpf_core_type_id_local macro to pass th=
e
+ *	type ID of a struct in program BTF.
+ *
+ *	The 'local_type_id' parameter must be a known constant.
+ *	The 'meta' parameter is rewritten by the verifier, no need for BPF
+ *	program to set it.
+ * Returns
+ *	A pointer to a percpu object of the type corresponding to the passed =
in
+ *	'local_type_id', or NULL on failure.
+ */
+extern void *bpf_percpu_obj_new_impl(__u64 local_type_id, void *meta) __=
ksym;
+
+/* Convenience macro to wrap over bpf_percpu_obj_new_impl */
+#define bpf_percpu_obj_new(type) ((type __percpu_kptr *)bpf_percpu_obj_n=
ew_impl(bpf_core_type_id_local(type), NULL))
+
+/* Description
+ *	Free an allocated percpu object. All fields of the object that requir=
e
+ *	destruction will be destructed before the storage is freed.
+ *
+ *	The 'meta' parameter is rewritten by the verifier, no need for BPF
+ *	program to set it.
+ * Returns
+ *	Void.
+ */
+extern void bpf_percpu_obj_drop_impl(void *kptr, void *meta) __ksym;
+
+/* Convenience macro to wrap over bpf_obj_drop_impl */
+#define bpf_percpu_obj_drop(kptr) bpf_percpu_obj_drop_impl(kptr, NULL)
+
 #endif
--=20
2.34.1


