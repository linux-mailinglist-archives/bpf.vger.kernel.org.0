Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0957F634DF9
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 03:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiKWClM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 21:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiKWClK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 21:41:10 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A6E6E56A;
        Tue, 22 Nov 2022 18:41:10 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so672614pjb.0;
        Tue, 22 Nov 2022 18:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6Jv9dgaKHeIKt84vFzHjfQK6aTNPAun2YWKNGfNy8g=;
        b=Z1raQFEbFQAilRZzpJGT88HO/EyRiuotS3kA0tTOUZcTafDINqEQGUo7LdjUeyklJf
         4UfXNjDkLknUA78FkzoChOlJHoY1NK1nCYIC9FaoeAQ3cnwnui/DugvmmHDVAv/R428O
         B2f+GrvDdDRImOq112gsXHIfP8XBNSD4fqPj1VFZlmVsqiEx/qwM4S1SHCsCnWS4gwjw
         M/sERgqf+BS5jdLN7hvymErjTFbQgHg70iI7pFVByWsMpGMA5j0q/gCByxyDPV0rDUJ+
         mSjUETIeSEGXmRcy0D+I5PMLRm45oZqzTaS8A2lamuYtr+7A9CDXgjAGXc9cltUW87za
         nzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6Jv9dgaKHeIKt84vFzHjfQK6aTNPAun2YWKNGfNy8g=;
        b=7j0ZavFzSPrR4v/6PxRjsTZfrDw/v3kiTwuDY2T+rJwzi9zSkLBWZzck1XYv/49iVK
         QRSIvabUvwsJGI5WkhuH4xt9+Z5rExKYTh9YQ45B0bIg/sz0h2jqNt9Ix/RU9TQu3GdV
         Yl0ZQoAu4sBF0JsvMpBH/iRxM5jFtniVzR+3Jtj6WNkLN6ZatZ72shsb7VgQev2bU/hN
         dtvBjWcbO30FBLAYQUvFnyhvXoFVn+0pke8SmQd9VKG4Q0r5Y2IKw88ajITUMAN/gAzX
         2DBsD3tQWInq0zT+czLl/VRrScz63cj76OGgS1DUNzbSxcgE3sNwVmw0lY98Gvz6Qbyd
         Ld8g==
X-Gm-Message-State: ANoB5pm9R7JkEtkqcBqjaJ52lj/xAPmv3kYc08d9KdT1eVc1YcLn1vvQ
        rWCK5HmbA9N7w34llQTwz5Q1KI6knC0=
X-Google-Smtp-Source: AA0mqf40kXBy0QGL2xk6dsBf3fJy8KQqSJiz4iFy4xz6CbppxnrCMyre0LcItf7Y64r5KnAOaI0Nrg==
X-Received: by 2002:a17:902:848d:b0:188:f42d:5b1a with SMTP id c13-20020a170902848d00b00188f42d5b1amr6717496plo.26.1669171269589;
        Tue, 22 Nov 2022 18:41:09 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090341d200b00186b04776b0sm12835493ple.118.2022.11.22.18.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 18:41:09 -0800 (PST)
Message-ID: <d9640d74-a353-73cf-d51c-81d9cfb1606b@gmail.com>
Date:   Wed, 23 Nov 2022 11:41:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v1] docs/bpf: Fix sphinx warnings in BPF map docs
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221122143933.91321-1-donald.hunter@gmail.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221122143933.91321-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Donald,

On Tue, 22 Nov 2022 14:39:33 +0000, Donald Hunter wrote:
> Fix duplicate C declaration warnings when using sphinx >= 3.1
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> Link: https://lore.kernel.org/bpf/ed4dac84-1b12-5c58-e4de-93ab9ac67c09@gmail.com
> ---
>  Documentation/bpf/map_array.rst       | 20 ++++++++++++---
>  Documentation/bpf/map_hash.rst        | 33 ++++++++++++++++++++----
>  Documentation/bpf/map_lpm_trie.rst    | 24 +++++++++++++++---
>  Documentation/bpf/map_of_maps.rst     |  6 ++++-
>  Documentation/bpf/map_queue_stack.rst | 36 ++++++++++++++++++++++-----
>  5 files changed, 99 insertions(+), 20 deletions(-)

Thank you for taking care of them!

Reviewed-by: Akira Yokosawa <akiyks@gmail.com> # Sphinx >= 3.1

