Return-Path: <bpf+bounces-69508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0EDB9859D
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 08:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB4B2E4BD5
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 06:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD4623E350;
	Wed, 24 Sep 2025 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xj8X9cOV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE3D21FF29
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758694185; cv=none; b=DwJAndlMQ2Q8858gxTf6huC39/jh/LATxhF47o5VqEaGwEeJOrL7HC7SFZdquD+aKjvXLTNU3WaOnwHwLwWSCze2YXTx0NpKESAKYoa9LIlMnMIEufhRvjcSXZhNRzf11ySdsMWwsTEJpxupqBn+axR+bV4sTLcw0FlARvQsP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758694185; c=relaxed/simple;
	bh=EhcXvjDksM360UK0Vc1kfwj42Glaw8DRfiy1mwD5d2o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V5nY3tOcLc5FI4mKHcHpT9ZZjaoTrUzZOkqQylu770kSMCg+o91roDSJklAld/Dwc8Nm+0cgWNhUd9wWURqZutxcQp5kNanN3S5zHt7yxYNT4NwnnQt67TIwI0B7P425MDhZyoH1lTKcNyyboPM77KanKpzSVwpKH4mpTeBY/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xj8X9cOV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-330a4d5c4efso4299744a91.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 23:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758694183; x=1759298983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VesomAbu95SiSwEJQVEDMDpoIPq0ZwIbbU6hCVXWd88=;
        b=Xj8X9cOVm5A73FG9phTGQteR+C/LYOjdZQGakP1LJ+GRAC7AbJEgXCyPV49o/PUNN4
         PWhLX6WjA7oQajBUQRj0tEVJnLp9cDvQ++aq1BlmvS2lHoHalZrmvcJ7nW3Hw9Y1GroA
         2X/oCIJ5LL4PepWjnJy4gf8eVWiX+eGmpcqs3vXe0WrUuhRda/pDACUz91cNvXHSLgCG
         mz/U7aoAwo7dGmJMSr9fVtVk9aEvM37RrbcDTJEpoIsAKTryXvodL2oIIOVvYTNuIMJq
         vi4Jf/9YfoKwgX2mH4655/JQGZAma1Wr56SJaAQBaDS4/cmlEFqZ4F4WJfDY1boDEm+B
         8vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758694183; x=1759298983;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VesomAbu95SiSwEJQVEDMDpoIPq0ZwIbbU6hCVXWd88=;
        b=TFHHJLGDEZYysVLFLqL0YyhzwltYReEPju6EK173y2OKvXMssw0SZYutgW+B5JipnZ
         yMUUc8k5uZRYY0/DSIVV6JfoB+yhMenO+DFrTPT0J58bbuML2bJFU5Y3EsyynCOQj6iB
         6kmM2ikEgW4G9DGepg4pnE2FGTajfbo3nf53wu3n9bFWT9W6SKLwikIpFcdaORrkE5qT
         qQNHXV5pB7Ozjg1iuKvCvYiaG7mEEV6FIdGumtpkaDFaMIFViKNjISa+EBdoWn9v2rbb
         YdKkagKG2OvMaqvAyOSvC8w+qbOXhz1pXLM17Sj/mcjCwXV6LnaflTFdRUVT5PqqvLyj
         TE9A==
X-Forwarded-Encrypted: i=1; AJvYcCWrWDREfNqY5NG7KQF0Mb2uHJ9CRC78js5/xAtL9NMG0zMgNckCQdJff4a2slPpQFoS8Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaU509ZUBxlasI7FDMphp7ig/no2kILWCmPMneNgnAZMdsI6pg
	+MtIv1f+/gYY7gVYhU7P+97S7G5N9xR4/yCdF/XxzYdJfacxTBkW91NdfkF8HP/N4Gh9mlils8x
	kVQ==
X-Google-Smtp-Source: AGHT+IHPYYt8LHeRbkdZ6BC5gEw24RQTAxzur79wWGM+UNPt7dswDqktCbgAAACHQQTYTv0OWU5feY1szQ==
X-Received: from pjbqe17.prod.google.com ([2002:a17:90b:4f91:b0:330:55ed:d836])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33c8:b0:32e:7c34:70cf
 with SMTP id 98e67ed59e1d1-332a95e9348mr5433618a91.36.1758694183313; Tue, 23
 Sep 2025 23:09:43 -0700 (PDT)
Date: Wed, 24 Sep 2025 06:08:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924060843.2280499-1-tavip@google.com>
Subject: [PATCH net] xdp: use multi-buff only if receive queue supports page pool
From: Octavian Purdila <tavip@google.com>
To: kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, uniyu@google.com, 
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com, toke@redhat.com, 
	lorenzo@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>, syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

When a BPF program that supports BPF_F_XDP_HAS_FRAGS is issuing
bpf_xdp_adjust_tail and a large packet is injected via /dev/net/tun a
crash occurs due to detecting a bad page state (page_pool leak).

This is because xdp_buff does not record the type of memory and
instead relies on the netdev receive queue xdp info. Since the TUN/TAP
driver is using a MEM_TYPE_PAGE_SHARED memory model buffer, shrinking
will eventually call page_frag_free. But with current multi-buff
support for BPF_F_XDP_HAS_FRAGS programs buffers are allocated via the
page pool.

To fix this issue check that the receive queue memory mode is of
MEM_TYPE_PAGE_POOL before using multi-buffs.

Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@google.com/
Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 net/core/dev.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8d49b2198d07..b195ee3068c2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5335,13 +5335,18 @@ static int
 netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
 {
 	struct sk_buff *skb = *pskb;
+	struct netdev_rx_queue *rxq;
 	int err, hroom, troom;
 
-	local_lock_nested_bh(&system_page_pool.bh_lock);
-	err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, prog);
-	local_unlock_nested_bh(&system_page_pool.bh_lock);
-	if (!err)
-		return 0;
+	rxq = netif_get_rxqueue(skb);
+	if (rxq->xdp_rxq.mem.type == MEM_TYPE_PAGE_POOL) {
+		local_lock_nested_bh(&system_page_pool.bh_lock);
+		err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool),
+					   pskb, prog);
+		local_unlock_nested_bh(&system_page_pool.bh_lock);
+		if (!err)
+			return 0;
+	}
 
 	/* In case we have to go down the path and also linearize,
 	 * then lets do the pskb_expand_head() work just once here.
-- 
2.51.0.534.gc79095c0ca-goog


