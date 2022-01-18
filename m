Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F408C492B00
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 17:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347163AbiARQTB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 11:19:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244086AbiARQSB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Jan 2022 11:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642522680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ILcJ4qL/uWT4PowdfPjtQ0Qex5Vhpd6jaPfQ4SZkE+U=;
        b=ZIRYNQ0tlt7gNN76VITEc708QxTbtcRUc5oa1Futt/IDNiXQF8jeeCfxFWh96q1eV1q41L
        H7B5Fi9zQOwnL5jqhCyqETcUM5LIDEPP+GvbPrQjAKLBcUoZQURePtv7AoIOnPmw9B61Ml
        zFA60/Z4uQaCZXPk30S+v0hYPXteHBw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-tiodbs4TOx6j4ttpFOOdTQ-1; Tue, 18 Jan 2022 11:17:59 -0500
X-MC-Unique: tiodbs4TOx6j4ttpFOOdTQ-1
Received: by mail-ed1-f70.google.com with SMTP id o10-20020a056402438a00b00403212b6b1aso4371375edc.13
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 08:17:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ILcJ4qL/uWT4PowdfPjtQ0Qex5Vhpd6jaPfQ4SZkE+U=;
        b=OJIh/OQsPuOS2haX2U7lNMyaAbeItUeh+s1oZ9qlcAH0V4PiuWE992DMQeIHSgUwm8
         iBgcH74lkGgXfmKZlYUNnctP7iJrolmg27UkgRxgQuchPLzNOTUrt+AqXvKayKS4d+tr
         dsnGR2pITzjfAGtvSyA8CcQlsH1dQlH9ZnBVMlLL7dyL4lTNE7cxC8D5WZa0k4XCpxmj
         Nmm5zvD2QhDXDmMKT2r8JMCsfjrum7nk++JszjVkOjmeVm1pCOz1uwWQvLbS/V9GU0Fo
         sfKggWCO8rQB3zwC2DzzMMsQkKNc1a3c+f1P3BSbS5JSkp1nQFkbrmzCuqgukXxcncVq
         nZdQ==
X-Gm-Message-State: AOAM532+XOJgtczdRJhnQyqn/qjcdRlZmV6OZCYaLUGlGJTRX0zbicRO
        kWWTzCo1w3eTMGArlTf+NzPNYTmocAZ841wBvc5F9fF50OSNopNi34GMZX4WmN3tj+qnatVndED
        BmOfO42Ux+Enf
X-Received: by 2002:a17:907:6eac:: with SMTP id sh44mr22149170ejc.179.1642522678176;
        Tue, 18 Jan 2022 08:17:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmBDSd7zHZAwsysU6zQVKYKbM8uqKeqQsYa+nNfSrUnmINvlE2UhCCPlJxSQhXYuFQpzO9oA==
X-Received: by 2002:a17:907:6eac:: with SMTP id sh44mr22149132ejc.179.1642522677712;
        Tue, 18 Jan 2022 08:17:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j4sm69940edk.64.2022.01.18.08.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 08:17:57 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4D5261804EC; Tue, 18 Jan 2022 17:17:56 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf] libbpf: define BTF_KIND_* constants in btf.h to
 avoid compilation errors
In-Reply-To: <YebeQKsIDDaBMtpW@kernel.org>
References: <20220118141327.34231-1-toke@redhat.com>
 <YebeQKsIDDaBMtpW@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 18 Jan 2022 17:17:56 +0100
Message-ID: <87k0ex81cb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> Em Tue, Jan 18, 2022 at 03:13:27PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n escreveu:
>> The btf.h header included with libbpf contains inline helper functions to
>> check for various BTF kinds. These helpers directly reference the
>> BTF_KIND_* constants defined in the kernel header, and because the header
>> file is included in user applications, this happens in the user applicat=
ion
>> compile units.
>>=20
>> This presents a problem if a user application is compiled on a system wi=
th
>> older kernel headers because the constants are not available. To avoid
>> this, add #defines of the constants directly in btf.h before using them.
>>=20
>> Since the kernel header moved to an enum for BTF_KIND_*, the #defines can
>> shadow the enum values without any errors, so we only need #ifndef guards
>> for the constants that predates the conversion to enum. We group these so
>> there's only one guard for groups of values that were added together.
>>=20
>>   [0] Closes: https://github.com/libbpf/libbpf/issues/436
>
> The coexistence of enums with the defines (in turn #ifndef guarded) as
> something I hadn't considered, clever.

Me neither - that bit was Andrii's idea :)

> Should fix lots of build errors in my test containers :-)
>
> FWIW:
>
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks!

-Toke

