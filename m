Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98788456F4B
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 14:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhKSNH7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 08:07:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235264AbhKSNH6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Nov 2021 08:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637327096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6cmbOiQ55ZXdF0mO+dnrrshZrs0frOxYZORj8IVZZ4=;
        b=DW4+zweozZ0tLV7M+4y+8VX+cnO6RXdRILDXi1HcGWIT03fioVQKvViT6b2/wfuhKLgqSD
        CPXVRlE+oTPDBZue0SFsH9sv0AMihtTer8n/lUUkI7X4Rp4lbACdmRE4YeOpmpC6aZ8x2B
        7ivQOTyuYittrsQnX+nH7SJAybtEddE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-qF2kGbLqOGukxtzSzaS_YQ-1; Fri, 19 Nov 2021 08:04:55 -0500
X-MC-Unique: qF2kGbLqOGukxtzSzaS_YQ-1
Received: by mail-ed1-f69.google.com with SMTP id d13-20020a056402516d00b003e7e67a8f93so8372201ede.0
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 05:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=K6cmbOiQ55ZXdF0mO+dnrrshZrs0frOxYZORj8IVZZ4=;
        b=lLJFOf8qrxt7aHD3CGg+J2xe5p9rBd3onaGYKp6I+YrU4YF9XP8P5M2vBsPQ4hy9Pw
         ijx5j6eFXzFwsGoOoFmRixyaUMWvB6EeCmsqHa7FoGPPFUBNzDyFrzyfYaLvY5Kvth+j
         OVI97zuZvyRLsyQv6I3DYm08ivltU+wNQm6rGuS0yt6FXc4bfVTeqA75QMCJvpn/0WtY
         2sQHbkc60PeSz1QP9KQzOS7wydxer08KX7M7kyEjcFwWoZtr6BwEI6DqHsyTrR57vSjF
         hCMxrGed92B8+yda7NAyt5U91ZKLVEm3mMgE4AjsJtZovKRzQRDDZaz5dyZYWPv8xxBO
         Jm8w==
X-Gm-Message-State: AOAM531xlb9bl7rVY5LX38J1T2fpRmhy4tY4WXRIUILVp70bweX9Ux7S
        Wh185sVlVwiwEs+Zjs/DMhEW8ZQQ+XR/JMMbHCrq2WekgS+sceWNQQjF9U/qoPiQSbHI+8H2j47
        7ipuprM+gGmpA
X-Received: by 2002:a50:d8cf:: with SMTP id y15mr24535482edj.66.1637327093848;
        Fri, 19 Nov 2021 05:04:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy26nrFMDrOxx3OSitu9nVzhMAHsBa2S0qxcIueDqyiRaArkoVPESh9AxXNat67Zs4y4RmRbw==
X-Received: by 2002:a50:d8cf:: with SMTP id y15mr24535443edj.66.1637327093585;
        Fri, 19 Nov 2021 05:04:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id hx21sm1129020ejc.85.2021.11.19.05.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:04:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 16484180270; Fri, 19 Nov 2021 14:04:52 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 3/3] selftest/bpf/benchs: add bpf_for_each
 benchmark
In-Reply-To: <CAEf4BzZMJfSqx9wLq9ntSK+n4kE82S_ifgFhBVtjYiy0vz4Gyg@mail.gmail.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
 <20211118010404.2415864-4-joannekoong@fb.com> <87r1bdemq4.fsf@toke.dk>
 <CAEf4BzZMJfSqx9wLq9ntSK+n4kE82S_ifgFhBVtjYiy0vz4Gyg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 19 Nov 2021 14:04:52 +0100
Message-ID: <874k88e1or.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Nov 18, 2021 at 3:18 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Joanne Koong <joannekoong@fb.com> writes:
>>
>> > Add benchmark to measure the overhead of the bpf_for_each call
>> > for a specified number of iterations.
>> >
>> > Testing this on qemu on my dev machine on 1 thread, the data is
>> > as follows:
>>
>> Absolute numbers from some random dev machine are not terribly useful;
>> others have no way of replicating your tests. A more meaningful
>> benchmark would need a baseline to compare to; in this case I guess that
>> would be a regular loop? Do you have any numbers comparing the callback
>> to just looping?
>
> Measuring empty for (int i =3D 0; i < N; i++) is meaningless, you should
> expect a number in billions of "operations" per second on modern
> server CPUs. So that will give you no idea. Those numbers are useful
> as a ballpark number of what's the overhead of bpf_for_each() helper
> and callbacks. And 12ns per "iteration" is meaningful to have a good
> idea of how slow that can be. Depending on your hardware it can be
> different by 2x, maybe 3x, but not 100x.
>
> But measuring inc + cmp + jne as a baseline is both unrealistic and
> doesn't give much more extra information. But you can assume 2B/s,
> give or take.
>
> And you also can run this benchmark on your own on your hardware to
> get "real" numbers, as much as you can expect real numbers from
> artificial microbenchmark, of course.
>
>
> I read those numbers as "plenty fast" :)

Hmm, okay, fair enough, but I think it would be good to have the "~12 ns
per iteration" figure featured prominently in the commit message, then :)

-Toke

