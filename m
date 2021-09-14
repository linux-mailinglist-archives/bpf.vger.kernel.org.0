Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811D040A5B0
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 06:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhINFAm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 01:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhINFAl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 01:00:41 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F668C061574
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:59:25 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id v10so25416784ybq.7
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=742MGnNDA8zuwELaLoWQLIMYpaQ3fWT3jZ6YCmFGcAE=;
        b=RyXjEdqoCRCQYEWxGIArJ6eNwIQR26lkaHo9fZng0OHc7pn1wq9eVibkqfzrVY4fSI
         R2qtv8m4w+0LR9vV43r9dwHAabS7jUAsAUxteJpyeDIj3pJx3vg5bxgcGpwdpMNxfmrF
         ywSROUWF/cLTx2jlMstba9GyAt9EGlIuR5taHI+/UqI6C+A5zXYhrctCteL+K2DU/oCk
         3qZmIQ+T82V/JxuHMSrSJLAJ93HEjm2glOw8PEGkFgFKQBiIq/lcYACP5Qf689RQEDRs
         DcH87UUlj/QW+DznBals47N5dzYvnlsxlnwrNeS5KM1XXv6jfi1L4ZrX9QVS4yZzSFHM
         GuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=742MGnNDA8zuwELaLoWQLIMYpaQ3fWT3jZ6YCmFGcAE=;
        b=szz48tEmXvr+KF+9nkCl8KpwKy+W/wT0zwznspqMK9kIz+TGjyaUKHn0jySb8D8Vcw
         IkDra1u3EaqAZSkezDexIMtapZ2c25MtV5h4DmS3w2n/sYhEmYZl66DRZzZ0cXh/8cd6
         Py2aP/lgjjnJdWTCFiboTbuJney4HhxcpsWjnu38mKCMHY38NBsrjrZ+DDWAK7CrOFfd
         Wk52w09Qfb1E5WHS5so2tWBr1DElDCJawXpcfq2Yxf630Kb5/JbjqxVgFxNqavqZLib9
         /+ZSXgMbiU2EldaeSnu8scmjvFo3ULoeo8s1Zem77aP+3UrJ4ihnJecbEESBeTQqE0TA
         SJsA==
X-Gm-Message-State: AOAM5325kvFi0ixA4uIUdBC8JOKs9PeYb2OcPtcTMInRgB4KVqOSxnqs
        KtiCeXhNA8YYoWxI++hPlDOgf5S6cjODPv5Gx2U=
X-Google-Smtp-Source: ABdhPJztDdNnoWfrGF60TixSBorEfMDrn88ix5xBhqEz0xD/RlL4Tjx+fosh8BrNOCNy3oic5uTOtloU4QshXj8/gGk=
X-Received: by 2002:a5b:408:: with SMTP id m8mr20414639ybp.2.1631595564487;
 Mon, 13 Sep 2021 21:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210913155122.3722704-1-yhs@fb.com> <20210913155127.3723489-1-yhs@fb.com>
In-Reply-To: <20210913155127.3723489-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Sep 2021 21:59:13 -0700
Message-ID: <CAEf4BzbZuKF6eN0BSsr_3c-g7ZbVzP6P__3Y9f35ef-zjWS20A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/11] btf: change BTF_KIND_* macros to enums
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
> Change BTF_KIND_* macros to enums so they are encoded in dwarf and
> appear in vmlinux.h. This will make it easier for bpf programs
> to use these constants without macro definitions.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/uapi/linux/btf.h       | 36 ++++++++++++++++++----------------
>  tools/include/uapi/linux/btf.h | 36 ++++++++++++++++++----------------
>  2 files changed, 38 insertions(+), 34 deletions(-)
>
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index d27b1708efe9..c32cd6697d63 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -56,23 +56,25 @@ struct btf_type {
>  #define BTF_INFO_VLEN(info)    ((info) & 0xffff)
>  #define BTF_INFO_KFLAG(info)   ((info) >> 31)
>
> -#define BTF_KIND_UNKN          0       /* Unknown      */
> -#define BTF_KIND_INT           1       /* Integer      */
> -#define BTF_KIND_PTR           2       /* Pointer      */
> -#define BTF_KIND_ARRAY         3       /* Array        */
> -#define BTF_KIND_STRUCT                4       /* Struct       */
> -#define BTF_KIND_UNION         5       /* Union        */
> -#define BTF_KIND_ENUM          6       /* Enumeration  */
> -#define BTF_KIND_FWD           7       /* Forward      */
> -#define BTF_KIND_TYPEDEF       8       /* Typedef      */
> -#define BTF_KIND_VOLATILE      9       /* Volatile     */
> -#define BTF_KIND_CONST         10      /* Const        */
> -#define BTF_KIND_RESTRICT      11      /* Restrict     */
> -#define BTF_KIND_FUNC          12      /* Function     */
> -#define BTF_KIND_FUNC_PROTO    13      /* Function Proto       */
> -#define BTF_KIND_VAR           14      /* Variable     */
> -#define BTF_KIND_DATASEC       15      /* Section      */
> -#define BTF_KIND_FLOAT         16      /* Floating point       */
> +enum {
> +       BTF_KIND_UNKN = 0,      /* Unknown      */
> +       BTF_KIND_INT,           /* Integer      */
> +       BTF_KIND_PTR,           /* Pointer      */
> +       BTF_KIND_ARRAY,         /* Array        */
> +       BTF_KIND_STRUCT,        /* Struct       */
> +       BTF_KIND_UNION,         /* Union        */
> +       BTF_KIND_ENUM,          /* Enumeration  */
> +       BTF_KIND_FWD,           /* Forward      */
> +       BTF_KIND_TYPEDEF,       /* Typedef      */
> +       BTF_KIND_VOLATILE,      /* Volatile     */
> +       BTF_KIND_CONST,         /* Const        */
> +       BTF_KIND_RESTRICT,      /* Restrict     */
> +       BTF_KIND_FUNC,          /* Function     */
> +       BTF_KIND_FUNC_PROTO,    /* Function Proto       */
> +       BTF_KIND_VAR,           /* Variable     */
> +       BTF_KIND_DATASEC,       /* Section      */
> +       BTF_KIND_FLOAT,         /* Floating point       */

Can you please leave explicit integer values specified? It's extremely
helpful and much easier in practice, compared to having to count the
number of rows from BTF_KIND_UNKN. Had to do it multiple times with
other BPF constants and was happy I didn't have to do that for
BTF_KIND enums.

> +};
>  #define BTF_KIND_MAX           BTF_KIND_FLOAT
>  #define NR_BTF_KINDS           (BTF_KIND_MAX + 1)

these two can be just an enum values as well, and actually will be
"auto-updated", if done this way (I think, haven't really tested)

BTF_KIND_FLOAT = 16,
NR_BTF_KINDS,
BTF_KIND_MAX = NR_BTF_KINDS - 1,

... won't it?

[...]
