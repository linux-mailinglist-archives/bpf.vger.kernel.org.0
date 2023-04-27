Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6831B6EFEF3
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 03:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbjD0BZW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 21:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbjD0BZV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 21:25:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9253AA1
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 18:25:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-956eacbe651so1440712566b.3
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 18:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682558718; x=1685150718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgWNVDhXQKQMtkPENBPEdg1ZbFl1MI/YY7cFIXCeUAc=;
        b=ARWJ9LQ/crQ4XNhAGxkjMLJjR6W4tb8jg7ctSL42fmVLWcFFskVnoFtF7zAG988p0/
         Dmi19mBbPvF2/V3OXsNwXxYDuzSClwBfc2exOSlOidiRwb4mjfJ6HT1q2JQerFAZUL6Z
         FQdRNi1jKKvX7LpcxpAk5Z24ueZtS5zC1SGa4h3e3Gyhpy2FbRM+aNsXkgj3tEOp1Sja
         MJcy4Fbf4WvY3799gbbAh7+APK8uDplSaEITV0doLW4J1prQ1qUNe9ZBFXrhHOaHK0uQ
         1jk20DAk91YUxaAI+ZEZVxF0hha5F5Qv+XQjNTwpPPa3jKi161cWeslDGMkEdleKTTsL
         kipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682558718; x=1685150718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgWNVDhXQKQMtkPENBPEdg1ZbFl1MI/YY7cFIXCeUAc=;
        b=FXuZe7EwUZ8cxtJaBZGCXLpBUtrjJvfiCr9oYI5m8blHPNR6lHdiGTwh3XkNkd/eQS
         eOGw/2NBV7qD8+eLKXqwNRU/IpxA3DKCfN2tpiPggFE4KQyST8vLfMERHCcMfvAE5bKQ
         s4y7ZSh3Sa5XvV20ExZnMygtgLwK3UJ4En2Z8hQmFctaG0zAsWZdKcmPaSUs6kBjR7Fl
         jkeKk3fGB8QK8UZg3/4FDY/ufhe5n+FBdTEyjCCzSS9TfQnP9BIIlgUP7GeqhgNpmbVa
         j+BfluS3dtuTNy2jg8afG8NWlqdJplP/Yc2uUtXtd49SpCPwfe+ayFeIahYCzCST2Bx8
         Z+AQ==
X-Gm-Message-State: AAQBX9cid0sWwGHrSeNcBVXuizipa8apcTBnMuUpwae2HZPyAZgY5Mqn
        v4+F4ARA4E1AbS1w/Ygv1jZqgmBT2Kb8Jh9Jn5o=
X-Google-Smtp-Source: AKy350Yn037Ri7SE4TDJuee0J/8ZTYoyhAybIwI6nV/W98KYRbyFZoCD06RmyW6jZaLMmQAA8SdvwQingpM/NvqUhWU=
X-Received: by 2002:a17:906:5dd2:b0:946:2fa6:3b85 with SMTP id
 p18-20020a1709065dd200b009462fa63b85mr17080108ejv.36.1682558718387; Wed, 26
 Apr 2023 18:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230426155357.4158846-1-sdf@google.com>
In-Reply-To: <20230426155357.4158846-1-sdf@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 18:25:06 -0700
Message-ID: <CAEf4BzatobESuMtP=ndHuf+imtX1ovM-4+cnV9c=UdsC=teZBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Make bpf_helper_defs.h c++ friendly
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Peng Wei <pengweiprc@google.com>, Yonghong Song <yhs@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 8:54=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> From: Peng Wei <pengweiprc@google.com>
>
> Compiling C++ BPF programs with existing bpf_helper_defs.h is not
> possible due to stricter C++ type conversions. C++ complains
> about (void *) type conversions:
>
> $ clang++ --include linux/types.h ./tools/lib/bpf/bpf_helper_defs.h
>
> bpf_helper_defs.h:57:67: error: invalid conversion from =E2=80=98void*=E2=
=80=99 to =E2=80=98void* (*)(void*, const void*)=E2=80=99 [-fpermissive]

Can you use -fpermissive instead? As Yonghong said, C++ is not really
supported, so pretending we do will just cause more confusion and
issues down the line.

BTW, can you elaborate more on v4 vs v6 code reuse (or what was it)? I
wonder if there is something that would stay within C domain that
could be done?

>    57 | static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
=3D (void *) 1;
>       |                                                                  =
 ^~~~~~~~~~
>       |                                                                  =
 |
>       |                                                                  =
 void*
>
> Extend bpf_doc.py to use proper function type instead of void.
>
> Before:
> static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D (void=
 *) 1;
>
> After:
> static void *(*bpf_map_lookup_elem)(void *map, const void *key) =3D (void=
 *(*)(void *map, const void *key)) 1;
>
> v2:
> - add clang++ invocation example (Yonghong)
>
> Cc: Yonghong Song <yhs@meta.com>
> Signed-off-by: Peng Wei <pengweiprc@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  scripts/bpf_doc.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index eaae2ce78381..fa21137a90e7 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -827,6 +827,9 @@ COMMANDS
>                  print(' *{}{}'.format(' \t' if line else '', line))
>
>          print(' */')
> +        fptr_type =3D '%s%s(*)(' % (
> +            self.map_type(proto['ret_type']),
> +            ((' ' + proto['ret_star']) if proto['ret_star'] else ''))
>          print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
>                                        proto['ret_star'], proto['name']),=
 end=3D'')
>          comma =3D ''
> @@ -845,8 +848,10 @@ COMMANDS
>                  one_arg +=3D '{}'.format(n)
>              comma =3D ', '
>              print(one_arg, end=3D'')
> +            fptr_type +=3D one_arg
>
> -        print(') =3D (void *) %d;' % helper.enum_val)
> +        fptr_type +=3D ')'
> +        print(') =3D (%s) %d;' % (fptr_type, helper.enum_val))
>          print('')
>
>  ########################################################################=
#######
> --
> 2.40.1.495.gc816e09b53d-goog
>
