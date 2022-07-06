Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E799569596
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 01:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiGFXB4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 19:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiGFXBz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 19:01:55 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1E020F72
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 16:01:54 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l14so20443485qtx.2
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 16:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PtNM1GEZDSdRmQMZQoeggIYPPP+5wqHALbDWGxuW5Cc=;
        b=Q5GA+WIFBxr1AvdVtYRnT+47GWrXVpL4qFWtF4+6IsSV+2SRJGr5EHycebrSGzT9D6
         KbePikb19U8h4mXTBPkve1L2iyLedbWhDVMS1885oEQ26Bw+6StZX0Ft9YPOj65HOxD4
         u9Wtx7lBUNZp1GhGKZIBsTXDLkQYtY4AKEjHKeLqGAXy+0SG/EOKe4cdX+ilj1UQBIF2
         Ipik/JGfEdWnzFIoF5AjZTHno5E7xHFy4ScshLG79WJt2KL0jlwgGg48bahcMqtmYS5q
         ICxwkuW8PDyla0Yu973s5vH2LyeeRblMxs5S7IKHHaTxfGM27EZq0EZCu4HABohvNQDG
         lqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PtNM1GEZDSdRmQMZQoeggIYPPP+5wqHALbDWGxuW5Cc=;
        b=ibV3b83MTK+q6sj8QSLKYoZQk3aOzguT88r8uNSOsYgGfa9KQ6xKCPvkdARKJJKs3R
         2QC6KHYyjuihfqRY+4jvIOohNdz/UAECrt+uA0vn8vPwuwMM/4fHj0zn4sHP6l35hOot
         5sv1Cjosye7bvewHWrg4Azybg1KcePZCbaO6Oy1S7kqr7c/Y/DyX9E88onaD/2tpIBEB
         I0utw0tIL+kP9WCVUMiv6FE/BDFvH+5j6f4RjU9igEGZFgd9NMnbf93o/rh7J06uIrgs
         O+WQaj3rdz8E4gz5RQLohmK+l3P3wcNomjPWoKmoigI9DhPBwwiNX1mV6QtNIoy0Yws2
         yG2Q==
X-Gm-Message-State: AJIora/JJWM4JsEigKTtLlhcE9oYL6Mvzy/u1eQNKnIjVwciwtgp0RSq
        arKFjYREZebi8Dmwnp7WJatMn7WygRmPOhv+PMDjUg==
X-Google-Smtp-Source: AGRyM1udpm2O+FOWxGd36c7AV3UpmX/cXi9qnAvOXyNitk2mFoRcQAvdHwuLHr1CAZfSltNwqJQ6erI2QtRUjI6DJpQ=
X-Received: by 2002:a05:6214:202f:b0:432:4810:1b34 with SMTP id
 15-20020a056214202f00b0043248101b34mr19087377qvf.35.1657148513364; Wed, 06
 Jul 2022 16:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <1656667620-18718-1-git-send-email-alan.maguire@oracle.com> <1656667620-18718-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1656667620-18718-2-git-send-email-alan.maguire@oracle.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 6 Jul 2022 16:01:42 -0700
Message-ID: <CA+khW7gY5qAqP+EsHzEqrAk5OFKdR4Fhy76v_5WN+0ko+vkgsA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: add a ksym BPF iterator
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org, void@manifault.com,
        swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 1, 2022 at 2:28 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> add a "ksym" iterator which provides access to a "struct kallsym_iter"
> for each symbol.  Intent is to support more flexible symbol parsing
> as discussed in [1].
>
> [1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/kallsyms.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index fbdf8d3..8b662da 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -30,6 +30,7 @@
[...]
> +
> +static struct bpf_iter_reg ksym_iter_reg_info = {
> +       .target                 = "ksym",
> +       .ctx_arg_info_size      = 1,
> +       .ctx_arg_info           = {
> +               { offsetof(struct bpf_iter__ksym, ksym),
> +                 PTR_TO_BTF_ID_OR_NULL },
> +       },
> +       .seq_info               = &ksym_iter_seq_info,
> +};

It would be great to allow cond_resched() while iterating. Disabling
resched is unnecessary for iterating ksyms IMO.

.feature = BPF_ITER_RESCHED,

Hao

> +
[...]
> --
> 1.8.3.1
>
