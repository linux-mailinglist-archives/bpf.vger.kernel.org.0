Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E2C52AE84
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 01:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiEQXZq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 19:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiEQXZp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 19:25:45 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072CCDE0
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:25:44 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y12so497105ior.7
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPT06H7duXGV2oNQRbcacBIsOSdxkLzMbWZVpPt+8zY=;
        b=HRk7YzcUVdkB3V4HPm4OuKa34kkIn0oIBtthGgm6Ffvm/MhhAtUxprBkZ2yOtyoktb
         oitQjMaPCiA3jZj2lXt1W2PGBxEbDcRE2ZHaoAsMsZ6w+k5l/5vX3ctYVGyDQHMnLM8V
         U89CqytDTV6ltnWQ3tCSFIFMjJf1lErK+IXPpYhyPV5EaM88SZzSeCyxrGbRTrfVMfTQ
         6K3VyRq6EJBN+H3+FRfSqIhrlOgxruQSd0lOetPuaAsLdDUgHRjhicvvMUGoKpnx1CwL
         ijgf1/ezz8G6bErYUlLgGMS+PH5RW5nziTVwFK9QmWKVDvinneWIIwYLkIlNSCjj/BdY
         jN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPT06H7duXGV2oNQRbcacBIsOSdxkLzMbWZVpPt+8zY=;
        b=an+mhFxDmUdqeHiGOhp3ViLvM1yDIMs+pRdKkh7BUhxo3Zae/uevBz0OJcji0Yzdnz
         F1AITHVC1xwgLeQKfRracvHBmPJQlHsRjehAa/sDqgdRi4e5IL7c/1HDSKE5N0PkhcNY
         2dprnPzfsjaIMTpNzF7t6uZeSgKDc9TGfuT8DmeomCfv9yevl6Gi05RzjnBkbBF7lC4Z
         Kt/1PNuEbre7X9Xs/iKtEMjy8IhivS7vjzBOrorZ1EYNTGLrwO+cLX6ujwIxoL3+c0+F
         X7DJqF2NQLKyLjtusNU+eRaV0qiIm4Rg+OzSjFRnkve7Hdk5lVY+CYiTnCgLcrTJ56xq
         eLjA==
X-Gm-Message-State: AOAM533Yvuija/V7IRcEvVkmdtYv8xFwO6hCEzaelxy/dIUV5EJdzeCX
        IkFA5wcoYNgPUWxlGYVH9zYcbz/LDQE3AMszsp22UkOvLSE=
X-Google-Smtp-Source: ABdhPJwp1dx0quPq0SZCrwqkwXf8Bd0usOLNdUzPpVB6tTBirZ0IXasWVV5M+mQ80NjtZdEPLnAXsUPEPRe7CmlerZA=
X-Received: by 2002:a5d:9316:0:b0:657:a364:ceb with SMTP id
 l22-20020a5d9316000000b00657a3640cebmr11601700ion.63.1652829943125; Tue, 17
 May 2022 16:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031308.3244041-1-yhs@fb.com>
In-Reply-To: <20220514031308.3244041-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 May 2022 16:25:32 -0700
Message-ID: <CAEf4Bza-2DL6jMZbkcOno1_tEePcK=tCjL_EM11FD0=agGQUBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/18] libbpf: Add enum64 support for bpf linking
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
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

On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add BTF_KIND_ENUM64 support for bpf linking, which is
> very similar to BTF_KIND_ENUM.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM :)

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/linker.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 9aa016fb55aa..979b150affb9 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -1340,6 +1340,7 @@ static bool glob_sym_btf_matches(const char *sym_name, bool exact,
>         case BTF_KIND_STRUCT:
>         case BTF_KIND_UNION:
>         case BTF_KIND_ENUM:
> +       case BTF_KIND_ENUM64:
>         case BTF_KIND_FWD:
>         case BTF_KIND_FUNC:
>         case BTF_KIND_VAR:
> @@ -1362,6 +1363,7 @@ static bool glob_sym_btf_matches(const char *sym_name, bool exact,
>         case BTF_KIND_INT:
>         case BTF_KIND_FLOAT:
>         case BTF_KIND_ENUM:
> +       case BTF_KIND_ENUM64:
>                 /* ignore encoding for int and enum values for enum */
>                 if (t1->size != t2->size) {
>                         pr_warn("global '%s': incompatible %s '%s' size %u and %u\n",
> --
> 2.30.2
>
