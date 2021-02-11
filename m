Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91F331828C
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 01:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhBKAUP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 19:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhBKAUK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 19:20:10 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D1C061756
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 16:19:30 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id d184so3921561ybf.1
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 16:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6A4zYMc59kDIi9TBIBoQ9VlmypYayM4f4YJFCK0j8M=;
        b=UbLaA0WXznYJWWXk6LCGwrZTuozj3FmZ8UQvNn0K/wdDS3ykePzeWLvcnwiaHW5myd
         GoWcdtC6PciNKEmgetBQT0wQSwEjdWoXEYPCMyftuRqG3PfX8x1T6fExeqg6eZOdNytj
         s3JzUwc+LhpdmgJNDW+ct5CrVVLAzPwzLEtiViZ1AAR391zlnezPnCW0Ago5hrCQaHtg
         YcRZkR1OijrfnhPf9B2t9iIEvyIR0u97e06PjI1+lcnU1juvHVoMD+DpfYWx0eDB7f+K
         T8bufNkCkR60ZpQe0U5S8JneUr5/98b0G/Wd0/riMgxW3YojADTfd2Kso/FHSaTRpule
         DSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6A4zYMc59kDIi9TBIBoQ9VlmypYayM4f4YJFCK0j8M=;
        b=VSEiNy+WElWe0JvQmaznj6uu0uYdLomBaNUYIEa9qbFKlQ1s/UFn0XQQAL5c2R4Qua
         SkbapGSYNSRucaN87iA1jIRb8HZCdcJ10sPH6AVkrbKJ/4n9kbl2qXvlVr6eiBMXJDQP
         5z52u6g9jyKyVnO5Vs9GzLoqRl5yj7LZrKhbM/TE9jZLUqyKCG4p3i8gSIqreO/i7qU4
         CutOY00sFC7EKVXQ8qrPVu12aus36aRSJDj8NX/wmGSlnDBOC3JzV4tG//vDKBeQ0em2
         j7wgVlUD/g2tzJEz7K135Daw+SBomqoOaFaaevKQG5oP3ZT+FNPjLENcD4gGERW6sFiW
         WiLg==
X-Gm-Message-State: AOAM5330q78OVQArOKYCcZybl6szgKlUAhr4zqH2WZLKLYjNK9xTbJhY
        XeZE3eNi0tc5aunHKjGdYB4HXkQluVbF7Nwv0Cc=
X-Google-Smtp-Source: ABdhPJy7rGUblm7p8yqqQtiKpIovWTdTZmDfRTqz39C1IYsbmSzoiLT4Ld8GLyCpxX4j3E3gyb+x/hPguw60SthnBEk=
X-Received: by 2002:a25:37c4:: with SMTP id e187mr8122385yba.347.1613002769991;
 Wed, 10 Feb 2021 16:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20210210030317.78820-1-iii@linux.ibm.com> <20210210030317.78820-2-iii@linux.ibm.com>
In-Reply-To: <20210210030317.78820-2-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 16:19:19 -0800
Message-ID: <CAEf4BzY-SOyP0g-ZHTK3h1mppwRGJ4YH3vKugeuLGTe8Q3-r7Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/6] bpf: Add BTF_KIND_FLOAT to uapi
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 9, 2021 at 7:03 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Add a new kind value, expand the kind bitfield, add a macro for
> parsing the additional u32.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  include/uapi/linux/btf.h       | 10 ++++++++--
>  tools/include/uapi/linux/btf.h | 10 ++++++++--
>  2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> index 5a667107ad2c..e713430cb033 100644
> --- a/include/uapi/linux/btf.h
> +++ b/include/uapi/linux/btf.h
> @@ -52,7 +52,7 @@ struct btf_type {
>         };
>  };
>
> -#define BTF_INFO_KIND(info)    (((info) >> 24) & 0x0f)
> +#define BTF_INFO_KIND(info)    (((info) >> 24) & 0x1f)
>  #define BTF_INFO_VLEN(info)    ((info) & 0xffff)
>  #define BTF_INFO_KFLAG(info)   ((info) >> 31)
>
> @@ -72,7 +72,8 @@ struct btf_type {
>  #define BTF_KIND_FUNC_PROTO    13      /* Function Proto       */
>  #define BTF_KIND_VAR           14      /* Variable     */
>  #define BTF_KIND_DATASEC       15      /* Section      */
> -#define BTF_KIND_MAX           BTF_KIND_DATASEC
> +#define BTF_KIND_FLOAT         16      /* Floating point       */
> +#define BTF_KIND_MAX           BTF_KIND_FLOAT
>  #define NR_BTF_KINDS           (BTF_KIND_MAX + 1)
>
>  /* For some specific BTF_KIND, "struct btf_type" is immediately
> @@ -169,4 +170,9 @@ struct btf_var_secinfo {
>         __u32   size;
>  };
>
> +/* BTF_KIND_FLOAT is followed by a u32 and the following


what's the point of that u32, if BTF_FLOAT_BITS() is just t->size * 8?
Why adding this complexity. BTF_KIND_INT has bits because we had an
inconvenient bitfield encoding as a special BTF_KIND_INT types, which
we since stopped using in favor of encoding bitfield sizes and offsets
inside struct/union fields. I don't think there is any need for that
with FLOAT, so why waste space and add complexity and possibility for
inconsistencies?

Disclaimer: I'm in a "just BTF_KIND_INT encoding bit for
floating-point numbers" camp.

> + * is the 32 bits arrangement:
> + */
> +#define BTF_FLOAT_BITS(VAL)    ((VAL)  & 0x000000ff)
> +
>  #endif /* _UAPI__LINUX_BTF_H__ */
> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
> index 5a667107ad2c..e713430cb033 100644
> --- a/tools/include/uapi/linux/btf.h
> +++ b/tools/include/uapi/linux/btf.h
> @@ -52,7 +52,7 @@ struct btf_type {
>         };
>  };
>
> -#define BTF_INFO_KIND(info)    (((info) >> 24) & 0x0f)
> +#define BTF_INFO_KIND(info)    (((info) >> 24) & 0x1f)
>  #define BTF_INFO_VLEN(info)    ((info) & 0xffff)
>  #define BTF_INFO_KFLAG(info)   ((info) >> 31)
>
> @@ -72,7 +72,8 @@ struct btf_type {
>  #define BTF_KIND_FUNC_PROTO    13      /* Function Proto       */
>  #define BTF_KIND_VAR           14      /* Variable     */
>  #define BTF_KIND_DATASEC       15      /* Section      */
> -#define BTF_KIND_MAX           BTF_KIND_DATASEC
> +#define BTF_KIND_FLOAT         16      /* Floating point       */
> +#define BTF_KIND_MAX           BTF_KIND_FLOAT
>  #define NR_BTF_KINDS           (BTF_KIND_MAX + 1)
>
>  /* For some specific BTF_KIND, "struct btf_type" is immediately
> @@ -169,4 +170,9 @@ struct btf_var_secinfo {
>         __u32   size;
>  };
>
> +/* BTF_KIND_FLOAT is followed by a u32 and the following
> + * is the 32 bits arrangement:
> + */
> +#define BTF_FLOAT_BITS(VAL)    ((VAL)  & 0x000000ff)
> +
>  #endif /* _UAPI__LINUX_BTF_H__ */
> --
> 2.29.2
>
