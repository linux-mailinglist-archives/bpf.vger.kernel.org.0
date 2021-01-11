Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA5D2F1E68
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 20:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390544AbhAKTAk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 14:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732477AbhAKTAk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 14:00:40 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8457C061786
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 10:59:59 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id x16so1159543ejj.7
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 10:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XPYTcSjoUKIc+bAniXDLq14GFcqVPdpfHpciaBIwxE=;
        b=cYeDkvHqKkQ12t9S/Kx6Hn8ThpSQ3sEL+Tk/uwDM1AXiUKhUEngbIkAzXSOhX0YjHe
         C1zkxBi6trX9d6mc4SLf5tWY5xWRykip4dimuryQ+jdJlsa0lXdvB8Ku+EwYozMHzwtX
         Zj5muVZdiY9sXut/FxxWHPpQJLpBxd0wZV82sMYiVBxiwiVxG7g82nYKIZSvL03zgX1p
         d5J9QO0rn1pWIIpYeeaMVH7YXLWE8mbSN37H+6GpedUlV65Y1dmq071fjEw6k2D18TtX
         p8xz4EqeEg3eTAZgr9qbk5PIZCXY10Z72Ei6PNltP5R0i+4ahZ2FeLte+XB/heXtWVZ8
         /VqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XPYTcSjoUKIc+bAniXDLq14GFcqVPdpfHpciaBIwxE=;
        b=b0GCc10/amOLoIM4/Ub/cf+VD9Rva2FONGRL/wjwyYXA2EckyG/Nlavs+Hln3ugWN/
         YQgfUulkGbgkeR/DtGaOHHcHgzulWMVHWubtQi52IAM9/+P8dBP+KW5Js7dnXDQELVlh
         FXX8segeNx/FwhcO17RduWqHrxCLEBXGsTieeQWT7Gn9qXJxB6tg14onWf33uDnAXBC2
         chTaUPh62eZyopzyhmgrkrdMveJydBWedQrGrxbRUtIEGymom9a8njMOh9TGbLzw1m5W
         4hM4RtjIHF9yfaB/CHLyCNyNdl185AY14G0o4f2noJpZYmWjUGcS+po8mV4qqYZD1fC8
         Rzzg==
X-Gm-Message-State: AOAM530HPJZDFaMOe0BydaRO6cdJP6x6K69VSCNqcCISEgrSS6AAk24E
        h8u5Cbc3Op5LMQvtoyLSsomDrrbNxpJ/TeWaXykAIQ==
X-Google-Smtp-Source: ABdhPJx/uDGJ2qO+3k/y9KbfWOQ4MgUXjS/lL7dn8aacdxL43x2p8CjBwLzW5gSp80r4A+y9KGPeyUECFrXNkaMIVAY=
X-Received: by 2002:a17:906:94d4:: with SMTP id d20mr583464ejy.475.1610391598414;
 Mon, 11 Jan 2021 10:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20210108220930.482456-1-andrii@kernel.org> <20210108220930.482456-6-andrii@kernel.org>
In-Reply-To: <20210108220930.482456-6-andrii@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 11 Jan 2021 10:59:46 -0800
Message-ID: <CA+khW7jTso5Jz6D8Scn8-Kf3OtT0B4JP_rJWFCZa8EEmYOO8iw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/7] bpf: support BPF ksym variables in kernel modules
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Acked-by: Hao Luo <haoluo@google.com>, with a suggestion on adding a comment.

On Fri, Jan 8, 2021 at 2:09 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add support for directly accessing kernel module variables from BPF programs
> using special ldimm64 instructions. This functionality builds upon vmlinux
> ksym support, but extends ldimm64 with src_reg=BPF_PSEUDO_BTF_ID to allow
> specifying kernel module BTF's FD in insn[1].imm field.
>
> During BPF program load time, verifier will resolve FD to BTF object and will
> take reference on BTF object itself and, for module BTFs, corresponding module
> as well, to make sure it won't be unloaded from under running BPF program. The
> mechanism used is similar to how bpf_prog keeps track of used bpf_maps.
>
> One interesting change is also in how per-CPU variable is determined. The
> logic is to find .data..percpu data section in provided BTF, but both vmlinux
> and module each have their own .data..percpu entries in BTF. So for module's
> case, the search for DATASEC record needs to look at only module's added BTF
> types. This is implemented with custom search function.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h          |  10 +++
>  include/linux/bpf_verifier.h |   3 +
>  include/linux/btf.h          |   3 +
>  kernel/bpf/btf.c             |  31 +++++++-
>  kernel/bpf/core.c            |  23 ++++++
>  kernel/bpf/verifier.c        | 149 ++++++++++++++++++++++++++++-------
>  6 files changed, 189 insertions(+), 30 deletions(-)

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 17270b8404f1..af94c6871ab8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9703,6 +9703,31 @@ static int do_check(struct bpf_verifier_env *env)
>         return 0;
>  }
>
> +static int find_btf_percpu_datasec(struct btf *btf)
> +{
> +       const struct btf_type *t;
> +       const char *tname;
> +       int i, n;
> +

It would be good to add a short comment here explaining the reason why
the search for DATASEC in the module case needs to skip entries.

> +       n = btf_nr_types(btf);
> +       if (btf_is_module(btf))
> +               i = btf_nr_types(btf_vmlinux);
> +       else
> +               i = 1;
> +
> +       for(; i < n; i++) {
> +               t = btf_type_by_id(btf, i);
> +               if (BTF_INFO_KIND(t->info) != BTF_KIND_DATASEC)
> +                       continue;
> +
> +               tname = btf_name_by_offset(btf, t->name_off);
> +               if (!strcmp(tname, ".data..percpu"))
> +                       return i;
> +       }
> +
> +       return -ENOENT;
> +}
[...]
> 2.24.1
>
