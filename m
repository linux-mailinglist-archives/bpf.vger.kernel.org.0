Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36679416557
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 20:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242787AbhIWSrG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 14:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242781AbhIWSrG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Sep 2021 14:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632422733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mA1ZreymseI332A07co5Ore8q2n397KYZFqSr+ZrYaY=;
        b=IZlmQNMQlsWC8172VcLU/qStDeWSpuDzBK9c6HJMrkHpBqBaWdYIG5KrLlq1vZ8tmfrQLH
        ezhE2u50PJ8/s5rwXZUxmJxgRgWMGbrptz2A8EHQc3gG8EejFZ6xeWbzrpko25eJZ4O3Yt
        t/1Ar+7fzFYdEsOrt4z5U0wYG59tQ28=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-ZvTWV4aLN-6hE2kbm4j92g-1; Thu, 23 Sep 2021 14:45:32 -0400
X-MC-Unique: ZvTWV4aLN-6hE2kbm4j92g-1
Received: by mail-ed1-f71.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so7631313edn.5
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 11:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mA1ZreymseI332A07co5Ore8q2n397KYZFqSr+ZrYaY=;
        b=bsyEP76Nue01VLDUifZ+uxJnYamGEtHn6+b4c7cH7sen09j8ZNxGnl1wpb96HNnrhC
         xJH+apXm56kKhQsGn3DSWpS2c5ePfTtrZZ9gurkiL6J4XQCxEcC/YbhDjF6RAycQjKNv
         0kyYjFm0Hb8Mqcoh9WSaetu6EOEA7SCIqLHUgWW8gB7tj4N6IcbzChmoUCNabgYP6reO
         o2pjS7/fQhAwM2dDk4MqrgeQrdxxaN2Dvc9crCUHfbW4ZKbicp0C775xaB7TTT1m3QOz
         rXsdm/oq6T+l4nYLvbgXeNXPTT+T45z3TpO3CKuCXso2QRaWqJWKe2Xv0XLGlcV+mxMr
         rj2Q==
X-Gm-Message-State: AOAM533WzYdyc8z4obBDw/zrejDNcT2oiX/nXeCvA3Oy6cVI1aZXcCfp
        vwO4DM1mPD/b1NglzBDM2eEqENfBhUTsriUD/+JWQsACBWcuq5T8psVzDD9Lkukr+HldiNI75+P
        T5sHWDwF/F6zR
X-Received: by 2002:a05:6402:5163:: with SMTP id d3mr305535ede.220.1632422731387;
        Thu, 23 Sep 2021 11:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws5TTO6iFtjsNHDarjLxqk+CWOvGO6oHgPeX5nRB5K6/po3I8VSrFf7N4FmAK3FrNvCKPNTQ==
X-Received: by 2002:a05:6402:5163:: with SMTP id d3mr305483ede.220.1632422731011;
        Thu, 23 Sep 2021 11:45:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z18sm4014413edq.29.2021.09.23.11.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 11:45:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DA204180274; Thu, 23 Sep 2021 20:45:29 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Zvi Effron <zeffron@riotgames.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Lorenzo Bianconi <lbianconi@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: Redux: Backwards compatibility for XDP multi-buff
In-Reply-To: <CAC1LvL2ZFHqqD4jkXdRNY0K-Sm-adb8OpQVcfv--aaQ+Z4j0EQ@mail.gmail.com>
References: <87o88l3oc4.fsf@toke.dk>
 <CAC1LvL1xgFMjjE+3wHH79_9rumwjNqDAS2Yg2NpSvmewHsYScA@mail.gmail.com>
 <87ilyt3i0y.fsf@toke.dk>
 <CAADnVQKi_u6yZnsxEagNTv-XWXtLPpXwURJH0FnGFRgt6weiww@mail.gmail.com>
 <87czp13718.fsf@toke.dk>
 <20210921155118.439c0aa9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87mto41isy.fsf@toke.dk>
 <CAC1LvL2ZFHqqD4jkXdRNY0K-Sm-adb8OpQVcfv--aaQ+Z4j0EQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 23 Sep 2021 20:45:29 +0200
Message-ID: <87bl4jyvue.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Zvi Effron <zeffron@riotgames.com> writes:

> On Wed, Sep 22, 2021 at 1:01 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Jakub Kicinski <kuba@kernel.org> writes:
>>
>> > On Wed, 22 Sep 2021 00:20:19 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>> >> >> Neither of those are desirable outcomes, I think; and if we add a
>> >> >> separate "XDP multi-buff" switch, we might as well make it system-=
wide?
>> >> >
>> >> > If we have an internal flag 'this driver supports multi-buf xdp' ca=
nnot we
>> >> > make xdp_redirect to linearize in case the packet is being redirect=
ed
>> >> > to non multi-buf aware driver (potentially with corresponding non m=
b aware xdp
>> >> > progs attached) from mb aware driver?
>> >>
>> >> Hmm, the assumption that XDP frames take up at most one page has been
>> >> fundamental from the start of XDP. So what does linearise mean in this
>> >> context? If we get a 9k packet, should we dynamically allocate a
>> >> multi-page chunk of contiguous memory and copy the frame into that, or
>> >> were you thinking something else?
>> >
>> > My $.02 would be to not care about redirect at all.
>> >
>> > It's not like the user experience with redirect is anywhere close
>> > to amazing right now. Besides (with the exception of SW devices which
>> > will likely gain mb support quickly) mixed-HW setups are very rare.
>> > If the source of the redirect supports mb so will likely the target.
>>
>> It's not about device support it's about XDP program support: If I run
>> an MB-aware XDP program on a physical interface and redirect the (MB)
>> frame into a container, and there's an XDP program running inside that
>> container that isn't MB-aware, bugs will ensue. Doesn't matter if the
>> veth driver itself supports MB...
>>
>> We could leave that as a "don't do that, then" kind of thing, but that
>> was what we were proposing (as the "do nothing" option) and got some
>> pushback on, hence why we're having this conversation :)
>>
>> -Toke
>>
>
> I hadn't even considered the case of redirecting to a veth pair on the sa=
me
> system. I'm assuming from your statement that the buffers are passed dire=
ctly
> to the ingress inside the container and don't go through the sort of egre=
ss
> process they would if leaving the system? And I'm assuming that's as an
> optimization?

Yeah, if we redirect an XDP frame to a veth, the peer will get the same
xdp_frame, without ever building an SKB.

> I'm not sure that makes a difference, though. It's not about whether the
> driver's code is mb-capable, it's about whether the driver _as currently
> configured_ could generate multiple buffers. If it can, then only an mb-a=
ware
> program should be able to be attached to it (and tail called from whateve=
r's
> attached to it). If it can't, then there should be no way to have multiple
> buffers come to it.
>
> So in the situation you've described, either the veth driver should be in=
 a
> state where it coalesces the multiple buffers into one, fragmenting the f=
rame
> if necessary or drops the frame, or the program attached inside the conta=
iner
> would need to be mb-aware. I'm assuming with the veth driver as written, =
this
> might mean that all programs attached to the veth driver would need to be
> mb-aware, which is obviously undesirable.

Hmm, I guess that as long as mb-frames only show up for large MTUs, the
MTU of the veth device would be a limiting factor just like for physical
devices, so we could just apply the same logic there. Not sure why I
didn't consider that before :/

> All of which significantly adds to the complexity to support mb-aware, so=
 maybe
> this could be developed later? Initially we could have a sysctl toggling =
the
> state 0 single-buffer only, 1 multibuffer allowed. Then later we _could_ =
add a
> state for dynamic control once all XDP supporting drivers support the nec=
essary
> dynamic functionality (if ever). At that point we'd have actual experienc=
e with
> the sysctl and could see how much of a burden having static control is.
>
> I may have been misinterpreting your use case though, and you were talking
> about the XDP program running on the egress side of the redirect? Is that=
 what
> you were talking about case?

No I was talking about exactly what you outlined above. Although longer
term, I also think we can use XDP mb as a way to avoid having to
linearise SKBs when running XDP on them in veth (and for generic XDP) :)

-Toke

