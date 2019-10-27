Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C11E63AC
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2019 16:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfJ0PVb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Oct 2019 11:21:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51542 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726996AbfJ0PVb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 27 Oct 2019 11:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572189690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsaLVyKdbpm6nEeF+BMRxdrAuNPhQ+esghjO+poSKeQ=;
        b=UWwslZwwf9BT1JsPO/XRq5WGS782uzZUxVAgQsqp1HkqEcvbrrfTVnR4oqor0NS7OJrCt8
        WNhULIO3vI9qOkFxLkEHIEI2HXaJ5UqBKUI1JxY7R2/Y96DblWZCrjYhGecZaYgb2TsX1F
        hDCO4AsxXysIIyRw0eB6ZQW5SciVTSg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-S4sQSTwEOLiQS1ZolFpabA-1; Sun, 27 Oct 2019 11:21:27 -0400
Received: by mail-lf1-f70.google.com with SMTP id k30so1349117lfj.5
        for <bpf@vger.kernel.org>; Sun, 27 Oct 2019 08:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MtfGITaRDzUY/+4h6Vxbvb6pbf08Pb4luPlPhypEp9I=;
        b=NBRTY1Hn6wYpY9lE84m9lB1N8Zfl+BuedBhL87PIrVhlTtdNLKOOdh11QKHq+k9RRN
         SqwCfw7eoxEGMZcY22tcRhGadRSTssUjLfZ3/qnVMRsMoLc3oMm6vioCvxOQhmrHxx5Y
         YsQNaNDfAZUCKX6ksKn9ZSkpZregXn+OQt0b55uomIjwJEmqi/KZ9A4hiNn896aV6NKH
         D2T4y9clOpq1B1MwKS/SU1oAaIhjOUe5iDZpLYGqQIYV0eOIeWktXALDRlt3V1+sGOqX
         xcTe38TO+jLhD5L9ITnslaawkw8/S8e4QsgsWSf+uGw21/OqtC9ZUpv4qHnHbzcDdhy0
         HUQg==
X-Gm-Message-State: APjAAAWC6yD1NIi9A08B7giwiAMBbtLJuwuz68AkWfmseiBeI8qX2YP0
        EsWQCFs9vXhv/mQrUjofSGEagFe8S0Hy0MQ3EPIVFWTwkaq+xNRMPj917RJyzUZh4HYhMS268sM
        aTvpkzjVIuhUx
X-Received: by 2002:a2e:b4e8:: with SMTP id s8mr8986740ljm.73.1572189685932;
        Sun, 27 Oct 2019 08:21:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxVLPJs2/APvcQtaAZRXGtd2dvvnV0IxBQKssQ5XAzEUetzhBKfeR9HKJUOmlkJ1sLyxpB1Mw==
X-Received: by 2002:a2e:b4e8:: with SMTP id s8mr8986716ljm.73.1572189685694;
        Sun, 27 Oct 2019 08:21:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id p193sm5249364lfa.18.2019.10.27.08.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 08:21:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BBFB41818B6; Sun, 27 Oct 2019 16:21:23 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Toshiaki Makita <toshiaki.makita1@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Pravin B Shelar <pshelar@ovn.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        William Tu <u9012063@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [RFC PATCH v2 bpf-next 00/15] xdp_flow: Flow offload to XDP
In-Reply-To: <a7f3d86b-c83c-7b0d-c426-684b8dfe4344@gmail.com>
References: <20191018040748.30593-1-toshiaki.makita1@gmail.com> <5da9d8c125fd4_31cf2adc704105c456@john-XPS-13-9370.notmuch> <22e6652c-e635-4349-c863-255d6c1c548b@gmail.com> <5daf34614a4af_30ac2b1cb5d205bce4@john-XPS-13-9370.notmuch> <87h840oese.fsf@toke.dk> <5db128153c75_549d2affde7825b85e@john-XPS-13-9370.notmuch> <87sgniladm.fsf@toke.dk> <a7f3d86b-c83c-7b0d-c426-684b8dfe4344@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 27 Oct 2019 16:21:23 +0100
Message-ID: <87zhhmrz7w.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: S4sQSTwEOLiQS1ZolFpabA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toshiaki Makita <toshiaki.makita1@gmail.com> writes:

>> Yeah, you are right that it's something we're thinking about. I'm not
>> sure we'll actually have the bandwidth to implement a complete solution
>> ourselves, but we are very much interested in helping others do this,
>> including smoothing out any rough edges (or adding missing features) in
>> the core XDP feature set that is needed to achieve this :)
>
> I'm very interested in general usability solutions.
> I'd appreciate if you could join the discussion.
>
> Here the basic idea of my approach is to reuse HW-offload infrastructure=
=20
> in kernel.
> Typical networking features in kernel have offload mechanism (TC flower,=
=20
> nftables, bridge, routing, and so on).
> In general these are what users want to accelerate, so easy XDP use also=
=20
> should support these features IMO. With this idea, reusing existing=20
> HW-offload mechanism is a natural way to me. OVS uses TC to offload=20
> flows, then use TC for XDP as well...

I agree that XDP should be able to accelerate existing kernel
functionality. However, this does not necessarily mean that the kernel
has to generate an XDP program and install it, like your patch does.
Rather, what we should be doing is exposing the functionality through
helpers so XDP can hook into the data structures already present in the
kernel and make decisions based on what is contained there. We already
have that for routing; L2 bridging, and some kind of connection
tracking, are obvious contenders for similar additions.

-Toke

