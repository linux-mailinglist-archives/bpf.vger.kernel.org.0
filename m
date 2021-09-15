Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BD340BC7E
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 02:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhIOAPQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 20:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhIOAPQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 20:15:16 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31938C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:13:58 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id z18so1898699ybg.8
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8OeYHwji+qbv10YfpNjWC0llK6+JGcFrpll3zna3Bg=;
        b=DWjWfCpjbJwWM+NGg6rnUcuhbGW1vYU/6EiQXIPDGlfZajrtOJ3Js5xBC1OJD8jnrm
         QSIGWmxcJM9KIKRlGdm2VfxQIqJwMHr/X1/tKRhmTuA/I6WSMn5si8ONvmjUwBocZzBX
         5qb1s9OenJGeCblAL+jenhrp6kCC6wq/ZL8mVZOa8VsUZQehUhm+QTQutjg5IO+8Cung
         yOvqRufum94XnE193SvEdG3pgg4mNoTWpQ98YNGss8S12uzmUuC9R/8F/F19n5CYle0q
         4LL+/gOTWYM1wQmmWUuaS2iB62r3nHg8cS2j0OQGP6JRGffEPU9xoPaTymezYynI0d73
         66Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8OeYHwji+qbv10YfpNjWC0llK6+JGcFrpll3zna3Bg=;
        b=HJVJ9h0RCrKIC+vDEshNv1KVNpDUjSS5YadITpw62+g0FRAqPnyjhPu5Icml8v05ID
         QmBus1Z2lAK8+RefsyIUBn77ChLGGcvcoLkxajkExKLTQK9g9VynaE1TVztL4LFyG3Ss
         mmF7uwAQ5ZvAUyKys71F0QgYyCEgupRHFkGSFT/HvuOzrL9b1vIlPfsJ0mLM9jDKgKqu
         mcWgLlVvSO+AzSnWhcIi8JqmxKfs77F2MmMthKBNsasKTtBmzTwsPh6loBmflHETbSYF
         +5yEa3U5bCZ0zkQYYQ7TZ4LJE9qfo9TDo7WqLvofq7JT4/6tQvW8r3FfIaxBpb8UfIdS
         /S4Q==
X-Gm-Message-State: AOAM532oZxzShkTHm/ZalbYZWueF38KFnHoaDZQctrRYDvOUIjCdv6hb
        h+g+jaghlmNU//pm8nvRfSgK9Yxejc8H0SGpdZ01nkHeECc=
X-Google-Smtp-Source: ABdhPJzh/LmQ9tfDgR+p80D4PqDUI4XYbpJD3bq84kNixuVszNsbNCBWwUe4LUdhsjLxRVV9v/nKYYp5hnqk+sDUFG0=
X-Received: by 2002:a25:fc5:: with SMTP id 188mr1983697ybp.51.1631664837427;
 Tue, 14 Sep 2021 17:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210914223004.244411-1-yhs@fb.com> <20210914223009.245307-1-yhs@fb.com>
In-Reply-To: <20210914223009.245307-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 17:13:46 -0700
Message-ID: <CAEf4BzYHpE--DwO-wXsnaQhz5zUkHoABRPK4FdJfRWm4gyYXXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] btf: change BTF_KIND_* macros to enums
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 3:30 PM Yonghong Song <yhs@fb.com> wrote:
>
> Change BTF_KIND_* macros to enums so they are encoded in dwarf and
> appear in vmlinux.h. This will make it easier for bpf programs
> to use these constants without macro definitions.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Awesome, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/uapi/linux/btf.h       | 41 ++++++++++++++++++----------------
>  tools/include/uapi/linux/btf.h | 41 ++++++++++++++++++----------------
>  2 files changed, 44 insertions(+), 38 deletions(-)
>
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index d27b1708efe9..10e401073dd1 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -56,25 +56,28 @@ struct btf_type {
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
> -#define BTF_KIND_MAX           BTF_KIND_FLOAT
> -#define NR_BTF_KINDS           (BTF_KIND_MAX + 1)
> +enum {
> +       BTF_KIND_UNKN           = 0,    /* Unknown      */
> +       BTF_KIND_INT            = 1,    /* Integer      */
> +       BTF_KIND_PTR            = 2,    /* Pointer      */
> +       BTF_KIND_ARRAY          = 3,    /* Array        */
> +       BTF_KIND_STRUCT         = 4,    /* Struct       */
> +       BTF_KIND_UNION          = 5,    /* Union        */
> +       BTF_KIND_ENUM           = 6,    /* Enumeration  */
> +       BTF_KIND_FWD            = 7,    /* Forward      */
> +       BTF_KIND_TYPEDEF        = 8,    /* Typedef      */
> +       BTF_KIND_VOLATILE       = 9,    /* Volatile     */
> +       BTF_KIND_CONST          = 10,   /* Const        */
> +       BTF_KIND_RESTRICT       = 11,   /* Restrict     */
> +       BTF_KIND_FUNC           = 12,   /* Function     */
> +       BTF_KIND_FUNC_PROTO     = 13,   /* Function Proto       */
> +       BTF_KIND_VAR            = 14,   /* Variable     */
> +       BTF_KIND_DATASEC        = 15,   /* Section      */
> +       BTF_KIND_FLOAT          = 16,   /* Floating point       */
> +
> +       NR_BTF_KINDS,
> +       BTF_KIND_MAX            = NR_BTF_KINDS - 1,
> +};
>
>  /* For some specific BTF_KIND, "struct btf_type" is immediately
>   * followed by extra data.

[...]
