Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E923B9155
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 13:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhGALxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 07:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236130AbhGALxj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Jul 2021 07:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625140268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cNFWWe/bPNS6BmiZ7sb2iaemvyIzFiI2RZ+5qcnXO7c=;
        b=c1AXFkPJGXJdTCOVMLTE3deP66jEAfgnxC9Gq/x1XQSc4sEspxY1V3LrgReQkcD7wzcyQ/
        CrnNjAwYUyAgvf1uUh6gzi7agxIabQopzAeSxCA6zPjmgFGhbiO/WGnzjOKCHUw7MAVvSI
        MteRF/OPbexYHAyG/bTpNT4NlTkcUSs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-dDHu5ddrPDKq3FzhH40p9A-1; Thu, 01 Jul 2021 07:51:07 -0400
X-MC-Unique: dDHu5ddrPDKq3FzhH40p9A-1
Received: by mail-ej1-f71.google.com with SMTP id k1-20020a17090666c1b029041c273a883dso2004150ejp.3
        for <bpf@vger.kernel.org>; Thu, 01 Jul 2021 04:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cNFWWe/bPNS6BmiZ7sb2iaemvyIzFiI2RZ+5qcnXO7c=;
        b=W6ciKLf8WT90GF3oV3AMBfYRN2+S3rpG/W5q5DsaaX4JhfTNdk/7ZxtqFgZS6VvtW0
         B7PUFt689EU5kyw/NgwJ1zBtNnHhv5TwFZYmCx+M0K6BbzeWfSI/HuVD8espcQ3A30td
         NuM1riPwzPCoDveF/MzH/fIbpCsvTPtQGj2vUgsiE2a8tix/4tV1J/2n5wDHI8SmunFW
         C2GDfXAtarVGpUViHoEFHQ/xNnbInsFsCi4xwo/NT7/kaAdUJLKJfQPSQN7hYRC3JhxJ
         VsjuaPn+2zB89ubsSe/vw0YVrElr9SKbweJni0MLDAT93DI1KC+QDTbfoxHZySZ12zkR
         aEhQ==
X-Gm-Message-State: AOAM532/5TAJ+U5bSywVVJ9vCwClaGkiYPaH2XdHlAS/rRzYgw2olV0g
        pnShFXapHRcIt/iDzCkY01VL9Gb9A4mu9M7vXI2c9UXia02RuR/0p9IbdQMJJ2PlXfx3mbvVBCZ
        /s+zDHZ8BEcWd
X-Received: by 2002:a17:907:72cf:: with SMTP id du15mr315043ejc.54.1625140265966;
        Thu, 01 Jul 2021 04:51:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyv9hPOtyit1IOG3jiYtp8Wtb+POauZnGECcvO6c9QzO5KiQs3r7RRfaD0ghmQrq1KbC67dDQ==
X-Received: by 2002:a17:907:72cf:: with SMTP id du15mr315020ejc.54.1625140265573;
        Thu, 01 Jul 2021 04:51:05 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id yl15sm3993267ejb.85.2021.07.01.04.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 04:51:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 325631804B1; Thu,  1 Jul 2021 13:51:04 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/8] bpf: Introduce bpf timers.
In-Reply-To: <CAADnVQJrZdC3f8SxxBqQK9Ov4Kcgao0enBNAhmwJuZPgxwjQUg@mail.gmail.com>
References: <20210624022518.57875-1-alexei.starovoitov@gmail.com>
 <20210624022518.57875-2-alexei.starovoitov@gmail.com>
 <CAADnVQJrZdC3f8SxxBqQK9Ov4Kcgao0enBNAhmwJuZPgxwjQUg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 01 Jul 2021 13:51:04 +0200
Message-ID: <878s2q1cd3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Jun 23, 2021 at 7:25 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> The bpf_timer_init() helper is receiving hidden 'map' argument and
> ...
>> +               if (insn->imm == BPF_FUNC_timer_init) {
>> +                       aux = &env->insn_aux_data[i + delta];
>> +                       if (bpf_map_ptr_poisoned(aux)) {
>> +                               verbose(env, "bpf_timer_init abusing map_ptr\n");
>> +                               return -EINVAL;
>> +                       }
>> +                       map_ptr = BPF_MAP_PTR(aux->map_ptr_state);
>> +                       {
>> +                               struct bpf_insn ld_addrs[2] = {
>> +                                       BPF_LD_IMM64(BPF_REG_3, (long)map_ptr),
>> +                               };
>
> After a couple of hours of ohh so painful debugging I realized that this
> approach doesn't work for inner maps. Duh.
> For inner maps it remembers inner_map_meta which is a template
> of inner map.
> Then bpf_timer_cb() passes map ptr into timer callback and if it tries
> to do map operations on it the inner_map_meta->ops will be valid,
> but the struct bpf_map doesn't have the actual data.
> So to support map-in-map we need to require users to pass map pointer
> explicitly into bpf_timer_init().
> Unfortunately the verifier cannot guarantee that bpf timer field inside
> map element is from the same map that is passed as a map ptr.
> The verifier can check that they're equivalent from safety pov
> via bpf_map_meta_equal(), so common user mistakes will be caught by it.
> Still not pretty that it's partially on the user to do:
> bpf_timer_init(timer, CLOCK, map);
> with 'timer' matching the 'map'.

The implication being that if they don't match, the callback will just
get a different argument and it'll be up to the developer to deal with
any bugs arising from that?

> Another option is to drop 'map' arg from timer callback,
> but the usability of the callback will suffer. The inner maps
> will be quite painful to use from it.
> Anyway I'm going with explicit 'map' arg in the next respin.
> Other ideas?

So the problem here is that the inner map pointer is not known at
verification time but only at runtime? Could the verifier inject code to
always spill inner map pointers to a known area of the stack after a
map-in-map lookup, and then just load them back from there when needed?
Not sure that would be worth the complexity (and overhead!), though;
having to supply an explicit callback arg is not that uncommon a pattern
after all...

-Toke

