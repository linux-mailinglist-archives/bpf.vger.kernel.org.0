Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB18C313534
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 15:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBHObG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 09:31:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231359AbhBHOaB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Feb 2021 09:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612794515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pf62NUg5UvMmmKH6/PEIFBen8GZAfIgYKu/i8yxyElw=;
        b=NbB8e+DEkwUifmhUeHt9RNCfqKcWEMEB/qYDShhtqX21j0tV8nlp/pyJ6QuI7NVvmOJSjz
        UF6JKkqsRrLzH1RejCjG/v+7TLhzfodhYRC0SC/NBomJqa8hbntMVrK7V8N0j6wMpfN3u8
        IUMTmIlE04/jaSOnBPWDuW2wQYvtdXw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-Fvfzd44lOQSSdtnllfL5qg-1; Mon, 08 Feb 2021 09:28:30 -0500
X-MC-Unique: Fvfzd44lOQSSdtnllfL5qg-1
Received: by mail-ed1-f70.google.com with SMTP id ay16so13412658edb.2
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 06:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Pf62NUg5UvMmmKH6/PEIFBen8GZAfIgYKu/i8yxyElw=;
        b=DN9iTw8UDUYr13H3dlNnAjgMxcH8/wLBWCZX5IcVzM9BQn+rVbsYWYiuXW0kjXM25M
         TYgd9OANnJBjgMcl3jXXy2ybxtuWW2bsP5eeiVIC2qGfrqMRiGjxw0UmVUJqUwDa9Je1
         kEPUlPny+F/L7iwfIwxlS7WC2zAORSzI6t1l6g8NNT/g9tOP8WM5P7DShBcFbPPrfZ/O
         l/OdhLdrZWy3ZFBoSM5TNDoqxz0ScuEBIatc+zIxDyykcquYDtUPk00lYUGhVulyJVCv
         Yo5K4QVey8wykf+muSvxEEziDX2J4iE7mMwe/vjH23u9FOQ75XfRzRmIsuI5EhVibEE2
         UICg==
X-Gm-Message-State: AOAM532+HWOj1bideKx/F1c3YH5lrHVSOu1DLIDAsJ+wtvhl4VeWTkSN
        fYMUgcCfpDqnAlRznCoBwQ7c9PWDYzQNFHIDrI2BgBubhfFMeL2Sw0RIKmvhmePYA16Y+rDa+1R
        o4y+oM7TNSzDz
X-Received: by 2002:a17:906:dff1:: with SMTP id lc17mr16586727ejc.198.1612794509079;
        Mon, 08 Feb 2021 06:28:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxu3yT8GjiQ9qaNk4TRy9lN4cBtspeccvfdk13+KYHRfsZTJ9zQ4Lrozq3hedbEmF/RgNC40g==
X-Received: by 2002:a17:906:dff1:: with SMTP id lc17mr16586710ejc.198.1612794508845;
        Mon, 08 Feb 2021 06:28:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p15sm8686076eja.61.2021.02.08.06.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 06:28:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BF6E41804EE; Mon,  8 Feb 2021 15:28:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: libbpf: pinning multiple progs from the same section
In-Reply-To: <CANaYP3GxKrjuUUTGaAjYGqwPCNzPJBNPQGMMCNaoHT4rfsYUfA@mail.gmail.com>
References: <CANaYP3G4zZu=d2Y_d+=418f6X9+5b-JFhk0h9VZoQmFFLhu3Ag@mail.gmail.com>
 <CANaYP3GgBDPBUjrkg0j-NOEzf3WJEOqcqoGU0uVxQ3LsAzz8ow@mail.gmail.com>
 <87v9b2u6pa.fsf@toke.dk>
 <CANaYP3GxKrjuUUTGaAjYGqwPCNzPJBNPQGMMCNaoHT4rfsYUfA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 08 Feb 2021 15:28:27 +0100
Message-ID: <87mtwetz04.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Gilad Reti <gilad.reti@gmail.com> writes:

> On Mon, Feb 8, 2021 at 1:42 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Gilad Reti <gilad.reti@gmail.com> writes:
>>
>> > Also, is there a way to set the pin path to all maps/programs at once?
>> > For example, bpf_object__pin_maps pins all maps at a specific path,
>> > but as far as I was able to find there is no similar function to set
>> > the pin path for all maps only (without pinning) so that at loading
>> > time libbpf will try to reuse all maps. The only way to achieve a
>> > complete reuse of all maps that I could find is to "reverse engineer"
>> > libbpf's pin path generation algorithm (i.e. <path>/<map_name>) and
>> > set the pin path on each map before load.
>>
>> You can set the 'pinning' attribute in the map definition - add
>> '__uint(pinning, LIBBPF_PIN_BY_NAME);' to the map struct. By default
>> this will pin beneath /sys/fs/bpf, but you can customise that by setting
>> the pin_root_path attribute in bpf_object_open_opts.
>
> Yes, I am familiar with that feature, but it has some downsides:
> 1. I need to set it manually on every map (and in cases that I have
> only the compiled object file that would be hard).
> 2. It only works for bpf maps and not bpf programs.
> 3. It only works for bpf maps that are defined explicitly in the bpf
> code and not for implicit (inner) bpf maps (bss, rodata, etc).

Ah, right. Well, other than that I don't think there's a way to set pin
paths in bulk, other than by manually iterating and setting them one at
a time. But, erm, can't you just do that? :)

-Toke

