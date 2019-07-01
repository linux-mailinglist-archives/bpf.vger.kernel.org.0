Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A8F27BD7
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 13:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfEWLd6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 23 May 2019 07:33:58 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42075 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWLd5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 May 2019 07:33:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so4118361lfh.9
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 04:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ArLV4j9Qrx20FwA1wP7GgXD93lvgUt96oTpw4Pb5vr0=;
        b=oFcVrdEh8hWzjtsuY5XjWYMRqqxjkiX8I3OydS7oy0zE/vvEQShpicwszVh6IuSOl8
         el7SjAtAWioT7/UKz8BkOqxh3Nn+FdsJcGOauURm+nT58ZXc9Hk4CcvGwMCKfMQSeVwi
         P/PtoSWMqU2VeLhJovR+m6g8vsfMJ9+6I6B7gTg3dtalkiu6TqURMiMY2sso+6z5+Kl1
         1BFAIN8bTCCaeokLe+HWPi0dm+FljKVvO8X2zhsKJTrDJyAUF/JPdN8UJDDJOWr0xWyX
         /8hyqnpLBQCbXsjYBBj8mDT+SAxAJSiLjE6DR2LsPXLCQGGAqbBpoqV4kYuxmkK45j3y
         6iRw==
X-Gm-Message-State: APjAAAVgBpIBgcUheaKFlSRt9k/MLxUZsvZT5xU4uoo4yRDXzYk1md9T
        +eEGG3D1u8P5CopRBov0yDdUog==
X-Google-Smtp-Source: APXvYqxjyMp1cGdI8t0OsQEd6S5RuK7INtPgaf6n6xSdk9zLVU9M/7K7cw4BORgg2XTX66BxenvXKA==
X-Received: by 2002:ac2:4c36:: with SMTP id u22mr1899825lfq.33.1558611236100;
        Thu, 23 May 2019 04:33:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id f16sm4125739lfk.75.2019.05.23.04.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 04:33:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B5EAA1800B1; Thu, 23 May 2019 13:33:54 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     netdev@vger.kernel.org, xdp-newbies@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] xdp: Add bulk XDP_TX queue
In-Reply-To: <2ab04d02-634e-9420-9514-e4ede08bcb10@lab.ntt.co.jp>
References: <1558609008-2590-1-git-send-email-makita.toshiaki@lab.ntt.co.jp> <1558609008-2590-2-git-send-email-makita.toshiaki@lab.ntt.co.jp> <8736l52zon.fsf@toke.dk> <2ab04d02-634e-9420-9514-e4ede08bcb10@lab.ntt.co.jp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 23 May 2019 13:33:54 +0200
Message-ID: <87v9y11k2l.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> writes:

> On 2019/05/23 20:11, Toke Høiland-Jørgensen wrote:
>> Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> writes:
>> 
>>> XDP_TX is similar to XDP_REDIRECT as it essentially redirects packets to
>>> the device itself. XDP_REDIRECT has bulk transmit mechanism to avoid the
>>> heavy cost of indirect call but it also reduces lock acquisition on the
>>> destination device that needs locks like veth and tun.
>>>
>>> XDP_TX does not use indirect calls but drivers which require locks can
>>> benefit from the bulk transmit for XDP_TX as well.
>> 
>> XDP_TX happens on the same device, so there's an implicit bulking
>> happening because of the NAPI cycle. So why is an additional mechanism
>> needed (in the general case)?
>
> Not sure what the implicit bulking you mention is. XDP_TX calls
> .ndo_xdp_xmit() for each packet, and it acquires a lock in veth and
> tun. To avoid this, we need additional storage for bulking like devmap
> for XDP_REDIRECT.

The bulking is in veth_poll(), where veth_xdp_flush() is only called at
the end. But see my other reply to the veth.c patch for the lock
contention issue...

-Toke
