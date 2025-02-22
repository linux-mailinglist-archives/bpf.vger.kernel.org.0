Return-Path: <bpf+bounces-52245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA5BA406D5
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 10:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A045424D0A
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA839206F12;
	Sat, 22 Feb 2025 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XYst5pqH"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73A206F30
	for <bpf@vger.kernel.org>; Sat, 22 Feb 2025 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740216390; cv=none; b=IrWyFA074KRSq1+Hvx3y4vS9/gO78pB5sWHuhQmCsrGTia4NNMNzJaWkLmq9LWx1qA5hix3nvLQJswT5Cz251USfV8GFBF4tm0JqPFyi+tnflvyRBbzHaKSfUnGsVQs/X9N2DcXyvvgIYVjM8FMxnr9+21yaivqTDkj7KctTwJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740216390; c=relaxed/simple;
	bh=sfIpC4mK60ZTxM8L5Lg3oNfU+bsuIGzSy6AGc6+L+74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ys53SNd8hizalgIapTs9q70g1Iusb7CQ5vIlPw6iQxA4JHQhMlUWoAkvPvHWryOu36jqYbBmmJAcqy9xeajRQTOSDYSqUtTQL+P2Y43Zw1Pty1jVzHL2lT7kPpD/wJ89HUEW2KXc8gg9kIRsKF7D9VhJeLAv6P3vNIC4ZyaIEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XYst5pqH; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740216385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdgFqFXXtd2PsA/56XMx8Rklb2PiwMNcWaN1bikm/tE=;
	b=XYst5pqH/ObdTqPVLmnwxWcsYwNoZwvPpQc2HFwBJoXoSTiy15eALlQ6UOgftY0KcQxXAx
	N1pYOPF+7gqVS9tlPyRPPFa+9eHUnbUR17v7EVFmJKIWLNCl80giCbxW0vNQstQwqg2lDV
	w6/W5Y8Xe1gs/Yf9IIoxxbZNrYoCZLg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ricardo@marliere.net,
	jiayuan.chen@linux.dev,
	viro@zeniv.linux.org.uk,
	dmantipov@yandex.ru,
	aleksander.lobakin@intel.com,
	linux-ppp@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mrpre@163.com,
	syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Subject: [PATCH net-next v3 1/1] ppp: Fix KMSAN warning by initializing 2-byte header
Date: Sat, 22 Feb 2025 17:25:56 +0800
Message-ID: <20250222092556.274267-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250222092556.274267-1-jiayuan.chen@linux.dev>
References: <20250222092556.274267-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The PPP driver adds an extra 2-byte header to enable socket filters to run
correctly. However, the driver only initializes the first byte, which
indicates the direction. For normal BPF programs, this is not a problem
since they only read the first byte.

Nevertheless, for carefully crafted BPF programs, if they read the second
byte, this will trigger a KMSAN warning for reading uninitialized data.

Reported-by: syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/000000000000dea025060d6bc3bc@google.com/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/ppp/ppp_generic.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4583e15ad03a..29a7a21cb096 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1762,10 +1762,17 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 
 	if (proto < 0x8000) {
 #ifdef CONFIG_PPP_FILTER
-		/* check if we should pass this packet */
-		/* the filter instructions are constructed assuming
-		   a four-byte PPP header on each packet */
-		*(u8 *)skb_push(skb, 2) = 1;
+		/* Check if we should pass this packet.
+		 * The filter instructions are constructed assuming
+		 * a four-byte PPP header on each packet. The first byte
+		 * indicates the direction, and the second byte is meaningless,
+		 * but we still need to initialize it to prevent crafted BPF
+		 * programs from reading them which would cause reading of
+		 * uninitialized data.
+		 */
+		skb_push(skb, 2);
+		skb->data[0] = 1;
+		skb->data[1] = 0;
 		if (ppp->pass_filter &&
 		    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 			if (ppp->debug & 1)
-- 
2.47.1


