Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD74BD13F
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 21:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbiBTUQ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Feb 2022 15:16:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243702AbiBTUQ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Feb 2022 15:16:27 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257304C43F
        for <bpf@vger.kernel.org>; Sun, 20 Feb 2022 12:16:06 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id e79so13718574iof.13
        for <bpf@vger.kernel.org>; Sun, 20 Feb 2022 12:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIqygdfz289PTgTIe1ySZ/371fQvY+R+cg4JjH+N7Ls=;
        b=mafYT6GGyxHKxZwHkSBaCjYKJQ+1VRHN9xzQmC99yXiw8eLhAkJU0YVBM51RhmpQpa
         gv/UBp0aGshUQQQ7eJNJNeCmDqdPZ8E1n4ffb7hbpXzgBOS9MXnrPR3ShPCnpyDLfpCq
         6fqlFKURmqOi5W7l7x0WJjEiVJ1fVIiCH6NxXVKzgmdfh/TvoB1o769wQ1/WiOiEVQtP
         aFK4NOsbxTbl72SIZNUH5HUEkz0ED8VWPYX+PU+V0ReB1FKu+nzmodS9afJ77805aP78
         sdWBNwGBYNePdZftudE1YWKoZ979lzNQu5BzChIontZ00466WONLIIgxIELxRK/sse4E
         dgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIqygdfz289PTgTIe1ySZ/371fQvY+R+cg4JjH+N7Ls=;
        b=07C+ZlPVUbt3CChhcwfXdkFxSwTgRVgvDS1txWVGy9o9GZ8Nrk+EI6lrDpPfZ70eiV
         5hpOgnMZyqmreI+ShmYxlQ6wNdbiwSsLAzLspBLJ6viQCCvX1rio9wfeiHr0I1dpMk4b
         o89NGjKENVHpxYIvIkLEqRATTVauSIisiwRW7N7voCT8Yq1p2kc0bFowBAlW0DGf96cl
         uKOz7Vo3V3hPxyhKqDqaaNP1sSZWbbz2pJ3JL39B4d5ya7XBWQ3mHlS3NxXmQb5UolFq
         YVshME8tZKjg3E89geGh/Lv/SFr3wKOjotaJaKMUj3r4kpig5cFOGrppHXuwIV3Ih4/n
         ObUg==
X-Gm-Message-State: AOAM5339UAhzW08hayBPX7ZEwIGsrX3zBsIx9CBeOLOAN0HJOlemIDrs
        rjDnR+NdhTgq/wGcMqai0mXg7nV6Wh8p2bDtOXk=
X-Google-Smtp-Source: ABdhPJwR+dNQyY8lq2Zt3o56PYwluSkZXhCHQFf4O3EKiMBemkZ41g/cNIsM0nx54yIqGqKS3uUU0FSWW7Rh/Qc2YsI=
X-Received: by 2002:a5d:859a:0:b0:632:7412:eb49 with SMTP id
 f26-20020a5d859a000000b006327412eb49mr13255760ioj.63.1645388165528; Sun, 20
 Feb 2022 12:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20220220072750.209215-1-ytcoode@gmail.com>
In-Reply-To: <20220220072750.209215-1-ytcoode@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 20 Feb 2022 12:15:54 -0800
Message-ID: <CAEf4BzaGEZAmLM=wmT=ohSaVco_iu8v7cTGYFGCyRz_Xf3c5=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Remove redundant check in btf_fixup_datasec()
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
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

On Sat, Feb 19, 2022 at 11:29 PM Yuntao Wang <ytcoode@gmail.com> wrote:
>
> The check 't->size && t->size != size' is redundant because if t->size
> compares unequal to 0, we will just skip straight to sorting variables.
>
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ad43b6ce825e..7e978feaf822 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2795,7 +2795,7 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
>                 goto sort_vars;
>
>         ret = find_elf_sec_sz(obj, name, &size);
> -       if (ret || !size || (t->size && t->size != size)) {

t->size check is redundant, but  (t->size != size) is not

> +       if (ret || !size) {
>                 pr_debug("Invalid size for section %s: %u bytes\n", name, size);
>                 return -ENOENT;
>         }
> --
> 2.35.1
>
