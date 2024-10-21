Return-Path: <bpf+bounces-42612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4869A6825
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493961C22587
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B4D1F9439;
	Mon, 21 Oct 2024 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHEQ1/Jq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349861F942B;
	Mon, 21 Oct 2024 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513319; cv=none; b=Vg8IwunvcWt2aS6WRa6r0hMpTX/fDfLNLUME4c9qS9kU98yNWSTi6NS9q7OEUb58BoOBnX0PrXnwwSqSKRmvhRrjIZD8zQHERKBLiZLfcxOy+JTCPZP5gHy8fFokQb0/kp1BZNDWl1YTJSmmaSiyA8KFtjHpL6Gm5oSLhxhHfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513319; c=relaxed/simple;
	bh=DksjoWr3zi3vNlUAvCVzy7Y3/lqTinQGR/Ze6AaMZC4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgsH+7h1Rb8rG4mC/sgQPPMutXvcpR8a8W8GXqyk5kBsHp7lyWNi5xTWA5nSnnsvZRVGfUVoWM7f+4+ffcd7kyJpu1fqGzn0LpeaKOTdSCpyYkfdNYmBHX0mcNv+6jBG0SboVaUL1bSEzWsGSuczbpb3FoF1UFWNz6qSbgyidbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHEQ1/Jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E0BC4CEC3;
	Mon, 21 Oct 2024 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513318;
	bh=DksjoWr3zi3vNlUAvCVzy7Y3/lqTinQGR/Ze6AaMZC4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nHEQ1/Jq4CEIn/6XFUcJ5UljN17WywRBZBPUwCPExk2/YXfvLhbx7jsTrL/5yA76S
	 mUE6v/rv1LKMZ8kiHWDvGn5hc075ANSZQgMxLAh+LP5FWo0LYM9zDn0k4CJ6oZNgU6
	 bYqFFOutWCFWwbMcXMIiNjK7I+BYqp9khSA2hiVcHVTCy3g1PrUX+BTaNAYlVi/h8d
	 vfN2pXpglXa+9KVGnf472OwHoRoKaNQ7YtDm46sRAmYGH6t5nrd6T2mKAICHZYH8xF
	 GFuOyXgPh4RUfiRgY0e2KUp4Q6uoIe12F21/CAf7ZtPHLXpzr4m2loCAFDERDmupBT
	 bobVeaSc/4f5w==
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
Subject: [PATCH bpf-next 1/5] net: checksum: move from32to16() to generic header
Date: Mon, 21 Oct 2024 12:21:08 +0000
Message-Id: <20241021122112.101513-2-puranjay@kernel.org>
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

from32to16() is used by lib/checksum.c and also by
arch/parisc/lib/checksum.c. The next patch will use it in the
bpf_csum_diff helper.

Move from32to16() to the include/net/checksum.h as csum_from32to16() and
remove other implementations.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/parisc/lib/checksum.c | 13 ++-----------
 include/net/checksum.h     |  6 ++++++
 lib/checksum.c             | 11 +----------
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/parisc/lib/checksum.c b/arch/parisc/lib/checksum.c
index 4818f3db84a5c..59d8c15d81bd0 100644
--- a/arch/parisc/lib/checksum.c
+++ b/arch/parisc/lib/checksum.c
@@ -25,15 +25,6 @@
 	: "=r"(_t)                      \
 	: "r"(_r), "0"(_t));
 
-static inline unsigned short from32to16(unsigned int x)
-{
-	/* 32 bits --> 16 bits + carry */
-	x = (x & 0xffff) + (x >> 16);
-	/* 16 bits + carry --> 16 bits including carry */
-	x = (x & 0xffff) + (x >> 16);
-	return (unsigned short)x;
-}
-
 static inline unsigned int do_csum(const unsigned char * buff, int len)
 {
 	int odd, count;
@@ -85,7 +76,7 @@ static inline unsigned int do_csum(const unsigned char * buff, int len)
 	}
 	if (len & 1)
 		result += le16_to_cpu(*buff);
-	result = from32to16(result);
+	result = csum_from32to16(result);
 	if (odd)
 		result = swab16(result);
 out:
@@ -102,7 +93,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 {
 	unsigned int result = do_csum(buff, len);
 	addc(result, sum);
-	return (__force __wsum)from32to16(result);
+	return (__force __wsum)csum_from32to16(result);
 }
 
 EXPORT_SYMBOL(csum_partial);
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 1338cb92c8e72..0d082febfead4 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -151,6 +151,12 @@ static inline void csum_replace(__wsum *csum, __wsum old, __wsum new)
 	*csum = csum_add(csum_sub(*csum, old), new);
 }
 
+static inline __sum16 csum_from32to16(__wsum sum)
+{
+	sum += (sum >> 16) | (sum << 16);
+	return (__force __sum16)(sum >> 16);
+}
+
 struct sk_buff;
 void inet_proto_csum_replace4(__sum16 *sum, struct sk_buff *skb,
 			      __be32 from, __be32 to, bool pseudohdr);
diff --git a/lib/checksum.c b/lib/checksum.c
index 6860d6b05a171..025ba546e1ec6 100644
--- a/lib/checksum.c
+++ b/lib/checksum.c
@@ -34,15 +34,6 @@
 #include <asm/byteorder.h>
 
 #ifndef do_csum
-static inline unsigned short from32to16(unsigned int x)
-{
-	/* add up 16-bit and 16-bit for 16+c bit */
-	x = (x & 0xffff) + (x >> 16);
-	/* add up carry.. */
-	x = (x & 0xffff) + (x >> 16);
-	return x;
-}
-
 static unsigned int do_csum(const unsigned char *buff, int len)
 {
 	int odd;
@@ -90,7 +81,7 @@ static unsigned int do_csum(const unsigned char *buff, int len)
 #else
 		result += (*buff << 8);
 #endif
-	result = from32to16(result);
+	result = csum_from32to16(result);
 	if (odd)
 		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
 out:
-- 
2.40.1


