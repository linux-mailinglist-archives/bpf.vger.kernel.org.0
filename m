Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A27D631A54
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 08:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiKUHav (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 02:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiKUHae (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 02:30:34 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53037450B1;
        Sun, 20 Nov 2022 23:29:51 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id h10so7513602qvq.7;
        Sun, 20 Nov 2022 23:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MY3mj3l+5CfCCInAcDlHvG3PSUH4yIPKLve52bAsu4=;
        b=qzVfHEkoMlxwASUliqg0rGXoW5wMBjzwf/hJ7Xav+ikzVov0jHewVMvVzBDneR+HES
         FjxW5v/yV9h/cpC9tNSVYtBERfXvx+GLc6gL3tbl+s+D0ZAVn1g9IgFuJiy1cCreGkLN
         sEepvoMov1/JCVAkQ0Tuw6iuidjPG+CtiYL25Alr3oM82xhXHap/GntQDMEechfmjO4t
         5E5gpMk7eMYCzo3q8X5hcT0Dd7DXlfEL/Em3tJf4XdzoZt5Gng5Iiimkn4M4f5tvN2f7
         XL1PyksWvwZVKs94Lx89YqhzoXNAI1NfmsP2NQ05MqJPDO2TZ9d0p+j3MOt1gbgkmkB5
         f0Hw==
X-Gm-Message-State: ANoB5pkCaPHRlwJU8Onvs5RH0RZ0MLH8hPawz346M1gZ/iKgpabhuZXB
        1HS2nC/ogANmiHhJP2Y0ld8=
X-Google-Smtp-Source: AA0mqf7jFCwahDzu6/UEgnqDJ+xx5vPjDH4fb0zlJQA7ZwTmATqqkab/aWh/ah9AOk9CLa8ehGH9og==
X-Received: by 2002:ad4:414d:0:b0:4b1:9872:85c5 with SMTP id z13-20020ad4414d000000b004b1987285c5mr3215991qvp.23.1669015790198;
        Sun, 20 Nov 2022 23:29:50 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id dt18-20020a05620a479200b006ea7f9d8644sm7721596qkb.96.2022.11.20.23.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:29:49 -0800 (PST)
Date:   Mon, 21 Nov 2022 01:29:54 -0600
From:   David Vernet <void@manifault.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        corbet@lwn.net, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, sdf@google.com,
        song@kernel.org, yhs@fb.com
Subject: Re: [PATCH bpf-next] docs/bpf: Update btf selftests program and add
 link
Message-ID: <Y3so8nndjYTpRVHn@maniforge.lan>
References: <Y3pj9FCI5SOEHZXz@maniforge.lan>
 <tencent_A24996F06584CAF86BC2A822E2A2C1BA1006@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A24996F06584CAF86BC2A822E2A2C1BA1006@qq.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 10:07:34AM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> commit c64779e24e88("selftests/bpf: Merge most of test_btf into
> test_progs") rename selftests/bpf btf test from 'test_btf.c' to
> 'prog_tests/btf.c'.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---

Please send this out as a v2 patch, as described in [0].

[0]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

>  Documentation/bpf/btf.rst | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index cf8722f96090..dca0b0e9dd35 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -1062,4 +1062,9 @@ format.::
>  7. Testing
>  ==========
>  
> -Kernel bpf selftest `test_btf.c` provides extensive set of BTF-related tests.
> +Kernel bpf selftest `tools/testing/selftests/bpf/prog_tests/btf.c`_ provides

You added the hyperlink, but don't seem to have applied my other
suggestions. Please do so in v2.

> +extensive set of BTF-related tests.
> +
> +.. Links
> +.. _tools/testing/selftests/bpf/prog_tests/btf.c:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/btf.c
> -- 
> 2.38.1
> 
