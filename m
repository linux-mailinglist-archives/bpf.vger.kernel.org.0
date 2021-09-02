Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C0F3FF76C
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 00:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348946AbhIBWz2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Sep 2021 18:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348526AbhIBWyb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Sep 2021 18:54:31 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC40BC061575;
        Thu,  2 Sep 2021 15:53:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id a93so6850136ybi.1;
        Thu, 02 Sep 2021 15:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkN5TNB/RrUPxS3oGH9hsOFgveMfRt3tup9G6sQBl4A=;
        b=Fk+6Et1cXuf5QLiY1KbCB35TBJYRkkKpa4ZkIO8ftoR8YyqBQl6X7Zd9LOOT2p+sFm
         mW6UF7TRboUjxGclc/JzDosCwJDd4Xlm+V6IDqDljBKEX+77V8CjIgCJD0p+chbO1FyQ
         L95KX5CRjpJDKBjMu9aoIn6191daUsvECPtezqgg1C4EOqSADhpbkqf41SiTbPolICr4
         7lSlwgi49RwGT+IxRfps3XhsiAcxilkOFr1X/bQl3CyIf7pxW7q8sxU5ptOCNe5RNksQ
         GIIbO9kZmOQ/r9Uag9BX8i4ec5i6kqJhN2wis7mlQNXLJXjVBXheS3rdQg3wc6W6Ead7
         P9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkN5TNB/RrUPxS3oGH9hsOFgveMfRt3tup9G6sQBl4A=;
        b=k3G/OCvEVcefXmooK/X6dVxz927+C1A2w0fIHznAeAc9FrrdjWDWRRy6MEgsvL3Con
         EwSbbs2T+kG1pofNIgi95iYyVheSLilxg/yB+nQKh5RD4xrvi19qx+U1/bWHVB3E64yX
         rXYk3lXpXDKW2l4Z+BR4jKMGAAxsXlNf3bcpriPjm5riKdgXjof4cm35IUS+gdzJICoq
         KQ73RurN31AwmjTIMotXXJS+kW+21uS+L9ruG5tb/5YV4KVHWclmZLwWqY4dsuFQlvJf
         TpTK5jZf08aw4WGVjeSkD9ADC0TQBAHp/YhcACiG07C3apHMl7XmrDpszZH6wL0jJQIa
         vCkA==
X-Gm-Message-State: AOAM531WnNLciuSwPP/aDHixXtklEP8f0svLMa9NcI/GQwO+cOL6TJPz
        3vCbFWPCN0xiQANEpU03Hz/mXTl2oLDFNrz3hC8=
X-Google-Smtp-Source: ABdhPJzbkJP3+kY3OlcOu1d13sx/NNf3F4qlhjY7sH5G+nHB6ztvepCnHffpAYOUYrKbvoxrJkGmT1yK+smFeT0o1hE=
X-Received: by 2002:a25:4941:: with SMTP id w62mr1046684yba.230.1630623211143;
 Thu, 02 Sep 2021 15:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210902165706.2812867-1-songliubraving@fb.com> <20210902165706.2812867-3-songliubraving@fb.com>
In-Reply-To: <20210902165706.2812867-3-songliubraving@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Sep 2021 15:53:20 -0700
Message-ID: <CAEf4BzZLSs3ejyVLPMORd_GPCYNE8Jz4M6=4wxzR576Vag-+-A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: introduce helper bpf_get_branch_snapshot
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 2, 2021 at 9:58 AM Song Liu <songliubraving@fb.com> wrote:
>
> Introduce bpf_get_branch_snapshot(), which allows tracing pogram to get
> branch trace from hardware (e.g. Intel LBR). To use the feature, the
> user need to create perf_event with proper branch_record filtering
> on each cpu, and then calls bpf_get_branch_snapshot in the bpf function.
> On Intel CPUs, VLBR event (raw event 0x1b00) can be use for this.
>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  include/uapi/linux/bpf.h       | 22 ++++++++++++++++++++++
>  kernel/bpf/trampoline.c        |  3 ++-
>  kernel/trace/bpf_trace.c       | 33 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 22 ++++++++++++++++++++++
>  4 files changed, 79 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 791f31dd0abee..c986e6fad5bc0 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4877,6 +4877,27 @@ union bpf_attr {
>   *             Get the struct pt_regs associated with **task**.
>   *     Return
>   *             A pointer to struct pt_regs.
> + *
> + * long bpf_get_branch_snapshot(void *entries, u32 size, u64 flags)
> + *     Description
> + *             Get branch trace from hardware engines like Intel LBR. The
> + *             branch trace is taken soon after the trigger point of the
> + *             BPF program, so it may contain some entries after the

This part is a leftover from previous design, so not relevant anymore?

> + *             trigger point. The user need to filter these entries
> + *             accordingly.
> + *
> + *             The data is stored as struct perf_branch_entry into output
> + *             buffer *entries*. *size* is the size of *entries* in bytes.
> + *             *flags* is reserved for now and must be zero.
> + *
> + *     Return
> + *             On success, number of bytes written to *buf*. On error, a
> + *             negative value.
> + *
> + *             **-EINVAL** if arguments invalid or **size** not a multiple
> + *             of **sizeof**\ (**struct perf_branch_entry**\ ).
> + *
> + *             **-ENOENT** if architecture does not support branch records.

[...]
