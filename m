Return-Path: <bpf+bounces-41807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBD599B0B8
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F72F285337
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB46313AD32;
	Sat, 12 Oct 2024 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3mr5wJB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960B12C499;
	Sat, 12 Oct 2024 04:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706071; cv=none; b=jZBhq1daAbahqFMqfolqMLqQIrsDZFVFxwSDXkOlVF+GKL8wwgSQqvnGpIawmgYNWKw8/VzzcbTRCObh7BYJnztVRz2CnOEyMC7BtjFHjwnlQLUNdZ1um9wll3UAfyjrwfVEwlFN9E+hQkFvCvm1o9EyHcaB2UOuyY7FHZo4Jqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706071; c=relaxed/simple;
	bh=AZLMFTRAR9NImMfyU1jqDkCBQJ6ODo1s57ciPrmyiAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzcguVa5PdjvJWjjwZnFmLeNZ4mT3O16TyIN7oLLPGz63pGmest5J+q+KABpRNrt57bZNz2jn4iyWqI1rgll9ncJob8UGkIub0/2/ORoWe8YxIJ7ibZLUuo4OB3qGqRJj3E54aEzoXtOVtK6R/XKBwcVM+7AqtQu5TYhwM/+TzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3mr5wJB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso20078135ad.2;
        Fri, 11 Oct 2024 21:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706069; x=1729310869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJyNH9xYi5bBFnTYrkHLA+DxeLz8FBF8B6RGVuO4Q5g=;
        b=a3mr5wJBPhfrzmmBPghKSO3OswE3EBv+T71IMMIBKKEO/ur6mFrDbUs80tvveQ65HT
         WVA4/6bfZvCGMzwaL5AT0ItBUdZM4MxMQ+0AoS24Ke0ZWqloNedjVSKToc2PRduMHVnU
         /CaevCcYKIJ4PtCPbrXaOyvhjuLn+YPpmDfSEsVT39rKgtPX+54rwMsuiGb9cJrKQ3D6
         UoVImulKxipA1TEFkYV9cjfjfIJ986gI/IeZLQD7CCzT6SzPWn179iGDWL1M3lHGq7Ac
         lDijQwb5UHgOFa/EjoQ8QA421p/0j4lwdl9kqH1d1HOV8wQTe+R1cuP+ngrI5mA3pPVh
         bCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706069; x=1729310869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJyNH9xYi5bBFnTYrkHLA+DxeLz8FBF8B6RGVuO4Q5g=;
        b=RS0Ijkc6oRzIZkwEB18MN7YUfoWXj1ycZGziN449XfhD1hU9siuRUDVzCgR73+8E/J
         WyPTvvpNrVKNlS4W8dgzhM7mrtxHHb5QQ0pOz4YNpw2xCX7IkEuvapy6QLJqEoOC6k5E
         DqlkPCsvyngSedD07tcJp39TvpgcOxH7AIg5EkwwshDuYrxtp135BKKN/DPqWTyg0jU2
         MRBwQZ/S3iI9NcHH5jOPzm78tRbotBgNr9IxzLo02/HOij89HhsmcKiXA3aqr5F9jHEh
         JA1bAwI8fpMONMUQKYmBQk92kTTvRgzKLoyTg1riJtAcgyNXdOCMKpPOQnFO6xCGxZ0G
         Ng3w==
X-Forwarded-Encrypted: i=1; AJvYcCXA1QhcFPdF53pAUUtfZxG3hGz9GeIEQN5JbTA4IiQi1jofcjgaB5qeqGs1E83OB2IxI8tNKR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2YKTDC17eJ8hlgFGZR/1Huwe1K+aOOF6P/Rpxj1F79ZBSUGW
	zTAbUjf1U9GfHQsyXGqFOr/Y+pXoHuvF2ioiO4MZlIdO61miPGZ5
X-Google-Smtp-Source: AGHT+IE6vVdS+2Zrk2JyZ02RROZFZDrma6NMtYS2SXTh1gb6ZWRV8nVhPE1eX0AaU+aCjIqyQwOKiQ==
X-Received: by 2002:a17:903:187:b0:20c:c880:c3a8 with SMTP id d9443c01a7336-20cc880c984mr2553725ad.50.1728706069207;
        Fri, 11 Oct 2024 21:07:49 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:07:48 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 10/12] net-timestamp: make bpf for tx timestamp work
Date: Sat, 12 Oct 2024 12:06:49 +0800
Message-Id: <20241012040651.95616-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241012040651.95616-1-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

It's time to let bpf extension feature work. I extracted the part
of logic from tcp_tx_timestamp() for bpf extension use, like
TX timestamp flags.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6c8968eb4427..d37e231b2737 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -477,11 +477,31 @@ void tcp_init_sock(struct sock *sk)
 }
 EXPORT_SYMBOL(tcp_init_sock);
 
+static void bpf_tx_timestamp(struct sock *sk, struct sk_buff *skb)
+{
+	u32 tsflags = READ_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR]);
+
+	if (tsflags && skb) {
+		struct skb_shared_info *shinfo = skb_shinfo(skb);
+		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
+
+		__sock_tx_timestamp(tsflags, &shinfo->tx_flags);
+
+		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
+			tcb->txstamp_ack = 1;
+		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
+			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+	}
+}
+
 static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 {
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
 	u32 tsflags = sockc->tsflags;
 
+	if (static_branch_unlikely(&bpf_tstamp_control))
+		bpf_tx_timestamp(sk, skb);
+
 	if (tsflags && skb) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
-- 
2.37.3


