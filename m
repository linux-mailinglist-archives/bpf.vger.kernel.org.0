Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075F4417BDC
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 21:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbhIXTjr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 15:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231756AbhIXTjq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Sep 2021 15:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632512292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKlIbx9VujkrEQw+yD79vCQNibEe3Cguf1xMuXO7LBA=;
        b=e+aAZvThJinbdeRS259LNsXo0AulDLN49nMTU3sWflBvd3aM+DhCts3HumlmehgWimviO0
        sAg8sQJIv7YxfhzE2PfJdUcBMsGz+oNzL7RC7gWHTBpRHSXxBOJH6DZtV5ONOdP/SASMi2
        Ni6u/eGH9Uhn4euH4JJaojFxD4ZjQI8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-uyGhGY7FP5Od8jSUYRbEkQ-1; Fri, 24 Sep 2021 15:38:10 -0400
X-MC-Unique: uyGhGY7FP5Od8jSUYRbEkQ-1
Received: by mail-ed1-f69.google.com with SMTP id h24-20020a50cdd8000000b003d8005fe2f8so11394888edj.6
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 12:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=zKlIbx9VujkrEQw+yD79vCQNibEe3Cguf1xMuXO7LBA=;
        b=MeXS1F4IMIt2c+L6mmGV0bEaMDoWCtjfPzwr0GQD1ID8p9ZDLjZEFQ+d9WEowP13dO
         FPekv58Sm7EEKGI0lujQ3frUdANeyML7sPy0Kni3wNAzHospfA4bNg1bYtAqDOuJuO+S
         O5pSBlCKnf8qYg+Uhk3G6qpF+bVdYDBhugn08+GdAUf/VW8Z2eac76CCWz1QOU8vuMKy
         AfUWy8ArfTHL2/AW3WtDNzDYkueJ+nZu1kprvYKd68/bjZBxyP6A6JIxejd0FT4ceTXN
         04OMomHlMSxNsgoB5naDj4c8Hi2eH54kPBZOT5rFTv6rO2oEEUcWlo8OqcIy16VFvCu9
         1M3w==
X-Gm-Message-State: AOAM530GO+USqO8nULj19dvxMfPUfpFKax30dsKrmsQgh1+JAxof99ts
        k1vYapeEQ8jPv0VEy++LjiTyFOWj+uP0x3cO1VyqaXHTQbJJSHPs7ttvDBZR1ODhuAYRzcBxTZ8
        gAcJmWia9b/IH
X-Received: by 2002:a50:cfc1:: with SMTP id i1mr6948391edk.251.1632512288686;
        Fri, 24 Sep 2021 12:38:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+XTJjpKCOlqLWm+xRwhpthEFRJV4BaMLMrPzkVns7mpTH7g1/5UjKMLMQ9ihHbVRmoPABZg==
X-Received: by 2002:a50:cfc1:: with SMTP id i1mr6948285edk.251.1632512287255;
        Fri, 24 Sep 2021 12:38:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ck10sm6336943edb.43.2021.09.24.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 12:38:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 11EEE18034A; Fri, 24 Sep 2021 21:38:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Lorenzo Bianconi <lbianconi@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: Redux: Backwards compatibility for XDP multi-buff
In-Reply-To: <CACAyw9_N2Jh651hXL=P=cFM7O-n7Z0NXWy_D9j0ztVpEm+OgNA@mail.gmail.com>
References: <87o88l3oc4.fsf@toke.dk>
 <CACAyw99+KvsJGeqNE09VWHrZk9wKbQTg3h1h2LRmJADD5En2nQ@mail.gmail.com>
 <87tuibzbv2.fsf@toke.dk>
 <CACAyw9_N2Jh651hXL=P=cFM7O-n7Z0NXWy_D9j0ztVpEm+OgNA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Sep 2021 21:38:05 +0200
Message-ID: <87tui9ydb6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenz Bauer <lmb@cloudflare.com> writes:

> On Thu, 23 Sept 2021 at 13:59, Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> I don't think it has to be quite that bleak :)
>>
>> Specifically, there is no reason to block mb-aware programs from loading
>> even when the multi-buffer mode is disabled. So a migration plan would
>> look something like:
>
> ...
>
>> 2. Start porting all your XDP programs to make them mb-aware, and switch
>>    their program type as you do. In many cases this is just a matter of
>>    checking that the programs don't care about packet length. [...]
>
> Porting is only easy if we are guaranteed that the first PAGE_SIZE
> bytes (or whatever the current limit is) are available via ->data
> without trickery. Otherwise we have to convert all direct packet
> access to the new API, whatever that ends up being. It seemed to me
> like you were saying there is no such guarantee, and it could be
> driver dependent, which is the worst possible outcome imo. This is the
> status quo for TC classifiers, which is a great source of hard to
> diagnose bugs.

Well, for the changes we're proposing now it will certainly be the case
that the first PAGE_SIZE will always be present. But once we have the
capability, I would expect people would want to do more with it, so we
can't really guarantee this in the future. We could require that any
other use be opt-in at the driver level, I suppose, but not sure if that
would be enough?

-Toke

