Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D110121BA75
	for <lists+bpf@lfdr.de>; Fri, 10 Jul 2020 18:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgGJQMH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 12:12:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39747 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727782AbgGJQMG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jul 2020 12:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594397525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KjEBh/BOTj8O0DP/1T6iu+nKRTbX5bjS6l9mZZGhjTI=;
        b=cfvoWVVLcpMeMSN+GPKjwMEwZRkuzO9kjwG8JpCCyOkORIKXeMfLKNeMQuJlVE+8Gme2Nc
        xPw0AtudR4xxLGzYYxqD2bb0x2Cwnv0ocWDd2gIeRpl04hOk/8F/hUO++YXoODzr1eEFYQ
        0lDMkJUZmY4S3tP3TIeIhUHIDNj3wCg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-tf7CexY1M1CRm43bwFytZQ-1; Fri, 10 Jul 2020 12:12:03 -0400
X-MC-Unique: tf7CexY1M1CRm43bwFytZQ-1
Received: by mail-io1-f72.google.com with SMTP id n3so3889658iob.8
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 09:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KjEBh/BOTj8O0DP/1T6iu+nKRTbX5bjS6l9mZZGhjTI=;
        b=AkBxZ1aYW3M6c0c2KTUHOXgntBoSbcp2iuM4lX1Sabds2wuGbvfYy8MbWM7brRHGqz
         sBpkYEbMIwklr3MX2EjQEQJmNJwa81a4/FPpJbo1AksdriBZVZjAfoLOV6XosZR6yHw8
         w6PZwTS9mUlXwsgGIjF6yfIo0t76Q6xWGi1/m/M6MXby9RZb+tDyCQ+NqyvPull6lR5Y
         W1GLG65r9bgdXqNAoalzxxdINV/EBfmpgFC9BYLpX4VkNwf4fgx5vfSxXPlP3fRv6xrQ
         N7Ko1kJI1mmfML/9c37lNPZ8yN6gvCZ/yR90xU9jSmcck3G3+dZQR6x/iGH4bmvoio9b
         zG2w==
X-Gm-Message-State: AOAM533Dzql357I016kEus0sZ8hXOkYFSol8mTL+wZpG2Zce/mfGnrGG
        uNciVNG8KwOj4piuu899LERc9Z5GNGVgJOda+oFxpCMLyUGHzS5xVSpVC9TUTaetg0gj6/zu5oY
        aOFIP2Qtn5U6a
X-Received: by 2002:a02:a88a:: with SMTP id l10mr48785638jam.110.1594397522410;
        Fri, 10 Jul 2020 09:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy94wI731wHeAF8lN4eK3rZcY0aU8wnnlQa/0Aw+qE/7Bpzae229hnG2N1PedlmgS/crLLGSw==
X-Received: by 2002:a02:a88a:: with SMTP id l10mr48785622jam.110.1594397522235;
        Fri, 10 Jul 2020 09:12:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a1sm3518204ilq.50.2020.07.10.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:12:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 08EDE1808CD; Fri, 10 Jul 2020 18:12:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joe Perches <joe@perches.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>, ast@kernel.org,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, mchehab+huawei@kernel.org,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: XDP: restrict N: and K:
In-Reply-To: <a2f48c734bdc6b865a41ad684e921ac04b221821.camel@perches.com>
References: <20200709194257.26904-1-grandmaster@al2klimov.de> <d7689340-55fc-5f3f-60ee-b9c952839cab@iogearbox.net> <19a4a48b-3b83-47b9-ac48-e0a95a50fc5e@al2klimov.de> <7d4427cc-a57c-ca99-1119-1674d509ba9d@iogearbox.net> <a2f48c734bdc6b865a41ad684e921ac04b221821.camel@perches.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 10 Jul 2020 18:12:00 +0200
Message-ID: <875zavjqnj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Fri, 2020-07-10 at 17:14 +0200, Daniel Borkmann wrote:
>> On 7/10/20 8:17 AM, Alexander A. Klimov wrote:
>> > Am 09.07.20 um 22:37 schrieb Daniel Borkmann:
>> > > On 7/9/20 9:42 PM, Alexander A. Klimov wrote:
>> > > > Rationale:
>> > > > Documentation/arm/ixp4xx.rst contains "xdp" as part of "ixdp465"
>> > > > which has nothing to do with XDP.
> []
>> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> > > > @@ -18708,8 +18708,8 @@ F:    include/trace/events/xdp.h
>> > > >   F:    kernel/bpf/cpumap.c
>> > > >   F:    kernel/bpf/devmap.c
>> > > >   F:    net/core/xdp.c
>> > > > -N:    xdp
>> > > > -K:    xdp
>> > > > +N:    (?:\b|_)xdp(?:\b|_)
>> > > > +K:    (?:\b|_)xdp(?:\b|_)
>> > > 
>> > > Please also include \W to generally match on non-alphanumeric char given you
>> > > explicitly want to avoid [a-z0-9] around the term xdp.
>> > Aren't \W, ^ and $ already covered by \b?
>> 
>> Ah, true; it says '\b really means (?:(?<=\w)(?!\w)|(?<!\w)(?=\w))', so all good.
>> In case this goes via net or net-next tree:
>
> This N: pattern does not match files like:
>
> 	samples/bpf/xdp1_kern.c
>
> and does match files like:
>
> 	drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
>
> Should it?

I think the idea is that it should match both?

-Toke

