Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D785A58D057
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 00:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244550AbiHHWwo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 18:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244528AbiHHWwg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 18:52:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E561C115;
        Mon,  8 Aug 2022 15:52:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b96so13186374edf.0;
        Mon, 08 Aug 2022 15:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dU6sPoZYBSNt4B9LtuHokgv92EsNlfChjuz4gWlCh3c=;
        b=Exr8JjKVIeUBk4QLNhCoiII5yg41/A8vnhEx4Fc2fGaZ7n1pUJhVU+9lgsCg1XQcCO
         Wo9Eu2FjgNgTbOepoodzti9lYqnPhlSE0zczGqrbhujlOcI+dxS69w1P9VDJuDtrbzhO
         SsQrY+dGcuE/N1OElMRnPwP1MbqGnlNbNKIptPM2dnCdVCjNUGlf4cLrnNQ2HvJpByw4
         hTgvDQ07a6xelXdLS8323V7ibmh8GOH9R+fJe29ZXqhiFpYAAUr9HI75WcWdyHJqqtWb
         YYsbB9p5eryI33IWmPFwso/ii0ODJi4RLYbp9kZed4q1/Ek68EA5rVfy+UgPWNsHs6+B
         txfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dU6sPoZYBSNt4B9LtuHokgv92EsNlfChjuz4gWlCh3c=;
        b=tXj1qncJzzo3voYxmvrAzV0g3YUF4WXRd+xL7QWYcpvcaF7DJfcto1jTEBJxi2jTgX
         BIYkQVg7Fu2Fp3uGu7nmVaD6bJl//qW4O0153O+1xaTnCkCT2MlRFBeS0i7408CheYL3
         DuE/unxmUm69XPA0jzjdS9HEQHmGYCss/XMEP4fgF27TjJJZqjo/s1aEQpWbcxJIhRpw
         gVTJG6WBBLJzYB6pqmaq+QKgoS6GZsQy92u3pnH9O1b2JI9WnxxsZpNoScEm3Jk6dLQK
         4HE7Mebq6dld1MBIuaSV3fWgZz36p5dyUdBSiY4qFIEbOyvwMzPMRYXl1WMi1zqgdIq/
         Tkyw==
X-Gm-Message-State: ACgBeo0FR1tpFZGRnSChP/6ZpczWZb6LG+wnZBdixLOAhAweZZ/ZQSi1
        EqGabSDEXwCjZLZpIICcKYkdbX1G31NsObEWV4kN+mBY
X-Google-Smtp-Source: AA6agR5C2GkrdaY4xKi1nXEKkbJmNhl3u4xaS/qs1ow89CmtKfs2r1fYVlccvUopchgsp+TvJJRs9xiklXAGUZMuT/s=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr19868759edb.333.1659999153319; Mon, 08
 Aug 2022 15:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220807175309.4186342-1-yhs@fb.com>
In-Reply-To: <20220807175309.4186342-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Aug 2022 15:52:22 -0700
Message-ID: <CAEf4BzZJdqxOS_8VLX73z94GCUBVW4k6hKo3WGHyv4n-jQ-niQ@mail.gmail.com>
Subject: Re: [PATCH dwarves] dwarf_loader: encode char type as signed
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 7, 2022 at 10:53 AM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, the pahole treats 'char' or 'signed char' type
> as unsigned in BTF generation. The following is an example,
>   $ cat t.c
>   signed char a;
>   char b;
>   $ clang -O2 -g -c t.c
>   $ pahole -JV t.o
>   ...
>   [1] INT signed char size=1 nr_bits=8 encoding=(none)
>   [2] INT char size=1 nr_bits=8 encoding=(none)
> In the above encoding '(none)' implies unsigned type.
>
> But if the same program is compiled with bpf target,
>   $ clang -target bpf -O2 -g -c t.c
>   $ bpftool btf dump file t.o
>   [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>   [2] VAR 'a' type_id=1, linkage=global
>   [3] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>   [4] VAR 'b' type_id=3, linkage=global
>   [5] DATASEC '.bss' size=0 vlen=2
>           type_id=2 offset=0 size=1 (VAR 'a')
>           type_id=4 offset=0 size=1 (VAR 'b')
> the 'char' and 'signed char' are encoded as SIGNED integers.
>
> Encode 'char' and 'signed char' as SIGNED should be a right to
> do and it will be consistent with bpf implementation.
>
> With this patch,
>   $ pahole -JV t.o
>   ...
>   [1] INT signed char size=1 nr_bits=8 encoding=SIGNED
>   [2] INT char size=1 nr_bits=8 encoding=SIGNED
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Is there a plan to also add CHAR encoding bit?


>  dwarf_loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index d892bc3..c2ad2a0 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -560,7 +560,7 @@ static struct base_type *base_type__new(Dwarf_Die *die, struct cu *cu, struct co
>                 bt->bit_size = attr_numeric(die, DW_AT_byte_size) * 8;
>                 uint64_t encoding = attr_numeric(die, DW_AT_encoding);
>                 bt->is_bool = encoding == DW_ATE_boolean;
> -               bt->is_signed = encoding == DW_ATE_signed;
> +               bt->is_signed = (encoding == DW_ATE_signed) || (encoding == DW_ATE_signed_char);
>                 bt->is_varargs = false;
>                 bt->name_has_encoding = true;
>                 bt->float_type = encoding_to_float_type(encoding);
> --
> 2.30.2
>
