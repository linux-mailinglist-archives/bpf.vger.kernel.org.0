Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B996A124558
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 12:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfLRLIm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 06:08:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37018 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbfLRLIl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 06:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576667321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9N6bug9fqhjHQqfRWIzS1Bxa22v0COyCASVHwhVdOk=;
        b=CoJPhPdb6svHWPuOW5RxGA8likt+O2zzms89qF9PtQ0sEk1zkAlO5u9GnsnhGj7DsWEAB2
        0OoFRtdU15CssKLCXdS4NQT8Yc23myLlv+E0ixTE/Ix//0lV/H4ObV8+Pjw3QV5zP9f22f
        E6QOyhkOi/L+w41py2EQE7vtyjyF/YU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-Fom5qzOKPu6vd3Tp0FDPrQ-1; Wed, 18 Dec 2019 06:08:38 -0500
X-MC-Unique: Fom5qzOKPu6vd3Tp0FDPrQ-1
Received: by mail-lj1-f197.google.com with SMTP id t11so577478ljo.13
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 03:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=t9N6bug9fqhjHQqfRWIzS1Bxa22v0COyCASVHwhVdOk=;
        b=hP2axXsUcxs0nKfOzgQbbsNNUmhC9Iysx5CGEFbdTIAO6HIDWADEm5xv1RRfCOoM7N
         GFuUChQXiGl1UKgy1JzlMSWR+xws/6JuZWE5l4hFddA3jr8aqgPBO1iFIkp3e4mIaV+v
         wG9HJH7s3XBnu/V2RJ7UoNfjupIjHNaSDfc0TvkfOqFa0x6C+YO9eq4V/jWyw58r+ycG
         3REWf7jBY1kpWaHfM7NymUCE8GmT4+HfZUhrmkMzv4BBRZ6cQmtna5Y8zPxl+B5c8PjB
         S7h0uJrdg/Jbkogdmfh9xZlWSH4iZT1yZqqcRrQIhQBSska305TTCv0FArEv6+2u73nT
         cutg==
X-Gm-Message-State: APjAAAVslg2kwN1mEstmGaueYZ5bHR91YUpqHKO1z50ovOarfo4S2Aeo
        dcSKVg/tBJQ1QVmaL17CpNykUXQnGHWmrHBquak0yRSTbAl8sWYuwrVWvW2v0r0zYJhEtZ00ogG
        UJNCqd8PBkEoK
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr1236315ljj.206.1576667317417;
        Wed, 18 Dec 2019 03:08:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxvL/f+gpRBh2p4/BeptEEvf2ziXJJxLYL3xp5NKCseiQY2pF7SSqzs9T/8bffLHhb2+PPCEw==
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr1236295ljj.206.1576667317216;
        Wed, 18 Dec 2019 03:08:37 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m15sm951499ljj.16.2019.12.18.03.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:08:36 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8A764180969; Wed, 18 Dec 2019 12:08:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Yonghong Song <yhs@fb.com>, lkft-triage@lists.linaro.org,
        Leo Yan <leo.yan@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
Subject: Re: [PATCH bpf-next v2] libbpf: Print hint about ulimit when getting permission denied error
In-Reply-To: <CA+G9fYssgDcBkiNGSV7BmjE4Tj1j1_fa4VTJFv3N=2FHzewQLg@mail.gmail.com>
References: <20191216181204.724953-1-toke@redhat.com> <CA+G9fYssgDcBkiNGSV7BmjE4Tj1j1_fa4VTJFv3N=2FHzewQLg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Dec 2019 12:08:34 +0100
Message-ID: <878sn97ux9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Naresh Kamboju <naresh.kamboju@linaro.org> writes:

> On Tue, 17 Dec 2019 at 00:00, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index a2cc7313763a..3fe42d6b0c2f 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -41,6 +41,7 @@
>>  #include <sys/types.h>
>>  #include <sys/vfs.h>
>>  #include <sys/utsname.h>
>> +#include <sys/resource.h>
>>  #include <tools/libc_compat.h>
>>  #include <libelf.h>
>>  #include <gelf.h>
>> @@ -100,6 +101,32 @@ void libbpf_print(enum libbpf_print_level level, co=
nst char *format, ...)
>>         va_end(args);
>>  }
>>
>> +static void pr_perm_msg(int err)
>> +{
>> +       struct rlimit limit;
>> +       char buf[100];
>> +
>> +       if (err !=3D -EPERM || geteuid() !=3D 0)
>> +               return;
>> +
>> +       err =3D getrlimit(RLIMIT_MEMLOCK, &limit);
>> +       if (err)
>> +               return;
>> +
>> +       if (limit.rlim_cur =3D=3D RLIM_INFINITY)
>> +               return;
>> +
>> +       if (limit.rlim_cur < 1024)
>> +               snprintf(buf, sizeof(buf), "%lu bytes", limit.rlim_cur);
>
>  libbpf.c: In function 'pr_perm_msg':
>  libbpf.c:120:33: error: format '%lu' expects argument of type 'long
> unsigned int', but argument 4 has type 'rlim_t {aka long long unsigned
> int}' [-Werror=3Dformat=3D]
>     snprintf(buf, sizeof(buf), "%lu bytes", limit.rlim_cur);
>                                 ~~^         ~~~~~~~~~~~~~~
>                                 %llu
>

Ah, guess this needs PRIu64. Will send a follow-up, thanks for the
report :)

-Toke

