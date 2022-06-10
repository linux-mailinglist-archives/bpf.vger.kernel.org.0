Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2710547055
	for <lists+bpf@lfdr.de>; Sat, 11 Jun 2022 02:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbiFJXzf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 19:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiFJXzf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 19:55:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25AC12740;
        Fri, 10 Jun 2022 16:55:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kq6so802558ejb.11;
        Fri, 10 Jun 2022 16:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m2fXIIXeQGxSM/RZDHtCli6wPQtwAxjAErth8QWW4uE=;
        b=gh9IKPSk1pn6D61IY2qGzrrdlbFPdi6uDVVHGEiANe4eqku4MXjhjo94lxlNnTGyqo
         XNN3xX5yKDybwSWyHzr/RabT3R6UjhGKDUzLGrgCAjfACG1fx8AActWd6o5vphRBZzfu
         QWDzrmY2j/uv0P1CJw+Q37UUcUSdXZ6Wh2SsplOvCLtUNCgWN9i4NCSmaMEigpnUBDUa
         eEzHnuy2hjXL8rgWZiIonw53AZsUk56UiDP/Okh3JGo0adQawskZldyIWre0ScH4F3JE
         yG5UnX66j8zXsylLjAdoDHIbgxAuIraVeiJxf12Mm8ZeoOQdF9tawbKqAOv2oAaCj4rF
         1jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m2fXIIXeQGxSM/RZDHtCli6wPQtwAxjAErth8QWW4uE=;
        b=XZe+j8leGPXzxeBEOHbsONPzSx9hrVSbjOPocJSZ8dql1uJ20zXJ8fjfu92yCXitKM
         ciXxTn4d5l50qJ13P9YBVPo2kOsVHhILB27cgiKIMqvFoTfmdIJawfmZ1ZZk0zH4lYTr
         ZCtQLgkpZJcryaerJ3RFI1en2UnafvozriEoi6KNFNB8xBxwCojnvQ87dUrANtqMikUZ
         eaODPIJCD3be9iXcD6HtEt0gC+tOevyqJjkjj1f8dWCi1wDEw//cL3XYPKJ3mrnmbfrl
         x1X01czAxKWIz0Q4LaEcjzI/uRktqBvW7Lit4oOHNrRNXMoeZH5GRnxfwn/3Iuk9MbPV
         j42Q==
X-Gm-Message-State: AOAM533wO+BJseIxSTqwxT9Q5ShH8eKVqZGBFOsoD+4qfyoavuI5y0eM
        TfG2keQgwxVYmrBSBwR9RiBPTy8Kad+qpR4XU+Aqvwn2
X-Google-Smtp-Source: ABdhPJzZ/P/FaQm3gPaq3MIw10TqMwsCUU//pYhOgtv3RX4Oh+ktO3ddpaHHI6WiN9T7zxGH8qULKAmnSPrQ5p6v78E=
X-Received: by 2002:a17:906:586:b0:70d:9052:fdf0 with SMTP id
 6-20020a170906058600b0070d9052fdf0mr37262501ejn.633.1654905332409; Fri, 10
 Jun 2022 16:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220609234601.2026362-1-kpsingh@kernel.org> <bc4fe45a-b730-1832-7476-8ecb10ae5f90@schaufler-ca.com>
 <CACYkzJ6e2f+vdQmWBvRaQCJJ1ABPrfw4hYU231LbwhB_03GWLQ@mail.gmail.com>
In-Reply-To: <CACYkzJ6e2f+vdQmWBvRaQCJJ1ABPrfw4hYU231LbwhB_03GWLQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 10 Jun 2022 16:55:20 -0700
Message-ID: <CAADnVQJrbySvD9UB8POyhL6hKx6mEkh1EZfeWbmm5nTrfsyViQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] security: Fix side effects of default BPF LSM hooks
To:     KP Singh <kpsingh@kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>
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

On Fri, Jun 10, 2022 at 4:49 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > > In order to reliably fix this issue and also allow LSM Hooks and BPF
> > > programs which implement hook logic to choose to not make a decision
> > > in certain conditions (e.g. when BPF programs are used for auditing),
> > > introduce a special return value LSM_HOOK_NO_EFFECT which can be used
> > > by the hook to indicate to the framework that it does not intend to
> > > make a decision.
> >
> > The LSM infrastructure already has a convention of returning
> > -EOPNOTSUPP for this condition. Why add another value to check?'
>
> This is not the case in call_int_hook currently.
>
> If we can update the LSM infra to imply that  -EOPNOTSUPP means
> that the hook iteration can continue as that implies "no decision"
> this would be okay as well.

Agree that it's cleaner to use existing code like EOPNOTSUPP
to indicate 'ignore this lsm'.

Folks, reminder, please trim your replies.
