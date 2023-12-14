Return-Path: <bpf+bounces-17876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92F0813BA2
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 21:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50EAEB21DA0
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 20:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CE079E08;
	Thu, 14 Dec 2023 20:38:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B16A35D
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id A31BB2B83FEE5; Thu, 14 Dec 2023 12:38:20 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v6 2/2] selftests/bpf: Remove flaky test_btf_id test
Date: Thu, 14 Dec 2023 12:38:20 -0800
Message-Id: <20231214203820.1469402-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214203815.1469107-1-yonghong.song@linux.dev>
References: <20231214203815.1469107-1-yonghong.song@linux.dev>
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
Depending on system workload, workqueue could take quite some time
to execute function bpf_map_free_deferred() which may cause the test fail=
ure.
Instead of adding arbitrary delays, let us remove the logic to
check btf_id availability after map is closed.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
index 8fb4a04fbbc0..816145bcb647 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4630,11 +4630,6 @@ static int test_btf_id(unsigned int test_num)
 	/* The map holds the last ref to BTF and its btf_id */
 	close(map_fd);
 	map_fd =3D -1;
-	btf_fd[0] =3D bpf_btf_get_fd_by_id(map_info.btf_id);
-	if (CHECK(btf_fd[0] >=3D 0, "BTF lingers")) {
-		err =3D -1;
-		goto done;
-	}
=20
 	fprintf(stderr, "OK");
=20
--=20
2.34.1


