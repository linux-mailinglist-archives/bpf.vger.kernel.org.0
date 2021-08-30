Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF323FBEE1
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 00:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbhH3WQB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 18:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhH3WQB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Aug 2021 18:16:01 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49364C061575;
        Mon, 30 Aug 2021 15:15:07 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v19so17566484ybv.9;
        Mon, 30 Aug 2021 15:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFNvsjqGoOUvaOP1kexRv4qguktfVomTKA5112VDpAo=;
        b=scQdVfYcAQVStZ2ycSE8XcE2y7omukO6oSDVj4IPGbtpT9EUIKlzs3u02kHT0Oy7+x
         9IIFUlIZvMVbfjtkvFUxdTo9+uH2nK/ulqykXYC7dKosPhn1Ar/lpVo8a0cvUk8C0RzJ
         p39BNZaxq9DzAgVUcmy4UPjL3SCxE0gdv+DJTT3aU8nR6gq0vS1M1vH314P05CTm10UC
         GVFbaSLD1Du44opiIj0EzfqXfCEOl/VcoG6PD9EHgSb+pdVt/GsQUeijXSbFzJgnGWtZ
         Kl+d8zXAXl4utwtas0b44QOin8fF41poWXIQxFUI8jniwNAUN6lGfb+aLh3suHhsy1W8
         Mmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFNvsjqGoOUvaOP1kexRv4qguktfVomTKA5112VDpAo=;
        b=WiTG4OqjjB/2U1umr9qS6ZuaZYVKcXprIaIVaL/GBqAWRRnnHhoxDYnFtlHtlBn/ta
         EH0smXtGZALW4dj0S1aU7lWaS1BXaIHr360I0cC3O4yMobLOi+Axi4V9598Y/5Ic3cv7
         FfeZKRcCoVo6ae7OnWD709KCRiU8g82U1RgsvSsirp8UkXrE/czerdIxpvOx7bKC4Gj8
         cP+sz8zXPH7RO57cAcuCcC1hrIGfLvPNu8NSgT8C3mWU6yQj62suJ3aFGTXGfDSUozv8
         Yf6pjpB3whSTL3SYe2ykCmqK8jZ5T3d26rEhKUCPPZaC+EJw1Qc9fnLSvuLqWbcUtTT1
         dePQ==
X-Gm-Message-State: AOAM531tBUc2Xnyz24qR6Sa2tXHvo41Lj9IVTV7rQpIXI7ZSrr7v5opr
        mT8B2JErCqDDbr52h001zNOGlAO0bWGwf1rnJQI=
X-Google-Smtp-Source: ABdhPJwaK0wRRyCPCTu5uynUif+6ia5s49XOmqYd+bu4Elir7aULt+9D2ZS3upSizmpPFWB6TaXmo5+cHbita0YLfbc=
X-Received: by 2002:a25:16c6:: with SMTP id 189mr26345337ybw.27.1630361706519;
 Mon, 30 Aug 2021 15:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210830214106.4142056-1-songliubraving@fb.com> <20210830214106.4142056-3-songliubraving@fb.com>
In-Reply-To: <20210830214106.4142056-3-songliubraving@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 30 Aug 2021 15:14:55 -0700
Message-ID: <CAEf4BzYuUTndYGb7-4q9=8s4PQUbTK+VHy=u9vOBqabZ08Yy-w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: introduce helper bpf_get_branch_snapshot
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

On Mon, Aug 30, 2021 at 2:42 PM Song Liu <songliubraving@fb.com> wrote:
>
> Introduce bpf_get_branch_snapshot(), which allows tracing pogram to get
> branch trace from hardware (e.g. Intel LBR). To use the feature, the
> user need to create perf_event with proper branch_record filtering
> on each cpu, and then calls bpf_get_branch_snapshot in the bpf function.
> On Intel CPUs, VLBR event (raw event 0x1b00) can be use for this.
>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  include/linux/bpf.h            |  2 ++
>  include/linux/filter.h         |  3 ++-
>  include/uapi/linux/bpf.h       | 16 +++++++++++++
>  kernel/bpf/trampoline.c        | 13 ++++++++++
>  kernel/bpf/verifier.c          | 12 ++++++++++
>  kernel/trace/bpf_trace.c       | 43 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 16 +++++++++++++
>  7 files changed, 104 insertions(+), 1 deletion(-)
>

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 206c221453cfa..72e8b49da0bf9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6446,6 +6446,18 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 env->prog->call_get_func_ip = true;
>         }
>
> +       if (func_id == BPF_FUNC_get_branch_snapshot) {
> +               if (env->prog->aux->sleepable) {
> +                       verbose(env, "sleepable progs cannot call get_branch_snapshot\n");
> +                       return -ENOTSUPP;
> +               }
> +               if (!IS_ENABLED(CONFIG_PERF_EVENTS)) {
> +                       verbose(env, "func %s#%d not supported without CONFIG_PERF_EVENTS\n",
> +                               func_id_name(func_id), func_id);
> +                       return -ENOTSUPP;
> +               }
> +               env->prog->call_get_branch = true;
> +       }
>         if (changes_data)
>                 clear_all_pkt_pointers(env);
>         return 0;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 8e2eb950aa829..a01f26b7877e6 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1017,6 +1017,33 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_pe = {
>         .arg1_type      = ARG_PTR_TO_CTX,
>  };
>
> +BPF_CALL_2(bpf_get_branch_snapshot, void *, buf, u32, size)

I bet we'll need u64 flags over time, let's add it right now. It's
similar to bpf_read_branch_records().

> +{
> +#ifdef CONFIG_PERF_EVENTS
> +       u32 max_size;
> +
> +       if (this_cpu_ptr(&bpf_perf_branch_snapshot)->nr == 0)
> +               return -EOPNOTSUPP;
> +
> +       max_size = this_cpu_ptr(&bpf_perf_branch_snapshot)->nr *
> +               sizeof(struct perf_branch_entry);
> +       memcpy(buf, this_cpu_ptr(&bpf_perf_branch_snapshot)->entries,
> +              min_t(u32, size, max_size));
> +

Check bpf_read_branch_records() implementation and it's argument
validation logic. Let's keep them consistent (e.g., it enforces that
size is a multiple of sizeof(struct perf_branch_entry)). Another
difference is that bpf_read_branch_records() returns number of bytes
filled, not number of records. That's consistent with accepting size
as number of bytes. Let's stick to this convention then, so bytes
everywhere.


> +       return this_cpu_ptr(&bpf_perf_branch_snapshot)->nr;
> +#else
> +       return -EOPNOTSUPP;
> +#endif
> +}
> +
> +static const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
> +       .func           = bpf_get_branch_snapshot,
> +       .gpl_only       = true,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_UNINIT_MEM,
> +       .arg2_type      = ARG_CONST_SIZE_OR_ZERO,
> +};
> +

[...]
