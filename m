Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D340526C08
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 23:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380411AbiEMVGu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 17:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377240AbiEMVGu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 17:06:50 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640663A2
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:06:49 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id s23so9993547iog.13
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BV9pVRqog/CjR6sAfpA5Lva5o3uqpgJp7Y4CUpTMOUk=;
        b=d+MLIA36L33AkPK2swLX+Q49Y7m7PopbNaStaFhuud+MsoABxz1EOtgRXi81SsFfxI
         4UmmwD3L4XM9KrPPw/jSM7iWUeytNsqtmEBRFBKiDyohNjiu84DvwADrN1mvMkQshQgv
         ut1j7lN9YGwdOY01W9cnFSOcAMeLPzQe/IRTwwDHiNQCOzTs05wZFvTadJ1oIHtUY3ro
         1UIlAox6GYKDGEkxXqYLWyBzIIiJpGk2GakmfDLXZYp4nRvj+50sz65Ja0yVGKEl2W1R
         q8Z6JanhQtU/XJ29Ip1/m7RQsnOvMwYjvCOZESnKpaE4UGrnyjl83ZVtHC6FofqtsXOs
         avSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BV9pVRqog/CjR6sAfpA5Lva5o3uqpgJp7Y4CUpTMOUk=;
        b=Ueo2gR4vmVxsvgYSbEqFrbayIZ1TmkxOU9ElWasEtQwB7+pfn4OF1H9e2ml3Y9Q/zV
         gC3NUAtEu05dv6Wym1/CqOdvUFibOZcia2jlQE8Z2ZjmKtlvaILQkj4py2DxYAJeJqQJ
         VIklC2VTA/SXnTP3tBPSIsLHvZl14JJO/qiMMNn4E5cHyPQcxq6yY1qnICKCsHSiob0W
         EPgn+KZ6+7TVKc2Bw9ibdoerFJV0ZKkDbe8MUcKiiuKpqNensBl0yTDLHfajkpy6ez4L
         jgWiqbFQHP/6MZahSwRR4coOUXfllIMBYFewx6ySFDqmseSP0RKnhRjCpG8NR2RwzGlV
         4xJw==
X-Gm-Message-State: AOAM532fmPoUolJ4bllUM+TWVpUBGe+pBiUakX5E1dZi4alPJmXSoCeh
        Fo8ckXUQMeWb7UtUzbPnxS/wReBqDb5+5iZaQOE=
X-Google-Smtp-Source: ABdhPJyV2konhIvOTg20BWDNPeULSjAHDGNqBWMqvtKug0q6+SxO67IGspT8kT2G39notifQPMpas7ok8zAKdZmWo3Y=
X-Received: by 2002:a05:6602:1695:b0:65d:cbd3:eed0 with SMTP id
 s21-20020a056602169500b0065dcbd3eed0mr3111936iow.144.1652476008945; Fri, 13
 May 2022 14:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220509224257.3222614-1-joannelkoong@gmail.com> <20220509224257.3222614-5-joannelkoong@gmail.com>
In-Reply-To: <20220509224257.3222614-5-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 May 2022 14:06:38 -0700
Message-ID: <CAEf4BzYv-hVvmpuCzmZP7hZfaDhv0Uer8VD_M5qa9-DcwT2XUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/6] bpf: Add bpf_dynptr_read and bpf_dynptr_write
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Mon, May 9, 2022 at 3:44 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> This patch adds two helper functions, bpf_dynptr_read and
> bpf_dynptr_write:
>
> long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset);
>
> long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len);
>
> The dynptr passed into these functions must be valid dynptrs that have
> been initialized.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h            | 16 ++++++++++
>  include/uapi/linux/bpf.h       | 19 ++++++++++++
>  kernel/bpf/helpers.c           | 56 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 19 ++++++++++++
>  4 files changed, 110 insertions(+)
>

[...]
