Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6786835507B
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 12:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbhDFKGk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 06:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241197AbhDFKGi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Apr 2021 06:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617703590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMmoJ8lzD0jdeUc9n0Wk+eKCrv0ig+3eGAmzp2n3I2E=;
        b=ObLlaAiW/jethRX3PH0Ekui0AdngzW2j78M2ekH+uXmT+q50MNvuZTZWWkOCNxfdTXJUVX
        TJj4rVwTnDZu50+acKUHrCIYnwYbEdC2UHatzZbuTOgYT/jfDPf+vD5rwievHv/Gxx3X6G
        rk+QQThUtZaCfA8BZNn6kAjR5pUgubU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-9-mtuGAYNHiDUt3DK_PFRA-1; Tue, 06 Apr 2021 06:06:26 -0400
X-MC-Unique: 9-mtuGAYNHiDUt3DK_PFRA-1
Received: by mail-ej1-f70.google.com with SMTP id gn30so5245038ejc.3
        for <bpf@vger.kernel.org>; Tue, 06 Apr 2021 03:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HMmoJ8lzD0jdeUc9n0Wk+eKCrv0ig+3eGAmzp2n3I2E=;
        b=cSkw9mPq+VP2p58W6QD3MbN80ZzGmhTcbGFYp/OBoubiRUlhrnhntTTocSbwFdc6bX
         ZQBadAWS/dKTj1Bi0iupYqLQHhjhyQVRnqsCJHhKtzyAsoCNhZ5KoRZotISHf4p1tgCt
         AM5hjWslGGdnLJh7FSCNuHPZjdtoz6lJZZ4Fi3iUK9hLIX82uW27/KfS3NCcQEDs1Mhb
         WyQu6X0R1wLYrNdUW/gbZkene6EMB8jju0o4QMCSITSakjyDwk7+gdZmPgc8ncyMKVrn
         C5WbFt26WpFOMko0aNRVBnaw77rT9cI+RCvV8KaSp3UwyDfBAMdWjia3PNiml95jKhxh
         HKgg==
X-Gm-Message-State: AOAM533n5+7Sy1HZEbJggA7bs00q4jBYvCJpgdNSyT+oc3BffR7QwZ0v
        D7TZ4FhXcTzqIo8Ucdf24exJdtFy4HQx/1emcaVfLtPKXt0cP6NDP9xPkSzvo2O+i9yrGU8cr4w
        YyFWUZBp3sfg0
X-Received: by 2002:a05:6402:1b1c:: with SMTP id by28mr12908366edb.62.1617703585695;
        Tue, 06 Apr 2021 03:06:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkFahB+GBVvfN5+4DjXC410VqB3rQQ1MthTGIdEaIgp48fePTzVnaVaxK/KzASTOExPeqmdA==
X-Received: by 2002:a05:6402:1b1c:: with SMTP id by28mr12908347edb.62.1617703585534;
        Tue, 06 Apr 2021 03:06:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y24sm13732387eds.23.2021.04.06.03.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:06:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5D5CF180300; Tue,  6 Apr 2021 12:06:24 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/5] libbpf: add low level TC-BPF API
In-Reply-To: <CAEf4Bzaeu4apgEtwS_3q1iPuURjPXMs9H43cYUtJSmjPMU5M9A@mail.gmail.com>
References: <20210325120020.236504-4-memxor@gmail.com>
 <CAEf4Bzbz9OQ_vfqyenurPV7XRVpK=zcvktwH2Dvj-9kUGL1e7w@mail.gmail.com>
 <20210328080648.oorx2no2j6zslejk@apollo>
 <CAEf4BzaMsixmrrgGv6Qr68Ytq8k9W+WP6m4Vdb1wDhDFBKStgw@mail.gmail.com>
 <48b99ccc-8ef6-4ba9-00f9-d7e71ae4fb5d@iogearbox.net>
 <20210331094400.ldznoctli6fljz64@apollo>
 <5d59b5ee-a21e-1860-e2e5-d03f89306fd8@iogearbox.net>
 <20210402152743.dbadpgcmrgjt4eca@apollo>
 <CAADnVQ+wqrEnOGd8E1yp+1WTAx8ZcAx3HUjJs6ipPd0eKmOrgA@mail.gmail.com>
 <20210402190806.nhcgappm3iocvd3d@apollo>
 <20210403174721.vg4wle327wvossgl@ast-mbp>
 <CAEf4Bzaeu4apgEtwS_3q1iPuURjPXMs9H43cYUtJSmjPMU5M9A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 06 Apr 2021 12:06:24 +0200
Message-ID: <87blar4ti7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Sat, Apr 3, 2021 at 10:47 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Sat, Apr 03, 2021 at 12:38:06AM +0530, Kumar Kartikeya Dwivedi wrote:
>> > On Sat, Apr 03, 2021 at 12:02:14AM IST, Alexei Starovoitov wrote:
>> > > On Fri, Apr 2, 2021 at 8:27 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> > > > [...]
>> > >
>> > > All of these things are messy because of tc legacy. bpf tried to follow tc style
>> > > with cls and act distinction and it didn't quite work. cls with
>> > > direct-action is the only
>> > > thing that became mainstream while tc style attach wasn't really addressed.
>> > > There were several incidents where tc had tens of thousands of progs attached
>> > > because of this attach/query/index weirdness described above.
>> > > I think the only way to address this properly is to introduce bpf_link style of
>> > > attaching to tc. Such bpf_link would support ingress/egress only.
>> > > direction-action will be implied. There won't be any index and query
>> > > will be obvious.
>> >
>> > Note that we already have bpf_link support working (without support for pinning
>> > ofcourse) in a limited way. The ifindex, protocol, parent_id, priority, handle,
>> > chain_index tuple uniquely identifies a filter, so we stash this in the bpf_link
>> > and are able to operate on the exact filter during release.
>>
>> Except they're not unique. The library can stash them, but something else
>> doing detach via iproute2 or their own netlink calls will detach the prog.
>> This other app can attach to the same spot a different prog and now
>> bpf_link__destroy will be detaching somebody else prog.
>>
>> > > So I would like to propose to take this patch set a step further from
>> > > what Daniel said:
>> > > int bpf_tc_attach(prog_fd, ifindex, {INGRESS,EGRESS}):
>> > > and make this proposed api to return FD.
>> > > To detach from tc ingress/egress just close(fd).
>> >
>> > You mean adding an fd-based TC API to the kernel?
>>
>> yes.
>
> I'm totally for bpf_link-based TC attachment.
>
> But I think *also* having "legacy" netlink-based APIs will allow
> applications to handle older kernels in a much nicer way without extra
> dependency on iproute2. We have a similar situation with kprobe, where
> currently libbpf only supports "modern" fd-based attachment, but users
> periodically ask questions and struggle to figure out issues on older
> kernels that don't support new APIs.

+1; I am OK with adding a new bpf_link-based way to attach TC programs,
but we still need to support the netlink API in libbpf.

> So I think we'd have to support legacy TC APIs, but I agree with
> Alexei and Daniel that we should keep it to the simplest and most
> straightforward API of supporting direction-action attachments and
> setting up qdisc transparently (if I'm getting all the terminology
> right, after reading Quentin's blog post). That coincidentally should
> probably match how bpf_link-based TC API will look like, so all that
> can be abstracted behind a single bpf_link__attach_tc() API as well,
> right? That's the plan for dealing with kprobe right now, btw. Libbpf
> will detect the best available API and transparently fall back (maybe
> with some warning for awareness, due to inherent downsides of legacy
> APIs: no auto-cleanup being the most prominent one).

Yup, SGTM: Expose both in the low-level API (in bpf.c), and make the
high-level API auto-detect. That way users can also still use the
netlink attach function if they don't want the fd-based auto-close
behaviour of bpf_link.

-Toke

