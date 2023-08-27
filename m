Return-Path: <bpf+bounces-8791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB21789FD7
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 17:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8431F1C208C6
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B2910967;
	Sun, 27 Aug 2023 15:06:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21CF7EE
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 15:06:07 +0000 (UTC)
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182A110F
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 08:06:05 -0700 (PDT)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 7C895257E9A9C; Sun, 27 Aug 2023 08:05:51 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf] selftests/bpf: Fix flaky cgroup_iter_sleepable subtest
Date: Sun, 27 Aug 2023 08:05:51 -0700
Message-Id: <20230827150551.1743497-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
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

Occasionally, with './test_progs -j' on my vm, I will hit the
following failure:
  test_cgrp_local_storage:PASS:join_cgroup /cgrp_local_storage 0 nsec
  test_cgroup_iter_sleepable:PASS:skel_open 0 nsec
  test_cgroup_iter_sleepable:PASS:skel_load 0 nsec
  test_cgroup_iter_sleepable:PASS:attach_iter 0 nsec
  test_cgroup_iter_sleepable:PASS:iter_create 0 nsec
  test_cgroup_iter_sleepable:FAIL:cgroup_id unexpected cgroup_id: actual =
1 !=3D expected 2812
  #48/5    cgrp_local_storage/cgroup_iter_sleepable:FAIL
  #48      cgrp_local_storage:FAIL

Finally, I decided to do some investigation since the test is introduced
by myself. It turns out the reason is due to cgroup_fd with value 0.
In cgroup_iter, a cgroup_fd of value 0 means the root cgroup.
	/* from cgroup_iter.c */
        if (fd)
                cgrp =3D cgroup_v1v2_get_from_fd(fd);
        else if (id)
                cgrp =3D cgroup_get_from_id(id);
        else /* walk the entire hierarchy by default. */
                cgrp =3D cgroup_get_from_path("/");
That is why we got cgroup_id 1 instead of expected 2812.

Why we got a cgroup_fd 0? Nobody should really touch 'stdin' (fd 0) in te=
st_progs.
I traced 'close' syscall with stack trace and found the root cause,
which is a bug in bpf_obj_pinning.c. Basically, the code closed fd 0
although it should not. Fixing the bug in bpf_obj_pinning.c
also resolved the above cgroup_iter_sleepable subtest failure.

Fixes: 3b22f98e5a05 ("selftests/bpf: Add path_fd-based BPF_OBJ_PIN and BP=
F_OBJ_GET tests")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c b/t=
ools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
index 31f1e815f671..ee0458a5ce78 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_pinning.c
@@ -8,6 +8,7 @@
 #include <linux/unistd.h>
 #include <linux/mount.h>
 #include <sys/syscall.h>
+#include "bpf/libbpf_internal.h"
=20
 static inline int sys_fsopen(const char *fsname, unsigned flags)
 {
@@ -155,7 +156,7 @@ static void validate_pin(int map_fd, const char *map_=
name, int src_value,
 	ASSERT_OK(err, "obj_pin");
=20
 	/* cleanup */
-	if (pin_opts.path_fd >=3D 0)
+	if (path_kind =3D=3D PATH_FD_REL && pin_opts.path_fd >=3D 0)
 		close(pin_opts.path_fd);
 	if (old_cwd[0])
 		ASSERT_OK(chdir(old_cwd), "restore_cwd");
@@ -220,7 +221,7 @@ static void validate_get(int map_fd, const char *map_=
name, int src_value,
 		goto cleanup;
=20
 	/* cleanup */
-	if (get_opts.path_fd >=3D 0)
+	if (path_kind =3D=3D PATH_FD_REL && get_opts.path_fd >=3D 0)
 		close(get_opts.path_fd);
 	if (old_cwd[0])
 		ASSERT_OK(chdir(old_cwd), "restore_cwd");
--=20
2.34.1


