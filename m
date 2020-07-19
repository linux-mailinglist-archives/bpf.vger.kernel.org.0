Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656002251BC
	for <lists+bpf@lfdr.de>; Sun, 19 Jul 2020 13:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgGSL67 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jul 2020 07:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSL67 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jul 2020 07:58:59 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C99C0619D2
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2020 04:58:59 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e15so7090879vsc.7
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2020 04:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KWS4SM5Npr5IAIZzJSPVdCMdcccCo0V/JaIzbAuJ3aM=;
        b=Ans4RD2HFywsIRW+oznrlpqw1LD7WDsiwDbNEt1LxGPVZEQF3xiZJ595ZWmTFb53Lo
         QfjEzZU3p6qUuykGV6MpiVu2M1yebqyAsFKDJ/DWO7+SZhzdkOap2p3GdfARMy5EzY/G
         dkXnAKA6lbaIQhDxvOnxN7QHj966FE1uCmQ7GrLmJff0tnlPe+nBWe0e6h9NHKezJ+rv
         7454FsvscoFET5wAXine9adMcXBbZTPNrcozU92SU5ktN32rsfFwHXDBKdQP576NV6re
         qV1AoZ9qNUtA00RzLyABKVDjmJrilAc7AYsPB0LvjTedEpBt4zBrrMTUv14H2ZPCGKDg
         ggGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KWS4SM5Npr5IAIZzJSPVdCMdcccCo0V/JaIzbAuJ3aM=;
        b=eO8opjLcob+zFSrWIC0SebhKBiaU+rBeNIP0h2oU8ninpPe4AdjKiy7Q7KYXc9apME
         GZBMxvRsoyBe29w6Toldgh2qDCRe7gNBiAdaiTc10V/x5/HLnUNKESohAolNJK3IlakO
         70l9XmZZSw37W+e1CBT0bGzSyXV/WVfn3X4XI1Pq8mlOxZi6iUvIk9z2T8LsTFVJFhx3
         vZzPMPDPSOmk8zRrzddaUYkUEawZKHEwos0DffA2Tg8juFDprg8bEY4j8oXQbDiARQw1
         CJiIDbnCL3IkUCjQBB+KRBfpHYLDBfnGck62oqop/9jiCHz0CShgjSt7t8wNW27CfCB+
         iphA==
X-Gm-Message-State: AOAM5335nqkHnwnkG9Pqv49kWARVjz3bIuxr8B2ysXF7CGO8pWEUiLta
        G7JQJ3fqDTt5Gn7u7s2ozzQV6TKDUgit8AHJf3JQA18MORE=
X-Google-Smtp-Source: ABdhPJwOmKa7X9Hag7+3+Nf9jGjnydW+OUklTpC4cMG8i3Gm4KjCLbE2ru7DU/nyaXX6Xp9I4DjeRcH4y5lUqNWGf/E=
X-Received: by 2002:a67:fb8e:: with SMTP id n14mr13882317vsr.44.1595159937829;
 Sun, 19 Jul 2020 04:58:57 -0700 (PDT)
MIME-Version: 1.0
From:   Douglas Gray <mrdivorce287569@gmail.com>
Date:   Sun, 19 Jul 2020 12:58:46 +0100
Message-ID: <CANMtcHKyrz1YV_U_kBeysRA9SLpEVAt1ANB9ORxcd5ignT-9dQ@mail.gmail.com>
Subject: Question regarding the use of XDP_USE_NEED_WAKEUP
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello, I'm currently trying to write a Rust wrapper for using AF_XDP
sockets (using libbpf bindings) and have a couple questions about how
the XDP_USE_NEED_WAKEUP flag and the UMEM's fill queue interact. I'm
pretty new to this so apologies in advance if this is a dumb question.

While mucking around I created an AF_XDP socket with the
XDP_USE_NEED_WAKEUP flag set, and as I expected a call to
xsk_ring_prod__needs_wakeup returned 'true' when passed the xsk->tx
producer, however returned 'false' when passed the umem->fq producer.

I was a bit confused by this, as I thought it was a sort of 'fixed'
setting, so I think I'm misunderstanding one of two things:

1. Binding the socket with XDP_USE_NEED_WAKEUP isn't sufficient, I
also need to inform the UMEM through a particular flag / function
call, either on creation or after binding the socket? (To me this
seems unlikely and I've looked through the example [1] and I couldn't
find anything doing this, though I may have overlooked it).

2. Ater binding the socket with the XDP_USE_NEED_WAKEUP flag, both the
fill ring and tx ring may now require waking up, and the required flag
(XDP_RING_NEED_WAKEUP I believe) is set dynamically based on some
criteria at the time. Indeed going back over the docs [2] it appears
this way, so that at any time XDP_RING_NEED_WAKEUP can be set on the
fill ring (or tx ring) depending on a variety of conditions, and if it
is set then I should definitely send a wakeup, however there are
conditions where I may add to the fill ring / tx ring and I do not
need to send a wakeup.

I feel like #2 is the correct misinterpretation, does that sound
right? If that is correct, then out of interest (and if possible)
please could someone point me in the direction of the code which sets
the XDP_RING_NEED_WAKEUP flag on the UMEM's fill ring? I see there is
a comment in if_xdp.h [3] which says 'If this option is set, the
driver might go sleep and in that case, the XDP_RING_NEED_WAKEUP flag
in the fill and/or Tx rings will be set'. I couldn't find any further
code that mentions this flag however, so does its setting happen
deeper in the kernel / by the driver itself?

Thanks all!

Doug

[1] https://github.com/torvalds/linux/blob/master/samples/bpf/xdpsock_user.c

[2] https://www.kernel.org/doc/html/latest/networking/af_xdp.html#xdp-use-need-wakeup-bind-flag

[3] https://github.com/libbpf/libbpf/blob/d2f307c7f657bc7a4d3545bfcb7d42d66f9cedc1/include/uapi/linux/if_xdp.h
