Return-Path: <bpf+bounces-8686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2C6788F6A
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 21:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A931C20F91
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DEC19386;
	Fri, 25 Aug 2023 19:53:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B0F322B
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 19:53:48 +0000 (UTC)
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04D72690
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 12:53:46 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 4F5AD25659FAA; Fri, 25 Aug 2023 12:53:33 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 01/13] bpf: Add support for non-fix-size percpu mem allocation
Date: Fri, 25 Aug 2023 12:53:33 -0700
Message-Id: <20230825195333.92519-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825195328.92126-1-yonghong.song@linux.dev>
References: <20230825195328.92126-1-yonghong.song@linux.dev>
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

This is needed for later percpu mem allocation when the
allocation is done by bpf program. For such cases, a global
bpf_global_percpu_ma is added where a flexible allocation
size is needed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  4 ++--
 kernel/bpf/core.c     |  8 +++++---
 kernel/bpf/memalloc.c | 14 ++++++--------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 12596af59c00..144dbddf53bd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -55,8 +55,8 @@ struct cgroup;
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
 extern struct kobject *btf_kobj;
-extern struct bpf_mem_alloc bpf_global_ma;
-extern bool bpf_global_ma_set;
+extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
+extern bool bpf_global_ma_set, bpf_global_percpu_ma_set;
=20
 typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0f8f036d8bd1..95599df82ee4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -64,8 +64,8 @@
 #define OFF	insn->off
 #define IMM	insn->imm
=20
-struct bpf_mem_alloc bpf_global_ma;
-bool bpf_global_ma_set;
+struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
+bool bpf_global_ma_set, bpf_global_percpu_ma_set;
=20
 /* No hurry in this branch
  *
@@ -2921,7 +2921,9 @@ static int __init bpf_global_ma_init(void)
=20
 	ret =3D bpf_mem_alloc_init(&bpf_global_ma, 0, false);
 	bpf_global_ma_set =3D !ret;
-	return ret;
+	ret =3D bpf_mem_alloc_init(&bpf_global_percpu_ma, 0, true);
+	bpf_global_percpu_ma_set =3D !ret;
+	return !bpf_global_ma_set || !bpf_global_percpu_ma_set;
 }
 late_initcall(bpf_global_ma_init);
 #endif
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 9c49ae53deaf..cb60445de98a 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -499,15 +499,16 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, in=
t size, bool percpu)
 	struct obj_cgroup *objcg =3D NULL;
 	int cpu, i, unit_size, percpu_size =3D 0;
=20
+	/* room for llist_node and per-cpu pointer */
+	if (percpu)
+		percpu_size =3D LLIST_NODE_SZ + sizeof(void *);
+
 	if (size) {
 		pc =3D __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
 		if (!pc)
 			return -ENOMEM;
=20
-		if (percpu)
-			/* room for llist_node and per-cpu pointer */
-			percpu_size =3D LLIST_NODE_SZ + sizeof(void *);
-		else
+		if (!percpu)
 			size +=3D LLIST_NODE_SZ; /* room for llist_node */
 		unit_size =3D size;
=20
@@ -527,10 +528,6 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int=
 size, bool percpu)
 		return 0;
 	}
=20
-	/* size =3D=3D 0 && percpu is an invalid combination */
-	if (WARN_ON_ONCE(percpu))
-		return -EINVAL;
-
 	pcc =3D __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL);
 	if (!pcc)
 		return -ENOMEM;
@@ -543,6 +540,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int =
size, bool percpu)
 			c =3D &cc->cache[i];
 			c->unit_size =3D sizes[i];
 			c->objcg =3D objcg;
+			c->percpu_size =3D percpu_size;
 			c->tgt =3D c;
 			prefill_mem_cache(c, cpu);
 		}
--=20
2.34.1


