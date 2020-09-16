Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C484626CBAC
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 22:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbgIPUaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 16:30:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48063 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726915AbgIPRM4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Sep 2020 13:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600276345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQyq2xuCGNHkYvL97fJ+nfUr6mDnAugF/ipqA9mhYME=;
        b=JAffHlIVZl6VFgcxbjk3iK0uUZf7IVQHlD3gcII6QkoTXWpw2Fyk83xU9vMdY1gKqN8+jD
        TTb9hKBnIxuSPLJ8zwK64Tcb7cLQs1K2cf6KCgoyc4Hoj/35Dnfgd1kG4V/OATuf9AQ+Yr
        x/URuo6hSFx/6gsDCcbdXtuZOocn6WQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-8PtYLylDMJu9DVG9dNssPw-1; Wed, 16 Sep 2020 07:37:30 -0400
X-MC-Unique: 8PtYLylDMJu9DVG9dNssPw-1
Received: by mail-ed1-f69.google.com with SMTP id r19so2328473edq.12
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 04:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RQyq2xuCGNHkYvL97fJ+nfUr6mDnAugF/ipqA9mhYME=;
        b=ncFWnP0BlrkKIQH9fjKyBm7DCRQO823PyNmfB1k9jB6K9n7gynImAFcHo+TqN5B2b9
         zdYQ0BasGaC+fOGT71J3IiivXHyCfy1HAIVVM7g94X5hDmIqFxA+cJnG8mu0JRssbg+p
         OoRJvzVBlDVrdDs45o9L1OJ7vr/P5sTlM2pGfXFS+coeIdgz9JbFuvkKBr2nS80U8yri
         xRC7GYCsR6SzEZZieYQwSccWL8DhR0Usv3P1Wys5IBzxcGwnmtp2NrRUaFFt4Qnlzbmc
         slxBeENwsOoTHDSS9mQ29g8vJBHs0+zhgMRNsL9HuLW15LBwAgbEUPnaL1N0LYBhkRLq
         K6Dg==
X-Gm-Message-State: AOAM531tfpYLl1xtDCMXaZUGecn+R3S0C3moMQQ+V9OAxbhdB6Hnwkgs
        iQF3EJzYD0Nq8zVClKP2D9/8YMUci4k6DC/G3u47TK9LWNfmWjyzwh77hVtaqWaJN7KN0d5U+CJ
        XgJ0BujrxZOOJ
X-Received: by 2002:a17:906:3088:: with SMTP id 8mr14075906ejv.487.1600256249057;
        Wed, 16 Sep 2020 04:37:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5qscMaMnIvPB74Nt602ZvP3284TeQZsUwMmfnfhukiJAfLhlw8RjOfPXviImTQCvk2iGm6A==
X-Received: by 2002:a17:906:3088:: with SMTP id 8mr14075875ejv.487.1600256248771;
        Wed, 16 Sep 2020 04:37:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o6sm13971569edh.40.2020.09.16.04.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 04:37:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 57809183A90; Wed, 16 Sep 2020 13:37:27 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux NetDev <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: don't check against device MTU in
 __bpf_skb_max_len
In-Reply-To: <CANP3RGf581mZKE2Eky-bY6swU6TAFv1vzxxZ24SQ+yB9TGAD8w@mail.gmail.com>
References: <159921182827.1260200.9699352760916903781.stgit@firesoul>
 <20200904163947.20839d7e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200907160757.1f249256@carbon>
 <CANP3RGfjUOoVH152VHLXL3y7mBsF+sUCqEZgGAMdeb9_r_Z-Bw@mail.gmail.com>
 <20200914160538.2bd51893@carbon>
 <CANP3RGftg2-_tBc=hGGzxjGZUq9b1amb=TiKRVHSBEyXq-A5QA@mail.gmail.com>
 <87ft7jzas7.fsf@toke.dk>
 <CANP3RGf581mZKE2Eky-bY6swU6TAFv1vzxxZ24SQ+yB9TGAD8w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 16 Sep 2020 13:37:27 +0200
Message-ID: <875z8eq7ew.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Maciej =C5=BBenczykowski <maze@google.com> writes:

> On Tue, Sep 15, 2020 at 1:47 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> [ just jumping in to answer this bit: ]
>>
>> > Would you happen to know what ebpf startup overhead is?
>> > How big a problem is having two (or more) back to back tc programs
>> > instead of one?
>>
>> With a jit'ed BPF program and the in-kernel dispatcher code (which
>> avoids indirect calls), it's quite close to a native function call.
>
> Hmm, I know we have (had? they're upstream now I think) some CFI vs
> BPF interaction issues.
> We needed to mark the BPF call into JIT'ed code as CFI exempt.
>
> CFI is Code Flow Integrity and is some compiler magic, to quote wikipedia:
> Google has shipped Android with the Linux kernel compiled by Clang
> with link-time optimization (LTO) and CFI since 2018.[12]
> I don't know much more about it.
>
> But we do BPF_JIT_ALWAYS_ON on 64-bit kernels, so it sounds like we
> might be good.

No idea about the CFI thing...

>> > We're running into both verifier performance scaling problems and code
>> > ownership issues with large programs...
>> >
>> > [btw. I understand for XDP we could only use 1 program anyway...]
>>
>> Working on that! See my talk at LPC:
>> https://linuxplumbersconf.org/event/7/contributions/671/
>
> Yes, I'm aware and excited about it!

Great! :)

> Unfortunately, Android S will only support 4.19, 5.4 and 5.10 for
> newly launched devices (and 4.9/4.14 for upgrades).
> (5.10 here means 'whatever is the next 5.x LTS', but that's most likely 5=
.10)
> I don't (yet) even have real phone hardware running 5.4, and 5.10
> within the next year is even more of a stretch.

Right, I saw your talk at LPC and of course the kernel version thing is
a bit of an issue. I suppose you could do some compile-time magic to
wrap programs and use the tail-call-based chaining for older kernels -
bit of a hassle, though :/

-Toke

