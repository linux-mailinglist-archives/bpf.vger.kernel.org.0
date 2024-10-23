Return-Path: <bpf+bounces-42909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F7B9ACF08
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AF11F20172
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 15:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29FC1CCB5C;
	Wed, 23 Oct 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh8ceyXz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467241C8781;
	Wed, 23 Oct 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697987; cv=none; b=FdUnm/hQG98J2D2F3rpb0guUu8ZRDXLXtaYC/V2uH36JdRiVqfJEF9hPnnau1CWr8GVvZ7H2T5rcY8dotogBIEITPvzCNc10AhmpTOptoUXQBwtKZnsEuY23IGx8UrSSHXj4G/T+T9Zt1Y4fXMZiiZ4GUoLNiHQsd73NT0oH+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697987; c=relaxed/simple;
	bh=ewTQi8vvMjY2tDN+rwCGUkIKwCDc2H1+fYWUrCoOJYU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+y3SiEArS8tu+tYEmuluQa1MNvy20VIvDW7JcmgWU3xvxCZwREZUWEt3cqYXkLPP2O5eBhinhohzDx0On6wz3Mr45UEQccslYYzN6uG2S5aoDiyoMY/Cw9plj6cVuPZjA694RQyHF0vqcg9AsSqsxIcmPWJsGLld6UoTzfEK90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh8ceyXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66695C4CEC6;
	Wed, 23 Oct 2024 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729697986;
	bh=ewTQi8vvMjY2tDN+rwCGUkIKwCDc2H1+fYWUrCoOJYU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dh8ceyXz5u5QQMbCEoEHeP0xSKZ4uIoXgtgkuhEcUSkOpfAJulmJKqh8W2RKuXr2+
	 Ov+Q7/pZkE0RHW0c7Dpi9oB606f339GA7ThVoZwFRwdb/sOC8OVslxR1M191apFcXR
	 ojf/hrt4/LJsITLt6m+YAfEV0nixevr7h1CxjyHlNzqZF7toRZNmk3K0/pzcx3KA4Q
	 lwRFG+sVi//FCVdqm9NHW/5CbbfX5jL+dbvMm7qtz7ocOp+TvhK3Me5dNoOxCboDou
	 heffJRjCKzh04XNttacz9V7HVSiQZ0ZWcNmgMBqJ6B4Rr4cIgz90BZiEvfm2zkaPbX
	 s1+SWPD7ICZmw==
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
Subject: [PATCH bpf-next v2 1/4] net: checksum: move from32to16() to generic header
Date: Wed, 23 Oct 2024 15:39:19 +0000
Message-Id: <20241023153922.86909-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241023153922.86909-1-puranjay@kernel.org>
References: <20241023153922.86909-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

from32to16() is used by lib/checksum.c and also by
arch/parisc/lib/checksum.c. The next patch will use it in the
bpf_csum_diff helper.

Move from32to16() to the include/net/checksum.h as csum_from32to16() and
remove other implementations.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
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
index 1338cb92c8e72..243f972267b8d 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -151,6 +151,12 @@ static inline void csum_replace(__wsum *csum, __wsum old, __wsum new)
 	*csum = csum_add(csum_sub(*csum, old), new);
 }
 
+static inline unsigned short csum_from32to16(unsigned int sum)
+{
+	sum += (sum >> 16) | (sum << 16);
+	return (unsigned short)(sum >> 16);
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


