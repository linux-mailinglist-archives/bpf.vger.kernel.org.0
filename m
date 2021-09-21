Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7784E413120
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 12:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhIUKFa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 06:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhIUKF3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 06:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632218641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8WXelVxVEtcB236AlZ3RJ7jb6WwUywUxojDqr4AaxI=;
        b=XKZam6FKJ+YoBcBJFKs2HkvBq6IP/5zaWuP0FG5JazXwyiHL6yRnMyqUMiUOKSju7ZszlF
        Z6z3tYYzkJ/UAMRtchAa+lwk7+z4ABCyjn4N/5K+3WelhJBuYm/3jgVz3nIyjz/o6nzCB4
        fbxbCr6hky+k4ZeDM3sx1h0ZKq91U8Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-KtW3bKF6Pgur_fT4CSjSMg-1; Tue, 21 Sep 2021 06:03:59 -0400
X-MC-Unique: KtW3bKF6Pgur_fT4CSjSMg-1
Received: by mail-ed1-f71.google.com with SMTP id h15-20020aa7de0f000000b003d02f9592d6so18474527edv.17
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 03:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i8WXelVxVEtcB236AlZ3RJ7jb6WwUywUxojDqr4AaxI=;
        b=QG+DEReWYF13ptfNG9KRTtF99F8Q59osh8667Zm4jfkn81Yj7g/pe0jTQhVaEP5/Zv
         VHAkUgXLHyoLaTcD79QYShdAUTcct11XEF0drdnNCXl9TYE8cvgdPJxLndunsZZPp9B1
         BoEJy11abLAdzH3Vf2RBWtI8QHzFxQe3nIyJ6ALBU10HDsDIjSz6p7Su0fzWoMPl/Pe/
         Mz8ruD0Oex88p2ngzaMu6Bolmh+woUwdjDS8l3EVPXvhSWkrndveFg23NALN93isjyJr
         ebEURF91wGZqCfTcqGRRCD8zW5fyBI4zI5Ko8lCagR8LLLvt2PDFbL4Eni0WaHIbZn10
         0hOA==
X-Gm-Message-State: AOAM531R1jiEoLgud3vtxbT+YlkGlTocbDNN9jX0PrpPRWVOAv8H+Pjx
        Za5QyEvaCGQp+jkxcBvBMk2Qk09b5TrDqWb6Svz5G+vXjBHmoQIoqtxKB97Sg1LuDvMEO9MUsSW
        9c1OTpruZQNQu
X-Received: by 2002:a50:c949:: with SMTP id p9mr35186756edh.326.1632218638700;
        Tue, 21 Sep 2021 03:03:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr8wPz04E9dTEncwS9JYdZz2YKXnnPGf+BcL4OmkSrX4uJABVjfdghdv+cVHBpU1MOoUQ+kg==
X-Received: by 2002:a50:c949:: with SMTP id p9mr35186706edh.326.1632218638362;
        Tue, 21 Sep 2021 03:03:58 -0700 (PDT)
Received: from [10.39.193.103] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id q6sm7091042ejm.106.2021.09.21.03.03.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Sep 2021 03:03:57 -0700 (PDT)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     Toke =?utf-8?b?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shayagr@amazon.com,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v14 bpf-next 00/18] mvneta: introduce XDP multi-buffer support
Date:   Tue, 21 Sep 2021 12:03:56 +0200
X-Mailer: MailMate (1.14r5820)
Message-ID: <2C4CB8CA-1234-4761-8F74-49A198F94880@redhat.com>
In-Reply-To: <87ilyu50kl.fsf@toke.dk>
References: <cover.1631289870.git.lorenzo@kernel.org>
 <20210916095539.4696ae27@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YUSrWiWh57Ys7UdB@lore-desk>
 <20210917113310.4be9b586@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAADnVQL15NAqbswXedF0r2om8SOiMQE80OSjbyCA56s-B4y8zA@mail.gmail.com>
 <20210917120053.1ec617c2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAADnVQKbrkOxfNoixUx-RLJEWULJLyhqjZ=M_X2cFG_APwNyCg@mail.gmail.com>
 <614511bc3408b_8d5120862@john-XPS-13-9370.notmuch> <8735q25ccg.fsf@toke.dk>
 <20210920110216.4c54c9a3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87lf3r3qrn.fsf@toke.dk>
 <20210920142542.7b451b78@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87ilyu50kl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 21 Sep 2021, at 0:44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:

> Jakub Kicinski <kuba@kernel.org> writes:
>
>> On Mon, 20 Sep 2021 23:01:48 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>>>> In fact I don't think there is anything infra can do better for
>>>> flushing than the prog itself:
>>>>
>>>> 	bool mod =3D false;
>>>>
>>>> 	ptr =3D bpf_header_pointer(...);
>>>> 	...
>>>> 	if (some_cond(...)) {
>>>> 		change_packet(...);
>>>> 		mod =3D true;
>>>> 	}
>>>> 	...
>>>> 	if (mod)
>>>
>>> to have an additional check like:
>>>
>>> if (mod && ptr =3D=3D stack)
>>>
>>> (or something to that effect). No?
>>
>> Good point. Do you think we should have the kernel add/inline this
>> optimization or have the user do it explicitly.
>
> Hmm, good question. On the one hand it seems like an easy optimisation
> to add, but on the other hand maybe the caller has other logic that can=

> better know how/when to omit the check.
>
> Hmm, but the helper needs to check it anyway, doesn't it? At least it
> can't just blindly memcpy() if the source and destination would be the
> same...
>
>> The draft API was:
>>
>> void *xdp_mb_pointer_flush(struct xdp_buff *xdp_md, u32 flags,
>>                            u32 offset, u32 len, void *stack_buf)
>>
>> Which does not take the ptr returned by header_pointer(), but that's
>> easy to add (well, easy other than the fact it'd be the 6th arg).
>
> I guess we could play some trickery with stuffing offset/len/flags into=

> one or two u64s to save an argument or two?
>
>> BTW I drafted the API this way to cater to the case where flush()
>> is called without a prior call to header_pointer(). For when packet
>> trailer or header is populated directly from a map value. Dunno if
>> that's actually useful, either.
>
> Ah, didn't think of that; so then it really becomes a generic
> xdp_store_bytes()-type helper? Might be useful, I suppose. Adding
> headers is certainly a fairly common occurrence, but dunno to what
> extent they'd be copied wholesale from a map (hadn't thought about doin=
g
> that before either).


Sorry for commenting late but I was busy and had to catch up on emails...=


I like the idea, as these APIs are exactly what I proposed in April, http=
s://lore.kernel.org/bpf/FD3E6E08-DE78-4FBA-96F6-646C93E88631@redhat.com/

I did not call it flush, as it can be used as a general function to copy =
data to a specific location.


//Eelco

