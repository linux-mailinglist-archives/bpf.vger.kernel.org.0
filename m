Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECBC5AF395
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiIFS3y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 14:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIFS3x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 14:29:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDA64D253;
        Tue,  6 Sep 2022 11:29:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 29so11219659edv.2;
        Tue, 06 Sep 2022 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nnW0gh4/5RbElboZnDeZlyzS1e6LNOQ80svTWGcDjDo=;
        b=Qe+vUnlQNcxNOXltmkpjWbPqfsi1WAYaUaKTSmIpEUgzBt2Iyw+UgHMTwaIbwMfVa6
         7T5SH0nEkcAt0NPEuJ4G45WjTDAuRCFwUmWFPqDjx7NaPIMEebV6KBVGWSU9H9N4hf/3
         d/xVA5SaMOMZ9pzEmxF9qXCASQUYSf6WQ7raxslLgXRcbGtI+tG2HUvA3e+3rrsv4Ox8
         QYo57B0UBTrQ1lVOa1K4FeXOTy3zKJoEmRnbqCXN/MLg5u1cxWNcQgctJYCT+i3p93p8
         dY9Nm91Cv0enJUuPePggqO6DAUtapN1BZKEdeWhiChApbsrQaHnZeBr3so7nhMbOfPif
         31iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nnW0gh4/5RbElboZnDeZlyzS1e6LNOQ80svTWGcDjDo=;
        b=VXfsYO7MumH3j67zfNy4HKqvEHXd1xOFFdcxLwicoiQ/m+izJxleeRQBNRwxzZcUpB
         dReLqEVy5fxHdDESbPWIdFtPBVnWX/foopSUYZ8vIS9zyDPMkTLFt94tQjNd1wfAvZfm
         swAI62Qk8uGdcGG1yl/4QTaPNqYo8GlDexg0ImkAZO9kfBvgAn9MUAgsc82tR9i/IaNN
         XqDnt021l8yPfdy9lCtzDCRzAI0K2Xv7SRAQTesP1lvAKr9QRKzwo8RK3Otpv5xKJA7G
         Vs1iiVY0Patp3MH8XTlLb9fEAfCDurJ7mViPPOadcOHigwWlO9ZLOtmf6UVIkJ3Qg5lJ
         1B4g==
X-Gm-Message-State: ACgBeo1V8BkZ+n5sJgETyrjaY9tku4lgbVCmLaRJbtRG5WDc+rragwX2
        ndtlxaKtNDc3bGdIg55ugnXPFvUqgK9B3KSFb0g=
X-Google-Smtp-Source: AA6agR4NkWtq2/uhaWboxw9xhu+6q4snk8/x91hcRywIQjE3vHFuj2tfC8DUMELuZHxJOlhCQcbbL88BAEDJimSiajs=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr48859651edb.333.1662488990119; Tue, 06
 Sep 2022 11:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <YxOkt4An+u1azlvG@playground>
In-Reply-To: <YxOkt4An+u1azlvG@playground>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 6 Sep 2022 11:29:38 -0700
Message-ID: <CAADnVQLvVBKkeGXp5PBKHVNDwfsV7T5YmMtqEexZqjFK3Kz_=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] bpf: Fix warning of incorrect type in return expression
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Elana.Copperman@mobileye.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
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

On Sat, Sep 3, 2022 at 12:02 PM Jules Irenge <jbi.octave@gmail.com> wrote:
>
> Sparse reports a warning at bpf_array_map_seq_start()
>
> "warning: incorrect type in return expression (different address spaces)"
>
> The root cause is the function expect a return of type void *
> but instead got a percpu value in one of the return.
>
> To fix this a variable of type void * is created
> and the complainining return value is saved into the variable and return.
>
> Fix incorrect type in return expression
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  kernel/bpf/arraymap.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 624527401d4d..b1914168c23a 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -548,6 +548,7 @@ static void *bpf_array_map_seq_start(struct seq_file *seq, loff_t *pos)
>         struct bpf_map *map = info->map;
>         struct bpf_array *array;
>         u32 index;
> +       void *pptrs;
>
>         if (info->index >= map->max_entries)
>                 return NULL;
> @@ -556,8 +557,10 @@ static void *bpf_array_map_seq_start(struct seq_file *seq, loff_t *pos)
>                 ++*pos;
>         array = container_of(map, struct bpf_array, map);
>         index = info->index & array->index_mask;
> -       if (info->percpu_value_buf)
> -              return array->pptrs[index];
> +       if (info->percpu_value_buf) {
> +               pptrs = &array->pptrs[index];
> +               return pptrs;
> +       }

Somebody will surely send a patch to optimize above back
to original code.
Please find a different way to shut up sparse or just ignore it.
