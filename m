Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1A38F23D
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 19:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhEXR2U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 May 2021 13:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbhEXR2U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 13:28:20 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2708FC061574
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 10:26:49 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id y36so22529063ybi.11
        for <bpf@vger.kernel.org>; Mon, 24 May 2021 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrZg3aF4wUsMWkfJXXxMMvLTZLRZg8W7KFx0ulOdy+Q=;
        b=KaCzSiIT0AGMipw55isONac3MtGNKazw/t8zTuiMTJ/jORHWUb0vtDVc6RCoxqtV1H
         Poj9CBYPrG/nJxV3RHurRsP9oJUkKzEm82WI1iDoH6GpCjwlwnlUJFVUfojEVIfCzXXX
         HxOa7gPtbQHf2VeXYW924NO2y/13u5Rb4jaZktWZBf/74PByTiYbBJu7conEIxaOfzGd
         xVEW/jy0upZ+ba6cimc2Vcyka1KEbn7aZdafACQ/gj38nsz2KJt6/cxzMnPMn5dul3eF
         FGgTS8wtz3B703Y5ytDNg1A0gnwMPbbswoIgWIqGsvYkv7UpYOsbzDLNZl6DqkrgtHwO
         LAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrZg3aF4wUsMWkfJXXxMMvLTZLRZg8W7KFx0ulOdy+Q=;
        b=Le/OReO172gbc5CGo4w0r62HC6Cq7zKrb970hMbht2k4Z1/O08B9fP1tTEemcOYuwP
         VbQOMoesD9ZQoemowwubsZ9vd6sZ0nbN7TIhTl0ct5KpkCZk2tWeSewUHqTSZ6pkfPRw
         X34BC2diTAadp6wc24oWPEHq2O19cPhIvLhAZUHD550jjoASEmgjgwfQnWpa1vbVqxTg
         Pkim7GjAHo1UpdtQ41padGncG2OLOqVMXSGTfNP6ApXQytEFjhcFPKC3Jpo1RkrOmpxU
         fKuQofIz7XtuJkMyhHnUjHIVQwMdFwQqjzl5Us6XeEtxAu6x1zmHO4RM8pCI8gaVFhAc
         vSCQ==
X-Gm-Message-State: AOAM530pSwQivlLciZkNjgpafM/ANw4kXcebPgtLO/eY50XfblhHcN3d
        iuOai/7waNdu6y9kjxwu6umJG3KmsxwQPbx3C2Y=
X-Google-Smtp-Source: ABdhPJxzm4JG4Ay6TI5lJe0zjaQ09DalLElM1VbdK/8Q4H9I673VY0ClxqFxVavEJtgoxMGjD8WMJ8ziDwWdssCgcb4=
X-Received: by 2002:a25:1455:: with SMTP id 82mr35769957ybu.403.1621877208359;
 Mon, 24 May 2021 10:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210522162341.3687617-1-yhs@fb.com>
In-Reply-To: <20210522162341.3687617-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 May 2021 10:26:37 -0700
Message-ID: <CAEf4BzYSUzhhFC-wujFfXVPkWfv3cY9_c_12h2YLw=+uUtEpLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add support for new llvm bpf relocations
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 22, 2021 at 9:23 AM Yonghong Song <yhs@fb.com> wrote:
>
> LLVM patch https://reviews.llvm.org/D102712
> narrowed the scope of existing R_BPF_64_64
> and R_BPF_64_32 relocations, and added three
> new relocations, R_BPF_64_ABS64, R_BPF_64_ABS32
> and R_BPF_64_NODYLD32. The main motivation is
> to make relocations linker friendly.
>
> This change, unfortunately, breaks libbpf build,
> and we will see errors like below:
>   libbpf: ELF relo #0 in section #6 has unexpected type 2 in
>      /home/yhs/work/bpf-next/tools/testing/selftests/bpf/bpf_tcp_nogpl.o
>   Error: failed to link
>      '/home/yhs/work/bpf-next/tools/testing/selftests/bpf/bpf_tcp_nogpl.o':
>      Unknown error -22 (-22)
> The new relocation R_BPF_64_ABS64 is generated
> and libbpf linker sanity check doesn't understand it.
> Relocation section '.rel.struct_ops' at offset 0x1410 contains 1 entries:
>     Offset             Info             Type               Symbol's Value  Symbol's Name
> 0000000000000018  0000000700000002 R_BPF_64_ABS64         0000000000000000 nogpltcp_init
>
> Look at the selftests/bpf/bpf_tcp_nogpl.c,
>   void BPF_STRUCT_OPS(nogpltcp_init, struct sock *sk)
>   {
>   }
>
>   SEC(".struct_ops")
>   struct tcp_congestion_ops bpf_nogpltcp = {
>           .init           = (void *)nogpltcp_init,
>           .name           = "bpf_nogpltcp",
>   };
> The new llvm relocation scheme categorizes 'nogpltcp_init' reference
> as R_BPF_64_ABS64 instead of R_BPF_64_64 which is used to specify
> ld_imm64 relocation in the new scheme.
>
> Let us fix the linker sanity checking by including
> R_BPF_64_ABS64 and R_BPF_64_ABS32. There is no need to
> check R_BPF_64_NODYLD32 which is used for .BTF and .BTF.ext.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM. Is there a chance that those relocations will get renamed or
expanded before LLVM diff lands? Or it's safe to apply now and LLVM
side won't change much?

>  tools/lib/bpf/libbpf_internal.h | 6 ++++++
>  tools/lib/bpf/linker.c          | 3 ++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 55d9b4dca64f..e2db08573bf0 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -28,6 +28,12 @@
>  #ifndef R_BPF_64_64
>  #define R_BPF_64_64 1
>  #endif
> +#ifndef R_BPF_64_ABS64
> +#define R_BPF_64_ABS64 2
> +#endif
> +#ifndef R_BPF_64_ABS32
> +#define R_BPF_64_ABS32 3
> +#endif
>  #ifndef R_BPF_64_32
>  #define R_BPF_64_32 10
>  #endif
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index b594a88620ce..1dca41a24f75 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -892,7 +892,8 @@ static int linker_sanity_check_elf_relos(struct src_obj *obj, struct src_sec *se
>                 size_t sym_idx = ELF64_R_SYM(relo->r_info);
>                 size_t sym_type = ELF64_R_TYPE(relo->r_info);
>
> -               if (sym_type != R_BPF_64_64 && sym_type != R_BPF_64_32) {
> +               if (sym_type != R_BPF_64_64 && sym_type != R_BPF_64_32 &&
> +                   sym_type != R_BPF_64_ABS64 && sym_type != R_BPF_64_ABS32) {
>                         pr_warn("ELF relo #%d in section #%zu has unexpected type %zu in %s\n",
>                                 i, sec->sec_idx, sym_type, obj->filename);
>                         return -EINVAL;
> --
> 2.30.2
>
