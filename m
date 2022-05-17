Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3FB52AECB
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 01:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiEQXnV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 19:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiEQXnU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 19:43:20 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A236327
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:43:18 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i5so457556ilv.0
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Yur15fkhaq1zRakLw2DID9FWLWft7XXHyZjRrWa31I=;
        b=Vy7v90sP44pwLf5WyJW7US7U4+zCZjUYkCx9lPqT0aL6WEi6kbK/AvwQ3ngwD3bc3d
         mg4Lg10VWUyJhjoapkUjfVXMBY0d1Ed+UBzq/VYy19T/j6Y69JaCtrCANFa8+U/aJr7u
         PPNchLzIkkAIVZC630e8xjQ3cbF+gGPFzZNk+yQbLS+qNEHYhfb9Iv3Wrg60TvXSuO2F
         qkPqVJsoSeqKEdEDCm87pHGrxfYkh64BG0vzY9exPZHAz7ahsTewQmeiEPLGHxRDwDPl
         3Oi2aY+OTLltyIQDigapB3sWOAbguLp8Onl7UA4zkdo58rgSynP/Xo04mxDPIrDFYCnW
         v/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Yur15fkhaq1zRakLw2DID9FWLWft7XXHyZjRrWa31I=;
        b=62kCBI5r+cgFMd8rmxCWyCYn8pkEsvd7gX0AKqxgS+Hhxud5eyImL0fCMTB0muSQ8U
         lZaVQ9+dPDO44JzCJAiWgcdcX8AMCJbEd5juvdrHzWfnu9flow+y2UBBqRX0keisEafF
         g16oqaZd/3eDscHVLDRyQQAtyihLMcbI/kIcuXbNb1eYaKCNr8/msNqetA3abdNogXjx
         xB7PaWM6rnMNP7HF++td0xRsDGlPVbBr/nwCIhLyygvBvupUxtaRB5KFhqoTU06bWvt3
         4BXPPNG7zU+T529YBamyy6wzuMnOnfcKjiPwiLeqML25Hkkgua2Y5wwHiAZZrSiibVhR
         K9Pg==
X-Gm-Message-State: AOAM533QG+8nKFMB6DlqnD9kBUaC43B5eWA2K1ecWYnGO0jkeXsx++NK
        EE+t8T5AS7fRxGzJBQpAISRJTOKRi55Ovpy5oh2sE5zAWn4=
X-Google-Smtp-Source: ABdhPJxxgxD6M9C/Ioc1KP80k31O0yakeAl4Oxa3DXIGg1zw7XG8Drvw2lfIYtp24KX25ktcpCd53cxr4sUjJYAn/Jk=
X-Received: by 2002:a05:6e02:1b82:b0:2cf:199f:3b4b with SMTP id
 h2-20020a056e021b8200b002cf199f3b4bmr13185414ili.71.1652830998216; Tue, 17
 May 2022 16:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031340.3246580-1-yhs@fb.com>
In-Reply-To: <20220514031340.3246580-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 May 2022 16:43:07 -0700
Message-ID: <CAEf4BzY=T7bc-8HhFKDHUAFkCQgUGSR9osfHzJU4gGzRpUekhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/18] selftests/bpf: Test BTF_KIND_ENUM64 for deduplication
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add a few unit tests for BTF_KIND_ENUM64 deduplication.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Great test cases, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/prog_tests/btf.c | 97 +++++++++++++++++++-
>  1 file changed, 95 insertions(+), 2 deletions(-)
>

[...]
