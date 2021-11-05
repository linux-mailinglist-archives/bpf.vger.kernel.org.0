Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC8446502
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 15:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhKEOg5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 10:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233105AbhKEOg5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 10:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636122857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXcjTf98RBg39p7qE5KWevwR1yUeicHmGqCbX9E43a4=;
        b=clMzb1CRo8iLkuajtVxhqt44zXGtcK4JQijplCdQZhyBP5sTq9OPHUaFj1eYskdOLaKn8l
        bcs1oo1JjRm6dw7r/Zwg4oV0WQCjOdNZdOzNDIOe/Wis51wRyx0hX+3xIzo0+AJsR6fd6L
        AumjEkoy7u9Lg6uU7yozfczfm66kk8Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-5DB86zPwMdSHmiGCA8P57A-1; Fri, 05 Nov 2021 10:34:16 -0400
X-MC-Unique: 5DB86zPwMdSHmiGCA8P57A-1
Received: by mail-ed1-f70.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso9065862edj.13
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 07:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jXcjTf98RBg39p7qE5KWevwR1yUeicHmGqCbX9E43a4=;
        b=SR4phhQzmsf+9fuyh5OYOSfKTvs5xybdfj4EIRyT2o3WiO5l/pw6tBHINxBw4qXAF/
         3887MppMG2sUipuwT8NmvVOSCdjO4QwiFVnJTEzbob2Xo0qosSKEzQbEsdGj1c2tWpDa
         Vrl5+ICy91CJiAr0iyQ/fSMRSG6qdGNKTtnI1Zb3fSYoHZCObXWp6oHNzdppExXpEOzt
         A3fEQvFmwzsMRCYEbB/pF9KhjwotYO7TCsYotLk7HjRavQz2R0d5VBm9KsJtvBOMb1RC
         cXMrCgUJqPsQpi/asmMkq18llB9noOSkn+zqQ3z6ktkRpxPm4rsiGuk2I3jdo/To3cWh
         cGxQ==
X-Gm-Message-State: AOAM533UlXbZWBbO+ILEiiowu0QOVROkEGOzKwZfjCZDRzEB7Ni5dO5p
        kfhGQrcaTJIIEcjb4z6y8Jx9c6qd6dU+PP1D7t18+lu7hRlC2xmcPOuTZNcUP1Dl6ToYEL51NMq
        TtjEFRrVS4kgt
X-Received: by 2002:a05:6402:354c:: with SMTP id f12mr36821400edd.108.1636122854686;
        Fri, 05 Nov 2021 07:34:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL923YcZsRbLzCuKVlPXnT9Wbnkrp+pxMuQhXvlvpVKdOFJ9dGTvXYMq05nJL/w7/mzMrsbw==
X-Received: by 2002:a05:6402:354c:: with SMTP id f12mr36821347edd.108.1636122854231;
        Fri, 05 Nov 2021 07:34:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g1sm2978807eje.105.2021.11.05.07.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:34:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0FCD018026D; Fri,  5 Nov 2021 15:34:13 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Ciara Loftus <ciara.loftus@intel.com>
Subject: Re: [PATCH bpf-next] libbpf: demote log message about unrecognised
 data sections back down to debug
In-Reply-To: <CAEf4BzYGjV5DQB7tqRkSKz6pz-3QtU7uSWQVNJMW4eSjnpF98A@mail.gmail.com>
References: <20211104122911.779034-1-toke@redhat.com>
 <CAEf4BzYGjV5DQB7tqRkSKz6pz-3QtU7uSWQVNJMW4eSjnpF98A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 05 Nov 2021 15:34:13 +0100
Message-ID: <87a6iismca.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Nov 4, 2021 at 5:29 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> When loading a BPF object, libbpf will output a log message when it
>> encounters an unrecognised data section. Since commit
>> 50e09460d9f8 ("libbpf: Skip well-known ELF sections when iterating ELF")
>> they are printed at "info" level so they will show up on the console by
>> default.
>>
>> The rationale in the commit cited above is to "increase visibility" of s=
uch
>> errors, but there can be legitimate, and completely harmless, uses of ex=
tra
>> data sections. In particular, libxdp uses custom data sections to store
>
> What if we make those extra sections to be ".rodata.something" and
> ".data.something", but without ALLOC flag in ELF, so that libbpf won't
> create maps for them. Libbpf also will check that program code never
> references anything from those sections.
>
> The worry I have about allowing arbitrary sections is that if in the
> future we want to add other special sections, then we might run into a
> conflict with some applications. So having some enforced naming
> convention would help prevent this. WDYT?

Hmm, I see your point, but as the libxdp example shows, this has not
really been "disallowed" before. I.e., having these arbitrary sections
has worked just fine.

How about we do the opposite: claim a namespace for future libbpf
extensions and disallow (as in, hard fail) if anything unrecognised is
in those sections? For instance, this could be any section names
starting with .BPF?

-Toke

