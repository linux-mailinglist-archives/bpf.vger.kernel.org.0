Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C3E365580
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 11:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhDTJgb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Apr 2021 05:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229761AbhDTJga (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Apr 2021 05:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618911359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLC/fMpScBSSJ5G9NEpH9AKjnUVqqpw3OSPo3mLcv5E=;
        b=AV46E0zLyGhthHLKRx3SdhCERj8QbaNkuNyvqrCT0EVrZxsGZMneTvWHLOs3sUs0AjlTrv
        dfVmyBp57DmdeqAqbxdf9km8X8XGGWKetn9j3MKzRNLL9DGkzrtcwSMsQqFWfRKe/b0sfh
        VHhOaLpeLYuwFUqPT/QDLIGNmzTkr+0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-wI0udugcNa2O9to-NCu6Aw-1; Tue, 20 Apr 2021 05:35:57 -0400
X-MC-Unique: wI0udugcNa2O9to-NCu6Aw-1
Received: by mail-ej1-f69.google.com with SMTP id d16-20020a1709066410b0290373cd3ce7e6so4547655ejm.14
        for <bpf@vger.kernel.org>; Tue, 20 Apr 2021 02:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qLC/fMpScBSSJ5G9NEpH9AKjnUVqqpw3OSPo3mLcv5E=;
        b=Y0X22L3vEelnTrH87wtMOn5a9GpD2BWWsxylVPMwVMKNPP6d4cSiWSIERqy70id2e6
         bfVloO/vjtTsburJ4BWIBl/sc7iz3QVvd4bnT3HwyiiGTeWs3WQyIzSzeWeqjuvT87OE
         NEi20UtkYHdQQakk9sHWvZNyg2aSWaviN4nx/vuMqZcBJFxYuCbN967gAHF02+Nwwwdw
         SN7Kr0PzLZepRGdFBj4S5TIFdJY3RMsuYqHiK0mYPmzuswC8fodmzRzLGrVTjOQtchE0
         Fq4HbC5C9Lzrhp7bUVld7B2fhdUHx7yxpw1WSeMXtFSXLuPfnQC/rktum+AxWKN2j5Nt
         VXnA==
X-Gm-Message-State: AOAM530NR0a0vuxe43By3qgWbMb5AxTdRpTceWszgidPLXbQAalE3g3P
        1V9kcpMjZYZSw9jYlhi/3NSWLuCx1V0Vd2SrvpGIGrWxSLnZkGwcRg5CsiNZ3ee1t+iTMmP6Q77
        aLEkAOqmPhHvv
X-Received: by 2002:a17:906:2b05:: with SMTP id a5mr26805419ejg.446.1618911356004;
        Tue, 20 Apr 2021 02:35:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygUvQBo5REQ1U3GcHppe37i8r/zepGZC/vvWAKuiPEsJIOpg5VA2hFakvZ6s2VQvupH8jbGQ==
X-Received: by 2002:a17:906:2b05:: with SMTP id a5mr26805396ejg.446.1618911355570;
        Tue, 20 Apr 2021 02:35:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f1sm11283234edt.4.2021.04.20.02.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 02:35:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6DEC41802D9; Tue, 20 Apr 2021 11:35:54 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin Willi <martin@strongswan.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: xdp: Update pkt_type if generic XDP
 changes unicast MAC
In-Reply-To: <f14da35f8cfa4b8f888dadfe4c9ebcd031d8e870.camel@strongswan.org>
References: <20210419141559.8611-1-martin@strongswan.org>
 <87tuo2gwbj.fsf@toke.dk>
 <f14da35f8cfa4b8f888dadfe4c9ebcd031d8e870.camel@strongswan.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 20 Apr 2021 11:35:54 +0200
Message-ID: <87sg3lfgcl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin Willi <martin@strongswan.org> writes:

> Hi,
>
> Thanks for your comments.
>
>> >  	eth =3D (struct ethhdr *)xdp->data;
>> > +	orig_host =3D ether_addr_equal_64bits(eth->h_dest, skb->dev->dev_add=
r);
>>=20
>> ether_addr_equal_64bits() seems to assume that the addresses passed to=20
>> it are padded to be 8 bytes long, which is not the case for eth->h_dest.
>> AFAICT the only reason the _64bits variant works for multicast is that
>> it happens to be only checking the top-most bit, but unless I'm missing
>> something you'll have to use the boring old ether_addr_equal() here, no?
>
> This is what eth_type_trans() uses below, so I assumed it is safe to
> use. Isn't that working on the same data?
>
> Also, the destination address in Ethernet is followed by the source
> address, so two extra bytes in the source are used as padding. These
> are then shifted out by ether_addr_equal_64bits(), no?

Ohh, you're right, it's shifting off the two extra bytes afterwards.
Clever! I obviously missed that, but yeah, that means it just needs the
two extra bytes to not be out-of-bounds reads, so this usage should be
fine :)

>> > +		skb->pkt_type =3D PACKET_HOST;
>> >  		skb->protocol =3D eth_type_trans(skb, skb->dev);
>> >  	}
>>=20
>> Okay, so this was a bit confusing to me at fist glance:
>> eth_type_trans() will reset the type, but not back to PACKET_HOST. So
>> this works, just a bit confusing :)
>
> Indeed. I considered changing eth_type_trans() to always reset
> pkt_type, but I didn't want to take the risk for any side effects.

Hmm, yeah, it does seem there are quite a few call sites to audit if you
were to change the behaviour. I guess we'll have to live with the slight
confusion, then :)

-Toke


Given the above:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

