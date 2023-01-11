Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120AF665DA1
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 15:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjAKOV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 09:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjAKOVz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 09:21:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5AF5FE3
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 06:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673446871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2KPbS/SEYeEU4JdPiymEdfVDyvIp5gFWxNtorg1DK8=;
        b=SGMFrX0Wzrcc1MTz2SQCZ9CtVPsWmUl3AzWst/e4fU3tt5il+oY9HKaKSUJzxzq3vtKd4n
        AFlpUWOq60RIk1AnysI+FqPu3Y3kvx2Yt0TZL6AOqLe66EmUGvdnUuFEqrdEYGD5R1J4y3
        tV1jR1PkMY/2XxfPVXSx59E792r+FjY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-283-MVNjmneLNFqV1QfKfPbJTA-1; Wed, 11 Jan 2023 09:21:10 -0500
X-MC-Unique: MVNjmneLNFqV1QfKfPbJTA-1
Received: by mail-ed1-f72.google.com with SMTP id w3-20020a056402268300b00487e0d9b53fso10081404edd.10
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 06:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2KPbS/SEYeEU4JdPiymEdfVDyvIp5gFWxNtorg1DK8=;
        b=3IbuGlmGADY1o4T6SVUBzhml6w+mxO2zyO3N5CSkbEswDmtk7d9kyIhSs2Zv/qOGqr
         9JN1FaCuRQo6UBcYz0PMA9ToweEm7BA/ebmeuYbgzA0rrVnT0f3m9VJedse0EJGEf6kT
         +crUzg+zu5jKTlRKiB0jtwwIp9+mA9hn/Uc1aJ3pw2TH/+gfmnb8GVzw0evEHPvivRR0
         x7kQUWmwygRoeGMf1zcygzNOkcpw/HVtXo/anUF8bMRL/P2/E1/kMGBBL5D9FiJUM91o
         I4HJmH3nfSX1lorwf0qSF4mc8yJb6+Xc+2xZ5924/Rnhp4B9yhUvOmZ285KNQ4rUk697
         Q2pg==
X-Gm-Message-State: AFqh2kodE7UnaNnfxfkZhiS6+i5NvZI+CHcU+tpd9NilsAhREU81DDm8
        wZeZh8EhPhlNEDlDvKpmqMLrRkycbrOc98bTHKrBqwQKZ0nDtSXuLh3Fok9syEvUvE7TRhE7MHZ
        CXpwbFsznkG9i
X-Received: by 2002:a17:907:2587:b0:7c0:e7ad:fb0f with SMTP id ad7-20020a170907258700b007c0e7adfb0fmr51315066ejc.20.1673446868114;
        Wed, 11 Jan 2023 06:21:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuaWxJhnTXv7aycQTAtJPqKsgkEpqFLA7DaJ3DcobVJDtNfu/sYPSJYiSzA4spvi1Lwm9DwJg==
X-Received: by 2002:a17:907:2587:b0:7c0:e7ad:fb0f with SMTP id ad7-20020a170907258700b007c0e7adfb0fmr51315026ejc.20.1673446867121;
        Wed, 11 Jan 2023 06:21:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b007933047f923sm6255801ejn.118.2023.01.11.06.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 06:21:06 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 385909004A5; Wed, 11 Jan 2023 15:21:06 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Shawn Bohrer <sbohrer@cloudflare.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, bjorn@kernel.org, kernel-team@cloudflare.com,
        davem@davemloft.net
Subject: Re: [PATCH] veth: Fix race with AF_XDP exposing old or
 uninitialized descriptors
In-Reply-To: <CAJ8uoz2ZL54EbZw+jTCQowjmC=MBzdpVzn=uQNcM7K+sCH7K5Q@mail.gmail.com>
References: <Y5pO+XL54ZlzZ7Qe@sbohrer-cf-dell>
 <20221220185903.1105011-1-sbohrer@cloudflare.com>
 <e6b0414dbc7e97857fee5936ed04efca81b1d472.camel@redhat.com>
 <CAJ8uoz2ZL54EbZw+jTCQowjmC=MBzdpVzn=uQNcM7K+sCH7K5Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Jan 2023 15:21:06 +0100
Message-ID: <877cxtgnjh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> On Thu, Dec 22, 2022 at 11:18 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On Tue, 2022-12-20 at 12:59 -0600, Shawn Bohrer wrote:
>> > When AF_XDP is used on on a veth interface the RX ring is updated in two
>> > steps.  veth_xdp_rcv() removes packet descriptors from the FILL ring
>> > fills them and places them in the RX ring updating the cached_prod
>> > pointer.  Later xdp_do_flush() syncs the RX ring prod pointer with the
>> > cached_prod pointer allowing user-space to see the recently filled in
>> > descriptors.  The rings are intended to be SPSC, however the existing
>> > order in veth_poll allows the xdp_do_flush() to run concurrently with
>> > another CPU creating a race condition that allows user-space to see old
>> > or uninitialized descriptors in the RX ring.  This bug has been observed
>> > in production systems.
>> >
>> > To summarize, we are expecting this ordering:
>> >
>> > CPU 0 __xsk_rcv_zc()
>> > CPU 0 __xsk_map_flush()
>> > CPU 2 __xsk_rcv_zc()
>> > CPU 2 __xsk_map_flush()
>> >
>> > But we are seeing this order:
>> >
>> > CPU 0 __xsk_rcv_zc()
>> > CPU 2 __xsk_rcv_zc()
>> > CPU 0 __xsk_map_flush()
>> > CPU 2 __xsk_map_flush()
>> >
>> > This occurs because we rely on NAPI to ensure that only one napi_poll
>> > handler is running at a time for the given veth receive queue.
>> > napi_schedule_prep() will prevent multiple instances from getting
>> > scheduled. However calling napi_complete_done() signals that this
>> > napi_poll is complete and allows subsequent calls to
>> > napi_schedule_prep() and __napi_schedule() to succeed in scheduling a
>> > concurrent napi_poll before the xdp_do_flush() has been called.  For the
>> > veth driver a concurrent call to napi_schedule_prep() and
>> > __napi_schedule() can occur on a different CPU because the veth xmit
>> > path can additionally schedule a napi_poll creating the race.
>>
>> The above looks like a generic problem that other drivers could hit.
>> Perhaps it could be worthy updating the xdp_do_flush() doc text to
>> explicitly mention it must be called before napi_complete_done().
>
> Good observation. I took a quick peek at this and it seems there are
> at least 5 more drivers that can call napi_complete_done() before
> xdp_do_flush():
>
> drivers/net/ethernet/qlogic/qede/
> drivers/net/ethernet/freescale/dpaa2
> drivers/net/ethernet/freescale/dpaa
> drivers/net/ethernet/microchip/lan966x
> drivers/net/virtio_net.c
>
> The question is then if this race can occur on these five drivers.
> Dpaa2 has AF_XDP zero-copy support implemented, so it can suffer from
> this race as the Tx zero-copy path is basically just a napi_schedule()
> and it can be called/invoked from multiple processes at the same time.
> In regards to the others, I do not know.
>
> Would it be prudent to just switch the order of xdp_do_flush() and
> napi_complete_done() in all these drivers, or would that be too
> defensive?

We rely on being inside a single NAPI instance trough to the
xdp_do_flush() call for RCU protection of all in-kernel data structures
as well[0]. Not sure if this leads to actual real-world bugs for the
in-kernel path, but conceptually it's wrong at least. So yeah, I think
we should definitely swap the order everywhere and document this!

-Toke

[0] See https://lore.kernel.org/r/20210624160609.292325-1-toke@redhat.com

