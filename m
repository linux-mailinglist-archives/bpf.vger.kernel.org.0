Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A892453DBC
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 02:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhKQBeY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 20:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhKQBeX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 20:34:23 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45845C061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 17:31:26 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id g17so2234630ybe.13
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 17:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPkGPg3D7kX/ZFbXDYMJLHRVoNk9VzJ6o59jkQNycIs=;
        b=oLUx1oZrBUfDjmecOBUslmqAFvWd7sWr0wIj7+sCkFqsouZi+haH5GQRfSEExqx3IB
         YjLcqOffZYb2cjGBNb1ToJ8VYo2TNCWy3aRY5xqYX0oY86M90WV2X6BMEA1gQoLHbs9p
         wqR81HV5Q1Cd0iQJ7y93jGE+7oqglR/z5NITJI9uSLxITYmz7vIueSBcXYo51MNYAYyD
         duyy4SfijwRdDk/FDdEPHL0vai+LnjTJfgTe3ehwaoU3Go5+Pi0XVH+fsnCEzctWjVwx
         Wanq2cVIF1crvVhpUFmXl/2WC8EcjSe8EP51mXqEJkTKNwz5TCi0SFzXvAV4oYF/Mwmh
         7zTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPkGPg3D7kX/ZFbXDYMJLHRVoNk9VzJ6o59jkQNycIs=;
        b=0kAwtD99WZ3qFXFA5lGJ9D547KBBDZmUf/t9hlMRvznvVKFONeawlbfx8CI9sJebBc
         O8tyFxILzm1sMd/K4eWdG9rK4jGPoP3um1P7kBRwqhHkKsaIQlcCFD9nYNv2QE1oh2bo
         UmTUuW9YjEBrJBLEC6JgZiyT+RzrEHsCZJI3bK3jx9NtVKR65gSIqvyiH+A/cG5lj+iO
         vS2j44SB1TQb/txm4qvgR/8cyu+SSy94uHAByswY7x5LMzhDRy4yoZyr71ayqPHCm66h
         LNhiI7glI7khEYm8FIUNANCutXFW4OKsgeaGDR7xkrkEToDn5j7vKWNAg/Bea34Cz2I+
         9oSg==
X-Gm-Message-State: AOAM532eCXBp5+ra3iBdlGRRODwD4Tz6U9JUx028/ZDxDZCcOrwmJKgn
        NXj4VGqR0vcoFEiwRy4isHhyVS1LGs9w2W/FIHs=
X-Google-Smtp-Source: ABdhPJxCm7Yc1yvx9VdNMZSDHGIV2Ktv8y7CzVQlNqoGqsvNzn3A5vIuxuFW2ikpRLh/t+lHRVOX2VB0d2yPhJ+HBVk=
X-Received: by 2002:a25:d010:: with SMTP id h16mr14801046ybg.225.1637112685522;
 Tue, 16 Nov 2021 17:31:25 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com> <20211112050230.85640-7-alexei.starovoitov@gmail.com>
In-Reply-To: <20211112050230.85640-7-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 17:31:14 -0800
Message-ID: <CAEf4BzaJ4VVBofSetOOyUcpm1avX_TK0RFQmpz2X7Pxw5=U4RQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 06/12] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 11, 2021 at 9:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Given BPF program's BTF perform a linear search through kernel BTFs for
> a possible candidate.
> Then wire the result into bpf_core_apply_relo_insn().
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/btf.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 137 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index efb7fa2f81a2..aeb591579282 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -25,6 +25,7 @@
>  #include <linux/kobject.h>
>  #include <linux/sysfs.h>
>  #include <net/sock.h>
> +#include "../tools/lib/bpf/relo_core.h"
>
>  /* BTF (BPF Type Format) is the meta data format which describes
>   * the data types of BPF program/map.  Hence, it basically focus
> @@ -6440,9 +6441,144 @@ size_t bpf_core_essential_name_len(const char *name)
>         return n;
>  }
>
> +static void bpf_core_free_cands(struct bpf_core_cand_list *cands)
> +{
> +       if (!cands)
> +               return;
> +        kfree(cands->cands);
> +        kfree(cands);

indentation is off?

> +}
> +
> +static int bpf_core_add_cands(struct bpf_verifier_log *log,
> +                             struct bpf_core_cand *local_cand,

and here?

> +                              size_t local_essent_len,
> +                              const struct btf *targ_btf,
> +                              int targ_start_id,
> +                              struct bpf_core_cand_list *cands)
> +{
> +       struct bpf_core_cand *new_cands, *cand;
> +       const struct btf_type *t;
> +       const char *targ_name;
> +       size_t targ_essent_len;
> +       int n, i;
> +

[...]

>  int bpf_core_relo_apply(struct bpf_verifier_log *log, const struct btf *btf,
>                         const struct bpf_core_relo *relo, int relo_idx,
>                         void *insn)
>  {
> -       return -EOPNOTSUPP;
> +       struct bpf_core_cand_list *cands = NULL;
> +       int err;
> +
> +       if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
> +               cands = bpf_core_find_cands(log, btf, relo->type_id);
> +               if (IS_ERR(cands)) {
> +                       bpf_log(log, "target candidate search failed for %d\n",
> +                              relo->type_id);
> +                        return PTR_ERR(cands);

some indentation issues here as well

> +                }
> +       }
> +       err = bpf_core_apply_relo_insn((void *)log, insn, relo->insn_off / 8,
> +                                      relo, relo_idx, btf, cands);
> +       bpf_core_free_cands(cands);

Why did you decide to not persist the candidate list? It is a
significant slowdown even on moderately large BPF programs, as you are
linearly re-searching vmlinux BTF multiple times for the same root
type.

> +       return err;
>  }
> --
> 2.30.2
>
