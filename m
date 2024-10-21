Return-Path: <bpf+bounces-42614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E169A6832
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E781D1F26AFC
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5E1FA271;
	Mon, 21 Oct 2024 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2s47iFp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D51FA262;
	Mon, 21 Oct 2024 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513327; cv=none; b=pAZNwXF+IX7FJxSkTzUuno6opPS8ZkvSa7432iHN9Q+6uP4fa0zsjbt8GC1cDfBRXA5NOfkCyNReh6UzU7Bu0WTvw8u8TicpRcpFxF4ql1FYj6cD4TdK9ylt96H4b5qVeX8nekPWe1wrAeeRRGsPSpt5nxnERMngBkbWFFN5cEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513327; c=relaxed/simple;
	bh=q9r41TUNdBdaXSTHRnEB4GOxd1xBEVJa+omNwYCjQ9g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M5eGNbKwrla3jAx5CuQaS6S1x+Mi7RUF3h+qNm3PH4XCJJioxchpU2ce7flMq+RIuhTObkQfKXxv3vSaj1GisAqcgwCwbh2TbiHV7+ak18mF+FGLpQWlpaI8F/Rqh9t7kgiXCBX8Pm7Lyr8NMX/yyHUEsepCzlihpGJk+CMC4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2s47iFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A248C4CEC3;
	Mon, 21 Oct 2024 12:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513326;
	bh=q9r41TUNdBdaXSTHRnEB4GOxd1xBEVJa+omNwYCjQ9g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K2s47iFpNxrXBD19bu1MVAodC8qAnRBq0DYV2+zoAoelVjDzHq34KIcYHkvE/jHWi
	 CDiDHlRCjvOZqIIjIZO0MEQCQZFiVIb63p7V8pfIRpzXQHXzM62S0hGnJMqmVhgQQY
	 LuIVyNVIuMPtcui6PykJbw0VJs6Tg5+OpAldA/XTxeLVTvLcu+KkTXYNwGroOypmLJ
	 AqHAzWmluEL6R1UHGwCvc7yAxP+XivHBshqAG9qRft8BKEwcwEwmKqMLJDS/6Zov3R
	 GimBTQLOAe7/H/QRhRZwfgM7ha0qmbdQotEtL7otQ9AZOQRJRJYhcrtm0YW8ae7DeB
	 +2rGIQLxsS3dg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Hao Luo <haoluo@google.com>,
	Helge Deller <deller@gmx.de>,
	Jakub Kicinski <kuba@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	netdev@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 3/5] selftests/bpf: don't mask result of bpf_csum_diff() in test_verifier
Date: Mon, 21 Oct 2024 12:21:10 +0000
Message-Id: <20241021122112.101513-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241021122112.101513-1-puranjay@kernel.org>
References: <20241021122112.101513-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_csum_diff() helper has been fixed to return a 16-bit value for
all archs, so now we don't need to mask the result.

This commit is basically reverting the below:

commit 6185266c5a85 ("selftests/bpf: Mask bpf_csum_diff() return value
to 16 bits in test_verifier")

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/verifier_array_access.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 95d7ecc12963b..4195aa824ba55 100644
--- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -368,8 +368,7 @@ __naked void a_read_only_array_2_1(void)
 	r4 = 0;						\
 	r5 = 0;						\
 	call %[bpf_csum_diff];				\
-l0_%=:	r0 &= 0xffff;					\
-	exit;						\
+l0_%=:	exit;						\
 "	:
 	: __imm(bpf_csum_diff),
 	  __imm(bpf_map_lookup_elem),
-- 
2.40.1


