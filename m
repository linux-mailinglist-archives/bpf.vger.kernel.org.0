Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BF440A5DD
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 07:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbhINFSW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 01:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239328AbhINFSW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 01:18:22 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E1DC061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:17:05 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id c6so25502603ybm.10
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXiT4vpi30YjX7ZZGG023I3m4pPhmn/n/0GAszSHR+8=;
        b=IVJxqFeM126/GxQEDjKI2Zs75+Day4TPyqjuv55SCwpWvWqhT6zPKGosudun1tlgd4
         UZM7J/Gf6GJZ+NPhr5O2xUzeGbcn6vB6vlrtf06EnK87nEggGD7y6c9qHGiVGhuooB2Y
         F5skp4RP+FLbm7ChU5QFPjTgBftayFm8PYBmksSbzVtEHwVA9ytUW2yDIY1drPJpzE2M
         rJg5q+1WE+LM6cxo4t2gC/tK6+jebCsLuYKyivRyeIiq5Growk8yo/rTlvRmYA7Ie4vI
         +m+oOci+9FtaUtlACofdFG9/7VYtId3IZbsVRof0ZQiCi76i3N+0K+zuT35gqq5wSzXa
         uOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXiT4vpi30YjX7ZZGG023I3m4pPhmn/n/0GAszSHR+8=;
        b=w/hai7uAG1g6kYlFrGRZSgsj8eNvcCwEkVCB4LOy48eTifYZrNV5CvUFqU6unVmau8
         tKKL0XWWiF+ipoSox7fg1BOzul3/sTgWIw+Eq5OdkqFxCXWNkgPDFddPZ6UCW4VynVqq
         2ii/ar6038FObiuWvZRakJaZJy20nd2CRH5LaPbSPcXiALCZXtypuCcoIAO3EVxZL6yb
         8UK8IeUcuYd4XoyDbyFI5UbeRA6IXEjXee9w7svPYJ16BtLHkFxro8CLc4GRFTItuZsv
         WTlo1Q4m2kkBXpMK2twJrkaD+ieL9hakMd857hh58yvrlB6fvXFBY3T+lc9Yrn+g1n70
         G4OQ==
X-Gm-Message-State: AOAM533lFveGEsoZAz0nqToKWZC2hggGsuPGd4DHX4JTkFzTUL6e6dGY
        1GJ7bTtrDKoQ6/QDF2oRzuQqQqbNRYvZ2DnpsHNwWhND8Ms=
X-Google-Smtp-Source: ABdhPJzgsBeiOsZhlpJDzTGbXD2Dg769eHE1963mwF7obbwVkXYcq/lv6Jyc6dpP+e9o3LEPMGV06Qn1ThtWe6KSNus=
X-Received: by 2002:a5b:408:: with SMTP id m8mr20492722ybp.2.1631596624763;
 Mon, 13 Sep 2021 22:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210913155122.3722704-1-yhs@fb.com> <20210913155150.3727112-1-yhs@fb.com>
In-Reply-To: <20210913155150.3727112-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 22:16:53 -0700
Message-ID: <CAEf4BzZv6yxdPGyNozewEiVMOy9U6Gcr0vzrTGsKN=NqB-=XXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/11] bpftool: add support for BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 8:51 AM Yonghong Song <yhs@fb.com> wrote:
>
> Added bpftool support to dump BTF_KIND_TAG information.
> The new bpftool will be used in later patches to dump
> btf in the test bpf program object file.
>
> Currently, the tags are not emitted with
>   bpftool btf dump file <path> format c
> and they are silently ignored.  The tag information is
> mostly used in the kernel for verification purpose and the kernel
> uses its own btf to check. With adding these tags
> to vmlinux.h, tags will be encoded in program's btf but
> they will not be used by the kernel, at least for now.
> So let us delay adding these tags to format C header files
> until there is a real need.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/bpf/bpftool/btf.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index f7e5ff3586c9..49743ad96851 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -37,6 +37,7 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>         [BTF_KIND_VAR]          = "VAR",
>         [BTF_KIND_DATASEC]      = "DATASEC",
>         [BTF_KIND_FLOAT]        = "FLOAT",
> +       [BTF_KIND_TAG]          = "TAG",
>  };
>
>  struct btf_attach_table {
> @@ -347,6 +348,17 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>                         printf(" size=%u", t->size);
>                 break;
>         }
> +       case BTF_KIND_TAG: {
> +               const struct btf_tag *tag = (const void *)(t + 1);
> +
> +               if (json_output) {
> +                       jsonw_uint_field(w, "type_id", t->type);
> +                       jsonw_int_field(w, "component_idx", tag->component_idx);
> +               } else {
> +                       printf(" type_id=%u component_idx=%d", t->type, tag->component_idx);
> +               }
> +               break;
> +       }
>         default:
>                 break;
>         }
> --
> 2.30.2
>
