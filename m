Return-Path: <bpf+bounces-36868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2474494E61F
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 07:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1364D1C21446
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 05:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4132314D28E;
	Mon, 12 Aug 2024 05:21:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDECC5FBB7
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 05:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723440086; cv=none; b=Iad/u9iMrUYiyBMfiG7DXg9eoURW0SdM3RN+JTmztS3El6E8IaxVa1jkCr+/HeRPp68sziU02r6v1UxYM72gDg+1tEKIvY2+8hftrVP6Dj9zi1ASr31DvO+eDwMQxt3GHmjP5EQsv8hOk7Vv1pAKLdyfibzju9MvOHB0FIDTHYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723440086; c=relaxed/simple;
	bh=/2bi0y2iVeFYjXQJs4bDPCALBYhyo0TrCsTZU7C+jDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6mB0k0jE+38u7dCRL1ggq56zbJ8UFWZQLBP6fRCSe8LIJhTRf6QitOG9n9c1wr3i2apMKMpXPN8J9KU9e9T0+93AH32RIdGWSv3p1YT8R88jiZEjMZYHkbKIJTkPSgUxuITPCazuLTw0vtCunu57J5SxpTy3JIWb1lCRnRy+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 14F947A354D0; Sun, 11 Aug 2024 22:21:12 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf 2/2] selftests/bpf: Add a test to verify previous stacksafe() fix
Date: Sun, 11 Aug 2024 22:21:12 -0700
Message-ID: <20240812052112.3980530-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240812052106.3980303-1-yonghong.song@linux.dev>
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A selftest is added such that without the previous patch,
a crash can happen. With the previous patch, the test can
run successfully. The new test is written in a way which
mimics original crash case:
  main_prog
    static_prog_1
      static_prog_2
where static_prog_1 has different paths to static_prog_2
and some path has stack allocated and some other path
does not. A stacksafe() checking in static_prog_2()
triggered the crash.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/iters.c | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/se=
lftests/bpf/progs/iters.c
index 16bdc3e25591..8d3b75147617 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1432,4 +1432,58 @@ int iter_arr_with_actual_elem_count(const void *ct=
x)
 	return sum;
 }
=20
+__u32 upper, select_n, result;
+__u64 global;
+
+static __noinline bool nest_2(char *str, int len)
+{
+	/* some insns (including branch insns) to ensure stacksafe() is trigger=
ed
+	 * in nest_2(). This way, stacksafe() can compare frame associated with=
 nest_1().
+	 */
+	if (str[0] =3D=3D 't')
+		return true;
+	if (str[1] =3D=3D 'e')
+		return true;
+	if (str[2] =3D=3D 's')
+		return true;
+	if (str[3] =3D=3D 't')
+		return true;
+	return false;
+}
+
+static __noinline bool nest_1(int n)
+{
+	/* case 0: allocate stack, case 1: no allocate stack */
+	switch (n) {
+	case 0: {
+		char comm[16];
+
+		if (bpf_get_current_comm(comm, 16))
+			return false;
+		return nest_2(comm, 16);
+	}
+	case 1:
+		return nest_2((char *)&global, sizeof(global));
+	default:
+		return false;
+	}
+}
+
+SEC("raw_tp")
+__success
+int iter_subprog_check_stacksafe(const void *ctx)
+{
+	long i;
+
+	bpf_for(i, 0, upper) {
+		if (!nest_1(select_n)) {
+			result =3D 1;
+			return 0;
+		}
+	}
+
+	result =3D 2;
+	return 0;
+}
+
 char _license[] SEC("license") =3D "GPL";
--=20
2.43.5


