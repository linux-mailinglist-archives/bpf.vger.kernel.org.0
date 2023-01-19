Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB61672F2D
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjASCoI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjASCnw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:43:52 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C5D6CCC3
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:43:51 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v13so1166051eda.11
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QiDNlSaoi7mrYBR24sYJ3Gb7J5bSPSGiilOnQNME2EI=;
        b=n/1XiVB0W2gjgu3hdoPMWx2EXvswhkejynnIyfUgE9oSl4oMzTHows5NLdGE47FlaS
         kbvmUR33yIKCL//SJsuYZH8g1dBXVmwRH8sJ/QfjUNdMWU2OsW+dpEJ8q7+DgUlzB8dr
         6USVgoKoVK0ydCx/1csXnX6tG8oY4k44ChqffCVA17hZ9+byBbMuQQJtFV2CSHwcDrCR
         xZ/r0twWn4b+hfwKpgzrhaSjrYIIaNzZ1TXvFfNgYTZlcc+Dem3F/j5PQjFKEFtqpa2b
         tFqdvW4KqlWRzzgyWiT+9vwa4Ex00VhxWe6lw1hVfkwLwi1UuHkgrFNjhi7LDwnPziKP
         nEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiDNlSaoi7mrYBR24sYJ3Gb7J5bSPSGiilOnQNME2EI=;
        b=cZ4KLPJalsrHPtXA0cva37eMSkzQYaiBZcLLAtgrLlMbUGYSFwpTYrIZ61nqhztWHS
         /4ynhKP/ChK+7rPAGjnhMRgJKQrfn/UkYFzCkSjYawsplbE/wRbnZL1dLyFe/o5r8ib1
         e0dKL0rRD3KQbcmtvNFKeJK4Uq/Hy/poApyVVxPpgL6C5C7toYoQTXP38gprfUpFLw5o
         UF8Ta01rMCByhvJJMd/YTuXJXE2RHsGJoLwwcHIpu3pGpua3jPznbpyqeG72CDg9oG+K
         hNgI6M70zy7cOjEfOdcz7P8PZSCAUII1WEMv+cClov5dmaiFXHX1cWPOGu+7f6JJHcXT
         kkdw==
X-Gm-Message-State: AFqh2ko6NUzVWBueKtLvtH0lMNURfnYxuCWWehVnoidOQ0mKEn3A5sOs
        7Jw9sCCm6dM7IkDjOf3kEy2z8Femb1bfCqQlfVU=
X-Google-Smtp-Source: AMrXdXvPWmxZD2Sp6Sgx2SaHetDDdYPw8NK1L2qOrbDsPIpho/YT7GlG9ykMzp9RgAlow6rrj/SPuNosasTpzgY+OfI=
X-Received: by 2002:aa7:d718:0:b0:49d:c012:3f32 with SMTP id
 t24-20020aa7d718000000b0049dc0123f32mr1300963edq.173.1674096230351; Wed, 18
 Jan 2023 18:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20230118084630.3750680-1-houtao@huaweicloud.com> <5592d49e-5a8a-158a-093f-158ecca80cdb@meta.com>
In-Reply-To: <5592d49e-5a8a-158a-093f-158ecca80cdb@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 18 Jan 2023 18:43:38 -0800
Message-ID: <CAADnVQL9okYjd1eUXwJoMhu69rdFZMb82-aCymfCDqR_6iEfRw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix off-by-one error in bpf_mem_cache_idx()
To:     Yonghong Song <yhs@meta.com>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Hou Tao <houtao1@huawei.com>
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

On Wed, Jan 18, 2023 at 9:58 AM Yonghong Song <yhs@meta.com> wrote:
>
> >
> > -     return fls(size - 1) - 1;
> > +     return fls(size - 1) - 2;

Wow. Thanks.
Not sure how I missed it and why the tests didn't catch it.
test_maps goes through many key/value sizes.

Applied.
