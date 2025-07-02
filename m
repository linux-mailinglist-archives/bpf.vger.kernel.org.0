Return-Path: <bpf+bounces-62123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD7FAF5BEA
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39E13A5D0E
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9003D30B987;
	Wed,  2 Jul 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbvlcwKe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1019C292B53;
	Wed,  2 Jul 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468312; cv=none; b=FOhdEIR7qlqn6nLGwSKigJoK7FlOu7pqHo0L5nxm3pz8dLb8sPi01LHYPCWH48dEJNI0764SS5hHINiGOe6TMG66wosphvPl4NQ1iXyeehGLSkzWoNAbB2i1Ut41WwPSih9o+X3UuUYziN9NK0fcD7BQxYZMybSkWzh75AoJbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468312; c=relaxed/simple;
	bh=DKc7Er4JVCfvqXu6MwgQwuoZumA/bmws5bxXOs7Jorw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9vFjZK0CA0z8BFXmfeWGOr6+cMnBw/NISpRe8edr3SLYFu3nX17kZ3pZHEw2euznUydqOiHHIk1UXr4+Yjmr9j1J9RLGz2pxzSt1a0q7Iip3lUMWdlR4hfoBrQ2BPq1CmnJ2ShvoMPIUuu1iqPmRJmayjPiyeT42xa2Nb8Lzwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbvlcwKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28394C4CEE7;
	Wed,  2 Jul 2025 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468311;
	bh=DKc7Er4JVCfvqXu6MwgQwuoZumA/bmws5bxXOs7Jorw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mbvlcwKedXAePme9LGS7rLkE/Ori3B6uwgvMjIzeTb7wObsMAJPoudJFOBUONQhOv
	 hB/nc2Wdh/CHFEolcAQC8JKmfFWfnadP7HXjLAC856EnKaZ1ah4+G/fQSeER6ThodN
	 yQUrqfJx6OEv+Wlxm/bNr4mwPne+/Szr2ND/Ie2aB9ekQylHOiKP4j54PdAPm3fn8u
	 zTNVzcnRvwzYO8IIvyCLwjBteCFTsv3LL5HBTVWZDyavDHhw8/DPSZvns/HgoZQZVP
	 ik9zHAgLRzONW3wKqGQWPUEQN4zBJCEJ1h1W/WnMurDtygkHgY/76Sdm/5UmQdrRXp
	 GvyRLTGLCJsgQ==
Subject: [PATCH bpf-next V2 2/7] selftests/bpf: Adjust test for maximum packet
 size in xdp_do_redirect
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 sdf@fomichev.me, kernel-team@cloudflare.com, arthur@arthurfabre.com,
 jakub@cloudflare.com
Date: Wed, 02 Jul 2025 16:58:26 +0200
Message-ID: <175146830610.1421237.2715806824407788172.stgit@firesoul>
In-Reply-To: <175146824674.1421237.18351246421763677468.stgit@firesoul>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Patchset increased xdp_buff with a pointer 8 bytes, and the bpf/test_run
struct xdp_page_head have two xdp_buff's.  Thus adjust test with 16 bytes.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 .../selftests/bpf/prog_tests/xdp_do_redirect.c     |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index dd34b0cc4b4e..35c65518f55a 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -59,12 +59,12 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, int fd)
 
 /* The maximum permissible size is: PAGE_SIZE - sizeof(struct xdp_page_head) -
  * SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) - XDP_PACKET_HEADROOM =
- * 3408 bytes for 64-byte cacheline and 3216 for 256-byte one.
+ * 3392 bytes for 64-byte cacheline and 3200 for 256-byte one.
  */
 #if defined(__s390x__)
-#define MAX_PKT_SIZE 3216
+#define MAX_PKT_SIZE 3200
 #else
-#define MAX_PKT_SIZE 3408
+#define MAX_PKT_SIZE 3392
 #endif
 
 #define PAGE_SIZE_4K  4096



