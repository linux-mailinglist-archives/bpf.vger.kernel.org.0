Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464F23DB27B
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 06:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhG3Etz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 00:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhG3Etz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 00:49:55 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A06C061765
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 21:49:49 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id m193so13882698ybf.9
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 21:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/KHDu+tFdFdo0e1WFShh7fuIZzrebf90uCllirMxlY=;
        b=pFARe3fT6yVJ1uvS0I8XiR7WAzJ3x4X7iqUfSDPjeOEEjYCilnGPTgoEz+DOHUvsji
         SBHQQKmAg0wxd9v5xvuQz2iAhI/G4fF9hBG1tinWXn+x19DlzwIyQYFaW5joGWtEUrLI
         5fy9L/t6jj5Z+EJV7niDNgcb9wVDulWbjdk7UwDa0mlcY8zC/uQwXkDriFwVDrCGeEYv
         Kt/2OY/NUCxd8tSFZtYyibHPa1qHbsH8n+t/lZI1vc1z4d4CmU+y2NDsFlchjxse7sdO
         sOzq8VxfggZfJn9P6p9Bvh5kXo+6iWW9JrpRjGDWJwasjh3zOc/I17ZnobBO8omjhNQK
         VsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/KHDu+tFdFdo0e1WFShh7fuIZzrebf90uCllirMxlY=;
        b=ATm/iIgKpRYY+Yr3D3I7duVoBGi+iwjULPqCg3K1i9p6e9jqM7HSSvP7rAoC3gpLMB
         HAitQdXLN1SjDaZaY02GzVkzZQwVqCwz4Q8gc1JU+9XEghrK83wz6bViUIRq/ZUl0XPm
         hOcmkVqaugbcSCyyJcKC5h2KN1r031RzBDtZFl74WcYlxca9aUTaDoia0FZ/XkHY/RF9
         jPdR7Eq/dYKQvJhbmCn1RjznLgnHZ/1qfeZ3rm1Mux8iKA/Qf9ZN9jniTBikfYOPMU13
         8OHy72i7YMCwSwZNv/S8vJv18pP+v2QSEUEWzY/RyFX7qEfaUU4xIhI0z9/DxQAULLUG
         YWtQ==
X-Gm-Message-State: AOAM5330E3lHnQhzUo8h7EW3HuU2/AS6lRA3PL8K6WTj157jl4wZkisP
        JaBDgz5V2nu66hTTu5bA2oRAN9ohclfx5FL+Tig=
X-Google-Smtp-Source: ABdhPJxfMCPfg+aqMX4wcasm2wuOUjC3JVYEHgXWQtGwCDg6/okLWwWVgt2VcTr8KFguGc+S0mXHaJu+7fJSzaTs1i8=
X-Received: by 2002:a25:2901:: with SMTP id p1mr733720ybp.459.1627620589243;
 Thu, 29 Jul 2021 21:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210726161211.925206-1-andrii@kernel.org> <20210726161211.925206-7-andrii@kernel.org>
 <ca7119de-3bb5-7a68-4005-4485ec151bb9@fb.com>
In-Reply-To: <ca7119de-3bb5-7a68-4005-4485ec151bb9@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 29 Jul 2021 21:49:38 -0700
Message-ID: <CAEf4BzY2fVJN5CEdWDDNkWQ9En4N6Rynnnzj7hTnWG65BqdusQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 06/14] bpf: add bpf_get_user_ctx() BPF helper
 to access user_ctx value
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 29, 2021 at 11:17 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 7/26/21 9:12 AM, Andrii Nakryiko wrote:
> > Add new BPF helper, bpf_get_user_ctx(), which can be used by BPF programs to
> > get access to the user_ctx value, specified during BPF program attachment (BPF
> > link creation) time.
> >
> > Currently all perf_event-backed BPF program types support bpf_get_user_ctx()
> > helper. Follow-up patches will add support for fentry/fexit programs as well.
> >
> > While at it, mark bpf_tracing_func_proto() as static to make it obvious that
> > it's only used from within the kernel/trace/bpf_trace.c.
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   include/linux/bpf.h            |  3 ---
> >   include/uapi/linux/bpf.h       | 16 ++++++++++++++++
> >   kernel/trace/bpf_trace.c       | 35 +++++++++++++++++++++++++++++++++-
> >   tools/include/uapi/linux/bpf.h | 16 ++++++++++++++++
> >   4 files changed, 66 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 74b35faf0b73..94ebedc1e13a 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2110,9 +2110,6 @@ extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
> >   extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
> >   extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
> >
> > -const struct bpf_func_proto *bpf_tracing_func_proto(
> > -     enum bpf_func_id func_id, const struct bpf_prog *prog);
> > -
> >   const struct bpf_func_proto *tracing_prog_func_proto(
> >     enum bpf_func_id func_id, const struct bpf_prog *prog);
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index bc1fd54a8f58..96afeced3467 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -4856,6 +4856,21 @@ union bpf_attr {
> >    *          Get address of the traced function (for tracing and kprobe programs).
> >    *  Return
> >    *          Address of the traced function.
> > + *
> > + * u64 bpf_get_user_ctx(void *ctx)
> > + *   Description
> > + *           Get user_ctx value provided (optionally) during the program
> > + *           attachment. It might be different for each individual
> > + *           attachment, even if BPF program itself is the same.
> > + *           Expects BPF program context *ctx* as a first argument.
> > + *
> > + *           Supported for the following program types:
> > + *                   - kprobe/uprobe;
> > + *                   - tracepoint;
> > + *                   - perf_event.
>
> I think it is possible in the future we may need to support more
> program types with user_ctx, not just u64 but more than 64bit value.
> Should we may make this helper extensible like
>      long bpf_get_user_ctx(void *ctx, void *user_ctx, u32 user_ctx_len)
>
> The return value will 0 to be good and a negative indicating an error.
> What do you think?

I explicitly wanted to keep this user_ctx/bpf_cookie to a small fixed
size. __u64 is perfect because it's small enough to not require
dynamic memory allocation, but big enough to store any kind of index
into an array *or* user-space pointer. So if user needs more storage
than 8 bytes, they will be able to have a bigger array where
user_ctx/bpf_cookie is just an integer index or some sort of key into
hashmap, whichever is more convenient.

So I'd like to keep it lean and simple. It is already powerful enough
to support any scenario, IMO.

>
> > + *   Return
> > + *           Value specified by user at BPF link creation/attachment time
> > + *           or 0, if it was not specified.
> >    */
> >   #define __BPF_FUNC_MAPPER(FN)               \
> >       FN(unspec),                     \
> > @@ -5032,6 +5047,7 @@ union bpf_attr {
> >       FN(timer_start),                \
> >       FN(timer_cancel),               \
> >       FN(get_func_ip),                \
> > +     FN(get_user_ctx),               \
> >       /* */
> >
> >   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index c9cf6a0d0fb3..b14978b3f6fb 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -975,7 +975,34 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_kprobe = {
> >       .arg1_type      = ARG_PTR_TO_CTX,
> >   };
> >
> > -const struct bpf_func_proto *
> > +BPF_CALL_1(bpf_get_user_ctx_trace, void *, ctx)
> > +{
> > +     struct bpf_trace_run_ctx *run_ctx;
> > +
> > +     run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
> > +     return run_ctx->user_ctx;
> > +}
> > +
> > +static const struct bpf_func_proto bpf_get_user_ctx_proto_trace = {
> > +     .func           = bpf_get_user_ctx_trace,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_PTR_TO_CTX,
> > +};
> > +
> [...]
