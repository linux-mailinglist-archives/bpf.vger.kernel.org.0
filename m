Return-Path: <bpf+bounces-18166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B627B816683
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 07:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97C91C20B68
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 06:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7AF6FB5;
	Mon, 18 Dec 2023 06:30:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CDC6FA3
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 06:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 1CA462BB1F6E3; Sun, 17 Dec 2023 22:30:41 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 2/7] bpf: Add objcg to bpf_mem_alloc
Date: Sun, 17 Dec 2023 22:30:41 -0800
Message-Id: <20231218063041.3039560-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218063031.3037929-1-yonghong.song@linux.dev>
References: <20231218063031.3037929-1-yonghong.song@linux.dev>
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
index 00e101c2a68b..dfde9d9a3e1d 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -544,6 +544,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int =
size, bool percpu)
 		if (memcg_bpf_enabled())
 			objcg =3D get_obj_cgroup_from_current();
 #endif
+		ma->objcg =3D objcg;
 		for_each_possible_cpu(cpu) {
 			c =3D per_cpu_ptr(pc, cpu);
 			c->unit_size =3D unit_size;
@@ -564,6 +565,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int =
size, bool percpu)
 #ifdef CONFIG_MEMCG_KMEM
 	objcg =3D get_obj_cgroup_from_current();
 #endif
+	ma->objcg =3D objcg;
 	for_each_possible_cpu(cpu) {
 		cc =3D per_cpu_ptr(pcc, cpu);
 		for (i =3D 0; i < NUM_CACHES; i++) {
@@ -729,9 +731,8 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
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
@@ -747,8 +748,8 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
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


