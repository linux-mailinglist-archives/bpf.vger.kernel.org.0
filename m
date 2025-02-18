Return-Path: <bpf+bounces-51830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60975A39DE4
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 14:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5163A4481
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8645C26AA98;
	Tue, 18 Feb 2025 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYWcyrtA"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3FB26A1C2
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885540; cv=none; b=A42EpJYRYUD4Lw30L5ZvSxGtRMnGvzoDZb/uCyfVlRIrMsG5WMaBDGwLz6vHRnwOntM0ht99auZnDKVE/6wpnTLCf9zKUD39Ee6mcNGpSfGXABad8oxPZ5bZKUulvJKtidrA+l66HB9T+ciHkmghi/By594PTH9RPLz+DcfyWhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885540; c=relaxed/simple;
	bh=Y4bb2gMg2fhQX3UumMqYLIY1mVeZXXRdQb69m4+STL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqKKVfAGeJmkIfMgiQrKn0k2jXFuhsCyLhkAOggHbUep8CJlaNMOHgd0aiRqZWWPfv89n+KZgg65HgPPfpR85lT4hiqCv5QSSCkPslbEquTfB4wbzFDtU94fTgRk+L6rouQ1LI3PvvuODb87eMyoB+uBhbhKUGod2zBUliRf0is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYWcyrtA; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739885535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYjio39CMFV+Mh6EEVWTUj22Y7RBm4Gi+VVLarh3BvE=;
	b=nYWcyrtAK2xqFBLaFB3HRZ2IxF6NVcxEUBcKDh3zyZQWxiykNSn8cdkIATx4O8gqFXFcFO
	zQKPogA0Fqj2JT0l8VZq+u17y2o8/NEq4uWXQJ9xvnpmCf5lliRWyiM+q2CHGn2pLml/s7
	zOpGSd8FzsLEdoNwn75vLxGoPb6NK8Q=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.ne,
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
Subject: [PATCH net-next v1 1/1] ppp: Fix KMSAN warning by initializing 2-byte header
Date: Tue, 18 Feb 2025 21:31:44 +0800
Message-ID: <20250218133145.265313-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250218133145.265313-1-jiayuan.chen@linux.dev>
References: <20250218133145.265313-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The ppp program adds a 2-byte pseudo-header for socket filters, which is
normally skipped by regular BPF programs, causing no issues.

However, for abnormal BPF programs that use these uninitialized 2 bytes,
a KMSAN warning is triggered.

Reported-by: syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/000000000000dea025060d6bc3bc@google.com/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/ppp/ppp_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4583e15ad03a..a913403d5847 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1765,7 +1765,7 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 		/* check if we should pass this packet */
 		/* the filter instructions are constructed assuming
 		   a four-byte PPP header on each packet */
-		*(u8 *)skb_push(skb, 2) = 1;
+		*(u16 *)skb_push(skb, 2) = 1;
 		if (ppp->pass_filter &&
 		    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 			if (ppp->debug & 1)
@@ -2489,7 +2489,7 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 			if (skb_unclone(skb, GFP_ATOMIC))
 				goto err;
 
-			*(u8 *)skb_push(skb, 2) = 0;
+			*(u16 *)skb_push(skb, 2) = 0;
 			if (ppp->pass_filter &&
 			    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 				if (ppp->debug & 1)
-- 
2.47.1


