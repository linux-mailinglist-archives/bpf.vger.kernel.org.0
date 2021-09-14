Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473D040A609
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 07:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbhINFlk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 01:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbhINFle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 01:41:34 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B137AC061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:40:17 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v10so25605944ybq.7
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 22:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwKEJO8dHd9HFUtz/ZIsaaJIFWPqMbGTJPnenJoSIoY=;
        b=HNcq6Rz03z0sJWLynIxTOCtJoVImtpskehksmoF8tky6uRaSczUXg3802oC2XC685f
         gpBZDM9vJJ2gGF4JkGZupnjMVOl3pb5hANJp4Plvh9Qml1wy5LTkIn8TzRyxxHJLDbqI
         HgttWm9qUdQrRqvdYO7KoPsYelamm6HeEzequegSJkczCh7Q5gyS+SXyX6tVg9Se1xjh
         EhFxY+PPVWbZczjjN/fL5YdghxzmVc/LbYEWh2epX/OQjK+v9Mthb7Lp6BSRZYpnZtx7
         S+I8W3R/zV8pwSTVx85L1jvhjyMZb2psk0oa9EFP030K4MTBRE4foIfWagJ28P/Jq8T2
         x3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwKEJO8dHd9HFUtz/ZIsaaJIFWPqMbGTJPnenJoSIoY=;
        b=mIij5AcNT+BdRDGn1GeR6I1iSun3EQDtwr1ljk7MuPf9eNt/hUz/f2AOGWRKFdmGtm
         oY8RH1yndw+WXJdQwYS4E5gUuScamQVnjo2TC08ZUtqFl+WP6IjBvkwnwEs7xIEtzSNx
         a0XXAdNyTJ9dJQoJeuw+7r7WleGgbBGXe9d0MteMa/Mrc1Q+dE4e6Zoge8TH5g4sLpbb
         TJ/DLYbDflru1HPAKH6MiSZB3sPfVBEKme3PxiDTtJIWH94ddtG91lvveCYhv97gXqzn
         IOvhta9nFheksR1it5n7meX+1LX9wwDk0Ag8UOSdjBHIvVTdFp/fBIOGyjQLuCSfI7rQ
         DVQQ==
X-Gm-Message-State: AOAM5303vR6UiFfcyTG0Ic1GbYEM9Mz7lLrv38+aXa9sR210L3XMm2uP
        LkdgkJVltGTGMkNHDB06nY8uNGJVx1Lt7U7DzCg=
X-Google-Smtp-Source: ABdhPJy84ON6peGMPEy05CV4GhjjA4ZFMeKWkDkbolSf57jlkHkEI8IFESb7PMASkBa4MEK014arYAKN6+jTNMcjg50=
X-Received: by 2002:a05:6902:724:: with SMTP id l4mr18679660ybt.433.1631598016946;
 Mon, 13 Sep 2021 22:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210913155122.3722704-1-yhs@fb.com> <20210913155221.3729990-1-yhs@fb.com>
In-Reply-To: <20210913155221.3729990-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 22:40:06 -0700
Message-ID: <CAEf4BzY=8PMXhZDiQ-+CDfsVOxTmR-vxNQBJwODX3UKba2sNwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 11/11] docs/bpf: add documentation for BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 8:53 AM Yonghong Song <yhs@fb.com> wrote:
>
> Add BTF_KIND_TAG documentation in btf.rst.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Probably worth it to mention that component_idx for tag for VAR has to be -1.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  Documentation/bpf/btf.rst | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 846354cd2d69..9fff578a0a35 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -85,6 +85,7 @@ sequentially and type id is assigned to each recognized type starting from id
>      #define BTF_KIND_VAR            14      /* Variable     */
>      #define BTF_KIND_DATASEC        15      /* Section      */
>      #define BTF_KIND_FLOAT          16      /* Floating point       */
> +    #define BTF_KIND_TAG            17      /* Tag          */
>
>  Note that the type section encodes debug info, not just pure types.
>  ``BTF_KIND_FUNC`` is not a type, and it represents a defined subprogram.
> @@ -106,7 +107,7 @@ Each type contains the following common data::
>           * "size" tells the size of the type it is describing.
>           *
>           * "type" is used by PTR, TYPEDEF, VOLATILE, CONST, RESTRICT,
> -         * FUNC and FUNC_PROTO.
> +         * FUNC, FUNC_PROTO and TAG.
>           * "type" is a type_id referring to another type.
>           */
>          union {
> @@ -465,6 +466,30 @@ map definition.
>
>  No additional type data follow ``btf_type``.
>
> +2.2.17 BTF_KIND_TAG
> +~~~~~~~~~~~~~~~~~~~
> +
> +``struct btf_type`` encoding requirement:
> + * ``name_off``: offset to a non-empty string
> + * ``info.kind_flag``: 0
> + * ``info.kind``: BTF_KIND_TAG
> + * ``info.vlen``: 0
> + * ``type``: ``struct``, ``union``, ``func`` or ``var``
> +
> +``btf_type`` is followed by ``struct btf_tag``.::
> +
> +    struct btf_tag {
> +        __u32   component_idx;
> +    };
> +
> +The ``name_off`` encodes btf_tag attribute string.
> +The ``type`` should be ``struct``, ``union``, ``func`` or ``var``.
> +If ``btf_tag.component_idx = -1``, the btf_tag attribute is
> +applied to a valid ``type``. Otherwise, the btf_tag attribute is
> +applied to a ``struct``/``union`` member or a ``func`` argument,
> +and ``btf_tag.component_idx`` should be a valid index (starting from 0)
> +pointing to a member or an argument.
> +
>  3. BTF Kernel API
>  *****************
>
> --
> 2.30.2
>
