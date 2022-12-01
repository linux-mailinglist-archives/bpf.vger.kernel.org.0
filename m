Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F143763E6A3
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 01:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLAAm1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 19:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLAAm1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 19:42:27 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EB1865A0;
        Wed, 30 Nov 2022 16:42:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f7so322312edc.6;
        Wed, 30 Nov 2022 16:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zpvp+e+s7oTSiRyeUBaqCfKwUhXwNEbaOAQ5dW3BcZQ=;
        b=bFBZ1HikjoF4dFXhG6yjahMXb1nQK6oOG2SpOZRmNi+vwtLpqLcTAX3KssS6plvFbS
         /wPqg9IEGexDMUEn3c3NfRkLDXMxWFJ7OEuhJBFXiydyXMHZuh5VCY/CvEX4p68uNorc
         VZiiJqDCCZWnxDsjq1NYgQvB0jYEmQZLDtC2QJSM2ksQTieyv4EfVl21IatwdTIgF3Dk
         tuQJOUSpiHvgT2mD8WoQ8Je+2pHZ708advnMF/pUyH7i3gi6HCKWSgrttlKcZ31fJucV
         wqDUetN9s+m2iMl78jkGw3s/QCXHLQWYXL3pnPC6NTLFenJ6BFgJpUVNkQgRB7ZA4Flt
         MUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zpvp+e+s7oTSiRyeUBaqCfKwUhXwNEbaOAQ5dW3BcZQ=;
        b=0rkuraj1ujzta7txX882q5RAT3z3R5+BnRCrlAlE1AkEc8gSBEa338DRXKhYffvt4c
         0VYSruOOaYCg2U3NjXql8B5VhJ98qxsy+taBbAg2vPCM/K01G3DMaXSvwhxtCqa9fE6/
         e66UHPio2sVXZI9Jju+QX2p85VlnZIhX/IMAmK9Wm8ukX4LU8q52fWWpOtpLFwcMMPeS
         qDrA5+iAp4l9WUhQtDhAq0tGr0xUSJHUpDylRIzEAdefzK2EcnJZpVbqiz3A+VvPDUpm
         tbe3tUNEiA+//G7EOBsKNlBOYDyVbB4oXWKHBSsDFWasjVYshanM8C9FmOY0/zYVAYYb
         FFTQ==
X-Gm-Message-State: ANoB5plKDcgZSFWMmcgLqu7u8b2KjXnCacy5FMHFCUiLZHFMBtp9Fg9p
        7ZTPvYl5Rq8IY0GTQUGLEssVqzvev2reA6EImW0=
X-Google-Smtp-Source: AA0mqf5Ol3JhINeqqhj1Mw4fgAe2dW5aqG/dyvBEGluIiXmicdpTjveGJzwxJ4GWmiF2S3uJYh08epa9wLeCENx/FWw=
X-Received: by 2002:a50:ed90:0:b0:46a:e6e3:b3cf with SMTP id
 h16-20020a50ed90000000b0046ae6e3b3cfmr21317903edr.333.1669855341893; Wed, 30
 Nov 2022 16:42:21 -0800 (PST)
MIME-Version: 1.0
References: <20221129074235.116969-1-liuxin350@huawei.com>
In-Reply-To: <20221129074235.116969-1-liuxin350@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Nov 2022 16:42:09 -0800
Message-ID: <CAEf4BzZ8z9yKwkbQthaNPR9HJDqq77EJwHaEqqwQ3qYjKWTRAQ@mail.gmail.com>
Subject: Re: [PATCH] Improved usability of the Makefile in libbpf
To:     Xin Liu <liuxin350@huawei.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com,
        kongweibin2@huawei.com, zhangmingyi5@huawei.com
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

On Mon, Nov 28, 2022 at 11:42 PM Xin Liu <liuxin350@huawei.com> wrote:
>
> Current libbpf Makefile does not contain the help command, which
> is inconvenient to use. A help command is provided to list the
> commands supported by libbpf make and the functions of the commands.
>
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> ---
>  tools/lib/bpf/Makefile | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 4c904ef0b47e..c86e05df4711 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -286,3 +286,37 @@ tags:
>
>  # Delete partially updated (corrupted) files on error
>  .DELETE_ON_ERROR:
> +
> +help:
> +       @echo 'Default targets:'
> +       @echo '  all               - Run all_cmd'
> +       @echo '  all_cmd           - Build library and pkgconfig, check abi and version info'
> +       @echo ''
> +       @echo 'Cleaning targets:'
> +       @echo '  clean             - Remove all generated files'
> +       @echo ''
> +       @echo 'Build targets:'
> +       @echo '  libbpf.so         - Build the dynamic library'
> +       @echo '  libbpf.a          - Build the static library'
> +       @echo '  libbpf.pc         - Build the pkgconfig file'
> +       @echo ''
> +       @echo 'Install targets:'
> +       @echo '  install           - Install all headers, library and pkgconfig file to'
> +       @echo '                      DESTDIR(default: /) with prefix(default: /usr/local)'
> +       @echo '  install_lib       - Install only library'
> +       @echo '  install_headers   - Install only headers'
> +       @echo '  install_pkgconfig - Install only pkgconfig file'
> +       @echo ''
> +       @echo 'Other generic targets:'
> +       @echo '  cscope            - Generate cscope index'
> +       @echo '  tags              - Generate tags file for editors'
> +       @echo '  check             - Check abi and version info'
> +       @echo '  check_abi         - Check versioned symbols'
> +       @echo '  check_version     - Check whether the libbpf version defined in libbpf_version.h'
> +       @echo '                      is the same as that defined in libbpf.map'
> +       @echo ''
> +       @echo '  make V=0|1             [targets] 0 => quiet build (default), 1 => verbose build'
> +       @echo '  make DESTDIR=/root     [install targets] use DESTDIR for installing'
> +       @echo '                                           into a different root directory'
> +       @echo '  make prefix=/path      [install targets] use prefix for installing'
> +       @echo '                                           into a user defined prefix path'


I'm a bit hesitant about adding all this. Most of those targets are
not intended to be used directly, only "all", "clean", and "install"
are supposed to be used by end-users (maybe also "install_headers").
And those seems to be pretty typical and straightforward targets.

I actually didn't even know about `make help`, but I checked perf's
`make help` and it's way more succinct, let's try modeling it here?

Also, please use [PATCH bpf-next] (with v2 in between them) for next
submission to point that this is meant for bpf-next tree.


> --
> 2.33.0
>
