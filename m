Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A46864D32E
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 00:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiLNXT2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 18:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLNXT0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 18:19:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EB54A5AF
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 15:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671059922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3Niud/FDBKZ0PLlm6oSbfgMtWVA78sLZvuotPdg9K8=;
        b=DdGCUi8Dh+j09Oz+c18XVgddbkXXbFhhmxbq5xVN1aca+weLrMj2BWP3/QxUVLRa9Ert2Y
        igLE0RsRfoVcEKMIC3XpAk1WVthjM+A2dCm4r1yvNfPmR7A/zBUZpsf+kv170Fj/7DW+sp
        AR73+kSTL2zPE1m8qYAozDfe7FRhNzk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-106-IZF4Lv7LNNKaLUL1g4JNBg-1; Wed, 14 Dec 2022 18:18:39 -0500
X-MC-Unique: IZF4Lv7LNNKaLUL1g4JNBg-1
Received: by mail-ed1-f72.google.com with SMTP id v4-20020a056402348400b0046cbbc786bdso10493263edc.7
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 15:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3Niud/FDBKZ0PLlm6oSbfgMtWVA78sLZvuotPdg9K8=;
        b=GO6qi2chJTXJGjzDSgpBkipV8dc9xCqD4EyfYfwTVDYfSrzsSsxerKJLPGAKQQqbZH
         Z5jQe/K2vjXCaJgFgpX9gEH4cEDCubY7xAm9zthLUkzULWXYnxPav7oTlc1iRlHU9RX+
         aQujY4NWEBWg22Sy7oyX3NUhEJgvKXJBtAabEEmaxl0lo4BfnuUeoLqbk2l3O9yF5Hue
         DmDfs30ciebLDWDe79Fxstifz+UhRZ6QexhIgO6J4IWRZbccseXQzP5NlVywrCI+0HNx
         eJVg9FT6kUL5+yMTuTxyJu0l6IO87HTBlCwVbyeqO8xXW8G32PmoMs/sTnvEvwUuP2w1
         4MfQ==
X-Gm-Message-State: ANoB5pmOOhPAOZRrz6NzS0sGN2vY2TzF5KcMiMMvJdOY5Mo3ic85TJk5
        /Etl2lWsmuL4+iE/s1r31AmPcrNm5Rf52ciQhlk7+CMndmQOvnvYMeL0zPPXc7+Xu+Z1TFLjNF9
        cAlnOo3hGXjjw
X-Received: by 2002:aa7:c917:0:b0:46d:8aeb:bc03 with SMTP id b23-20020aa7c917000000b0046d8aebbc03mr24264335edt.22.1671059916731;
        Wed, 14 Dec 2022 15:18:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5rOn0PuoH3Gafe+Vm7g0LYq3zaZ70GXRaw4Bn9629i81BWP10FSH3Cvtf+lIWyqLkBSc/GUg==
X-Received: by 2002:aa7:c917:0:b0:46d:8aeb:bc03 with SMTP id b23-20020aa7c917000000b0046d8aebbc03mr24264253edt.22.1671059914420;
        Wed, 14 Dec 2022 15:18:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id dy1-20020a05640231e100b00459f4974128sm6873508edb.50.2022.12.14.15.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 15:18:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 47CD782F667; Thu, 15 Dec 2022 00:18:33 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf] libbpf: Fix signedness confusion when using
 libbpf_is_mem_zeroed()
In-Reply-To: <CAEf4BzZOYD7YEgzWz08Q7sZ8wMVf+kiP7Aw1tm4_wN0_mNDrhA@mail.gmail.com>
References: <20221214010046.668024-1-toke@redhat.com>
 <CAEf4BzZOYD7YEgzWz08Q7sZ8wMVf+kiP7Aw1tm4_wN0_mNDrhA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 15 Dec 2022 00:18:33 +0100
Message-ID: <87zgbpefqu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Dec 13, 2022 at 5:01 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> The commit in the Fixes tag refactored the check for zeroed memory in
>> libbpf_validate_opts() into a separate libbpf_is_mem_zeroed() function.
>> This function has a 'len' argument of the signed 'ssize_t' type, which in
>> both callers is computed by subtracting two unsigned size_t values from
>> each other. In both subtractions, one of the values being subtracted is
>> converted to 'ssize_t', while the other stays 'size_t'.
>>
>> The problem with this is that, because both sizes are the same
>> rank ('ssize_t' is defined as 'long' and 'size_t' is 'unsigned long'), t=
he
>> type of the mixed-sign arithmetic operation ends up being converted back=
 to
>> unsigned. This means it can underflow if the user-specified size in
>> opts->sz is smaller than the size of the type as defined by libbpf. If t=
hat
>> happens, it will cause out-of-bounds reads in libbpf_is_mem_zeroed().
>
> hmm... but libbpf_is_mem_zeroed expects signed ssize_t, so that
> "underflow" will turn into a proper negative ssize_t value. What am I
> missing? Seems to be working fine:
>
> $ cat test.c
> #include <stdio.h>
>
> void testit(ssize_t sz)
> {
>         printf("%zd\n", sz);
> }
>
> int main()
> {
>         ssize_t slarge =3D 100;
>         size_t ularge =3D 100;
>         ssize_t ssmall =3D 50;
>         size_t usmall =3D 50;
>
>         testit(ssmall - slarge);
>         testit(ssmall - ularge);
>         testit(usmall - slarge);
>         testit(usmall - ularge);
> }
>
> $ cc test.c && ./a.out
> -50
> -50
> -50
> -50

Hmnm, yeah, you're right. Not sure how I managed to convince myself
there was an actual bug there :(

Sorry for the noise!

-Toke

