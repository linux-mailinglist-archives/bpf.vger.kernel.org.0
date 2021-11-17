Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C327453D31
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 01:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhKQAl1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 19:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhKQAl1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 19:41:27 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED88BC061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 16:38:29 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g17so1928347ybe.13
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 16:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WJslWGg9hL/o7KyGrxV4fcRc1YINsfDYybDnX/nUD8=;
        b=F2N+qaoSj0jWF8eC+rbu+0shDPz34nZldigIi9aI+vxTnWIX00qQjfZZhHMW2jGAnY
         Oe7VmrnfaFLzJzm/2rucBrj8L3JplBE4OrVUSmLyc7w3o58IQ9+rnopN2CJS9V+zLysk
         lI8NjVlCZWRxu3wAwLUYVC+fiM7TAlVS0N8EYinXZ7SgROIag5X3+EqjaLNa4HoWr0NN
         zxHLpYBezeKlb8DEVlNuJzZtuVbNnYGSFFqQiwc6dNVGchEs/u6AL1tDU/qpfDVmQ2oL
         4+iKaC0dzkFc8rPcPN5DvcjHyvhvPQy6RJCYAWQPmZu/bAEeGo5JfEGoTAMxeHNKGuCK
         Piog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WJslWGg9hL/o7KyGrxV4fcRc1YINsfDYybDnX/nUD8=;
        b=Kp+tLgy8gAGAevEUC3gDNv9IVcsbgR2Z0+I5mvrlbQzOz7TP/R0bTXFapEFI9A2/NO
         tiEN9gD3lqbjj5/4VkOGFjqaCziNldgnjWb2nPBOyOeWjodzIeWx2O37K4W8XGXMfZN6
         KeEjiFi9LOQT3m/jGTkHXGAvdFJLmGfR3EiU91uzF/8PVC3HyHHVmEygRWP2PtlCss4b
         LFbH8pr50yUoBFKfarROGi+FNkd433s35ieT1JTMLPhUQdrM3qrOlGmDfI9zRpY97vsd
         1c3twravBy49q6CyPB1FWRu2rab2PxYWmHr9ow711x436vnrVkGbYWb3WmoVUdScCgiN
         2ihg==
X-Gm-Message-State: AOAM533szf6LNMxFPW9K7nJfue5BLw+4q2yNYiLUy4aQJ9V6jQiDW2J8
        ajGUPmkg2Fkn1ySaFuVlMuilIK1fGaA7Lpq7mHk=
X-Google-Smtp-Source: ABdhPJyrVeIzXkmcuh956RlMnnABWXsevxF9bgKmlZfbVxHekZw0QwTSBtB5jAA0UItxW++/N9XlF3mEu0VmSkq1LEM=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr12132517ybj.433.1637109509009;
 Tue, 16 Nov 2021 16:38:29 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com> <20211112050230.85640-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20211112050230.85640-3-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 16:38:18 -0800
Message-ID: <CAEf4BzYjvg+iqs8wB9bMYWJ-BAH6s4iM89vvB9ZywjHKQBJg8g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/12] bpf: Rename btf_member accessors.
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
> Rename btf_member_bit_offset() and btf_member_bitfield_size() to
> avoid conflicts with similarly named helpers in libbpf's btf.h.
> Rename the kernel helpers, since libbpf helpers are part of uapi.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

See below, I'd get rid of those "almost duplicates" instead, but up to
you, I'm fine either way.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/btf.h         |  8 ++++----
>  kernel/bpf/bpf_struct_ops.c |  6 +++---
>  kernel/bpf/btf.c            | 18 +++++++++---------
>  net/ipv4/bpf_tcp_ca.c       |  6 +++---
>  4 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 203eef993d76..956f70388f69 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -194,15 +194,15 @@ static inline bool btf_type_kflag(const struct btf_type *t)
>         return BTF_INFO_KFLAG(t->info);
>  }
>
> -static inline u32 btf_member_bit_offset(const struct btf_type *struct_type,
> -                                       const struct btf_member *member)
> +static inline u32 __btf_member_bit_offset(const struct btf_type *struct_type,
> +                                         const struct btf_member *member)

a bit surprised you didn't choose to just remove them, given you had
to touch all 24 places in the kernel that call this helper

>  {
>         return btf_type_kflag(struct_type) ? BTF_MEMBER_BIT_OFFSET(member->offset)
>                                            : member->offset;
>  }
>
> -static inline u32 btf_member_bitfield_size(const struct btf_type *struct_type,
> -                                          const struct btf_member *member)
> +static inline u32 __btf_member_bitfield_size(const struct btf_type *struct_type,
> +                                            const struct btf_member *member)
>  {
>         return btf_type_kflag(struct_type) ? BTF_MEMBER_BITFIELD_SIZE(member->offset)
>                                            : 0;
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 8ecfe4752769..21069dbe9138 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -165,7 +165,7 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
>                                 break;
>                         }
>
> -                       if (btf_member_bitfield_size(t, member)) {
> +                       if (__btf_member_bitfield_size(t, member)) {

like in this case it would be btf_member_bitfield_size(t, j)


>                                 pr_warn("bit field member %s in struct %s is not supported\n",
>                                         mname, st_ops->name);
>                                 break;
> @@ -296,7 +296,7 @@ static int check_zero_holes(const struct btf_type *t, void *data)
>         const struct btf_type *mtype;
>
>         for_each_member(i, t, member) {
> -               moff = btf_member_bit_offset(t, member) / 8;
> +               moff = __btf_member_bit_offset(t, member) / 8;

same here, seema like in all the cases we already have member_idx (i
in this case)

>                 if (moff > prev_mend &&
>                     memchr_inv(data + prev_mend, 0, moff - prev_mend))
>                         return -EINVAL;

[...]
