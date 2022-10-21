Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9CF608200
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 01:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJUXLL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 19:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJUXLK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 19:11:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553B02441A1
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:11:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g27so11208220edf.11
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LQcbgdjZ0sgAWDaTVdiThALnefoKcmp34Ciys60S2w4=;
        b=NEe8/qy7LcWE0dAOOtNSED7e3qYGwJcQ1Dr0qjgh8lOi7Zfas3Tfb8614XX4aTm8e6
         D8DhkF9bLNYLEZJo9h8H9fFMZaQRsti6iTU0zHP7dyoB86y9wkxa+RHXtVWOrGitz4Uo
         Le93Po800p8YKdHItYWssUdJ14OKzmGAwyvw2Wahr/OATb7N/z1cL+K3DL7XkxbGvT1k
         m3nbYGmV6w/gWSRoh0zfmgN/zV7E1pm6b1KHqEZygYzFS74CWvH7DwKvPsFwWAx04/gx
         dpFZ9XFR7x+j10sx/PJ+qfoWOHKF63A4CpbzmAwu72XtUi5OxsN7ZMteEA6ZNBqSh4m9
         3Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQcbgdjZ0sgAWDaTVdiThALnefoKcmp34Ciys60S2w4=;
        b=bBalmchgw/nGtq1rviCc0PhQ0GFgB+gJipXNMC+dHErJ6iR2+UZZTYn1jZSe7m0TQ2
         oYNgaWfghclSBlmPHHAKQmd+1bqyklJMDNruvpSnhPba7Vdfwv3SkeDjEStTrORDk7DH
         B2anKCk21k2N/EpGOAsrTDJUKpy7FNJI1LUTAPpCLmU0Gc82VtdsDsgM4Py/w7JcAwnx
         BWcJmi7iVYE8c3UqopUB+vfNcaYJYSZMU8X/L1DBaI9tFYuPwdUPOoX1+iobDkdCBzEm
         sSZDcL+/uvewOe0sZwnjV0GbsbDx6P7rUZElbRFj3ydLnLIqVmlEv1FaHTVk5ojUOHyS
         PJ1w==
X-Gm-Message-State: ACrzQf3aQsLp6taxhDD4capjbuL6WAajZqW3/xUoYoyIKLehGAGa1ot/
        9D9E4kQ5xzM+RrrzQ7BHLwjKK2IghxR8Irs3+gs=
X-Google-Smtp-Source: AMsMyM4CgtUmBpX5zUhWM27E3279nFUK8nEkBHrk7oVwteKbf7pPrgOYCr4Lwtr8kohbzRTcmU7y2ZopxB3x6fQoh8I=
X-Received: by 2002:a17:907:2d91:b0:78d:8747:71b4 with SMTP id
 gt17-20020a1709072d9100b0078d874771b4mr17560032ejc.545.1666393867938; Fri, 21
 Oct 2022 16:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221020221255.3553649-1-yhs@fb.com> <20221020221311.3554642-1-yhs@fb.com>
In-Reply-To: <20221020221311.3554642-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 16:10:54 -0700
Message-ID: <CAEf4Bzbi1UwGwnekjpWNZwF2G1_M-64EqH5BaKCf712nR1PUPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] libbpf: Support new cgroup local storage
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
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

On Thu, Oct 20, 2022 at 3:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add support for new cgroup local storage.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---


LGTM, but I do think that BPF_MAP_TYPE_CG_STORAGE and "cg_storage" is
easier to read and talk about. But that's minor.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/libbpf.c        | 1 +
>  tools/lib/bpf/libbpf_probes.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 027fd9565c16..5d7819edf074 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -164,6 +164,7 @@ static const char * const map_type_name[] = {
>         [BPF_MAP_TYPE_TASK_STORAGE]             = "task_storage",
>         [BPF_MAP_TYPE_BLOOM_FILTER]             = "bloom_filter",
>         [BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
> +       [BPF_MAP_TYPE_CGRP_STORAGE]             = "cgrp_storage",
>  };
>
>  static const char * const prog_type_name[] = {
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index f3a8e8e74eb8..bdb83d467f9a 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -221,6 +221,7 @@ static int probe_map_create(enum bpf_map_type map_type)
>         case BPF_MAP_TYPE_SK_STORAGE:
>         case BPF_MAP_TYPE_INODE_STORAGE:
>         case BPF_MAP_TYPE_TASK_STORAGE:
> +       case BPF_MAP_TYPE_CGRP_STORAGE:
>                 btf_key_type_id = 1;
>                 btf_value_type_id = 3;
>                 value_size = 8;
> --
> 2.30.2
>
