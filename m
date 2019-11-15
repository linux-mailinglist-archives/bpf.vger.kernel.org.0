Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47F8FDEAF
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2019 14:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKONQI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Nov 2019 08:16:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727249AbfKONQH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Nov 2019 08:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573823766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GeD65KwsS+fE6Or7ud2CVWjI1CEIZ+Ix4+TxZCqIdtE=;
        b=gKce9p7Qff7xROk2b3upFn7p4XPWlYBOFIc6T/esCo3GEe5e5JqJiDiLe9oZyhrKh5xI9S
        W3x7A9FSPqE/Bs1V4/JOlL643aHso6wZ76lq49pwVx/gFwRXmYrtQC8q5PxuX60t66auQZ
        0V3ra1foBo/qnUrAnJvJ4mLeLn7p1hA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-KcVt2Z-3OgiaX8k-vVMZmQ-1; Fri, 15 Nov 2019 08:16:05 -0500
Received: by mail-lf1-f71.google.com with SMTP id p4so3058020lfo.10
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2019 05:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uSEHhC3h0jA99je5phr1Tt1BRvYnZITqg83hPOTs1ws=;
        b=JvQ5zfEcLfW/Ik3nH+C2v95i9NiHrECnnIHlRe/ATEcOYD1Q+recZ1O2gGyI29VkKX
         M0Huyt+q1heydpmlfKJ7weBfb38XVziseiUyvHfD53jhZK4JJtlaOhL2+dIgKQJcuMY2
         TACi3O3nJMx7GuUlVxu7zUAQGc7Dt5SnQzI2KXJ+8GHg3vwPUmiwWeL4SNMX1H1OlIyk
         mJwaWRXDOl3XebPaxcLKYfp3P+NLfUQq7TTg6QVU0DT0xBG/ZaefBW8IPJhiXcxUiKgP
         EuPFObIK7OtNGuIQGXNd2H8IjtbgSIveVdY13YyW3kjHpp3H6XnHjwPsJCe0rVZe5JTe
         ECFA==
X-Gm-Message-State: APjAAAWhg4Zc09iBfmw/e7hpbFYyrH2Lstvzn1QZEN0zGxliSwUxYZMu
        2WlqTujQ0dekPXZFJN6syThRGbRhVbnbR3VIyj8hD62zn6Eoiw6h/2wWI+D0LEN/fEZgm0qP1Hn
        gVAaRF0vsRMSd
X-Received: by 2002:a19:c606:: with SMTP id w6mr11110855lff.71.1573823763688;
        Fri, 15 Nov 2019 05:16:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxP4lmDKLFMQ1LGtdYAF7daaSBpCIUGAnQN1NBdC2bR6u836rFBA2izTJO1E8Qqdyeg6BGE2w==
X-Received: by 2002:a19:c606:: with SMTP id w6mr11110838lff.71.1573823763430;
        Fri, 15 Nov 2019 05:16:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id j23sm4253293lji.41.2019.11.15.05.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:16:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CD7D51818C5; Fri, 15 Nov 2019 14:16:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     William Tu <u9012063@gmail.com>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        pravin shelar <pshelar@ovn.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [RFC PATCH v2 bpf-next 00/15] xdp_flow: Flow offload to XDP
In-Reply-To: <CALDO+SbqcoiwJn3jskpPTjdJyK5932r0cEzs=1R6p=CWgERLuw@mail.gmail.com>
References: <87h840oese.fsf@toke.dk> <282d61fe-7178-ebf1-e0da-bdc3fb724e4b@gmail.com> <87wocqrz2v.fsf@toke.dk> <20191027.121727.1776345635168200501.davem@davemloft.net> <09817958-e331-63e9-efbf-05341623a006@gmail.com> <CALDO+SaxbNpON+=3zA4r4k6BE7UhbGU1WovW8Owyi8-9J_Wbkw@mail.gmail.com> <53538a02-e6d3-5443-8251-bef381c691a0@gmail.com> <CALDO+SbqcoiwJn3jskpPTjdJyK5932r0cEzs=1R6p=CWgERLuw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 15 Nov 2019 14:16:01 +0100
Message-ID: <877e41mga6.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: KcVt2Z-3OgiaX8k-vVMZmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

William Tu <u9012063@gmail.com> writes:

> On Thu, Nov 14, 2019 at 2:06 AM Toshiaki Makita
> <toshiaki.makita1@gmail.com> wrote:
>>
>> On 2019/11/13 2:50, William Tu wrote:
>> > On Wed, Oct 30, 2019 at 5:32 PM Toshiaki Makita
>> > <toshiaki.makita1@gmail.com> wrote:
>> >>
>> >> On 2019/10/28 4:17, David Miller wrote:
>> >>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> >>> Date: Sun, 27 Oct 2019 16:24:24 +0100
>> >>>
>> >>>> The results in the paper also shows somewhat disappointing performa=
nce
>> >>>> for the eBPF implementation, but that is not too surprising given t=
hat
>> >>>> it's implemented as a TC eBPF hook, not an XDP program. I seem to r=
ecall
>> >>>> that this was also one of the things puzzling to me back when this =
was
>> >>>> presented...
>> >>>
>> >>> Also, no attempt was made to dyanamically optimize the data structur=
es
>> >>> and code generated in response to features actually used.
>> >>>
>> >>> That's the big error.
>> >>>
>> >>> The full OVS key is huge, OVS is really quite a monster.
>> >>>
>> >>> But people don't use the entire key, nor do they use the totality of
>> >>> the data paths.
>> >>>
>> >>> So just doing a 1-to-1 translation of the OVS datapath into BPF make=
s
>> >>> absolutely no sense whatsoever and it is guaranteed to have worse
>> >>> performance.
>> >
>> > 1-to-1 translation has nothing to do with performance.
>>
>> I think at least key size matters.
>> One big part of hot spots in xdp_flow bpf program is hash table lookup.
>> Especially hash calculation by jhash and key comparison are heavy.
>> The computational cost heavily depends on key size.
>>
>> If umh can determine some keys won't be used in some way (not sure if it=
's
>> practical though), umh can load an XDP program which uses less sized
>> key. Also it can remove unnecessary key parser routines.
>> If it's possible, the performance will increase.
>>
> Yes, that's a good point.
> In other meeting people also gave me this suggestions.
>
> Basically it's "on-demand flow key parsing using eBPF"
> The key parsing consists of multiple eBPF programs, and
> based on the existing rules, load the program and parse minimum
> necessary fields required by existing rules. This will definitely
> have better performance.

See the xdp-filter program[0] for a simple example of how to do this
with pre-compiled BPF programs. Basically, what it does is generate
different versions of the same program with different subsets of
functionality included (through ifdefs). The feature set of each program
is saved as a feature bitmap, and the loader will dynamically select
which program to load based on which features the user enables at
runtime.

The nice thing about this is that it doesn't require dynamic program
generation, and everything can be compiled ahead of time. The drawback
is that you'll end up with a combinatorial explosion of program variants
if you want full granularity in your feature selection.

-Toke

[0] https://github.com/xdp-project/xdp-tools/tree/master/xdp-filter

