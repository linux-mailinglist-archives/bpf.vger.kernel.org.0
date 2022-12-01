Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD1663EF31
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 12:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiLALRT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 06:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLALQp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 06:16:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8610DA85D5
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 03:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669892980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qU2TuWd+0O3otFPfr6vlmRP+YxZG5HKjhLnoTy3E3L4=;
        b=PFaCHR6P8MUPeRx9uiofgUrCRrcGRwMTvF895CAhct8UPQz+z6h01irWI5OranRghRmvNh
        PBazbnDprTGIyD56gji+o6PMhB/VPnkEVWn0EFWXICeIvWUkhtYMIrAHmCwOLQA67CaijI
        o8pDWgpS5+BxgTXDovDF58RYw5od7jk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-QEd1yfkXNha3nEpVzq2VOg-1; Thu, 01 Dec 2022 06:09:40 -0500
X-MC-Unique: QEd1yfkXNha3nEpVzq2VOg-1
Received: by mail-ed1-f70.google.com with SMTP id b6-20020a056402278600b0046bb01fb9c0so699059ede.3
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 03:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qU2TuWd+0O3otFPfr6vlmRP+YxZG5HKjhLnoTy3E3L4=;
        b=swxfsQsd2aQj1DFKoUXTvIOLeJpc5G9a3y87JZp57AYgTCF6jEwb8k2UXqgkdyl+hy
         05ZLiz9NKZFDwh+Mnna43wC9mjr0JiC5cghfMaZK80lL+uVn+b2UUgRaak59j6wFa1E8
         +nL7fySZhpD8Inou9JRTjPCX4qCFX+8nXAPPT/axNxjlKj3SueqJfjCCqZcuVEASpvpt
         z7afqC7iPagJ2QSYh5yDpC/d+O5UelzSGp5sawEecdzPfzorBqHNUcUNzn21WXQJcfCX
         aQ0ADKdpe5D5oXGZGrBZpNGTVvc5KS4lcHUJ3l2VeujYjQ+TA0yJn2mfI73kfty4Zh0s
         q+rQ==
X-Gm-Message-State: ANoB5plyWtBfYHx17gio5iAxQSeExacI8ZyemaHjnULRA1AXt5Zvpn9c
        +2eJz3i9vXuEDxqpGF3sWnBVsMvHfrYOhyfu8CY2JZ6LRI5PB0ZW54yQCaFTI87VcJdCp6fROuc
        SyfmWTOMSMIQ9
X-Received: by 2002:a17:907:76cb:b0:7c0:870b:3dda with SMTP id kf11-20020a17090776cb00b007c0870b3ddamr10519330ejc.676.1669892976158;
        Thu, 01 Dec 2022 03:09:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7R9xh8S7sMRLkqaPcdUYpWRxgVpHJKcuACb499YCJZddWDmO8d5RaNAO6dt37hbP3eIw6HsA==
X-Received: by 2002:a17:907:76cb:b0:7c0:870b:3dda with SMTP id kf11-20020a17090776cb00b007c0870b3ddamr10519167ejc.676.1669892973636;
        Thu, 01 Dec 2022 03:09:33 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0079dbf06d558sm1629787ejf.184.2022.12.01.03.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:09:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 977FF80AFD0; Thu,  1 Dec 2022 12:09:32 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jiri Benc <jbenc@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add local definition of enum
 nf_nat_manip_type to bpf_nf test
In-Reply-To: <CAEf4Bzb+Vg0QGb40f2z4UrhNhzcH6sEvzoVjvvM=uVHXFRchpw@mail.gmail.com>
References: <20221130144240.603803-1-toke@redhat.com>
 <20221130144240.603803-2-toke@redhat.com>
 <CAEf4BzaXbNkx85pBAB=gSshQvdGySkuZzw+HJ9KmDDA1JuheNQ@mail.gmail.com>
 <CAEf4Bzb+Vg0QGb40f2z4UrhNhzcH6sEvzoVjvvM=uVHXFRchpw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 01 Dec 2022 12:09:32 +0100
Message-ID: <87cz93xtw3.fsf@toke.dk>
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

> On Wed, Nov 30, 2022 at 5:18 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Wed, Nov 30, 2022 at 6:42 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>> >
>> > The bpf_nf selftest calls the bpf_ct_set_nat_info() kfunc, which takes=
 a
>> > parameter of type enum nf_nat_manip_type. However, if the nf_nat code =
is
>> > compiled as a module, that enum is not defined in vmlinux BTF, and
>> > compilation of the selftest fails.
>> >
>> > A previous patch suggested just hard-coding the enum values:
>> >
>> > https://lore.kernel.org/r/tencent_4C0B445E0305A18FACA04B4A959B57835107=
@qq.com
>> >
>> > However, this doesn't work as the compiler then complains about an
>> > incomplete type definition in the function prototype. Instead, just ad=
d a
>> > local definition of the enum to the selftest code.
>> >
>> > Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info=
 kfunc")
>> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> > ---
>> >  tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/t=
esting/selftests/bpf/progs/test_bpf_nf.c
>> > index 227e85e85dda..6350d11ec6f6 100644
>> > --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> > +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> > @@ -43,6 +43,11 @@ struct bpf_ct_opts___local {
>> >         u8 reserved[3];
>> >  } __attribute__((preserve_access_index));
>> >
>> > +enum nf_nat_manip_type {
>> > +       NF_NAT_MANIP_SRC,
>> > +       NF_NAT_MANIP_DST
>> > +};
>> > +
>>
>> and enum redefinition error if vmlinux.h already defines it?...
>
>
> ... which is apparently proven by our CI already:
>
>   [0] https://github.com/kernel-patches/bpf/actions/runs/3584446939/jobs/=
6031141757

Doh *facepalm*! Will fix...

-Toke

