Return-Path: <bpf+bounces-72239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E971C0A984
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47ADE3B0CBC
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88C225291B;
	Sun, 26 Oct 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jmewu0WS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96EE248F40
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488332; cv=none; b=ha4pCLnNl6DXOcZnbR1KDfftcRYABx6GEfvEFq/8cmxx1/6cTnmgxxV5Qd6S1vnl+Ukgc3hPeL3K3rznttO4SCK5GE1zhLQAL2aIzTgX7jSrb6POQBqkZai5SQdImnK1w4mZazVRcA9xP7LVcLR65wDbQxdjdajBlN2gyEoO/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488332; c=relaxed/simple;
	bh=Gak4HRUwBOd2FQnLiXDTXLRpQgivj1vf/nGp3J5rI+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c690h8cECEdwzTuELW7ErUU7kJSbBFcOP+0eS85CLe2d4brhqLGacfIfCcrTBriESUyMsw9HvDDH9FQ02KG9fyqc0XHzKIajS7lWno5jBNyzVjRqB9Pu36TOe7X93CsP6eRY5eVSBQiOvesRnNEbmuIqeF71oxukq/02xiLpHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jmewu0WS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63e11cfb4a9so6801806a12.2
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488329; x=1762093129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSYvzngXAX+S+IrAJeNpu+SkdlG3R21JATkFTa33X3I=;
        b=Jmewu0WSaFA/F7m74l/d4W5oJyVqTrsastsCWQBhevkifAYnZYrlK8C/O5HYZhAaBP
         7pga/+977XfLPAQtR/QAadHi4mqNtWSSO1tAVKckmVooh/LkZAipU9ETOu2Pmt4wLQ3q
         WkhpbbZzEJbTcobPEnJypxtZafD1ttX/qSkJ81YQUQaaxnYR0FJMJ2mYdy6MeUhOcHcf
         bMLHbmk6Kq6jnLgCM9kLWO0WT2IP9ZPIFZMBt0KFAegL/RvkzNu3RPXqCGq9+dkS+MY5
         YsneHBAG0C1J87wPK1bD8xtXiaa/ezsiBVZYmx6NWOiqYmcYJpZyaOIbMP8tiw9103PR
         qnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488329; x=1762093129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSYvzngXAX+S+IrAJeNpu+SkdlG3R21JATkFTa33X3I=;
        b=oCq4Ok6usCDAWlhQZMz7rHxT0L/iARViVGmqtxZJLGK5fWg/Dk0h3s6nwm+wlZ1J6j
         RkbjqB8D9tsAoQzw2LrUNHX7mvH6mcm7VcuDyKMbuxFI5WzgzxKNN3rfHzqazN7KU+Bw
         YDYq02Tga2O2BdIY1gxGNLthVhVcf4wTtC/SZO/SzYUJK4lig1THmQC6ZtQeqNsDhgFs
         J+Vq8YL5BT6zFY89EiHHnPTQSK5BAmyQdmvIGrYFbu+9fyDmTrkla4y3/edSZ6sBtsth
         /SwGKU6svaCMsBV8IdqdyewaetGzhTt2Jxi3EbQ5WwdVenU2A9+wj450pH3HBpozAYZV
         arEQ==
X-Gm-Message-State: AOJu0Yz3jw09nj26XOYQYxne6la8RfFy/QZFRrd9qWhhGOlBzXhJSK2P
	XxMxkbo5tjw0AA9uEW9Bwy85EfwdSayVMGGBAfWOU9cjNxUpK95pzRJDH5y0CbJdL3k=
X-Gm-Gg: ASbGncvQJi2bfDslvN9d4psg7DRjNycFRrf8AtkXyMW5hH0kK2YXBDUDwYiisGEnHWe
	A275fuy8yAtYpcZpMzFZ6jeSpTTaNvU2BzpDbVItu246+PFW6jhLwyG8EBBtz2xZP/MZ8qD6rD7
	9oEQkS7NhDK8+uDT8qJow9kx34eurIrUjYKooRr7zhiZ9c6ZxwMnkF1m9WreYyVeqLXxNo9LDkK
	le8zY9KmW3RDLjISlWkkCEQqEDZ/Q71pQBJIM9Cfus1etKWq6EC4kHKP+wSu3XWpvAbxDDpe7aX
	bC0jBb3MMI9RGIYN6V9vp5617ax1rHkXFAr2CxKJTBR9cdMXrT2Jqh/c0ITNhbIdHGPzBHSQg1B
	HQYCXoczn8pOCOp+77TBdNjvXWDecXbwMtVRlUfebor8Nui1CrgeJYMU9FdjCe+CbbZ29jqrMZQ
	JKZERdYzZhlzIKn+j3DWLwVccJIDtLQ4Muc6pQtOKf9P5Gzw==
X-Google-Smtp-Source: AGHT+IElR+KKTIQUVvqZHLDN1tnFR/WtdI9kHI8UMta06H3SpUZDJM8GEaSmKEppAf94BbKvhvPh3Q==
X-Received: by 2002:a05:6402:5107:b0:63a:5d3:6a1e with SMTP id 4fb4d7f45d1cf-63e600f2646mr7077995a12.33.1761488329226;
        Sun, 26 Oct 2025 07:18:49 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef9a5cbsm4076717a12.23.2025.10.26.07.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:48 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:28 +0100
Subject: [PATCH bpf-next v3 08/16] bpf: Make bpf_skb_change_proto helper
 metadata-safe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-8-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
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
index 80a7061102b5..09a094546ddb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3333,10 +3333,11 @@ static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
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


