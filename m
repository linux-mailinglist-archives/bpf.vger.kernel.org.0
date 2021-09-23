Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D454F416595
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 21:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242805AbhIWTCF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 15:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232331AbhIWTCD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Sep 2021 15:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632423631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4N1OpVszDzQL5pSRj0mhEDEcwQtQTGko1jICaLW5DhE=;
        b=NZMrDGT5vSW7H7u6Up8ZNztGesyMhBvbHfC2fn4GO/RQa5ACHNCsKOzD+VuiMVU1Bg9ISl
        qY9D3L/vHYVhLy9BgmKPjW/xz8gwEfBDjrRkk7OJKiRjlJ/9fI+2bCS6EO9TRtV3HFgxPp
        kD7uaRp3BN7sDfIP4EoNHFnez3A3ykk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-ZDbkUh19M5K4t6dtZ3uAhQ-1; Thu, 23 Sep 2021 15:00:28 -0400
X-MC-Unique: ZDbkUh19M5K4t6dtZ3uAhQ-1
Received: by mail-ed1-f70.google.com with SMTP id z6-20020a50cd06000000b003d2c2e38f1fso7689696edi.1
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 12:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4N1OpVszDzQL5pSRj0mhEDEcwQtQTGko1jICaLW5DhE=;
        b=GeWhU6Hh7kv003yiU73jQwv/24cxHtTFQNbRHK07nDFRiWv6YpHTqDcFU37yRoEaMI
         pgqpEaAQjWAh+Zw8PTqierx0njhA/3xi1rfnomGNwCNzKkLgUfBt0bCQNdz3wUFIvdt9
         MCwjAOksoStJ/fxPGNugFdwMb80GHkZETc/o6NAwIjKl4T8PB+2wZ2r0ARdinS+H8TpO
         /VJq96Et0gF90igHI+ObwNEnQF6gLs6jU+dRPfmtNaO+qz90uSPq8uMDzf8R41wiuiFy
         qJYnSEFwDzWD+nAJ6LLJQAmOf0R7iSC7l4ES+k63YSVyG+mmkxgxYruIPb7WTkbJkFeC
         6+TQ==
X-Gm-Message-State: AOAM533CA6MqSQ6nm33h3244lbVzPzETNukf2naPYVGtsB/uO4PbKU/I
        p5b4YUk4p6b5yzFrwSMrRE0IJWuMC+yJ6tDaDtqXtj4lsZMWb4YbZ7JFMhIhNXcvq5PDlko8X1X
        9GXUYxWzmOgkR
X-Received: by 2002:a17:907:7703:: with SMTP id kw3mr6813707ejc.34.1632423624778;
        Thu, 23 Sep 2021 12:00:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJze7OvSGXBiNuBxyXXx8R9XStQQwqgi2185GS2FMCL6hPut1aH6DX2utyCbVjBk5sVfGD7w6g==
X-Received: by 2002:a17:907:7703:: with SMTP id kw3mr6813549ejc.34.1632423622891;
        Thu, 23 Sep 2021 12:00:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q12sm3533422ejs.58.2021.09.23.12.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 12:00:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 89BA1180274; Thu, 23 Sep 2021 21:00:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Zvi Effron <zeffron@riotgames.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Lorenzo Bianconi <lbianconi@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: Redux: Backwards compatibility for XDP multi-buff
In-Reply-To: <CAC1LvL11QfiuLq3YGLsJn2meLuo5jXivFf2v-y10-ax7p7sjXQ@mail.gmail.com>
References: <87o88l3oc4.fsf@toke.dk>
 <20210921155443.507a8479@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87k0j81iq5.fsf@toke.dk>
 <CAC1LvL11QfiuLq3YGLsJn2meLuo5jXivFf2v-y10-ax7p7sjXQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 23 Sep 2021 21:00:20 +0200
Message-ID: <878rznyv5n.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Zvi Effron <zeffron@riotgames.com> writes:

> On Wed, Sep 22, 2021 at 1:03 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Jakub Kicinski <kuba@kernel.org> writes:
>>
>> > On Tue, 21 Sep 2021 18:06:35 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>> >> 1. Do nothing. This would make it up to users / sysadmins to avoid
>> >> anything breaking by manually making sure to not enable multi-buffer
>> >> support while loading any XDP programs that will malfunction if
>> >> presented with an mb frame. This will probably break in interesting
>> >> ways, but it's nice and simple from an implementation PoV. With this
>> >> we don't need the declaration discussed above either.
>> >>
>> >> 2. Add a check at runtime and drop the frames if they are mb-enabled =
and
>> >> the program doesn't understand it. This is relatively simple to
>> >> implement, but it also makes for difficult-to-understand issues (why
>> >> are my packets suddenly being dropped?), and it will incur runtime
>> >> overhead.
>> >>
>> >> 3. Reject loading of programs that are not MB-aware when running in an
>> >> MB-enabled mode. This would make things break in more obvious ways,
>> >> and still allow a userspace loader to declare a program "MB-aware" to
>> >> force it to run if necessary. The problem then becomes at what level
>> >> to block this?
>> >>
>> >> Doing this at the driver level is not enough: while a particular
>> >> driver knows if it's running in multi-buff mode, we can't know for
>> >> sure if a particular XDP program is multi-buff aware at attach time:
>> >> it could be tail-calling other programs, or redirecting packets to
>> >> another interface where it will be processed by a non-MB aware
>> >> program.
>> >>
>> >> So another option is to make it a global toggle: e.g., create a new
>> >> sysctl to enable multi-buffer. If this is set, reject loading any XDP
>> >> program that doesn't support multi-buffer mode, and if it's unset,
>> >> disable multi-buffer mode in all drivers. This will make it explicit
>> >> when the multi-buffer mode is used, and prevent any accidental subtle
>> >> malfunction of existing XDP programs. The drawback is that it's a
>> >> mode switch, so more configuration complexity.
>> >
>> > 4. Add new program type, XDP_MB. Do not allow mixing of XDP vs XDP_MB
>> > thru tail calls.
>> >
>> > IMHO that's very simple and covers majority of use cases.
>>
>> Using the program type (or maybe the expected_attach_type) was how I was
>> imagining we'd encode the "I am MB aware" flag, yes. I hadn't actually
>> considered that this could be used to also restrict tail call/freplace
>> attachment, but that's a good point. So this leaves just the redirect
>> issue, then, see my other reply.
>>
>
> I really like this apporoach as well, but before we commit to it, how lik=
ely
> are we to encounter this type of situation (where we need to indicate whe=
ther
> an XDP program supports a new capability) again in the future. And if we =
do,
> are we willing to require that all programs supporting that new feature a=
re
> also mb-aware? Essentially, the suboptimal case I'm envisioning is needin=
g to
> have XDP_MB, XD_MB_NEW_THING, XDP_NEW_THING, and XDP all as program types=
. That
> leads to exponential explosion in program types.

Hmm, that's a good point. Maybe it would be better to communicate it via
a flag; we do have a prog_flags attribute on BPF_PROG_LOAD we could use.

> Also, every time we add a program type to encode a feature (instead of a =
truly
> new type), we're essentially forcing a recompilation (and redeployment) o=
f all
> existing programs that take advantage of the libbpf section name program
> typing. (I'm sure there are tools that can rename a section in an ELF file
> without recompilation, but recompilation seems the simplest way to correc=
t the
> ELF files for most people.)

Isn't this true regardless of how we encode it? I mean when we add a new
feature that needs an explicit support declaration, programs need to
declare that they support it somehow. No matter how it's actually
encoded, this will either entail recompiling the program, or having the
loader override the value at load-time.

For instance, say we do use a flag instead of a new prog type, how would
a BPF program set that flag? Defining a new section type in libbpf would
be an obvious answer (i.e., SEC("xdp") sets prog_type=3Dxdp, and
SEC("xdp_mb") sets prog_type=3Dxdp, flags=3DXDP_MB).

> If we think this is a one-off, it's probably fine, but if we think
> it'll happen again, is it worth it to find a solution that will work
> for future cases now, instead of having XDP, XDP_MB, and then having
> to find a solution for future cases?

Well, really the right solution is a general "XDP feature flags"
capability. There was some work done on this, but unfortunately it
stalled out. Not sure it's feasible to resurrect that as a prerequisite
for landing xdp_mb, though, so I guess we'll need a one-off thing here :/

-Toke

