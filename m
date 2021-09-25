Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A43A4180C5
	for <lists+bpf@lfdr.de>; Sat, 25 Sep 2021 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhIYJVO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Sep 2021 05:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234271AbhIYJVO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 25 Sep 2021 05:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632561579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z80AgXcXHIwRTFTMl3bI9yZVEqbIK0iNPvS8Ba7Fx9I=;
        b=SGbZOLEgprw2N2NI0mJItejAsCcKW3r6COfpU3fwOhBNaaqFmbd3/v7Oizq1VE9zYqkwvH
        sNLZvXT58ctCjdb/wO39wQ+kDgI6J3bU04MdpaVVarpleczRH4v5/3CDp9bV8v3DhVhi4m
        bZ/TCx7CXCgqWYoICoDrKZ2nmeLNdUM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-mL0cH0BfNgyTt8UqXbofsQ-1; Sat, 25 Sep 2021 05:19:37 -0400
X-MC-Unique: mL0cH0BfNgyTt8UqXbofsQ-1
Received: by mail-ed1-f69.google.com with SMTP id ec14-20020a0564020d4e00b003cf5630c190so12990797edb.3
        for <bpf@vger.kernel.org>; Sat, 25 Sep 2021 02:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Z80AgXcXHIwRTFTMl3bI9yZVEqbIK0iNPvS8Ba7Fx9I=;
        b=AEKBLEhqfD6QKPcYNL83V1cRuOu14OjPu/gE/ZgsZAthDamT6zFes2bRLcTte6BqO3
         BUqOAX5zhgN3eNgiLjIlyh2et4q0ds6YYVZNSFCX4ha+SPn6NVuHvbaBGD1HRwX+7XfM
         8eYNteI+EgxFJyMpRXR3gB5xDoCRfJm/C3HoyZhmgSz18yyG7gO8AROHZ26xTV2klZwU
         a9ZJFKLhzuFS3SXVO+QJrTGYQeskZBDC9KU4KGu+tokfgffjz/JSuHChLVgWnGb0Xm9U
         icOgxH4xRD41aHAn7N9RwRJt9Xf3LajwsdnciV38MvcblvfE9RJ98ilFBrPuwYqqwOhv
         Ww1Q==
X-Gm-Message-State: AOAM5330lNegZxf+m6X68eyPtgVuRLu6eyrr3kzHvIFHU5ZJSgkIdteV
        zXvFW7QRjnWvoFmnuNcC0CrWT0k2RPn9NjyHR/GKUNjamZWt6pnflbgCTRCe52SbrsEMkhc06MP
        0ntr6rHkTfAb4
X-Received: by 2002:a17:906:fc7:: with SMTP id c7mr16490277ejk.333.1632561576455;
        Sat, 25 Sep 2021 02:19:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8RrBb8e4sXT01SLGFFVtC68/eBZ2VekMRq6OF1/pCy0XTOKs48XdJ8UXa+PjEEu1+aP5TBA==
X-Received: by 2002:a17:906:fc7:: with SMTP id c7mr16490257ejk.333.1632561576152;
        Sat, 25 Sep 2021 02:19:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id lv10sm6110839ejb.66.2021.09.25.02.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 02:19:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 927D218034A; Sat, 25 Sep 2021 11:19:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>
Subject: Re: Reason for libbpf rejecting SECTION symbols in 'maps' section
In-Reply-To: <CAEf4BzZ5HXrhhpbZ573Hh2yjwxFf3Gu-WekafYZqCBhVgQ=zRg@mail.gmail.com>
References: <87wnn5yl4p.fsf@toke.dk>
 <CAEf4BzZ5HXrhhpbZ573Hh2yjwxFf3Gu-WekafYZqCBhVgQ=zRg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 25 Sep 2021 11:19:34 +0200
Message-ID: <871r5dko61.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Sep 24, 2021 at 9:49 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Hi Andrii
>>
>> We ran into an issue with binutils[0] mangling BPF object files, which
>> makes libbpf sad. Specifically, binutils will create SECTION symbols for
>> every section in .symtab, which trips this check in
>> bpf_object__init_user_maps():
>>
>> if (GELF_ST_TYPE(sym.st_info) =3D=3D STT_SECTION
>>     || GELF_ST_BIND(sym.st_info) =3D=3D STB_LOCAL) {
>>         pr_warn("map '%s' (legacy): static maps are not supported\n", ma=
p_name);
>>         return -ENOTSUP;
>> }
>>
>> Given the error message I can understand why it's checking for
>> STB_LOCAL, but why is the check for STT_SECTION there? And is there any
>> reason why libbpf couldn't just skip the SECTION symbols instead of
>> bugging out?
>
> Static functions are often referenced through STT_SECTION symbol +
> some offset. I don't remember by now if I encountered cases where
> static variables can be referenced through section symbol + offset, I
> suspect I did, which is why I added this check.
>
> But thinking about this now, we should just ignore the STT_SECTION
> symbol. If Clang really referenced map through STT_SECTION symbol,
> we'll later won't find a corresponding bpf_map instance for a
> corresponding relocation.
>
> So I think it's fine to drop the STT_SECTION.

Great, thanks! I'll send a patch :)

-Toke

