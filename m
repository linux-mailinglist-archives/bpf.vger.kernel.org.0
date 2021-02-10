Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8883174DE
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 01:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhBKAAl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 19:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhBKAAk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 19:00:40 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9ABC061574;
        Wed, 10 Feb 2021 16:00:00 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id b187so3840418ybg.9;
        Wed, 10 Feb 2021 16:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09Spi/8UU1p/OELTmxfBTiRNhMO6Zc63FG918GZPQAA=;
        b=EF+LIGXXYc1EUPopzbnCsxWMLbZfgAQTIuqeQpp3sB8Pyj+OahPnlNb+ZPBnnChnKt
         c/YD28oE/pwEsKrfQ7Fo6aV5E8P1MAChr2xMPMyWOtlMYaDyIi8bRykAMrVVwwLEmF7K
         YX426O0D6tOdl3uX9pn6MiPA4ggZWJRukyRC65+35rcLJ2DPetU9oUSpAgD8EMiZ9OPI
         OvDyjvTUDXg0CZLtM4CbXtmItOBFbbPgTc1Ny3kRE1zr1Bb1RnyZlu4Xsn20KbhZAktU
         yFV5I1ESYt7mZlS57xX/OqvkGemxR2gXCalMCSBgcbUfgrKYIVF3Kagd9qNvgV67664j
         ENIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09Spi/8UU1p/OELTmxfBTiRNhMO6Zc63FG918GZPQAA=;
        b=lmazh8GmiANSp4WEIG1SZSGUiyl455wb6CqRvWNBruwIUErCs9Yz4BAlacI/zBXnSy
         5RHDA6yOWVK79j3WD1vAdLei6FmLAvHKBETY3JnuQekj/6l+r61Vq6JDRmuSXlpSctnF
         uo9eF9lkevTCnA6l2lMD2N10TA8kFykXcmmQ3Rxdnl67aAkbEStf17dS0yzDMRy+c4SB
         OdMDgVUJgiOH8qjYBecB5Tkf/Ad5XNvVQJtzQVu4M4e6FAyyOz71MyY1IdImCa6001Y5
         tpjx5vlelpZzLnQg6I0Rq94kLupk4owVEoa3GAByrcmdi9m6xHQOp+8082huEFfvAzjs
         sAjA==
X-Gm-Message-State: AOAM530M96lZSZ3HtQCu/a7vMGD/qQeFWPsPjbF7MrxKrfY/R8jI87Rx
        g8l101gvTZqpTrPJY9e+WBhcthFk1pn07ltXxlk=
X-Google-Smtp-Source: ABdhPJy3QQ0g3KgzsSZKy2VIqOQh4kUKd5sut5vteImfeMSz3vaAa9nl3Gw3Lsrm8MinBBIp9VutBxHBGWhdhh2jP4w=
X-Received: by 2002:a5b:3c4:: with SMTP id t4mr7326726ybp.510.1613001599552;
 Wed, 10 Feb 2021 15:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20210210232327.1965876-1-morbo@google.com>
In-Reply-To: <20210210232327.1965876-1-morbo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 15:59:48 -0800
Message-ID: <CAEf4BzYrWe4N28JjM6na=sNvq5214zs5yHra_fCuE1KA24KQ0A@mail.gmail.com>
Subject: Re: [PATCH] dwarf_loader: use a better hashing function
To:     Bill Wendling <morbo@google.com>
Cc:     dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 10, 2021 at 3:25 PM Bill Wendling <morbo@google.com> wrote:
>
> This hashing function[1] produces better hash table bucket
> distributions. The original hashing function always produced zeros in
> the three least significant bits.
>
> The new hashing funciton gives a modest performance boost.
>
>       Original      New
>        0:11.41       0:11.38
>        0:11.36       0:11.34
>        0:11.35       0:11.26
>       -----------------------
>   Avg: 0:11.373      0:11.327
>
> for a performance improvement of 0.4%.
>
> [1] From Numerical Recipes, 3rd Ed. 7.1.4 Random Hashes and Random Bytes
>

Can you please also test with the one libbpf uses internally:

return (val * 11400714819323198485llu) >> (64 - bits);

?

Thanks!

> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  hash.h | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/hash.h b/hash.h
> index d3aa416..ea201ab 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -33,22 +33,17 @@
>
>  static inline uint64_t hash_64(const uint64_t val, const unsigned int bits)
>  {
> -       uint64_t hash = val;
> +       uint64_t hash = val * 0x369DEA0F31A53F85UL + 0x255992D382208B61UL;
>
> -       /*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
> -       uint64_t n = hash;
> -       n <<= 18;
> -       hash -= n;
> -       n <<= 33;
> -       hash -= n;
> -       n <<= 3;
> -       hash += n;
> -       n <<= 3;
> -       hash -= n;
> -       n <<= 4;
> -       hash += n;
> -       n <<= 2;
> -       hash += n;
> +       hash ^= hash >> 21;
> +       hash ^= hash << 37;
> +       hash ^= hash >>  4;
> +
> +       hash *= 0x422E19E1D95D2F0DUL;
> +
> +       hash ^= hash << 20;
> +       hash ^= hash >> 41;
> +       hash ^= hash <<  5;
>
>         /* High bits are more random, so use them. */
>         return hash >> (64 - bits);
> --
> 2.30.0.478.g8a0d178c01-goog
>
