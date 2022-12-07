Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07950646121
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 19:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiLGSb6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 13:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGSbt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 13:31:49 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE5A6E567;
        Wed,  7 Dec 2022 10:31:48 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n20so16174925ejh.0;
        Wed, 07 Dec 2022 10:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNms7Hi4w1RYlFMn8tQ29mfpUPBacg1jiG+VyuPjD8I=;
        b=Mdm4YR7dpQnvJdWvX0qiSEPorThhnrBexUuWZP88nDlJgrNGQi7wXNMdIMj96niLo8
         hNqrowKAmOY8/CnyRQPbwIFTRPpq1ekqIQv2tn2Sdpzg67jEW5FqK4QFjNCJNEPA1C6K
         QtXWnv7wcr4x5p8ToOZDb4PK6k/EDKpCkvIToky9JaOKmOYM55pW0JBMkSDsJLZHs3PM
         Fu/h/FhxH8Rzf3Y7oAbVtlIOhJT+qJAZQ4WzrUlQlHID5QzrKs1zFO3hF+YGtT7N/IJZ
         azVRiTdXugfjPUR7QkOQN9ryDwns8HDW5TeAhOopqA1D0NFXfmsa62NnC87mQoXRYIEv
         Ldyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNms7Hi4w1RYlFMn8tQ29mfpUPBacg1jiG+VyuPjD8I=;
        b=RLl/Y6UPgjMxo1oJhBggVsxh0WL1BJJCknIHzLZzVxCrmkbrmwrWBkZ1iqfOcEAH9g
         /4kEkTO1cyS7lbSD3NRxBhGwZwVwZWyXjyDxwICaij0e48jsBuKcuMTp2TeNW9/IENuQ
         3DgZbWe8PwlMsdEHsXxcCWiLNUl6uxgky2aHdKbZLnoGDUeRY6B66bHD9dJ1vufMbEp0
         5iRduR3cew4jXbXDjYxniAfptG9rcVhAWFG9/kYPUa6xyTRdObHM56NVH05/7k+jvvtb
         YN+yHrrCjPHLaw+Gv9VaobUOcLqiVv61a0nSI34kh9G5/kixScyizYSCEHcuIORdd+aS
         9X4A==
X-Gm-Message-State: ANoB5plIlFuwBdopMHK2nBtw9KAscKimRPMZJcW3YNNafrB48zyHe4Ed
        pETGzygkbMZ8Zc5W64f2hT1KiMNXpwSZWSvqZlY=
X-Google-Smtp-Source: AA0mqf7PiTvOMdup8c6tLZlJguE1SyMAw51mfWFNj75ihz/N/FvtvIw8f0GxRE8/GS68owj7T/wB73KEcjm1ocZmjlA=
X-Received: by 2002:a17:906:68a:b0:78d:3188:9116 with SMTP id
 u10-20020a170906068a00b0078d31889116mr78551225ejb.176.1670437906724; Wed, 07
 Dec 2022 10:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20221203093740.218935-1-liuxin350@huawei.com> <6ac9f767-e7f5-6603-6234-97126ea22005@iogearbox.net>
 <CAEf4BzaC6hhNzKkzFa+s4bws7APWj-Nk8Uup+3J6avCXnMFziA@mail.gmail.com> <660fd781-2d86-9d99-2851-127d6b4d4595@iogearbox.net>
In-Reply-To: <660fd781-2d86-9d99-2851-127d6b4d4595@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Dec 2022 10:31:34 -0800
Message-ID: <CAEf4BzYV=tCDMOO8xYwNgpogyEo6dbfnAHyYKnf59rUeG5TNSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Optimized return value in
 libbpf_strerror when errno is libbpf errno
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Xin Liu <liuxin350@huawei.com>, andrii@kernel.org, ast@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 7, 2022 at 1:09 AM Daniel Borkmann <daniel@iogearbox.net> wrote=
:
>
> On 12/7/22 1:00 AM, Andrii Nakryiko wrote:
> > On Mon, Dec 5, 2022 at 1:11 PM Daniel Borkmann <daniel@iogearbox.net> w=
rote:
> >>
> >> On 12/3/22 10:37 AM, Xin Liu wrote:
> >>> This is a small improvement in libbpf_strerror. When libbpf_strerror
> >>> is used to obtain the system error description, if the length of the
> >>> buf is insufficient, libbpf_sterror returns ERANGE and sets errno to
> >>> ERANGE.
> >>>
> >>> However, this processing is not performed when the error code
> >>> customized by libbpf is obtained. Make some minor improvements here,
> >>> return -ERANGE and set errno to ERANGE when buf is not enough for
> >>> custom description.
> >>>
> >>> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> >>> ---
> >>>    tools/lib/bpf/libbpf_errno.c | 6 ++++++
> >>>    1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errn=
o.c
> >>> index 96f67a772a1b..48ce7d5b5bf9 100644
> >>> --- a/tools/lib/bpf/libbpf_errno.c
> >>> +++ b/tools/lib/bpf/libbpf_errno.c
> >>> @@ -54,10 +54,16 @@ int libbpf_strerror(int err, char *buf, size_t si=
ze)
> >>>
> >>>        if (err < __LIBBPF_ERRNO__END) {
> >>>                const char *msg;
> >>> +             size_t msg_size;
> >>>
> >>>                msg =3D libbpf_strerror_table[ERRNO_OFFSET(err)];
> >>>                snprintf(buf, size, "%s", msg);
> >>>                buf[size - 1] =3D '\0';
> >>> +
> >>> +             msg_size =3D strlen(msg);
> >>> +             if (msg_size >=3D size)
> >>> +                     return libbpf_err(-ERANGE);
> >>
> >> Given this is related to libbpf_strerror_table[] where the error strin=
gs are known
> >> lets do compile-time error instead. All callers should pass in a buffe=
r of STRERR_BUFSIZE
> >> size in libbpf.
> >
> > That sounds a bit too pessimistic?.. If the actual error message fits
> > in the buffer, why return -ERANGE just because theoretically some
> > error descriptions might fit?
> >
> > But I don't think we need to calculate strlen(). snprintf above
> > returns the number of bytes required to print a full string, even if
> > it was truncated. So just comparing snprintf's result to size should
> > be enough.
>
> I meant sth like below. For example if we were to shrink STRERR_BUFSIZE d=
own
> to 32 for testing, you'd then get:

Sure, but I'm not sure why do we need to do this? Array of pointers to
string will overall use less memory, as each string will take as much
space as needed and no more.

I guess I'm missing which problem you are trying to solve. I believe
Xin was addressing a concern of extern (to libbpf) callers not getting
-ERANGE in cases when they provide too small a buffer, which is just a
simple snprintf() use adjustment to be a proper fix.

>
> # make libbpf_errno.o
> gcc -g -O2 -std=3Dgnu89 -Wbad-function-cast -Wdeclaration-after-statement=
 -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissin=
g-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -W=
packed -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum=
 -Wundef -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3D3 -W=
shadow -Wno-switch-enum -Werror -Wall -I. -I/home/darkstar/trees/bpf-next/t=
ools/include -I/home/darkstar/trees/bpf-next/tools/include/uapi -fvisibilit=
y=3Dhidden -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64    -c -o libbpf_e=
rrno.o libbpf_errno.c
> libbpf_errno.c:27:31: error: initializer-string for array of chars is too=
 long [-Werror]
>     27 |  [ERRCODE_OFFSET(KVERSION)] =3D "'version' section incorrect or =
lost",
>        |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> libbpf_errno.c:27:31: note: (near initialization for =E2=80=98libbpf_stre=
rror_table[2]=E2=80=99)
> libbpf_errno.c:31:29: error: initializer-string for array of chars is too=
 long [-Werror]
>     31 |  [ERRCODE_OFFSET(VERIFY)] =3D "Kernel verifier blocks program lo=
ading",
>        |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
> libbpf_errno.c:31:29: note: (near initialization for =E2=80=98libbpf_stre=
rror_table[7]=E2=80=99)
> libbpf_errno.c:34:31: error: initializer-string for array of chars is too=
 long [-Werror]
>     34 |  [ERRCODE_OFFSET(PROGTYPE)] =3D "Kernel doesn't support this pro=
gram type",
>        |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> libbpf_errno.c:34:31: note: (near initialization for =E2=80=98libbpf_stre=
rror_table[10]=E2=80=99)
> libbpf_errno.c:37:30: error: initializer-string for array of chars is too=
 long [-Werror]
>     37 |  [ERRCODE_OFFSET(NLPARSE)] =3D "Incorrect netlink message parsin=
g",
>        |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> libbpf_errno.c:37:30: note: (near initialization for =E2=80=98libbpf_stre=
rror_table[13]=E2=80=99)
> cc1: all warnings being treated as errors
> make: *** [<builtin>: libbpf_errno.o] Error 1
>
>
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2a82f49ce16f..2e5df1624f79 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -265,8 +265,6 @@ static void pr_perm_msg(int err)
>                 buf);
>   }
>
> -#define STRERR_BUFSIZE  128
> -
>   /* Copied from tools/perf/util/util.h */
>   #ifndef zfree
>   # define zfree(ptr) ({ free(*ptr); *ptr =3D NULL; })
> diff --git a/tools/lib/bpf/libbpf_errno.c b/tools/lib/bpf/libbpf_errno.c
> index 96f67a772a1b..2f03f861b8b6 100644
> --- a/tools/lib/bpf/libbpf_errno.c
> +++ b/tools/lib/bpf/libbpf_errno.c
> @@ -21,7 +21,7 @@
>   #define ERRCODE_OFFSET(c)     ERRNO_OFFSET(LIBBPF_ERRNO__##c)
>   #define NR_ERRNO      (__LIBBPF_ERRNO__END - __LIBBPF_ERRNO__START)
>
> -static const char *libbpf_strerror_table[NR_ERRNO] =3D {
> +static const char libbpf_strerror_table[NR_ERRNO][STRERR_BUFSIZE] =3D {
>         [ERRCODE_OFFSET(LIBELF)]        =3D "Something wrong in libelf",
>         [ERRCODE_OFFSET(FORMAT)]        =3D "BPF object format invalid",
>         [ERRCODE_OFFSET(KVERSION)]      =3D "'version' section incorrect =
or lost",
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 377642ff51fc..d4dc4fe945a6 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -57,6 +57,8 @@
>   #define ELF64_ST_VISIBILITY(o) ((o) & 0x03)
>   #endif
>
> +#define STRERR_BUFSIZE 128
> +
>   #define BTF_INFO_ENC(kind, kind_flag, vlen) \
>         ((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN)=
)
>   #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or=
_type)
