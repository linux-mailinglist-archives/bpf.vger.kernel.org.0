Return-Path: <bpf+bounces-46815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B97839F032B
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 04:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22593162849
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 03:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0BA16CD35;
	Fri, 13 Dec 2024 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTY2pXgw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB515573A;
	Fri, 13 Dec 2024 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061283; cv=none; b=Aq2jeT2blc0D5xk17JRv2AxTfmWH/q6ccTgjqiV9PIhQ8Sk6ErvCuB/Ly1T3+YXgUtsKaAPZFUAW1bbECvyffIko6TuRYg5Qra0PgLCGAau+nrysgxaRZDAm9J5vZeMwf2aydtgvU/k50dbPEZTWMO6Hdnmqi1FSgPYQdg9YWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061283; c=relaxed/simple;
	bh=Cz+RDuxZGhbIYpPvRdxXHAIVMKeHS8VaukFXwDX1SXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fNTYKbEqgnKtr4vx9fU7PVbUGmrmsZF7sOy8BHDvUMVI1ztB4LC5g6V+Yh9cwGS7AdcoVm6FJ4w6kSjosxDLRuhjVxClPtGsbM4UTR8jgWB3mT5+7/K5IOQw8pM6+LUFSg+FdOOrdul8yj1CjSXnH4zH6T89BVq0Gp1nrvo/G+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTY2pXgw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166f1e589cso14307455ad.3;
        Thu, 12 Dec 2024 19:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734061281; x=1734666081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V42dUz7lZc/wavr0Sk49K9gYie7ScXcG5kiu9sQv1Co=;
        b=HTY2pXgwTCO/1P9YlP626lszdPqQ6cPp8usfB4Ly+gva68yYVfKa+AbMNZYIN80T6G
         sSAWRBVSpL2gJoWp9I/U9lVd6BwoDWGGorgHUx1h8HlGz9aCBNDLPrinI1h63I2Om/Oz
         0osKjI0QiuQCCRGvjv3flbN3yALhVZ89pVxpLyftIglbvybGafaovlcauvAwm8W+wc4R
         RH5B+vlIIEjZnUkjdkolw9LwdWh7XK2dajqYRbjFwd14IrZKHFL0vDVTES+9/R+dg19D
         eyjChsahTkc879YqryHhVaRuznl6B6xKhox+XIeJmpVpQmchZOAnd5h6dkb8qpTmHnFC
         1OaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734061281; x=1734666081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V42dUz7lZc/wavr0Sk49K9gYie7ScXcG5kiu9sQv1Co=;
        b=Vr6rldK6VNhJjBywXpiWsMCHT/4qIrCPDwwEyqBy9/bWvA8/oxOp3RhcMcs6BuGU0a
         pFR8Z6JjAYAInz5o1Q77jvl56kqcA61E9BQe7ESeU6FYuTr0R7RaT7ylziEpQ3EAsY7A
         TxEUuxvWFe5xIOhgAbepMWgVvNQ8X4jAs0epOFoG0dA86dHYm5FODY2u8YKvA/b0kTNK
         l5y5EoTOEH472Z6fmrDKSC050lape0e1FTb8THKlCH0NFI7ddnmOclblHfKtu+xOpMdx
         z1lxlP6WH7FJUaW9FC2kZUiMR4u28/hqVMvxFOE1yuT5xb2tQksJ7TBwLKphwvZiLEeH
         9B3g==
X-Gm-Message-State: AOJu0YwrrdFzmzynj3Hi5CKV1UGjQXjV4GUxHN2dkFeQQ819JU2LF9Lz
	MuB0AOpBPFKN5txsstTc8MIcKPEIzK681X1FZS38HmbuAub5D7kE7MmgzQ==
X-Gm-Gg: ASbGnctiODFSkNKouwVR5lw/WWtivHXOX//bn4nGZZAg2pPbAWkEattXbbd/I/RgGou
	qLi0zzMmdnVkMlAr/uq0LwDyB7MbmRErDjP/m8vCN2hxqBWNo3AnftG63OH8fAa99j3aZyx/Y+J
	jOKCudFqaI9SpEvJAYUxptFVhYlgv6jQfaJOdAWCOGApSgiRheoYEOE5b0VWGIYQMKVV2QkomDA
	MPavxWJ4ZT002PX66IZV1qUi84GxSO50/WQALL+d8tp5kXW7y7oBmsCFYV42pugtC/pJCJGsgAE
	enrUy3Nksw==
X-Google-Smtp-Source: AGHT+IGichFnYAjLXh4QVB/I3OTGpYWo84HTsrKTkSdeTpu6llD20twvgMsdFUBu1EIEE07gt7/9lg==
X-Received: by 2002:a17:902:ce88:b0:216:3732:ade3 with SMTP id d9443c01a7336-21892ab82e1mr15390495ad.35.1734061280826;
        Thu, 12 Dec 2024 19:41:20 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:a642:75a1:c5bb:c287])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163725faf4sm89526435ad.196.2024.12.12.19.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:41:20 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [Patch bpf v3 1/4] bpf: Check negative offsets in __bpf_skb_min_len()
Date: Thu, 12 Dec 2024 19:40:54 -0800
Message-Id: <20241213034057.246437-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
References: <20241213034057.246437-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

skb_network_offset() and skb_transport_offset() can be negative when
they are called after we pull the transport header, for example, when
we use eBPF sockmap at the point of ->sk_data_ready().

__bpf_skb_min_len() uses an unsigned int to get these offsets, this
leads to a very large number which then causes bpf_skb_change_tail()
failed unexpectedly.

Fix this by using a signed int to get these offsets and ensure the
minimum is at least zero.

Fixes: 5293efe62df8 ("bpf: add bpf_skb_change_tail helper")
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 net/core/filter.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 21131ec25f24..834614071727 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3734,13 +3734,22 @@ static const struct bpf_func_proto bpf_skb_adjust_room_proto = {
 
 static u32 __bpf_skb_min_len(const struct sk_buff *skb)
 {
-	u32 min_len = skb_network_offset(skb);
+	int offset = skb_network_offset(skb);
+	u32 min_len = 0;
 
-	if (skb_transport_header_was_set(skb))
-		min_len = skb_transport_offset(skb);
-	if (skb->ip_summed == CHECKSUM_PARTIAL)
-		min_len = skb_checksum_start_offset(skb) +
-			  skb->csum_offset + sizeof(__sum16);
+	if (offset > 0)
+		min_len = offset;
+	if (skb_transport_header_was_set(skb)) {
+		offset = skb_transport_offset(skb);
+		if (offset > 0)
+			min_len = offset;
+	}
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		offset = skb_checksum_start_offset(skb) +
+			 skb->csum_offset + sizeof(__sum16);
+		if (offset > 0)
+			min_len = offset;
+	}
 	return min_len;
 }
 
-- 
2.34.1


