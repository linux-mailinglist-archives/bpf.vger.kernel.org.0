Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2776237D4
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 00:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKIX6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 18:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKIX6b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 18:58:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750FEDEC8
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 15:58:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a5so590701edb.11
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 15:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=He60EoJuFpLEMFyBNV7f2C7UduUP6UgUc9OdQ/g5/oY=;
        b=n5DRqb7E6j/dps2jOuTl8M1hIFy5dY4mxW36xVzygC5j85Zoi04Fr9LgoFx4Cyv0mz
         jG8TB1zP3/MwIfLiViMTtkF7hAL7eYfMFlyrtxG8si8zw5W9Yn+2OnbvWlgW8TwPtcjR
         l3+n04HPjPUmOoxr2A9hjjCCCzjvwYGS1ioRsM6To+xK7G8vr2d+1dlyLcRYv7do4bDP
         vofxeBZy2Od+PoAcDx4xgqaajZNLTLdkYesBP8/5gOB1RH4puLBzqvl04/b20C9rJ12n
         H73WegvVhWwqc8Eqyadh2MekvwY8Z/HpHNaTLclHOKBsUphMDnoap6Ua110LNbqBpN5a
         xrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=He60EoJuFpLEMFyBNV7f2C7UduUP6UgUc9OdQ/g5/oY=;
        b=FPUIdJVLlwoiLUf2Onj5SzPat9ljYAL34R+mTshgMblqtk9zacC0edBJvvLzksZdJs
         TSaTv6NgwCtcSqH1znLGbrGzUbcq81zzppqqfdUyk5kX2tquNxvvwZzaWf1ZjkElgbfK
         1UPyWRLYIhcJybt3gVSNyNAXQHDalh++dgToVCPo1RGcexyH61IORTrnkAoUSyPGIv+0
         pHSVoKeS7fyNiQppCiFXzs9A4dxHfjSFeha2JEvijqZb51z2eTprn3EzAbpyojj072bR
         m8WsNsdGszWg6oeY8YNOSZbnvILIBzQpFlseZho/qR6sSB8Iv8E4R11/D0CEGvp3LLUR
         0UeA==
X-Gm-Message-State: ACrzQf2rre4WGSlYOwTP/vJkhc2YpJncESEKR30NRmgrs/GWsA/u/DB0
        CtA98SRB1K/TUpZkK7LifVPgGMc6uAIaGFeoj4s=
X-Google-Smtp-Source: AMsMyM4mW9ltJjvprfTYkX/6D8whh3Ku/FZKimkyFiynJHW4YI//2Ap6mUx3dgCdjo2Me0VBRTqCJ5QSTTOCJgZ2DY8=
X-Received: by 2002:aa7:d58f:0:b0:461:524f:a8f4 with SMTP id
 r15-20020aa7d58f000000b00461524fa8f4mr1318923edq.260.1668038307911; Wed, 09
 Nov 2022 15:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20221109074427.141751-1-sahid.ferdjaoui@industrialdiscipline.com> <20221109074427.141751-3-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221109074427.141751-3-sahid.ferdjaoui@industrialdiscipline.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Nov 2022 15:58:15 -0800
Message-ID: <CAEf4Bzb4j1PZWs1gJaDGftdtO0GBAzs=37=A8ettPMVyiRtnww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] bpftool: replace return value
 PTR_ERR(NULL) with 0
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
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

On Tue, Nov 8, 2022 at 11:45 PM Sahid Orentino Ferdjaoui
<sahid.ferdjaoui@industrialdiscipline.com> wrote:
>
> There is no reasons to keep PTR_ERR() when kern_btf=NULL, let's just
> return 0.
>
> Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipline.com>
> ---
>  tools/bpf/bpftool/struct_ops.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
> index e08a6ff2866c..68281f9b7a0e 100644
> --- a/tools/bpf/bpftool/struct_ops.c
> +++ b/tools/bpf/bpftool/struct_ops.c
> @@ -63,10 +63,8 @@ static __s32 get_map_info_type_id(void)
>                 return map_info_type_id;
>
>         kern_btf = get_btf_vmlinux();
> -       if (libbpf_get_error(kern_btf)) {
> -               map_info_type_id = PTR_ERR(kern_btf);
> -               return map_info_type_id;
> -       }
> +       if (libbpf_get_error(kern_btf))
> +               return 0;
>

if (!kern_btf)
    return 0;

>         map_info_type_id = btf__find_by_name_kind(kern_btf, "bpf_map_info",
>                                                   BTF_KIND_STRUCT);
> --
> 2.34.1
>
>
