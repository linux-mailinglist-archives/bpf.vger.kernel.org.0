Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC249151141
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2020 21:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgBCUpZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Feb 2020 15:45:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51473 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725372AbgBCUpY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Feb 2020 15:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580762723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rBeREEFrc1ibiywC0oSftvsLzox1ImW/OL6dossCxk=;
        b=EBYj6p0r0hfppSbARuyzGhnO24iU5+atmGlmowkZ+mj6FPN5piZEGJ2K3w72stGJRIs5RN
        Jy5ZnC/yERSMvK4iXCJwXQAqfB/9BmUkBg8SvRFcgnJ3//rlLWmqjS75gsB/ZqXW4OGsuH
        zV5A3SwN3UbnSi30y1Zi0PLYNO5NGUA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-Im441gdqOyCJNiNzY5IvRw-1; Mon, 03 Feb 2020 15:45:22 -0500
X-MC-Unique: Im441gdqOyCJNiNzY5IvRw-1
Received: by mail-lj1-f198.google.com with SMTP id j21so4391052lji.12
        for <bpf@vger.kernel.org>; Mon, 03 Feb 2020 12:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9rBeREEFrc1ibiywC0oSftvsLzox1ImW/OL6dossCxk=;
        b=K9Q36S7ma7XQARtAa3kfpbLZ/0rLPi8gbbX/jJHYJbJwXEL3NvklAofxd5+eo5EXvo
         6VFQWwqKBO1QclKA6Ra/57MprzPnhi3TymVqAJU1X6WbSIwg7L9K52QJ/7MHTht/dcgf
         0p395W8dCGYSFnDRTK48F+aodWCdQADVtFcSds8K7E7CbFu3ZivPpaT8ft6Fn2I3r+ER
         +vapuSIfbwH/U2q8qTsLeWN2nfrqtG+yLPL2IsYcwUr5unKN/WprLa5TDdrCP6Fe9iol
         tPVk+k4FQjhYECe0qN4O6hRsLYjJSAfUS1bhrkGKGFsMDxv0xxlrWpUjcW9NefojXt5o
         sjPg==
X-Gm-Message-State: APjAAAU3zESzpJCKBEEoIhZ3whY5SWUWZOBlZGVDZRo6AfGlpuHRR1dP
        5mNTb8aA05SkmwEn9yb5PWaGcodI/KnN7IiOix65d80wRujdP2PoLzpuY4Jk4BPa4glNG4a89SJ
        aV9PBpuYlj95h
X-Received: by 2002:a2e:810d:: with SMTP id d13mr14964343ljg.113.1580762720042;
        Mon, 03 Feb 2020 12:45:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqxAS4HyP3obPp8U0dyuNGHmzCDo/fMPU55pFRDiI0nn2BEQ1igI8sTBIhJDPBTFIzM1H+QORw==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr14964331ljg.113.1580762719872;
        Mon, 03 Feb 2020 12:45:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v16sm9488227lfp.92.2020.02.03.12.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:45:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D12A81800A2; Mon,  3 Feb 2020 21:45:17 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Miller <davem@redhat.com>
Subject: Re: [PATCH 5/5] bpf: Allow to resolve bpf trampoline in unwind
In-Reply-To: <8f656ce1-c350-0edd-096b-8f1c395609ec@intel.com>
References: <20191229143740.29143-1-jolsa@kernel.org> <20191229143740.29143-6-jolsa@kernel.org> <20200106234639.fo2ctgkb5vumayyl@ast-mbp> <20200107130546.GI290055@krava> <76a10338-391a-ffca-9af8-f407265d146a@intel.com> <20200113094310.GE35080@krava> <a2e2b84e-71dd-e32c-bcf4-09298e9f4ce7@intel.com> <9da1c8f9-7ca5-e10b-8931-6871fdbffb23@intel.com> <20200113123728.GA120834@krava> <20200203195826.GB1535545@krava> <8f656ce1-c350-0edd-096b-8f1c395609ec@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 03 Feb 2020 21:45:17 +0100
Message-ID: <87tv47bdsy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:

> On 2020-02-03 20:58, Jiri Olsa wrote:
> [...]
>>>> ...and FWIW, it would be nice with bpf_dispatcher_<...> entries in kal=
lsyms
>>>
>>> ok so it'd be 'bpf_dispatcher_<name>'
>>=20
>> hi,
>> so the only dispatcher is currently defined as:
>>    DEFINE_BPF_DISPATCHER(bpf_dispatcher_xdp)
>>=20
>> with the bpf_dispatcher_<name> logic it shows in kallsyms as:
>>    ffffffffa0450000 t bpf_dispatcher_bpf_dispatcher_xdp    [bpf]
>>
>
> Ick! :-P
>
>
>> to fix that, would you guys preffer having:
>>    DEFINE_BPF_DISPATCHER(xdp)
>>=20
>> or using the full dispatcher name as kallsyms name?
>> which would require some discipline for future dispatcher names ;-)
>>
>
> I'd prefer the latter, i.e. name "xdp" is shown as bpf_dispatcher_xdp in=
=20
> kallsyms.
>
> ...and if this route is taken, the macros can be changed, so that the=20
> trampoline functions are prefixed with "bpf_dispatcher_". Something like=
=20
> this (and also a small '_' cleanup):

+1; and thanks for fixing that _ as well - that was really bothering me :)

-Toke

