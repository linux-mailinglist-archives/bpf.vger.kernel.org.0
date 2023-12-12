Return-Path: <bpf+bounces-17600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9241180FA4E
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5DB2824C5
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 22:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3939BD29F;
	Tue, 12 Dec 2023 22:31:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8725DC
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 14:31:08 -0800 (PST)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 9F2422B68D7A0; Tue, 12 Dec 2023 14:30:55 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 3/5] bpf: Refill only one percpu element in memalloc
Date: Tue, 12 Dec 2023 14:30:55 -0800
Message-Id: <20231212223055.2138132-1-yonghong.song@linux.dev>
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

Typically for percpu map element or data structure, once allocated,
most operations are lookup or in-place update. Deletion are really
rare. Currently, for percpu data strcture, 4 elements will be
refilled if the size is <=3D 256. Let us just do with one element
for percpu data. For example, for size 256 and 128 cpus, the
potential saving will be 3 * 256 * 128 * 128 =3D 12MB.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/memalloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 84987e97fd0a..a1d718ee264d 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -483,11 +483,15 @@ static void init_refill_work(struct bpf_mem_cache *=
c)
=20
 static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 {
+	int cnt =3D 1;
+
 	/* To avoid consuming memory assume that 1st run of bpf
 	 * prog won't be doing more than 4 map_update_elem from
 	 * irq disabled region
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


