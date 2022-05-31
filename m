Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6186539A3C
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 01:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243717AbiEaX5f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 19:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbiEaX5e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 19:57:34 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E2C1A3B3
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 16:57:33 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id c62so55739vsc.10
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGsoyZ11s4rwB9WpTRZ1U/WtvIXK7dzZbADyFr6Mkhg=;
        b=qKoFoheGZYnN0llN0Rn3C8X69Pc109/W8zKJ1naHGD9O71sEM0MX9CHXIg38sWF7Mf
         P670mbyhpae26wNBBYKFU4IZBXrKY0TrYulQuY197ab86DlEwALPGQptVk4k5Ebm1dK+
         LS39NEFvfLG4oHFHGCLCKCQNBw/EzM9jji9i/VqYUZ+X6iWyrXWFcXni7GrFK9rtgmHZ
         ax4UFEnU+V8IKb1q/Kql8/FSM9m8ExVbzMTpG9drpuKW+gF3Yf8gLyjahQ6t0AHWhR59
         KzhgCxnUwwAiCRykhlQgw301KC1voKbeF+tbeHafELXkNTUOVpWoFxqoNkdvWzfai//y
         E2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGsoyZ11s4rwB9WpTRZ1U/WtvIXK7dzZbADyFr6Mkhg=;
        b=L0c+vTJ9KVQ8I/WjjDWfXBpxuxhtJ1tS20uORQ8FH/fH6JaUy4wGjIdMZaRvOxE8Qy
         k6IvimQCE0ar8dyUNTyZzOColq933VqQFDQR8pk3emuRhpHxF/pee4IueEXEXknWxfLd
         TbnL7REwwA3M+K9NyDbsQXfcSX6zHhIjjo3KwsY2wU9xKoJ0l7IUDTZRBXZgnLjYpu69
         MsBtLh/VMlMo+h04y0IYpwMrM8kABZZf+2TZILrShQ5XBs4NYAkmI8lgKx9DbNWsLUhu
         zFyE3ahAslXK+SVbF5/IMtf5HpxbB52amAsLjWjlp8aWAhR1LiumOOLyqGm1+3uXnYM7
         8OkQ==
X-Gm-Message-State: AOAM5313aB00fRH9ET6fIhZusLLgvAwWuQ+xF18Oo9uW2ar49Toxa6qp
        kv2XAZFHMpddtQpKciD1Udlnoz0xHMKLFbr3a+c=
X-Google-Smtp-Source: ABdhPJz82pNXXpBINRWh5y3exbO/67d+Cool/nV+ueCOwt9kQnvmvVpPZYRiMnC2j1zjn33sLRu9MtQNmGAN3SqDu1E=
X-Received: by 2002:a67:e0d5:0:b0:337:b2f4:afe0 with SMTP id
 m21-20020a67e0d5000000b00337b2f4afe0mr19050422vsl.11.1654041452544; Tue, 31
 May 2022 16:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220526185432.2545879-1-yhs@fb.com> <20220526185509.2548233-1-yhs@fb.com>
In-Reply-To: <20220526185509.2548233-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 May 2022 16:57:21 -0700
Message-ID: <CAEf4BzaJCisZuVWPtriqzZS3T=DehvNC1ouXiTJx=4msSmAoLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 07/18] libbpf: Add enum64 support for btf_dump
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

On Thu, May 26, 2022 at 11:55 AM Yonghong Song <yhs@fb.com> wrote:
>
> Add enum64 btf dumping support. For long long and unsigned long long
> dump, suffixes 'LL' and 'ULL' are added to avoid compilation errors
> in some cases.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/btf.h      |   5 ++
>  tools/lib/bpf/btf_dump.c | 128 ++++++++++++++++++++++++++++++---------
>  2 files changed, 103 insertions(+), 30 deletions(-)
>

I suspect we have bug in btf_dump_get_enum_value(), we unconditionally
sign-extend values. It seems wrong. Can you please extend that part to
take into account signed bit (kflag) and do a proper signed/unsigned
casting? Thanks!

Other than that, it looks good!
