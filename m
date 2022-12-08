Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC95E6466AD
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 02:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiLHBym (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 20:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLHBym (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 20:54:42 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F113D900C7
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 17:54:39 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so123547plr.10
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 17:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F820hvEjC8Tln7Ombg3pHE4UXL08XwaY9eNP4pc3pbQ=;
        b=Ksw6sSb3uQwGAKwB176etNGXiAgR9Ryeax/wQ8dPD2yAk1ro61gFZiYJLciRjY0Ers
         7HOfkcH9a7YisPNl48wG0e4UEkgXoeVDafgVyvoItJ7VIms08TuKv34QD0wDaPddoQ32
         OYvL4FQ1Dmu9k8LKUHdwQ4YvaI2/xkDiXLGsvfiuMdJ+Zpr/0bj0kBlVEnRKm+eiCRHi
         txLvKpgRH+JCuAbYzUhiVM6fnV8gfHAqfiykp7qEb1k7ApUnHkgnPxqPJUOCaEN3TyhA
         xaICryz0/cTctsq6nydya/939cmg+yUOA0d3eanJWqTGeXmTEb7H12Em8YiLLUVHvdyZ
         UjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F820hvEjC8Tln7Ombg3pHE4UXL08XwaY9eNP4pc3pbQ=;
        b=KNKV+Q7IpzBKJkXe2JddvJ2fTQez6dhQ5n674duQ/8nohjn8yR9fOd67uIpC70r1t5
         ny1BPuE5ozQzZ2M5+5iLmY6AkNO3+quRXfjUsL24OsBlbqzurGcg2x0njyV4DcymKMRi
         FakUmWhZ5aZw19ddI40puJFFvogsCrWUdqPeUKmwtqxFGQo6JaQMNM8p7vjwUpfJacIx
         JuAHUO4tsCdqqUiIAxzROKmWOrDU3ZPahov7RzhX47lEN1saLZ5M2+I198BlzksfPwvy
         PZTReq0vedBmUoHlQoimH7mVUbQgoPmU/RtN9LGX1UTcPOPbmH/rG4ttgT9LHxjFk768
         KVLQ==
X-Gm-Message-State: ANoB5pml0ivH0TEyfW8v5THlTv0gOH8Q+HE0wc+J3C7GYQHfSun6/kxQ
        pbWn7Nu3rgrDptzRvC39dKU=
X-Google-Smtp-Source: AA0mqf7s7PLV87O1HHskwu4GDlwaIVyfz3flw3uJZZqgPlrtUMNORUKIGghMiRMovmRTQZM1LEAsgQ==
X-Received: by 2002:a05:6a20:ce4c:b0:a3:7d0b:5dcb with SMTP id id12-20020a056a20ce4c00b000a37d0b5dcbmr2096983pzb.15.1670464479398;
        Wed, 07 Dec 2022 17:54:39 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id 36-20020a631864000000b00478ac3c34f3sm6276791pgy.93.2022.12.07.17.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 17:54:37 -0800 (PST)
Date:   Wed, 7 Dec 2022 17:54:34 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org
Subject: Re: [PATCH v2 bpf-next 0/6] Dynptr convenience helpers
Message-ID: <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
References: <20221207205537.860248-1-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207205537.860248-1-joannelkoong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 12:55:31PM -0800, Joanne Koong wrote:
> This patchset is the 3rd in the dynptr series. The 1st can be found here [0]
> and the 2nd can be found here [1].
> 
> In this patchset, the following convenience helpers are added for interacting
> with bpf dynamic pointers:
> 
>     * bpf_dynptr_data_rdonly
>     * bpf_dynptr_trim
>     * bpf_dynptr_advance
>     * bpf_dynptr_is_null
>     * bpf_dynptr_is_rdonly
>     * bpf_dynptr_get_size
>     * bpf_dynptr_get_offset
>     * bpf_dynptr_clone
>     * bpf_dynptr_iterator

This is great, but it really stretches uapi limits.
Please convert the above and those in [1] to kfuncs.
I know that there can be an argument made for consistency with existing dynptr uapi
helpers, but we got burned on them once and scrambled to add 'flags' argument.
kfuncs are unstable and can be adjusted/removed at any time later.
The verifier now supports dynptr in kfunc verification, so conversion should
be straightforward.
Thanks

> 
> Please note that this patchset will be rebased on top of dynptr refactoring/fixes
> once that is landed upstream.
> 
> [0] https://lore.kernel.org/bpf/20220523210712.3641569-1-joannelkoong@gmail.com/
> [1] https://lore.kernel.org/bpf/20221021011510.1890852-1-joannelkoong@gmail.com/
> 
