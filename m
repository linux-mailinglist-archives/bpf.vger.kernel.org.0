Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DAF2109DB
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 12:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgGAK7v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbgGAK7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 06:59:50 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9F4C061755
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 03:59:50 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b4so21666259qkn.11
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0sPTcwaHfjc8BjlQeotblIpfP730mwd5PECatEbAiio=;
        b=HkQ3xsUZWo64Obt2YWjYNZNh4SsoghoiXQlfd4f9oBpWjEhWsXY4ga6bYoinGv7614
         XDxXM37VZT51rlHb7zsyGauFZM29bNqU2cdx99i9UMr3WxPbGSmps8Ah0Q91yElnwlOH
         40D4J32UFv6T8dg3zEkUFj46hxCpuAJQaTI14JOCLKMAnMxTg3LIqX5eIdp/MqJfniz7
         FnVxsuhyLTER9OwXU02X3BFmkCFWes+E3LcRR49VnMOHv42i+9WFUqQcCHHaKi5SVnH/
         jblpkoFucRM2d93BLCvTMfI8Mo3ylWrARwfStlHXCoYRaQU4lwuC4qg5U82p4mDcWKrq
         sQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0sPTcwaHfjc8BjlQeotblIpfP730mwd5PECatEbAiio=;
        b=Ifr6VJoXttE8zdyu0WXAUnGM1iWQ2ZAf2W2g0B5/1lWin/Hf1TShV4unUjwzNfFZQF
         2GCS/XQNzuXkJyGIDJr6yjFvhwpb95POrSGi0dsvrKFfOsMOTYtjLP9FP50t59zAhWKP
         SaeJ8HqYjpmH16rBFzaXJzcCRJFb3ftYpdCBBaSvI77SEVJT50PlLtCWNcBnX3ETeROp
         erBaJlWoRIoYW+JYKY9YUxMy93D4F35+ln7Boaca9sTOP4EJ+LC79gxglTS5WPoODjyo
         ioJJwSbTGpQUh9gTvXTPhVqcv57T2MpB8l8D/RkiaClc/h3Tpor/lb1ka9+tYquuekxI
         dQsg==
X-Gm-Message-State: AOAM530A22Bs5iBlsQrC5rn+atmYai6tT6CPlzDeHKsfTdhi3bArMIjm
        Optm/zeCbYIMmX127od1wH2bU8MQcEzdFrVWUcDYkEjrtxI=
X-Google-Smtp-Source: ABdhPJxk2ey2QQwVRDvxxLbIikW47TwWKTexxeacGJ2I1w3qHZ/OzBCB2Ei+XcM8kJ8pRWwasY2fM59iB8mmncwoKYI=
X-Received: by 2002:a37:b9c2:: with SMTP id j185mr6294020qkf.274.1593601189577;
 Wed, 01 Jul 2020 03:59:49 -0700 (PDT)
MIME-Version: 1.0
From:   Yahui Chen <goodluckwillcomesoon@gmail.com>
Date:   Wed, 1 Jul 2020 18:59:38 +0800
Message-ID: <CAPydje-awJLYYs-u_5sEy=AYnxUcY28tteiCKiy5pLMisVOxnA@mail.gmail.com>
Subject: AF_XDP: soft interrupt takes 100% CPU when APP rx slower than nic's
 input traffic
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     steven.zou@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ring 0 of p6p1 can rx_drop about 1.4Mpps traffic, all 64 bytes long
packets, by kernel
xdpsock sample running with cmd `./xdpsock -r -z -i p6p1 -m`.
I change the samples/bpf/xdpsock_user.c code to make sure only receive 10Kpps:
```
git diff xdpsock_user.c
diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index c91e913..7bbffec 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -857,6 +857,7 @@ static inline void complete_tx_only(struct
xsk_socket_info *xsk,
}
}
+int payload = 100000 /*10Kpps*/;
static void rx_drop(struct xsk_socket_info *xsk, struct pollfd *fds)
{
unsigned int rcvd, i;
@@ -888,6 +889,21 @@ static void rx_drop(struct xsk_socket_info *xsk,
struct pollfd *fds)
char *pkt = xsk_umem__get_data(xsk->umem->buffer, addr);
hex_dump(pkt, len, addr);
+
+               unsigned long now = get_nsecs();
+               unsigned long prev = now;
+               int j;
+               for (;;){
+                       j=0;
+                       do {
+                               j++;
+                       }while(j<1000);
+
+                       now = get_nsecs();
+                       if (now - prev >= payload)
+                               break;
+               }
+
*xsk_ring_prod__fill_addr(&xsk->umem->fq, idx_fq++) = orig;
}
```

Then, run the xdpsock with cmd `./xdpsock -r -z -i p6p1 -m`. And check
the CPU usage with `top`.
Unexpectedly the si(soft interrupt) of p6p1's ring 0 is 99.x%, almost
100%. However, if I didn't
modify xdpsock code, the si was about 20% and xdpsock can rx_drop all
the packages. Fewer packages
are processed but more cpu are consumed, this is not correct.

Nic's driver is ixgbe. This unexpected situation means ixgbe_poll
doesn't deal with rx traffic
congestion well. A feasible solution is to make ixgbe realize rx
congestion and drop the packets
by hardware.

```
# git diff
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 5ddfc83..b8592d8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -430,6 +430,7 @@ struct ixgbe_ring_container {
u16 work_limit;                 /* total work allowed per interrupt */
u8 count;                       /* total number of rings in vector */
u8 itr;                         /* current ITR setting for ring */
+       int congestion;                 /* traffic congestion flag */
};
/* iterator for handling rings in ring container */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f162b8b..26e63f9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2542,6 +2542,12 @@ static void ixgbe_update_itr(struct
ixgbe_q_vector *q_vector,
if (time_after(next_update, ring_container->next_update))
goto clear_counts;
+       if (ring_container->congestion){
+               itr = ring_container->itr << 1;
+               ring_container->congestion = 0;
+               goto clear_counts;
+       }
+
packets = ring_container->total_packets;
/* We have no packets to actually measure against. This means
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index be9d2a8..2835cf8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -235,6 +235,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
struct ixgbe_adapter *adapter = q_vector->adapter;
u16 cleaned_count = ixgbe_desc_unused(rx_ring);
unsigned int xdp_res, xdp_xmit = 0;
+       int fail_times = 0;
bool failure = false;
struct sk_buff *skb;
@@ -249,6 +250,8 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
!ixgbe_alloc_rx_buffers_zc(rx_ring,
cleaned_count);
cleaned_count = 0;
+                       if (failuer)
+                               fail_times++;
}
rx_desc = IXGBE_RX_DESC(rx_ring, rx_ring->next_to_clean);
@@ -352,6 +355,15 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
return (int)total_rx_packets;
}
+
+       /* too many failure meaning traffic congestion,
+        * this would eat all of the CPU.
+        * packets should be dropped earlier by HW
+        */
+       if (fail_times > total_rx_packets/IXGBE_RX_BUFFER_WRITE/2){
+               q_vector->rx_congestion = 1;
+               return (int)total_rx_packets
+       }
return failure ? budget : (int)total_rx_packets;
}
```

The expected thing is xdpsock can rx 10Kpps and si takes a small amount of CPU.
However, the code above disappointed my expectations. The xdpsock is
able to receive
1Kpps only.

So, what's wrong with my code, or how to solve rx traffic congestion
caused by AF_XDP?
