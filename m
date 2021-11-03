Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82144443A4E
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 01:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhKCAOX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 20:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbhKCAOU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Nov 2021 20:14:20 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D4C061714;
        Tue,  2 Nov 2021 17:11:45 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id d204so2284984ybb.4;
        Tue, 02 Nov 2021 17:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7n6isZ3xSfSLtS1Jv0XYXqOaIwdMbkSb+z9LApvy+7s=;
        b=frKHE7X3cg5xPvz3HtL0GYz9kWuqhNljeQjX9SRy0wcgXQUFWoyu36Imc71N+cJ4Oq
         TcGWqNbw7xIRNo5S47Zzm1WZOiNUPjEM0B1hHkrvbaeYw+wHxNDxINI01GIytRz2qxna
         IuC65XVON56ANIBKphg72Hn1hk4se446Innx842dJaDWeOInQMAXdy0048V0okOjQP1/
         D1sewQFlw/uulv1vi24Gz7jLmDoBeW/9bU7LNpAiziDinmuUkj8y66AE+DFrBg9kOVqD
         luZv3K/4ZTAvZOxxIk2HcHK0lOTSJ0h78E6r5GeR+g/DxDOr8dfNWpGtHu0UfclcX2Hx
         GwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7n6isZ3xSfSLtS1Jv0XYXqOaIwdMbkSb+z9LApvy+7s=;
        b=boZyjWPYikTrEVohQAOfGG95Ks5ibo/U+KsDyrv//4mWw3sHv60JOHtewwZXs4FQpy
         4FxnfgtkXF/uJXc+D7YdsbQ9KGlNqMrP5BhRZg9qngQEru2OqnMw3xbgapF4BVyWUJr6
         Ow0YBo2ykyMZIv6tZmz3U9d+KxU9UxpX0hzlj/41IUEX//SUf0u7dwdbVcSCAsGUj1Gw
         j76qpUxplHnbexENEJ4C2E5rxEEAJBmSCn3m/IVZaLfqDXNxwzs8VOrdVjWxjukSWLSL
         GXCoQDAuzHA8sCulCqHO4BWIjn2rK2ba2Yyr4LFtelPPWg7aqC/ZLSSjHB49V2x3BB8u
         iKfw==
X-Gm-Message-State: AOAM532bRFqmcmSOY7TXWK3iKiazwpCeFwU0J8cfaZApU3XxtjVLr7ql
        wfdWkLwOAa2Qt0vpZI2SibzK2TrU5WbutbrLzrnSyrUVJDU=
X-Google-Smtp-Source: ABdhPJxLdyrwEA83PblIQRcGm7jeHEsKVc3kXIJCZ2R/H/9PjlZ0mzCQudVLBr76noCY6d1LNYWGOi5m/SwSv/FVwAw=
X-Received: by 2002:a25:d16:: with SMTP id 22mr35691109ybn.51.1635898303755;
 Tue, 02 Nov 2021 17:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211102233500.1024582-1-yhs@fb.com>
In-Reply-To: <20211102233500.1024582-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 2 Nov 2021 17:11:32 -0700
Message-ID: <CAEf4BzZXVjTgZH-t0kXP6rwyA=dxQqc3VAHdmh-eFHY5OdbGYA@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 0/2] btf: support typedef DW_TAG_LLVM_annotation
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 2, 2021 at 4:35 PM Yonghong Song <yhs@fb.com> wrote:
>
> Latest llvm is able to generate DW_TAG_LLVM_annotation for typedef
> declarations. Latest bpf-next supports BTF_KIND_DECL_TAG for
> typedef declarations. This patch implemented dwarf DW_TAG_LLVM_annotation
> to btf BTF_KIND_DECL_TAG conversion. Patch 1 is for dwarf_loader
> to process DW_TAG_LLVM_annotation tags. Patch 2 is for the
> dwarf->btf conversion.
>
> Changelog:
>   v1 -> v2:
>    - change some "if" statements to "switch" statement.
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Yonghong Song (2):
>   dwarf_loader: support typedef DW_TAG_LLVM_annotation
>   btf_encoder: generate BTF_KIND_DECL_TAGs for typedef btf_decl_tag
>     attributes
>
>  btf_encoder.c  | 17 ++++++++++++++---
>  dwarf_loader.c |  7 ++-----
>  2 files changed, 16 insertions(+), 8 deletions(-)
>
> --
> 2.30.2
>
