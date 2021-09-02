Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C5A3FF1EC
	for <lists+bpf@lfdr.de>; Thu,  2 Sep 2021 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346534AbhIBQ6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 12:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346521AbhIBQ60 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 2 Sep 2021 12:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630601844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8Q1kK8grLBRDrHjzp9sq1sAAV8774+oYHuiomT7vc8=;
        b=fiUSZlf4l+bIpvTI9QLdOPrk5fvYOaffJ2+umQaNwZ0GP7/vXYLcWp7yDeV75kVfQJ5kSw
        CySd9syAgx65IBWBDedSkO86+GLpdj+o7mPqv3D/84SHEYjf7I1ceP+f2zD4O0s91J6u5u
        yLzVB9E49X4zAOk6qi/ON9WG9sTGP9k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-MvrILhprOfqp9Lr3R8-hQA-1; Thu, 02 Sep 2021 12:57:23 -0400
X-MC-Unique: MvrILhprOfqp9Lr3R8-hQA-1
Received: by mail-ej1-f70.google.com with SMTP id x21-20020a170906135500b005d8d4900c5eso1244656ejb.4
        for <bpf@vger.kernel.org>; Thu, 02 Sep 2021 09:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Y8Q1kK8grLBRDrHjzp9sq1sAAV8774+oYHuiomT7vc8=;
        b=dTU0Y9o91L+n5g7qcGKvai9bdL1k82IMnGE/ptFvfRA6nV/zLtp+GSxL3SiEfwxQnJ
         4XqiLDd/mPsi7g6pmtAIHRzASTSWgoqn7z2R34E+UUa+7vY1cNg8MrhSBHVC6Iu2IYre
         2ZVhKBHMIHOKURqJvfIJ1bGPnI3IXlHkJI+GsZ5TwAI9bD4363ZDOs5nN7vTE8s9Sde2
         Cx5kyy5OBjr3PeEixEIBUtDKzDO4ym0qpETGb9KhLJmVvYFzyNYb0sGfD5EyHueEkxWj
         MP/1EXtS8NAL2NafFSfr6TajJzzW2Ma+NvOQkfTXjh1uWI3ciKwx5kz8AZnOscCNTHgx
         dOLg==
X-Gm-Message-State: AOAM532gu7bfiNLHnOMyvwAVEEvBo7aSS7FLpkCqx1zGqUInMWStVJ3X
        XI+yWZ1QIViVrFUZvYj/Kw99jiGKOVKXSlZ4fuaOvMHxB7E8c5hqBkEPrkNiItC3ito6k4n7nCs
        h+u76QRVqCG9C
X-Received: by 2002:a17:906:3146:: with SMTP id e6mr4787466eje.296.1630601841271;
        Thu, 02 Sep 2021 09:57:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA7t1ufeC8Jy4UEBuz0UedPDZt+yymBf/BVOrjcuL/zq8TriQxH/MNambvq/MaIXWjPSEoGQ==
X-Received: by 2002:a17:906:3146:: with SMTP id e6mr4787374eje.296.1630601839982;
        Thu, 02 Sep 2021 09:57:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bm1sm1494793ejb.38.2021.09.02.09.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:57:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DC0211800EB; Thu,  2 Sep 2021 18:57:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Cong Wang <cong.wang@bytedance.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC Patch net-next] net_sched: introduce eBPF based Qdisc
In-Reply-To: <20210901174543.xukawl7ylkqzbuax@kafai-mbp.dhcp.thefacebook.com>
References: <20210821010240.10373-1-xiyou.wangcong@gmail.com>
 <20210824234700.qlteie6al3cldcu5@kafai-mbp>
 <CAM_iQpWP_kvE58Z+363n+miTQYPYLn6U4sxMKVaDvuRvjJo_Tg@mail.gmail.com>
 <612f137f4dc5c_152fe20891@john-XPS-13-9370.notmuch>
 <871r68vapw.fsf@toke.dk>
 <20210901174543.xukawl7ylkqzbuax@kafai-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 02 Sep 2021 18:57:17 +0200
Message-ID: <871r66ud8y.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:

> On Wed, Sep 01, 2021 at 12:42:03PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> John Fastabend <john.fastabend@gmail.com> writes:
>>=20
>> > Cong Wang wrote:
>> >> On Tue, Aug 24, 2021 at 4:47 PM Martin KaFai Lau <kafai@fb.com> wrote:
>> >> > Please explain more on this.  What is currently missing
>> >> > to make qdisc in struct_ops possible?
>> >>=20
>> >> I think you misunderstand this point. The reason why I avoid it is
>> >> _not_ anything is missing, quite oppositely, it is because it requires
>> >> a lot of work to implement a Qdisc with struct_ops approach, literally
>> >> all those struct Qdisc_ops (not to mention struct Qdisc_class_ops).
>> >> WIth current approach, programmers only need to implement two
>> >> eBPF programs (enqueue and dequeue).
> _if_ it is using as a qdisc object/interface,
> the patch "looks" easier because it obscures some of the ops/interface
> from the bpf user.  The user will eventually ask for more flexibility
> and then an on-par interface as the kernel's qdisc.  If there are some
> common 'ops', the common bpf code can be shared as a library in userspace
> or there is also kfunc call to call into the kernel implementation.
> For existing kernel qdisc author,  it will be easier to use the same
> interface also.

The question is if it's useful to provide the full struct_ops for
qdiscs? Having it would allow a BPF program to implement that interface
towards userspace (things like statistics, classes etc), but the
question is if anyone is going to bother with that given the wealth of
BPF-specific introspection tools already available?

My hope is that we can (longer term) develop some higher-level tools to
express queueing policies that can then generate the BPF code needed to
implement them. Or as a start just some libraries to make this easier,
which I think is also what you're hinting at here? :)

>> > Another idea. Rather than work with qdisc objects which creates all
>> > these issues with how to work with existing interfaces, filters, etc.
>> > Why not create an sk_buff map? Then this can be used from the existing
>> > egress/ingress hooks independent of the actual qdisc being used.
>>=20
>> I agree. In fact, I'm working on doing just this for XDP, and I see no
>> reason why the map type couldn't be reused for skbs as well. Doing it
>> this way has a couple of benefits:
>>=20
>> - It leaves more flexibility to BPF: want a simple FIFO queue? just
>>   implement that with a single queue map. Or do you want to build a full
>>   hierarchical queueing structure? Just instantiate as many queue maps
>>   as you need to achieve this. Etc.
> Agree.  Regardless how the interface may look like,
> I even think being able to queue/dequeue an skb into different bpf maps
> should be the first thing to do here.  Looking forward to your patches.

Thanks! Guess I should go work on them, then :D

>> - The behaviour is defined entirely by BPF program behaviour, and does
>>   not require setting up a qdisc hierarchy in addition to writing BPF
>>   code.
> Interesting idea.  If it does not need to use the qdisc object/interface
> and be able to do the qdisc hierarchy setup in a programmable way, it may
> be nice.  It will be useful for the future patches to come with some
> bpf prog examples to do that.

Absolutely; we plan to include example algorithm implementations as well!

>> - It should be possible to structure the hooks in a way that allows
>>   reusing queueing algorithm implementations between the qdisc and XDP
>>   layers.
>>=20
>> > You mention skb should not be exposed to userspace? Why? Whats the
>> > reason for this? Anyways we can make kernel only maps if we want or
>> > scrub the data before passing it to userspace. We do this already in
>> > some cases.
>>=20
>> Yup, that's my approach as well.
>>=20
>> > IMO it seems cleaner and more general to allow sk_buffs
>> > to be stored in maps and pulled back out later for enqueue/dequeue.
>>=20
>> FWIW there's some gnarly details here (for instance, we need to make
>> sure the BPF program doesn't leak packet references after they are
>> dequeued from the map). My idea is to use a scheme similar to what we do
>> for XDP_REDIRECT, where a helper sets some hidden variables and doesn't
>> actually remove the packet from the queue until the BPF program exits
>> (so the kernel can make sure things are accounted correctly).
> The verifier is tracking the sk's references.  Can it be reused to
> track the skb's reference?

I was vaguely aware that it does this, but have not looked at the
details. Would be great if this was possible; will see how far I get
with it, and iterate from there (with your help, hopefully :))

-Toke

