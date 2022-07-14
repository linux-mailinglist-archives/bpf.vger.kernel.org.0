Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E55744C1
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 08:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiGNGA0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 02:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiGNGAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 02:00:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B6F1AF3C
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 23:00:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v12so1031484edc.10
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 23:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/a1DNPG1XpJxTmdBTuR/N+mtKXMn43pTOzy1NXZdhk=;
        b=bhFOeobxREV3c9dSFdKTjHod3yibkT2J3tKT6K8IdU9qfcOOHwvXs3uDgm3/igJbvH
         hLjb8z78VSlo0BY9IbAv/nS83SWSGZCi6U2j5DsPctCAX5PMB3iT7qCLOpOtIkoMqsvT
         OTmVgSGuYkRDuUVD4xGnHly6zX5Bee8loHHwGl9dify4ch085CFQ+yR3vl5RrHfQLc/Q
         D6hQvN7vTBSSgQfTdZqGvCklxqdbRD5shiwccZbMJFUDg1yQY/risJVZhzBfI0qIXTwf
         QX14oyn1DZpZjARq9GT6eqzaWjjyzpRGmvjpTzRm26WhEdREMFApTVpqS8H/fvTxbSEn
         Ex5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/a1DNPG1XpJxTmdBTuR/N+mtKXMn43pTOzy1NXZdhk=;
        b=BCJjOYTN6Vcub9P17zLZzZ6MxurwILhFajSnTEZ+ZAqngtPW40gGVx613MtJe+s4Et
         eJn3UMVVt1eeE8p9UC7r5XRy2kMGPdImmqBjQ2B/Iz431dV8yuD2MIdERGic82nRKTi5
         mjXyuxlWyFhK+qCH7OZxBAmtcjnW2C0H74sh4JrZj5Fvu4a89kJhgmpFQUW4uujAdYZY
         5wvA6kmt0RNfSQXvXFc0/aTR590tYl8jxakGteaLvt7tFqvOejb3Mm84JOrnKCN4KZnd
         uPAG8SwTs2TV7p03f8+zcjW5uLek+tmBPJOLiQxnyVGdJ4s1zm5reRcuofld7dVfs9Fn
         BDoA==
X-Gm-Message-State: AJIora82Fci2kKNCDDkyEPaQagfy/3owQX8zMECViDD65iEH3GLaGNXZ
        lnBFyQkxYCXAVWHmJDfeaJjWG1uEjqTEwZn8mcU=
X-Google-Smtp-Source: AGRyM1vDe+vvYmKJVs8WXqKU9hSMDi74p2CkCNZmosZyegP4LYorEAvBShmq5lpdj6eHEJ/i9m3wc2Iaw3SHAVqeaQ4=
X-Received: by 2002:aa7:d053:0:b0:43a:a164:2c3 with SMTP id
 n19-20020aa7d053000000b0043aa16402c3mr9974977edo.333.1657778421297; Wed, 13
 Jul 2022 23:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220713222544.2355143-1-indu.bhagat@oracle.com>
In-Reply-To: <20220713222544.2355143-1-indu.bhagat@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 23:00:10 -0700
Message-ID: <CAEf4BzYqL_p61f_2HXSNuCSXPGxWbq7+kvZvmVGGgdLY1Z1ZWA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Update documentation for BTF_KIND_FUNC
To:     Indu Bhagat <indu.bhagat@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>
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

On Wed, Jul 13, 2022 at 3:37 PM Indu Bhagat <indu.bhagat@oracle.com> wrote:
>
> The vlen bits in the BTF type of kind BTF_KIND_FUNC are used to convey the
> linkage information for functions.
>
> Signed-off-by: Indu Bhagat <indu.bhagat@oracle.com>
> ---
>  Documentation/bpf/btf.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index f49aeef62d0c..b3a9d5ac882c 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -369,7 +369,7 @@ No additional type data follow ``btf_type``.
>    * ``name_off``: offset to a valid C identifier
>    * ``info.kind_flag``: 0
>    * ``info.kind``: BTF_KIND_FUNC
> -  * ``info.vlen``: 0
> +  * ``info.vlen``: linkage information (static=0, global=1)

there is also extern=2, but I think we should just refer to enum
btf_func_linkage, defined in UAPI (include/uapi/linux/btf.h) ?

>    * ``type``: a BTF_KIND_FUNC_PROTO type
>
>  No additional type data follow ``btf_type``.
> --
> 2.31.1
>
