Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3513982F
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2020 18:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgAMR7Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jan 2020 12:59:24 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36994 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMR7X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jan 2020 12:59:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id o13so11141425ljg.4
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2020 09:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=V7wY/vYKMxp0blW+3XXKjM+/7BBXTANUS+2NXTz/KMI=;
        b=Cwg9++eSmMCtlaXNDEa4indYDNX6UdfXCy1AVOZIHWY7Vh05QWkAgEWWrXS8MaJqGp
         45Ih46MbLu4rJS1ClJ413Aap4nktOg0Ex0lt8LJYxWs4P/cor0jGy3mZscIrrG13Tlga
         RFHRSRzzYtgTYbTDuHqgyNhS+cipFL+2R1jJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=V7wY/vYKMxp0blW+3XXKjM+/7BBXTANUS+2NXTz/KMI=;
        b=Hzz/X5BMrGcLtNb+SrgyqqUf11J/qYcS2yzZ2dDggLlzDrKCNmkSMblrscKJ+EBRMT
         fNddYPxhgl+sp41gBGjCCt578Vye5wohi2x7gkDjITEkhv/6kRfiiqPFHgmnJ2h0ZCwi
         ZAcKPbHzCS79IWpaX5BaWDnTvogZBZemaPRNVoXPlbB5CT+rGCF/CnkLBQpBHnYnF4Ht
         bkq6Pm5hEODq8O0+XTMAeLtUBDqa01G4F6R4Q3ycbwEqQaFnoZfqksrcUmXR/5oTrj0o
         bqyVErPno92QYNg/GZaWiOBtpty6igMhRDY6IaJHBu8GildWKitdxOkTZmIVZZ4ZobSw
         eVmg==
X-Gm-Message-State: APjAAAWOiAf9JxUPEcxoeHWNDUej/l/1fcWLD+vXr1sa3yeivmbdl8FT
        advMdprxDF7c1Gb/MGk+hv/qbg==
X-Google-Smtp-Source: APXvYqyM0fA5D1jWNSIoZd/DwiKE6o9rZGgB4P8ii5GK/H57g5NA0dspua87c457lWuRmiBwO3nChA==
X-Received: by 2002:a2e:7d01:: with SMTP id y1mr12084783ljc.100.1578938361757;
        Mon, 13 Jan 2020 09:59:21 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id w29sm6045520lfa.34.2020.01.13.09.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 09:59:21 -0800 (PST)
References: <20200110105027.257877-1-jakub@cloudflare.com> <20200110105027.257877-7-jakub@cloudflare.com> <5e1a6d8a5de6c_1e7f2b0c859c45c063@john-XPS-13-9370.notmuch> <5e1a7165b4a67_76782ace374ba5c050@john-XPS-13-9370.notmuch>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next v2 06/11] bpf, sockmap: Don't set up sockmap progs for listening sockets
In-reply-to: <5e1a7165b4a67_76782ace374ba5c050@john-XPS-13-9370.notmuch>
Date:   Mon, 13 Jan 2020 18:59:19 +0100
Message-ID: <87imlfs0eg.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 12, 2020 at 02:07 AM CET, John Fastabend wrote:
> John Fastabend wrote:
>> Jakub Sitnicki wrote:
>> > Now that sockmap can hold listening sockets, when setting up the psock we
>> > will (i) grab references to verdict/parser progs, and (2) override socket
>> > upcalls sk_data_ready and sk_write_space.
>> >
>> > We cannot redirect to listening sockets so we don't need to link the socket
>> > to the BPF progs, but more importantly we don't want the listening socket
>> > to have overridden upcalls because they would get inherited by child
>> > sockets cloned from it.
>> >
>> > Introduce a separate initialization path for listening sockets that does
>> > not change the upcalls and ignores the BPF progs.
>> >
>> > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> > ---
>> >  net/core/sock_map.c | 34 +++++++++++++++++++++++++++++++++-
>> >  1 file changed, 33 insertions(+), 1 deletion(-)
>>
>>
>> Any reason only support for sock_map types are added? We can also support
>> sock_hash I presume? Could be a follow up patch I guess but if its not
>> too much trouble would be worth adding now vs trying to detect at run
>> time later. I think it should be as simple as using similar logic as
>> below in sock_hash_update_common
>>
>> Thanks.
>
> After running through the other patches I think its probably OK to do hash
> support as a follow up. Up to you.

Yes, preferably. This series is already into double digits.

