Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B65836BC07
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 01:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhDZX1H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Apr 2021 19:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhDZX1G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Apr 2021 19:27:06 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2048C061574;
        Mon, 26 Apr 2021 16:26:22 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 130so23227084ybd.10;
        Mon, 26 Apr 2021 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2SiQIyo4hvRrgZvT9+3elzY2NurWPOQ84hTpTx/mOI=;
        b=qSvchFfBqTvPetH+6AbfQTtL3URnd4+U3V2aLgfVYrg1MiRIOITthJcS8SUYRJQOOu
         NGGSCERCRCzxK6/k5n5vdefwXA+bwRzz+t6GvImtA6rLRYjX/lrkiPH6qZjbJHiUHMdS
         t0Pyxqc3SdVYZ3tBCBlSL5fHhrrdP9WsjqSKWFJHkWyA8u74JDz3igrf33bLBewC27ai
         Z91ofW55kffitvHjotb6WuQWtbfG9ES5q1AGgyJF6yrZMrsUHSH9fivc+Py05vjuOT4W
         hy2u6S5+OAyMGRIeLCSwtisLkYwM8Khh44wDa6xiPXfWl8injZXsLhO8SAc7125qRm18
         ErCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2SiQIyo4hvRrgZvT9+3elzY2NurWPOQ84hTpTx/mOI=;
        b=M4eD+EEL+MxJoH4/BIQ34BdrCv90i4h4I15/D7Q4MMmF7lm0WtGoLFYLRai44JRqq/
         IBDbryB/YDk8Bh26P//4vkTqnDzmLgqKAA9c9Ha20K5fnDg2ig+TtbtFV4ze+bNH+MB4
         S/TLhaseF67ISuP0+hA3PKfm29DL6ypK0MzCAWVDhut0lk5674aTV7/aUmkdhdKzLP2L
         Wvs68fkdsaOejPUbTIRgO1I8hGwanalZ41nF63Cv0VkYron60U7fG4L1d2A4WySvnh4R
         Rrw0cxiJ1+adQC6u40umcrPjHwI6gFOmfnkFp6KXqA5htd0ENbyU0pWaVgijTbsvjSp3
         zdCQ==
X-Gm-Message-State: AOAM531Txi/dKpr/w/qP7s291/N4fmoY8J2tS31ZjUlt6hq7dsfQpij+
        76mkxrHpWraWfg3dED+m3G/gquQg9zn2WW1oh40=
X-Google-Smtp-Source: ABdhPJzn2RP5+aJ17mulwvz8Ouj6oUBRo//R6AMFHhjue1v8ToKT8O+GHcVnlYS5PDbBgUm9YL3F4en8T7qI7yqoyOw=
X-Received: by 2002:a25:3357:: with SMTP id z84mr28144598ybz.260.1619479581915;
 Mon, 26 Apr 2021 16:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210423213728.3538141-1-kafai@fb.com>
In-Reply-To: <20210423213728.3538141-1-kafai@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 26 Apr 2021 16:26:11 -0700
Message-ID: <CAEf4BzY16ziMkOMdNGNjQOmiACF3E5nFn2LhtUUQbo-y-AP7Tg@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids section
To:     Martin KaFai Lau <kafai@fb.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 23, 2021 at 2:37 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> BTF is currently generated for functions that are in ftrace list
> or extern.
>
> A recent use case also needs BTF generated for functions included in
> allowlist.  In particular, the kernel
> commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> allows bpf program to directly call a few tcp cc kernel functions.  Those
> functions are specified under an ELF section .BTF_ids.  The symbols
> in this ELF section is like __BTF_ID__func__<kernel_func>__[digit]+.
> For example, __BTF_ID__func__cubictcp_init__1.  Those kernel
> functions are currently allowed only if CONFIG_DYNAMIC_FTRACE is
> set to ensure they are in the ftrace list but this kconfig dependency
> is unnecessary.
>
> pahole can generate BTF for those kernel functions if it knows they
> are in the allowlist.  This patch is to capture those symbols
> in the .BTF_ids section and generate BTF for them.
>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---

I wonder if we just record all functions how bad that would be. Jiri,
do you remember from the time you were experimenting with static
functions how much more functions we'd be recording if we didn't do
ftrace filtering?

>  btf_encoder.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++---
>  libbtf.c      |  10 ++++
>  libbtf.h      |   2 +
>  3 files changed, 142 insertions(+), 6 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 80e896961d4e..48c183915ddd 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -106,6 +106,121 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym,
>         return 0;
>  }
>
> +#define BTF_ID_FUNC_PREFIX "__BTF_ID__func__"
> +#define BTF_ID_FUNC_PREFIX_LEN (sizeof(BTF_ID_FUNC_PREFIX) - 1)
> +
> +static char **listed_functions;
> +static int listed_functions_alloc;
> +static int listed_functions_cnt;

maybe just use struct btf as a container of strings, which is what you
need here? You can do btf__add_str() and btf__find_str(), which are
both fast and memory-efficient, and you won't have to manage all the
memory and do sorting, etc, etc.

[...]
