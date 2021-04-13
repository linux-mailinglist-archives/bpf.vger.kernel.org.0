Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB8835DAA5
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 11:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhDMJIL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 05:08:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229562AbhDMJIL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 05:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618304871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8dMjKPuj7Gd9aR14Ewh3xOlWPPZ0nGmss4wwNBp1e0=;
        b=IIabpadAxA0x6t1beBe6Lj5PYSwTzDqTjSo3SKhhMda84odsUzRuY1F2gPYwrzjG5WAmV/
        Krt3frRvhYNhpLVUJyQ3TSm+Y/i9R7W/gNn2fIZzvcLB0O1C/gOh4bX/Q1obvAt56Dc85T
        1TyzkE0F5VV6WmYT8lnx37uJRP1STCY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-SEUuVpEINEyzjHHQGIBp2g-1; Tue, 13 Apr 2021 05:07:50 -0400
X-MC-Unique: SEUuVpEINEyzjHHQGIBp2g-1
Received: by mail-ed1-f72.google.com with SMTP id o4-20020a0564024384b0290378d45ecf57so942634edc.12
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 02:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=i8dMjKPuj7Gd9aR14Ewh3xOlWPPZ0nGmss4wwNBp1e0=;
        b=TNKEwNge3syrEmQrplzrlFk5VA2L2px20KovTwH2Y0VeRXpb5xBNF8UbbE3xl4bpD6
         bGxbnaYsj3zbt8YHxqW7Vn4PK6RuHILKRNrzyV/6p0SOs3tHJxBGRqQCsQV3al6ovafM
         x1QtXX8SC8Pj/eHlJxpST9pWg0HltziYyefQcA40isvAA+quZdgEbGLHc2F8S7/OtjTp
         b8NXVdChuvDvpuV7hg0HopPdS4bom2DIC4a9z7ZDTfl6LxfhzT70+D68iZ8QPjqOkhdw
         Odf6KW6Ci4huZPdyqZnPyCmDNP8ao7pDbH+2+9/E4NLWioema54BRwohaaLQvzJ7Etl5
         5oYw==
X-Gm-Message-State: AOAM533zE6UEGPepTquLVGNze9B4jehqaX1Tm8IUOcQKNS2MdcGSZap0
        sOtoK5PoqHNtiDMP47FK1zi7DU5it0IGl/DZClQHoXYjap7zGKdxzhf4/gFGqNzkR9rhmR6Ew+h
        NvIaCxgTDcsD1
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr33728941eds.166.1618304868366;
        Tue, 13 Apr 2021 02:07:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp3kyKEBlRQ4BwAjSlCMXdIVOOtcT0J9HoZdh2Yw//R/t5HNny9W+E0REGUrpEPWbjCrDijQ==
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr33728926eds.166.1618304868185;
        Tue, 13 Apr 2021 02:07:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t14sm7366159ejc.121.2021.04.13.02.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:07:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 18E9E1804E8; Tue, 13 Apr 2021 11:07:47 +0200 (CEST)
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
In-Reply-To: <CAEf4BzaZ8nAAqs8twnqCtSvmxsDvKBDUaYw+s+CcOnZyYo=0Vw@mail.gmail.com>
References: <20210408195740.153029-1-toke@redhat.com>
 <20210408195740.153029-2-toke@redhat.com>
 <CAEf4BzaZ8nAAqs8twnqCtSvmxsDvKBDUaYw+s+CcOnZyYo=0Vw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 13 Apr 2021 11:07:47 +0200
Message-ID: <87blaio8m4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Apr 8, 2021 at 12:57 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Extend the fexit_bpf2bpf test to check that the info for the bpf_link
>> returned by the kernel matches the expected values.
>>
>> While we're updating the test, change existing uses of CHEC() to use the
>> much easier to read ASSERT_*() macros.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> Just a minor nit below. Looks good, thanks.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
>>  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 50 +++++++++++++++----
>>  1 file changed, 39 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/to=
ols/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
>> index 5c0448910426..019a46d8e98e 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
>> @@ -57,11 +57,13 @@ static void test_fexit_bpf2bpf_common(const char *ob=
j_file,
>>                                       bool run_prog,
>>                                       test_cb cb)
>>  {
>> +       __u32 duration =3D 0, retval, tgt_prog_id, info_len;
>
> if not CHECK() is used, duration shouldn't be needed anymore

Oh, and duration is still needed for bpf_prog_test_run(), so I'll keep
that; but removing it did make the compiler point out that I missed one
CHECK() at the beginning of the function when converting, so will fix
that instead :)

-Toke

