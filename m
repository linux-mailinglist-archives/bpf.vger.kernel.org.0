Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 535A7CAAD3
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2019 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390338AbfJCROb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Oct 2019 13:14:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25055 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731738AbfJCQ1I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Oct 2019 12:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570120027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hl97RRcZcrIYJupRDULXM2IOdbeRQMpGH096RnGRTkc=;
        b=A/CBNCoJQ0dx+jVF09zgvSjA0bicNyQU7e9qW5+u14TdxH0p9DRMiw6dTcyPU9lOewNqs3
        eC0+jwmhbnBeKQL269SK/gWhhkdVPSN0Qd/iPohwF9LnGkoQa3WtDxg0uHpGaptAaErWE+
        8IgfoKR/m4Wx39JgUD7VeTCRiVGMzPQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146--36JOMzxP6aBI8OlHfX-Bg-1; Thu, 03 Oct 2019 12:27:03 -0400
Received: by mail-lf1-f70.google.com with SMTP id r3so321789lfn.13
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2019 09:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hl97RRcZcrIYJupRDULXM2IOdbeRQMpGH096RnGRTkc=;
        b=ApqGNO9faNaTCpmLFnY9MSYpEsGtnOSybcjWwCToXOtB+EjbNz9Tai7iMpUd+fQGAv
         ImkwWlUOyax1vN0TOw9ih4ppfkn3Y17Y4hh1mitQzvqxg7oDxjw6Jv1kyefssIhxiy+i
         deVCqTtorzNN3lyJ7yaZk+3YDOzFgrcG8jfbLEyeney6DHKBcqrVGrY2U+LNdj15Oy4O
         5D4bom5wXBYN9uCkJ2ztQxle5VYYzs16u6MUhPbGSz1yuNtyfFHEkwoGUcnezQswGGEn
         e4IB+ub1IGJrwIWsdv+V/IomzMGkc5TOFUoPTBnR1kjrxM3Oyt/vHuIVDoS1jwWq4nl6
         wyJQ==
X-Gm-Message-State: APjAAAU0eG5+azSgiKPwQ4/qXy5Gr0PMhih4ALKKCGsyy4YM5MrBkZxL
        8V7vmKThgQIma6RInDwPffeMJ79oApXRXzz4YZiagCNXUo155i6TFUsB75SHvhgYZA1gY89tRTM
        7dnx+vYqr1VKI
X-Received: by 2002:a2e:9d50:: with SMTP id y16mr6545200ljj.70.1570120022258;
        Thu, 03 Oct 2019 09:27:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWiuLcSKoRaVxkebUdfhoE89oH6oA58jgXqlx0RaM08Hae5JDAPB1m+IXJqWcW3kr12KzXiA==
X-Received: by 2002:a2e:9d50:: with SMTP id y16mr6545181ljj.70.1570120022010;
        Thu, 03 Oct 2019 09:27:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id y3sm547356lfh.97.2019.10.03.09.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 09:27:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5EB9C18063D; Thu,  3 Oct 2019 18:27:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 2/7] selftests/bpf: samples/bpf: split off legacy stuff from bpf_helpers.h
In-Reply-To: <CAEf4Bzb7ikPkrxCVMtHK5rS2kdoF_mo5_Bn5U78zKBiYYHS8ig@mail.gmail.com>
References: <20191002215041.1083058-1-andriin@fb.com> <20191002215041.1083058-3-andriin@fb.com> <87k19mqo1z.fsf@toke.dk> <CAEf4Bzb7ikPkrxCVMtHK5rS2kdoF_mo5_Bn5U78zKBiYYHS8ig@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 03 Oct 2019 18:27:00 +0200
Message-ID: <87k19lpzfv.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: -36JOMzxP6aBI8OlHfX-Bg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Oct 3, 2019 at 12:35 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andriin@fb.com> writes:
>>
>> > diff --git a/samples/bpf/map_perf_test_kern.c b/samples/bpf/map_perf_t=
est_kern.c
>> > index 2b2ffb97018b..f47ee513cb7c 100644
>> > --- a/samples/bpf/map_perf_test_kern.c
>> > +++ b/samples/bpf/map_perf_test_kern.c
>> > @@ -9,25 +9,26 @@
>> >  #include <linux/version.h>
>> >  #include <uapi/linux/bpf.h>
>> >  #include "bpf_helpers.h"
>> > +#include "bpf_legacy.h"
>> >
>> >  #define MAX_ENTRIES 1000
>> >  #define MAX_NR_CPUS 1024
>> >
>> > -struct bpf_map_def SEC("maps") hash_map =3D {
>> > +struct bpf_map_def_legacy SEC("maps") hash_map =3D {
>> >       .type =3D BPF_MAP_TYPE_HASH,
>> >       .key_size =3D sizeof(u32),
>> >       .value_size =3D sizeof(long),
>> >       .max_entries =3D MAX_ENTRIES,
>> >  };
>>
>> Why switch these when they're not actually using any of the extra fields
>> in map_def_legacy?
>
> See below, they have to be uniform-sized.
>
>> >
>> > -struct bpf_map_def SEC("maps") lru_hash_map =3D {
>> > +struct bpf_map_def_legacy SEC("maps") lru_hash_map =3D {
>> >       .type =3D BPF_MAP_TYPE_LRU_HASH,
>> >       .key_size =3D sizeof(u32),
>> >       .value_size =3D sizeof(long),
>> >       .max_entries =3D 10000,
>> >  };
>> >
>> > -struct bpf_map_def SEC("maps") nocommon_lru_hash_map =3D {
>> > +struct bpf_map_def_legacy SEC("maps") nocommon_lru_hash_map =3D {
>> >       .type =3D BPF_MAP_TYPE_LRU_HASH,
>> >       .key_size =3D sizeof(u32),
>> >       .value_size =3D sizeof(long),
>> > @@ -35,7 +36,7 @@ struct bpf_map_def SEC("maps") nocommon_lru_hash_map=
 =3D {
>> >       .map_flags =3D BPF_F_NO_COMMON_LRU,
>> >  };
>> >
>> > -struct bpf_map_def SEC("maps") inner_lru_hash_map =3D {
>> > +struct bpf_map_def_legacy SEC("maps") inner_lru_hash_map =3D {
>> >       .type =3D BPF_MAP_TYPE_LRU_HASH,
>> >       .key_size =3D sizeof(u32),
>> >       .value_size =3D sizeof(long),
>> > @@ -44,20 +45,20 @@ struct bpf_map_def SEC("maps") inner_lru_hash_map =
=3D {
>> >       .numa_node =3D 0,
>> >  };
>>
>> Or are you just switching everything because of this one?
>
> Exactly. Another way would be to switch all but this to BTF-based one,
> but I didn't want to make this patch set even bigger, we can always do
> that later

Right, fair enough :)

-Toke

