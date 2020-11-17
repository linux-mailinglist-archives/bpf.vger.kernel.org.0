Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FDC2B6D8E
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 19:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgKQSi5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 13:38:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729918AbgKQSi5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Nov 2020 13:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605638329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m5E0/SseXfuXN9mnbZhJFdsMHAx3WO5//ot42+LxJLs=;
        b=XQgkQOTVax/7b7JuQg3sVoVCa9d4w9cMsPXin745SCz/NbyOwQJgTLPQkG3mXPom2GfRTX
        TTFfgH49BlN4v9o5UGDUFgzg0TjniHPhvkB+z5O4uxNGnt+fyauWwuAOvivrxhP9l3m3kw
        lKhot8iqD0NwNtDcznMXm96O6P3jWtw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-GRQ9stLMPS282IAERIlsFw-1; Tue, 17 Nov 2020 13:38:47 -0500
X-MC-Unique: GRQ9stLMPS282IAERIlsFw-1
Received: by mail-oi1-f200.google.com with SMTP id k200so10362716oih.23
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 10:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=m5E0/SseXfuXN9mnbZhJFdsMHAx3WO5//ot42+LxJLs=;
        b=q4tDzmMl+6Cw9a1K2H1fv1tlb/DPZS8qRZGsiJgMv51pZ9plHlowr2LmsuuM4c+uSK
         j1lVTXmuLdQ1E9+l60s7CkBRGDOVTsU33uXk//xreGYZf0wJ7JyCroyjfjP5ULSKbcYJ
         I19KlHyILBzMDK5gqsgr4SJrqd0m6LRLMKaoVryfhvQOtdW5NHMT4CzrTxfxquJkFVfu
         dQY3TTT4Brb3Pn1yB6gZLUiXsX/ae+DeB4rXa09oRiKaWQ0jqFcSIAeWAZi/N6McjF53
         cUHlq5xXNIOkZ4HIEbGl23RHnoG6e/Fd/LyfzepE+6UecWusfmvzvileMU6rrupm7dx1
         TeGQ==
X-Gm-Message-State: AOAM533+5LsEwJ0jsbgQMIrK8yNgd+CKlVzilh/RAyM33K14ECE1pmmv
        BmncwMhCyo3s2PjNqOowY7mTML6TxTBjo+sQvh/AzxGIiH+BFOP7DCoPBVjG9803BJU7mf1WEoa
        jNms2K8xMuCxz
X-Received: by 2002:aca:f19:: with SMTP id 25mr295731oip.175.1605638326775;
        Tue, 17 Nov 2020 10:38:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTN9L9PixBfldKyQC4E/ow1F8kWj6YKiiPonLzZQA0YMjXGZ9yHRADwxOubQznzJnHVpA2Bw==
X-Received: by 2002:aca:f19:: with SMTP id 25mr295698oip.175.1605638326197;
        Tue, 17 Nov 2020 10:38:46 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q24sm6239836otm.22.2020.11.17.10.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 10:38:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 52A7E1833E0; Tue, 17 Nov 2020 19:38:43 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Marek Majtyka <alardam@gmail.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        =?utf-8?B?QmrDtnJuIFQ=?= =?utf-8?B?w7ZwZWw=?= 
        <bjorn.topel@intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>, hawk@kernel.org,
        Maciej Fijalkowski <maciejromanfijalkowski@gmail.com>,
        Marek Majtyka <marekx.majtyka@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH 0/8] New netdev feature flags for XDP
In-Reply-To: <CAAOQfrGzfKf-vpaitfC_KLDnWDo_uJFDF_PE5X9RH_G4Yt8QHA@mail.gmail.com>
References: <20201116093452.7541-1-marekx.majtyka@intel.com>
 <875z655t80.fsf@toke.dk>
 <CAJ8uoz1C7-a7A0WJqThomSxYwmdkfLpDyC5YnB8g_J+p486RXQ@mail.gmail.com>
 <CAAOQfrGzfKf-vpaitfC_KLDnWDo_uJFDF_PE5X9RH_G4Yt8QHA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 17 Nov 2020 19:38:43 +0100
Message-ID: <87wnyj25ho.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Marek Majtyka <alardam@gmail.com> writes:

> On Tue, Nov 17, 2020 at 8:37 AM Magnus Karlsson
> <magnus.karlsson@gmail.com> wrote:
>
> Thank you for your quick answers and comments.
>
>>
>> On Mon, Nov 16, 2020 at 2:25 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>> >
>> > alardam@gmail.com writes:
>> >
>> > > From: Marek Majtyka <marekx.majtyka@intel.com>
>> > >
>> > > Implement support for checking if a netdev has native XDP and AF_XDP=
 zero
>> > > copy support. Previously, there was no way to do this other than to =
try
>> > > to create an AF_XDP socket on the interface or load an XDP program a=
nd
>> > > see if it worked. This commit changes this by extending existing
>> > > netdev_features in the following way:
>> > >  * xdp        - full XDP support (XDP_{TX, PASS, DROP, ABORT, REDIRE=
CT})
>> > >  * af-xdp-zc  - AF_XDP zero copy support
>> > > NICs supporting these features are updated by turning the correspond=
ing
>> > > netdev feature flags on.
>> >
>> > Thank you for working on this! The lack of a way to discover whether an
>> > interface supports XDP is really annoying.
>> >
>> > However, I don't think just having two separate netdev feature flags f=
or
>> > XDP and AF_XDP is going to cut it. Whatever mechanism we end up will
>> > need to be able to express at least the following, in addition to your
>> > two flags:
>> >
>> > - Which return codes does it support (with DROP/PASS, TX and REDIRECT =
as
>> >   separate options)?
>> > - Does this interface be used as a target for XDP_REDIRECT
>> >   (supported/supported but not enabled)?
>> > - Does the interface support offloaded XDP?
>>
>> If we want feature discovery on this level, which seems to be a good
>> idea and goal to have, then it is a dead end to bunch all XDP features
>> into one. But fortunately, this can easily be addressed.
>
> Do you think that is it still considerable to have a single netdev
> flag that means "some" XDP feature support which would activate new
> further functionalities?

Why bother? The presence of any XDP-specific feature bits would imply
the support for XDP :)

>> > That's already five or six more flags, and we can't rule out that we'll
>> > need more; so I'm not sure if just defining feature bits for all of th=
em
>> > is a good idea.
>>
>> I think this is an important question. Is extending the netdev
>> features flags the right way to go? If not, is there some other
>> interface in the kernel that could be used/extended for this? If none
>> of these are possible, then we (unfortunately) need a new interface
>> and in that case, what should it look like?
>
> Toke, are you thinking about any particular existing interface or a
> new specific one?

I have mostly been thinking about the internal kernel interface. The
simple thing would just be to define a whole new bitmap of XDP-specific
feature bits that the rest of the kernel can consume. That would also
mean we don't have to do pointer chasing to see if the ndos are
implemented, which Jesper pointed out the other day actually shows up on
his profiling traces.

The downside to having them be feature flags is that they can get out of
sync, of course. But if we block the support from working unless the
right flags are set, that should at least make driver developers pay
attention. Although we'd have to change all the drivers in one go, but I
suppose that's not too onerous seeing as you just did that for this
series :)

So what that boils down to is basically what you're doing in this
series, but more fine grained, via a new netdev->xdp_features instead of
burning bits in netdev->features.

As for UAPI, i dunno? Ethtool is netlink now, right? So it should be
fairly easy to just extend with a new attribute for XDP?

I believe there was originally some resistance to explicitly exposing
XDP capabilities to userspace because we wanted all drivers to implement
all features. Clearly that has not panned out, though, so as far as I'm
concerned we can just expose it and be done with it :) But I'll let
others weigh in here; the original discussions predate my involvement.

-Toke

