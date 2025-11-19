Return-Path: <bpf+bounces-75114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A929DC715A9
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 23:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6B47F30360
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 22:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A44D33D6D1;
	Wed, 19 Nov 2025 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="mH3mu7CU"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831A322547;
	Wed, 19 Nov 2025 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592180; cv=none; b=dAIyxEwxcL87Tb78++Pmi/tMN6NsqzQQFUE755EdpszLCb7BjgYjNiwkt7WNyVYTyvP9B6myTkCtKIb+4o0YUhYkGj8GsRwoXzvarawobmkTdkyCO5Lp0/Df5FLlPLB6mdxjBhjNI5b2Hs2Z5JjCQPFh2pvjdvMCEB2zG1T+q6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592180; c=relaxed/simple;
	bh=XFrfwVCvPCtb0hiydszl3RIWBMsxeFfaRQl+89Butuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxala0pxsZ+ljQUql0P//lxy0e+3u8GA+fxnFMiWiXhDpcuTQcYk2eoETcdO67NxObJyqb1AxhjYipxWLNcpYlo4rh083o03UTABIvCZ449140YFSt5QjZjjbkxn3/QVm8RcSgGIGH3EXkknIGTR+TkPoETslvoNk4Pl4kw3VpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=mH3mu7CU; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt4-006kya-5z; Wed, 19 Nov 2025 23:42:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=gcWmtAAfsAw9kpNlGTgaWUDkrcywIVK3kKVtDQyu4MQ=; b=mH3mu7CUOLOgvZQQz4iSHYl8md
	bDHLoV5jQJ8+4QdanQY9jEszDaCJGnYBPdN/4BkP6xA9uFDgkIQlZ7zgNuiie8/ZY6pBzFla7+hXS
	9r8objOy4Ex6It0D6XXEOl/Ymqhq8c9jrgoXsT3A2gKVHlNDl/K8WSP+dYsluD8oldGHLBid67cdC
	5wh75wheE42DC29E923kuHXpZ2xLnaVZZzR380BbZO6/MLyooYHxkfo0oix0AeASsGKtT2Tm6ErWp
	Cz7stmPzBciBUC+4KoVhXmQ+C9WaxPETYMv1feWdSi4IHH4NcmDS5XzkRdZQCyyyJ7+x7csJw6sfP
	L3rM3iwg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt3-0000E8-Mq; Wed, 19 Nov 2025 23:42:53 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqso-00Fos6-ED; Wed, 19 Nov 2025 23:42:38 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 41/44] net/core: Change loop conditions so min() can be used
Date: Wed, 19 Nov 2025 22:41:37 +0000
Message-Id: <20251119224140.8616-42-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Loops like:
	int copied = ...;
	...
	while (copied) {
		use = min_t(type, copied, PAGE_SIZE - offset);
		...
		copied -= 0;
	}
can be converted to a plain min() if the comparison is changed to:
	while (copied > 0) {
This removes any chance of high bits being discded by min_t().
(In the case above PAGE_SIZE is 64bits so the 'int' cast is safe,
but there are plenty of cases where the check shows up bugs.)

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 net/core/datagram.c | 6 +++---
 net/core/skmsg.c    | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index c285c6465923..555f38b89729 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -664,8 +664,8 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
 		head = compound_head(pages[n]);
 		order = compound_order(head);
 
-		for (refs = 0; copied != 0; start = 0) {
-			int size = min_t(int, copied, PAGE_SIZE - start);
+		for (refs = 0; copied > 0; start = 0) {
+			int size = min(copied, PAGE_SIZE - start);
 
 			if (pages[n] - head > (1UL << order) - 1) {
 				head = compound_head(pages[n]);
@@ -783,7 +783,7 @@ EXPORT_SYMBOL(__zerocopy_sg_from_iter);
  */
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
 {
-	int copy = min_t(int, skb_headlen(skb), iov_iter_count(from));
+	int copy = min(skb_headlen(skb), iov_iter_count(from));
 
 	/* copy up to skb headlen */
 	if (skb_copy_datagram_from_iter(skb, 0, from, copy))
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2ac7731e1e0a..b58e319f4e2e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -335,8 +335,8 @@ int sk_msg_zerocopy_from_iter(struct sock *sk, struct iov_iter *from,
 		bytes -= copied;
 		msg->sg.size += copied;
 
-		while (copied) {
-			use = min_t(int, copied, PAGE_SIZE - offset);
+		while (copied > 0) {
+			use = min(copied, PAGE_SIZE - offset);
 			sg_set_page(&msg->sg.data[msg->sg.end],
 				    pages[i], use, offset);
 			sg_unmark_end(&msg->sg.data[msg->sg.end]);
-- 
2.39.5


