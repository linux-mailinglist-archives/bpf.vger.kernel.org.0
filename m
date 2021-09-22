Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1274150ED
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 22:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhIVUEd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 16:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237277AbhIVUEc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Sep 2021 16:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632340982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0mZrXwtVoTqrEGwO19onMcwK6RNG+1i3idZF3EfBrNg=;
        b=UcG+Sr8ytL4AuKxbTncXRn2ugzqZBu2bOIUY4E7REyUUG1NWnvi6YyniX3zNNNg2CbNUYM
        RMaMA0XxxlgDIZHqiGQNtehZyi/sSyqwegyglm6zjj8OZgu790ICis6RLMmxS6HYBRanpx
        UBKq/r0GaovrvDTop6nN6IYF0GQ5tgU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-vj2iP_bZOxONhGNzDxM3VA-1; Wed, 22 Sep 2021 16:03:00 -0400
X-MC-Unique: vj2iP_bZOxONhGNzDxM3VA-1
Received: by mail-ed1-f72.google.com with SMTP id n5-20020a05640206c500b003cf53f7cef2so4388094edy.12
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 13:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0mZrXwtVoTqrEGwO19onMcwK6RNG+1i3idZF3EfBrNg=;
        b=Z7XTTHwYa/ex8DFFFUBFGhA5dm7HwcOgrH1rEhssB9Ylqg+U7pxf0cAz5/ASldhTYb
         ZeuP/qRrZDzAGulA6E1/ks0ReFGteM1Er7AIbbI4pG7sb+g7KM6G1fGRnHamoL2gwdIF
         1EEyvg+lH8Bz/xhclyPHBK42rm+9kL1dKbZRWb3IjBmtvIYG+qcYDGBtnwBsnAjPaGlk
         +2TA70L5IqPj0P99nXfX1/2oO/x0I4mRyRuT6fdmHULYJQynSKCCP8gX6oHgX6npQS4p
         Zf/IXyMxqqpiijDj+HegUpTFVkMvcRd7MRXywfk+GTt+ApyUgc143ApodLWV5A6cYR9J
         Jp3g==
X-Gm-Message-State: AOAM5315s+K7zG4bW0OhSEZsg5u9prLTEWkkvsPH7C0iavCvD/jeVKHN
        zC8WP2pGYtYQpNFIVa6D6ZPIF8pG+WPgjl9UXAG1A+BcWgXHy5+VIaDryGDxmqLzTW4atkUiyJ4
        ZsJmUxzTfn/eH
X-Received: by 2002:a17:906:e01:: with SMTP id l1mr1148869eji.456.1632340979674;
        Wed, 22 Sep 2021 13:02:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyksRgd4lny4i/b7PfQvHQsTLK11iJu1K4N4udpsiKsIjrleIZ3C0m/6/2uIOP+wPMWAV45nQ==
X-Received: by 2002:a17:906:e01:: with SMTP id l1mr1148833eji.456.1632340979292;
        Wed, 22 Sep 2021 13:02:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s11sm1709259edy.64.2021.09.22.13.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:02:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4D0C818034A; Wed, 22 Sep 2021 22:02:58 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Lorenzo Bianconi <lbianconi@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: Redux: Backwards compatibility for XDP multi-buff
In-Reply-To: <20210921155443.507a8479@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <87o88l3oc4.fsf@toke.dk>
 <20210921155443.507a8479@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 22 Sep 2021 22:02:58 +0200
Message-ID: <87k0j81iq5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 21 Sep 2021 18:06:35 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> 1. Do nothing. This would make it up to users / sysadmins to avoid
>>    anything breaking by manually making sure to not enable multi-buffer
>>    support while loading any XDP programs that will malfunction if
>>    presented with an mb frame. This will probably break in interesting
>>    ways, but it's nice and simple from an implementation PoV. With this
>>    we don't need the declaration discussed above either.
>>=20
>> 2. Add a check at runtime and drop the frames if they are mb-enabled and
>>    the program doesn't understand it. This is relatively simple to
>>    implement, but it also makes for difficult-to-understand issues (why
>>    are my packets suddenly being dropped?), and it will incur runtime
>>    overhead.
>>=20
>> 3. Reject loading of programs that are not MB-aware when running in an
>>    MB-enabled mode. This would make things break in more obvious ways,
>>    and still allow a userspace loader to declare a program "MB-aware" to
>>    force it to run if necessary. The problem then becomes at what level
>>    to block this?
>>=20
>>    Doing this at the driver level is not enough: while a particular
>>    driver knows if it's running in multi-buff mode, we can't know for
>>    sure if a particular XDP program is multi-buff aware at attach time:
>>    it could be tail-calling other programs, or redirecting packets to
>>    another interface where it will be processed by a non-MB aware
>>    program.
>>=20
>>    So another option is to make it a global toggle: e.g., create a new
>>    sysctl to enable multi-buffer. If this is set, reject loading any XDP
>>    program that doesn't support multi-buffer mode, and if it's unset,
>>    disable multi-buffer mode in all drivers. This will make it explicit
>>    when the multi-buffer mode is used, and prevent any accidental subtle
>>    malfunction of existing XDP programs. The drawback is that it's a
>>    mode switch, so more configuration complexity.
>
> 4. Add new program type, XDP_MB. Do not allow mixing of XDP vs XDP_MB
>    thru tail calls.
>
> IMHO that's very simple and covers majority of use cases.

Using the program type (or maybe the expected_attach_type) was how I was
imagining we'd encode the "I am MB aware" flag, yes. I hadn't actually
considered that this could be used to also restrict tail call/freplace
attachment, but that's a good point. So this leaves just the redirect
issue, then, see my other reply.

-Toke

