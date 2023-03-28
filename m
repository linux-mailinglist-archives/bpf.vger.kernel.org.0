Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142756CB3B9
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 04:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjC1CSS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 22:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1CSR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 22:18:17 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC65171F
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 19:18:16 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id m6-20020a4ae846000000b0053b9059edd5so1669035oom.3
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 19:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969895; x=1682561895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU6sSIuB9S3Sm9kGoTeIT1kh1TN1JoX3kB57xAvsDCo=;
        b=eIUY2o2pV49RBR6KOb5rFjsnMjIozJT2CSu65H6Y6ke1CeMDb5xzCuWfxFEpXELbT+
         D/dh/aus0LlBNhI3UJyufsq4rATJ0tOEf/k4wHrAVlnI7wHiS6hkxcrQCDO4gx7HZ7YY
         MNCergHbTfl71TE8Efr2GW2YoWWMKqmBjg0MzcunCVqyW7nWaI4Rt22nc0mK6q2ajJnt
         sajmZZGem6rGjonzBTHYJt0jJ0Qz+CIwTmAE2+pVp98WeECoUMxNAbG7ewSU2Q3l0pLL
         dlswJfe9IxGkp888ezQpspDjb+ctA755aFKwMdN/Cse1piLwomejJvEiT+ikokpSbKL2
         D5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969895; x=1682561895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dU6sSIuB9S3Sm9kGoTeIT1kh1TN1JoX3kB57xAvsDCo=;
        b=H5V46AKYWCfxJ9AeX7m7g2VoGT8d9fWtE4iwC52pUa9zgbZ3TXFFi7WAVDyd1JNfz3
         q0Hr+yTNC/4ZXWmUAv2QlKMeRhGJt8sIPwIII47PNwQzsdGik3UImjMLWCYvi1tbTgiV
         xjzFngK3q7YDsurWG1WdfM4fDNtMGAx0gmZPUa0GWnaZINbV1Jlrb7obU9LTmL3DnCHC
         KkByNnBI7vNrVaDOO/MGO1n+/GbA+JY8dSZLG2VIrxjUAsdP7sXmQxK6EZRntCoFYh6U
         /qqRLQEmFDUu36HTaSMo/GDoAwOHf3IdzQPkRmUThSq2zsQw5UFz/4yINNgp8d8o7E/V
         puqA==
X-Gm-Message-State: AO0yUKWyAvkW79SriY9yRc7uYH7ExAasE63RCDX49+iA1PHmI9vOD5So
        nk/KWpH+VK7myC9KBG2i77b9Qh5eWVMy3GItKafambO+vl1X7Q==
X-Google-Smtp-Source: AK7set/+WE7SCZMccEUTKVAzoxa+msOSTzhQ0vgotE16uwreuCu3pojT5exP6jp8a5i62dLrCd1xU1v4jjnIgy8DNV4=
X-Received: by 2002:a4a:b782:0:b0:534:ed09:a018 with SMTP id
 a2-20020a4ab782000000b00534ed09a018mr4433269oop.1.1679969895401; Mon, 27 Mar
 2023 19:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230328004738.381898-1-eddyz87@gmail.com> <20230328004738.381898-3-eddyz87@gmail.com>
In-Reply-To: <20230328004738.381898-3-eddyz87@gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Mon, 27 Mar 2023 20:18:04 -0600
Message-ID: <CADvTj4ovU+TS9aW=L6EvK5fu-gnU71p8DyiDozc_dAJ4vJtRdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] libbpf: Fix double-free when linker
 processes empty sections
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 27, 2023 at 6:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Double-free error in bpf_linker__free() was reported by James Hilliard.
> The error is caused by miss-use of realloc() in extend_sec().
> The error occurs when two files with empty sections of the same name
> are linked:
> - when first file is processed:
>   - extend_sec() calls realloc(dst->raw_data, dst_align_sz)
>     with dst->raw_data =3D=3D NULL and dst_align_sz =3D=3D 0;
>   - dst->raw_data is set to a special pointer to a memory block of
>     size zero;
> - when second file is processed:
>   - extend_sec() calls realloc(dst->raw_data, dst_align_sz)
>     with dst->raw_data =3D=3D <special pointer> and dst_align_sz =3D=3D 0=
;
>   - realloc() "frees" dst->raw_data special pointer and returns NULL;
>   - extend_sec() exits with -ENOMEM, and the old dst->raw_data value
>     is preserved (it is now invalid);
>   - eventually, bpf_linker__free() attempts to free dst->raw_data again.
>
> This patch fixes the bug by avoiding -ENOMEM exit for dst_align_sz =3D=3D=
 0.
> The fix was suggested by Andrii Nakryiko <andrii.nakryiko@gmail.com>.
>
> Reported-by: James Hilliard <james.hilliard1@gmail.com>
> Link: https://lore.kernel.org/bpf/CADvTj4o7ZWUikKwNTwFq0O_AaX+46t_+Ca9gvW=
MYdWdRtTGeHQ@mail.gmail.com/
Tested-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/linker.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index d7069780984a..5ced96d99f8c 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -1115,7 +1115,19 @@ static int extend_sec(struct bpf_linker *linker, s=
truct dst_sec *dst, struct src
>
>         if (src->shdr->sh_type !=3D SHT_NOBITS) {
>                 tmp =3D realloc(dst->raw_data, dst_final_sz);
> -               if (!tmp)
> +               /* If dst_align_sz =3D=3D 0, realloc() behaves in a speci=
al way:
> +                * 1. When dst->raw_data is NULL it returns:
> +                *    "either NULL or a pointer suitable to be passed to =
free()" [1].
> +                * 2. When dst->raw_data is not-NULL it frees dst->raw_da=
ta and returns NULL,
> +                *    thus invalidating any "pointer suitable to be passe=
d to free()" obtained
> +                *    at step (1).
> +                *
> +                * The dst_align_sz > 0 check avoids error exit after (2)=
, otherwise
> +                * dst->raw_data would be freed again in bpf_linker__free=
().
> +                *
> +                * [1] man 3 realloc
> +                */
> +               if (!tmp && dst_align_sz > 0)
>                         return -ENOMEM;
>                 dst->raw_data =3D tmp;
>
> --
> 2.40.0
>
