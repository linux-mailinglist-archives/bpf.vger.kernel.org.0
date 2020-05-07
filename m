Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C641C96C5
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEGQqS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 12:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEGQqR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 12:46:17 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CC2C05BD09
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 09:46:17 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id x2so1431126ilp.13
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xTRCZ4tW93FlQDi5UVI2IwLTt/gRd10gzUrxWk69L20=;
        b=tNVqnuOWgFXs94wWijiHSZqW2RCSvX1eMyUhS1UUdpeRxO1VQfci5pvCuieJC03TjQ
         1v4TjWXve+qPDiY1IEF3ZfFRcMpna9fmYEg+45XaGG+FNcXoqF+jB7tmFWn64eqtOd/d
         kmCPIh21DTj45KeMrYpCuoW2CzXU46fDOVwrkNZ54WB/PzQkiw6Rdygu9pfJtNEKV3oR
         sos0yT6Zpz8TDhgCETAfpxk3vG2ztkba+7DmW3Xe9dP1PO61gQa9Tem/fXOJbmFhsK0S
         DFBgvvH6gcIvHhpXnyTH9LNbbiUk+WVHqKyVh+tsFUZ9QkhA0Gto7h3mL9Y4H5tsqlu+
         ynNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTRCZ4tW93FlQDi5UVI2IwLTt/gRd10gzUrxWk69L20=;
        b=gWQMmDryYMEIo9P151CY/+dnGQINfZe+aCUTEr4Yd4k3sPVLH/71aOURsib8NDhPmG
         xHgLbzyJSF4rScnaqUSsd5rIID8JIq8K2WatTIilyqrP3dfIbqxd7IEwvKmV9Oc0lb0b
         WuFXYADh+UEFQ3jtawWHtADyJZBoFJjlvyDATBSkbHOcEGdjbF/VPVp3kplQm1TUzIeH
         IFkVniccKcaQh9mJCdPwRDSYxfxeCx82vFRDqgKDXH5zjZxC7u3J29vOojMAS542/Y02
         LIjPhgSjcwwW2CTQj1MeyuRqG3/HH1yXoU/8SU/j5lwGFZm9YcWMBtpdM81wC+ULHDBb
         6y4w==
X-Gm-Message-State: AGi0Pua+Mjw3g/YpWbzYWS8TWjsDTIFkiNHRb0+17Kf3MYqzrEV8dlJV
        ceVIi027qB/8cGWAtwTejXHtAPF0xXe60OOpYi3XCg==
X-Google-Smtp-Source: APiQypLMNP7mFNGVBrw7kSKMyDYiyp19Ww2dZxj3ZP5gRIFX6j47TZ8P5YanwZltORDw5uPz7Lz83ILXcwGBPtGajQk=
X-Received: by 2002:a92:2912:: with SMTP id l18mr15729465ilg.28.1588869976087;
 Thu, 07 May 2020 09:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <CANP3RGduts2FJ2M5MLcf23GaRa=-fwUC7oPf-S4zp39f63jHMg@mail.gmail.com>
 <20200507023606.111650-1-zenczykowski@gmail.com> <ae1e5602-a2fd-661b-155c-d32ff0059ce6@iogearbox.net>
In-Reply-To: <ae1e5602-a2fd-661b-155c-d32ff0059ce6@iogearbox.net>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Thu, 7 May 2020 09:46:03 -0700
Message-ID: <CANP3RGcz3VE6kS8JUNw4gR1tbCGGbF=-u99_j9QZRrz6559=kw@mail.gmail.com>
Subject: Re: [PATCH v3] net: bpf: permit redirect from ingress L3 to egress L2
 devices at near max mtu
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

(a) not clear why the max is SKB_MAX_ALLOC in the first place (this is
PAGE_SIZE << 2, ie. 16K on x86), while lo mtu is 64k

(b) hmm, if we're not redirecting, then exceeding the ingress device's
mtu doesn't seem to be a problem.

Indeed AFAIK this can already happen, some devices will round mtu up
when they configure the device mru buffers.
(ie. you configure L3 mtu 1500, they treat that as L2 1536 or 1532 [-4
fcs], simply because 3 * 512 is a nice amount of buffers, or they'll
accept not only 1514 L2, but also 1518 L2 or even 1522 L2 for VLAN and
Q-IN-Q -- even if the packets aren't actually VLAN'ed, so your non
VLAN mru might be 1504 or 1508)

Indeed my corp dell workstation with some standard 1 gigabit
motherboard nic has a standard default mtu of 1500, and I've seen it
receive L3 mtu 1520 packets (apparently due to misconfiguration in our
hardware [cisco? juniper?] ipv4->ipv6 translator which can take 1500
mtu ipv4 packets and convert them to 1520 mtu ipv6 packets without
fragmenting or generating icmp too big errors).  While it's obviously
wrong, it does just work (the network paths themselves are also
obviously 1520 clean).

(c) If we are redirecting we'll eventually (after bpf program returns)
hit dev_queue_xmit(), and shouldn't that be what returns an error?

btw. is_skb_forwardable() actually tests
- device is up && (packet is gso || skb->len < dev->mtu +
dev->hard_header_len + VLAN_HLEN);

which is also wrong and in 2 ways, cause VLAN_HLEN makes no sense on
non ethernet, and the __bpf_skb_max_len function doesn't account for
VLAN...  (which possibly has implications if you try to redirect to a
vlan interface)

---

I think having an mtu check is useful, but I think the mtu should be
selectable by the bpf program.  Because it might not even be device
mtu at all, it might be path mtu which we should be testing against.
It should also be checked for gso frames, since the max post
segmentation size should be enforced.

---

I agree we should expose dev->mtu (and dev->hard_header_len and hatype)

I'll mull this over a bit more, but I'm not convinced this patch isn't ok as is.
There just is probably more we should do.
