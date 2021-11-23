Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3419A45AF5F
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 23:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhKWWuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 17:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbhKWWuL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Nov 2021 17:50:11 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58339C061574
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 14:47:00 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e136so1656324ybc.4
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 14:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2hShKXj8Nab4b2rKgV7yEvsJXL7EsfxfHjXESnw8AI=;
        b=g81CwoU3PcXDhfVWiocZBDOg737JvAT1UkswIaYApRgubIefqGEKMScP1BDRKnNXpn
         MTIBQ8IH9h6V5tVcSyBO5UsKNRNR5sT6q8pWB4hFerp0WPxKhyrTfSjISiiNJUl4k0U4
         SXz9SC2kjQvI6hiB/1TLb1kHWMbTNCfM1hYy9E8wCc1S6byQnrBb+rK5j4HFfErUhYds
         SEya9bw9g+l3t30I5/CEnEDGm8l5busiXz0Pb2u2WNTt4jHtzCmVEkVWgoD/NVJomQBs
         gTWdmkBUxC0dcNSgVBDF3dct6bgJ6xB6b9FDdqVdvQ8HDzL7yjPvLcKeX6xV3VqJQhcr
         rjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2hShKXj8Nab4b2rKgV7yEvsJXL7EsfxfHjXESnw8AI=;
        b=ROHxvGq7aVlPeFp49DKc5sOzHpfwpDeCNCaaQnpacZ7b94LsbrpKY5Vu+Qf9DmjLIe
         DS1gMk05kw+/3yjegTijVXrpMKO/af0wvctk25MK+0LfZeCrhfrTaYu/eqgjnRuJrVmk
         I3eff6695xCWIeWXuAGPJn5FriZlAfH4MXglrmyR59DW+Lbd5xl9fXwMdnebb4FmiHPv
         0KuYH9fVzhwBskPhE/+5j1JTAbTdQvzc+DJXqF7ruQxQZ1132suLRl3yyrATctP3yimx
         A0dlozkyjIH7iwFjECleOvQg4KE5jZJuSmOwSVwt0vOguezseBoxTuyJRk9NGRBl8t/m
         WPIw==
X-Gm-Message-State: AOAM5319+AwiteZvmqBndVyXFQxPSHblMMX9GSplVnD1gSF3fkT/JIkC
        QYcIG7vJ3eXFhBXij1QJAMP1Wvtnvavj9mbD+H+AfWElWtY=
X-Google-Smtp-Source: ABdhPJyPtldxzNcu6qp1WGp5Uk17vn5QkLD+TVy0sma0geeYW46qgFgeGdnLaBWsllDlzKcFKUf8572fHOTEocx9LNA=
X-Received: by 2002:a05:6902:68d:: with SMTP id i13mr10733117ybt.2.1637707619565;
 Tue, 23 Nov 2021 14:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20211123183409.3599979-1-joannekoong@fb.com> <20211123183409.3599979-2-joannekoong@fb.com>
In-Reply-To: <20211123183409.3599979-2-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Nov 2021 14:46:48 -0800
Message-ID: <CAEf4BzbBfnWqB9gHF12EMFS8oM6pewN55qc1k3_c99v7smXqyg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Add bpf_loop helper
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 10:34 AM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds the kernel-side and API changes for a new helper
> function, bpf_loop:
>
> long bpf_loop(u32 nr_loops, void *callback_fn, void *callback_ctx,
> u64 flags);
>
> where long (*callback_fn)(u32 index, void *ctx);
>
> bpf_loop invokes the "callback_fn" **nr_loops** times or until the
> callback_fn returns 1. The callback_fn can only return 0 or 1, and
> this is enforced by the verifier. The callback_fn index is zero-indexed.
>
> A few things to please note:
> ~ The "u64 flags" parameter is currently unused but is included in
> case a future use case for it arises.
> ~ In the kernel-side implementation of bpf_loop (kernel/bpf/bpf_iter.c),
> bpf_callback_t is used as the callback function cast.
> ~ A program can have nested bpf_loop calls but the program must
> still adhere to the verifier constraint of its stack depth (the stack depth
> cannot exceed MAX_BPF_STACK))
> ~ Recursive callback_fns do not pass the verifier, due to the call stack
> for these being too deep.
> ~ The next patch will include the tests and benchmark
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       | 25 +++++++++
>  kernel/bpf/bpf_iter.c          | 35 ++++++++++++
>  kernel/bpf/helpers.c           |  2 +
>  kernel/bpf/verifier.c          | 97 +++++++++++++++++++++-------------
>  tools/include/uapi/linux/bpf.h | 25 +++++++++
>  6 files changed, 148 insertions(+), 37 deletions(-)
>

[...]

> +/* maximum number of loops */
> +#define MAX_LOOPS      BIT(23)
> +
> +BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
> +          u64, flags)
> +{
> +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> +       u64 ret;
> +       u32 i;
> +
> +       if (flags || nr_loops > MAX_LOOPS)
> +               return -EINVAL;

nit: it's probably a good idea to return -E2BIG for nr_loops >
MAX_LOOPS? It will be more obvious for unsuspecting users that forgot
to read the documentation carefully :)

> +
> +       for (i = 0; i < nr_loops; i++) {
> +               ret = callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
> +               /* return value: 0 - continue, 1 - stop and return */
> +               if (ret) {
> +                       i++;
> +                       break;

nit: could be just return i + 1;

> +               }
> +       }
> +
> +       return i;
> +}
> +

[...]

> +       case BPF_FUNC_get_local_storage:
> +               /* check that flags argument in get_local_storage(map, flags) is 0,
> +                * this is required because get_local_storage() can't return an error.
> +                */
> +               if (!register_is_null(&regs[BPF_REG_2])) {
> +                       verbose(env, "get_local_storage() doesn't support non-zero flags\n");
>                         return -EINVAL;
> -       }
> -
> -       if (func_id == BPF_FUNC_timer_set_callback) {
> +               }
> +               err = 0;

err is guaranteed to be zero, no need to re-assign it

> +               break;
> +       case BPF_FUNC_for_each_map_elem:
>                 err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> -                                       set_timer_callback_state);
> -               if (err < 0)
> -                       return -EINVAL;
> -       }
> -
> -       if (func_id == BPF_FUNC_find_vma) {
> +                                       set_map_elem_callback_state) ? -EINVAL : 0;

I think it's actually good to propagate the original error code, so
let's not do `? -EINVAL : 0` logic

> +               break;
> +       case BPF_FUNC_timer_set_callback:
>                 err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> -                                       set_find_vma_callback_state);
> -               if (err < 0)
> -                       return -EINVAL;
> -       }
> -
> -       if (func_id == BPF_FUNC_snprintf) {
> +                                       set_timer_callback_state) ? -EINVAL : 0;
> +               break;
> +       case BPF_FUNC_find_vma:
> +               err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> +                                       set_find_vma_callback_state) ? -EINVAL : 0;
> +               break;
> +       case BPF_FUNC_snprintf:
>                 err = check_bpf_snprintf_call(env, regs);
> -               if (err < 0)
> -                       return err;
> +               break;
> +       case BPF_FUNC_loop:
> +               err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> +                                       set_loop_callback_state) ? -EINVAL : 0;
> +               break;
> +       default:
> +               err = 0;

same, err is already zero if no error so far was found

>         }
>
> +       if (err)
> +               return err;
> +

[...]
