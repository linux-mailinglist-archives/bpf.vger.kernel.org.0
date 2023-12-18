Return-Path: <bpf+bounces-18167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C12816684
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 07:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B621F213DE
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 06:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659216FBD;
	Mon, 18 Dec 2023 06:30:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872746FB2
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id A409C2BB1F6CD; Sun, 17 Dec 2023 22:30:36 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH bpf-next v4 1/7] bpf: Avoid unnecessary extra percpu memory allocation
Date: Sun, 17 Dec 2023 22:30:36 -0800
Message-Id: <20231218063036.3039329-1-yonghong.song@linux.dev>
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

Currently, for percpu memory allocation, say if the user
requests allocation size to be 32 bytes, the actually
calculated size will be 40 bytes and it further rounds
to 64 bytes, and eventually 64 bytes are allocated,
wasting 32-byte memory.

Change bpf_mem_alloc() to calculate the cache index
based on the user-provided allocation size so unnecessary
extra memory can be avoided.

Suggested-by: Hou Tao <houtao1@huawei.com>
Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/memalloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 6a51cfe4c2d6..00e101c2a68b 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -871,7 +871,9 @@ void notrace *bpf_mem_alloc(struct bpf_mem_alloc *ma,=
 size_t size)
 	if (!size)
 		return ZERO_SIZE_PTR;
=20
-	idx =3D bpf_mem_cache_idx(size + LLIST_NODE_SZ);
+	if (!ma->percpu)
+		size +=3D LLIST_NODE_SZ;
+	idx =3D bpf_mem_cache_idx(size);
 	if (idx < 0)
 		return NULL;
=20
--=20
2.34.1


