Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F41140BC30
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 01:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhINXby (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 19:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhINXby (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 19:31:54 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74614C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 16:30:36 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id y13so1742534ybi.6
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m8kjlHiOet4h4pDMne73URk26NLp3rLJcOfAJ95mu8E=;
        b=goiWsHzQGanGv8Ba9CCz74Wm/X+/gFNmZc/vdIVBa1Rr6KmAAFrztGO/GxRcKqiXJK
         P6Op64xXv8QfZDDX3zWanhvOlcNpo5q4CzTgbBRu2Wpb0eRJE/qAq3Ibp4wRbHm6oVF8
         XbSGjtGcq1M8HsCYxR5lnit4G7LhzLlOnnrxkBXIb97MokNYY/Eu0no5K+o/P2DvXFG7
         QML663DMxOuneDUspbbqm9AvNA5tuKMSGn6NoJ+bbEuChOCvaAZZZOBQ2MyigMKXTgSk
         YOIFVgRnrNXzkcR5eZDZINc+yyWiYc561X1QieOm043YJio8tgk8dFK9BwLwQcREJDyG
         wokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m8kjlHiOet4h4pDMne73URk26NLp3rLJcOfAJ95mu8E=;
        b=3lkLDWarfbm58QrcnqSgLqcP33hs7uDqcaOa8nnrvNrny4ZF3580LSSXtTzj+3sEC5
         SJDqn3xhFHz73l3HP378x7gpWf7+9PriiDS3jrKsq+qP0YZgjSWPtW8lU/0/2Qy9hv5J
         b5uX67nCe4ncJT6b1Ho6/JYyJTPH98MnwqXo7172vlk55k2QocJcvSnSjpGavRoZ+mSj
         duRQ4DDY0FH8IHAjdONsl7MPGrEUkyrHHC0wPCa7qW7KbJRVaLRT8Bks2/RIvh85gV6U
         HJbQ3aiOjI+OfP9r8BteFuUi2wRBaQsJJIT6HywPOqlXy8YDUJvJnX128zyx0hU0bzm8
         tDpw==
X-Gm-Message-State: AOAM533umbRZf6npAZoXOS9Fsjz093+PgUP+HghxyPEkX4IAAn0TUDoq
        7bfW5lgSf8CEzQ2Wq/hOZ314o25VdqvLXv1ErPdcTIgg
X-Google-Smtp-Source: ABdhPJyXsMnl7W92yVrx0MuTF7QN8ph0i5wDtYtBX6K25QCTRTwYYW1/h1ncnfoMq5FA0/I1UvXfTMz9TQkoAaQeLSE=
X-Received: by 2002:a5b:408:: with SMTP id m8mr2324261ybp.2.1631662235712;
 Tue, 14 Sep 2021 16:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210913155122.3722704-1-yhs@fb.com> <20210913155133.3723769-1-yhs@fb.com>
 <CAEf4Bza69r-Sp4nFZqd4i1xhD+Dy5u+Xb=FB7TNNSfHzNNvosg@mail.gmail.com> <5a079457-88f9-5ed5-83bf-b0a456186323@fb.com>
In-Reply-To: <5a079457-88f9-5ed5-83bf-b0a456186323@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 16:30:24 -0700
Message-ID: <CAEf4BzYjVHpnz1YWa-e1gD4mwU_ssV+b-Mv7taGho2b_gUSWLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/11] bpf: support for new btf kind BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 8:59 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/13/21 10:08 PM, Andrii Nakryiko wrote:
> > On Mon, Sep 13, 2021 at 8:51 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> LLVM14 added support for a new C attribute ([1])
> >>    __attribute__((btf_tag("arbitrary_str")))
> >> This attribute will be emitted to dwarf ([2]) and pahole
> >> will convert it to BTF. Or for bpf target, this
> >> attribute will be emitted to BTF directly ([3], [4]).
> >> The attribute is intended to provide additional
> >> information for
> >>    - struct/union type or struct/union member
> >>    - static/global variables
> >>    - static/global function or function parameter.
> >>
> >> For linux kernel, the btf_tag can be applied
> >> in various places to specify user pointer,
> >> function pre- or post- condition, function
> >> allow/deny in certain context, etc. Such information
> >> will be encoded in vmlinux BTF and can be used
> >> by verifier.
> >>
> >> The btf_tag can also be applied to bpf programs
> >> to help global verifiable functions, e.g.,
> >> specifying preconditions, etc.
> >>
> >> This patch added basic parsing and checking support
> >> in kernel for new BTF_KIND_TAG kind.
> >>
> >>   [1] https://reviews.llvm.org/D106614
> >>   [2] https://reviews.llvm.org/D106621
> >>   [3] https://reviews.llvm.org/D106622
> >>   [4] https://reviews.llvm.org/D109560
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   include/uapi/linux/btf.h       |  16 ++++-
> >>   kernel/bpf/btf.c               | 120 +++++++++++++++++++++++++++++++++
> >>   tools/include/uapi/linux/btf.h |  16 ++++-
> >>   3 files changed, 148 insertions(+), 4 deletions(-)
> >>
> >
> > [...]
> >
> >>
> >> +static s32 btf_tag_check_meta(struct btf_verifier_env *env,
> >> +                             const struct btf_type *t,
> >> +                             u32 meta_left)
> >> +{
> >> +       const struct btf_tag *tag;
> >> +       u32 meta_needed = sizeof(*tag);
> >> +       const char *value;
> >> +
> >> +       if (meta_left < meta_needed) {
> >> +               btf_verifier_log_basic(env, t,
> >> +                                      "meta_left:%u meta_needed:%u",
> >> +                                      meta_left, meta_needed);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       value = btf_name_by_offset(env->btf, t->name_off);
> >> +       if (!value || !value[0]) {
> >> +               btf_verifier_log_type(env, t, "Invalid value");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (btf_type_vlen(t)) {
> >> +               btf_verifier_log_type(env, t, "vlen != 0");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (btf_type_kflag(t)) {
> >> +               btf_verifier_log_type(env, t, "Invalid btf_info kind_flag");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >
> > probably need to enforce that component_idx is >= -1? -2 is not a
> > valid supported value right now.
>
> I tested below. But I can test here for kernel practice, testing error
> case earlier.
>
> >
> >> +       btf_verifier_log_type(env, t, NULL);
> >> +
> >> +       return meta_needed;
> >> +}
> >> +
> >> +static int btf_tag_resolve(struct btf_verifier_env *env,
> >> +                          const struct resolve_vertex *v)
> >> +{
> >> +       const struct btf_type *next_type;
> >> +       const struct btf_type *t = v->t;
> >> +       u32 next_type_id = t->type;
> >> +       struct btf *btf = env->btf;
> >> +       s32 component_idx;
> >> +       u32 vlen;
> >> +
> >> +       next_type = btf_type_by_id(btf, next_type_id);
> >> +       if (!next_type || !btf_type_is_tag_target(next_type)) {
> >> +               btf_verifier_log_type(env, v->t, "Invalid type_id");
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       if (!env_type_is_resolve_sink(env, next_type) &&
> >> +           !env_type_is_resolved(env, next_type_id))
> >> +               return env_stack_push(env, next_type, next_type_id);
> >> +
> >> +       component_idx = btf_type_tag(t)->component_idx;
> >> +       if (component_idx != -1) {
> >
> > so here, if it's -2, that should be an error, but currently will be
> > ignored, right?
>
> It is not. See below. At this point, component_idx could be -2 or 0 or 1 ...
>
> >
> >> +               if (btf_type_is_var(next_type) || component_idx < 0) {
> >
> > if is_var(next_type) then component_idx should only be -1, nothing
> > else. Or am I missing some convention?
>
> So if it is a variable, the error will return.
>
> If it is not a variable and component_idx < 0 (-2 in this case), return
> error. So we do test -2 here.
>
> I will restructure the code to test < -1 earlier, so we won't have
> confusion here.

Oh, I've read this a few times and every single time I read it as
(btf_type_is_var() && component_idx < 0). It makes sense now, but it
is a bit convoluted to follow the checks. Thanks for improving!

>
> >
> >> +                       btf_verifier_log_type(env, v->t, "Invalid component_idx");
> >> +                       return -EINVAL;
> >> +               }
> >> +
> >> +               if (btf_type_is_struct(next_type)) {
> >> +                       vlen = btf_type_vlen(next_type);
> >> +               } else {
> >> +                       next_type = btf_type_by_id(btf, next_type->type);
> >> +                       vlen = btf_type_vlen(next_type);
> >> +               }
> >> +
> >> +               if ((u32)component_idx >= vlen) {
> >> +                       btf_verifier_log_type(env, v->t, "Invalid component_idx");
> >> +                       return -EINVAL;
> >> +               }
> >> +       }
> >> +
> >> +       env_stack_pop_resolved(env, next_type_id, 0);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >
> > [...]
> >
