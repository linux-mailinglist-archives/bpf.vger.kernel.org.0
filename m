Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED3A62A222
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 20:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKOTpe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 14:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKOTpd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 14:45:33 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA54E22B14
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 11:45:32 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gv23so5994693ejb.3
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 11:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3jgfWB/btevfgWd08dSeLuagkfgv2e99I83W2wLf4=;
        b=C/hQXSenjGEyvSvUsYUIEoHVHZHnsxxxe18hXq/v6Y9lXIeew9g2R1Fjc1DbiKhYd/
         f+HQih7JEX5tHl0K16O8AgTHPpaynox5eJ9cW03/bMTrpDLjB1d9J1pmM93LjZCH4Qc2
         4F6dxhcCFtDBrnMI+EyF6Q7e9nJamCgSFvF+wRbpZTWrkhuCh7AmBwR5Yv/rfwqgkaz+
         aubtTEyJlxj19rFnvM5MToKYx7Ej44wLUDZAUefeNn4ypcyupitHK4ax2wdEORPZek1V
         1r33A1HM8+ME+3M2Xyc31qXYfin/UtsvbV4iqJO1RrCmbGpxGZ6AijD53gh4fQFzt/1J
         PFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJ3jgfWB/btevfgWd08dSeLuagkfgv2e99I83W2wLf4=;
        b=kb0Lane6tmudCpgQJzi8+/KR739oh2empZdBZtALs9CC3TT1dJs5XlIewNUolVzjkW
         a8aBw2+tx2GrfyiE9GHzS9QAh7ajS5HlAW1qsiHUYqewr+9lNAjetjphQ7UTnyHGzoXA
         ZntoPtRN7++j+EhPx6GSY86jsfuG+4x9LYIM5k7VLIo1LJGk3hrVzYgj0eIOkv1VmaXq
         gzPU5yPmwfmR68cWh3YGbKUiXgowfERARUV/7zHXQPB3VUwmU9M7mWzQRgfiWb6+ufC1
         dXFx/+p3aiaRbgLk2YOR9fE/lWpqjcpw4Yizg3BJtBEqsFokIiaB5xyMfTqeYKkKlphK
         yGpw==
X-Gm-Message-State: ANoB5pk9fp12t8VTbVL7uHDdADu2igAord24JIPxyeWVX0WxySUzBWha
        WEDDpmLXK+GGytOmkjsqmDIGsoZfyh/98f4OXxs=
X-Google-Smtp-Source: AA0mqf4be//zjtvG8HIFsUSLyKQWhhYPk3+V6KdAeUMEhBvxKVrxxtOUcmlNTg5T1e/JUIxutUzGfQXdrs0BIUaPkQ8=
X-Received: by 2002:a17:907:770f:b0:78d:c16e:dfc9 with SMTP id
 kw15-20020a170907770f00b0078dc16edfc9mr15210770ejc.327.1668541531277; Tue, 15
 Nov 2022 11:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20221114191547.1694267-1-memxor@gmail.com> <20221114191547.1694267-21-memxor@gmail.com>
 <20221115062637.hzuo7ehffpuxflsw@macbook-pro-5.dhcp.thefacebook.com>
 <20221115165951.fy7bqwcum3veiz2d@apollo> <20221115182616.ctmabyirb7vdpa66@MacBook-Pro-5.local.dhcp.thefacebook.com>
 <20221115193623.ncblmxapyiljqsuw@apollo>
In-Reply-To: <20221115193623.ncblmxapyiljqsuw@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Nov 2022 11:45:19 -0800
Message-ID: <CAADnVQJnGOe6UcF8CSSZtch6gdScCwknq6rp-X7PqyRUCShu=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 20/26] bpf: Introduce single ownership BPF
 linked list API
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
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

On Tue, Nov 15, 2022 at 11:36 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> > It feels the users will be hitting this error case from time to time,
> > so the most verbose message is the best.
> > Both options above are a bit cryptic.
>
> How about something like this?
>
> operation on bpf_list_head expects node at offset=X in struct foo, but
> node is at offset=Y in struct bar

Excellent. That would be the most accurate error message.
