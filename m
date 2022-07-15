Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C8957689F
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 23:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiGOVCm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 17:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGOVCl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 17:02:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1439411C37
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 14:02:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ss3so10963303ejc.11
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 14:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2pfPUjkBPp9wWUsg0dFT5foq/yROEANFC9VMmjemJ4M=;
        b=aKQC5jZ4OmD5+mf4p91I15QRwNyvneuJHVErSxdgO2fno7LJqsyHDcK2wx396FNs2I
         G4ek2QPuJjbW2VoXcdIU0S/TFvK91n3I1H466lfo9d8VbRQh3UNdeFQeZK6rG+g9ANVF
         6hKAbsuStf+lLeJBs41etBej4dsgo6OIoxUuPUeLZsWYHwbhUc/qiSzd+cSPgYnqQNcx
         1PlGRQzwOuq2NftkCiIcFxl9PtinFCZRk4DpEom9Pxa4GK5CZonilmqiA8QthlGbER2q
         /Gn48KQccSwzJRp3pymi/a66h/ygJ4PnhV5Co3qwpPA1gbmSV0icxyllj6jNclsK/khh
         XOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2pfPUjkBPp9wWUsg0dFT5foq/yROEANFC9VMmjemJ4M=;
        b=GTmsWNVp1RSKFNOjOkeEQnseLa22CIXmKVIvYtRTsYH+mKJI1VUduH4u+rTVAmo1lc
         BSKFOOybH78zIJ+iayISM//aFhQX44dy8SZChuqsov3ByAtys039oCz6oMQqP82YHSaG
         eU0gsVYb31xVkaV0hvXC7+zXNnBuBQXqWNlGr9U4b8oKdewcMiKzXf7Y4DjRYQ8yegcg
         ywSUwpQn7u6/caabWxfZMWVAIHgBojb/J2ZC9VPcEpOYb3kTVo53SjUOK2aeLn772tRX
         YQnj4QMC2rheoZFldwmM2ArvLRk1Q+pHSjTSoppclXivlh0kbirh9GLte9knne4kU5Ay
         06oA==
X-Gm-Message-State: AJIora/qv4zeTqGsbkNcx6oxcQisQ0omIupyJQsIjVPJfiB4JdiR5Bky
        pneuBHFiY6tvhvY7zpETCQcjLrG7eqpEd6Ohc1k=
X-Google-Smtp-Source: AGRyM1sm9x1qd58PwKMMBu1EoOok/jgxnP8gM06Jn9r+rTmX2UFf9h9RF/cSawZ9YAzNVWnZpVDnfgeP4Sfz9vLlG7Q=
X-Received: by 2002:a17:907:75ef:b0:72b:2fd:1a92 with SMTP id
 jz15-20020a17090775ef00b0072b02fd1a92mr15397692ejc.745.1657918959508; Fri, 15
 Jul 2022 14:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220714223310.1140097-1-indu.bhagat@oracle.com>
In-Reply-To: <20220714223310.1140097-1-indu.bhagat@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 15 Jul 2022 14:02:28 -0700
Message-ID: <CAEf4BzZvqacZeZ5GdHWjWHhjKzvPvcK3vR6vCYABhZCz7nW1Xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] docs/bpf: Update documentation for BTF_KIND_FUNC
To:     Indu Bhagat <indu.bhagat@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>
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

On Thu, Jul 14, 2022 at 3:33 PM Indu Bhagat <indu.bhagat@oracle.com> wrote:
>
> The vlen bits in the BTF type of kind BTF_KIND_FUNC are used to convey the
> linkage information for functions. The Linux kernel only supports
> linkage values of BTF_FUNC_STATIC and BTF_FUNC_GLOBAL at this time.
>
> Signed-off-by: Indu Bhagat <indu.bhagat@oracle.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  Documentation/bpf/btf.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index f49aeef62d0c..cf8722f96090 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -369,7 +369,8 @@ No additional type data follow ``btf_type``.
>    * ``name_off``: offset to a valid C identifier
>    * ``info.kind_flag``: 0
>    * ``info.kind``: BTF_KIND_FUNC
> -  * ``info.vlen``: 0
> +  * ``info.vlen``: linkage information (BTF_FUNC_STATIC, BTF_FUNC_GLOBAL
> +                   or BTF_FUNC_EXTERN)
>    * ``type``: a BTF_KIND_FUNC_PROTO type
>
>  No additional type data follow ``btf_type``.
> @@ -380,6 +381,9 @@ type. The BTF_KIND_FUNC may in turn be referenced by a func_info in the
>  :ref:`BTF_Ext_Section` (ELF) or in the arguments to :ref:`BPF_Prog_Load`
>  (ABI).
>
> +Currently, only linkage values of BTF_FUNC_STATIC and BTF_FUNC_GLOBAL are
> +supported in the kernel.
> +
>  2.2.13 BTF_KIND_FUNC_PROTO
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.31.1
>
