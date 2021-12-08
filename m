Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0B546CBBF
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 04:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbhLHDxH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 22:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhLHDxH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 22:53:07 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC833C061574
        for <bpf@vger.kernel.org>; Tue,  7 Dec 2021 19:49:35 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id f20so1186064qtb.4
        for <bpf@vger.kernel.org>; Tue, 07 Dec 2021 19:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5AD5l9tb3ufR+kmzSv1qXGXsUrYO3IlphohBoda0s0=;
        b=lo+WxW55URwdkDydZPN28eajkd1l71LzHWYEd4hziGeGTpmnBmeAR0Nx1TupRYwdxu
         fniJnArGT3GbGcR5MhlzKjGYslQ0+ig9KPWAEpihLhPh6R8Y5Y6b3Bg0Qdqudp6zO7uI
         8vi1qNAS5X94f6aPxCKFDQZ6vo+H9kL68oTz2ilVrnPl/A3QljWFsEMnkiXM31KibGId
         29mrUjxvZZ/pCWw1VJtNIozNIicgRfmGdSNEXtHLFOmbVw5+rMTH9eBdsUSqYHZVCm/V
         Sk1m7NrSlyzxjliNQCeqka/fccpzbukJwP9oJFUZ2fuyi2hRVSDq9+BITG0eAtt6QXRy
         nWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5AD5l9tb3ufR+kmzSv1qXGXsUrYO3IlphohBoda0s0=;
        b=WZR6euzTD45KfpEIYnMRFTpS8i0s0LZMjuGmZgIO8rdz1J2vtSqIj+V34RrNF2LRCA
         qaamq0TkwYYE3Bu429NIbIfzuNLuItTg9jNgczlMsZRhRUYbsw98x81ABcu0WULut0Bd
         wAV1PjJcxXljAIpULaAJreBmgRKnYO1xA4viHlPwT66K6Rqil//+8/2MEg3KB8OPVlks
         +4I7dS27uKSCDTeW6e+WxskRJBN+GQfsY/iLwrtmBAhlH4+im7Il7SVLZUVKr9bsi+iV
         sYMSn6UqLA8AEBcMAZb1WRhhNLOPZUnUNYwEuz8S+uR3TcbkSKL2AlfOhtMQkPynrVcg
         EQWA==
X-Gm-Message-State: AOAM533aYF15wHL37cJIfoi3lmkSB3ZEqCUpPOp2ipFU1yjxfH5tY+ap
        A+VXysV/O2ycj1dhxgnTCP0eelobMnrrH/b9PZpO9Q==
X-Google-Smtp-Source: ABdhPJzGN8xjGJeiVhq2ZP3r5ajYk6l8ZXugYriMu68KCW8Z4Nd29EQUPURyn4xDZFJgirK6CJjuI4Z8p5KQjLlh5Pg=
X-Received: by 2002:a05:622a:108:: with SMTP id u8mr4382827qtw.333.1638935374978;
 Tue, 07 Dec 2021 19:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-9-haoluo@google.com>
 <CAEf4Bzb3nyWbS4=e7M8Am5BvMSPbMhMzXPKvd3spk+D9vZg99g@mail.gmail.com>
In-Reply-To: <CAEf4Bzb3nyWbS4=e7M8Am5BvMSPbMhMzXPKvd3spk+D9vZg99g@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 7 Dec 2021 19:49:24 -0800
Message-ID: <CA+khW7h3VM+7CESWeFgheMkg20JckbxidC6Quy-02_kFJL96tA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Add MEM_RDONLY for helper args that
 are pointers to rdonly mem.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 6, 2021 at 10:24 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Some helper functions may modify its arguments, for example,
> > bpf_d_path, bpf_get_stack etc. Previously, their argument types
> > were marked as ARG_PTR_TO_MEM, which is compatible with read-only
> > mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate
> > to modify a read-only memory by passing it into one of such helper
> > functions.
> >
> > This patch tags the bpf_args compatible with immutable memory with
> > MEM_RDONLY flag. The arguments that don't have this flag will be
> > only compatible with mutable memory types, preventing the helper
> > from modifying a read-only memory. The bpf_args that have
> > MEM_RDONLY are compatible with both mutable memory and immutable
> > memory.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  include/linux/bpf.h      |  4 ++-
> >  kernel/bpf/btf.c         |  2 +-
> >  kernel/bpf/cgroup.c      |  2 +-
> >  kernel/bpf/helpers.c     |  8 ++---
> >  kernel/bpf/ringbuf.c     |  2 +-
> >  kernel/bpf/syscall.c     |  2 +-
> >  kernel/bpf/verifier.c    | 14 +++++++--
> >  kernel/trace/bpf_trace.c | 26 ++++++++--------
> >  net/core/filter.c        | 64 ++++++++++++++++++++--------------------
> >  9 files changed, 67 insertions(+), 57 deletions(-)
> >
[...]
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 44af65f07a82..a7c015a7b52d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4966,6 +4966,7 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
> >         return 0;
> >  }
> >
> > +
>
> nit: unnecessary extra empty line?
>

Ack.

> >  struct bpf_reg_types {
> >         const enum bpf_reg_type types[10];
> >         u32 *btf_id;
> > @@ -5012,7 +5013,6 @@ static const struct bpf_reg_types mem_types = {
> >                 PTR_TO_MAP_VALUE,
> >                 PTR_TO_MEM,
> >                 PTR_TO_BUF,
> > -               PTR_TO_BUF | MEM_RDONLY,
> >         },
> >  };
> >
> > @@ -5074,6 +5074,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> >         enum bpf_reg_type expected, type = reg->type;
> >         const struct bpf_reg_types *compatible;
> > +       u32 compatible_flags;
> >         int i, j;
> >
> >         compatible = compatible_reg_types[base_type(arg_type)];
> > @@ -5082,6 +5083,13 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> >                 return -EFAULT;
> >         }
> >
> > +       /* If arg_type is tagged with MEM_RDONLY, it's compatible with both
> > +        * RDONLY and non-RDONLY reg values. Therefore fold this flag before
> > +        * comparison. PTR_MAYBE_NULL is similar.
> > +        */
> > +       compatible_flags = arg_type & (MEM_RDONLY | PTR_MAYBE_NULL);
> > +       type &= ~compatible_flags;
> > +
>
> wouldn't
>
> type &= ~MEM_RDONLY; /* clear read-only flag, if any */
> type &= ~PTR_MAYBE_NULL; /* clear nullable flag, if any */
>
> be cleaner and more straightforward?
>
>

No problem. Sounds good to me.

> >         for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
> >                 expected = compatible->types[i];
> >                 if (expected == NOT_INIT)
>
> [...]
