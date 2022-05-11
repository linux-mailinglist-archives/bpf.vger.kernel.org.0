Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F92E523B7B
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 19:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiEKR1e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 13:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbiEKR1d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 13:27:33 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5CB4754E
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 10:27:31 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id k8so2791210qki.8
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 10:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sDjMohXAEhoZ3wtEjwEFwLndrNYcEVDeGKfEDK3DAjs=;
        b=ca1Imlm/tjqsMRXXVI4raq8fPy9/lyWG1Kz1nm+Mms6GVhKgNY0i8GwE9UezXxtTrP
         A31BFeT6hsiwVqw8U8gs5KiwKN9VswKwqBW6/WG4NKEYUAdy/EKLuPWZhZuumtkEufCi
         jOBGduS4ogeVqWoMqRFiCtda4lr+U/0nbCzw0MtW03a0MeX4KCZFH+qaOXlIOYAVeZx5
         wxtf2uE8HIXPDcCoBsCNtqKebZBF+k7lt7WS2anG/bl8GI9GU8mubN2VV1s6Im0Hz6BM
         SaIp3pjhGFJmajbLA7OJ91kw2hKQKniA5JWCe57zmlFvnA7QGJPX60Ht42u04ktdUxTB
         8dkw==
X-Gm-Message-State: AOAM533Brwz9G7wdCkqKSk63zebYqaNdNsDrAPpWJGiv8maFtLjzcnvA
        almL6ZlythC/KQgnKFhINqM=
X-Google-Smtp-Source: ABdhPJxlR4b5yCsECXPdOIT4LQuqAMQ+k1EBaQLYRI5JrR1Fb/d4vhCtTMy03QbgT4kqsgEryPDxjQ==
X-Received: by 2002:a05:620a:46a2:b0:6a0:3f59:e012 with SMTP id bq34-20020a05620a46a200b006a03f59e012mr19563878qkb.452.1652290050907;
        Wed, 11 May 2022 10:27:30 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-023.fbsv.net. [2a03:2880:20ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id q5-20020ae9e405000000b006a098381abcsm1487395qkc.114.2022.05.11.10.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 10:27:30 -0700 (PDT)
Date:   Wed, 11 May 2022 10:27:28 -0700
From:   David Vernet <void@manifault.com>
To:     Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] Enable CONFIG_FPROBE for self tests
Message-ID: <20220511172728.wtaojbqsdpm7mang@dev0025.ash9.facebook.com>
References: <20220511172249.4082510-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220511172249.4082510-1-deso@posteo.net>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 11, 2022 at 05:22:49PM +0000, Daniel Müller wrote:
> Some of the BPF selftests are failing when running with a rather bare
> bones configuration based on tools/testing/selftests/bpf/config.
> Specifically, we see a bunch of failures due to errno 95:
> 
>   > test_attach_api:PASS:fentry_raw_skel_load 0 nsec
>   > libbpf: prog 'test_kprobe_manual': failed to attach: Operation not supported
>   > test_attach_api:FAIL:bpf_program__attach_kprobe_multi_opts unexpected error: -95
>   > 79 /6     kprobe_multi_test/attach_api_syms:FAIL
> 
> The cause of these is that CONFIG_FPROBE is missing. With this change we
> add this configuration value to the BPF selftests config.
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>
> ---
>  tools/testing/selftests/bpf/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 763db6..08c6e5a 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -53,3 +53,4 @@ CONFIG_NF_DEFRAG_IPV4=y
>  CONFIG_NF_DEFRAG_IPV6=y
>  CONFIG_NF_CONNTRACK=y
>  CONFIG_USERFAULTFD=y
> +CONFIG_FPROBE=y
> -- 
> 2.30.2
> 

Looks good, thanks Daniel.

Acked-by: David Vernet <void@manifault.com>
