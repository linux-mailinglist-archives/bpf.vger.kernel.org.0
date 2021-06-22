Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B636E3B0FFA
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 00:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhFVWVE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Jun 2021 18:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51925 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229625AbhFVWVE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Jun 2021 18:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624400327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uVjhLDtJhsrPmwpZ576YLQgGs/VGWOCyo3tFRjK1wVc=;
        b=E0yyc9fbxJFAB+t00kAS12Qe/tuCVb4hcWxDsJB/DcoOytPbtBE3azUNfHNCqMSGo0jxdp
        01HwRyoDHx9FeLuPADySA4mNrSFVfhToZG3GirLzPGhLyjKIX4fb1myGLXFNvHFJlB+uFL
        XegDwwenRJibiraeXvsETZPe5iX+4mk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-mA0ZDs9GNLylXGKD92HMEQ-1; Tue, 22 Jun 2021 18:18:46 -0400
X-MC-Unique: mA0ZDs9GNLylXGKD92HMEQ-1
Received: by mail-wr1-f72.google.com with SMTP id j1-20020adfb3010000b02901232ed22e14so161188wrd.5
        for <bpf@vger.kernel.org>; Tue, 22 Jun 2021 15:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uVjhLDtJhsrPmwpZ576YLQgGs/VGWOCyo3tFRjK1wVc=;
        b=emnY2KNIDUBh00/s1bpkysDqJIaahbcpaYmW5VM4ZJPp6mFO0qIdFncqAu2SVXp7yL
         qvJs8gUlMLLO8ykaBKgwnkm+i9AflRwwMkQqGduBdHvXejhAHK7/wkDzCw8cQ9vrnocq
         +N92SZiclxxik7xFmRkQLBFAs8KSgNiNkb/nQpS7cQPNQh0xHKrQWLZ0x6buX4VHGwHo
         HS/tEcNUMIuMtmU/TPsKmGhmM3UEDdlB7CoWhVFu+hFH0yBuzZZOHawemcWCctTbdAHU
         gTdKmUSvCfv3M1xkwleWvoGs5oTap0lcQJcLODJzum2UScQ80Sg1M7ael5SI4+F3dU/C
         OSOA==
X-Gm-Message-State: AOAM532m/8+uK+WrpxYl9XlRbfiRhnipINg+KOwQvut7sUBrnh+9DKEf
        3f4IIk4zt4jXPbsDlxImeW4m3SpnIsVW5s6u/g9i9Flt2AY7+uk6mdVr+zz2n/Vu1I97ezAz11z
        o0sEr4VtWgj/a
X-Received: by 2002:a17:907:62a5:: with SMTP id nd37mr6232986ejc.148.1624398507924;
        Tue, 22 Jun 2021 14:48:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJYc4EPMTh0Uqt1cLxNZiku3xd51dHPTQpEsvO1j5WnZ7aApODp+VBuPPzksxLysFyRy9DeA==
X-Received: by 2002:a17:907:62a5:: with SMTP id nd37mr6232977ejc.148.1624398507771;
        Tue, 22 Jun 2021 14:48:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e6sm12947248edk.63.2021.06.22.14.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 14:48:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BCF71180730; Tue, 22 Jun 2021 23:48:26 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     paulmck@kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 03/16] xdp: add proper __rcu annotations to
 redirect map entries
In-Reply-To: <20210622202604.GH4397@paulmck-ThinkPad-P17-Gen-1>
References: <20210617212748.32456-1-toke@redhat.com>
 <20210617212748.32456-4-toke@redhat.com>
 <1881ecbe-06ec-6b0a-836c-033c31fabef4@iogearbox.net>
 <87zgvirj6g.fsf@toke.dk> <87r1guovg2.fsf@toke.dk>
 <20210622202604.GH4397@paulmck-ThinkPad-P17-Gen-1>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Jun 2021 23:48:26 +0200
Message-ID: <874kdppo45.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Tue, Jun 22, 2021 at 03:55:25PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>=20
>> >> It would also be great if this scenario in general could be placed
>> >> under the Documentation/RCU/whatisRCU.rst as an example, so we could
>> >> refer to the official doc on this, too, if Paul is good with this.
>> >
>> > I'll take a look and see if I can find a way to fit it in there...
>>=20
>> OK, I poked around in Documentation/RCU and decided that the most
>> natural place to put this was in checklist.rst which already talks about
>> local_bh_disable(), but a bit differently. Fixing that up to correspond
>> to what we've been discussing in this thread, and adding a mention of
>> XDP as a usage example, results in the patch below.
>>=20
>> Paul, WDYT?
>
> I think that my original paragraph needed to have been updated back
> when v4.20 came out.  And again when RCU Tasks Trace came out.  ;-)
>
> So I did that updating, then approximated your patch on top of it,
> as shown below.  Does this work for you?

Yup, LGTM, thanks! Shall I just fold that version into the next version
of my series, or do you want to take it through your tree (I suppose
it's independent of the rest, so either way is fine by me)?

-Toke

