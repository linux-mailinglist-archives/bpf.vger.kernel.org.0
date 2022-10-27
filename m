Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9F96105E3
	for <lists+bpf@lfdr.de>; Fri, 28 Oct 2022 00:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiJ0Woo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 18:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiJ0Wok (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 18:44:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91CD1209B
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:44:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 21so5374816edv.3
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 15:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9YeiJEgW3NOttOopPAuCZ3TE2/z62dDKOzpGXccTptc=;
        b=ILAhmUVkvWRQrqACqrH5oWYezOQWs/0Jl43c82JGoR3ItQNALM5yPZ/WuK9Ajk8hUC
         3mna6Sh5F5wGk62FJPsZUdZ2lwCmm+cg5mFcmieJdlh7/CIG90KyMVIdx5k6lJ9tUvVt
         Zgxstu7ZfhKKE+T6ApnfLtXoD2QEZCgUkGM+51HzeTcEvxCrtntDSe4q82LFTS4607ot
         Ztvr+908yf/MTt/7ZWY72PLHYYfNoKtzLaLQwEkF0Fehf4PGJGSbSGWFr/Z7+rjYolpH
         pQ+J4TcrQEGrMiU7/iQaRASOVryrDiSoLh9AdmSTAO6mKieMO4BY/1Hs19qqrhfJII6V
         CObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YeiJEgW3NOttOopPAuCZ3TE2/z62dDKOzpGXccTptc=;
        b=idPrmwrHGIBem2KQ0Nct4mjoCQ007qOCb3CqzomwbrzZEbX8kjkJx/XWdPgji6/Rqn
         4F4igu0ZyAc/dPRSGJH5+EQb9ZGKNCB9wPoZg8XdoJBta6mly1DndgvKFix7JSbblu8l
         u5R/Yjb7moSpxrW40TGUJjWY6o8QlLZdshAivXbVJDhD0ZV5uypx1x3TOmQjnWt3oe7B
         WCB+242iIMh+GnoI1nIdzPIOsB9E1GEnZZtbNIQxQosDu0cSCRJ2jRQ/gH8iq0DO4C34
         0ggc9xGi3sFj1gdNnwPYsaYuC5WWB0OiETtuW+kk+kdGnbXxCInKJX1Be70SkfGQd3ap
         pNFA==
X-Gm-Message-State: ACrzQf3encv30L2etS+3GKJ8oUpppQmtVogKONGoh6znHc6WB9A9Mjyd
        Jf5oDpW8yuzUdbm4CM0BkU//hCOrnDB6XVvSfYA=
X-Google-Smtp-Source: AMsMyM5BPa4fSXAhQg9EI+Q6yliwEGUVZ86fvT69ScxNJ8El4EcjzprgxTIgo9wPg8IZVn+6OefWyP6zrOqYhTW6AJ4=
X-Received: by 2002:aa7:c504:0:b0:461:122b:882b with SMTP id
 o4-20020aa7c504000000b00461122b882bmr37033394edq.14.1666910677194; Thu, 27
 Oct 2022 15:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221025222802.2295103-1-eddyz87@gmail.com> <20221025222802.2295103-6-eddyz87@gmail.com>
In-Reply-To: <20221025222802.2295103-6-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Oct 2022 15:44:24 -0700
Message-ID: <CAEf4BzYdJ+LLZ74+4agO1hrT43xV+wQoadAK1C0iF-fQ3ZY02g@mail.gmail.com>
Subject: Re: [RFC bpf-next 05/12] libbpf: Header guards for selected data
 structures in vmlinux.h
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        arnaldo.melo@gmail.com
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

On Tue, Oct 25, 2022 at 3:28 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> The goal of the patch is to allow usage of header files from
> `include/uapi` alongside with `vmlinux.h`. E.g. as follows:
>
>   #include <uapi/linux/tcp.h>
>   #include "vmlinux.h"
>
> This goal is achieved by adding #ifndef / #endif guards in vmlinux.h
> around definitions that originate from the `include/uapi` headers. The
> guards emitted match the guards used in the original headers.
> E.g. as follows:
>
> include/uapi/linux/tcp.h:
>
>   #ifndef _UAPI_LINUX_TCP_H
>   #define _UAPI_LINUX_TCP_H
>   ...
>   union tcp_word_hdr {
>         struct tcphdr hdr;
>         __be32        words[5];
>   };
>   ...
>   #endif /* _UAPI_LINUX_TCP_H */
>
> vmlinux.h:
>
>   ...
>   #ifndef _UAPI_LINUX_TCP_H
>
>   union tcp_word_hdr {
>         struct tcphdr hdr;
>         __be32 words[5];
>   };
>
>   #endif /* _UAPI_LINUX_TCP_H */
>   ...
>
> The problem of identifying data structures from uapi and selecting
> proper guard names is delegated to pahole. When configured pahole
> generates fake `BTF_DECL_TAG` records with header guards information.
> The fake tag is distinguished from a real tag by a prefix
> "header_guard:" in its value. These tags could be present for unions,
> structures, enums and typedefs, e.g.:
>
> [24139] STRUCT 'tcphdr' size=20 vlen=17
>   ...
> [24296] DECL_TAG 'header_guard:_UAPI_LINUX_TCP_H' type_id=24139 ...
>
> This patch adds An option `emit_header_guards` to `struct btf_dump_opts`.
> When this option is present the function `btf_dump__dump_type` emits
> header guards for top-level declarations. The header guards are
> identified by inspecting fake `BTF_DECL_TAG` records described above.

This looks like a completely arbitrary convention that libbpf has no
business knowing or caring about. I think bpftool should be emitting
these guards when generating vmlinux.h. Let's solve this somehow
differently.

>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/lib/bpf/btf.h      |  7 +++-
>  tools/lib/bpf/btf_dump.c | 89 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 94 insertions(+), 2 deletions(-)
>

[...]
