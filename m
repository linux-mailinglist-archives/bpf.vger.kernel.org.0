Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1263C196D3C
	for <lists+bpf@lfdr.de>; Sun, 29 Mar 2020 14:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgC2MRU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Mar 2020 08:17:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51645 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727965AbgC2MRT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 29 Mar 2020 08:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585484238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WfywHfrj+1lQlKG+4iQOCkxR/74mY2cs8yIfDnYdB3o=;
        b=C6ILBwFgOhVQNZe4/PQqARCKQE9sZL84+aMHkxU1JYC/bPwGDh4E8qIHYwDlexeLqaWT2J
        4dOxTMvnWwQ+uRVsGcHAiDkTghcE9sR2IUY/8O5p3IjqQRRmtJg0KkD2btYpZv+C6Q9Zu/
        HmRgzyxpJlBvkEFU5+++mlHYS7l0Krg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-usFmsAQYPMOIDmvN6NgBeA-1; Sun, 29 Mar 2020 08:17:16 -0400
X-MC-Unique: usFmsAQYPMOIDmvN6NgBeA-1
Received: by mail-lf1-f71.google.com with SMTP id l5so1528391lfg.3
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2020 05:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WfywHfrj+1lQlKG+4iQOCkxR/74mY2cs8yIfDnYdB3o=;
        b=pTaJztIHFSRci9DKG/4FLu+J74LUKDtwXgSCgRQMNORY8OMT5vUYj1K/WWapcdbezy
         4sjCnmc0yMlxQ5tGGA4b0djo3iYwUXezy6Kbn6xR6Fp1QvoPYEuxo4CXY2RMiJ1fnUwG
         13ikw00sK+8driPcTV3pjJ7uYLY+e3VGrXJRQCBC6W5pFph9tmsbZyBiyRm2D8rskB2d
         eJODJ2mjHIR1UMeOM4efRGHwBcEf579eOCwUCmkN06s5qVyCaAEGRLgaOGr0RKwo04tu
         VdaxZb3h/82PTGZQ9iVjMoT06uqUQPEMDkNf9iWC5t2xuOCDHpI50EX2kPZkM53Dn7VO
         RU7w==
X-Gm-Message-State: AGi0Pua3j+OYBi8gF/rWhArwAusGhLbMZZ/OtgeqNCtYxKCWu91OQKxs
        cdABzlNeiE5cpYfu/a3yXY+ERbZgG7geIEc7eCHcJ8+FOzgnxpyqWjaWf0OwuRvL3DjQC04YCOe
        5iklFJJ4rzBaV
X-Received: by 2002:a2e:a0d3:: with SMTP id f19mr4431503ljm.117.1585484234813;
        Sun, 29 Mar 2020 05:17:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNtDmTAqdxHNjpdzVM2nzYejdd1kFapt/FdxAG4xUpn/tdU1PbrccBYg+depfNm5J6anS3GA==
X-Received: by 2002:a2e:a0d3:: with SMTP id f19mr4431492ljm.117.1585484234606;
        Sun, 29 Mar 2020 05:17:14 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l6sm5027211ljc.80.2020.03.29.05.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 05:17:13 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 39AE118158B; Sun, 29 Mar 2020 14:17:12 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] libbpf: Add setter for initial value for internal maps
In-Reply-To: <CAEf4BzaN5s_quON_pvPsoretOGSvFVffzCrSve+=7A_bw94asQ@mail.gmail.com>
References: <20200327125818.155522-1-toke@redhat.com> <20200328182834.196578-1-toke@redhat.com> <CAEf4BzaN5s_quON_pvPsoretOGSvFVffzCrSve+=7A_bw94asQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 29 Mar 2020 14:17:12 +0200
Message-ID: <87wo73jqyf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Sat, Mar 28, 2020 at 11:29 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>>
>> For internal maps (most notably the maps backing global variables), libb=
pf
>> uses an internal mmaped area to store the data after opening the object.
>> This data is subsequently copied into the kernel map when the object is
>> loaded.
>>
>> This adds a function to set a new value for that data, which can be used=
 to
>> before it is loaded into the kernel. This is especially relevant for ROD=
ATA
>> maps, since those are frozen on load.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>> v3:
>>   - Add a setter for the initial value instead of a getter for the point=
er to it
>>   - Add selftest
>> v2:
>>   - Add per-map getter for data area instead of a global rodata getter f=
or bpf_obj
>>
>>  tools/lib/bpf/libbpf.c   | 11 +++++++++++
>>  tools/lib/bpf/libbpf.h   |  2 ++
>>  tools/lib/bpf/libbpf.map |  1 +
>>  3 files changed, 14 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 085e41f9b68e..f9953a8ffcfa 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -6756,6 +6756,17 @@ void *bpf_map__priv(const struct bpf_map *map)
>>         return map ? map->priv : ERR_PTR(-EINVAL);
>>  }
>>
>> +int bpf_map__set_initial_value(struct bpf_map *map,
>> +                              void *data, size_t size)
>
> nit: const void *

ACK.

>> +{
>> +       if (!map->mmaped || map->libbpf_type =3D=3D LIBBPF_MAP_KCONFIG ||
>> +           size !=3D map->def.value_size)
>> +               return -EINVAL;
>> +
>
> How about also checking that bpf_map wasn't yet created? Checking
> map->fd >=3D 0 should be enough.


Yup, makes sense.

>> +       memcpy(map->mmaped, data, size);
>> +       return 0;
>> +}
>> +
>>  bool bpf_map__is_offload_neutral(const struct bpf_map *map)
>>  {
>>         return map->def.type =3D=3D BPF_MAP_TYPE_PERF_EVENT_ARRAY;
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index d38d7a629417..ee30ed487221 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -407,6 +407,8 @@ typedef void (*bpf_map_clear_priv_t)(struct bpf_map =
*, void *);
>>  LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
>>                                  bpf_map_clear_priv_t clear_priv);
>>  LIBBPF_API void *bpf_map__priv(const struct bpf_map *map);
>> +LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
>> +                                         void *data, size_t size);
>>  LIBBPF_API int bpf_map__reuse_fd(struct bpf_map *map, int fd);
>>  LIBBPF_API int bpf_map__resize(struct bpf_map *map, __u32 max_entries);
>>  LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 5129283c0284..f46873b9fe5e 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -243,5 +243,6 @@ LIBBPF_0.0.8 {
>>                 bpf_link__pin;
>>                 bpf_link__pin_path;
>>                 bpf_link__unpin;
>> +               bpf_map__set_initial_value;
>>                 bpf_program__set_attach_target;
>>  } LIBBPF_0.0.7;
>> --
>> 2.26.0
>>

