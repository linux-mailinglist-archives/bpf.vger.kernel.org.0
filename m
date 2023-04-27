Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3722C6F0BDF
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 20:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbjD0S2P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 14:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjD0S2O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 14:28:14 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800133C29
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 11:28:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24bf43fae6bso2304755a91.2
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 11:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682620093; x=1685212093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4aLQGpFNX5qly7iV9G5CqlTNQWcBkLYmo+FRHaOx6I=;
        b=NJoFhRto2PQlOOjbzPh9oXFg+y0CSQjCKSlgskjud8bzXf5fB0gjG/g6rrcha5ydRJ
         MIe954s2abHb0UqqKI+4rcQY0IbPgvVKEF6AAA4lqtGYEbLILWHLBfdbIYgU+telaUf9
         dm1fgFK1tc6p2yEq2NWQLjVNjOiBk3h7w4F4OjgO54xCc9K0bopRwB35McFiyZrKkznJ
         6X3TdWJk3vw51Ja1MpHnDSjEY+dDE+gm47O2Ly4xVM8B4zgs6vYQX9bufUoOWWU+vTrU
         8tzfms2tiV6IFB0F0VFvoS7xj2rZhd8hYo8Vzno34/8D3hy4Ovgi7QOmqwtBmR41AEGO
         jIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682620093; x=1685212093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4aLQGpFNX5qly7iV9G5CqlTNQWcBkLYmo+FRHaOx6I=;
        b=JWBb3ZfnJGegJyHdvUWm3Z0UvWj4RlsYWDC4RKXFwAFJNL3A5370VaPFqUtb6iYgfD
         O8p7GoKYewfm+6uGFGIleusuogZD8Oi208hV7xFiQvPDsX+XwlY5w9fi3g/VaQ2NUzm4
         UVtgZb0w1GYRkRyqWoY35x5GvHeM8TYRDePlBakaCRwFtvj9khcpgPPZEhGHJyyrLn4u
         x8V5Kdp+OhN34Kz+XM3BPhuvfMljf87jE2Ytl7SoCEdXNTFhJ/WSDbT1xPfhDVCQ49bZ
         F8IXJFSxGf/+5O7ZaWqZ7gIdjFUN716NnGICcHHXie5z/dKlu47T309nuha3fr0Bf33m
         VPiA==
X-Gm-Message-State: AC+VfDyFPoUf+6tXPe8Le2uH35LCTOqDuVUAERbJnkzorukJ5PHFLTn/
        8a0X8HL2gzEDNW+VB3kyxlisyWw=
X-Google-Smtp-Source: ACHHUZ7+0lDE62NqgN7SOmFhEMUOybYiJhSDJKluYTuON5gTSMdUBLUULYmHIFAtGf2ugW7CW6uK/Ls=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:3881:b0:247:9111:9d0d with SMTP id
 x1-20020a17090a388100b0024791119d0dmr728351pjb.4.1682620092950; Thu, 27 Apr
 2023 11:28:12 -0700 (PDT)
Date:   Thu, 27 Apr 2023 11:28:11 -0700
In-Reply-To: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1682607419.git.legion@kernel.org>
Mime-Version: 1.0
References: <88e3ab23029d726a2703adcf6af8356f7a2d3483.1682607419.git.legion@kernel.org>
Message-ID: <ZEq+u0CWs8eO2ED/@google.com>
Subject: Re: [PATCH v1] selftests/bpf: Do not use sign-file as testcase
From:   Stanislav Fomichev <sdf@google.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/27, Alexey Gladkov wrote:
> The sign-file utility (from scripts/) is used in prog_tests/verify_pkcs7_sig.c,
> but the utility should not be called as a test. Executing this utility
> produces the following error:
> 
> selftests: /linux/tools/testing/selftests/bpf: urandom_read
> ok 16 selftests: /linux/tools/testing/selftests/bpf: urandom_read
> 
> selftests: /linux/tools/testing/selftests/bpf: sign-file
> not ok 17 selftests: /linux/tools/testing/selftests/bpf: sign-file # exit=2
> 
> Fixes: fc97590668ae ("selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc")
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  tools/testing/selftests/bpf/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index b677dcd0b77a..fd214d1526d4 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -88,8 +88,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
>  	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
>  	xdp_features
>  
> -TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read $(OUTPUT)/sign-file
> -TEST_GEN_FILES += liburandom_read.so
> +TEST_GEN_FILES += liburandom_read.so urandom_read sign-file
>  
>  # Emit succinct information message describing current building step
>  # $1 - generic step name (e.g., CC, LINK, etc);
> -- 
> 2.33.7
> 
