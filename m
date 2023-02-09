Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E943691160
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 20:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjBITbW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 14:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBITbV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 14:31:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095107683
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 11:31:21 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id az16so2063395wrb.1
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 11:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o5sX8x9/ZLXnougQLzrHVQNETH1Reze9Dv4TXLwYEsc=;
        b=RtX6nmc2AHK26MgCggYGera5BXnJnytgs7ccV/kKPx4Klsn6PP+6nRH6bnRCOFnGHm
         mfi+MBg3JppH7GsnnDuhGs9B17R5zdSSa3eipY+ZElYgYusWVMiCB14RA6V3ZjxXadxH
         EtAxwRMzS/JGNwRhR4egJ87XXNc+QQstSPqCwrPv9MQmW6XLk80naJVJlgRb15jfAMhe
         H/26nDyu34xYof6TGkYuZizEF7p0ZQ0XSdPadJfXr8w+6yJSz4EqJHF63p2TiZgHITrZ
         8r5BuGhSUxCYwtdn4Mh1vJU2Yj49e0DZTKUAJh86uFhdpMX9fLAghCbrV2CpemQcnpup
         v6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5sX8x9/ZLXnougQLzrHVQNETH1Reze9Dv4TXLwYEsc=;
        b=pxPYdEq18LMcvbsLsFXeJf4ElNsDCOmDOCcWIqDxna5WTVD7HiDGIKP7fj7qm/cPWn
         usUp9h/cJRSoNNiE1sT3p0UZ+PnEdnm2NiMlbxNI9AIVp3WELwmYgwoEOwMun/ZRCOw3
         Z8huyM9nijTLZRQNYJtzcTFgwl+kzS8l+TDdD1lrHwDq5DjTtzlRNSttzOd3mYEBZ+2a
         hmck/y9aYzdEn4zCZICsgW/E0gnWRSLghnjXAucUZNh/i+LEZuR5ZGFFuHO5hwOX0OQ3
         Lga05DYjFmp0WdhGSjX5GZjNkfgNG/rjkfVZkd0mQTS4qsA1zJ2kZ2b4wttC8WUC5ZkI
         BFZA==
X-Gm-Message-State: AO0yUKUXMWONhzogHzJQGHTYzs7EBnNw8wo3kE68vapOohV6GY28AwED
        sYFEdl6h58BFhJqxUP5CYRexvSw/947n4nOTg1UfXQ==
X-Google-Smtp-Source: AK7set8rjISgOViGZrPumeNmnRQ3QwRh7fHLJ0zY2pr7+s/pmDl3R5xGDcnGTy2dZ2l978IRE2OpU18WHlAQ59FyfEk=
X-Received: by 2002:a5d:65c2:0:b0:2c4:760:5cbd with SMTP id
 e2-20020a5d65c2000000b002c407605cbdmr118002wrw.19.1675971079163; Thu, 09 Feb
 2023 11:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20230209143735.4112845-1-jolsa@kernel.org>
In-Reply-To: <20230209143735.4112845-1-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 9 Feb 2023 11:31:07 -0800
Message-ID: <CAP-5=fWxWktaFvgNoLCGdAN8vu=9CazyVoyY-AVsX_-AdWHzZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Pass HOSTCFLAGS as
 EXTRA_CFLAGS to prepare targets
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 9, 2023 at 6:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Thorsten reported build issue with command line that defined extra
> HOSTCFLAGS that were not passed into 'prepare' targets, but were
> used to build resolve_btfids objects.
>
> This results in build fail when these objects are linked together:
>
>   /usr/bin/ld: /build.../tools/bpf/resolve_btfids//libbpf/libbpf.a(libbpf-in.o):
>   relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE \
>   object; recompile with -fPIE
>
> Fixing this by passing HOSTCFLAGS in EXTRA_CFLAGS as part of
> HOST_OVERRIDES variable for prepare targets.
>
> [1] https://lore.kernel.org/bpf/f7922132-6645-6316-5675-0ece4197bfff@leemhuis.info/
>
> Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/bpf/resolve_btfids/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index 2abdd85b4a08..ac548a7baa73 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -19,7 +19,7 @@ endif
>
>  # Overrides for the prepare step libraries.
>  HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
> -                 CROSS_COMPILE=""
> +                 CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
>
>  RM      ?= rm
>  HOSTCC  ?= gcc
> --
> 2.39.1
>
