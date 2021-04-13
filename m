Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEF335DAE9
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245596AbhDMJRQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 05:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237858AbhDMJRQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 05:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618305416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fa0VO4NS0WcM6QKIm6X93LeNCNUpBKsoeWvxsAb3W6A=;
        b=cp2bQCYl1Yknw8E1Sssa1pVIcBoaXYbfaEmJl7BqJnkYab8piZm18j2cL0x511SvtxDLoW
        Cfgw2aEqqXkhVgsDAxZrUp3zvON9U0ss4wJPeJMhYDJUfgtSSZzpbv++l7PfnzphJyp2yP
        Bx004NssgV6LcSf7XohdtL7/HJttKK4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-Yg6tqjeXM7ucg81pH7BoFQ-1; Tue, 13 Apr 2021 05:16:55 -0400
X-MC-Unique: Yg6tqjeXM7ucg81pH7BoFQ-1
Received: by mail-ed1-f70.google.com with SMTP id ay2-20020a0564022022b02903824b52f2d8so947427edb.22
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 02:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Fa0VO4NS0WcM6QKIm6X93LeNCNUpBKsoeWvxsAb3W6A=;
        b=U2h8bq55HptvkuK0FP/nyaR0JtMU0dOHKRLFtxc24FqSya0dsu7QVF/7bzEBZuOqRs
         FPzJ8J17w2hIR1bY6JBjkiP9UeMCVOF94HR+zgmufm0HTdTfGDQoBS5EydMdY6aKlNQ/
         RganYXgeLkIz2szYXP98yYXkW2GcXRtexiQ+I+VMTaEfbf4hOzffirKmN3mACo0qkK0c
         5m/EBcmCIJdELM+OvqAOKsFL1A62CML+OojzeADIc/+IpISDP0GxY1Y4nimD0lI6W49b
         zokkxbMNF0lBBaAiWD3rnzbsZIIXa92FIprQI0C13TBMA3u4GV4itDmEZc7c2Na1E9Zd
         LytA==
X-Gm-Message-State: AOAM532lpVX6d5I88C+EnN9yB1zncQxLcnkfC5+XXzY3B68HgpxVe1AR
        roF1FWsSPDZ88t+P8xjXNMvJ+zEVYmcvxVILdKHgwDkq5JqyxDvVjZKZoogbwQhmiusQ+vkslFc
        +Iiw+ZP9Rjuj2
X-Received: by 2002:a05:6402:1a:: with SMTP id d26mr33922784edu.99.1618305413235;
        Tue, 13 Apr 2021 02:16:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwb19cyfHtp062mT2t/joUSCyyAo4rjkwRZEQv9nXu7Yt+rpIz9Pw792L/CaBDPL464iV5z0Q==
X-Received: by 2002:a05:6402:1a:: with SMTP id d26mr33922740edu.99.1618305412788;
        Tue, 13 Apr 2021 02:16:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x24sm8938429edr.36.2021.04.13.02.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:16:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D693C1804E8; Tue, 13 Apr 2021 11:16:51 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add tests for target
 information in bpf_link info queries
In-Reply-To: <87blaio8m4.fsf@toke.dk>
References: <20210408195740.153029-1-toke@redhat.com>
 <20210408195740.153029-2-toke@redhat.com>
 <CAEf4BzaZ8nAAqs8twnqCtSvmxsDvKBDUaYw+s+CcOnZyYo=0Vw@mail.gmail.com>
 <87blaio8m4.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 13 Apr 2021 11:16:51 +0200
Message-ID: <878s5mo870.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
>> On Thu, Apr 8, 2021 at 12:57 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>>>
>>> Extend the fexit_bpf2bpf test to check that the info for the bpf_link
>>> returned by the kernel matches the expected values.
>>>
>>> While we're updating the test, change existing uses of CHEC() to use the
>>> much easier to read ASSERT_*() macros.
>>>
>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>> ---
>>
>> Just a minor nit below. Looks good, thanks.
>>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>
>>>  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 50 +++++++++++++++----
>>>  1 file changed, 39 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/t=
ools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
>>> index 5c0448910426..019a46d8e98e 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
>>> @@ -57,11 +57,13 @@ static void test_fexit_bpf2bpf_common(const char *o=
bj_file,
>>>                                       bool run_prog,
>>>                                       test_cb cb)
>>>  {
>>> +       __u32 duration =3D 0, retval, tgt_prog_id, info_len;
>>
>> if not CHECK() is used, duration shouldn't be needed anymore
>
> Oh, and duration is still needed for bpf_prog_test_run(), so I'll keep
> that; but removing it did make the compiler point out that I missed one
> CHECK() at the beginning of the function when converting, so will fix
> that instead :)

Argh, no, bpf_prog_test_run() will accept a NULL pointer for duration;
sorry for the noise!

-Toke

