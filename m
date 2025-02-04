Return-Path: <bpf+bounces-50450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88932A279DC
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6CF1882277
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387B8217713;
	Tue,  4 Feb 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj70skGH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E8217719;
	Tue,  4 Feb 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693897; cv=none; b=UXTKuj0DpTRVRgwDjY2lXJgnfj3g/Dmb+KhfmziwcHgam1fFnA/oEXPkj6DbGUKdKenQ7kjg+zBDGADuQXGh7kxIKVkQ3Uhl+Ai+YI/rvsdGXZiWNMHcXr+b4vxdAbM4UC+5adC3BH9vSo5MqdQ7y01Ov6NjMkgECX3h7/R8mQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693897; c=relaxed/simple;
	bh=U7E9mizli4Bk7jylQ/BPR7NIf1gctffza2LoYxYBHeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OSxfD7k0YUPIO8aAjDqCJzJIPvLLUe9VCiQVeF7G7vscEGVfszNTMxEbWxH76I0n2iE2/I8V/2qhnYCKqoO4GPFLLM3qsJhYk4sUFLtY/yrxnvMCb413TCbzohRai0RJlnt8UmAOYJDkh0gBWo6jD7BDbycPfwLNK1R0NQEgoCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj70skGH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso88426a91.1;
        Tue, 04 Feb 2025 10:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693895; x=1739298695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DRlgN3qVuWfs5Q4rRCKBtt/eYEeRjpMUiyPnMHhuq0=;
        b=lj70skGHGuLziXwOm3WiAogBqLdYKKNSmEasZPZzwrVzQYqZDK6P6L4cr3fNDAidfY
         EZczRr52Tbrjg3eeQBbLbJQ46FW5b676FQlvShYx2Xo9sG6w6e9bD0iY9J0cxT2fszI5
         R9WGUrW/8SGUZ5C5yTpYjXGWDGJ50Lg3PXf7exhKx7pFAAMKZ4xz3gedZ20iAcE5Ox+N
         aB4h0I6ex8HWVDTJh/S481gnFQUbm3qTX6k/iSTGqlDt+rAgL5DSEPcly1Y0uxn90FZh
         0zEwjiVWAncX8jPcjzqtpg8qgB9ScnNlJ456T1HStylgdrMG5ihHjEYA2w3n1NZ2aq3n
         4HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693895; x=1739298695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DRlgN3qVuWfs5Q4rRCKBtt/eYEeRjpMUiyPnMHhuq0=;
        b=eRJfDGPc7gffMNa+brAbrNfI0Vn6MDnSe7npGjTv+IcVZZbbRjDDKDYViYgkns9/kd
         fn2YrY+VCs3luIe9P4x4tAzTkl/SOOZE3XCyS7O0Wi/npvN+gQx0KNOyEmc/KsYt+r7L
         dZfk7r3hCoUvlDIO1WdzVlNMFnLr58i6xz+NRHT4veaMoOaK14pjxUTQcjD6mWVUQkND
         rhu0TPlMCD83tAX6apaKo+DIEgdfmPzZ0JC2sQoX+3mZGJEUoYV68oMlJ6xV/QE9Fzfs
         OFlLn7D4WaOTBuDgOwvYbTIIk+S0sVzGH+TJccxDpqOEP5r6B9eklwq6JnKrYYT9Elrz
         aF2g==
X-Forwarded-Encrypted: i=1; AJvYcCV87uBRUB/ItgzZtibiwWp2OaAnhHNqKwgn4B9h0ENAo5Npa7i8dwZO7egoXvlSSfGMfcojy8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiSp1AVRFQOO0GMXli7wngVlQnGMaX8cLtGu9jv+iOSTp26yth
	0nH7XDWPVfTjsUlieXkuvjq3fITmLynH49xlgrdVOppbZr0XbI+D
X-Gm-Gg: ASbGnctvYhrBd0dr5RoMcCqxl7LpiXHGryOYQFan4Yr3m4y8gEvp3mmnA//cUKiAtS9
	b0QaktWeFwH42VlN1RqdcHb6eqZUUSiRqlcOWMrMIlMnPDilo5tL9hC+3/8vj43cE2dcDV+D5fR
	XxjouiHjz6tom3VvORiYEXHI/U5JQI9Eoqkq15fqG5UKhcTp3+2funHMRfG7huAvCHYM1Rzc+th
	vFtrKoo2nCqqqXgXPrkyGI/30FhIPJqjOVI/U/3kQbTbzqTT2IL8qHLRS1ESn4TTqdMPZG90s/0
	iqeUNGiOfkK1RZSZUvIgwIvtvCAtjJymP3t9S60UHqRJwrnIYvhcag==
X-Google-Smtp-Source: AGHT+IFcJT+ALVYYNbzTyM7auTPPGJVRhKb/Gp+nFSLDgsro7nKlUTzUjf29NphzQ+zbO3GRvkaCWg==
X-Received: by 2002:a17:90b:2884:b0:2f9:9c3a:ed3 with SMTP id 98e67ed59e1d1-2f9ba73e992mr6512851a91.16.1738693895580;
        Tue, 04 Feb 2025 10:31:35 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a99a45sm11590591a91.38.2025.02.04.10.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:31:35 -0800 (PST)
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
Subject: [PATCH bpf-next v8 11/12] bpf: add a new callback in tcp_tx_timestamp()
Date: Wed,  5 Feb 2025 02:30:23 +0800
Message-Id: <20250204183024.87508-12-kerneljasonxing@gmail.com>
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

Introduce the callback to correlate tcp_sendmsg timestamp with other
points, like SND/SW/ACK. let bpf prog trace the beginning of
tcp_sendmsg_locked() and then store the sendmsg timestamp at
the bpf_sk_storage, so that in tcp_tx_timestamp() we can correlate
the timestamp with tskey which can be found in other sending points.

More details can be found in the selftest:
The selftest uses the bpf_sk_storage to store the sendmsg timestamp at
fentry/tcp_sendmsg_locked and retrieves it back at tcp_tx_timestamp
(i.e. BPF_SOCK_OPS_TS_SND_CB added in this patch).

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/uapi/linux/bpf.h       | 7 +++++++
 net/ipv4/tcp.c                 | 1 +
 tools/include/uapi/linux/bpf.h | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 800122a8abe5..accb3b314fff 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7052,6 +7052,13 @@ enum {
 					 * when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SND_CB,		/* Called when every sendmsg syscall
+					 * is triggered. For TCP, it stays
+					 * in the last send process to
+					 * correlate with tcp_sendmsg timestamp
+					 * with other timestamping callbacks,
+					 * like SND/SW/ACK.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3df802410ebf..a2ac57543b6d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -501,6 +501,7 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		tcb->txstamp_ack_bpf = 1;
 		shinfo->tx_flags |= SKBTX_BPF;
 		shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
+		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_SND_CB);
 	}
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 06e68d772989..384502996cdd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7045,6 +7045,13 @@ enum {
 					 * when SK_BPF_CB_TX_TIMESTAMPING
 					 * feature is on.
 					 */
+	BPF_SOCK_OPS_TS_SND_CB,		/* Called when every sendmsg syscall
+					 * is triggered. For TCP, it stays
+					 * in the last send process to
+					 * correlate with tcp_sendmsg timestamp
+					 * with other timestamping callbacks,
+					 * like SND/SW/ACK.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.43.5


