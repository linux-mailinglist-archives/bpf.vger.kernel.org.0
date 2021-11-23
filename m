Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C73A4598EE
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 01:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhKWAHJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhKWAHI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 19:07:08 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560DAC061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:04:01 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id e136so54569083ybc.4
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BCifO8mywHw0p6eYfj5I7XoYVF8QYWajGx9ZQIyldgE=;
        b=Y57Xkk7T6O9G+eu2xeH2g82OUX940dCYyzDzbex5RLzmRgj1TiaVwnxPRUkCu8FEII
         foERjy0Vk8F0/hJ4MtFi5wT0o9SE1h6ZW9EE3Kdb987w/ZIz4RbdyKZpytZaf36vu5Xg
         IgPwh7v+RiX3VTE/zrCkpvv6AyLbsMUIFBLuUM+yEMXxE0UC47RfgLhYcGbZJRlSNB10
         3wStquxG+xjk/1IFd4AW+6fV3OW972ZJX+dInPn0OwaQgouw9xeaQ619nzN4LlylamWz
         pESGqOyhXByJ6gyw4+3b48eE82MXa7ohSgBZyQcWx0epywtWS9BZo/DaBWUb+Zw49/tm
         DdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCifO8mywHw0p6eYfj5I7XoYVF8QYWajGx9ZQIyldgE=;
        b=d3iFOn9rx3uZnUq/5Pl9kDF2UE5foq+Hn6avakuj+dt/w1bTnKvbDH5a4I9iFZZkKQ
         sSyPIzWFE7BPbAFQOA54Ew4Gnw8FfdvzY+kypGDxe6KI3g3Fg1ZgixX2wU3Yqt/B2ySx
         xMeM0GkFN/THImstvy16on6W7+uPrVn/xInvdGhW/+DXHmUMZ61A6VysvSJDAEYgu7b0
         SpnrAcB+rszU9l05+ObVxwcQk21FgVIj6vyRhFHoE/0dcRmmVwU6v+Cn2tN3ka5/AoYE
         i2lWSHJk+W7hO05+YgoNss2jrFbw5xwawP6UhmIPnKXBxlGDuL4ZO6cOaPp9zfYvMtEK
         jOHw==
X-Gm-Message-State: AOAM531OOjFE3z/y76aInomWjqol8Ihfzchsnp5uNzvmfRCu/3GhK6+u
        eHz7P3AJXau1LiLiGbvCzAaJnKe+LuqxO3bosu0=
X-Google-Smtp-Source: ABdhPJwpcfEfcHMSpcGz3n9Ns0AHtE+MN21I3/B3RmI4dynY8KmvHJWte3J/5ccdGSLGB3w1a53QMgNKhF06LhYu5mE=
X-Received: by 2002:a25:d310:: with SMTP id e16mr1230770ybf.504.1637625840552;
 Mon, 22 Nov 2021 16:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com> <20211120033255.91214-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20211120033255.91214-8-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 16:03:49 -0800
Message-ID: <CAEf4BzYXO_T7rLSs3aReF+oLfdjgd6WEzw9WNUynom7UOwtyNw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 07/13] libbpf: Use CO-RE in the kernel in
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

On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
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

[...]

>         if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
> @@ -5653,6 +5679,9 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
>                 case RELO_CALL:
>                         /* handled already */
>                         break;
> +               case RELO_CORE:
> +                       /* will be handled by bpf_program_record_relos() */
> +                       break;
>                 default:
>                         pr_warn("prog '%s': relo #%d: bad relo type %d\n",
>                                 prog->name, i, relo->type);
> @@ -6090,6 +6119,35 @@ bpf_object__free_relocs(struct bpf_object *obj)
>         }
>  }
>
> +static int cmp_relocs(const void *_a, const void *_b)
> +{
> +       const struct reloc_desc *a = _a;
> +       const struct reloc_desc *b = _b;
> +
> +       if (a->insn_idx != b->insn_idx)
> +               return a->insn_idx < b->insn_idx ? -1 : 1;
> +
> +       /* no two relocations should have the same insn_idx, but ... */
> +       if (a->type != b->type)
> +               return a->type < b->type ? -1 : 1;
> +
> +       return 0;
> +}
> +
> +static void bpf_object__sort_relos(struct bpf_object *obj)
> +{
> +       int i;
> +
> +       for (i = 0; i < obj->nr_programs; i++) {
> +               struct bpf_program *p = &obj->programs[i];
> +
> +               if (!p->nr_reloc)
> +                       continue;
> +
> +               qsort(p->reloc_desc, p->nr_reloc, sizeof(*p->reloc_desc), cmp_relocs);
> +       }
> +}
> +
>  static int
>  bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
>  {
> @@ -6104,6 +6162,8 @@ bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
>                                 err);
>                         return err;
>                 }
> +               if (obj->gen_loader)
> +                       bpf_object__sort_relos(obj);

libbpf sorts relos because it does binary search on them (see
find_prog_insn_relo). Kernel doesn't seem to enforce the order of
CO-RE relocations, so there doesn't seem to be a need to sort them. Is
there any reason you wanted to sort them? Does light skeleton's
generated code rely on some ordering? If yes, let's add a small
comment to document this.

>         }
>
>         /* Before relocating calls pre-process relocations and mark

[...]
