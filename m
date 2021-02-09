Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54888314DDA
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 12:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhBILHF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 06:07:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232249AbhBILFB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 06:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612868609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lorKAyny8qo8X8PLzFQXMUrLbtZ72KNyEjJSwWTk6UE=;
        b=cB2YE0UOMf7OLNV6cVa2I3noEIM95KP6gLOtWjXLJmP/1aMUZUlW5nsgCCOpbGFvkbwrW+
        xWvn/3qUf2bx2uM3PH9dFfkMvOHW5c/Q3NEh7GdfLN57NBZ/6Sg539fRDVht1qijmslHAz
        PLkljruryEJsBdz/mpjz1zi1Nxpcp40=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-yP4e0xfQM06vXOkjK4XI4A-1; Tue, 09 Feb 2021 06:03:27 -0500
X-MC-Unique: yP4e0xfQM06vXOkjK4XI4A-1
Received: by mail-ed1-f72.google.com with SMTP id l23so14555538edt.23
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 03:03:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lorKAyny8qo8X8PLzFQXMUrLbtZ72KNyEjJSwWTk6UE=;
        b=DhbRIDVOsRBb+vrxJJo2IVDT7NVvnwPd9swDH7lAMC8E8b94qfFWKo452EHuXew2gv
         CcpG3FujR11unq1SMLHYkFXC20Pid1v99JwST7PVrWmpA2k+0eEso0bHNYSr5jSMn0mf
         5haTLJN8K9572CxGJy6F3vxOrLI6Z2qk8r2ErO68DfFVrY72WXu9mutIYVk4Mqy4n5Cb
         D2ZV0jm4mYI7XhsktgiJJ2LwbZenluixY8vmyJGehxPPtHmr6rSaL5UR1JWgozEFW4F0
         fX/wNTx6lCvzUO/Cz58fmCoW+QknAYGcnuwcAUISpAVtKMBhPkilXJohKr4KOwxl/IM8
         o17A==
X-Gm-Message-State: AOAM531PBeEWauhD9R8TX+eSiiDgoUFc0JeNsDs6sGwwmupjwVq4/5Qe
        BzqG9OvLTTHT9C7EvB4ai1r6+DHFexupf6El5qmMBU/JK4zkeXBqqUw8BPc80Md3wOCcqB7Jf1n
        VVSQ5nI+Sg6/h
X-Received: by 2002:a17:906:d189:: with SMTP id c9mr22164033ejz.36.1612868606243;
        Tue, 09 Feb 2021 03:03:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVaCW15/oqimd+9o17tkTN+kbxltL7e4b6CkLV/SSP1sb14KXVT+d/0/sIea3FwAFl9AxJmQ==
X-Received: by 2002:a17:906:d189:: with SMTP id c9mr22164021ejz.36.1612868606071;
        Tue, 09 Feb 2021 03:03:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a15sm11427727edy.86.2021.02.09.03.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 03:03:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 15ADA1804EE; Tue,  9 Feb 2021 12:03:25 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: libbpf: pinning multiple progs from the same section
In-Reply-To: <CANaYP3G+rtJuMAaTvdxSZCEtA9tSqh00OCkJ0LoeL7L030w0VQ@mail.gmail.com>
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
 <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
 <87v9b2u6pa.fsf@toke.dk>
 <CANaYP3GxKrjuUUTGaAjYGqwPCNzPJBNPQGMMCNaoHT4rfsYUfA@mail.gmail.com>
 <87mtwetz04.fsf@toke.dk>
 <CANaYP3G4sBrBy3Xsrku4LjW4sFhAb-9HreZUo_aBNe6gCab1Eg@mail.gmail.com>
 <87blcutx3v.fsf@toke.dk>
 <CANaYP3FEheoxSp86sFair0CAQz1-fkdmGp0_zvgGqQr_3P+qdg@mail.gmail.com>
 <875z32tpel.fsf@toke.dk>
 <CANaYP3EUOLf=8+ZuKFr4ozPueqgjvzxkEK+O8WEamwY01yATaA@mail.gmail.com>
 <87zh0es73x.fsf@toke.dk>
 <CANaYP3G+rtJuMAaTvdxSZCEtA9tSqh00OCkJ0LoeL7L030w0VQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 09 Feb 2021 12:03:25 +0100
Message-ID: <87tuqlsdtu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Gilad Reti <gilad.reti@gmail.com> writes:

>> > I didn't get this last comment. What I meant is that I want something
>> > like the bpf_object__pin_maps but that doesn't pin the maps, just
>> > exposing its naming part.
>>
>> Right, OK. Why, though? I can kinda see how it could be convenient to
>> (basically )make libbpf behave as if all maps has the 'pinning'
>> attribute set, for map reuse. But I'm not sure I can think any concrete
>> use cases where this would be needed. What's yours?
>>
>
> I am using the same bpf objects (more specifically, the new skeleton
> feature) in two different processes that need access to the same
> maps/programs (for example, they both need access to shared maps).
> Thus, I want to reuse the entire object in both. Since we already have
> a way to pin an entire bpf object, I thought it would be convenient to
> have a way of reusing it entirely (though I am fine with pinning and
> reusing each one manually).
> (I cannot set the __uint(pinning, LIBBPF_PIN_BY_NAME) on each since I
> want to share the bss map too)

Ah, see, now *this* could go under the "missing API" header: having a
way to make libbpf pin (and reuse) the auto-generated maps, like you can
do with the 'pinning' attribute.

Andrii, WDYT?

-Toke

