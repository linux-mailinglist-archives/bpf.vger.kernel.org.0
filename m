Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3F45EB942
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 06:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiI0EhG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 00:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiI0EhF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 00:37:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4BF9C234
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 21:37:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a26so18228884ejc.4
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 21:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TLiFMhau8IGVeOuN2QnwxQVgVaFtjxaCH5aYcKQZlB4=;
        b=lzttZJHw12TGlfH2LJH3jrEjVPOieprIzRTT3CqcNcPZj9jq/JjK6CfnQDsIuirf7g
         bv4bDYW+7xpY2eGzMO1RBgne4DWx2Ou4JtAhIcQEb/jtdBfgfC0FMcUSGi+cyI6Jdhen
         sR2tlzJYRmomH4QneDyYxa4wV1VChC1d8KNqfvO91mhc0Li3eF51ZXvCGXnfvxRMJIzM
         eG6wIzFmKILmB1XnkavXPapAkhrd/q76xfRj7F9jxoEfB7YWuUGxnILe/dwoW4YLxR2R
         Fz6IUA8FmWDYKeHgmyaWrORihvcJfgqAE3hFydDUFvsnmb4ftbvo7Dxk/0ih1/vyFdax
         WovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TLiFMhau8IGVeOuN2QnwxQVgVaFtjxaCH5aYcKQZlB4=;
        b=ZXBPzubvnAcPKyc+bqx4xy6X6iSMxvfhxL2fWqKtUCKDcBe0zbQS4xx9rL4RCzHUkm
         uAFiU9/mfsj4WcsxvdGcrCAoYvD9bWaLGtc0MokKQEwWKicV0r3JgNgJq7+wMOmYIwzi
         lKpBNz9/pMUMqroDSVM160/fY2YeUwokHMLCbA6yGMNqskDucm0/llSuev7cNXKL9OdN
         4uQvPySwdGaIN9Orc+LyZ49JIpcjYQJQuiIeQVaYIIai65uwPs2UU3T3BNgNt/lHDOZ1
         RP6TYi0O5mFWAGqguMlzqXvfNeBMoRoVfnBsbvxGsydJfoQoC84HvCXVVe1TPNZLrLMy
         eK9w==
X-Gm-Message-State: ACrzQf0cjYAlBw6/RWLBKY5HMxrsFTi4RfImMvMWS/mKGyjyf41gsdbH
        cWrfwU74mOwWgoicE3x7cFJ/BgVPo3IyK5IgKQp4LT7a
X-Google-Smtp-Source: AMsMyM5wPiGaBy/pSaZpeMB0hER4ic8OTCDtmPCVn+q90rmracb6OkXrQK4s+52IPVMuQaYDHwpmZK+221pZlKBqkgE=
X-Received: by 2002:a17:907:984:b0:77f:4d95:9e2f with SMTP id
 bf4-20020a170907098400b0077f4d959e2fmr21771819ejc.176.1664253422151; Mon, 26
 Sep 2022 21:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <SY4P282MB1084C694AB3F6C2DD3DD3A379D529@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY4P282MB1084C694AB3F6C2DD3DD3A379D529@SY4P282MB1084.AUSP282.PROD.OUTLOOK.COM>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 26 Sep 2022 21:36:50 -0700
Message-ID: <CAEf4BzYbmi-NQ8qQuMmCWCG=0V2z4SuKogb4y-WrUKkL1iw7-w@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Add friendly error prompt for missing .BTF section
To:     Tianyi Liu <i.pear@outlook.com>
Cc:     andrii@kernel.org, bpf@vger.kernel.org, trivial@kernel.org
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

On Sun, Sep 25, 2022 at 10:54 PM Tianyi Liu <i.pear@outlook.com> wrote:
>
> Fresh users usually forget to turn on BTF generating flags compiling
> kernels, and will receive a confusing error "No such file or directory"
> (from return value ENOENT) with command "bpftool btf dump file vmlinux".
>
> Hope this can help them find the mistake.
>
> Signed-off-by: Tianyi Liu <i.pear@outlook.com>
> ---
>  tools/lib/bpf/btf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d14f1a52..9fbae1f3d 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -990,6 +990,8 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>         err = 0;
>
>         if (!btf_data) {
> +               pr_warn("Failed to get section %s from ELF %s, check CONFIG_DEBUG_INFO_BTF if compiling kernel\n",
> +                       BTF_ELF_SEC, path);

This is going to be very confusing for any user trying to load BTF
from some other ELF file. If we want to add such helpful suggestion
(and even then it's a bit of a hit and miss, as not every passed in
file is supposed to be vmlinux kernel image), it should be done in
bpftool proper.

>                 err = -ENOENT;
>                 goto done;
>         }
> --
> 2.37.3
>
