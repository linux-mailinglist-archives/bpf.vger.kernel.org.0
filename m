Return-Path: <bpf+bounces-17602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160AD80FA51
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 953CCB21016
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 22:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C363D67;
	Tue, 12 Dec 2023 22:33:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A09CE
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:33:25 -0800 (PST)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 08E792B68D7BB; Tue, 12 Dec 2023 14:31:00 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 4/5] bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
Date: Tue, 12 Dec 2023 14:31:00 -0800
Message-Id: <20231212223100.2138537-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212223040.2135547-1-yonghong.song@linux.dev>
References: <20231212223040.2135547-1-yonghong.song@linux.dev>
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

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0c55fe4451e1..e5cb6b7526b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -43,6 +43,8 @@ static const struct bpf_verifier_ops * const bpf_verifi=
er_ops[] =3D {
 };
=20
 struct bpf_mem_alloc bpf_global_percpu_ma;
+#define LLIST_NODE_SZ sizeof(struct llist_node)
+#define BPF_GLOBAL_PERCPU_MA_MAX_SIZE  (512 - LLIST_NODE_SZ)
=20
 /* bpf_check() is a static code analyzer that walks eBPF program
  * instruction by instruction and updates register/stack state.
@@ -12091,6 +12093,11 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
 				}
=20
 				if (meta.func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_new_imp=
l]) {
+					if (ret_t->size > BPF_GLOBAL_PERCPU_MA_MAX_SIZE) {
+						verbose(env, "bpf_percpu_obj_new type size (%d) is greater than %l=
u\n",
+							ret_t->size, BPF_GLOBAL_PERCPU_MA_MAX_SIZE);
+						return -EINVAL;
+					}
 					mutex_lock(&bpf_percpu_ma_lock);
 					err =3D bpf_mem_alloc_percpu_unit_init(&bpf_global_percpu_ma, ret_t=
->size);
 					mutex_unlock(&bpf_percpu_ma_lock);
--=20
2.34.1


