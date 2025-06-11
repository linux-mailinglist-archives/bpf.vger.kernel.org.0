Return-Path: <bpf+bounces-60344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58564AD5BF7
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02F816284F
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EBB1F0985;
	Wed, 11 Jun 2025 16:21:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183B41E835B
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658879; cv=none; b=gARn8fKNzRrvh/As0FmDkAzSTpB/GjQX6CgxGB27ldGUhTiNWOMWrHy2Zp/0m0mhJEjfNTdeINeAgKguUfy4Ps6bwZjAGeVJEHaTQJ6bmtULHJX+3Xf3E/zBHIfFDuMGkOEr0FuKA3hgjsaqobhGDP6ZF7tdX7v3DwRo4f75g3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658879; c=relaxed/simple;
	bh=1OsWRhDhAEvlL0mXhjUp3ncZ2EkaocKJbKwS9AU+JIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eii16wcqT1lGSd6dbgFJgEMZXYqdyLPaP/9J5U3E8bQzFLOXWh7Xx79AMiMHuEthQFIVWIzKJEGEvPVmYRaiOkdcaEhpPgFY8j8hpHe/ghSeI6AIggaV2RMmw7PUSD0ldAdxTT1zYYxdNA7Krw7fGS8BjVrdAQ49INY1qQpYiTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B485396768CC; Wed, 11 Jun 2025 09:21:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix cgroup_mprog_ordering failure due to uninitialized variable
Date: Wed, 11 Jun 2025 09:21:03 -0700
Message-ID: <20250611162103.1623692-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On arm64, the cgroup_mprog_ordering selftest failed with test_progs run
when building with clang compiler. The reason is due to socklen_t optlen
not initialized.

In kernel function do_ip_getsockopt(), we have

        if (copy_from_sockptr(&len, optlen, sizeof(int)))
                return -EFAULT;
        if (len < 0)
                return -EINVAL;

The above 'len' variable is a negative value and hence the test failed.

But the test is okay on x86_64. I checked the x86_64 asm code and I didn'=
t
see explicit initialization of 'optlen' but its value is 0 so kernel
didn't return error. This should be a pure luck.

Fix the bug by initializing 'oplen' var properly.

Fixes: e422d5f118e4 ("selftests/bpf: Add two selftests for mprog API base=
d cgroup progs")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_mprog_ordering.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_ordering=
.c b/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_ordering.c
index 4a4e9710b474..a36d2e968bc5 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_ordering.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_mprog_ordering.c
@@ -12,7 +12,7 @@ static int run_getsockopt_test(int cg_parent, int sock_=
fd, bool has_relative_fd)
 	struct cgroup_preorder *skel =3D NULL;
 	struct bpf_program *prog;
 	__u8 *result, buf;
-	socklen_t optlen;
+	socklen_t optlen =3D 1;
 	int err =3D 0;
=20
 	skel =3D cgroup_preorder__open_and_load();
--=20
2.47.1


