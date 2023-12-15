Return-Path: <bpf+bounces-17909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB1813E9B
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D081C2202D
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F381853A2;
	Fri, 15 Dec 2023 00:14:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0435382
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id C6EC62B862783; Thu, 14 Dec 2023 16:11:58 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH bpf-next v2 1/6] bpf: Refactor to have a memalloc cache destroying function
Date: Thu, 14 Dec 2023 16:11:58 -0800
Message-Id: <20231215001158.3251863-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215001152.3249146-1-yonghong.song@linux.dev>
References: <20231215001152.3249146-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function, named as bpf_mem_alloc_destroy_cache(), will be used
in the subsequent patch.

Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/memalloc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 6a51cfe4c2d6..75068167e745 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -618,6 +618,13 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 	free_all(llist_del_all(&c->waiting_for_gp), percpu);
 }
=20
+static void bpf_mem_alloc_destroy_cache(struct bpf_mem_cache *c)
+{
+	WRITE_ONCE(c->draining, true);
+	irq_work_sync(&c->refill_work);
+	drain_mem_cache(c);
+}
+
 static void check_mem_cache(struct bpf_mem_cache *c)
 {
 	WARN_ON_ONCE(!llist_empty(&c->free_by_rcu_ttrace));
@@ -723,9 +730,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 		rcu_in_progress =3D 0;
 		for_each_possible_cpu(cpu) {
 			c =3D per_cpu_ptr(ma->cache, cpu);
-			WRITE_ONCE(c->draining, true);
-			irq_work_sync(&c->refill_work);
-			drain_mem_cache(c);
+			bpf_mem_alloc_destroy_cache(c);
 			rcu_in_progress +=3D atomic_read(&c->call_rcu_ttrace_in_progress);
 			rcu_in_progress +=3D atomic_read(&c->call_rcu_in_progress);
 		}
@@ -740,9 +745,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			cc =3D per_cpu_ptr(ma->caches, cpu);
 			for (i =3D 0; i < NUM_CACHES; i++) {
 				c =3D &cc->cache[i];
-				WRITE_ONCE(c->draining, true);
-				irq_work_sync(&c->refill_work);
-				drain_mem_cache(c);
+				bpf_mem_alloc_destroy_cache(c);
 				rcu_in_progress +=3D atomic_read(&c->call_rcu_ttrace_in_progress);
 				rcu_in_progress +=3D atomic_read(&c->call_rcu_in_progress);
 			}
--=20
2.34.1


