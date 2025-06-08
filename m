Return-Path: <bpf+bounces-60017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E53AD1367
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 18:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C55F3AAD5E
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620C21A314D;
	Sun,  8 Jun 2025 16:55:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABAE156C40
	for <bpf@vger.kernel.org>; Sun,  8 Jun 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749401753; cv=none; b=fndB2ZjL7/Tu2tlZGRYdkbnKtU8FmhZ4o/iH1SJq4nxrhPHk9YE7DuaNntzifMdwOEQgZpCfwmW1KQPnV5wXv7iqojzii4oKGGad1iyEG21HnkZ5eLuk4Gxk9ZYoxrvbxElSJR0Uzg1nmY/4T0oM7DxGTckUxuX2x3TxKUxggz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749401753; c=relaxed/simple;
	bh=ill3hujARH8K5s1+KDl30qgH+OaHFktIbjTjWZb0YBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnGrHzF1W0iISiDYErW8pMIjlbUi830aUB7d4kzu7G3MzzUMW9SuCRQQCIQWeLhcxmtj16KCAq3Xa/MAkIlXdvgYnJxt0BAc65bbJV/kA+eu+VHukxTmrEFKHFMetd9g+OQYTArEA1t3Kt5x2Q2/UG3orYQzwoLlBvIN5NEdZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7562691DF8C8; Sun,  8 Jun 2025 09:55:39 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Fix two net related test failures with 64K page size
Date: Sun,  8 Jun 2025 09:55:39 -0700
Message-ID: <20250608165539.1020481-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250608165534.1019914-1-yonghong.song@linux.dev>
References: <20250608165534.1019914-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When running BPF selftests on arm64 with a 64K page size, I encountered
the following two test failures:
  sockmap_basic/sockmap skb_verdict change tail:FAIL
  tc_change_tail:FAIL

With further debugging, I identified the root cause in the following
kernel code within __bpf_skb_change_tail():

    u32 max_len =3D BPF_SKB_MAX_LEN;
    u32 min_len =3D __bpf_skb_min_len(skb);
    int ret;

    if (unlikely(flags || new_len > max_len || new_len < min_len))
        return -EINVAL;

With a 4K page size, new_len =3D 65535 and max_len =3D 16064, the functio=
n
returns -EINVAL. However, With a 64K page size, max_len increases to
261824, allowing execution to proceed further in the function. This is
because BPF_SKB_MAX_LEN scales with the page size and larger page sizes
result in higher max_len values.

Updating the new_len parameter in both tests from 65535 to 262143 (0x3fff=
f)
resolves the failures.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c | 2 +-
 tools/testing/selftests/bpf/progs/test_tc_change_tail.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c=
 b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
index 2796dd8545eb..4f7f08364c75 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_change_tail.c
@@ -31,7 +31,7 @@ int prog_skb_verdict(struct __sk_buff *skb)
 		change_tail_ret =3D bpf_skb_change_tail(skb, skb->len + 1, 0);
 		return SK_PASS;
 	} else if (data[0] =3D=3D 'E') { /* Error */
-		change_tail_ret =3D bpf_skb_change_tail(skb, 65535, 0);
+		change_tail_ret =3D bpf_skb_change_tail(skb, 262143, 0);
 		return SK_PASS;
 	}
 	return SK_PASS;
diff --git a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c b/to=
ols/testing/selftests/bpf/progs/test_tc_change_tail.c
index 28edafe803f0..b1057fda58a0 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_change_tail.c
@@ -94,7 +94,7 @@ int change_tail(struct __sk_buff *skb)
 			bpf_skb_change_tail(skb, len, 0);
 		return TCX_PASS;
 	} else if (payload[0] =3D=3D 'E') { /* Error */
-		change_tail_ret =3D bpf_skb_change_tail(skb, 65535, 0);
+		change_tail_ret =3D bpf_skb_change_tail(skb, 262143, 0);
 		return TCX_PASS;
 	} else if (payload[0] =3D=3D 'Z') { /* Zero */
 		change_tail_ret =3D bpf_skb_change_tail(skb, 0, 0);
--=20
2.47.1


