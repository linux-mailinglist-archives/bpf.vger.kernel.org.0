Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF3318288
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 01:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhBKAQi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 19:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhBKAQh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 19:16:37 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B5C061574
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 16:15:56 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id i71so3883073ybg.7
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 16:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRjRB76p7uasNgk6Y37mc4cxubCNDmg8dRRTITTNkRw=;
        b=F41QCZhl33ZUPwbcUmJ1VBOPXwQyWB6cGvtiezeeg1HWkN4qQOXZf+I7jkICtJe8Ax
         aHWypm9xqMYj+4b65QMOqUOg0xx5h/a55n/AryU8EjiHWtUDIrZ/6sRD8rAQM2BENOz+
         Gb0ErO8PVwgbQBiM2gmd96o9keFzfmgabpsF4VgjxI3kYw3C9Bnnj77IaXH31CsMdk71
         TAl7xdDZfyLnqqaDQrB9lOozBaRHTFaxSNL8+mdyF1MUb9F74Z+O1hoRRtLeJgyltAYW
         PPs9/zt3khz65Z8/XAK4CPoQFZEX3aGtp1dsfZkLhEFX4s4lj1npvUVUeKn1UjbdgOis
         Hu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRjRB76p7uasNgk6Y37mc4cxubCNDmg8dRRTITTNkRw=;
        b=Yaft7HB6OX8kZX5IgINbEeECqq+asKKGZtMeCMh10ZY38yIMjobmXyeTt6DfH2MBft
         s+wH47G3sLMOWrojQVsWnt7rwrQzcWm35HB1AajEDTIw6gaKTcUU7/Zf5W1Su8VX8ffS
         n+J3p+UqiXAXCIx/vcnyUmlIjWClLD8IEx2nCLwCfnvqUAO8SGvEsL7chyI4mratnFP7
         GxMTgGC4pNHzVzxeDJuG4UW7EFFSczWYOYQuQVNZUOIJhxabz9YXom0EPmyWiw+U6B/f
         9IdiNcveVrr0Ps7qfSgAgUJJtEKa2zdIGlvBV7qv+fMwU5qm+e0OnNJpTDKB1SiQpqO0
         RoZw==
X-Gm-Message-State: AOAM532FPoKz6EWc65psYfMbE3jsS1LY8JLeeOIlV1b9nekD6HtpksoC
        Wb6EfQ5Jc+ogWq3bT9tvLztmkqDLTQmYv7UomF4=
X-Google-Smtp-Source: ABdhPJzeAPMHqG37eIvrruVYsNbkF7KmjP7Yik1o5q7MIPOG/ofxKxM+q5jamG7wS9pCB7vicnM88PTAhJ3UXbCUaLU=
X-Received: by 2002:a25:9882:: with SMTP id l2mr7389667ybo.425.1613002555759;
 Wed, 10 Feb 2021 16:15:55 -0800 (PST)
MIME-Version: 1.0
References: <20210210030317.78820-1-iii@linux.ibm.com> <20210210030317.78820-3-iii@linux.ibm.com>
In-Reply-To: <20210210030317.78820-3-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 16:15:45 -0800
Message-ID: <CAEf4BzbqvvdMRNqEYMuTSZmjndZbCEhOj169tH6o8BFj8OwyxA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/6] libbpf: Add BTF_KIND_FLOAT support
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

On Tue, Feb 9, 2021 at 7:04 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> The logic follows that of BTF_KIND_INT most of the time, some functions
> are even unified to work on both. Sanitization replaces BTF_KIND_FLOATs
> with equally-sized BTF_KIND_INTs on older kernels.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/btf.c             | 85 +++++++++++++++++++++++----------
>  tools/lib/bpf/btf.h             | 13 +++++
>  tools/lib/bpf/btf_dump.c        |  4 ++
>  tools/lib/bpf/libbpf.c          | 32 ++++++++++++-
>  tools/lib/bpf/libbpf.map        |  5 ++
>  tools/lib/bpf/libbpf_internal.h |  4 ++
>  6 files changed, 118 insertions(+), 25 deletions(-)
>

[...]

> @@ -2445,6 +2450,12 @@ static void bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *btf)
>                 } else if (!has_func_global && btf_is_func(t)) {
>                         /* replace BTF_FUNC_GLOBAL with BTF_FUNC_STATIC */
>                         t->info = BTF_INFO_ENC(BTF_KIND_FUNC, 0, 0);
> +               } else if (!has_float && btf_is_float(t)) {
> +                       /* replace FLOAT with INT */
> +                       __u8 nr_bits = btf_float_bits(t);
> +

nit: no need for extra variable, just use it inline below

> +                       t->info = BTF_INFO_ENC(BTF_KIND_INT, 0, 0);
> +                       *(int *)(t + 1) = BTF_INT_ENC(0, 0, nr_bits);
>                 }
>         }
>  }
> @@ -3882,6 +3893,18 @@ static int probe_kern_btf_datasec(void)
>                                              strs, sizeof(strs)));
>  }

[...]
