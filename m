Return-Path: <bpf+bounces-18586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D5481C358
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 04:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECC3285E9A
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 03:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F224A15A7;
	Fri, 22 Dec 2023 03:18:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B99910EA
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 8C0472BD993DE; Thu, 21 Dec 2023 19:18:01 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH bpf-next v6 6/8] bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
Date: Thu, 21 Dec 2023 19:18:01 -0800
Message-Id: <20231222031801.1290841-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222031729.1287957-1-yonghong.song@linux.dev>
References: <20231222031729.1287957-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For percpu data structure allocation with bpf_global_percpu_ma,
the maximum data size is 4K. But for a system with large
number of cpus, bigger data size (e.g., 2K, 4K) might consume
a lot of memory. For example, the percpu memory consumption
with unit size 2K and 1024 cpus will be 2K * 1K * 1k =3D 2GB
memory.

We should discourage such usage. Let us limit the maximum data
size to be 512 for bpf_global_percpu_ma allocation.

Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5b2bfa2cbb7b..6c02905c8700 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -195,6 +195,8 @@ struct bpf_verifier_stack_elem {
 					  POISON_POINTER_DELTA))
 #define BPF_MAP_PTR(X)		((struct bpf_map *)((X) & ~BPF_MAP_PTR_UNPRIV))
=20
+#define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  512
+
 static int acquire_reference_state(struct bpf_verifier_env *env, int ins=
n_idx);
 static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
@@ -12162,6 +12164,12 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 				}
=20
 				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l]) {
+					if (ret_t->size > BPF_GLOBAL_PERCPU_MA_MAX_SIZE) {
+						verbose(env, "bpf_percpu_obj_new type size (%d) is greater than %d=
\n",
+							ret_t->size, BPF_GLOBAL_PERCPU_MA_MAX_SIZE);
+						return -EINVAL;
+					}
+
 					if (!bpf_global_percpu_ma_set) {
 						mutex_lock(&bpf_percpu_ma_lock);
 						if (!bpf_global_percpu_ma_set) {
--=20
2.34.1


