Return-Path: <bpf+bounces-62102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1F8AF13D8
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 13:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4334A3B224A
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33072620FA;
	Wed,  2 Jul 2025 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOw+tcQh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926C2367D3;
	Wed,  2 Jul 2025 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455710; cv=none; b=OG8nqjVe3k8P/u81DisW3ai4CcVxIaoMNQP4q9He8shTAtU0J3/z5RJlKcK2m9L/N1Zjkk8CXOyHZ83eWJuT+9mam3ThbAwIuArY409bD8Xwq2V1kQN8aDIm2nFKMtC/kJkdEG43+xr+2ZShibs2aUmeCY/WwfLExB5+RkVlvv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455710; c=relaxed/simple;
	bh=AkCP8cLjfpSwT7G2NNjh4zmpmO3MEoSO6pAYrNiYkyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gy7sSxRr+0olEQq6pg2Sxlqgebg62eLr+TonjtRytTuZGKdXvOABxAhVzZZuv5b57SCjzUgF26LXPEqPjcl5+Sohd5+ZJwRAw4KPbzgCmqWqpS5hTOWJN74wj1seU9BsEoEt1hlRFM+du7JqgCX4fUNHmh0mOMSWBPWG/uSD3HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOw+tcQh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747e41d5469so4804025b3a.3;
        Wed, 02 Jul 2025 04:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751455708; x=1752060508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgrpbUm7WZ5EDAK6pL6YzXkQ2H20jKjHUYjS7QmkuEo=;
        b=LOw+tcQhdplIrGPHcD74i73tvK2EwRKCdGfiao/ajP2xrehGzXvhsVRim8qWKs2iHa
         jsK0dBTFI61J9ncS74uiPKzjM025feLMwP+PzR0G41WBrbFKSSkNUy9nUQ5/BmQgrfzt
         1LKe6+22QFZ5iwMayMpYejSZ8haPqT6QHIIScCkDk4IOHvECvVq2tpEsmpE84uFwWeoD
         6cmp5KInB/t6LCYjlAm8FIsOOsXTz3QwGl7f+MhY5CAQDVXbkw15T9ldQSlTjoPmSHSw
         uepzU7z/P1iWo0vrWJxN/kAA21PdIP8HXpUlBsLopWZV+r91bOhenXe7yxSf5HdSEMin
         c7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455708; x=1752060508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgrpbUm7WZ5EDAK6pL6YzXkQ2H20jKjHUYjS7QmkuEo=;
        b=ix48D/FP0OQBvigv8dG6rrHFJpnU4XS7ED9ntsDKZW3zugLJ3Ot/Aohm5gS7+RGx9Z
         fnN4yEzZ77SS9g2G6cLzpPbKAI4rgJ/SMJXpjs19FM5cGfZGbx/Ql6tC0mx8zg0w3Ud0
         gMSNrS3PugIyiEpM0dyr5cn876+cffi9Z1neq3QLmVxr7BpPoSij4ks//M7W+l4SUEw5
         UP8lhwtQx8pUitB3XsB18Ha3zj0a/I5/okfAmgzN0MRiOaRVFAk7s4xU+o2+xUxt/Ayr
         +HGsE5vvKFNMbK6W7bpslYB4ov4q7fx/O4i+jAARMagZVi9F4qfGo5KtC017ETtoVE4t
         3hZw==
X-Forwarded-Encrypted: i=1; AJvYcCWdd4ey5Gj835SMpALb1HG4SgB1ywct/dJOpotM3W1S7uJNcJEmR6i6METbO06IBfsgR6KfXDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/plTzoOtxb8LU+HpTjMYxfcNTmvoTbzv61vAF7x55KrNNi7bC
	tFyXNqlgzA4izyH3FIkCaJh6p7cWtWlFooiMvhsv2FvQPiI46+gnxVqz
X-Gm-Gg: ASbGnctVH+VEk9NR/PLbCiKvq1174S1csD7MujKJnj2XQ727896g+6goS8mVOjO3K+d
	LxQNJxLXb2b/MmGvYoiwmBROlvEnpyyVFsCk3c0l48H+A9zgQgBmwRaeE6RLlbJvxfu05pzymrD
	wmVreUhpDqc/Vkht5AXGvjhDfDx8xWQG+e53Mx7sq6uz2jqCOa4QbE207MQY3Ndib/Htcim55iK
	3lLLUX0RSpcH38dSmVoryMku1Tgl5AxANpYpqpMM/Z+ItYFGjE+J333m3LnWHNngkqf93pLJXA9
	GmXtoFe19/wZVubQy98NZRtXFz7Me7XDbLRASgTA7h4KQA5slevqVM8X185gs/WBpBtGy/7pGr7
	8EsGAt2wp03DLpr6l3uyKKLnMGS+zHN/elg==
X-Google-Smtp-Source: AGHT+IG9TfeBrXTLhcfdx7hxD8vWfzGV9PzVMaHEnikGFXjnzT0Deii+9uob/bNa6Z71ZifBYcykyA==
X-Received: by 2002:aa7:88d1:0:b0:748:f135:4fe6 with SMTP id d2e1a72fcca58-74b513206c3mr3402212b3a.10.1751455707836;
        Wed, 02 Jul 2025 04:28:27 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57f7e6bsm14437529b3a.179.2025.07.02.04.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:28:27 -0700 (PDT)
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
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 1/2] net: xsk: update tx queue consumer immediately after transmission
Date: Wed,  2 Jul 2025 19:28:14 +0800
Message-Id: <20250702112815.50746-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250702112815.50746-1-kerneljasonxing@gmail.com>
References: <20250702112815.50746-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

For afxdp, the return value of sendto() syscall doesn't reflect how many
descs handled in the kernel. One of use cases is that when user-space
application tries to know the number of transmitted skbs and then decides
if it continues to send, say, is it stopped due to max tx budget?

The following formular can be used after sending to learn how many
skbs/descs the kernel takes care of:

  tx_queue.consumers_before - tx_queue.consumers_after

Prior to the current patch, in non-zc mode, the consumer of tx queue is
not immediately updated at the end of each sendto syscall when error
occurs, which leads to the consumer value out-of-dated from the perspective
of user space. So this patch requires store operation to pass the cached
value to the shared value to handle the problem.

More than those explicit errors appearing in the while() loop in
__xsk_generic_xmit(), there are a few possible error cases that might
be neglected in the following call trace:
__xsk_generic_xmit()
    xskq_cons_peek_desc()
        xskq_cons_read_desc()
	    xskq_cons_is_valid_desc()
It will also cause the premature exit in the while() loop even if not
all the descs are consumed.

Based on the above analysis, using @sent_frame could cover all the possible
cases where it might lead to out-of-dated global state of consumer after
finishing __xsk_generic_xmit().

The patch also adds a common helper __xsk_tx_release() to keep align
with the zc mode usage in xsk_tx_release().

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
v5
Link: https://lore.kernel.org/all/20250627085745.53173-1-kerneljasonxing@gmail.com/
1. add acked-by tags

v4
Link: https://lore.kernel.org/all/20250625101014.45066-1-kerneljasonxing@gmail.com/
1. use the common helper
2. keep align with the zc mode usage in xsk_tx_release()

v3
Link: https://lore.kernel.org/all/20250623073129.23290-1-kerneljasonxing@gmail.com/
1. use xskq_has_descs helper.
2. add selftest

V2
Link: https://lore.kernel.org/all/20250619093641.70700-1-kerneljasonxing@gmail.com/
1. filter out those good cases because only those that return error need
updates.
---
 net/xdp/xsk.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72c000c0ae5f..bd61b0bc9c24 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -300,6 +300,13 @@ static bool xsk_tx_writeable(struct xdp_sock *xs)
 	return true;
 }
 
+static void __xsk_tx_release(struct xdp_sock *xs)
+{
+	__xskq_cons_release(xs->tx);
+	if (xsk_tx_writeable(xs))
+		xs->sk.sk_write_space(&xs->sk);
+}
+
 static bool xsk_is_bound(struct xdp_sock *xs)
 {
 	if (READ_ONCE(xs->state) == XSK_BOUND) {
@@ -407,11 +414,8 @@ void xsk_tx_release(struct xsk_buff_pool *pool)
 	struct xdp_sock *xs;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
-		__xskq_cons_release(xs->tx);
-		if (xsk_tx_writeable(xs))
-			xs->sk.sk_write_space(&xs->sk);
-	}
+	list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list)
+		__xsk_tx_release(xs);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL(xsk_tx_release);
@@ -858,8 +862,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 
 out:
 	if (sent_frame)
-		if (xsk_tx_writeable(xs))
-			sk->sk_write_space(sk);
+		__xsk_tx_release(xs);
 
 	mutex_unlock(&xs->mutex);
 	return err;
-- 
2.41.3


