Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7C6E860B
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 01:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjDSXoW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 19:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDSXoV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 19:44:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FEB10C2
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 16:44:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u3so2241239ejj.12
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 16:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681947859; x=1684539859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vB4w9Mtmjn0zFMrtyFiz1moKibbfTRZDJT6T/nQiJ0=;
        b=X0P+Zl62d0sTDCUeQ6nmyyvMKgvMosS8E97Wzkz9b2KQonoI+QFgE8VPekPyXqhAyA
         u2z4PIxGI8VNwStu1atBDS/esQrq6PdU5tBL8sZhAg1pMnl1eNDN+cEkfaUevPTl+Quy
         7jL4e5SAMSIrfRfOwcpKms1q15hIeBuG0KLKuDe+f2hNMekkXmJer2VtkXqjB6z9YwTK
         DUkD4S7xT2ora35QIp6rTv04BzSK3KvUnw8cIakEX/vA6XjcnYXDAsZaFBxzV8Hv4QUm
         7E/rOwQys1xhWaBcoVlEEhwS2GmFFXk7Tmh1OXBUOKxbItRaHxI1Wpv9k98RGgJg/p61
         fPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681947859; x=1684539859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vB4w9Mtmjn0zFMrtyFiz1moKibbfTRZDJT6T/nQiJ0=;
        b=gbooQG2PR//OcT0gju5Z/XlJqizmL5/8xgv1uV19XeCNjSLATm9vpIHy9OW4IYMiVP
         AQ4b2p7D/BsUqlVN3mBvT4vuHEdPtA2Y1RL+tcNOy9wrlwUJSc9t9FoOZxx3mD+nSa3n
         eLBVG82nEa02go6pi1TRiQWcrl35k/Z6165XMYdNAIKbg1bJ+mvHLiU1fff7rV1T758L
         SsMpAKhyLrF459kb7R4tXdvuyqyEnXK522YRADHNogviy5/bvVzOAfi9kE456DIX7wgC
         20XFRkm0oqbftBNvdDX+NOfU7NNSBQxXJc/ZQqI2BTc1rmrxDhoImrEjz3/R7/4oDQTM
         XrVA==
X-Gm-Message-State: AAQBX9dRKBy5xf3wvGlHne0943HOMjju1qG7UiCoQXNKgXO3moUIFAi5
        Sb6j6EyiAc7qOuz2dUbJDzfaAcu1KKrx4UaH5yWa+Q==
X-Google-Smtp-Source: AKy350Yk6oJ1mPno1gWzwug4Fp4RFD/a6xULvDKILWMdYwWHYi+s0iMThvFihYOPIoA0s53CMLEJYRP39a+fFn+3vNM=
X-Received: by 2002:a17:906:82c9:b0:92b:69cd:34c7 with SMTP id
 a9-20020a17090682c900b0092b69cd34c7mr19370478ejy.40.1681947859357; Wed, 19
 Apr 2023 16:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230419025625.1289594-1-kuifeng@meta.com> <20230419025625.1289594-2-kuifeng@meta.com>
In-Reply-To: <20230419025625.1289594-2-kuifeng@meta.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Thu, 20 Apr 2023 00:44:08 +0100
Message-ID: <CACdoK4JFQFdFwXXq9UTwfEXGPEDaUjE0FYFAqQDkRt2Rs_b6NQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpftool: Update doc to explain struct_ops
 register subcommand.
To:     Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        yhs@meta.com, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 19 Apr 2023 at 03:56, Kui-Feng Lee <thinker.li@gmail.com> wrote:
>
> The "struct_ops register" subcommand now allows for an optional *LINK_DIR*
> to be included. This specifies the directory path where bpftool will pin
> struct_ops links with the same name as their corresponding map names.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst b/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
> index ee53a122c0c7..2111c9550938 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-struct_ops.rst
> @@ -51,10 +51,14 @@ DESCRIPTION
>                   for the given struct_ops.  Otherwise, it dumps all struct_ops
>                   currently existing in the system.
>
> -       **bpftool struct_ops register** *OBJ*
> +       **bpftool struct_ops register** *OBJ* [*LINK_DIR*]
>                   Register bpf struct_ops from *OBJ*.  All struct_ops under
> -                 the ELF section ".struct_ops" will be registered to
> -                 its kernel subsystem.
> +                 the ELF section ".struct_ops" and ".struct_ops.link" will
> +                 be registered to its kernel subsystem.  For each
> +                 struct_ops in the ".struct_ops.link" section, a link
> +                 will be created.  You can give *LINK_DIR* to provide a
> +                 directory path where these links will be pinned with the
> +                 same name as their corresponding map name.
>
>         **bpftool struct_ops unregister**  *STRUCT_OPS_MAP*
>                   Unregister the *STRUCT_OPS_MAP* from the kernel subsystem.

Thanks! Since there are some nits to address on the first patch
anyway, would you mind updating the command summary earlier in this
file as well, please? In section "STRUCT_OPS COMMANDS".

Thanks,
Quentin
