Return-Path: <bpf+bounces-18585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010DD81C357
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 04:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E5E285E18
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 03:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E88186C;
	Fri, 22 Dec 2023 03:18:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0210EA
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 891BF2BD993B5; Thu, 21 Dec 2023 19:17:55 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 5/8] bpf: Use smaller low/high marks for percpu allocation
Date: Thu, 21 Dec 2023 19:17:55 -0800
Message-Id: <20231222031755.1289671-1-yonghong.song@linux.dev>
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

Currently, refill low/high marks are set with the assumption
of normal non-percpu memory allocation. For example, for
an allocation size 256, for non-percpu memory allocation,
low mark is 32 and high mark is 96, resulting in the
batch allocation of 48 elements and the allocated memory
will be 48 * 256 =3D 12KB for this particular cpu.
Assuming an 128-cpu system, the total memory consumption
across all cpus will be 12K * 128 =3D 1.5MB memory.

This might be okay for non-percpu allocation, but may not be
good for percpu allocation, which will consume 1.5MB * 128 =3D 192MB
memory in the worst case if every cpu has a chance of memory
allocation.

In practice, percpu allocation is very rare compared to
non-percpu allocation. So let us have smaller low/high marks
which can avoid unnecessary memory consumption.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/memalloc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index a8ee6fb8401c..460c8f38fed6 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -464,11 +464,17 @@ static void notrace irq_work_raise(struct bpf_mem_c=
ache *c)
  * consume ~ 11 Kbyte per cpu.
  * Typical case will be between 11K and 116K closer to 11K.
  * bpf progs can and should share bpf_mem_cache when possible.
+ *
+ * Percpu allocation is typically rare. To avoid potential unnecessary l=
arge
+ * memory consumption, set low_mark =3D 1 and high_mark =3D 3, resulting=
 in c->batch =3D 1.
  */
 static void init_refill_work(struct bpf_mem_cache *c)
 {
 	init_irq_work(&c->refill_work, bpf_mem_refill);
-	if (c->unit_size <=3D 256) {
+	if (c->percpu_size) {
+		c->low_watermark =3D 1;
+		c->high_watermark =3D 3;
+	} else if (c->unit_size <=3D 256) {
 		c->low_watermark =3D 32;
 		c->high_watermark =3D 96;
 	} else {
--=20
2.34.1


