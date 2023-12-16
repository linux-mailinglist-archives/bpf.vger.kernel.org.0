Return-Path: <bpf+bounces-18068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6A5815667
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 03:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA610B24612
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 02:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AAB1875;
	Sat, 16 Dec 2023 02:30:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A3525C
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 9AD6F2B958488; Fri, 15 Dec 2023 18:30:20 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 3/6] bpf: Refill only one percpu element in memalloc
Date: Fri, 15 Dec 2023 18:30:20 -0800
Message-Id: <20231216023020.3741548-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231216023004.3738749-1-yonghong.song@linux.dev>
References: <20231216023004.3738749-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Typically for percpu map element or data structure, once allocated,
most operations are lookup or in-place update. Deletion are really
rare. Currently, for percpu data strcture, 4 elements will be
refilled if the size is <=3D 256. Let us just do with one element
for percpu data. For example, for size 256 and 128 cpus, the
potential saving will be 3 * 256 * 128 * 128 =3D 12MB.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/memalloc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 30e347fccc6a..5cf2738c20a9 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -485,11 +485,16 @@ static void init_refill_work(struct bpf_mem_cache *=
c)
=20
 static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 {
-	/* To avoid consuming memory assume that 1st run of bpf
-	 * prog won't be doing more than 4 map_update_elem from
-	 * irq disabled region
+	int cnt =3D 1;
+
+	/* To avoid consuming memory, for non-percpu allocation, assume that
+	 * 1st run of bpf prog won't be doing more than 4 map_update_elem from
+	 * irq disabled region if unit size is less than or equal to 256.
+	 * For all other cases, let us just do one allocation.
 	 */
-	alloc_bulk(c, c->unit_size <=3D 256 ? 4 : 1, cpu_to_node(cpu), false);
+	if (!c->percpu_size && c->unit_size <=3D 256)
+		cnt =3D 4;
+	alloc_bulk(c, cnt, cpu_to_node(cpu), false);
 }
=20
 static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
--=20
2.34.1


