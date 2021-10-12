Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BBC429C1D
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 05:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhJLDy6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 23:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhJLDy6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 23:54:58 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE99C061570
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 20:52:57 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id q189so43699220ybq.1
        for <bpf@vger.kernel.org>; Mon, 11 Oct 2021 20:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zcbg/YVb6HX4+6fXVcl/rcnlP8ZMpZduXrX31SOHPLw=;
        b=XYv3pHoZOYEjsptOAD8N+hgBDkPL6JBA1iaopev2bx4Qfx9pSX57rCY/J4QyHZ1aTc
         n2mDkw7vxKYit/X1EwutlC+Ghx0rJLCegUInDELKkMmSNB4Ebqo1ErwJfj7tIysCFnQr
         RF6zuz6Sy4UNQbcjzE4tmfViDuTRhguzKBoF3JN49HfSJ3RCrweEsAyyDFScHbrm28h+
         6F1j1P20Sn7W8wnHNM0EjyflVqKknMJRQ39TuCmNarBjkqWU/QxSqZN8mRuqsVA/lguU
         kcjelR9WdeMXJU1b9mZIYEYxgDhJUyJSMk00ohfuQ6p+xkrb3XMtlwM+E8HG/A9yHXAG
         Tdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zcbg/YVb6HX4+6fXVcl/rcnlP8ZMpZduXrX31SOHPLw=;
        b=fD0e8lGYTVvK4V+d9gxuLJKB+TwpoKdSG1csxSuytGnf0YCzz61CaD4PxKczWE5MvZ
         Kp2185K9HRcp3o4lww1yZE4bAYlS/c1ZHA9MYTHu40Qqs4BiaNJNuj3OIPrNNNGCJd9d
         mPUFGLUFFaRu9X86Av3uhsujTetMrZEPcEKoqgVpiss9vMarQX07iAMOrMfTrEsr/8vh
         d0WlSY7gWxSeYfHMbRR5gmGljrebhngNFiscNiDRY7Nv9tgxH4gu7//uIuyPbyYrYScK
         i6jPZmVquY0h08z9GjieQjNCeBa3+AToja2apdYFmqAX1Z5LFWuv0la7PJ9pZNaTWPHZ
         uQLw==
X-Gm-Message-State: AOAM533KLStiAuAuLKgzPASyXlbsSUiJ4oVjPI7JzDlZw5LIGgYO6QKL
        Om/8A4tz4QH8WvOO4epFPRwUIsVbpPbVs4DupWM=
X-Google-Smtp-Source: ABdhPJxaycKHoqAi9roXh0onjSx7f9CaepV532nlfpUzK5IJsGSFM+A1yywwm6YLTbZBxCIo6VPGZU28gvEMx40n7ns=
X-Received: by 2002:a5b:887:: with SMTP id e7mr5038888ybq.114.1634010776690;
 Mon, 11 Oct 2021 20:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211012023218.399568-1-iii@linux.ibm.com> <20211012023218.399568-4-iii@linux.ibm.com>
In-Reply-To: <20211012023218.399568-4-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Oct 2021 05:52:45 +0200
Message-ID: <CAEf4BzYzgSZELHujELqggGPyDFPCN4nM6OwGLzyy8O5mJAcXJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] libbpf: Fix dumping __int128
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 12, 2021 at 4:32 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On s390 __int128 can be 8-byte aligned, therefore in libbpf will
> occasionally consider variables of this type non-aligned and try to
> dump them as a bitfield, which is supported for at most 64-bit
> integers.
>
> Fix by using the same trick as btf_dump_float_data(): copy non-aligned
> values to the local buffer.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/btf_dump.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index ab45771d0cb4..d8264c1762e8 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1672,9 +1672,10 @@ static int btf_dump_int_data(struct btf_dump *d,
>  {
>         __u8 encoding = btf_int_encoding(t);
>         bool sign = encoding & BTF_INT_SIGNED;
> +       char buf[16] __aligned(16);
>         int sz = t->size;
>
> -       if (sz == 0) {
> +       if (sz == 0 || sz > sizeof(buf)) {
>                 pr_warn("unexpected size %d for id [%u]\n", sz, type_id);
>                 return -EINVAL;
>         }
> @@ -1682,8 +1683,10 @@ static int btf_dump_int_data(struct btf_dump *d,
>         /* handle packed int data - accesses of integers not aligned on
>          * int boundaries can cause problems on some platforms.
>          */
> -       if (!ptr_is_aligned(data, sz))
> -               return btf_dump_bitfield_data(d, t, data, 0, 0);
> +       if (!ptr_is_aligned(data, sz)) {

I think ptr_is_aligned() logic is wrong. We should probably not assume
that __int128 has 16-byte alignment. Can you try fixing it by using
btf__align_of() API to get the natural alignment?

> +               memcpy(buf, data, sz);
> +               data = buf;
> +       }
>
>         switch (sz) {
>         case 16: {
> --
> 2.31.1
>
