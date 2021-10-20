Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305064352E6
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 20:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhJTSqw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 14:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhJTSqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 14:46:52 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42CDC06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:44:37 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g6so16837046ybb.3
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 11:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JX0DnHdrqYKUVRURMwYeJtC050q6Yp6Dl4aQtW5gb6U=;
        b=lx4fF7RzzRfdZoDLBiga4nSdMxcldfrinyMesEyUol5yfNOy0WLey+yKuZjXWH9RF1
         HygGI3nqPTY8z6E4lPSH6QKg4dD9IosDjWazpKOc3VuP1enEvezxv/NjoFsDiccsfABs
         e1HA+7Kw5LHfzw9jliG5Qn/Csvhj+vTuE5Pm/SHfAofffpUN9r63/sQVhnE/g5ctVkaj
         o+LgbyPoSazIKmfllnkBmqXbHoPs7OoB2D6Y9XRmiUH34ZPc2PluxUpMcz7HM+6qJw0Y
         Yjm8knsiLhowzJzKq4qrHEuN5ZWpbikn37X039ljXOX11YrdK9Jgn7qTuw5V1U13vONc
         ZGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JX0DnHdrqYKUVRURMwYeJtC050q6Yp6Dl4aQtW5gb6U=;
        b=vpiO/ff59cH4yQxOaem5VGUfRbU90/g9WJQ+uRBGVX/By6zoRgk4ufKCr+4druFpL3
         n9Ib4YL7/iYbR5vJFhj9OsgFUWVDOIN32CTInRLqciVDV467crp47bvJtssEKMKcWLp9
         N8/4F1VaGuWi9uesgbHeZhrFhgiGCH4z1VMT68w79ewCm97QC8qgG1nUy8TznlUcJDK/
         xhCzXouOIok1/EoqfT9+YzYqXIlv3xSMRGzzmNwDSuPCUXzcNfp2vxVjpNM55ma3I/fC
         w+2BuGuYz8tfj1njo5GzLqxB7t/KeyWcenO/cjTSsagXaSwBYolSwSQ3JwIGzFeR+V0Z
         0+sQ==
X-Gm-Message-State: AOAM533C73ZOkzo36jlUDmwt9nYrg9y85ARDUPBqSU1SDt7jwDWCLBNU
        F44RhkWXdQJbqJFvQ3DuC7XiGt6cyYuYfT7jAkDFlqoZgstcBw==
X-Google-Smtp-Source: ABdhPJwdOQUR+wyU8BRPH5azdCvve73LE6gahRzA8Iah9k5pjGAdsRmd/+jgOHc/5isNGe7uma0tZAIk+zZuD2+9T4c=
X-Received: by 2002:a25:24c1:: with SMTP id k184mr902752ybk.2.1634755476985;
 Wed, 20 Oct 2021 11:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211013160902.428340-1-iii@linux.ibm.com> <20211013160902.428340-5-iii@linux.ibm.com>
In-Reply-To: <20211013160902.428340-5-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 11:44:25 -0700
Message-ID: <CAEf4BzbQcsz8Y1_MVhnyjCaYx-t-MWBD8xykF3x-UHE9a+X8HQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] libbpf: Fix ptr_is_aligned() usages
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 13, 2021 at 9:09 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Currently ptr_is_aligned() takes size, and not alignment, as a
> parameter, which may be overly pessimistic e.g. for __i128 on s390,
> which must be only 8-byte aligned. Fix by using btf__align_of() where
> possible - one notable exception is ptr_sz, for which there is no
> corresponding type.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/btf_dump.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 25ce60828e8d..da345520892f 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1657,9 +1657,9 @@ static int btf_dump_base_type_check_zero(struct btf_dump *d,
>         return 0;
>  }
>
> -static bool ptr_is_aligned(const void *data, int data_sz)
> +static bool ptr_is_aligned(const void *data, int alignment)
>  {
> -       return ((uintptr_t)data) % data_sz == 0;
> +       return ((uintptr_t)data) % alignment == 0;

btf__align_of() can return 0 on error and this will be div by 0. I
think the better approach would be for ptr_is_aligned to accept struct
btf *btf and __u32 type_id, call btf__align_of() based on btf and type
id, handle 0 case pessimistically (assume not aligned).

>  }
>
>  static int btf_dump_int_data(struct btf_dump *d,
> @@ -1681,7 +1681,7 @@ static int btf_dump_int_data(struct btf_dump *d,
>         /* handle packed int data - accesses of integers not aligned on
>          * int boundaries can cause problems on some platforms.
>          */
> -       if (!ptr_is_aligned(data, sz)) {
> +       if (!ptr_is_aligned(data, btf__align_of(d->btf, type_id))) {
>                 memcpy(buf, data, sz);
>                 data = buf;
>         }
> @@ -1770,7 +1770,7 @@ static int btf_dump_float_data(struct btf_dump *d,
>         int sz = t->size;
>
>         /* handle unaligned data; copy to local union */
> -       if (!ptr_is_aligned(data, sz)) {
> +       if (!ptr_is_aligned(data, btf__align_of(d->btf, type_id))) {
>                 memcpy(&fl, data, sz);
>                 flp = &fl;
>         }
> @@ -1953,10 +1953,8 @@ static int btf_dump_get_enum_value(struct btf_dump *d,
>                                    __u32 id,
>                                    __s64 *value)
>  {
> -       int sz = t->size;
> -
>         /* handle unaligned enum value */
> -       if (!ptr_is_aligned(data, sz)) {
> +       if (!ptr_is_aligned(data, btf__align_of(d->btf, id))) {
>                 __u64 val;
>                 int err;
>
> --
> 2.31.1
>
