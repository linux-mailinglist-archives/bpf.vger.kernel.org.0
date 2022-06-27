Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13555DF09
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbiF0WaY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 18:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbiF0WaX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 18:30:23 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62781E3CA;
        Mon, 27 Jun 2022 15:30:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd6so15059464edb.5;
        Mon, 27 Jun 2022 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbvCDPcLSAQnfMdnBweT6otCUIZmNSQtDthkskLiw8M=;
        b=MQWEI+tGktLDRoDAE9v0uf+Q6pEIM420acna+zLwmnoNtDKrcoPTBuZHm1jk/3tPxM
         VcYfCWfxxDb/3qj2LOTNQNn2PF4qbIR1Bt7Oyxg198OGFiJFEJSWA4GtbSLpovVssLCD
         Ei1vQOrcjLaFR0YgAflkMreBXDtgJ8s+MsoTzVcwml5V7Brj2sr0UO9IgIXhZZO+3ob+
         zKUGjyXLLv+FUnrtxtT3mre2DP4VOtswVyGS7+m0iq8tfu1pBJ0tffsyV57I1t400Ppx
         wUQl8O0mokzhxlN1zazKk9VhxQQr6QLez/LSL5VNT4VttNglid+ALeE+D6iL70uO/tVd
         rKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbvCDPcLSAQnfMdnBweT6otCUIZmNSQtDthkskLiw8M=;
        b=snV5XaWZuNHMhW2h9Csv3l71D+YkbC69ZHYdkOPvHEt/j+48tkNhap04JADi2AyNwO
         2q8BB3h1kw5hDdsx3RA/nnS6c4rqkpSju9uGJc/bcg7kpkPGOI3ltVIXA+u2c741OKig
         8ybwv9KNKHv7RrK+qCR6Zg3g/nADOsxjM+zNME1VR/JFXPg8jTnv4L7g77/KNzpF8a2M
         IvU+FuMICVibxdLjHG/RGXt0HSZHpGkCIdzRMe1xDm8JSUS6tSWkYCXYmo5GMdKLamsy
         BLBUcxH1nC2cRNXqkKkapDWPDHaD3IkogYEv2uJpmUzi7pl18UhtW1u48lqBV9XwJD7N
         NCIA==
X-Gm-Message-State: AJIora9SoKjPICzhobPR/yBc8Q1ywnBuJcMvJlr0mIWj0Bf1oQL6LvQO
        cmCKpMUMdXWXmzcgteEU0tXlov/0qivHCyEr4tA=
X-Google-Smtp-Source: AGRyM1suwsqGaCzU1OXD7cq6HTk36GmO6WFoThPrCCMavOirmGJ+0BuYRCLoOcTv5E/LFuDL//RjrVx9kRK5gmVgSCI=
X-Received: by 2002:a05:6402:5309:b0:435:6431:f9dc with SMTP id
 eo9-20020a056402530900b004356431f9dcmr19200558edb.14.1656369020056; Mon, 27
 Jun 2022 15:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220615230306.851750-1-yhs@fb.com> <20220615230317.852304-1-yhs@fb.com>
In-Reply-To: <20220615230317.852304-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Jun 2022 15:30:07 -0700
Message-ID: <CAEf4BzayE3nEdft-=nhxSAxkq_F1N0o0AdbFU0m=MKSsF+pZ4w@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 2/2] btf: Support BTF_KIND_ENUM64
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Jun 15, 2022 at 4:03 PM Yonghong Song <yhs@fb.com> wrote:
>
> BTF_KIND_ENUM64 is supported with latest libbpf, which
> supports 64-bit enum values. Latest libbpf also supports
> signedness for enum values. Add enum64 support in
> dwarf-to-btf conversion.
>
> The following is an example of new encoding which covers
> signed/unsigned enum64/enum variations.
>
>   $cat t.c
>   enum { /* signed, enum64 */
>     A = -1,
>     B = 0xffffffff,
>   } g1;
>   enum { /* unsigned, enum64 */
>     C = 1,
>     D = 0xfffffffff,
>   } g2;
>   enum { /* signed, enum */
>     E = -1,
>     F = 0xfffffff,
>   } g3;
>   enum { /* unsigned, enum */
>     G = 1,
>     H = 0xfffffff,
>   } g4;
>   $ clang -g -c t.c
>   $ pahole -JV t.o
>   btf_encoder__new: 't.o' doesn't have '.data..percpu' section
>   Found 0 per-CPU variables!
>   File t.o:
>   [1] ENUM64 (anon) size=8
>           A val=-1
>           B val=4294967295
>   [2] INT long size=8 nr_bits=64 encoding=SIGNED
>   [3] ENUM64 (anon) size=8
>           C val=1
>           D val=68719476735
>   [4] INT unsigned long size=8 nr_bits=64 encoding=(none)
>   [5] ENUM (anon) size=4
>           E val=-1
>           F val=268435455
>   [6] INT int size=4 nr_bits=32 encoding=SIGNED
>   [7] ENUM (anon) size=4
>           G val=1
>           H val=268435455
>   [8] INT unsigned int size=4 nr_bits=32 encoding=(none)
>
> With the flag to skip enum64 encoding,
>
>   $ pahole -JV t.o --skip_encoding_btf_enum64
>   btf_encoder__new: 't.o' doesn't have '.data..percpu' section
>   Found 0 per-CPU variables!
>   File t.o:
>   [1] ENUM (anon) size=8
>         A val=4294967295
>         B val=4294967295
>   [2] INT long size=8 nr_bits=64 encoding=SIGNED
>   [3] ENUM (anon) size=8
>         C val=1
>         D val=4294967295
>   [4] INT unsigned long size=8 nr_bits=64 encoding=(none)
>   [5] ENUM (anon) size=4
>         E val=4294967295
>         F val=268435455
>   [6] INT int size=4 nr_bits=32 encoding=SIGNED
>   [7] ENUM (anon) size=4
>         G val=1
>         H val=268435455
>   [8] INT unsigned int size=4 nr_bits=32 encoding=(none)
>
> In the above btf encoding without enum64, all enum types
> with the same type size as the corresponding enum64. All these
> enum types have unsigned type (kflag = 0) which is required
> before kernel enum64 support.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  btf_encoder.c     | 65 +++++++++++++++++++++++++++++++++++------------
>  btf_encoder.h     |  2 +-
>  dwarf_loader.c    | 12 +++++++++
>  dwarves.h         |  4 ++-
>  dwarves_fprintf.c |  6 ++++-
>  pahole.c          | 10 +++++++-
>  6 files changed, 79 insertions(+), 20 deletions(-)
>

Sorry for late review, I don't always catch up on emails from older
emails first :(

[...]

>         size = BITS_ROUNDUP_BYTES(bit_size);
> -       id = btf__add_enum(btf, name, size);
> +       is_enum32 = size <= 4 || no_enum64;
> +       if (is_enum32)
> +               id = btf__add_enum(btf, name, size);
> +       else
> +               id = btf__add_enum64(btf, name, size, is_signed);
>         if (id > 0) {
>                 t = btf__type_by_id(btf, id);
>                 btf_encoder__log_type(encoder, t, false, true, "size=%u", t->size);
>         } else {
> -               btf__log_err(btf, BTF_KIND_ENUM, name, true,
> +               btf__log_err(btf, is_enum32 ? BTF_KIND_ENUM : BTF_KIND_ENUM64, name, true,
>                               "size=%u Error emitting BTF type", size);
>         }
>         return id;
>  }
>
> -static int btf_encoder__add_enum_val(struct btf_encoder *encoder, const char *name, int32_t value)
> +static int btf_encoder__add_enum_val(struct btf_encoder *encoder, const char *name, int64_t value,
> +                                    bool is_signed, bool is_enum64, bool no_enum64)

It was quite confusing to see "is_enum64" and "no_enum64" as arguments
to the same function :)

I'll let Arnaldo decide for himself, but I think it would be cleaner
to pass such configuration switches as fields in struct btf_encoder
itself and just check such flags from relevant btf_encoder__add_xxx()
functions. Such flags are global by nature, so it seems fitting.

But other than that looks good to me.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  {
> -       int err = btf__add_enum_value(encoder->btf, name, value);
> +       const char *fmt_str;
> +       int err;
> +
> +       /* If enum64 is not allowed, generate enum32 with unsigned int value. In enum64-supported
> +        * libbpf library, btf__add_enum_value() will set the kflag (sign bit) in common_type
> +        * if the value is negative.
> +        */
> +       if (no_enum64)
> +               err = btf__add_enum_value(encoder->btf, name, (uint32_t)value);
> +       else if (is_enum64)
> +               err = btf__add_enum64_value(encoder->btf, name, value);
> +       else
> +               err = btf__add_enum_value(encoder->btf, name, value);

[...]
