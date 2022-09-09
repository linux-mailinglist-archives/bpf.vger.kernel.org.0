Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587245B3C14
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 17:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIIPfE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiIIPei (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 11:34:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0D83ED77
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 08:34:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2992A62044
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827DFC43142
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662737571;
        bh=xaEbntIVqJSxd2glqwN11spCOK8wjtV6bPs6jb9Vc4U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FZaXRlFMGUlIwZ1OXpi3U9K4Q9MGDIXqXdcJ0MFILNV0Lx1PAqExq+XaeUifUfAyP
         0b/+LgzNy1NmJR9I8/yJj6cDghB4LgYg7XemWdGLR1xTPWwCS31glq8jtyV2iiyqt3
         /gjt5IIiBjyyNvI2o8O7RrWO/VAAXIKYQcazyl44wMhGayWWgrCqtF7Bv0U4K87iVo
         NobMt9+szlXwlt3fi6N50O9vPuIzZyuOMJnT3LLG2JM6upGsptRGQQ+K0K0btXVDGH
         wxeCWrnf/43iIUToqK8trHrQ8xvTJnZ9HLNZ3FTbpkwj2tujIy57Zb0LnGWCfvrcrD
         xhGTKtRxEnoaA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-12ab0eaa366so4734925fac.13
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 08:32:51 -0700 (PDT)
X-Gm-Message-State: ACgBeo1EwQDmscmDJe/CjZEvM8JGfZNnuKUYBNfeBSfiZkcDQCk9vl5r
        pH9awcQRBlRL5HVZcvSWaLy1Ugzvv2MdJoSBb8g=
X-Google-Smtp-Source: AA6agR5A5gVpPbp4bofnb8vqg0ebDN+dgnkyTO4Oxnb68e/TVbgONWZz1W8YWuNqYh7CnQzd9v9inpRQApiA3Y/OYrI=
X-Received: by 2002:a05:6870:32d2:b0:127:f0b4:418f with SMTP id
 r18-20020a05687032d200b00127f0b4418fmr5553706oac.22.1662737570721; Fri, 09
 Sep 2022 08:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com> <20220908000254.3079129-3-joannelkoong@gmail.com>
In-Reply-To: <20220908000254.3079129-3-joannelkoong@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 9 Sep 2022 16:32:40 +0100
X-Gmail-Original-Message-ID: <CAPhsuW5QSnr1s=wOrjb_fkzwX1rYkVzL4mdKRkdgQ+W7LszBdQ@mail.gmail.com>
Message-ID: <CAPhsuW5QSnr1s=wOrjb_fkzwX1rYkVzL4mdKRkdgQ+W7LszBdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        martin.lau@kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 8, 2022 at 1:10 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Add two new helper functions: bpf_dynptr_trim and bpf_dynptr_advance.
>
> bpf_dynptr_trim decreases the size of a dynptr by the specified
> number of bytes (offset remains the same). bpf_dynptr_advance advances
> the offset of the dynptr by the specified number of bytes (size
> decreases correspondingly).
>
> One example where trimming / advancing the dynptr may useful is for
> hashing. If the dynptr points to a larger struct, it is possible to hash
> an individual field within the struct through dynptrs by using
> bpf_dynptr_advance+trim.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Acked-by: Song Liu <song@kernel.org>
