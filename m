Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAB029500D
	for <lists+bpf@lfdr.de>; Wed, 21 Oct 2020 17:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502616AbgJUPfs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Oct 2020 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502569AbgJUPfr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Oct 2020 11:35:47 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4979DC0613CE;
        Wed, 21 Oct 2020 08:35:46 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id l15so2156267ybp.2;
        Wed, 21 Oct 2020 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5/xCGnHx7slidVcpzEBSRP7yklPajwRiNS892kQv04=;
        b=YpQWMZgclARfg79AZH8x5LVSx//nNzx+8850kPMje6Trst53hiRgi92+WB/B0LGPW+
         fpsa7d4KFQmwNNpoV17Uqma21rnuDcbBmiGXVJm+XglGXxVuiVt7ASPHvWlKH1wbdqkX
         w1171aC7KetdR1nnBIH49Y0qVLzHyFsOXpuqRsV2awl4c19AWtFJGM1CSZ8QeyjR1pt7
         8ll4rxPPxWYfpCi66htOkgG24VugCmJYx8UEem2arWPBLoqMF7urjto4Yr/qHNxQ039i
         j/3+xYGB01vxooNkKs/08iEDbjqYBvSgSrpgwve7FMePeaO7JraeJ5W7gloBdGYTaB5V
         JBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5/xCGnHx7slidVcpzEBSRP7yklPajwRiNS892kQv04=;
        b=rh4SIMEoOanxBa4rjoZz3jhd1VXJeNwWn1SKgWS4qG+OoDzSDEAEF+sVYAXK8Uy1BW
         nFTp0hFtUUD3zINQFE6Xz1SrxCAMnQzLyJuh2stK+bowPd6Tm3Dmp5pvhEu6rQ+9J3uS
         RlpObpaK8fc0a3lRLrrnDC96PamCDRxhGV99EPP5WOu94fkhUu6C7C6qmMClnFN89TXm
         kvAvhEbDpokXJJl914hYFnwuSl6u7NFE7NVCWNUiXtE6GAG6sY/9X1xb+gdXk4pUMbcd
         +JXdlQ3t81cgYmqeLxAiJ4AhHK8UGG/R2zYdbVyxtsFFNUuKJr7TKDVbiFzr1kmDVn7j
         Unkw==
X-Gm-Message-State: AOAM531+DNEBqgH2D9m0EcNSWJ3jK0cH2MANLiRV2lFOxPfnyBilQqun
        lM53RjFWD2OAqh/Z3Ov+2w/s9kOI88nFvso3O4Y=
X-Google-Smtp-Source: ABdhPJyo+sR7bI5EENrfC2u9qIQ0dZr/cb77WxMoucEGZmSaHzxeEia1oD8Rh9xjeS9Lxpd3CfBIV4tN5v/A/+pmugw=
X-Received: by 2002:a25:c001:: with SMTP id c1mr5773484ybf.27.1603294545464;
 Wed, 21 Oct 2020 08:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201009192607.699835-1-andrii@kernel.org>
In-Reply-To: <20201009192607.699835-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 21 Oct 2020 08:35:34 -0700
Message-ID: <CAEf4BzY4k4B5Pc93wSOWD-Hjw=_uoFjfByxc44uXAipV+PV96g@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_loader: handle union forward declaration properly
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 12:26 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Differentiate between struct and union forwards. For BTF_KIND_FWD this is
> determined by kflag. So teach btf_loader to use that bit to decide whether
> forward is for union or struct.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
> N.B. This patch is based on top of tmp.libbtf_encoder branch.
>
> Also seems like non-forward declared union has a slightly different
> representation from struct (class). Not sure why it is so, but this change
> doesn't seem to break anything.
> ---

Ping on this one, let's include it with upcoming pahole 1.19 as well?

>
>  btf_loader.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/btf_loader.c b/btf_loader.c
> index 9b5da3a4997a..0cb23967fec3 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -134,12 +134,13 @@ static struct type *type__new(uint16_t tag, strings_t name, size_t size)
>         return type;
>  }
>
> -static struct class *class__new(strings_t name, size_t size)
> +static struct class *class__new(strings_t name, size_t size, bool is_union)
>  {
>         struct class *class = tag__alloc(sizeof(*class));
> +       uint32_t tag = is_union ? DW_TAG_union_type : DW_TAG_structure_type;
>
>         if (class != NULL) {
> -               type__init(&class->type, DW_TAG_structure_type, name, size);
> +               type__init(&class->type, tag, name, size);
>                 INIT_LIST_HEAD(&class->vtable);
>         }
>
> @@ -228,7 +229,7 @@ static int create_members(struct btf_elf *btfe, const struct btf_type *tp,
>
>  static int create_new_class(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -       struct class *class = class__new(tp->name_off, tp->size);
> +       struct class *class = class__new(tp->name_off, tp->size, false);
>         int member_size = create_members(btfe, tp, &class->type);
>
>         if (member_size < 0)
> @@ -313,7 +314,7 @@ static int create_new_subroutine_type(struct btf_elf *btfe, const struct btf_typ
>
>  static int create_new_forward_decl(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -       struct class *fwd = class__new(tp->name_off, 0);
> +       struct class *fwd = class__new(tp->name_off, 0, btf_kind(tp));
>
>         if (fwd == NULL)
>                 return -ENOMEM;
> --
> 2.24.1
>
