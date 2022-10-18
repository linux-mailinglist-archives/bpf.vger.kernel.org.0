Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F3A602083
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 03:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJRBkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 21:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJRBj7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 21:39:59 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B8A3057E
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 18:39:56 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id a18so7874661qko.0
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 18:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/D6eXmgie0EYtMFbMscNrVihtX5JSgXAnvXyWSdlMyI=;
        b=q+Fv9XjqXjdeEQcZc4dWTNYi3gySVd+ay9oZDxgLz2n5XxIefUL1EyMyeDQBrQy9pm
         uCvvBhid2ludcYNsKnxHZMDzCU4w4OP61JMdckgXnHGvww9xIo/1pm6KRvadh9KRq9VD
         joSojgG609aqzFvCvHHxCZS1RrKui3Zlk+wE9EhODFkiyRmm+bu26YbdbfhjTXlsbFDv
         BX5r/UQiTb96GUIs7mZd0peCPikSN+dC9OU2w4GOF7tALJtOQbrtjJTWgcfdn3lpu87i
         F0imOviG5OtLbNBwyN2+aMV7bJVb8jv/Y3hUMLJKFgw4Q3GbnZO5MQV9dFuPryUWefZ2
         Oy/g==
X-Gm-Message-State: ACrzQf3Z3hjwSh4DVRthNT2X3pyl+Bqe7wvdxFrkfOzYkBbLZcPRSd6f
        H20dLpI0jqSt4NiZGHBONePTH5jV3H0SHw==
X-Google-Smtp-Source: AMsMyM6r4XHibMxiwA1pskBnmsldYNpskL7eE/Gw6d+sXVSDRnVgfGErKVktt8jOljFePwabgWgUYA==
X-Received: by 2002:a05:620a:29c2:b0:6ee:b27c:2a50 with SMTP id s2-20020a05620a29c200b006eeb27c2a50mr334073qkp.485.1666057194717;
        Mon, 17 Oct 2022 18:39:54 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::d067])
        by smtp.gmail.com with ESMTPSA id o24-20020ac85558000000b0039bde72b14asm908284qtr.92.2022.10.17.18.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 18:39:54 -0700 (PDT)
Date:   Mon, 17 Oct 2022 20:39:55 -0500
From:   David Vernet <void@manifault.com>
To:     Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] bpf/docs: Summarize CI system and deny lists
Message-ID: <Y04D6+RfZfTcqYIz@maniforge.dhcp.thefacebook.com>
References: <20221017231948.1246272-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221017231948.1246272-1-deso@posteo.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 17, 2022 at 11:19:48PM +0000, Daniel Müller wrote:

Hi Daniel,

> This change adds a brief summary of the BPF continuous integration (CI)
> to the BPF selftest documentation. The summary focuses not so much on
> actual workings of the CI, as it is maintained outside of the
> repository, but aims to document the few bits of it that are sourced
> from this repisitory and that developers may want to adjust as part of

s/repisitory/repository

> patch submissions: the BPF kernel configuration and the deny list
> file(s).
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>
> ---
>  tools/testing/selftests/bpf/README.rst | 42 +++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
> index d3c6b3d..d1d7e9 100644
> --- a/tools/testing/selftests/bpf/README.rst
> +++ b/tools/testing/selftests/bpf/README.rst
> @@ -6,13 +6,53 @@ General instructions on running selftests can be found in
>  
>  __ /Documentation/bpf/bpf_devel_QA.rst#q-how-to-run-bpf-selftests
>  
> +=============
> +BPF CI System
> +=============
> +
> +BPF employs a continuous integration (CI) system to check patch submission in an
> +automated fashion. The system runs selftests for each patch in a series. Results
> +are propagated to patchwork, where failures are highlighted similar to
> +violations of other checks (such as additional warnings being emitted or a
> +``scripts/checkpatch.pl`` reported deficiency):
> +
> +  https://patchwork.kernel.org/project/netdevbpf/list/?delegate=121173
> +
> +The CI system executes tests on multiple architectures. It uses a kernel
> +configuration derived from both the generic and architecture specific config
> +file fragments below ``tools/testing/selftests/bpf/`` (e.g., ``config`` and
> +``config.x86_64``).
> +
> +Denylisting Tests
> +=================
> +
> +It is possible for some architectures to not have support for all BPF features.
> +In such a case tests in CI may fail. An example of such a shortcoming is BPF
> +trampoline support on IBM's s390 architecture. For cases like this, an in-tree

tiny nit: Elsewhere in the README we're saying s390x. Should we just say
the same here for consistency?

Looks good otherwise, thanks.

Acked-by: David Vernet <void@manifault.com>
