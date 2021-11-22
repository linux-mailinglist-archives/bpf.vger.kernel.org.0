Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B317045988A
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 00:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhKVXuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 18:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhKVXuf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 18:50:35 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57608C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 15:47:28 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d10so54563291ybe.3
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 15:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9AIUvp/gVmEQH39qA+wOuvYK1TL/jLp9JHB/qjrH2zY=;
        b=OIvNq3J2KPvmSnVdBbsG770nOdgbg2Z9Gfijs4rHHqE163IoN1MjgvdD6xUuJ7+Fi1
         mbu57Fk2VH6dhFAJyxXd1Ykt7ZVu9K4dBYBN+pXf9KLV6+3jn8IaPZI8M8RCE4sf3D2Y
         FvcDAIzf4haZC1B32JbeFWhXHAkJ8EFRQ82MkoV1t7PeuBkTYCtJ8/EcgZsq+9j8e+AW
         z2MRgyQAQHyYxqjct6dNL7CmKnb71JOL3LIB77ovLA2DTcYo4atnHI54Y5X1AdPSR8wC
         yEoAMftAP8WFgLsLbWl8BYjut0iheGqOCq+3fzuBDOiJF88VFp1XmGMMw6ugwm7Ptv8O
         G1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AIUvp/gVmEQH39qA+wOuvYK1TL/jLp9JHB/qjrH2zY=;
        b=3N4kQYnVdshBBodJouGBwqvQ/SHGxrd8VBNnWsaSXi/mjiYY57ll5AjkYJ94UJJtaO
         EKhNgJseXQB1L0Yz7oSjxTA0/0uxsDQDU2KgFspG3L4qWSQhfqQksOH9DwIM7aGqOSj3
         VA2Gx4bzKNhItfcQncbF3EfQq2aNgbsVgXc2l+2qXC/qOEBJa9/wyo6kb+Dl4y9e0xQk
         JTFTPWk7peMSf0pfmxzhsiccUSKBC6HHmcWSZPHs4UWgIiasD/mOZX9hPyFINzsFMIBU
         BfBlJlDJzzDZil8cp1B/2k7j2R81Uq4s153IpbQUmptWZu9N1oq/lqCIj7ptLG6na3w1
         vWWw==
X-Gm-Message-State: AOAM532DRuIZR5MRCxcAbns11vQubV7nJOPH/pFEhL7TfiHOKhccCs5/
        6u9gOaJ3Aa2dCkLN/cbWd4qCTjAmvHat+zfZqYQ=
X-Google-Smtp-Source: ABdhPJwbNSPDR+7Dmj6mV3OtKsAhYpyYmB4LZiBYyKNVfL21yI/Ck3eL7sbB+I+nVML53vgZFAovFEpJ3SIn61kqBS8=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr1102784ybe.455.1637624847597;
 Mon, 22 Nov 2021 15:47:27 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com> <20211120033255.91214-7-alexei.starovoitov@gmail.com>
In-Reply-To: <20211120033255.91214-7-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 15:47:16 -0800
Message-ID: <CAEf4BzZWiXEi3FmBsAScPpUnuHzVHL64hXrBj46HQAmx_qUH5Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/13] bpf: Add bpf_core_add_cands() and wire
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

On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
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
>  kernel/bpf/btf.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 135 insertions(+), 1 deletion(-)
>

[...]

>  int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
>                    int relo_idx, void *insn)
>  {
> -       return -EOPNOTSUPP;
> +       if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
> +               struct bpf_core_cand_list *cands;
> +
> +               cands = bpf_core_find_cands(ctx, relo->type_id);

this is wrong for many reasons:

1. you will overwrite previous ctx->cands, if it was already set,
which leaks memory
2. this list of candidates should be keyed by relo->type_id ("root
type"). Different root types get their own independent lists; so it
has to be some sort of look up table from type_id to a list of
candidates.

2) means that if you had a bunch of relos against struct task_struct,
you'll crate a list of candidates when processing first relo that
starts at task_struct. All the subsequent relos that have task_struct
as root type will re-used that list and potentially trim it down. If
there are some other relos against, say, struct mm_struct, they will
have their independent list of candidates.


> +               if (IS_ERR(cands)) {
> +                       bpf_log(ctx->log, "target candidate search failed for %d\n",
> +                               relo->type_id);
> +                       return PTR_ERR(cands);
> +               }
> +               ctx->cands = cands;
> +       }
> +       return bpf_core_apply_relo_insn((void *)ctx->log, insn, relo->insn_off / 8,
> +                                       relo, relo_idx, ctx->btf, ctx->cands);
>  }
> --
> 2.30.2
>
