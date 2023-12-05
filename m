Return-Path: <bpf+bounces-16707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 674C88049B5
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 07:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDE9B20C62
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 06:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AE3D536;
	Tue,  5 Dec 2023 06:05:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9504C11F
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 22:05:08 -0800 (PST)
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 6FD362AFE0AC8; Mon,  4 Dec 2023 22:04:55 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Fix flaky test_btf_id test
Date: Mon,  4 Dec 2023 22:04:55 -0800
Message-Id: <20231205060455.3577644-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205060450.3577161-1-yonghong.song@linux.dev>
References: <20231205060450.3577161-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With previous patch, one of subtests in test_btf_id becomes
flaky and may fail. The following is a failing example:

  Error: #26 btf
  Error: #26/174 btf/BTF ID
    Error: #26/174 btf/BTF ID
    btf_raw_create:PASS:check 0 nsec
    btf_raw_create:PASS:check 0 nsec
    test_btf_id:PASS:check 0 nsec
    ...
    test_btf_id:PASS:check 0 nsec
    test_btf_id:FAIL:check BTF lingersdo_test_get_info:FAIL:check failed:=
 -1

The test tries to prove a btf_id not available after the map is closed.
But btf_id is freed only after workqueue and a rcu grace period, compared
to previous case just after a rcu grade period.

To fix the flaky test, I added a kern_sync_rcu() after closing map and
before querying btf id availability, essentially ensuring a rcu grace
period in the kernel, which seems making the test happy.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index 8fb4a04fbbc0..7feb4223bbac 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4629,6 +4629,7 @@ static int test_btf_id(unsigned int test_num)
=20
 	/* The map holds the last ref to BTF and its btf_id */
 	close(map_fd);
+	kern_sync_rcu();
 	map_fd =3D -1;
 	btf_fd[0] =3D bpf_btf_get_fd_by_id(map_info.btf_id);
 	if (CHECK(btf_fd[0] >=3D 0, "BTF lingers")) {
--=20
2.34.1


