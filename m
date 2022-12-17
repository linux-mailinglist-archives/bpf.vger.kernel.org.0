Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDA564F823
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 09:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiLQIFg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 03:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQIFd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 03:05:33 -0500
X-Greylist: delayed 186 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Dec 2022 00:05:31 PST
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F379921E09
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 00:05:31 -0800 (PST)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-07.nifty.com with ESMTP id 2BH80YKm011674
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 17:00:34 +0900
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2BH80IA4012632;
        Sat, 17 Dec 2022 17:00:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2BH80IA4012632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1671264019;
        bh=ZYycTl7T8nH4SIgrrOiw66f272R2d0kq/iv5kqpNuaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ITgCGqH4ENtV2LTVdBPOio2glFcENszaYlHdkhPnQe+pjg/+VvydvdifhBzp5e6XZ
         SWm7jy8LxIrnkVzYobfgYJJlkttUMDdp2U0QvwmFBVLOzgW+WAVkt/HziTIzi3QRXA
         LGJtNMA1nYINWoaVY25VsgC5bp2r+058StL9YSsJ/zeuZ6mbUrLn/P2k5s7eQUtDuP
         /Vf/N9G/5zMiUL0C6qdk+D7uuYrgbe7v7fn7Lceny7AWo9OWEyLqTQ9OtRVnVkFE0K
         EOKqyWNDcmJSmyiyBvR1+2xsx3x5FBrlrvkxRUh53culY/GZJu/gx3C0IC0J/P7Jps
         mEgc1+h+vgtyQ==
X-Nifty-SrcIP: [209.85.161.52]
Received: by mail-oo1-f52.google.com with SMTP id q2-20020a4a8e02000000b004a0236114ecso708667ook.11;
        Sat, 17 Dec 2022 00:00:19 -0800 (PST)
X-Gm-Message-State: ANoB5pnyK03PRW10NVmJVuGmGyN3tn/CEBzUkvDYsJnHnWCx4gAxZZLd
        UhntAGu5jB0ucJRw6FH01clj6p4QzQ+D3JoUPH0=
X-Google-Smtp-Source: AA0mqf4VXD08DBaDeWXjG343pcdciVvCPWfwyE7r6SSrDDFo46BhrKC5u062VHChFuUJzHVI8UiZE4MbOz6mspfCSpk=
X-Received: by 2002:a4a:ac0e:0:b0:4a0:31ba:82bb with SMTP id
 p14-20020a4aac0e000000b004a031ba82bbmr26006944oon.96.1671264018138; Sat, 17
 Dec 2022 00:00:18 -0800 (PST)
MIME-Version: 1.0
References: <tencent_3D7B0D368482B2602EC7559A5E1546171009@qq.com>
In-Reply-To: <tencent_3D7B0D368482B2602EC7559A5E1546171009@qq.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 17 Dec 2022 16:59:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASM6KsrXHXLykaQ=rJ3YZ5OA+7im4=g=3Ob3EPt97n_HQ@mail.gmail.com>
Message-ID: <CAK7LNASM6KsrXHXLykaQ=rJ3YZ5OA+7im4=g=3Ob3EPt97n_HQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fix compilation error
To:     Rong Tao <rtoax@foxmail.com>
Cc:     linux-kbuild@vger.kernel.org, Rong Tao <rongtao@cestc.cn>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BPF [MISC]" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 17, 2022 at 4:07 PM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> In the absence of a CONFIG_FUNCTION_ALIGNMENT defined,

Does it happen in the mainline kernel?


CONFIG_FUNCTION_ALIGNMENT is always defined
as far as I understood arch/Kconfig.












> -falign-functions=3D
> will be given a null value, which results in a compilation error, as
> follows:
>
>     $ make -C samples/bpf/
>     ...
>     CC      /home/sdb/Git/linux/samples/bpf/syscall_nrs.s
>     gcc: error: missing argument to =E2=80=98-falign-functions=3D=E2=80=
=99
>     make[2]: *** [scripts/Makefile.build:118: /home/sdb/Git/linux/samples
>         /bpf/syscall_nrs.s] Error 1
>     make[1]: *** [Makefile:1996: /home/sdb/Git/linux/samples/bpf] Error 2
>     make[1]: Leaving directory '/home/sdb/Git/linux'
>     make: *** [Makefile:269: all] Error 2
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 6aa709df6bde..57cce4c8f8a2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1006,9 +1006,11 @@ KBUILD_CFLAGS    +=3D $(CC_FLAGS_CFI)
>  export CC_FLAGS_CFI
>  endif
>
> +ifdef CONFIG_FUNCTION_ALIGNMENT
>  ifneq ($(CONFIG_FUNCTION_ALIGNMENT),0)
>  KBUILD_CFLAGS +=3D -falign-functions=3D$(CONFIG_FUNCTION_ALIGNMENT)
>  endif
> +endif
>
>  # arch Makefile may override CC so keep this after arch Makefile is incl=
uded
>  NOSTDINC_FLAGS +=3D -nostdinc
> --
> 2.38.1
>


--=20
Best Regards
Masahiro Yamada
