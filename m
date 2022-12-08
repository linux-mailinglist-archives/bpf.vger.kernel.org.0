Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647416479FB
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 00:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiLHXcu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 18:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLHXcs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 18:32:48 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5AA2A717
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 15:32:47 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m18so7663679eji.5
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 15:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ULtsSq2P23wGZMnT25QC7oMe23/PV8lWVOSDn7WRshM=;
        b=bXz4sTebBkUEx4FyoOGRfs+oEdlMk8b0eZwvHGRWTJJHQ9CdyIMc6h7BTNxosdloN8
         opC0uozZ0xwGEnt15Gsgf3elWIb5VqruZxcXj1CUShuBaL2cdUvcP6Mxonx4fH4u9L4V
         bDzLjNMotgx6AY6LcRAaAwns67ckj+JDpAu42BF3Yu5JathvgW+eyFW2ecd45iRG7Yzu
         LKotP7o6ICxMlkqNefIqy15VPyn8z1hWmQvmp2k1DiiNSh0pVUlgp64rVZJVtfNRfDI5
         h2rQiK9F00OlbTV715dFNwqxHFS8GTWeYcVEhcZJ+K9AnRkz6EUuO0HtcA6Fy3qDWwC8
         /fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULtsSq2P23wGZMnT25QC7oMe23/PV8lWVOSDn7WRshM=;
        b=4n9tbDodvuQUPaZ6RsdiRn8YBBctaC10Ni1/qJXjQwCiH3/5JZOAyjAIzauFAVcx9T
         SubPLsZjbZ8fnrMjc1FPQNnj7ArfFoWmMABc/xN1Ezh3fCx/aJ40Ekp06YPEeyNhUUcS
         Yw0duS+glY0g5DJHnr+f0r2V3Bki6Dt+mXkPwlBVAeUCyVGtK2WyOsLCupNKE/c5GdM8
         mg9uN6nzsh/ZKvn8Z6kIIU0mqPgaZde/B1+cR1+sgHALyoafNkVXF03wMZ6zUAiPNGyR
         jeEYJyxkJEd7/UFpIpMhKu/Fqi1PzpZnVUa0iAZF1dOiN0LdEUnrYKe4mEoN1X1WqpV1
         8YNA==
X-Gm-Message-State: ANoB5pn7tUeAtxbYNsA9EsQz71ReRwOUnAY6V7iv+6o2aOzOgbiA302g
        6jt59A9k0rzJrDwQpu1w8IbjMJQKncv6eb979Eg=
X-Google-Smtp-Source: AA0mqf7II3r6YPezjmw1DyOmI5Q35WD27f7LdF8Ek5IC5UdOH5kT0HNo4I1xJr6G8eD7WBwVdF9s8fD8eQJwuPLhi4s=
X-Received: by 2002:a17:906:94e:b0:7ba:4617:3f17 with SMTP id
 j14-20020a170906094e00b007ba46173f17mr57545792ejd.226.1670542365708; Thu, 08
 Dec 2022 15:32:45 -0800 (PST)
MIME-Version: 1.0
References: <20221206043501.5249-1-chethan.suresh@sony.com>
In-Reply-To: <20221206043501.5249-1-chethan.suresh@sony.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Dec 2022 15:32:33 -0800
Message-ID: <CAEf4BzbuRywbSsTn1gjvJ-c5JtTn+xTTA8ApS0B-aLyLXFJZrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: fix output for skipping kernel config check
To:     Chethan Suresh <chethan.suresh@sony.com>
Cc:     quentin@isovalent.com, bpf@vger.kernel.org,
        Kenta Tada <Kenta.Tada@sony.com>
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

On Mon, Dec 5, 2022 at 8:41 PM Chethan Suresh <chethan.suresh@sony.com> wrote:
>
> When bpftool feature does not find kernel config files
> under default path, do not output CONFIG_XYZ is not set.
> Skip kernel config check and continue.
>
> Signed-off-by: Chethan Suresh <chethan.suresh@sony.com>
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>  tools/bpf/bpftool/feature.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> index 36cf0f1517c9..316c4a01bdb7 100644
> --- a/tools/bpf/bpftool/feature.c
> +++ b/tools/bpf/bpftool/feature.c
> @@ -487,14 +487,14 @@ static void probe_kernel_image_config(const char *define_prefix)
>         }
>
>  end_parse:
> -       if (file)
> +       if (file) {

There are two error conditions when file != NULL but we actually don't
read kconfig contents. Please handle those properly, otherwise all the
same confusion will keep happening.

>                 gzclose(file);
> -
> -       for (i = 0; i < ARRAY_SIZE(options); i++) {
> -               if (define_prefix && !options[i].macro_dump)
> -                       continue;
> -               print_kernel_option(options[i].name, values[i], define_prefix);
> -               free(values[i]);
> +               for (i = 0; i < ARRAY_SIZE(options); i++) {
> +                       if (define_prefix && !options[i].macro_dump)
> +                               continue;
> +                       print_kernel_option(options[i].name, values[i], define_prefix);
> +                       free(values[i]);
> +               }
>         }
>  }
>
> --
> 2.17.1
>
