Return-Path: <bpf+bounces-18582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA42B81C354
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 04:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488511F25982
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 03:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E8B10F0;
	Fri, 22 Dec 2023 03:17:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8101E184C
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 03:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 021E42BD99355; Thu, 21 Dec 2023 19:17:40 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH bpf-next v6 2/8] bpf: Add objcg to bpf_mem_alloc
Date: Thu, 21 Dec 2023 19:17:39 -0800
Message-Id: <20231222031739.1288590-1-yonghong.song@linux.dev>
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

The objcg is a bpf_mem_alloc level property since all bpf_mem_cache's
are with the same objcg. This patch made such a property explicit.
The next patch will use this property to save and restore objcg
for percpu unit allocator.

Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_mem_alloc.h |  1 +
 kernel/bpf/memalloc.c         | 11 ++++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.=
h
index bb1223b21308..acef8c808599 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -11,6 +11,7 @@ struct bpf_mem_caches;
 struct bpf_mem_alloc {
 	struct bpf_mem_caches __percpu *caches;
 	struct bpf_mem_cache __percpu *cache;
+	struct obj_cgroup *objcg;
 	bool percpu;
 	struct work_struct work;
 };
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 288ec4a967d0..4a21050f0359 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -523,6 +523,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int =
size, bool percpu)
 		if (memcg_bpf_enabled())
 			objcg =3D get_obj_cgroup_from_current();
 #endif
+		ma->objcg =3D objcg;
 		for_each_possible_cpu(cpu) {
 			c =3D per_cpu_ptr(pc, cpu);
 			c->unit_size =3D unit_size;
@@ -542,6 +543,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int =
size, bool percpu)
 #ifdef CONFIG_MEMCG_KMEM
 	objcg =3D get_obj_cgroup_from_current();
 #endif
+	ma->objcg =3D objcg;
 	for_each_possible_cpu(cpu) {
 		cc =3D per_cpu_ptr(pcc, cpu);
 		for (i =3D 0; i < NUM_CACHES; i++) {
@@ -691,9 +693,8 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			rcu_in_progress +=3D atomic_read(&c->call_rcu_ttrace_in_progress);
 			rcu_in_progress +=3D atomic_read(&c->call_rcu_in_progress);
 		}
-		/* objcg is the same across cpus */
-		if (c->objcg)
-			obj_cgroup_put(c->objcg);
+		if (ma->objcg)
+			obj_cgroup_put(ma->objcg);
 		destroy_mem_alloc(ma, rcu_in_progress);
 	}
 	if (ma->caches) {
@@ -709,8 +710,8 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 				rcu_in_progress +=3D atomic_read(&c->call_rcu_in_progress);
 			}
 		}
-		if (c->objcg)
-			obj_cgroup_put(c->objcg);
+		if (ma->objcg)
+			obj_cgroup_put(ma->objcg);
 		destroy_mem_alloc(ma, rcu_in_progress);
 	}
 }
--=20
2.34.1


