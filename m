Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D531EA56
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 14:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhBRNQY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 08:16:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232200AbhBRLFj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 06:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613646247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVGvS4WtBOitWgg3cGAIoGlh1baXvecO5zsS83DdOKw=;
        b=GxWS8nR+qgRiCipABTpAbVjWQjnwcBwuxrNqRJota9JJObVpfEZG6Xi2xucAyo3h2grMMZ
        5nXISnrhW8N7z2iM28hirSi1QTCm4OVB2l39rZAALFMSGx0LEz2qPxjn0wTkY7R4Xrkmbm
        9DHoQ0RT6uNi/bpNklcBqf+TSVEyv0g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-MFfIyHWxN4KdmBEn-aMNeQ-1; Thu, 18 Feb 2021 06:00:34 -0500
X-MC-Unique: MFfIyHWxN4KdmBEn-aMNeQ-1
Received: by mail-ed1-f70.google.com with SMTP id bd22so725853edb.4
        for <bpf@vger.kernel.org>; Thu, 18 Feb 2021 03:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WVGvS4WtBOitWgg3cGAIoGlh1baXvecO5zsS83DdOKw=;
        b=g91+TA/K6kZ7hZwuzmNjdTNLByDhi5AInBC3pKUPlXAHcXXS9wLGPL+O3c1kFzPUxP
         TtBHl/DmcPvhT9AR6Y/SXsNtZoInJQKZuWO14EELQUHFZMTslTQCN4ocz1sxYU+tJqG/
         GKka92TpwBIgw3yq0l401B0CLsBVuaSGj9DqahSUcM3x3BLDAF+CEZcSMqFh9j/sLlxk
         w33aaNZal7n9pXWOxZ/DM3IAatcqAtpg9nVSdykwlU5ZE6/4ycO0jSKCVtAhR7Fypnjz
         Y5OnhLhGUjVxMDffZP+DMJ6YyFuUhNbhVS6CujQElO0Z/o5oigO5s0BmCtp8lyIwgN4a
         emmQ==
X-Gm-Message-State: AOAM530a7wMok5X9qSjTx3gA71/6b9yWD+QHsSML2lVkIOt31oi8Rimf
        8m0PzFdf6sN3QXI4xEeHUs5WjeePQJEH/fgb7wGbYyYFl1F5qs5ApHVcFp5OiSZJJ+WTapwl0bh
        tAm9Qhvwa6rcr
X-Received: by 2002:a17:906:f8c5:: with SMTP id lh5mr3457290ejb.294.1613646032883;
        Thu, 18 Feb 2021 03:00:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycz01GTcue7TtaljG4q00iJbq9gaP3pdGP/0eZ1TZipqblG79I7PuDralQesyYQcWUWgI0Cg==
X-Received: by 2002:a17:906:f8c5:: with SMTP id lh5mr3457276ejb.294.1613646032719;
        Thu, 18 Feb 2021 03:00:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q14sm2490218edw.52.2021.02.18.03.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 03:00:32 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0C46C1805FA; Thu, 18 Feb 2021 12:00:32 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "Brian G. Merrell" <brian.g.merrell@gmail.com>
Cc:     xdp-newbies@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Subject: Re: How to orchestrate multiple XDP programs
In-Reply-To: <20210218101634.qn4lq2zvdwafpyvv@snout.localdomain>
References: <20201201091203.ouqtpdmvvl2m2pga@snout.localdomain>
 <878sah3f0n.fsf@toke.dk>
 <20201216072920.hh42kxb5voom4aau@snout.localdomain>
 <873605din6.fsf@toke.dk> <87tur0x874.fsf@toke.dk>
 <20210210222710.7xl56xffdohvsko4@snout.localdomain>
 <874kiirgx3.fsf@toke.dk>
 <20210218101634.qn4lq2zvdwafpyvv@snout.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 18 Feb 2021 12:00:31 +0100
Message-ID: <87v9apljxs.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Brian G. Merrell" <brian.g.merrell@gmail.com> writes:

> On 21/02/11 12:18PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> "Brian G. Merrell" <brian.g.merrell@gmail.com> writes:
>>=20
>> > On 21/01/29 01:02PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> Hi Brian
>> >>=20
>> >> I've posted a first draft of this protocol description here:
>> >> https://github.com/xdp-project/xdp-tools/blob/master/lib/libxdp/proto=
col.org
>> >>=20
>> >> Please take a look and let me know what you think. And do feel free to
>> >> point out any places that are unclear, as I said this is a first draf=
t,
>> >> and I'm expecting it to evolve as I get feedback from you and others =
:)
>> >>=20
>> >> -Toke
>> >>=20
>> >
>> > Thanks so much for doing this Toke. There's a lot of great information.
>> > I did one read-through, and didn't notice any surprises compared to the
>> > code that I've read so far.
>>=20
>> Awesome! :)
>
> A question for anyone (sorry if it's a silly one)...
>
> I did a second read-through of the protocol this evening. I wanted to
> take a deeper look at the function calls that are referenced. Some of
> them are BPF syscalls, which should be relatively straightforward to
> interface with from Go. However, some functions like
> bpf_get_link_xdp_info() appear to reside deep in the bowels of libbpf.
> I'd really like to avoid needing cgo bindings, so my question is if
> there some way to 1) interface with these functions that I'm just not
> seeing, or 2) achieve what's necessary for implementing libxdp by only
> utilizing syscalls.

bpf_get_link_xdp_info() is a wrapper around the kernel rt_netlink
interface. It issues an RTM_GETLINK with flags NLM_F_DUMP |
NLM_F_REQUEST and parses the IFLA_XDP attribute on the return value to
extract the program ID of the currently attached XDP program. I'm pretty
sure you can find an existing netlink library for Go, so this should be
pretty straight-forward to implement.

But point well taken that a document such as the protocol doc should
refer to the kernel interface and not the libbpf internals - I'll fix
that :)

-Toke

