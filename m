Return-Path: <bpf+bounces-61743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3FCAEB1D0
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 10:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4509118998B5
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40A127EFE2;
	Fri, 27 Jun 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbtTDS4p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7F926B2A9;
	Fri, 27 Jun 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014680; cv=none; b=Mud86kk2yt0EQfPaiWuQM8SvFtS8GwWbyfvlYRMLJ7b/rO9UXqeywczBwKwEgL0ECGDgMF0bs5u2B8BCNqcwOehXUFKEM/okUpkybtSj54QgIUlXlgp26d2SxoNQgLeZP5f7ghFTnhpgA19dKqeDdOb9yAgr45FmvENDrPxyr+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014680; c=relaxed/simple;
	bh=64lzhlOS6Ll3JYiI4Hq2fiWauytvfVKyYUj/LfcsYHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKuKhOvIqiVPrhGHBLDNWZNHU2YSpEbJRS2+Rz72OwYqTvqNvPrmSsdudekaH7tEWJnxiIAZ6z8r6GmVFrRYtK8hgzQ5vnc19qOag1U/72zsYVqu4Z76Thf15slyptVV6BvLbwwa7gApgH1yqSueeUyPPSOG0wj6ydz0eg1IpFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbtTDS4p; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c3d06de3so2281285b3a.0;
        Fri, 27 Jun 2025 01:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751014678; x=1751619478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rma6I+SMCg5IFTS6MQYQICW/eD4GzCgZ+2ytJ8punCk=;
        b=JbtTDS4pbUzZzdAKkqmjQukDebX4nnIz7rMZGEFNPxFm7F/9wRqhzawgl3lNpJz7ee
         8uTanw+z2hT46Z+BzfcesjlI3AQdDfQzlggiwT/q8qUSlPQT+I2+SsYK3yXAP4eEDv3N
         HFDY8FX1ICtGUlU/L14+4q9ycY+TSEOhbQ32EQ9u4xEBv8MI5sb3fgu6riN9x4OeAVJi
         K2OVcX6DOEtFcqhuKIruKKPmTPjqt5wq1n97/F+eddBtfCD3eUL5zgK8fwMffyWdgUqC
         8aQcwJSselsx8Bch85c64G4Z1aBccY7euLd+0jgyGbZR9hfu+00j4spAbeoEpCdPPmKV
         aHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751014678; x=1751619478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rma6I+SMCg5IFTS6MQYQICW/eD4GzCgZ+2ytJ8punCk=;
        b=mw0DYRKaq3uGDHtrEfhtU0foaMPbunyVa9zsTBCJZp5fORcu0GvTmMZkhmHZ9FYVGl
         TS4phRWKC9TnoZ57/7iRTF7Lw9RIGLi0e7ZZ3Ab1qnkHtlELVfDLhE2VkLnTlObOPZD/
         IuoJ1zNaIKGxUwRCD/YQfdvGZp5owtM7RGWVnnKz0vZLBpB+nh9T689v9txyJjcd1s80
         e/X3cadvguVeHUcsVFjeov/uFGp/lf0P73IFIaDQca7g0xxk/CGz/dsGqNmswrBFhr1K
         AKo/vWiUrtHWnfbhZXHhf3FHheiCNgfXuynqA8Tijn7w9khzj3yBo379SNh2k3Vxk9lf
         NruQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4JRTmrCJy9nCS0uxxwGAGx3ynj4jTjCLAqK4HKOMzq35Hl88ZVqzCgTb+T5q1ndW6xVkjhf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cF3v8eEjZUPXqrH7QrMzWt/9PXqnDd5Y2azFJQKX3h2ZdA5F
	3mI7hXSwlWKd1VvbyS+pEacLe2lYQZQ80TXLob220bdNcqWmXF8tyk+/
X-Gm-Gg: ASbGncuF2+abBhJQjzRwD4MlqnsQRZcWmvuGw+1NQFcg/VQLlCg+kZ8WQ7PhL9NJ/y0
	npEOm91LId21cvDG8kOXNE5iG/gNBPzXOL3giBYRrYA7G6xdUrZUoVEFkCHrc8a1hpBTyc5T8g+
	c/enV0wbq9e4r1MgIE5RXUhge78jRZcB4hlrpSzpvOaPhvzRNbWNs4dIc3sve1CwWNWlJiuyd/J
	eu0JlWSUm5aEkSZA0dFjb2ADzEf6ABI4lSSwpWgXTy+gSjjSI1herAZum9y92wPjasWuOv88hy9
	5SL+iCoXx9iA4Tt31lyZREAkPH+vRTKQSTu3+PB/b1CmsXpdQF2TUaVUslUuIlEI4xKeV6KhZQW
	3DlyDWI5xCAd2+BNugzDuFfRMHLi9TqU5Iw==
X-Google-Smtp-Source: AGHT+IGDfYTyJK2+wO160MzBuwuUf4yB67HKOLYrS011HJWbDof+z0WsnVBAxJlBZkDpPlr1PiWxqg==
X-Received: by 2002:a05:6a00:1388:b0:740:9e87:9625 with SMTP id d2e1a72fcca58-74af6ebb80fmr3571408b3a.4.1751014678294;
        Fri, 27 Jun 2025 01:57:58 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b3d9sm1728170b3a.2.2025.06.27.01.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 01:57:57 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/2] net: xsk: update tx queue consumer immediately after transmission
Date: Fri, 27 Jun 2025 16:57:44 +0800
Message-Id: <20250627085745.53173-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250627085745.53173-1-kerneljasonxing@gmail.com>
References: <20250627085745.53173-1-kerneljasonxing@gmail.com>
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
---
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
Side note:
1. in non-batched zero copy mode, at the end of every caller of
xsk_tx_peek_desc(), there is always a xsk_tx_release() function that used
to update the local consumer to the global state of consumer. So for the
zero copy mode, no need to change at all.
2. Actually I have no strong preference between v1 (see the above link)
and v2 because smp_store_release() shouldn't cause side effect.
Considering the exactitude of writing code, v2 is a more preferable
one.
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


