Return-Path: <bpf+bounces-59948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 230B6AD098B
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF04E189E24F
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C654623C4EC;
	Fri,  6 Jun 2025 21:31:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736DC224892
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749245468; cv=none; b=dyErEboqSDkB9ShYK53+yN8xKIk15kJqRqxYkWVPq0+0OYvyFyj5QQtkR7IcOx5qJS8c2cWAPgb6SpsPtCRynv4qgfcmhd13CSeKAADEu1W8g7kIqi85LyKDl/H0WuDKYjFhoJHaJfUt/0jkQSRmev8hJU402JnqeCIkw0YRgHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749245468; c=relaxed/simple;
	bh=hHLYhil1lEHMtJ4WsLcI2QiQyZas2+PY8aHCTmpv/Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o65tSGW9gNVvADHTYLFUVzZ9r1AMwt8XBlpfAlIh+OZFGTStql2gbPVgYhSXWPR6h/R1i310lqSfPy56lfTf7h7VguBGI4BIZkMZFW5OEbj1Gb8OBOaV0EGB+RR+adHN3XAzPFoMPiztcSQcx+jH9LSABB8z2AufyrMqZZqbmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2F65D906E20A; Fri,  6 Jun 2025 14:30:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 1/4] selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
Date: Fri,  6 Jun 2025 14:30:53 -0700
Message-ID: <20250606213053.340607-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250606213048.340421-1-yonghong.song@linux.dev>
References: <20250606213048.340421-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow, if tested failur=
e,
I see a long list of log output like

    ...
    test_xdp_adjust_frags_tail_grow:PASS:9Kb+10b-untouched 0 nsec
    test_xdp_adjust_frags_tail_grow:PASS:9Kb+10b-untouched 0 nsec
    test_xdp_adjust_frags_tail_grow:PASS:9Kb+10b-untouched 0 nsec
    test_xdp_adjust_frags_tail_grow:PASS:9Kb+10b-untouched 0 nsec
    ...

There are total 7374 lines of the above which is too much. Let us
only issue such logs when it is an assert failure.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/t=
ools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index b2b2d85dbb1b..e361129402a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -246,14 +246,20 @@ static void test_xdp_adjust_frags_tail_grow(void)
 	ASSERT_EQ(topts.retval, XDP_TX, "9Kb+10b retval");
 	ASSERT_EQ(topts.data_size_out, exp_size, "9Kb+10b size");
=20
-	for (i =3D 0; i < 9000; i++)
-		ASSERT_EQ(buf[i], 1, "9Kb+10b-old");
+	for (i =3D 0; i < 9000; i++) {
+		if (buf[i] !=3D 1)
+			ASSERT_EQ(buf[i], 1, "9Kb+10b-old");
+	}
=20
-	for (i =3D 9000; i < 9010; i++)
-		ASSERT_EQ(buf[i], 0, "9Kb+10b-new");
+	for (i =3D 9000; i < 9010; i++) {
+		if (buf[i] !=3D 0)
+			ASSERT_EQ(buf[i], 0, "9Kb+10b-new");
+	}
=20
-	for (i =3D 9010; i < 16384; i++)
-		ASSERT_EQ(buf[i], 1, "9Kb+10b-untouched");
+	for (i =3D 9010; i < 16384; i++) {
+		if (buf[i] !=3D 1)
+			ASSERT_EQ(buf[i], 1, "9Kb+10b-untouched");
+	}
=20
 	/* Test a too large grow */
 	memset(buf, 1, 16384);
--=20
2.47.1


