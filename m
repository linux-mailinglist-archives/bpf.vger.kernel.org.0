Return-Path: <bpf+bounces-69958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9BCBA97F9
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B61A16A859
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831A530B536;
	Mon, 29 Sep 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="J3S+4xa6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA530B518
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154974; cv=none; b=p6yq2F3Ff4uj5tVHzcam0IVJ72pTacDT3Oj5OvNVImqvlrA5CmkaJyeqq4LC9RYQIpDQ4kYtJ59VYAlp1mtBYHiP1WI56/lswOJ1psb1999vjb9h77Up4rvDgps2n2u5c9Jgu6QR7tCOAwILTGBSxsxx9Cuzwk1FKDfKRG0yfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154974; c=relaxed/simple;
	bh=BgOR8bzAO8QkIkPvLUhe9jPbzwE7eBy+kPUbUnL7JiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVk3VnAEOdepd0PrzH1fQBW8yEVX4FXoQW+aBLQtLcR8my0UZsjxzzsU0to6S3PjQ0R9o1T7vdLHpFU7ZtkgOw+u6qVO+dB562oRrfzbNAyMLdtA9dvZC5qKT6o8dOtSsvBHuHc6TlA5AsaigPiUy5RSml0ChutJ3j4WNfDh5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=J3S+4xa6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3b27b50090so362134066b.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154971; x=1759759771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/TmEkEKPYb4IvmOQwqL1V6bPCyihwKao023pDUBEQk=;
        b=J3S+4xa6fFKbpHCHWNww0X/A1q2QyavYV74PLZ//OdbOXs0vJnQlOvFOjTLjHASWCR
         Q2oEThCv4KCkpHvDZ5fM/7fZlORiV/dFdHcq0+rBBbnmecH7KR6r/unLq6ErTtIW8PVg
         /0tSfY2BmYwExs/CckehvqUlYr8UUVvMRUmF+I/X+t2Hf8Zt289dkPGXFiBKlyhc0+jH
         Akg+ghWY8TSqXedSLg7TdjwD1wrvLy5FDyWV3UqwHDCXcYozrX7p0o1hyEuL6EyFQJT4
         UpGgmDNF8DjkT1DEZjIF58xyJiwNZwshnT2fmsvoLGMtLKfIMn0iWwvv5f8e8ySytUac
         HkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154971; x=1759759771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/TmEkEKPYb4IvmOQwqL1V6bPCyihwKao023pDUBEQk=;
        b=rOsjztGHauf8mCktFO6hkiGselCJEj9rUPkJ0vse30JEG6zBKhZUrIDJMpHcOqkykz
         /bue9K8WoY2C4qw7ZNAT2a7qJR/wnKv3MyL1eHfkmgEY1WnDspzsUsxvO59XGHlCQETC
         2ivJwtWitr5gjEqaPJVDixDQNokeSXjllKrPIeo4Htqkr2xt3sq/GKsvEdjbYoIG4S84
         7d7eMIcsabcJMutVEZMcAzhnnGrKD9ZPejrdyp9dknNUKkgd3e9UGIMYVx0S2Mipg3Q7
         iPU3h2owAxncCJttu6jbjNccK6DxH46Jkd7csFR2MbQm9P3nAaDwceG05SE+spsGwnvw
         gc8A==
X-Gm-Message-State: AOJu0Yyc5OPuHANYcMOATVOpZ2dndwPAJx3Hz1Sn39Aqg6QivsBfQCKn
	o51HRlfqZlbUU8I0R3sUdCPN4ykNXErgVc9prNEtZVoqGMT3geAbcN1we8QPUKzrTaw=
X-Gm-Gg: ASbGncsw+TRjk4gzNzRhNydpYJ4wXTm0+CfaSAa71tpjbNWIoAnb3Fz6KqnPlOm+JgD
	Y7rj3eGs8HYiRi3mi2HIkPM0Aidd69S/TQeXk/Kbj7AseCclOirDedoiGhoyKABvjHe1UWlli6e
	p4Fp4ig1ZuaDYjwRO7iuLwn3ksDkVR949RQcSXcqhLNzLmf1Wp+i+50maZJIxnCMDPjmQk8O9St
	Iox5A0ZMJXgmPIbSuHceohbiS0YdeWdmiytDizFj7ortDLqxj5aeM5SgaH87TdpVRtKXv8FJ2Bw
	4CkvjFJpmT+Y+MsOeTaeAAMhrON/KEKtpv9eeDefS0ZEFb33xAcqFpttJuU2b+kH/rwqviXzcGx
	5yK76UU+j7QEZXLSez8l628oTQrRXPvj+qP/I49fmVz88orumo8JpcW6FQTudEJu2zNzJJts=
X-Google-Smtp-Source: AGHT+IF2bkB5c0b7TIiqTGkEKYPqRERLoMjLoZPQYy8Agg2IXaG2QltRUgoaBeflXjkeWABgYm+dyg==
X-Received: by 2002:a17:907:3f12:b0:b04:7541:e695 with SMTP id a640c23a62f3a-b34bb9e9f27mr1788285366b.32.1759154970501;
        Mon, 29 Sep 2025 07:09:30 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3df8c7aef1sm261583766b.11.2025.09.29.07.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:29 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 29 Sep 2025 16:09:12 +0200
Subject: [PATCH RFC bpf-next 7/9] bpf: Make bpf_skb_change_proto helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-skb-meta-rx-path-v1-7-de700a7ab1cb@cloudflare.com>
References: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
In-Reply-To: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

bpf_skb_change_proto reuses the same headroom operations as
bpf_skb_adjust_room, already updated to handle metadata safely.

The remaining step is to ensure that there is sufficient headroom to
accommodate metadata on skb_push().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 030349179b5a..c4b18b7fa95e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3324,10 +3324,11 @@ static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
 static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 {
 	const u32 len_diff = sizeof(struct ipv6hdr) - sizeof(struct iphdr);
+	const u8 meta_len = skb_metadata_len(skb);
 	u32 off = skb_mac_header_len(skb);
 	int ret;
 
-	ret = skb_cow(skb, len_diff);
+	ret = skb_cow(skb, meta_len + len_diff);
 	if (unlikely(ret < 0))
 		return ret;
 

-- 
2.43.0


