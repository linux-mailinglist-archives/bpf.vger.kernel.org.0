Return-Path: <bpf+bounces-8697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF23788F76
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 21:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F3228175F
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286FD193B9;
	Fri, 25 Aug 2023 19:54:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007F1322B
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 19:54:40 +0000 (UTC)
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4542689
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 12:54:39 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id E6CA22565A1D8; Fri, 25 Aug 2023 12:54:35 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 13/13] bpf: Mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated
Date: Fri, 25 Aug 2023 12:54:35 -0700
Message-Id: <20230825195435.99405-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825195328.92126-1-yonghong.song@linux.dev>
References: <20230825195328.92126-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_SOFTFAIL,
	TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now 'BPF_MAP_TYPE_CGRP_STORAGE + local percpu ptr'
can cover all BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE functionality
and more. So mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated.
Also make a change in selftests/bpf/test_bpftool_synctypes.py
to fix a test error.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/uapi/linux/bpf.h                              | 9 ++++++++-
 tools/include/uapi/linux/bpf.h                        | 9 ++++++++-
 tools/testing/selftests/bpf/test_bpftool_synctypes.py | 9 +++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8790b3962e4b..73b155e52204 100644
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
index 8790b3962e4b..73b155e52204 100644
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
diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tool=
s/testing/selftests/bpf/test_bpftool_synctypes.py
index 0cfece7ff4f8..0ed67b6b31dd 100755
--- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
+++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
@@ -509,6 +509,15 @@ def main():
     source_map_types.remove('cgroup_storage_deprecated')
     source_map_types.add('cgroup_storage')
=20
+    # The same applied to BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED =
and
+    # BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE which share the same enum value
+    # and source_map_types picks
+    # BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED/percpu_cgroup_storag=
e_deprecated.
+    # Replace 'percpu_cgroup_storage_deprecated' with 'percpu_cgroup_sto=
rage'
+    # so it aligns with what `bpftool map help` shows.
+    source_map_types.remove('percpu_cgroup_storage_deprecated')
+    source_map_types.add('percpu_cgroup_storage')
+
     help_map_types =3D map_info.get_map_help()
     help_map_options =3D map_info.get_options()
     map_info.close()
--=20
2.34.1


