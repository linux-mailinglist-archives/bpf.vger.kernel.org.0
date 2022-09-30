Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48565F166F
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 01:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiI3XB5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 19:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiI3XBz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 19:01:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA07718C00C
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 16:01:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dv25so11856642ejb.12
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 16:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ahmyuz7wFVwUJK37lhj+mZ8YUqncTXioR1vjbQ5vXr0=;
        b=Jyke8Z5FjpHAL0Cdzy7GoOTUe0uPAn5lXwFyxh5ILaW9RrIWOBl4XUsjdFdvsTbpsv
         ho0VIKiGVNm4BwJxDnAx+Qs1HY5IiAA4UorvxTTBAoyQ2nvUC/0mDqQDv6eXu4EK+xL4
         tQAA+VgkTbDfmfJ+fX2XaP/HZ9uXZsXq/iTkKITTYWoFrByUUmFtXISjPXJQotoisJJe
         E1MNf7OeIr1YiOlEEfU0HRRCb+WdU42czd9Y4bh8bsBrZsjtdCBSMf4VgrS3gQkDzQcA
         dkNa4nBs5KYn7biDoRytG8wDfs+nVeYtqldjX7S4zP0adPIvPM9x7M5GQ9EmQaOSbUsL
         mnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahmyuz7wFVwUJK37lhj+mZ8YUqncTXioR1vjbQ5vXr0=;
        b=19Ppy1VCet7k/XfrqB2uADqrHUNVSprCdqVShBnySCv3AvT/lvCgGhM1374RBK1ULD
         V3/87g0Mi2G/ONLdDWCQ9AOrVcLSlIxZKVdG4fdoF5AJXjidxivsadzB2LR1H3KpXwpm
         QsDuhge+iXAuf4Z2pVDO22Gty1H7ucQeEXmDBoJgU9JJjbk342uSHtfpvItFS8rb+Lsd
         K07pDMQYodXu8kvZ+MLQwvDGvYv/R09wEhDBP9cQb2Rf33Dp+mBoETJO5B7UZyMYsyUV
         pvOwHqvHBi2hUIYpIIx4f1HRsWEnMLxYHJTIMgWzqbKzLSTZFmZQZxMgsIYyrVbBMro7
         OxBQ==
X-Gm-Message-State: ACrzQf17KI3RE9eN1TV15Q44LPXuaPo4jG9xtmFMSIQxKn/aBT2uzwDQ
        fVB8PtgELG25Nsk8tVZr+FsV3ruHOeUaslFIRJg=
X-Google-Smtp-Source: AMsMyM6Hv0O6hvwnbEuDP9bb7PLEUjxiMvFGYgXr4dWQjL/uyFF2zNCQG4LC/9kTApguEqUmrKYuGpXXoUYcPzQPRhs=
X-Received: by 2002:a17:906:8454:b0:772:7b02:70b5 with SMTP id
 e20-20020a170906845400b007727b0270b5mr7911722ejy.114.1664578913341; Fri, 30
 Sep 2022 16:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220930164918.342310-1-eddyz87@gmail.com> <20220930164918.342310-2-eddyz87@gmail.com>
In-Reply-To: <20220930164918.342310-2-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 16:01:41 -0700
Message-ID: <CAEf4BzZ8x_nQzxZ79tejeA-aUGEeWghx_xcgYmARCnh1U_Mx=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: fix newline for struct with padding
 only fields
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 30, 2022 at 9:50 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> An update for `bpftool btf dump file ... format c`.
> Add a missing newline print for structures that consist of
> anonymous-only padding fields. E.g. here is struct bpf_timer from
> vmlinux.h before this patch:
>
>  struct bpf_timer {
>         long: 64;
>         long: 64;};
>
> And after this patch:
>
>  struct bpf_dynptr {
>         long: 64;
>         long: 64;
>  };

Without looking at source code it wasn't clear what the original issue
was. It would be good to explain that libbpf's btf_dumper attempts to
emit empty structs with {} on the same line. But this breaks for
non-zero-sized structs due to padding.

>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/btf_dump.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 4221f73a74d0..ebbba19ac122 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -852,7 +852,7 @@ static int chip_away_bits(int total, int at_most)
>         return total % at_most ? : at_most;
>  }
>
> -static void btf_dump_emit_bit_padding(const struct btf_dump *d,
> +static bool btf_dump_emit_bit_padding(const struct btf_dump *d,
>                                       int cur_off, int m_off, int m_bit_sz,
>                                       int align, int lvl)
>  {
> @@ -861,10 +861,10 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
>
>         if (off_diff <= 0)
>                 /* no gap */
> -               return;
> +               return false;
>         if (m_bit_sz == 0 && off_diff < align * 8)
>                 /* natural padding will take care of a gap */
> -               return;
> +               return false;
>
>         while (off_diff > 0) {
>                 const char *pad_type;
> @@ -886,6 +886,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
>                 btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type, pad_bits);
>                 off_diff -= pad_bits;
>         }
> +
> +       return true;
>  }
>
>  static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
> @@ -906,6 +908,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
>         bool is_struct = btf_is_struct(t);
>         int align, i, packed, off = 0;
>         __u16 vlen = btf_vlen(t);
> +       bool padding_added = false;
>
>         packed = is_struct ? btf_is_struct_packed(d->btf, id, t) : 0;
>
> @@ -940,11 +943,11 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
>         /* pad at the end, if necessary */
>         if (is_struct) {
>                 align = packed ? 1 : btf__align_of(d->btf, id);
> -               btf_dump_emit_bit_padding(d, off, t->size * 8, 0, align,
> -                                         lvl + 1);
> +               padding_added = btf_dump_emit_bit_padding(d, off, t->size * 8, 0, align,
> +                                                         lvl + 1);
>         }
>
> -       if (vlen)
> +       if (vlen || padding_added)

What if instead of returning the padding_added flag we just check that
struct is non-zero-sized? Clearly vlen isn't an appropriate check
here.

>                 btf_dump_printf(d, "\n");
>         btf_dump_printf(d, "%s}", pfx(lvl));
>         if (packed)
> --
> 2.37.3
>
