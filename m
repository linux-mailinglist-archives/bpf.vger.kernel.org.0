Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9A0453F1D
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 04:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhKQDs5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 22:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhKQDs5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 22:48:57 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C689C061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 19:45:59 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id i194so3185872yba.6
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 19:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHG24AoUoQsGyzUilmQLsyeMZwWN7F/yPFEDmabh5Eo=;
        b=g5bxHvePsfhVUCVxtJv6SxZ/MObpqoUGddBauna4QUMP8tG693BFRiNcn7x0ME6nHW
         iWOj+yXL6B5SngqMcm22nhIFqvAlDDmWX4CMK+vr2iRJNdtgQq0MzG0wFca6oNmTqtAa
         sEQr5Tx+Tl1tyb7z5CyYVe5/SE6D7+MgUyL31yZ03Rq+o3k66/KMVRKOi5Mb9Z4wSZUy
         rkODYRvn8RDT0ngZ4smrfNNKAabAgiXu7mPSs+a13jKiJjZ4OweF/horG4XIpmzBv2yz
         3cQIlFwyDHJD58EQpNL/22GZOc28SYSswf1A5W5Nlej5v3x6AtSWV6taoW61EHjK8XMO
         T+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHG24AoUoQsGyzUilmQLsyeMZwWN7F/yPFEDmabh5Eo=;
        b=ZI1zicA4OLAuRIX9opPWI25Pm1eUz76oPVCc9hDNGiELNko/sDffWzNSmt2qRRbwST
         D47NMlIW8oNQNupVCNodGmXc98OxUBqdmHSRmiwbFoYmShjz3bgQxygDsn0MLYQVSHfE
         zrUVyuJGDH7NGogziDs8maz+RwJuKFPiMR8bRFHtWHw3GyOoTbflsVlPABkDIuOQ6Dvr
         iBi9SsgLuj67F/Tsb9qV2fe/hjtoCvlVIcMIRnQXTQgQMYFusVa5i+6U68Ix3iROCll6
         veT4UAEO0asgKhfBq+thAV/uJGAl3xueH6CfH6kORxbi7U1EpRnUfZJplr7K3uBuQ3ip
         uHuQ==
X-Gm-Message-State: AOAM53155a9r9qIiSKl5fGY/9f6W7qIaHSEnFv/dad6O59vsYy2SROZ5
        GODCKliqFC1dg2Bx0lAH3HMjyIVaG5ha/y5DBTM=
X-Google-Smtp-Source: ABdhPJzaW9/bejPnQBIv4uWlmoYqxsElko7hhu54Z1acvpxM0/m5d8qbZz7yMQMmOwha0QR7Wogmmhw22YP38PrftFY=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr14439316ybj.504.1637120758769;
 Tue, 16 Nov 2021 19:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com> <20211112050230.85640-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20211112050230.85640-8-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 19:45:47 -0800
Message-ID: <CAEf4BzZwgvN1Qdoukr-KxBQ_GFP9Fj=wYe16_qdZxJ-oummguA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/12] libbpf: Use CO-RE in the kernel in
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

On Thu, Nov 11, 2021 at 9:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Without lskel the CO-RE relocations are processed by libbpf before any other
> work is done. Instead, when lksel is needed, remember relocation as RELO_CORE

typo: lskel

> kind. Then when loader prog is generated for a given bpf program pass CO-RE
> relos of that program to gen loader via bpf_gen__record_relo_core(). The gen
> loader will remember them as-is and pass it later as-is into the kernel.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/bpf_gen_internal.h |   3 +
>  tools/lib/bpf/gen_loader.c       |  41 +++++++++++-
>  tools/lib/bpf/libbpf.c           | 104 +++++++++++++++++++++++--------
>  3 files changed, 119 insertions(+), 29 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
> index 75ca9fb857b2..ed162fdeecf6 100644
> --- a/tools/lib/bpf/bpf_gen_internal.h
> +++ b/tools/lib/bpf/bpf_gen_internal.h
> @@ -39,6 +39,8 @@ struct bpf_gen {
>         int error;
>         struct ksym_relo_desc *relos;
>         int relo_cnt;
> +       struct bpf_core_relo *core_relo;

this is named as a singular pointer to one relocation, core_relos
would be a more natural name for an array?


> +       int core_relo_cnt;
>         char attach_target[128];
>         int attach_kind;
>         struct ksym_desc *ksyms;
> @@ -61,5 +63,6 @@ void bpf_gen__map_freeze(struct bpf_gen *gen, int map_idx);
>  void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *name, enum bpf_attach_type type);
>  void bpf_gen__record_extern(struct bpf_gen *gen, const char *name, bool is_weak,
>                             bool is_typeless, int kind, int insn_idx);

[...]

> @@ -6581,6 +6623,16 @@ static int bpf_program__record_externs(struct bpf_program *prog)
>                                                ext->is_weak, false, BTF_KIND_FUNC,
>                                                relo->insn_idx);
>                         break;
> +               case RELO_CORE: {

This is not an extern, it doesn't make sense to have it here. But I
also don't understand why we need to add RELO_CORE and extend struct
relo_desc in the first place, just to pass it as bpf_core_relo into
gen_loader. Why can't gen_loader just record this directly at the
place of record_relo_core() call?

> +                       struct bpf_core_relo cr = {
> +                               .insn_off = relo->insn_idx * 8,
> +                               .type_id = relo->type_id,
> +                               .access_str_off = relo->access_str_off,
> +                               .kind = relo->kind,
> +                       };
> +                       bpf_gen__record_relo_core(obj->gen_loader, &cr);
> +                       break;
> +               }
>                 default:
>                         continue;
>                 }
> --
> 2.30.2
>
