Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3FF606EDC
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 06:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJUEWj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 00:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJUEW1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 00:22:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EAC15D0BF
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 21:22:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id q9so4433075ejd.0
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 21:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hbHe6pNmaqQ1j8F+cmbrHLPFEr+xT5Vc7xGC6wVC7VM=;
        b=WLgQhjtwSbxluw9HzpE5ypLh/NuzbmCltDAqqk+bRpJBu69hosVXmfW6LMEf9wiW49
         Zjp9S7pGfFm4rfQp77pFKkG8WOrR0Fv1BDxKQHkfGmKyDPZW/7uonBBZcWB+ujcqbwTP
         6+EbjrKL44SPXDkp1Sz4x/N+FSjoEOSF8Y+K+4DHuCcv9ChnqTjihIrQHbDZ1FnOTWvE
         YcSfSYVWdM7MiFpEWtEvJ6X9aef4ypUC/+CLnPII8TcxgAJx9JN+npyhuv4TbdT/lJBC
         FYa9slwNaOLCHcjIu1CPPlMDiy+68kOpHbYcNK67SUirlP2ZLL8w4nzuZ6ZxR4pTbGxL
         ok8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbHe6pNmaqQ1j8F+cmbrHLPFEr+xT5Vc7xGC6wVC7VM=;
        b=w3XZsUwflni5DFby48VGHeJKnoTIcAtrom5KtnBRa7iitUB+OiwDFBcwNGZtzmpANM
         VvHkz5JIXohOM3gvR9620iFX0k0TTRBgY8R3pS5LNX6ahhRn8n0WuBujpQvIoieomyG9
         tAPpDCbklYvmuu+pPPFaLpPUX8EcS1TSj34Gufzqll2YYabmcEZmUgvjQsF+CzinopnJ
         VYSYWWzCp2X/QJaPIygv2Tvq5hvQAsGQ/zhEhuNLbNEDYnD5OsPsLTuCfmrNF1Oh+hCX
         LFLUTnLCXc1n9nSGAf3E1eLXi4RX0L/GYtmL5XloytBBT6UUInzg2ACiuUEF5qPv1B2q
         2dng==
X-Gm-Message-State: ACrzQf0EruS6CU95D0MnP+O/lyqkwlpyvcjErbD585LxilWsFE+thuB8
        GMF5uBY49T8FIQpHfOO1VtKYBPjhoqjxelAkYOw=
X-Google-Smtp-Source: AMsMyM5QZlvQMfwsLzOrnBB3oCro+QPZagseN2ijy9CJAW+SWRgbf4L/wrn9kmMYDokmlT89tq8SjvKIuA/dLsO/5Pk=
X-Received: by 2002:a17:907:7f93:b0:791:91a6:5615 with SMTP id
 qk19-20020a1709077f9300b0079191a65615mr14323378ejc.708.1666326143159; Thu, 20
 Oct 2022 21:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221020142247.1682009-1-houtao@huaweicloud.com>
 <CA+khW7jE_inL9-66Cb_WAPey6YkY+yf1H+q2uASTQujNXbRF=Q@mail.gmail.com>
 <212fbd46-7371-c3f9-e900-3a49d9fafab8@huaweicloud.com> <20221021014807.pvjppg433lucybui@macbook-pro-4.dhcp.thefacebook.com>
 <b20aa49f-61ee-6275-3f8b-aa2b5e950874@huaweicloud.com> <CAADnVQJXdFsPXSQBhD9WD_66bWaGyq1x_=SY5UiFGzUqm=34Dg@mail.gmail.com>
 <de1173bb-3adf-a04c-7999-44e7e7103ff9@huaweicloud.com>
In-Reply-To: <de1173bb-3adf-a04c-7999-44e7e7103ff9@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 20 Oct 2022 21:22:11 -0700
Message-ID: <CAADnVQ+_xJzdLpJMucRA7wXRBUr7msDktEjYfcinfzrRGLfVTg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Support for setting numa node in bpf memory allocator
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
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

On Thu, Oct 20, 2022 at 7:26 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> How about reject the NUMA node setting for non-preallocated hash table in
> hashtab.c ?

It's easy to ask the question, but please answer it yourself.
Analyze the code and describe what you think is happening now
and what should or should not be the behavior.
