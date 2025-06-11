Return-Path: <bpf+bounces-60354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946B1AD5CE8
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEB83A8A26
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AC61F09B3;
	Wed, 11 Jun 2025 17:15:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26431CD208
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662150; cv=none; b=EX6Jq8P3VFj4+k08zD4Oofu4WRtyxpk8xW4t2wI4uqCJfR2NQJU7YG9PDDy3yng2pN65VDv62grnWacaQhSIcayEqmPlXoVg+jpLPNrZSgIlGFW9pvAo+C+V2a0TYX+vcTsTfgaHiRPKKbq/N5LZAnKwmEHjeaoijrJrJKoLKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662150; c=relaxed/simple;
	bh=jJgT63k4r+/mDJ1wI8n6mvKTyi6x10RwgW4AYPOjMNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jny55tY3BEMQKCxQxa4mEz4nigGmYoOxdH7UgG0mw4uznXEBm0duBjpyNvoSLxILvFCCsSR7ualBa7M3L9IQYqhWjM9FS1Y0KslCdawLFNHqNgeCGZjUK9JPlvu2wVZtJQpkH6koy/Zkr3x1Sg4OIyWpB7jtsbWKyTQU6s+GaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 056A59680C77; Wed, 11 Jun 2025 10:15:35 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Fix xdp_do_redirect failure with 64KB page size
Date: Wed, 11 Jun 2025 10:15:34 -0700
Message-ID: <20250611171535.2034440-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250611171519.2033193-1-yonghong.song@linux.dev>
References: <20250611171519.2033193-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On arm64 with 64KB page size, the selftest xdp_do_redirect failed like
below:
  ...
  test_xdp_do_redirect:PASS:pkt_count_tc 0 nsec
  test_max_pkt_size:PASS:prog_run_max_size 0 nsec
  test_max_pkt_size:FAIL:prog_run_too_big unexpected prog_run_too_big: ac=
tual -28 !=3D expected -22

With 64KB page size, the xdp frame size will be much bigger so
the existing test will fail.

Adjust various parameters so the test can also work on 64K page size.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/xdp_do_redirect.c      | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/t=
ools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index 7dac044664ac..dd34b0cc4b4e 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -66,16 +66,25 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, i=
nt fd)
 #else
 #define MAX_PKT_SIZE 3408
 #endif
+
+#define PAGE_SIZE_4K  4096
+#define PAGE_SIZE_64K 65536
+
 static void test_max_pkt_size(int fd)
 {
-	char data[MAX_PKT_SIZE + 1] =3D {};
+	char data[PAGE_SIZE_64K + 1] =3D {};
 	int err;
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in =3D &data,
-			    .data_size_in =3D MAX_PKT_SIZE,
 			    .flags =3D BPF_F_TEST_XDP_LIVE_FRAMES,
 			    .repeat =3D 1,
 		);
+
+	if (getpagesize() =3D=3D PAGE_SIZE_64K)
+		opts.data_size_in =3D MAX_PKT_SIZE + PAGE_SIZE_64K - PAGE_SIZE_4K;
+	else
+		opts.data_size_in =3D MAX_PKT_SIZE;
+
 	err =3D bpf_prog_test_run_opts(fd, &opts);
 	ASSERT_OK(err, "prog_run_max_size");
=20
--=20
2.47.1


