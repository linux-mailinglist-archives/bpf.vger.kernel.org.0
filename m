Return-Path: <bpf+bounces-42613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8779A682C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F79B24DC2
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92101F9AB2;
	Mon, 21 Oct 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7u8hf1B"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E31E884B;
	Mon, 21 Oct 2024 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513323; cv=none; b=oF6OMma4+SyWfBDLQOzl/F01OKdC03HPxuqApwwR1qbAbV/PsOT7DzfJ/NMAcZ16DLC6HSW+sboxkj8qEUbQnQNzvawaFChO2qqYePP47AZh7IsC2kp2gERJevzEh+AlbNyFeXLiefSOEtTF3N99tiTVCP/EckmktRu+Uru6wHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513323; c=relaxed/simple;
	bh=gJ2hfEV44PPxvxKXpZF+JkBcTX9tTBF4IaZx7SCOMZ8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bchuinTiroAxS8JQuhlI0iqrCHezu6yKv2TQKrlS//TWFuTipA16PN5jgL0b404n3/WgPgz32MMaR/x/SbiwHcujrUCqhBhq5mOfThmaoyM76/HrHE3YL9YvO/km1Ynhqod8GjpIW8eEWBbzLcBXf4+voHWAhrsWBg/niTCbn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7u8hf1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE604C4CEE4;
	Mon, 21 Oct 2024 12:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513323;
	bh=gJ2hfEV44PPxvxKXpZF+JkBcTX9tTBF4IaZx7SCOMZ8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=H7u8hf1BlS2So8vQ1TSFGFD05iAr9Ps6b4H9FJhaHFS9M+hlJmUh9+4Os2jqFP/Q/
	 bdW2TEwQ6IxHTfkeXZwOtrm+b+57z5pFqqUi7KpQsoVGrI69x9j8DQ1ePmPrWMd3et
	 RAhnxCxeEHjH3SoqZdayL+7a7ffLzisilXVatTyfXD39jrD/P8rZxi8OKIW00B/9H2
	 oUU9jI0zkAx42RmuN6Nya/uLvsYiNMKR1A5rAUCwNqvEVwJRK5JcwcQdmtgVbhuyrz
	 YAh2aD+a1EAy5H4ucA6ux8jJyITT7IkQ/ZPolYVTZGf3iI8YRWfzg4UjRGupy9Bghv
	 s1kjJbP9utYdw==
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
Subject: [PATCH bpf-next 2/5] bpf: bpf_csum_diff: optimize and homogenize for all archs
Date: Mon, 21 Oct 2024 12:21:09 +0000
Message-Id: <20241021122112.101513-3-puranjay@kernel.org>
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

1. Optimization
   ------------

The current implementation copies the 'from' and 'to' buffers to a
scratchpad and it takes the bitwise NOT of 'from' buffer while copying.
In the next step csum_partial() is called with this scratchpad.

so, mathematically, the current implementation is doing:

	result = csum(to - from)

Here, 'to'  and '~ from' are copied in to the scratchpad buffer, we need
it in the scratchpad buffer because csum_partial() takes a single
contiguous buffer and not two disjoint buffers like 'to' and 'from'.

We can re write this equation to:

	result = csum(to) - csum(from)

using the distributive property of csum().

this allows 'to' and 'from' to be at different locations and therefore
this scratchpad and copying is not needed.

This in C code will look like:

result = csum_sub(csum_partial(to, to_size, seed),
                  csum_partial(from, from_size, 0));

2. Homogenization
   --------------

The bpf_csum_diff() helper calls csum_partial() which is implemented by
some architectures like arm and x86 but other architectures rely on the
generic implementation in lib/checksum.c

The generic implementation in lib/checksum.c returns a 16 bit value but
the arch specific implementations can return more than 16 bits, this
works out in most places because before the result is used, it is passed
through csum_fold() that turns it into a 16-bit value.

bpf_csum_diff() directly returns the value from csum_partial() and
therefore the returned values could be different on different
architectures. see discussion in [1]:

for the int value 28 the calculated checksums are:

x86                    :    -29 : 0xffffffe3
generic (arm64, riscv) :  65507 : 0x0000ffe3
arm                    : 131042 : 0x0001ffe2

Pass the result of bpf_csum_diff() through from32to16() before returning
to homogenize this result for all architectures.

NOTE: from32to16() is used instead of csum_fold() because csum_fold()
does from32to16() + bitwise NOT of the result, which is not what we want
to do here.

[1] https://lore.kernel.org/bpf/CAJ+HfNiQbOcqCLxFUP2FMm5QrLXUUaj852Fxe3hn_2JNiucn6g@mail.gmail.com/

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 net/core/filter.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index bd0d08bf76bb8..e00bec7de9edd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1654,18 +1654,6 @@ void sk_reuseport_prog_free(struct bpf_prog *prog)
 		bpf_prog_destroy(prog);
 }
 
-struct bpf_scratchpad {
-	union {
-		__be32 diff[MAX_BPF_STACK / sizeof(__be32)];
-		u8     buff[MAX_BPF_STACK];
-	};
-	local_lock_t	bh_lock;
-};
-
-static DEFINE_PER_CPU(struct bpf_scratchpad, bpf_sp) = {
-	.bh_lock	= INIT_LOCAL_LOCK(bh_lock),
-};
-
 static inline int __bpf_try_make_writable(struct sk_buff *skb,
 					  unsigned int write_len)
 {
@@ -2022,11 +2010,6 @@ static const struct bpf_func_proto bpf_l4_csum_replace_proto = {
 BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_size,
 	   __be32 *, to, u32, to_size, __wsum, seed)
 {
-	struct bpf_scratchpad *sp = this_cpu_ptr(&bpf_sp);
-	u32 diff_size = from_size + to_size;
-	int i, j = 0;
-	__wsum ret;
-
 	/* This is quite flexible, some examples:
 	 *
 	 * from_size == 0, to_size > 0,  seed := csum --> pushing data
@@ -2035,19 +2018,17 @@ BPF_CALL_5(bpf_csum_diff, __be32 *, from, u32, from_size,
 	 *
 	 * Even for diffing, from_size and to_size don't need to be equal.
 	 */
-	if (unlikely(((from_size | to_size) & (sizeof(__be32) - 1)) ||
-		     diff_size > sizeof(sp->diff)))
-		return -EINVAL;
 
-	local_lock_nested_bh(&bpf_sp.bh_lock);
-	for (i = 0; i < from_size / sizeof(__be32); i++, j++)
-		sp->diff[j] = ~from[i];
-	for (i = 0; i <   to_size / sizeof(__be32); i++, j++)
-		sp->diff[j] = to[i];
+	if (from_size && to_size)
+		return csum_from32to16(csum_sub(csum_partial(to, to_size, seed),
+						csum_partial(from, from_size, 0)));
+	if (to_size)
+		return csum_from32to16(csum_partial(to, to_size, seed));
 
-	ret = csum_partial(sp->diff, diff_size, seed);
-	local_unlock_nested_bh(&bpf_sp.bh_lock);
-	return ret;
+	if (from_size)
+		return csum_from32to16(~csum_partial(from, from_size, ~seed));
+
+	return seed;
 }
 
 static const struct bpf_func_proto bpf_csum_diff_proto = {
-- 
2.40.1


