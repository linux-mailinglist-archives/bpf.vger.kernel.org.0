Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86DC2D1D2F
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 23:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgLGWUN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 17:20:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbgLGWUN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 17:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607379526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fth5ZshA4w8bE9b8/qiWSCrkxogy+LVVKUmgi5NsXks=;
        b=G+cV/Zg+zBZIi2k4E3xqKFun8Olpn/Q8rIsaDnv+J9Lxuekm8qDp1w1oGFyRt+PpmIIt1H
        vdfQYaZlSjXXpg2AwjBip/lJuC2bqZvp1F/SvLhMWo8HlGCKw2V95CFKL86g+ThoCJXRd+
        eqlJ4p8cQm/O7yoVJquQdd7wo+25Yu8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-P9WEY0ytMKqDQeJhlj40qg-1; Mon, 07 Dec 2020 17:18:44 -0500
X-MC-Unique: P9WEY0ytMKqDQeJhlj40qg-1
Received: by mail-wr1-f71.google.com with SMTP id 91so5261206wrk.17
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 14:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Fth5ZshA4w8bE9b8/qiWSCrkxogy+LVVKUmgi5NsXks=;
        b=gLanZvCtaEnFiZN9J0KZ8EjLRnb/TyYFyp7rynA7Y6u/ZXcvCHVIfC4RFVlDYW066Z
         oEIZgPbPsLsQRoqHJe40NN+R/QjERDTQQUglTaNskPsQJFP1T7G6jloVus8ZVJQ4qvaR
         alwmVI2+8Q+UDMlXqHmnMlWDOfcIAVAYHkIS+7rJ5RfPCfImlE5AG1q2r/JaBWEpI6hG
         BaFyKGaj6DW2Lk+rvrKlW7qaWnCFOZXTGwXu8kamVUWnIpCnOOACo/esL+ebE4W4+3VX
         gXnY5UjHnhiT8kZzjMfHx4bXovnVm8ibg6q5hOSXoOC9Q4LwgLhtz0LNDoIUbATEiGBi
         Kbyg==
X-Gm-Message-State: AOAM530e6MLJmd51fnEWIGLpzfF/JVXa5tTxzxxBHlrCitA9CAeDVAGD
        WhO5WAJddETCBsF2cchcFXBQvN1uGJhGdCqmwBpoTabH3sj+0A/BHaoAvDYuU0AwDi5ON9q/I08
        50rtm+r72UZfL
X-Received: by 2002:adf:a3c1:: with SMTP id m1mr22792772wrb.28.1607379523682;
        Mon, 07 Dec 2020 14:18:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXVT4WVwHnS2nuJVQ67PRhP411hbaf27RH3LB3A8/yPJvHHfgEqMoLeiz7LptG4SV7tj9IrQ==
X-Received: by 2002:adf:a3c1:: with SMTP id m1mr22792762wrb.28.1607379523502;
        Mon, 07 Dec 2020 14:18:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h83sm803798wmf.9.2020.12.07.14.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:18:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 64A5E1843F5; Mon,  7 Dec 2020 23:18:42 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
In-Reply-To: <CAADnVQLGY26QfiZm8WvoeNJmBYOgVz_h-SjHLgoYqw=P4M4fLg@mail.gmail.com>
References: <87lfeebwpu.fsf@toke.dk>
 <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com> <87r1o59aoc.fsf@toke.dk>
 <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
 <875z5d7ufl.fsf@toke.dk>
 <CAADnVQ+qibC_8cDwaqOoAnL7CwXv85EjQ96Zcdtrm+86cgZq1g@mail.gmail.com>
 <878sa9619d.fsf@toke.dk>
 <CAADnVQKYaeF2KCC5SLBg3feUY_DBh-eq2_O=T10_+13z3wNm1Q@mail.gmail.com>
 <874kkx5zl5.fsf@toke.dk>
 <CAADnVQLGY26QfiZm8WvoeNJmBYOgVz_h-SjHLgoYqw=P4M4fLg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 07 Dec 2020 23:18:42 +0100
Message-ID: <87tusxi7jx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Dec 7, 2020 at 8:51 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Mon, Dec 7, 2020 at 8:15 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>> >>
>> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> >>
>> >> > On Mon, Dec 7, 2020 at 3:03 AM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>> >> >>
>> >> >> Wait, what? This is a regression that *breaks people's programs* on
>> >> >> compiler versions that are still very much in the wild! I mean, fi=
ne if
>> >> >> you don't want to support new features on such files, but then sur=
ely we
>> >> >> can at least revert back to the old behaviour?
>> >> >
>> >> > Those folks that care about compiling with old llvm would have to s=
tick
>> >> > to whatever loader they have instead of using libbpf.
>> >> > It's not a backward compatibility breakage.
>> >>
>> >> What? It's a change in libbpf that breaks loading of existing BPF obj=
ect
>> >> files that were working (with libbpf) before. If that's not a backward
>> >> compatibility break then that term has lost all meaning.
>> >
>> > The user space library is not a kernel.
>> > The library will change its interface. It will remove functions, featu=
res, etc.
>> > That's what .map is for.
>>
>> Right, OK, so how do I use .map to get the old behaviour here? That's
>> all I'm asking for, really...
>
> Fix old llvm. The users would have to upgrade either from llvm 7.x to
> 7.x+1 or to llvm 10+.

Right, so by "we keep a stable interface" you mean "we expect you to
upgrade your entire toolchain every time you update the library". Gotcha!
I'll rectify my newspeak dictionary straight away - doubleplusgood!

-Toke

