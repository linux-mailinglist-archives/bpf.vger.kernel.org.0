Return-Path: <bpf+bounces-61745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67330AEB1F1
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 11:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6262C7A8597
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5216A293C46;
	Fri, 27 Jun 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYwzdnyM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C929346F;
	Fri, 27 Jun 2025 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015049; cv=none; b=iQmpDt6a7ZyDRgdm4ZZi5tMYwW7aWdffd09fmzOBme0rXvat3SdZEzgdMT2gOUHy3u5jddMyiRpMjqjp7KOz6gaAh55dRKQv9PtevliGqKFRxmN7RCINDmHFJ8juxjtjMnDgsO84iY6GTBplB58jq4bT+szG4ywXmFvBZlgP6U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015049; c=relaxed/simple;
	bh=26Z1MwHnjk2h7wspYJq72P8Nt3nRYsPC+dd6E2tbHiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rqzs3OdzEm4mKYb1VkgZpPgKv62tkpIgMdV80GzgH+fBLNfFJGOaTybjn6ehtL+hWoR9bjIgbDZDONiwpe2TUo0lYELKG95wVoy4x82XMpjWSVZovbwMMBZtgRPy7hKrXsPkcPTTx6FEDtbS01aTmpEnBbEykG63mB1m79H6tlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYwzdnyM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so1803855b3a.1;
        Fri, 27 Jun 2025 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751015047; x=1751619847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+OPOjWi2p5Z5MHfvR9PBiYVVI5F5wJufIgUU5dhlzxE=;
        b=QYwzdnyMXyzC/AkjUu+yLzPM4JBPyFuOqerNlmYneVAZoFc6ADqf5+esANONCuLIl4
         CS8oTCfd0kUw42QtYWVN3ON44t2T1IEb8JCUZPlWzTiQ/a8cgDvP3XVyutFZ6/lcmPCe
         y06KezVNckEazH9MBDXS4N80TTql4cBrww0xUxt17cbvdLce2hs+3mOuLv8HwpoqgkD7
         YeTo8leP0KJHhJv4Ljb7AB5fVbBcduq11LKT3UetyeLS3/Hrz2ayYLrZE7sgdXA0DbvL
         U99kY4OP/hd9vZKzX2c5OSJn4FntClnCODkkr5MwhmTLkcFIEn11+sE24P/+ktWOkOmR
         asDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015047; x=1751619847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OPOjWi2p5Z5MHfvR9PBiYVVI5F5wJufIgUU5dhlzxE=;
        b=pPha3/yf0x60fMiHwykMyAj41MR/XJDAhaoK+CKDu+P1xLXHkeRxDYLBeUhChxc02+
         sSpu8+gG/ezo/JH+XwakbW9uA3u0nmUjUsOs0XIpRHp7kP4VByS5KUSX5i1QYB1W3MIE
         5mjgQOAbHME4HBQQlx3S5AV6t4MpDdK+TJVXuWA2lGQuFfK4W489qbEIr1+AEqwskqQL
         EatK3fx27OInM05iyXo6fcundPeo1ho2AnmYhG6oT9TpOz1xTHLqSNGnsikdyaWgijok
         C7U1EXfC2wrTaJaBIwOjEwNvUbaCywxqrYQ6EkYSCkk+GwJOq3SXE2Zw4fL3Dhfxr/pV
         pxXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3NbkwiI9v7+tOTkGlk/cNX3uF7Y3FeNnB6FSKmoTBhczhcVT39tLun7CawgNJF6LRPYGwaAXOdXD4NV6o@vger.kernel.org, AJvYcCUaKYHffPD6j2C8T9+sbFOLYr8kOrJXCxi8Xa5yh2nHGuS6zlU6w4wK/zPI92INYWp1Wkk=@vger.kernel.org, AJvYcCVf8xcDBhlopQUz+MVMGSIvMbLQ/GlA+eQTNfI6KV1Nnm60xN1KSaWCoHUNHTrNZoOPvYJTNL25@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sMXnb7FuPPVpAFraTkECgPB1QbMNKugwVq7lur/X0AeQ/UZ0
	RBfxPtuAyv9yvtroO0W+RwqJECx87bb0LRlmeRzZceHBuJLARyvT5otM1qG09Drt
X-Gm-Gg: ASbGnctsnA0hGUQZcXbhx8cGeALOokG2ZZmE2kc2Mbrqulgi3VpyEKc7QDnbqKjUm+o
	PLbRgCG3G/0kHj1tm0Ag6DRZKXyr5RIvoKr3yimxrqyXo5rHTOKTcPzvgzoKe829zbpFaE2+dH5
	wDD7akexEXTnmDEaCQMP1JMmdatV0eHsYnNDeX5EUaTZk40vFL13K0cnzm64F5oU8tosMBkC1++
	AflXFB3svvFExiGKGs2wZ2EfkVJ575pAr055R+B+Dzlkd6mbQeZaWjgN+Rb3qZPd4iOjMuuFFEp
	jyy3UBHs/R1JRrP/UfKicpKPkrXDXs6t38GIA/4BGReHWSi9fl0EjoCizXYNputlweVrZD2e/j1
	3o+JEFLs=
X-Google-Smtp-Source: AGHT+IFi7uSNU0NXFWo1RpPm1TGTKsqRNAglzlIgdaPSrhHfNLCIMhftBcZcOffl8C56MCw/UDFE6w==
X-Received: by 2002:a05:6a00:8ca:b0:749:1e60:bdd with SMTP id d2e1a72fcca58-74af7893218mr3329499b3a.2.1751015046910;
        Fri, 27 Jun 2025 02:04:06 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c67:6116:afb5:b6ab:2dc8:4a21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b389sm1846158b3a.35.2025.06.27.02.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:04:06 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.fastabend@gmail.com,
	daniel@iogearbox.net,
	jakub@cloudflare.com,
	lmb@cloudflare.com,
	davem@davemloft.net,
	kuba@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	cong.wang@bytedance.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Xu Kuohai <xukuohai@huawei.com>,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH 5.15] bpf, sockmap: Fix skb refcnt race after locking changes
Date: Fri, 27 Jun 2025 14:33:54 +0530
Message-ID: <20250627090354.10491-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit a454d84ee20baf7bd7be90721b9821f73c7d23d9 ]

There is a race where skb's from the sk_psock_backlog can be referenced
after userspace side has already skb_consumed() the sk_buff and its refcnt
dropped to zer0 causing use after free.

The flow is the following:

  while ((skb = skb_peek(&psock->ingress_skb))
    sk_psock_handle_Skb(psock, skb, ..., ingress)
    if (!ingress) ...
    sk_psock_skb_ingress
       sk_psock_skb_ingress_enqueue(skb)
          msg->skb = skb
          sk_psock_queue_msg(psock, msg)
    skb_dequeue(&psock->ingress_skb)

The sk_psock_queue_msg() puts the msg on the ingress_msg queue. This is
what the application reads when recvmsg() is called. An application can
read this anytime after the msg is placed on the queue. The recvmsg hook
will also read msg->skb and then after user space reads the msg will call
consume_skb(skb) on it effectively free'ing it.

But, the race is in above where backlog queue still has a reference to
the skb and calls skb_dequeue(). If the skb_dequeue happens after the
user reads and free's the skb we have a use after free.

The !ingress case does not suffer from this problem because it uses
sendmsg_*(sk, msg) which does not pass the sk_buff further down the
stack.

The following splat was observed with 'test_progs -t sockmap_listen':

  [ 1022.710250][ T2556] general protection fault, ...
  [...]
  [ 1022.712830][ T2556] Workqueue: events sk_psock_backlog
  [ 1022.713262][ T2556] RIP: 0010:skb_dequeue+0x4c/0x80
  [ 1022.713653][ T2556] Code: ...
  [...]
  [ 1022.720699][ T2556] Call Trace:
  [ 1022.720984][ T2556]  <TASK>
  [ 1022.721254][ T2556]  ? die_addr+0x32/0x80^M
  [ 1022.721589][ T2556]  ? exc_general_protection+0x25a/0x4b0
  [ 1022.722026][ T2556]  ? asm_exc_general_protection+0x22/0x30
  [ 1022.722489][ T2556]  ? skb_dequeue+0x4c/0x80
  [ 1022.722854][ T2556]  sk_psock_backlog+0x27a/0x300
  [ 1022.723243][ T2556]  process_one_work+0x2a7/0x5b0
  [ 1022.723633][ T2556]  worker_thread+0x4f/0x3a0
  [ 1022.723998][ T2556]  ? __pfx_worker_thread+0x10/0x10
  [ 1022.724386][ T2556]  kthread+0xfd/0x130
  [ 1022.724709][ T2556]  ? __pfx_kthread+0x10/0x10
  [ 1022.725066][ T2556]  ret_from_fork+0x2d/0x50
  [ 1022.725409][ T2556]  ? __pfx_kthread+0x10/0x10
  [ 1022.725799][ T2556]  ret_from_fork_asm+0x1b/0x30
  [ 1022.726201][ T2556]  </TASK>

To fix we add an skb_get() before passing the skb to be enqueued in the
engress queue. This bumps the skb->users refcnt so that consume_skb()
and kfree_skb will not immediately free the sk_buff. With this we can
be sure the skb is still around when we do the dequeue. Then we just
need to decrement the refcnt or free the skb in the backlog case which
we do by calling kfree_skb() on the ingress case as well as the sendmsg
case.

Before locking change from fixes tag we had the sock locked so we
couldn't race with user and there was no issue here.

[ Backport to 5.15: context cleanly applied with no semantic changes.
Build-tested. ]

Fixes: 799aa7f98d53e ("skmsg: Avoid lock_sock() in sk_psock_backlog()")
Reported-by: Jiri Olsa  <jolsa@kernel.org>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Xu Kuohai <xukuohai@huawei.com>
Tested-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20230901202137.214666-1-john.fastabend@gmail.com
Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 net/core/skmsg.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a5947aa55983..a13ddb9976ad 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -608,12 +608,18 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 			       u32 off, u32 len, bool ingress)
 {
+	int err = 0;
+
 	if (!ingress) {
 		if (!sock_writeable(psock->sk))
 			return -EAGAIN;
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
-	return sk_psock_skb_ingress(psock, skb, off, len);
+	skb_get(skb);
+	err = sk_psock_skb_ingress(psock, skb, off, len);
+	if (err < 0)
+		kfree_skb(skb);
+	return err;
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -681,9 +687,7 @@ static void sk_psock_backlog(struct work_struct *work)
 		} while (len);
 
 		skb = skb_dequeue(&psock->ingress_skb);
-		if (!ingress) {
-			kfree_skb(skb);
-		}
+		kfree_skb(skb);
 	}
 end:
 	mutex_unlock(&psock->work_mutex);
-- 
2.49.0


