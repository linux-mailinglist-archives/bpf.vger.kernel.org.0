Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458BC351FE6
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 21:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhDAThS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 15:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbhDAThR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 15:37:17 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85302C0613E6;
        Thu,  1 Apr 2021 12:37:17 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id 1so2365760qtb.0;
        Thu, 01 Apr 2021 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=eREv8wsoY+4Cc0jkM56aKVn1TEtGQU7ENVhOfYmiJeM=;
        b=Trh8LkluVzMGewlxO8exCFQsBL1qbovMKQ6FxPT95CWGZV7BH/u9ldYhTYrkF+6KkU
         vusR0L5z3ERnSXkMu77I3Cnk00FZ7SBSSQ2HsX9CX0oCBXKlSB0mVH4wg5Es98zy4BYb
         OhdCPKc3BciinMoF7LCVvZxIiSbJB+O+dsDT30yIniGNyG69tB6xZlxvnQU/cbeMtBqx
         RNHgzoAWagHi+4NZXa/ZM/3sI7Hp5jbvLOzG3YcGCIG1o29odXg8/1tYfzbV7x9zPHz7
         /xSTAZ2hb1mLt8+IOzBPjf9Qzax+yJ8etPiLVuk3vbkKDq/a8ew74MfvIa0dJL8rOzNj
         mFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=eREv8wsoY+4Cc0jkM56aKVn1TEtGQU7ENVhOfYmiJeM=;
        b=lIrTshULRqjUVIRsIOVktGvA4+ulmV7p4spOcoMQnHISpfEysXVVDP4YydRjimkQ09
         6qvadqqrSTW9CVwIPvOWvi22peFzq9cYB8sgFcHN1nk9jdg5S2WpYfcrELJ9tzmsjgWg
         +CfylsdT4/NhWkjA9OK7J6Z1td9Pln35GqlqEQvkc7ENKGKgmegXR6BYoS+OwwDVlaas
         hJigLvpaBzYU38335K+m0Yi0/KAEtM7AmFQ5A4EaW3zl2u7Lb0LHd2+/6lWCHcq86iNf
         /RQSBcqYfJpGeLs/ysRSeGSCufRStyBDgzfWNQ9oYehaC1byEJZtiJuYzIXJScPtmpAh
         8Idw==
X-Gm-Message-State: AOAM531ML1YSkbimY4CjlIkL+QKH33hKhGfEiiyw8OSGg6TFqOjNhZ4u
        HYHIDdVbkTQ3dYp3NHU76X/PiXO2qZ+b+g==
X-Google-Smtp-Source: ABdhPJzEnhm1WQLk0oGrLAHPG0HSkYdafED2QZky7JZHVgaF4JbrYfyIVGCmlHaw1k/EeHsrl6wm8w==
X-Received: by 2002:ac8:4406:: with SMTP id j6mr8587782qtn.180.1617305836670;
        Thu, 01 Apr 2021 12:37:16 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h11sm4225404qtp.24.2021.04.01.12.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 12:37:16 -0700 (PDT)
Date:   Thu, 01 Apr 2021 16:36:34 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <CAKwvOd=mzDREDAXCxdFzSWnxC1hNc7udMXc7Lrf50qmJk9zE7Q@mail.gmail.com>
References: <20210401025815.2254256-1-yhs@fb.com> <20210401025820.2254482-1-yhs@fb.com> <CAKwvOd=mzDREDAXCxdFzSWnxC1hNc7udMXc7Lrf50qmJk9zE7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: check .debug_abbrev for cross-cu references
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Yonghong Song <yhs@fb.com>
CC:     dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com, David Blaikie <blaikie@google.com>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <E4B08495-BC24-40F7-9BEA-010B534E5454@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On April 1, 2021 3:52:05 PM GMT-03:00, Nick Desaulniers <ndesaulniers@goog=
le=2Ecom> wrote:
>On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb=2Ecom> wrote:
>>
>> Commit 39227909db3c checked compilation flags to see
>> whether the binary is built with lto or not (-flto)=2E
>> Currently, for clang lto build, default setting
>> won't put compilation flags in dwarf due to size
>> concern=2E
>>
>> David Blaikie suggested in [1] to scan through =2Edebug_abbrev
>> for DW_FORM_ref_addr which should be most faster than
>> scanning through cu's=2E This patch implemented this
>> suggestion and replaced the previous compilation flag
>> matching approach=2E Indeed, it seems that the overhead
>> for this approach is indeed managable=2E
>>
>> I did some change to measure the overhead of cus_merging_cu():
>>   @@ -2650,7 +2652,15 @@ static int cus__load_module(struct cus *cus,
>struct conf_load *conf,
>>                   }
>>           }
>>
>>   -       if (cus__merging_cu(dw)) {
>>   +       bool do_merging;
>>   +       struct timeval start, end;
>>   +       gettimeofday(&start, NULL);
>>   +       do_merging =3D cus__merging_cu(dw);
>>   +       gettimeofday(&end, NULL);
>>   +       fprintf(stderr, "%ld %ld -> %ld %ld\n", start=2Etv_sec,
>start=2Etv_usec,
>>   +                       end=2Etv_sec, end=2Etv_usec);
>>   +
>>   +       if (do_merging) {
>>                   res =3D cus__merge_and_process_cu(cus, conf, mod, dw,
>elf, filename,
>>                                                   build_id,
>build_id_len,
>>                                                   type_cu ? &type_dcu
>: NULL);
>>
>> For lto vmlinux, the cus__merging_cu() checking takes
>> 130us over total "pahole -J vmlinux" time 65sec as the function bail
>out
>> earlier due to detecting a merging cu condition=2E
>> For non-lto vmlinux, the cus__merging_cu() checking takes
>> ~171368us over total pahole time 36sec, roughly 0=2E5% overhead=2E
>>
>>  [1] https://lore=2Ekernel=2Eorg/bpf/20210328064121=2E2062927-1-yhs@fb=
=2Ecom/
>>
>
>It might be a nice little touch to add:
>
>Suggested-by: David Blaikie <blaikie@google=2Ecom>

Sure, this is something that is becoming the norm, be it from patch submit=
ters, or, that being somehow lost, by the maintainer=2E

I think this is not just fair, but documents what actually happened and en=
courage people to share ideas more freely and quickly=2E

I'll do it in this specific case=2E

if I failed to do so I'm the past, I'm sorry=2E

- Arnaldo
>
>> Signed-off-by: Yonghong Song <yhs@fb=2Ecom>
>> ---
>>  dwarf_loader=2Ec | 43 ++++++++++++++++++++++++-------------------
>>  1 file changed, 24 insertions(+), 19 deletions(-)
>>
>> diff --git a/dwarf_loader=2Ec b/dwarf_loader=2Ec
>> index c1ca1a3=2E=2Ebd23751 100644
>> --- a/dwarf_loader=2Ec
>> +++ b/dwarf_loader=2Ec
>> @@ -2503,35 +2503,40 @@ static int cus__load_debug_types(struct cus
>*cus, struct conf_load *conf,
>>
>>  static bool cus__merging_cu(Dwarf *dw)
>>  {
>> -       uint8_t pointer_size, offset_size;
>>         Dwarf_Off off =3D 0, noff;
>>         size_t cuhl;
>> -       int cnt =3D 0;
>>
>> -       /*
>> -        * Just checking the first cu is not enough=2E
>> -        * In linux, some C files may have LTO is disabled, e=2Eg=2E,
>> -        *   e242db40be27  x86, vdso: disable LTO only for vDSO
>> -        *   d2dcd3e37475  x86, cpu: disable LTO for cpu=2Ec
>> -        * Fortunately, disabling LTO for a particular file in a LTO
>build
>> -        * is rather an exception=2E Iterating 5 cu's to check whether
>> -        * LTO is used or not should be enough=2E
>> -        */
>> -       while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL,
>&pointer_size,
>> -                           &offset_size) =3D=3D 0) {
>> +       while (dwarf_nextcu (dw, off, &noff, &cuhl, NULL, NULL, NULL)
>=3D=3D 0) {
>>                 Dwarf_Die die_mem;
>>                 Dwarf_Die *cu_die =3D dwarf_offdie(dw, off + cuhl,
>&die_mem);
>>
>>                 if (cu_die =3D=3D NULL)
>>                         break;
>>
>> -               if (++cnt > 5)
>> -                       break;
>> +               Dwarf_Off offset =3D 0;
>> +               while (true) {
>> +                       size_t length;
>> +                       Dwarf_Abbrev *abbrev =3D dwarf_getabbrev
>(cu_die, offset, &length);
>> +                       if (abbrev =3D=3D NULL || abbrev =3D=3D
>DWARF_END_ABBREV)
>> +                               break;
>>
>> -               const char *producer =3D attr_string(cu_die,
>DW_AT_producer);
>> -               if (strstr(producer, "clang version") !=3D NULL &&
>> -                   strstr(producer, "-flto") !=3D NULL)
>> -                       return true;
>> +                       size_t attrcnt;
>> +                       if (dwarf_getattrcnt (abbrev, &attrcnt) !=3D 0)
>> +                               return false;
>> +
>> +                       unsigned int attr_num, attr_form;
>> +                       Dwarf_Off aboffset;
>> +                       size_t j;
>> +                       for (j =3D 0; j < attrcnt; ++j) {
>> +                               if (dwarf_getabbrevattr (abbrev, j,
>&attr_num, &attr_form,
>> +                                                        &aboffset))
>> +                                       return false;
>> +                               if (attr_form =3D=3D DW_FORM_ref_addr)
>> +                                       return true;
>> +                       }
>> +
>> +                       offset +=3D length;
>> +               }
>>
>>                 off =3D noff;
>>         }
>> --
>> 2=2E30=2E2
>>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
