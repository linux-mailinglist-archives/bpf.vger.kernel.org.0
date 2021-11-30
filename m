Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A0646297A
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 02:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbhK3BOl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 20:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhK3BOk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 20:14:40 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62292C061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:11:22 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d10so47609124ybe.3
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcGc4hAk8eBIVeWXKH7f7WoQtGjyxOW2iZaVgoqsxX0=;
        b=RbL2aFzUx3RRLx7lJF/B8AILmG9r0FiHk6syvKyOc1HS3yQDZ6XCbql6td16/OhxUM
         OUESwasCK10o6bjb/e7KkGSATrLl8ptBBOBKDK0HwdmNUaGBxoRVMW+s+t7AjV+inCdO
         yl0u5Uk3OTULVPX2oM7o9i92H4rB+IVq4Zhg7VJAwGw9EJ49NTYz/vEp345hJbS9KbO1
         2reeXX0Nf+55r+QRjJjGUhZMxOjtNazjClxJkrT5gSTiGhCllslsrqmn+RstPcfGRP/H
         pZ9JYyjRScMSzyBzgXCgkLIVje5g/C6z/ncBdZv4eK9wfSWMMPzGHOyYh46Z1CREnhNs
         XNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcGc4hAk8eBIVeWXKH7f7WoQtGjyxOW2iZaVgoqsxX0=;
        b=yue54H0IUV9Gujrtb3UWW317p3KQq4OQ/qhcynV7XUYKAaMHsq7cYnWM0Z8Atf1bXw
         YHirMoea8FTF0l5rV+QDTidzkEza2hNkx6LeA9hFq5ZGkSa5kbSMirvIL0h29PbDr4S/
         rSy4LdpN2ivCr1kzu89eZUqQ47++yUez9f3GjqyoRgJxLahnhLviDQT+bNu3p8og2utg
         YLHtldnOFAmasbtZ9CEsEReYckavAjc0GgpBbGYvk0n8hTesOAyxuR/p5OOOzr/DIOQg
         QvdgWdDUdLxSzJpj5t8z97uGIoXuAs7yoTq1QZ6VeN0ZiCpOUhPQy8gFYA7nRB1VKeay
         E1sA==
X-Gm-Message-State: AOAM532igRl7Hw5zjXpLenwHSPtRLTZu2n3KmNhJ6G/PcFy2FCPvlMqx
        p7Yz9rGvlKpNae/t/ZaLcR0dqikA9o+fE11K2Ps=
X-Google-Smtp-Source: ABdhPJxlKYDbHJm90FD7J8yiIiXwufryxwd9I+KT5+9G70ja6JrApX3oe9w2CKo5TqW88UWLSP0SYqqu+plxCICLKEU=
X-Received: by 2002:a25:2c92:: with SMTP id s140mr38110216ybs.308.1638234681581;
 Mon, 29 Nov 2021 17:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20211124060209.493-1-alexei.starovoitov@gmail.com> <20211124060209.493-9-alexei.starovoitov@gmail.com>
In-Reply-To: <20211124060209.493-9-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 17:11:10 -0800
Message-ID: <CAEf4Bza-NtGJMEtJ99T_y9FFykXHsVwwjqYZ_aFp6+M1Sqfsng@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 08/16] libbpf: Use CO-RE in the kernel in
 light skeleton.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 10:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Without lskel the CO-RE relocations are processed by libbpf before any other
> work is done. Instead, when lskel is needed, remember relocation as RELO_CORE
> kind. Then when loader prog is generated for a given bpf program pass CO-RE
> relos of that program to gen loader via bpf_gen__record_relo_core(). The gen
> loader will remember them as-is and pass it later as-is into the kernel.
>
> The normal libbpf flow is to process CO-RE early before call relos happen. In
> case of gen_loader the core relos have to be added to other relos to be copied
> together when bpf static function is appended in different places to other main
> bpf progs. During the copy the append_subprog_relos() will adjust insn_idx for
> normal relos and for RELO_CORE kind too. When that is done each struct
> reloc_desc has good relos for specific main prog.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/bpf_gen_internal.h |   3 +
>  tools/lib/bpf/gen_loader.c       |  41 +++++++++++-
>  tools/lib/bpf/libbpf.c           | 108 ++++++++++++++++++++++---------
>  3 files changed, 119 insertions(+), 33 deletions(-)
>

LGTM, minor styling nit, please address if/when resubmitting.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

> @@ -6600,6 +6638,16 @@ static int bpf_program__record_externs(struct bpf_program *prog)
>                                                ext->is_weak, false, BTF_KIND_FUNC,
>                                                relo->insn_idx);
>                         break;
> +               case RELO_CORE: {
> +                       struct bpf_core_relo cr = {
> +                               .insn_off = relo->insn_idx * 8,
> +                               .type_id = relo->core_relo->type_id,
> +                               .access_str_off = relo->core_relo->access_str_off,
> +                               .kind = relo->core_relo->kind,
> +                       };

nit: empty line between variable and statements

> +                       bpf_gen__record_relo_core(obj->gen_loader, &cr);
> +                       break;
> +               }
>                 default:
>                         continue;
>                 }
> @@ -6639,7 +6687,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>                                 prog->name, prog->instances.nr);
>                 }
>                 if (obj->gen_loader)
> -                       bpf_program__record_externs(prog);
> +                       bpf_program_record_relos(prog);
>                 err = bpf_object_load_prog_instance(obj, prog,
>                                                     prog->insns, prog->insns_cnt,
>                                                     license, kern_ver, &fd);
> --
> 2.30.2
>
