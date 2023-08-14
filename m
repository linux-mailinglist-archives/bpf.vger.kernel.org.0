Return-Path: <bpf+bounces-7757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213D977BF03
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF194280E5D
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A39CA63;
	Mon, 14 Aug 2023 17:29:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CAC2FF
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:29:40 +0000 (UTC)
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7C81726
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 10:29:36 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id ACF0F24C22195; Mon, 14 Aug 2023 10:29:28 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 15/15] bpf: Mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated
Date: Mon, 14 Aug 2023 10:29:28 -0700
Message-Id: <20230814172928.1373311-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814172809.1361446-1-yonghong.song@linux.dev>
References: <20230814172809.1361446-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP,UPPERCASE_50_75 autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now 'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE + local percpu ptr'
can cover all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE functionality
and more. So mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/uapi/linux/bpf.h       | 9 ++++++++-
 tools/include/uapi/linux/bpf.h | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d21deb46f49f..5d1bb6b42ea2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -932,7 +932,14 @@ enum bpf_map_type {
 	 */
 	BPF_MAP_TYPE_CGROUP_STORAGE =3D BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
-	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
+	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
+	/* BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE is available to bpf programs
+	 * attaching to a cgroup. The new mechanism (BPF_MAP_TYPE_CGRP_STORAGE =
+
+	 * local percpu kptr) supports all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
+	 * functionality and more. So mark * BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
+	 * deprecated.
+	 */
+	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE =3D BPF_MAP_TYPE_PERCPU_CGROUP_STORA=
GE_DEPRECATED,
 	BPF_MAP_TYPE_QUEUE,
 	BPF_MAP_TYPE_STACK,
 	BPF_MAP_TYPE_SK_STORAGE,
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index d21deb46f49f..5d1bb6b42ea2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -932,7 +932,14 @@ enum bpf_map_type {
 	 */
 	BPF_MAP_TYPE_CGROUP_STORAGE =3D BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
-	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
+	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED,
+	/* BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE is available to bpf programs
+	 * attaching to a cgroup. The new mechanism (BPF_MAP_TYPE_CGRP_STORAGE =
+
+	 * local percpu kptr) supports all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
+	 * functionality and more. So mark * BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
+	 * deprecated.
+	 */
+	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE =3D BPF_MAP_TYPE_PERCPU_CGROUP_STORA=
GE_DEPRECATED,
 	BPF_MAP_TYPE_QUEUE,
 	BPF_MAP_TYPE_STACK,
 	BPF_MAP_TYPE_SK_STORAGE,
--=20
2.34.1


