Return-Path: <bpf+bounces-17906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9785F813E91
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF7D1C21FAC
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC071EC4;
	Fri, 15 Dec 2023 00:12:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D4EBC
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 4ED582B8627F3; Thu, 14 Dec 2023 16:12:15 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 4/6] bpf: Refill only one percpu element in memalloc
Date: Thu, 14 Dec 2023 16:12:15 -0800
Message-Id: <20231215001215.3253255-1-yonghong.song@linux.dev>
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
index aea4cd07c7b6..7b5bd1294b77 100644
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


