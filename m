Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A806B6D84F0
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjDER3X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjDER3S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:29:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4626E87
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:29:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id fi11so19439016edb.10
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680715747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccLL8M+0hPzYrg5qhosh7fO169Jvu+ep5EJTY2rQgxw=;
        b=P8aQurvtozunUg89IZPAfiGjzEWdfmpcjDwaLrqcWvF/WofumD6YEeAQDSkDJN1KRA
         lmR6fFRnz0gD3FiYK8wd41XCiv5h/24xK9nPgDcB7/g1BZL8fEYHINFTpEhfED5Ej2u3
         gnpgwh7U5xkPtKxAylOvUhc2b85qmGdJ1N2sgOaTgkJ4FNrV80dCjmVIzqJX3aT2CfW9
         46ZR004sH97dLSTiV/2LhXsRsXE/twieP3c2v88OJr+VczoHoeGrFyicIGvax6JOPUxb
         +O8QQUTIBD4CKl5OZjpwbMNxtnDTI6XN0GEUCcnHUYyVPAzA9AhcO6m0v5xqNXb2KBQ6
         moHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccLL8M+0hPzYrg5qhosh7fO169Jvu+ep5EJTY2rQgxw=;
        b=PAHrdc+hqwrwZbIB/ghJlYztSjBz9Y0JjmKEy6NqiT0Soo3M9i8jSKDebAbxV5pa/n
         7B2rc1c3tavrnYLZgL0CYnnwXfmsnd20Zl8K2Td11bi9mYqRx/9VIM5hMElXECJw6Obo
         FxSAQVDHHVgAjsmSseYBkzhfbAU8ExRsNwQsiZTE73e10vmOfAJGIktmll5BzH7iUxnI
         W6ERJ1l/5XFelIXSyiGeEKs+TguqugjtR/ijDKnCYeEPOIXonR+eGwP031zjL9pKIVfc
         vl37azLvLJInW8vD2rZkBRMr0FS8QoKnAI72QKgLz9P9n/u8W9MrsN0p1QBl5sBMj/mG
         HM6Q==
X-Gm-Message-State: AAQBX9fZYK7iQ+p0uZ/b694NHJwhQ3RNQJSP5MX+mKlRXoftyPw3U8Ke
        rXUuYAeVq1ywHV4m7Sx97BaI+2KcB0ys1Kiykpwz0Q==
X-Google-Smtp-Source: AKy350arGw5VqovSMQHoUWc+dteIxIgt11PMwY17PpD6nYcVkOgHJTX6Q2DaWX372cYHEDRZZ7l1a9ODGXNXaKXUp2g=
X-Received: by 2002:a17:906:dcf:b0:932:6a2:ba19 with SMTP id
 p15-20020a1709060dcf00b0093206a2ba19mr1983960eji.14.1680715746762; Wed, 05
 Apr 2023 10:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-14-andrii@kernel.org>
In-Reply-To: <20230404043659.2282536-14-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 5 Apr 2023 18:28:55 +0100
Message-ID: <CAN+4W8gxKYN=hpSgZ7UWuEBpx_XTHEgsNhhf+znQgnCzM6K5XQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/19] bpf: simplify internal verifier log interface
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Simplify internal verifier log API down to bpf_vlog_init() and
> bpf_vlog_finalize(). The former handles input arguments validation in
> one place and makes it easier to change it. The latter subsumes -ENOSPC
> (truncation) and -EFAULT handling and simplifies both caller's code
> (bpf_check() and btf_parse()).
>
> For btf_parse(), this patch also makes sure that verifier log
> finalization happens even if there is some error condition during BTF
> verification process prior to normal finalization step.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 1e974383f0e6..9aeac68ae7ea 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5504,16 +5504,30 @@ static int btf_check_type_tags(struct btf_verifie=
r_env *env,
>         return 0;
>  }
>
> +static int finalize_log(struct bpf_verifier_log *log, bpfptr_t uattr, u3=
2 uattr_size)
> +{
> +       u32 log_size_actual;
> +       int err;
> +
> +       err =3D bpf_vlog_finalize(log, &log_size_actual);
> +
> +       if (uattr_size >=3D offsetofend(union bpf_attr, btf_log_size_actu=
al) &&
> +           copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, btf_log=
_size_actual),
> +                                 &log_size_actual, sizeof(log_size_actua=
l)))

Why not share this with the verifier as well?
