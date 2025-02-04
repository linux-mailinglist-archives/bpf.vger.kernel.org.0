Return-Path: <bpf+bounces-50449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B3A279DA
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F661883B6B
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C112185B4;
	Tue,  4 Feb 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foRB8yhh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30A6217716;
	Tue,  4 Feb 2025 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693892; cv=none; b=rRB996qiJMeO6ABumCoANcidhLQar5M4tZQMMcDhgR9WuwMkZvsdynoT7Ei/W2A/17KtR1G9gFALtoUlp7zSO43o52SNUoeAqVJP3+R2e/d2ZuzCNe+fmh9SrY2sJz1KggCK70E14xBO2q6qFKb3CZTmxib4mzQZTtpFPz+uwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693892; c=relaxed/simple;
	bh=Blkp9t5eyElI1bhmb34aOXVqeTPcb3Fa1pZTIdwHEK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJfsu2b+U05ZoXb5WV1aLSsR6aA3ql8NNyDA3390XZV/CZwSR2FxP5ShH83WQKR47BFpFI4x0b5NEdXXGZbsqqFbmwc+EPoh1JdhH193Ch21aMKYNoEpKpD9qUZo2W2bvGDb2rcPwa5Xms94uOooIKxmIwMVIrJBUy3M/n0u2E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foRB8yhh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f9cb23d22cso1220520a91.1;
        Tue, 04 Feb 2025 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693890; x=1739298690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxLtuhE10MEuDrxCFADp/8wzNE83tQvqrbcavGZtRMg=;
        b=foRB8yhhCRC0AAX2Jrryc6jwnOvTh9m0U8quO1rqNWIHgHo8I4nFXqw+LtgScQC0Hl
         ta0UM16AJxQMEEPExbBj8cqSNoj03oq114EEEAESrdI6CQjZIsJJpQn4wtqyphSgKqir
         esjQxKv7Q9n/qGNQeIAqUDnz81H6u53/ZuJsiBGPtVhoxBVCWwVJBOV2HsOrlJWnqopu
         1M/En2gUmOUHxfzXQDiNz6hs2vLhkmn12+wuyIKrj8gqxVUaLlEhk59R38UxDA/HhF83
         5+5KOPhbIVmc6NxE5zzmUs+XxHep0Q1uu43XxWXZndcpApvFYofpox0yDm6u4Y4Q4e2y
         Bd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693890; x=1739298690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxLtuhE10MEuDrxCFADp/8wzNE83tQvqrbcavGZtRMg=;
        b=I53dzmuXkSfJ77Tc/JpgUFPooch/LvPIrO9oTMbTLmuQlcun6Ddob7VW60Q/utrEfI
         YfG/zTk6XGolRCDiDaDBOXH49l/sZPb5IRMsmFh/OGM4hH2JFHBzAJD4f/39iN4FMBcj
         Jwb5HMCAyUMwRh9nFbcFoCnMc4uTPLxvzEExnP/WNFeOH43YmG6nsQGy71+XtG9dIGa/
         2wbf5Iz/ql/k9mr8p+S/7/L4KZVajx6yvbLczzqeFU3WHGazOlCkZ0lZeEP2Kz8gIYqq
         EmUjk61+F5CeXNTIwWof+G9WIFjPyPoqTJLPza/eBRv+LJcpD3BNmxI3WmsXNteHqdYd
         nDbA==
X-Forwarded-Encrypted: i=1; AJvYcCX6BkBbPPof94fwEEHVNb89XK0znwcDK3RZ3FttMn6uZieWilMAHQK7sUVqCtfM23rohfymGqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLuimob/88Hga8kYBPTfUvxdr3FMAqbPdEKN/zNHFNh93gDE2f
	WWksrkcsIBU9akMnzH8vBi5Y06Y1AgZYVlP/cxADnwPEXtfWVvVn
X-Gm-Gg: ASbGncvNBDQgweRkg8wnzTTyR4DAkTYtauY7PrtKNAwoGW5/uaDsirgQNduC9SJD++E
	LEZ73jgJFgHBHXqo3FdeG+9rhn/HXpigMGfpIb+GyX1x3qo3tGRS3STf4pPHNTF1VHGyQOczDm4
	E/MHLcOCZ0CsdvqI2TZLzeX1093ll9DcDLf3v3gfWeunwPSCVjx94pqzKD8Y0QYBcnODBunYgj9
	CBN6uupVPkqGcdM9vU0JR7xEqhsJvDQUWDznE3MpN3oMhrNDrcnWBvQGSwdvMyanqm2qJSH4H8z
	JZCmlRkcwQJZ23av6luK/P1inKabfAkum3IaixH1PS3o+SIziayeUQ==
X-Google-Smtp-Source: AGHT+IFYsio+hsEy6VOpiXQ9YIsCcC/uZIT4OQtvUIez5wR+uUN6hRnoJrUAOs2l+xpg4ZQOQhJNSA==
X-Received: by 2002:a17:90b:5445:b0:2ee:a583:e616 with SMTP id 98e67ed59e1d1-2f83abdeb6fmr40850408a91.9.1738693889954;
        Tue, 04 Feb 2025 10:31:29 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a45sm11590591a91.38.2025.02.04.10.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:31:29 -0800 (PST)
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
	jolsa@kernel.org,
	horms@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf extension work
Date: Wed,  5 Feb 2025 02:30:22 +0800
Message-Id: <20250204183024.87508-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250204183024.87508-1-kerneljasonxing@gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After this patch, people can fully use the bpf prog to trace the
tx path for TCP type.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/ipv4/tcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c41..3df802410ebf 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -492,6 +492,16 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
 			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
 	}
+
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb) {
+		struct skb_shared_info *shinfo = skb_shinfo(skb);
+		struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
+
+		tcb->txstamp_ack_bpf = 1;
+		shinfo->tx_flags |= SKBTX_BPF;
+		shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+	}
 }
 
 static bool tcp_stream_is_readable(struct sock *sk, int target)
-- 
2.43.5


