Return-Path: <bpf+bounces-64325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 396CBB11776
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 06:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11818AC8730
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 04:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393A523E320;
	Fri, 25 Jul 2025 04:34:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D7235044
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 04:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753418083; cv=none; b=GanHG+HgAQPp4p7cGQ9XGkjLtQU7aK5Trfm9FERu+Fs0l6QuTbx0al4ug/UsrDzxDNwrxHjJ+iFeFJQngdrN7hq0Mz2xKvkkpQSSkR8uVx0gByRiNCBA7ySVoh4+1w+QYC4SAkm40ZIG6QIrJlw2J3O+KIA8/WMmJv0trgQwGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753418083; c=relaxed/simple;
	bh=hvsSAh5lheWaC2g83RAeeU8dnR2ZWaZQiXWVVgTg8Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hixWqPud88iXzhmGZphoL6fL/PKF9e2xUJTKn3uFKXDVjKfMo/zu54W5S5p8Qm2/mK7tal0y3H8rITsUHJIlVJmqMZF1Sbo6YARrg9+MtGgMWcCnHuh/O3FpLkY9vRzsQSgtLJMDyT+DZWyDrm6ETGf6D8z94rbarj0ga7y+gAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6DE80C48A501; Thu, 24 Jul 2025 21:34:30 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 1/3] selftests/bpf: Increase xdp data size for arm64 64K page size
Date: Thu, 24 Jul 2025 21:34:30 -0700
Message-ID: <20250725043430.208469-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250725043425.208128-1-yonghong.song@linux.dev>
References: <20250725043425.208128-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With arm64 64K page size, the following 4 subtests failed:
  #97/25   dynptr/test_probe_read_user_dynptr:FAIL
  #97/26   dynptr/test_probe_read_kernel_dynptr:FAIL
  #97/27   dynptr/test_probe_read_user_str_dynptr:FAIL
  #97/28   dynptr/test_probe_read_kernel_str_dynptr:FAIL

These failures are due to function bpf_dynptr_check_off_len() in
include/linux/bpf.h where there is a test
  if (len > size || offset > size - len)
    return -E2BIG;
With 64K page size, the 'offset' is greater than 'size - len',
which caused the test failure.

For 64KB page size, this patch increased the xdp buffer size from 5000 to
90000. The above 4 test failures are fixed as 'size' value is increased.
But it introduced two new failures:
  #97/4    dynptr/test_dynptr_copy_xdp:FAIL
  #97/12   dynptr/test_dynptr_memset_xdp_chunks:FAIL

These two failures will be addressed in subsequent patches.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/dynptr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
index f2b65398afce..9b2d9ceda210 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -51,6 +51,8 @@ static struct {
 	{"test_copy_from_user_task_str_dynptr", SETUP_SYSCALL_SLEEP},
 };
=20
+#define PAGE_SIZE_64K 65536
+
 static void verify_success(const char *prog_name, enum test_setup_type s=
etup_type)
 {
 	char user_data[384] =3D {[0 ... 382] =3D 'a', '\0'};
@@ -146,14 +148,18 @@ static void verify_success(const char *prog_name, e=
num test_setup_type setup_typ
 	}
 	case SETUP_XDP_PROG:
 	{
-		char data[5000];
+		char data[90000];
 		int err, prog_fd;
 		LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in =3D &data,
-			    .data_size_in =3D sizeof(data),
 			    .repeat =3D 1,
 		);
=20
+		if (getpagesize() =3D=3D PAGE_SIZE_64K)
+			opts.data_size_in =3D sizeof(data);
+		else
+			opts.data_size_in =3D 5000;
+
 		prog_fd =3D bpf_program__fd(prog);
 		err =3D bpf_prog_test_run_opts(prog_fd, &opts);
=20
--=20
2.47.3


