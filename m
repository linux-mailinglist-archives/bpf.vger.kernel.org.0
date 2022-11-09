Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233086220A3
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 01:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiKIASP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 19:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIASO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 19:18:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAAE61758
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 16:18:13 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ft34so6381825ejc.12
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 16:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uLL8sToArKF2EIxmHxhiMlhOd9Z6m/a+zyDD4jEF9Ck=;
        b=gx6orXCyUvp4VyS5a0B+sU+Mb8i8TaJhDbBzhh9Ewq1utijrO/Junx+4pS+ysYkPbY
         /ScW8UDuiBNqbRkmZ0lFaZg6PJZWnA/Zprs8uEA39fkOuuX3l5Bo3fYqzzXtcbPInlZN
         NS8n+Ae4Z64wN5Gv4zcaA+EE0aBDoH1mWU8TPxgClnCWwPyGWwizgThM97kTPGPSz3+U
         6IY9gX5qoa5zXZI7R/2ed+KLAfNT0w2xPt88Rrkt81j38IUsI96TZvg4G+EGXUHf3zOv
         udXWQEZdLmOHTnJ6VFRdqXWvxgSnhORDNHvYH4vFUhO+TpugYRP+R3Px0+pja9iNySp6
         oaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLL8sToArKF2EIxmHxhiMlhOd9Z6m/a+zyDD4jEF9Ck=;
        b=pCW2fsf4kqi9Dq4Q54DPn9BGZzIxCFocyEbSKxpPydTYjJfy9oKGoPNBHJl1SaYHXp
         ucarkQ9jUmkf9fabJQNc1U14+kCnnnPWlzdMb0jt98vc5dW2bqRakY7yofZTzmSwT8HO
         Y7X3KWB8kMBJ2StqMHYR2U+3V7OY8rQacHbBgouWmOv297S0qKR+uYP/sr/2DoWOBgp/
         a4dnqH2JNHITLSiExt1NfveRHGH/G3hVahRF263XQCdNeL2Fg6vSXVf8gM0lOVo05AQC
         73qhavmeB4EUKthmCiBJmGEdsbGo5BpV7LhzFoFGSDdwFLbQ066uxne6uxxO4PoK/Dp4
         M39w==
X-Gm-Message-State: ACrzQf0PWjy2keOfO4LdSliWzGezQhLlvCjd7N1BXGEniJF7dE3ybjS1
        yxV8RmmEmzw/XxlFgfFYvJux2a8O7rYaeYOXWZY=
X-Google-Smtp-Source: AMsMyM7Od2NuuaRyesuzkR3lClNjdFj6U5jW3tlFKnYcigLJrY6UNCRHaj9sfHkwl4OM0w7vmCy8aeYWKkOWWNbIjrU=
X-Received: by 2002:a17:906:11d6:b0:7ad:fd3e:2a01 with SMTP id
 o22-20020a17090611d600b007adfd3e2a01mr35755080eja.545.1667953092372; Tue, 08
 Nov 2022 16:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-26-memxor@gmail.com>
In-Reply-To: <20221107230950.7117-26-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Nov 2022 16:18:00 -0800
Message-ID: <CAEf4BzZCki9Dmqms4E643t6RctZxo3BowQvPY1u5Ht1zdiOxHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 25/25] selftests/bpf: Add BTF sanity tests
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Mon, Nov 7, 2022 at 3:11 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Preparing the metadata for bpf_list_head involves a complicated parsing
> step and type resolution for the contained value. Ensure that corner
> cases are tested against and invalid specifications in source are duly
> rejected. Also include tests for incorrect ownership relationships in
> the BTF.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/linked_list.c    | 271 ++++++++++++++++++
>  1 file changed, 271 insertions(+)
>

Have you considered using BTW write API to construct BTFs?
btf__new_empty() + btf__add_xxx()?

> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> index 669ef4bb9b87..40070e2d22f2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> @@ -1,4 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <bpf/btf.h>
> +#include <test_btf.h>
> +#include <linux/btf.h>
>  #include <test_progs.h>
>  #include <network_helpers.h>
>

[...]
