Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1407E2E6F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 12:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbfJXKNR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 06:13:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53865 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390611AbfJXKNQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 06:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571911995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFGC+pXdSvp7vqOlIqKp+e+pzxyzHrdtw3msqscabak=;
        b=SlTMPxwaxYVxvzcJb6R4jYTqME5BA7aIIbjnlSXjEYZnh/EW3hYbpxGvuAWbmrNCaugH6C
        7AtAz0sJ1KgN519rkmQWRCtgbcteVAIopQggCo4KwTZHRObTGHpUfm87DvbeeqItehpzKG
        ESHNWL3rchJFXwCHVCQnYYIz0RXGO8I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-TV3uus_NOD2CaWwtyiqqUA-1; Thu, 24 Oct 2019 06:13:13 -0400
Received: by mail-wr1-f71.google.com with SMTP id k10so3544470wrl.22
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 03:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yFGC+pXdSvp7vqOlIqKp+e+pzxyzHrdtw3msqscabak=;
        b=WEYcMHTO8DS4yeZsdgZ0c811z2jMY2U63g+zxDOJyrLNJ2D9aLwt09D+eWGLvJ7XYq
         14wvC/uve7pb+PSTGBkyEFgAPd5OUJxYaHZb5sFikSPY7CpkFi2dQEWg1KT4YEibxPSz
         KObAt589/thBEwgXKksT3Mx++Mv0VfCBacVA6jmsWZ82hdXyU7k6gbnGvFrBuG79Xdsh
         172NoX+br8GvKleZgwVo841fbM4WLcW/G6i0hqoyiRe4X+PA02D5LlQ/d22v34BmLlc1
         RaLf8hOHI08zJPWV9tUaEEdmQlwmyyMqBJvN+SOcICFtR1vBsHBVeYWh6mMPi+ce+2xi
         gcgg==
X-Gm-Message-State: APjAAAVC/dw88gX/vEycsJj/wBl5Qd8mNR/TWTs9YsWR5g2jzRizvxbX
        iA7Z0mbiz65XAoiV1AFlG911caDzSKjeJCnPVupjTrZLssvgqDBAMUGGIr6t+3ELTCFIGAXJ89w
        bbqzObDeIfhH2
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr3054568wrn.29.1571911991955;
        Thu, 24 Oct 2019 03:13:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxbjWsk+uYJ5GCUImfWcetRrlFjzBnZkqyCrD7do492wiZxHkC9gZGPWW3T+D/g68EBJcNoQg==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr3054534wrn.29.1571911991687;
        Thu, 24 Oct 2019 03:13:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id 6sm2277393wmd.36.2019.10.24.03.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 03:13:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 08AA51804B1; Thu, 24 Oct 2019 12:13:10 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
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
In-Reply-To: <5db128153c75_549d2affde7825b85e@john-XPS-13-9370.notmuch>
References: <20191018040748.30593-1-toshiaki.makita1@gmail.com> <5da9d8c125fd4_31cf2adc704105c456@john-XPS-13-9370.notmuch> <22e6652c-e635-4349-c863-255d6c1c548b@gmail.com> <5daf34614a4af_30ac2b1cb5d205bce4@john-XPS-13-9370.notmuch> <87h840oese.fsf@toke.dk> <5db128153c75_549d2affde7825b85e@john-XPS-13-9370.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 24 Oct 2019 12:13:09 +0200
Message-ID: <87sgniladm.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: TV3uus_NOD2CaWwtyiqqUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> John Fastabend <john.fastabend@gmail.com> writes:
>>=20
>> > I think for sysadmins in general (not OVS) use case I would work
>> > with Jesper and Toke. They seem to be working on this specific
>> > problem.
>>=20
>> We're definitely thinking about how we can make "XDP magically speeds up
>> my network stack" a reality, if that's what you mean. Not that we have
>> arrived at anything specific yet...
>
> There seemed to be two thoughts in the cover letter one how to make
> OVS flow tc path faster via XDP. And the other how to make other users
> of tc flower software stack faster.
>
> For the OVS case seems to me that OVS should create its own XDP
> datapath if its 5x faster than the tc flower datapath. Although
> missing from the data was comparing against ovs kmod so that
> comparison would also be interesting. This way OVS could customize
> things and create only what they need.
>
> But the other case for a transparent tc flower XDP a set of user tools
> could let users start using XDP for this use case without having to
> write their own BPF code. Anyways I had the impression that might be
> something you and Jesper are thinking about, general usability for
> users that are not necessarily writing their own network.

Yeah, you are right that it's something we're thinking about. I'm not
sure we'll actually have the bandwidth to implement a complete solution
ourselves, but we are very much interested in helping others do this,
including smoothing out any rough edges (or adding missing features) in
the core XDP feature set that is needed to achieve this :)

-Toke

