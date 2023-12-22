Return-Path: <bpf+bounces-18588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A6681C35A
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 04:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049EA1C2453E
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 03:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF305139D;
	Fri, 22 Dec 2023 03:18:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A7ECA
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 03:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id DAB1A2BD9948F; Thu, 21 Dec 2023 19:18:12 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH bpf-next v6 8/8] selftests/bpf: Add a selftest with > 512-byte percpu allocation size
Date: Thu, 21 Dec 2023 19:18:12 -0800
Message-Id: <20231222031812.1293190-1-yonghong.song@linux.dev>
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

Add a selftest to capture the verification failure when the allocation
size is greater than 512.

Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/progs/percpu_alloc_fail.c    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tool=
s/testing/selftests/bpf/progs/percpu_alloc_fail.c
index 1a891d30f1fe..f2b8eb2ff76f 100644
--- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
+++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
@@ -17,6 +17,10 @@ struct val_with_rb_root_t {
 	struct bpf_spin_lock lock;
 };
=20
+struct val_600b_t {
+	char b[600];
+};
+
 struct elem {
 	long sum;
 	struct val_t __percpu_kptr *pc;
@@ -161,4 +165,18 @@ int BPF_PROG(test_array_map_7)
 	return 0;
 }
=20
+SEC("?fentry.s/bpf_fentry_test1")
+__failure __msg("bpf_percpu_obj_new type size (600) is greater than 512"=
)
+int BPF_PROG(test_array_map_8)
+{
+	struct val_600b_t __percpu_kptr *p;
+
+	p =3D bpf_percpu_obj_new(struct val_600b_t);
+	if (!p)
+		return 0;
+
+	bpf_percpu_obj_drop(p);
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.34.1


