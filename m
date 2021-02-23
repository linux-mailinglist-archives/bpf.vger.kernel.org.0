Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D463226E5
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 09:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhBWIIu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 03:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhBWIHb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 03:07:31 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688B3C061574
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 00:06:30 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id p186so15650635ybg.2
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 00:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PhERrfave73MMXElRyvvcyyNWzbnb0TAR9mcE86jVME=;
        b=OZaJ4+gqAWyygj/3n4naAfQaRWbqC/4Y7d5WFequXMmeZooRKpoVtMiCz0gS2KwPaa
         jKbwSt/f/QAfDzpkfLJ7Z5NCkpwG3ieuAXehJ4bHUW5vRy/5X5FZBse2xTIa0ck74uPl
         SJrrP9Q+9lzNY9u1fcVv00iDDAFqDzbPF2uJmCf3g5GqRj4s9Wjw2p+jQwOQBs7Hyn3p
         7NVw5n3i3+ieL+a6IdVw8XgelOMIUVnFqIVK7vIwHNrG2uf9q2irOf/LpyPNHM3qVygx
         jf/ID/3aQfsL1XdwnbrABl2UDmw1rmuHKeU0YENFyW5YqFdHv81C9zd2vyv84IYZH/Bt
         ZtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhERrfave73MMXElRyvvcyyNWzbnb0TAR9mcE86jVME=;
        b=D4wuv6DagjLOr6gWqJ46ZfzAWlTPIZDgoyj5iIy4tOb3o8oDXLyq+XODNLAjtdPElS
         16iPkWJTb3BMTsurqXNi3sEIi/QwNe2RnUyd5A4IdsgbDhPCHLZYhTAnfeL1uTRqSe4b
         N0OTU8gOBxB0rKdcuAb8aMqpFAHjBPsaNGyBKGLusVw4pIoBajyfCJoo7tKFAQPNiqX9
         n2Rg9mygmU+1pNszrz0WqqrGkFVtg6f0eb72wAZy9cRDufDE7mnW329fV/Jbm0UhEfp1
         2Xs+uRjt11fuqikCVRTwVCKCyV29wqmMEMn1iD03aI6NQubQG4K7/hYWrfaOxE1SvXrN
         Izmg==
X-Gm-Message-State: AOAM530sUJtWvp+yhSTK1iwnUIUgw9nXw9egQZudpVXft0sZszZt6q2g
        k1UNynnoyvnJnsmXjPtACiYWgwwcbb5QFY2qGQ0=
X-Google-Smtp-Source: ABdhPJzaAUAHZcqtwT85WUSm/pNf0Qf5SkQAMWIztM76xavps9+8STGp7SxKf+W2s0etuXqT7jf/LKy/64wAC9M81Io=
X-Received: by 2002:a25:abb2:: with SMTP id v47mr37819266ybi.425.1614067589775;
 Tue, 23 Feb 2021 00:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20210217181803.3189437-1-yhs@fb.com> <20210217181813.3191699-1-yhs@fb.com>
In-Reply-To: <20210217181813.3191699-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Feb 2021 00:06:19 -0800
Message-ID: <CAEf4BzYgtusa_e3ULwgh4ZCsVRqpVRXi-rnmPrxWyk0WoFt_8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/11] bpftool: print local function pointer properly
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 17, 2021 at 12:56 PM Yonghong Song <yhs@fb.com> wrote:
>
> With later hashmap example, using bpftool xlated output may
> look like:
>   int dump_task(struct bpf_iter__task * ctx):
>   ; struct task_struct *task = ctx->task;
>      0: (79) r2 = *(u64 *)(r1 +8)
>   ; if (task == (void *)0 || called > 0)
>   ...
>     19: (18) r2 = subprog[+18]
>     30: (18) r2 = subprog[+26]
>   ...
>   36: (95) exit
>   __u64 check_hash_elem(struct bpf_map * map, __u32 * key, __u64 * val,
>                         struct callback_ctx * data):
>   ; struct bpf_iter__task *ctx = data->ctx;
>     37: (79) r5 = *(u64 *)(r4 +0)
>   ...
>     55: (95) exit
>   __u64 check_percpu_elem(struct bpf_map * map, __u32 * key,
>                           __u64 * val, void * unused):
>   ; check_percpu_elem(struct bpf_map *map, __u32 *key, __u64 *val, void *unused)
>     56: (bf) r6 = r3
>   ...
>     83: (18) r2 = subprog[-46]
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/bpf/bpftool/xlated_dumper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index 8608cd68cdd0..b87caae2e7da 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -196,6 +196,9 @@ static const char *print_imm(void *private_data,
>         else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE)
>                 snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>                          "map[id:%u][0]+%u", insn->imm, (insn + 1)->imm);
> +       else if (insn->src_reg == BPF_PSEUDO_FUNC)
> +               snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> +                        "subprog[%+d]", insn->imm + 1);

print_call_pcrel() doesn't do +1 adjustment, why is it needed here?

>         else
>                 snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>                          "0x%llx", (unsigned long long)full_imm);
> --
> 2.24.1
>
