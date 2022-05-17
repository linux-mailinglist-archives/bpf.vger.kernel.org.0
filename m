Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAD252AECC
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 01:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiEQXpP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 19:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiEQXpN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 19:45:13 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C07835DF3
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:45:13 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id m6so550516iob.4
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AH49eqKpcCLVVJmp2bX9Hy03VTksiLaJXDaMGOfcLWk=;
        b=dHslOg0oJls//NlK435R0WBA6P+cHD1Evdgp8bvsUJWClUY1y2JyB9A25SyAtTYR2c
         uX3MRtje6qSzzX+WfoY4FJGr3J+A9a22LDi4//F1Ye8d2q2xJo9LNM39uv/R23Ir2PaK
         BD9qzzjZ2XDQegP6jDw5fG+e6/YjNX6UKK04n2/HK5P+3PB20P0t7xyCRX7KM2bHyrZS
         gQ+iYEAAAaqJdd7/IpD5A6avlrxeb3cSSIYbPaABTKGbAEuuHd7FcXH08oRn8ioCMEuD
         KXFPzBj9o6JQDgiasani8jTV/UbuLwEJwl0bUdd0d3MFvzJ3hjA+oMrlB6CqFOtMc+J/
         909Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AH49eqKpcCLVVJmp2bX9Hy03VTksiLaJXDaMGOfcLWk=;
        b=XGrd6jpv4kskCpkHcit/IVY4VBCuYL75u/Ybn2EiBTd38Kgfq10YQE0iJL+JZ/YdJX
         E6gDU3antR1FKAzgi6Rkao74t9qnf0mBr+bKBE8rjw7MThyz9ifjt3WKdozLzu+3+yHE
         946KNu8/rzXbKP4KZVngvZ0EQxBdm3B6EqhJgN5EOquxJzv4+paCS+0aCN9qaZIaqo/n
         5l1ujbIwBYu65dFdYPz+nEqknxjjm9ckYz7dTbnw5Yrbykh3cpK2i2KLg5oPnJU6Y2OK
         7HqBOAY/BcpnNowJC6OOVosUTrF9s4EGzEpxICbUgW1oQRvKyYUA7nUrJSfIlFb67ITP
         8/+A==
X-Gm-Message-State: AOAM530v4/v02nKDhnYPrrJZh+Ey/DckDPVer3eIsAu1bYirTAj56XHG
        CCc8ReulnTJKqYHBePVFGgdJvpIhOAh4HQLxwCZtgayb90U=
X-Google-Smtp-Source: ABdhPJyWOrMb9nPssIzxAixpSRSEZfcFI+a3Vf1ap1de0L6OJTWAQIpIKyH4nfX6lYszRlXSvd7Dz8c3o1RwCFrXOY8=
X-Received: by 2002:a05:6602:248f:b0:65a:fb17:7a6b with SMTP id
 g15-20020a056602248f00b0065afb177a6bmr11375784ioe.79.1652831112634; Tue, 17
 May 2022 16:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031345.3246727-1-yhs@fb.com>
In-Reply-To: <20220514031345.3246727-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 May 2022 16:45:01 -0700
Message-ID: <CAEf4BzYSdfCnWRT__D247ia4zKVm85+yQMNg=Z9N-hm_mE_k1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 16/18] selftests/bpf: Add a test for enum64
 value relocations
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

On Fri, May 13, 2022 at 8:14 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add a test for enum64 value relocations.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  .../selftests/bpf/prog_tests/core_reloc.c     | 58 ++++++++++++++
>  .../bpf/progs/btf__core_reloc_enum64val.c     |  3 +
>  .../progs/btf__core_reloc_enum64val___diff.c  |  3 +
>  .../btf__core_reloc_enum64val___err_missing.c |  3 +
>  ...btf__core_reloc_enum64val___val3_missing.c |  3 +
>  .../selftests/bpf/progs/core_reloc_types.h    | 78 +++++++++++++++++++
>  .../bpf/progs/test_core_reloc_enum64val.c     | 70 +++++++++++++++++
>  7 files changed, 218 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val.c
>  create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___diff.c
>  create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___err_missing.c
>  create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___val3_missing.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_enum64val.c
>

[...]
