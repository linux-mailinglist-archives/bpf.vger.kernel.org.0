Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CAE1F5B37
	for <lists+bpf@lfdr.de>; Wed, 10 Jun 2020 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgFJSbQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Jun 2020 14:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgFJSbQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jun 2020 14:31:16 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05431C03E96B
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 11:31:16 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so2552456qtq.11
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMTxSBGT3qH57Z0fcgefq7qyTbxTLnXxOSOE4PZ8MyE=;
        b=MKDkK48tQlKn3rHlcrFdcTUSkKJpYzz+DzpUzwRHnV2noHqwovinLsmwOWp83HJymH
         gIY8qVOyAhGUldbAf6WO2FtpEfDFIx0aBzifznR5AZTDKq8JKIFQycZWx+XBaq1zpNVW
         7sco7LbuSjIieu4/xgLMqH5vDqFEnMQ2W/piSja2OtpN25gDeoV1hHK8e2YLtqR/n7mR
         0FCx1TaxevER077ZxfPH1bIHIfrU11Dnm63+CxHBBR3MuFjtRT+dS3lNj8pG/OUlEtaK
         Z8dgtN/5DUisRboihY71nOw6mAS3wvJN+VIeOg97GgB6JNU5j7ZGfnOspTzHNYI4gQfo
         dAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMTxSBGT3qH57Z0fcgefq7qyTbxTLnXxOSOE4PZ8MyE=;
        b=d1mrgIPJI7AJRK7mhL72+ph9BgGJQpo+BrmCpABIGqZfIOQx+wpNCDN0eIlgiFhxV8
         ceXfcIr9p55SWWNWYK+pYenMTHvxIT+0NnEoXl041XFTfWUSLkajIcGWd4QusgZI7cIj
         WTADfg4jPtW6/hc5zp1HMwdj9vZM2Q+/uzpBpJ1rJi3ssONVm0iiNuDTVqyO8YaMS+PW
         H3hLajac2iDfiXWNN08jcLL+UrwsJEBl5kLn085sNy4Al6EDdD/aNafBibH7AJbCv0/o
         KUgjg6IvltOnX4Av7RTnQbKvxaQyeoJzteB6z8YA9ZXsDl0oHCdVrz22giLF0MCV/vHG
         1JfA==
X-Gm-Message-State: AOAM530TqVFoLy1VkO4ywik5O1Sb8qpltStYjZ+3qPeUJ/pgPdzrE84m
        zAtZFkvCWUmI1h1H3W4gCDUL8d/AW8Ent8ywBsA6tJGg
X-Google-Smtp-Source: ABdhPJwa7beKtV4VDOIH081hAVMgpcN2jqpoHHjk2c/VI12OysfQ6cul0tj974hkBv4MG4j0fP9r3F6eZI2S7yMubIo=
X-Received: by 2002:ac8:42ce:: with SMTP id g14mr4652218qtm.117.1591813875207;
 Wed, 10 Jun 2020 11:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200610130804.21423-1-tklauser@distanz.ch>
In-Reply-To: <20200610130804.21423-1-tklauser@distanz.ch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Jun 2020 11:31:03 -0700
Message-ID: <CAEf4BzaGRcgj5COyfsNtR6uGgakCCBT=Q3osPR84ap2r1EMRjg@mail.gmail.com>
Subject: Re: [PATCH bpf] tools, bpftool: Fix memory leak in codegen error cases
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 10, 2020 at 6:10 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> Free the memory allocated for the template on error paths in function
> codegen.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/bpf/bpftool/gen.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a3c4bb86c05a..ecbae47e66b8 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -224,6 +224,7 @@ static int codegen(const char *template, ...)
>                 } else {
>                         p_err("unrecognized character at pos %td in template '%s'",
>                               src - template - 1, template);
> +                       free(s);
>                         return -EINVAL;
>                 }
>         }
> @@ -234,6 +235,7 @@ static int codegen(const char *template, ...)
>                         if (*src != '\t') {
>                                 p_err("not enough tabs at pos %td in template '%s'",
>                                       src - template - 1, template);
> +                               free(s);
>                                 return -EINVAL;
>                         }
>                 }
> --
> 2.27.0
>
