Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90F7E63B7
	for <lists+bpf@lfdr.de>; Sun, 27 Oct 2019 16:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfJ0PYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Oct 2019 11:24:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31529 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727312AbfJ0PYa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 27 Oct 2019 11:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572189868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k0PF6fDa4IHrKYA/cwKAZkTPLP3n9Ork1zMp9PtEt4U=;
        b=UyM85Nabz0rrz93fb+Ralm9ztbRinjept4R+ZG4F09fyvbxIf7aCcVH/Pk2+tQejqItAbr
        /h6eAqcwTSmKgUvZdpoNcbplnkyU3ZF5LBHKwgGey9D+q0rWu1oZ74v9EKAm4HZhbYOox/
        t0Am1L+dPbeVwLtj2WRdHX6qIx0QDR4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-zmlnd5UfNXW3dXIIRsERGQ-1; Sun, 27 Oct 2019 11:24:27 -0400
Received: by mail-lj1-f197.google.com with SMTP id n3so1397610ljg.23
        for <bpf@vger.kernel.org>; Sun, 27 Oct 2019 08:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=k0PF6fDa4IHrKYA/cwKAZkTPLP3n9Ork1zMp9PtEt4U=;
        b=A0p/KZtfjhJFaDtp4nHjjWbqYFSf0xzbP/dxiIfXEzNavfGlp9XBtvlztXUSJpqfQO
         ioCSQV5165OfBluxttmNKPWug0Ef0+P0RSXYZofKWcVk+kVZuA1ZwDhgq2lDYPgYHGdf
         3h+8tLMl2mC1ikdDscLISw2sJv6AQfi4gx5UOdgMgeabUWyp7zfWvk7y7JmDPFlsUFUo
         5xz8SSYqHNvHoAfeZ04gxO/jMloIVieq/TH2ZNquWOKYbzvzftOa5F5/pKkIC/54zhl7
         RAVLGZwObgvFIfTFT/JWL1xhw+CauGq2r7q44Y4XOItTj/GVe8ool4hEPftVcw21c+EE
         FheQ==
X-Gm-Message-State: APjAAAXN7G5DWeepzxpFmq7N47Tdu5NoC+5lyxtS5EPd0o3agQuriHDx
        FW9TEpNFrfropLaiQoHMRyXX4R1/O2WjAKUxC9ARoK2OZKgN4tl0aSKc8Rb2yKGB33/KvkY/1xQ
        zgG8iVvysGeX3
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr422585lfo.87.1572189866104;
        Sun, 27 Oct 2019 08:24:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCX6pcIFHS8vTHfvaGy23y34eKpDgWZoOBBqOkCVB20JMYYV2lMdxl4FbPoE3QfgopaVeaVg==
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr422552lfo.87.1572189865846;
        Sun, 27 Oct 2019 08:24:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id 4sm4114513ljv.87.2019.10.27.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 08:24:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 858011818B6; Sun, 27 Oct 2019 16:24:24 +0100 (CET)
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
In-Reply-To: <282d61fe-7178-ebf1-e0da-bdc3fb724e4b@gmail.com>
References: <20191018040748.30593-1-toshiaki.makita1@gmail.com> <5da9d8c125fd4_31cf2adc704105c456@john-XPS-13-9370.notmuch> <22e6652c-e635-4349-c863-255d6c1c548b@gmail.com> <5daf34614a4af_30ac2b1cb5d205bce4@john-XPS-13-9370.notmuch> <87h840oese.fsf@toke.dk> <282d61fe-7178-ebf1-e0da-bdc3fb724e4b@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 27 Oct 2019 16:24:24 +0100
Message-ID: <87wocqrz2v.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: zmlnd5UfNXW3dXIIRsERGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toshiaki Makita <toshiaki.makita1@gmail.com> writes:

> On 19/10/23 (=E6=B0=B4) 2:45:05, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> John Fastabend <john.fastabend@gmail.com> writes:
>>=20
>>> I think for sysadmins in general (not OVS) use case I would work
>>> with Jesper and Toke. They seem to be working on this specific
>>> problem.
>>=20
>> We're definitely thinking about how we can make "XDP magically speeds up
>> my network stack" a reality, if that's what you mean. Not that we have
>> arrived at anything specific yet...
>>=20
>> And yeah, I'd also be happy to discuss what it would take to make a
>> native XDP implementation of the OVS datapath; including what (if
>> anything) is missing from the current XDP feature set to make this
>> feasible. I must admit that I'm not quite clear on why that wasn't the
>> approach picked for the first attempt to speed up OVS using XDP...
>
> Here's some history from William Tu et al.
> https://linuxplumbersconf.org/event/2/contributions/107/
>
> Although his aim was not to speed up OVS but to add kernel-independent=20
> datapath, his experience shows full OVS support by eBPF is very
> difficult.

Yeah, I remember seeing that presentation; it still isn't clear to me
what exactly the issue was with implementing the OVS datapath in eBPF.
As far as I can tell from glancing through the paper, only lists program
size and lack of loops as limitations; both of which have been lifted
now.

The results in the paper also shows somewhat disappointing performance
for the eBPF implementation, but that is not too surprising given that
it's implemented as a TC eBPF hook, not an XDP program. I seem to recall
that this was also one of the things puzzling to me back when this was
presented...

-Toke

