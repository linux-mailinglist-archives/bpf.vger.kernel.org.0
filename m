Return-Path: <bpf+bounces-35514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51B493B386
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FF61C21259
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 15:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7663D15B547;
	Wed, 24 Jul 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeCDDT3w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491E15956C;
	Wed, 24 Jul 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834524; cv=none; b=T7gn5DhiZ44kz9a7iHeLclxanvOMAwlQ0267vU2mvY9ZfKiDFCo1t9M4MNiyrla10kWZjcgouYfyA1ZY6kTkEbqHDBHM8WavynvJDnrOXMQs61InS+/hMHeK9kJYlZj4/LqYz0MU+KnLYAu276QwuxGoDRMu5BH9zB0GhVjKBXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834524; c=relaxed/simple;
	bh=Ceg3RUmf4rRNIpgCeYe8s41+WFlcX7caGHWlez9+62c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NcJFg4rjALupgyrmsP2l8Bw4Cv05voJjEtpemN9VDjDJgTTEm7NJSK5cmmNO2/UbAmGYztJrLPe9j59u8QpboqnMdXrTZZayvpmgWErDdQ4Udb0jBqEO71TgIvtiYUNZcpeXV4dTR808IV+3psZsDzw+kTGEpnC4l2ZohbHU5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeCDDT3w; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d19d768c2so2794870b3a.3;
        Wed, 24 Jul 2024 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721834522; x=1722439322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnWZ1fT4b6BKlSSpK5hIlpD5167p0pQD25Swl/fcV10=;
        b=KeCDDT3wD0NB9u3WikeTb0eU9rR2MPK5hsUJj13oPQro9N7hZ4Jy1CqLpUYx8V1B7Y
         w5Ri0DR8MKE3DY9XD1REDUg2hPPhj6g8iPapeJJH3b8qmFwDwm3JycxOx7JI7Me/baY9
         xaWvqL4PBvAFPSMgeBPag8goJlZXmGMTW9JvrOnwXRkp1jKn0L80xeu/QfPC6RZSh3mk
         8s+6Z5Y0o83VdeZZQbISW/6JPXxnmG5zxfodkrtb9Pmr7HgaqCBDafXdKEaqVJV0wXZO
         sD4yrtdQlj83ykZAzgB3AlcmiB3P85KM9dvi+LXrfgNq0afdWn0zMkAxcgiS2xOtsiwu
         Zowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834522; x=1722439322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnWZ1fT4b6BKlSSpK5hIlpD5167p0pQD25Swl/fcV10=;
        b=GPkhpJ96g481og05lk0stgf3yj0Is0dtUhFeU7TW5FlKSQMIZbskd7w7U/QL+rXOO1
         prisvWCLOc3T/Q2O7x+JEZUwvJY36CT+oRqBhsZqJbHWU8xP6DhrJl/WmIO2JhsjH42e
         4G+/jH+ZehglAhk8CUzqFQ1rOmZ0JxS8wjHQY16Fxzzwh2cin5Z3YjQRQ63bSjwSQj96
         oe39YfOn0biiG2UU4NaP77ZncmnYYQKZ3qBlJRPypP69izPq+MbGkiPlI7niBaeK5cWT
         A0DOB663d6jd4JztYzEPXyegrMDSWDddcqOpduAJ1+BRHaJjUYkGS4qWMp4+TRuBYgZ4
         2f3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFPT7CiZdVj7QUKQ1OFZHPJkW4Rrpfo0DFR7llhip8BE3U1WdHXAvNLqjY6a5NV66JsAjFjgpo3/7IoQ3poRmJ1HdjmEFtdeA6kp1ZkeFd7WTGuzMc86dVDgtFfwbX4yLLgL4EiyoOAKfCVYijTUDb2z4vXiDcdlLT
X-Gm-Message-State: AOJu0Yx/7gV/MqjUWDOw8PUVSxmTcrOHiKzK/uutms43N/LLFf7qbTWN
	frMwaPZB/Qs/Mghpyl2WVKJw/PUIhyyxGFtm5uFP0R8a6cD2fp8v
X-Google-Smtp-Source: AGHT+IEY1lKR6G96tR7c/kmoW2BGAluJLADlcsBi4H9Y5GTy7y2rfUO8QJUd6cnHLjjBW7nJ9DU/Ew==
X-Received: by 2002:a05:6a21:1807:b0:1c3:b1b8:e01c with SMTP id adf61e73a8af0-1c4733d6c7emr90844637.49.1721834521728;
        Wed, 24 Jul 2024 08:22:01 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff59cb7dsm8987522b3a.144.2024.07.24.08.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:22:01 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com
Cc: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net] tun: Remove nested call to bpf_net_ctx_set() in do_xdp_generic()
Date: Thu, 25 Jul 2024 00:21:49 +0900
Message-Id: <20240724152149.11003-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000949a14061dcd3b05@google.com>
References: <000000000000949a14061dcd3b05@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous commit, bpf_net_context handling was added to 
tun_sendmsg() and do_xdp_generic(), but if you write code like this,
bpf_net_context overlaps in the call trace below, causing various
memory corruptions.

<Call trace>
...
tun_sendmsg() // bpf_net_ctx_set()
  tun_xdp_one()
    do_xdp_generic() // bpf_net_ctx_set() <-- nested
...

This patch removes the bpf_net_context handling that exists in 
do_xdp_generic() and modifies it to handle it in the parent function.

Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/tun.c | 3 +++
 net/core/dev.c    | 8 +++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9b24861464bc..095ada4a525e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1919,10 +1919,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (skb_xdp) {
 		struct bpf_prog *xdp_prog;
+		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 		int ret;
 
 		local_bh_disable();
 		rcu_read_lock();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		xdp_prog = rcu_dereference(tun->xdp_prog);
 		if (xdp_prog) {
 			ret = do_xdp_generic(xdp_prog, &skb);
@@ -1932,6 +1934,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 				goto unlock_frags;
 			}
 		}
+		bpf_net_ctx_clear(bpf_net_ctx);
 		rcu_read_unlock();
 		local_bh_enable();
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index 6ea1d20676fb..26f9fdd66e64 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5126,14 +5126,11 @@ static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
 int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 {
-	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
-
 	if (xdp_prog) {
 		struct xdp_buff xdp;
 		u32 act;
 		int err;
 
-		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		act = netif_receive_generic_xdp(pskb, &xdp, xdp_prog);
 		if (act != XDP_PASS) {
 			switch (act) {
@@ -5147,13 +5144,11 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 				generic_xdp_tx(*pskb, xdp_prog);
 				break;
 			}
-			bpf_net_ctx_clear(bpf_net_ctx);
 			return XDP_DROP;
 		}
 	}
 	return XDP_PASS;
 out_redir:
-	bpf_net_ctx_clear(bpf_net_ctx);
 	kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
 	return XDP_DROP;
 }
@@ -5475,10 +5470,13 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 
 	if (static_branch_unlikely(&generic_xdp_needed_key)) {
 		int ret2;
+		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 
 		migrate_disable();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog),
 				      &skb);
+		bpf_net_ctx_clear(bpf_net_ctx);
 		migrate_enable();
 
 		if (ret2 != XDP_PASS) {
--

