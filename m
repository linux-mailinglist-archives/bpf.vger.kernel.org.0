Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7875E1D1D71
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 20:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390133AbgEMS2g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733310AbgEMS2g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 14:28:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC74C061A0C
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 11:28:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id y22so281204qki.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdZ1aiYqFKGZxJzpe4bfX7G0RHGCLHEXOCZcVy2rRSE=;
        b=TDgL/bU9pdD6IeUapG16MhEJhJjSMwEtt/lLQTx47lAdcUrI7/ymoJJNFWDBCu3vbO
         UNh3yXIaqEaYIDdqOPkFHSDnAFA+7PZC47IqDOeK7bMPAgZePrLkruhF79Ai0NyNKNhy
         ZXHerQfT0w6SN8IpyAu34/r1tzQTtO0MGcI6uUlVUGI1baNV4pMMG1WbnTgeHS8gO6Qw
         6zqvrK9r7pPADh6bx4Y1aDDW9EsCGUr67cRWHZxqll8tsw4HlZ/2GDCMWiVAwvyh5Pc2
         W9sliPhEP4PoR82IJHQDRCe0hO3bcAJAmdowGUNIMxkV+UNLm/o2Rc/SKhS8JQFYnwLH
         aWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdZ1aiYqFKGZxJzpe4bfX7G0RHGCLHEXOCZcVy2rRSE=;
        b=DRyHZHgChtIHxFLYiCkXDWMYoUjWFKxQpfPjNfuA+tyC44GLPNZPMt1jjPZbb8v2Qc
         NgVL1XoOThs6AbXAiOVqRlOW8sq9lB8e0aqm0t4GSitYmgkYxy55x6hzjh99MOiuLl63
         k1/X7ln8hfzEbry0DjqR1Pop0SH8/xG+L0vTwG/gm0sKhR3YpW1XT7PTXcN5lqfvCO13
         i/5UmWduHwwWD7KcL9qbeuz1iOBW6kNu5HfpoVm9UEkSeHs9kUzcL4t+oYLeH0j4DDPQ
         ifaNQo9bo2dCd59j2baIrH3aZmtBauKlaJk1qMnKJoZCJvpZGoXXV5Ac1iTGtxN6+8rg
         Oy0Q==
X-Gm-Message-State: AOAM531IZJMsGRmDDZDPFLnBGZd/L9Zz16WUw+A8xq4NnYCs7UlrZoKy
        bvO2jNDJESNMzd0x1dyTmp39Uz/GqZIy+bDKipWNnA==
X-Google-Smtp-Source: ABdhPJwda+A3y1iib7NccxTfw6LKSFw51msLrU097BVbQpdtcNFI11GXkeNT0WPoJFDRUCjPS0X2snA0Zh5Qgg248fA=
X-Received: by 2002:ae9:e713:: with SMTP id m19mr1047505qka.39.1589394514102;
 Wed, 13 May 2020 11:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200513164525.2500605-1-yhs@fb.com> <20200513164525.2500681-1-yhs@fb.com>
In-Reply-To: <20200513164525.2500681-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 May 2020 11:28:23 -0700
Message-ID: <CAEf4BzaCbPqrC67PmAVkPjW2MxR1H=Md47w5nC1NkdEfWY6q4Q@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: enforce returning 0 for fentry/fexit progs
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 9:46 AM Yonghong Song <yhs@fb.com> wrote:
>
> Currently, tracing/fentry and tracing/fexit prog
> return values are not enforced. In trampoline codes,
> the fentry/fexit prog return values are ignored.
> Let us enforce it to be 0 to avoid confusion and
> allows potential future extension.
>
> Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fa1d8245b925..17b8448babfe 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7059,6 +7059,13 @@ static int check_return_code(struct bpf_verifier_env *env)
>                         return 0;
>                 range = tnum_const(0);
>                 break;
> +       case BPF_PROG_TYPE_TRACING:
> +               if (env->prog->expected_attach_type == BPF_TRACE_FENTRY ||
> +                   env->prog->expected_attach_type == BPF_TRACE_FEXIT) {
> +                       range = tnum_const(0);
> +                       break;
> +               }
> +               return 0;


I find such if conditions without explicitly handling "else" case very
error-prone and easy to miss when adding new functionality. Having an
explicit switch with all known cases handled and default failing seems
best. WDYT?

E.g., in this case

case BPF_PROG_TYPE_TRACING:
    switch (env->prog->expected_attach_type) {
        case BPF_TRACE_FENTRY:
        case BPF_TRACE_FEXIT:
            range = tnum_const(0);
            break;
        case BPF_MODIFY_RETURN:
            break;
        default:
            return -ENOTSUPP;
    }

This way if someone adds new tracing sub-type, they will need to
explicitly decide what to do with exit codes.

>         default:
>                 return 0;
>         }
> --
> 2.24.1
>
