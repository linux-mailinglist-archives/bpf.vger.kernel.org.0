Return-Path: <bpf+bounces-72181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A46F8C08C6F
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 08:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDECA4E7F5D
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 06:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D442D9EF2;
	Sat, 25 Oct 2025 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtDxybyd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E7326E6E8
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375207; cv=none; b=oEAIPsj8P/eetyBBc5Y41RxN/lZLE0XPz/9+mTaGz1wpztAmFBOUK/Kg77eW0rFBzsH8B+ykQGrQn3IV94TdH9HRhk5vcU9/EM6LUs7IqaPe5MWbmgX3nZ0Gh3zNR4Qo3+hwp3P2FWI7e8uT88L9xlS/H0XY+QXXMbl/io/UlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375207; c=relaxed/simple;
	bh=wijw4i1M0vTfBFIbS7+/cqkVMQiKCJdpRlsjiYYJilA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c20Bj5aAI03egbK/ViQH+kIsriLKbKgc7jOqirZqqVBtXlXyslYhwZHS0HpMQpXFhR/Togkjc4TpD99sXI9VTPx/O32NV1KkUz/YR5D3rtV+XBE8t3BfXJl7o/K6FN7WgFEovyn9yPZNUFceatIDV6xja0HQAKp/kdR9ltQqKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtDxybyd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781206cce18so2933783b3a.0
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 23:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761375205; x=1761980005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYxOi7/j9cjsZqMBUihMGCpPdFfgZqdeuZI37Hp+Tuo=;
        b=KtDxybydnYZddupZNm4crER3d/FqPBvKR8c6vqyzd63LC/9KJdzPlgX4Z1qaIbjxh4
         eDBdsFFDQWadwsAGdPvtMNghRXeC/1e/bwxcjfPpWt5CpxM7tzSqyVN59dkQiewKAhRq
         h9Ne+JLfPnEgitUbl0MNdL6X01dMbkkZCbf8uCDAuMl12AtGWmviU7y14CMibk/UUwZH
         PJo4ycEsDRAZEY51Ojq5RYwhc9J3HMCPA7S2fBxukPdNIsvpKciwCxH8PqAJVy23QAAM
         e7bc12n+Y4Ctd4HZNCQZKSuOYrGbgbeCkgWuUVbnWxzhb89hwID3x/cLv+4bI4oGI8Rm
         WO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761375205; x=1761980005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYxOi7/j9cjsZqMBUihMGCpPdFfgZqdeuZI37Hp+Tuo=;
        b=EmbPcKL8GOq+B0BJAOR0xzNfqOz4EOVY9zip6mw++G8Qkc0FPTBPI+KGRoru+R0ww6
         u1RqI1TtfjFi9WwKo4NYVWEyO8CIMRstcsbvrcO4iaG2EagWVcxppy43eKibwiXRHSTA
         PYYu6Yoasj7P58yBFe1l53RvWbs7AS/zuqnM4fb5APIU7CQ0Zhx5RVke0zr2SjvZfxcn
         at7QFdgUlpOv3i/fGbdSbJDSE08EDK+uKOSEVp5lxOgR4vGfXXFJ8phhjFSiLIL/IUKZ
         +TEOmBjoBNZu7BBg/mumfuwPRyoBQu6wWgNMqjFjUJyfhSw9Ei1u2VOTKH2V5+8wLph5
         zR/Q==
X-Gm-Message-State: AOJu0YxrmrOn/fa7zqYWpXP4NOkBBoa7/sG6p6Ax0/njnLI4kFT6gBm1
	cq/v8WN2OASXh3zDLhZb+nm3aPM6BCVQtt6BEs2zSnTOob9sIOtANC9s
X-Gm-Gg: ASbGncv8UypYSjTx0nQJ6GzsKVbUk/08yaS2az0wcQRZNQUb0wWVoLVfsSpWTPXtDVU
	ZVVuE0eH1qs3Xq4rBZEjKVP4VNnsPW2+wmuLLR6/3WnVO6ZZHp7fqJRIYR3XHkrypTd3QUcmFy0
	PKtpfmO/XQOaxRcT/LLRE0SFWLGdZ/t3GLxtpymxrNIzKdJ+gsrPmZ07uxUZF0XYyjrni6XG7b7
	zjIS+AYrseiwjieJInp+ckQtUqNEv9tXcEM4+csk/6GeOWZZL3PABpMQmhAPlB8EEwCMsMx7sW5
	jbs1pTPA5HvjOfd4Xpdkj27j6uJrQmugL/vQieG00AkJrEwm3TydhFUmJGqhvIN/H5Z4c9BVItb
	fiEMr13D4oR8jpUJXKm1nGM2UYB0D8sGjKSxgApK41yrg2ZVqCYzC93G56M2eNa5k1XQAjzVuWV
	1koNMwmC0ctc6QnzIvTMwHwd89x9YR+ojtc81IIi38XQ==
X-Google-Smtp-Source: AGHT+IFQ0YTZEGeIJ8YN+UDuP3ySMc4ZngeurKJEicfSScvo2krlJZu4E7wNkT5tG9m9tU42s7mT2Q==
X-Received: by 2002:a05:6a00:23cb:b0:7a2:7dab:d51f with SMTP id d2e1a72fcca58-7a284e62981mr6779258b3a.16.1761375205034;
        Fri, 24 Oct 2025 23:53:25 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140699basm1262820b3a.50.2025.10.24.23.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 23:53:24 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/2] xsk: avoid using heavy lock when the pool is not shared
Date: Sat, 25 Oct 2025 14:53:09 +0800
Message-Id: <20251025065310.5676-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251025065310.5676-1-kerneljasonxing@gmail.com>
References: <20251025065310.5676-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The commit f09ced4053bc ("xsk: Fix race in SKB mode transmit with
shared cq") uses a heavy lock (spin_lock_irqsave) for the shared
pool scenario which is that multiple sockets share the same pool.

It does harm to the case where the pool is only owned by one xsk.
The patch distinguishes those two cases through checking if the xsk
list only has one xsk. If so, that means the pool is exclusive and
we don't need to hold the lock and disable IRQ at all. The benefit
of this is to avoid those two operations being executed extremely
frequently.

With this patch, the performance number[1] could go from 1,872,565 pps
to 2,147,803 pps. It's a noticeable rise of around 14.6%.

[1]: taskset -c 1 ./xdpsock -i enp2s0f1 -q 0 -t -S -s 64

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7b0c68a70888..76f797fcc49c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -548,12 +548,15 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 
 static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
 {
+	bool lock = !list_is_singular(&pool->xsk_tx_list);
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&pool->cq_lock, flags);
+	if (lock)
+		spin_lock_irqsave(&pool->cq_lock, flags);
 	ret = xskq_prod_reserve(pool->cq);
-	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	if (lock)
+		spin_unlock_irqrestore(&pool->cq_lock, flags);
 
 	return ret;
 }
@@ -588,11 +591,14 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
+	bool lock = !list_is_singular(&pool->xsk_tx_list);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pool->cq_lock, flags);
+	if (lock)
+		spin_lock_irqsave(&pool->cq_lock, flags);
 	xskq_prod_cancel_n(pool->cq, n);
-	spin_unlock_irqrestore(&pool->cq_lock, flags);
+	if (lock)
+		spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
 static void xsk_inc_num_desc(struct sk_buff *skb)
-- 
2.41.3


