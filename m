Return-Path: <bpf+bounces-44200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF09BFD0C
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 04:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE0B1C20358
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 03:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B3188A3B;
	Thu,  7 Nov 2024 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuT5rsC1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238CB17A58F;
	Thu,  7 Nov 2024 03:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730950931; cv=none; b=DHgINj7OtBlHj+K2UEgwaFsRHT1+RHlQ5xYgvQ6v3m3w3R32zOgRLHT/t9fzC9GMbteLoey5cpIlqvZAS4ZJxWEni1Blkf0ubcDRP/OZrbQpitLPdC8YSkCT7GhQHQX0aLiso/mV3WCbqGDjWFQGeTm1SEhGSp8Kk5HYD3/LlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730950931; c=relaxed/simple;
	bh=Bd4/1bRQjL8ZeFkDPvv2WXCg6czYMlxfu06pKHSKVzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=moHwan+7YmcDBTRoKKYJd0Nb5d5wieQ0yrCbNg/IIzu8/vUPpnLsINJ15D6RcxbO22JsNwho0Xo4AFB60N4UQdbYg/q7ArsSaGEWbJZXq9oB0qNaO3EOm48HLpyrdhVAL0eevSJ4AWmOgyC5ZuM4XABvHX6NwAJ1U/alVX2KwS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuT5rsC1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso320359b3a.3;
        Wed, 06 Nov 2024 19:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730950929; x=1731555729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lZF/u9+GPXYrricxMdIO1ZeVQr+W3pwbp6CyD6Uri9Y=;
        b=BuT5rsC1pJbPykV3PBIPx/UL5vYgXL0iCGAjCmiUMzp+zY/lOwlzJAXOAEos7EP1ZR
         i1/E6JxpRU28o0/1FN+3LbIBejCTvJpXfUj4tHAAMLJTntGWAyeS9C7q92AmYME4RCpk
         YpI7QkJfztmYZjh4nRhSI+UODbSdZ4gEA8JnBRqwiy/4Yvp0nHGcL0S3qZy2CXehSB82
         /huxyLPJhgk/6XcPQxzWC2ysVRQsdbjiDQHkgtIKkhkl20UniwdU15lXNyiG9iwsD0oO
         RfujlZ9VImnFxs+eBCvuQ4SNGbLV2+lLK0ZTA2KiJ90kKgVENsqVTaKY5hRvaaR/zD9o
         2Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730950929; x=1731555729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZF/u9+GPXYrricxMdIO1ZeVQr+W3pwbp6CyD6Uri9Y=;
        b=JerIixmwOBUevr9VXtPoj7BEuIGpcXJMZDHm7dNOKagt+CFOld/kBZmlORZJMPc6z/
         ufHipMMYfFQQivAYs98JfdX/uQZSLnvJVhMGHGpPpFCldNKuasWMem9oXm4Of0vTzvFa
         G1b4DF81VB2JqQIpDhLRwLZ79JTF3acg4jM071AMHtVWKr4xg6qw1t7XXwOmWUUKV9/B
         TWKLkCpKcrXJW6hKcKqBbyAv3q7Ktns1Zo3y7QGM1d8Od0zh6zh6l4ILjKN3Ylylq1vS
         jaPHy8uXBz/A1oc62HFknk9Zxj4AR37gvDbIO+xpThqU2CAFejknsoBMgeOGZkzM8QfN
         bKDg==
X-Gm-Message-State: AOJu0YyUSZOSJpFxZey23TP/MOgiiOdsNME98JqsKIbIOp14cBRF0J+O
	BwnPegZ/kuK/JKJvfI1uEGJcAsM6nPKPDTPBm8z1qOMedG0fyUfZm9hxdA==
X-Google-Smtp-Source: AGHT+IG4yrxQXNfmcx6WnRaiSgVu3eH+rmHCU87fwTwPkWwrQTQJa0t692uwgt33civE9YHkyKiugA==
X-Received: by 2002:a05:6a00:b86:b0:71e:7c92:a192 with SMTP id d2e1a72fcca58-72063093594mr54596155b3a.24.1730950928825;
        Wed, 06 Nov 2024 19:42:08 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:baaf:f848:1f89:8135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a2367dsm361350b3a.169.2024.11.06.19.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 19:42:08 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [Patch bpf 1/2] bpf: check negative offsets in __bpf_skb_min_len()
Date: Wed,  6 Nov 2024 19:41:40 -0800
Message-Id: <20241107034141.250815-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

skb_transport_offset() and skb_transport_offset() can be negative when
they are called after we pull the transport header, for example, when
we use eBPF sockmap (aka at the point of ->sk_data_ready()).

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
index e31ee8be2de0..fd263c22944d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3737,13 +3737,22 @@ static const struct bpf_func_proto bpf_skb_adjust_room_proto = {
 
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


