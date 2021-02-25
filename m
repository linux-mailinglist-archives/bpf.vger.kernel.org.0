Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDD7325A0A
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 00:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBYXFt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 18:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBYXFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 18:05:49 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C569C061756
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 15:05:09 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id u3so7096166ybk.6
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 15:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lsoPF65f0J0PRto+p8SCYWC2dYpWFvb2c2vttsjN6T0=;
        b=RmfT2Agxr4Szllcfv/Lruhf34q8+BqLBPgZVCe/Nb78FK1oOHu0hriehRK6bgY7FpR
         /lqn2yuOEyYH93y6z6+9dX8DTwwe8N+VFkAyJnhlIckYs/Sralk4898008iqtMwZ77gL
         wMDy4Wk7NSIKMoCkirf08CPmf9qaQMkT41VOD2wWHMkG+IEvLTgYZL13yX6xwJ1eeQ7g
         zaSQ+Au3l7IKFRPFFieaIeU1mBOUhEPXBC/KaDf6m8cAtCYknmmrguWbQ0CZIkWngU+E
         bFpksD/6NIkBd3cu2hgFgDv1ndYsDuIhefH52rppddnDe+Gv+IvJY3U4EbzrqDs1Tz4D
         ElGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lsoPF65f0J0PRto+p8SCYWC2dYpWFvb2c2vttsjN6T0=;
        b=THD1Ly1O9V6IG+3q3sk6f/gIi45WLyobB4TtWW8F4uXkvkeN88af0L/4XpusAoTfqF
         FfO6yJHb9mgxtwY3pm3LOD/5gQcYVJl+gZFfV1NthfuVobZdSNG5RfDLjArEPhUzzlGU
         8o0KaB2ezRdmMkrxQVpmqfAr5z1+m4D2vDrK5VhvkqLfGh30rIEr6ZqGYNSnkOaGKy7K
         JfYW7xJyM1svRdkaOF2w1D9jIgHUKFH/OKYYdlci3nQspi85f0qeX1VMGjxJbr1/pJoR
         WApd/oYUJl/Ui+PPpMLoW1er65WjQTpWfQqGvi1T2Hqqtfd+XXja4YHNjAM++j4ZoT7O
         vEeA==
X-Gm-Message-State: AOAM533XzcOb7/y1h2sycqjN9G3u2MsagNwgHcZF0TXaQsn0cV6EHzEG
        97vdLt/QSeGtZDkECeC2wXMN0Y2cN3N5Popizj0=
X-Google-Smtp-Source: ABdhPJwODz+1BwqxQJ0Y8Q/cEqEKouihEI13p/cA5+mKYQmao19s3PT3HTPM3rD0F9KeXSt2hWzkDtoGLWPTgoTB/T8=
X-Received: by 2002:a25:abb2:: with SMTP id v47mr255753ybi.425.1614294308394;
 Thu, 25 Feb 2021 15:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073319.4121535-1-yhs@fb.com>
In-Reply-To: <20210225073319.4121535-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Feb 2021 15:04:57 -0800
Message-ID: <CAEf4BzZqA9pPjQVWcWuSV4_a0EUjxkfKMPg4qw-orTVCwSCy=w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/11] bpftool: print subprog address properly
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>
> With later hashmap example, using bpftool xlated output may
> look like:
>   int dump_task(struct bpf_iter__task * ctx):
>   ; struct task_struct *task = ctx->task;
>      0: (79) r2 = *(u64 *)(r1 +8)
>   ; if (task == (void *)0 || called > 0)
>   ...
>     19: (18) r2 = subprog[+17]
>     30: (18) r2 = subprog[+25]
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
>     83: (18) r2 = subprog[-47]
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/bpf/bpftool/xlated_dumper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
> index 8608cd68cdd0..6fc3e6f7f40c 100644
> --- a/tools/bpf/bpftool/xlated_dumper.c
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -196,6 +196,9 @@ static const char *print_imm(void *private_data,
>         else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE)
>                 snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>                          "map[id:%u][0]+%u", insn->imm, (insn + 1)->imm);
> +       else if (insn->src_reg == BPF_PSEUDO_FUNC)
> +               snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
> +                        "subprog[%+d]", insn->imm);
>         else
>                 snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>                          "0x%llx", (unsigned long long)full_imm);
> --
> 2.24.1
>
