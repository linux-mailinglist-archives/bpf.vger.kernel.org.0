Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033044150E9
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 22:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhIVUDP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 16:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237330AbhIVUDP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Sep 2021 16:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632340902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvr83e1n2Fgw45ulUi7a8YcLHtn9mb8DbDGNHYwss94=;
        b=QFEYD1rM0S/bfQSuiHIOGPu+m3jrQn3EjGB1XBDOKBJOePm3Pm+qPHOfx9mjFWi/OWiDHE
        nkjWkIlT+8lQtBvuU787zVKxk1YMrAai+qlMQRFeJorewmxP7x9+NTi4Y5EPjBkr2GvLpk
        6VVliWuyENtr09hxdq3EHgPmFh6El6M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-CE1n3qn1NZ-uuM3XfvxQSg-1; Wed, 22 Sep 2021 16:01:40 -0400
X-MC-Unique: CE1n3qn1NZ-uuM3XfvxQSg-1
Received: by mail-ed1-f69.google.com with SMTP id c7-20020a05640227c700b003d27f41f1d4so4346960ede.16
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dvr83e1n2Fgw45ulUi7a8YcLHtn9mb8DbDGNHYwss94=;
        b=QBg8EZxXHCRht+B9tzG0xDBeyB7xAIjQH5vJ1WofMWuYk7CiVOMiZlnSb06ds0bzDt
         8gTGAUFOF+DDWRUp4VB8XN5lhczGjC5enQqRN4d7k/31nFsMbw+DB8xBRZjuC7EL/4Mo
         pebFAlKEYMYd0VUptx5fj9wmeUY668YvFb8IUY8p0sYvK9HZ9iK+2TjbEZvEtfxUH2MB
         P/J4ZP7Qi97Kh3ydv3pjwywhB6hI6HXxE9DIhMi4jnzp3cvwPY2JjrS1iXXlT1JC3H8D
         kqxLsYz43JAgaisK6pcd6XTfxijcNr5Cb1CCsYkz0VOq6NZpUwEwfIY5xl+dstRU/pET
         7d+A==
X-Gm-Message-State: AOAM531H6NphBtaxR3uQ9ZzrECLPL2hKfVbjUTL+ypnOqylKdeNCFPSN
        QHb2I1mu8ll2m3uDJdYOUcKx4k20wGoPNY3rrHJxlzq4YqADY2Ycqtc6feQEBouZEhymJNbxM+D
        0vm9G9nJGIyF1
X-Received: by 2002:a17:907:2624:: with SMTP id aq4mr1129318ejc.448.1632340897910;
        Wed, 22 Sep 2021 13:01:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMzo127CmB7Voy0uTktBHCOW4IdwdLeoczJa9wnK3UJ8FoYXIbVWcfZXy6NhU4j/VrNfTl7w==
X-Received: by 2002:a17:907:2624:: with SMTP id aq4mr1129080ejc.448.1632340895635;
        Wed, 22 Sep 2021 13:01:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g10sm1503581ejj.44.2021.09.22.13.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:01:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3447218034A; Wed, 22 Sep 2021 22:01:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Zvi Effron <zeffron@riotgames.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Lorenzo Bianconi <lbianconi@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Redux: Backwards compatibility for XDP multi-buff
In-Reply-To: <20210921155118.439c0aa9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <87o88l3oc4.fsf@toke.dk>
 <CAC1LvL1xgFMjjE+3wHH79_9rumwjNqDAS2Yg2NpSvmewHsYScA@mail.gmail.com>
 <87ilyt3i0y.fsf@toke.dk>
 <CAADnVQKi_u6yZnsxEagNTv-XWXtLPpXwURJH0FnGFRgt6weiww@mail.gmail.com>
 <87czp13718.fsf@toke.dk>
 <20210921155118.439c0aa9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 22 Sep 2021 22:01:17 +0200
Message-ID: <87mto41isy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 22 Sep 2021 00:20:19 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> Neither of those are desirable outcomes, I think; and if we add a
>> >> separate "XDP multi-buff" switch, we might as well make it system-wid=
e?=20=20
>> >
>> > If we have an internal flag 'this driver supports multi-buf xdp' canno=
t we
>> > make xdp_redirect to linearize in case the packet is being redirected
>> > to non multi-buf aware driver (potentially with corresponding non mb a=
ware xdp
>> > progs attached) from mb aware driver?=20=20
>>=20
>> Hmm, the assumption that XDP frames take up at most one page has been
>> fundamental from the start of XDP. So what does linearise mean in this
>> context? If we get a 9k packet, should we dynamically allocate a
>> multi-page chunk of contiguous memory and copy the frame into that, or
>> were you thinking something else?
>
> My $.02 would be to not care about redirect at all.
>
> It's not like the user experience with redirect is anywhere close=20
> to amazing right now. Besides (with the exception of SW devices which
> will likely gain mb support quickly) mixed-HW setups are very rare.
> If the source of the redirect supports mb so will likely the target.

It's not about device support it's about XDP program support: If I run
an MB-aware XDP program on a physical interface and redirect the (MB)
frame into a container, and there's an XDP program running inside that
container that isn't MB-aware, bugs will ensue. Doesn't matter if the
veth driver itself supports MB...

We could leave that as a "don't do that, then" kind of thing, but that
was what we were proposing (as the "do nothing" option) and got some
pushback on, hence why we're having this conversation :)

-Toke

