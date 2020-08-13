Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9955244021
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 22:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHMUw3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 16:52:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37427 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbgHMUw2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 16:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597351946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wxW06eavvjQE5S/miuSsmYpL0N+ppHpAk3tInVhZXVw=;
        b=MMX5DTLtjvmz+OhJ84GtGj0jM8jXmhVK6WMherx8HfUl5XxO8d8XZ8jNuCoDngnS2j1iYj
        1uDMvwYQYgdIj/DPq8/SHmQCbgQK4n8HKuL1G2IT7Ub2+HHfy2Tub6y17TAbcgaEmW8i15
        D5/iFQDdFvTo4Elftc6eSykgMJruF80=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-ZQkjkEztObCsV3WRaDAyAA-1; Thu, 13 Aug 2020 16:52:24 -0400
X-MC-Unique: ZQkjkEztObCsV3WRaDAyAA-1
Received: by mail-wm1-f72.google.com with SMTP id a5so2592889wmj.5
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 13:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wxW06eavvjQE5S/miuSsmYpL0N+ppHpAk3tInVhZXVw=;
        b=nGuLX4G2nHMDjJu1nkW7Qn+En3w/cUuj+KyMBeMMsIfKqwZ9bmbMWnPPchZcsbVYkx
         l0M8BBXVTqUbPZqYAk3PcFbU6ygZxYzvooFegdY3xmViYIbf4HBoU44QpTiRng/rozdu
         BJTH8v5q92eh2VAZ53rdjk7sA9atqgUb6ew3tvlmroLFuY9xy/EtRCbr3JcqCY8e9wzc
         AoUOTSKqITBczN2ytQ7j8h6TkVFCq87/tM9XsjfoNFYOXM+IwgvlkA9gDd4nCBtBnAp0
         di9K6X7dltZ82ZlYqfDvOPnsxW2hAc26Bv2u8guRByx7NCuESoKnzN9fhwrT60qnvYtg
         CtAg==
X-Gm-Message-State: AOAM533D/CAv8gXLYQ9fVxouny8cajN5R/diSCJhdAErdHXp2YfulTRj
        228L6AA8dgHWV6DrIjapricbDe3djj3DUKyn5dI24RduvB76ybSFeP+pjbr0C7UJAkO9sr5dqbd
        II6tFcf9cCzJE
X-Received: by 2002:adf:e90f:: with SMTP id f15mr5777601wrm.18.1597351943660;
        Thu, 13 Aug 2020 13:52:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdRaaWG5XK/GB72XCdyO/ddbaB0kDUmcQI2wjL1g2kfocGA05c7/SyiiAki5Xo/nJX2Fbolg==
X-Received: by 2002:adf:e90f:: with SMTP id f15mr5777589wrm.18.1597351943457;
        Thu, 13 Aug 2020 13:52:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r3sm11137607wro.1.2020.08.13.13.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 13:52:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 500A5180493; Thu, 13 Aug 2020 22:52:22 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] libbpf: Prevent overriding errno when logging errors
In-Reply-To: <868b8e78-f0ae-8e59-1816-92051acba1f5@iogearbox.net>
References: <20200813142905.160381-1-toke@redhat.com>
 <CAEf4BzZ6yM_QWu0x4b51NAVzN6-EAoQN4ff4BNiof5CJ5ukhpg@mail.gmail.com>
 <87d03u1fyj.fsf@toke.dk>
 <868b8e78-f0ae-8e59-1816-92051acba1f5@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 13 Aug 2020 22:52:22 +0200
Message-ID: <87a6yy1d6h.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 8/13/20 9:52 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>> On Thu, Aug 13, 2020 at 7:29 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>>>>
>>>> Turns out there were a few more instances where libbpf didn't save the
>>>> errno before writing an error message, causing errno to be overridden =
by
>>>> the printf() return and the error disappearing if logging is enabled.
>>>>
>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>> ---
>>>
>>> Acked-by: Andrii Nakryiko <andriin@fb.com>
>>>
>>>>   tools/lib/bpf/libbpf.c | 12 +++++++-----
>>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index 0a06124f7999..fd256440e233 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -3478,10 +3478,11 @@ bpf_object__probe_global_data(struct bpf_objec=
t *obj)
>>>>
>>>>          map =3D bpf_create_map_xattr(&map_attr);
>>>>          if (map < 0) {
>>>> -               cp =3D libbpf_strerror_r(errno, errmsg, sizeof(errmsg)=
);
>>>> +               ret =3D -errno;
>>>> +               cp =3D libbpf_strerror_r(-ret, errmsg, sizeof(errmsg));
>>>
>>> fyi, libbpf_strerror_r() is smart enough to work with both negative
>>> and positive error numbers (it basically takes abs(err)), so no need
>>> to ensure it's positive here and below.
>>=20
>> Noted. Although that also means it doesn't hurt either, I suppose; so
>> not going to bother respinning this unless someone insists :)
>
> Fixed up while applying, thanks!

Great, thanks!

-Toke

