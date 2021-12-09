Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6710346F48C
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 21:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhLIUIE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 15:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhLIUID (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Dec 2021 15:08:03 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C291C061746
        for <bpf@vger.kernel.org>; Thu,  9 Dec 2021 12:04:30 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o29so5189257wms.2
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 12:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iG5PNVB7i1rl7VWt0dt7nlxQctDlSAH4wQC28xlNank=;
        b=fIv9+BaDmOG+YaC5f5dPzqQ2fUK0C8j+ympsVHw3LGzz1MMmm/3SA4YAlGWb0w0l5x
         NdRloDbZg7mLAjPtE8dMe7gU2NGV2MZV5AAUQCqKAC8In+dNcBb2GYiTkpu/cOyRiy0i
         M2WIL6fHVEDExV5btt5p43dCYOWLfmz5m1VX3dqiWLruQHwhxZ30TFEeraQ11ZArKe4k
         32vG1JbG5svVZqvaTVzK84xhBFFXv41ftlxnjNARfQ6DjDpk7WGIyH+fc0lwBz1Z7kE+
         QlZh9rXtmX6AEyF0VlgypnKnT9XqIzc/IUjlBCjs31EFJ+9yDbh6V4Lwrq1atbL5DWlj
         aj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iG5PNVB7i1rl7VWt0dt7nlxQctDlSAH4wQC28xlNank=;
        b=6ThdCI6FRvCGpWMi1ucA2fzFmfU6iTIEwJ/zpTZOIcNJnQuqNitjvDrsW5ZDLBvHhY
         ws8W9usf1Ec/A22E5XfL1L5N9cjJU7JBAVVxceTJdjj9AQ1U859nQ5WRXRlKMP2tZ6Gg
         8MYWdfkpuqEZssv5lbUEAHqBWGMG405+9vGXY11doQTZL3IMEQGFTAWi6z8CreNRl2Pk
         eEWzQXOtAL/9l+CCj5Af7kVjn5jyMyoZbsSOwpvWz8rdpJx/2VE4RNXePUZROLAOLZtf
         TTOrUJJtmZAwgSonNsQ7d2YhJ89RLisFXSTUINzPYIgzDi6qZ7L3WWs0yXbw0RJ+E+z4
         scbw==
X-Gm-Message-State: AOAM532NxCuSx/0pilpUucSya/0rsXu5cWsq7psPpeVoevEt9NzXOynG
        2yqBf35VBAjXoVM3HC/N8edvjapmJR7KGlcNLSPcbw==
X-Google-Smtp-Source: ABdhPJxUge6ER2ziYtKCZxwBKjlUBmBcF0ESfO7EZUjTKTKNq3QVmpwTsovmV+m0xJbG8+cwUVCAT0Y9ugwEX5Lv2PI=
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr10015769wmq.164.1639080268291;
 Thu, 09 Dec 2021 12:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-9-haoluo@google.com>
 <CAEf4Bzb3nyWbS4=e7M8Am5BvMSPbMhMzXPKvd3spk+D9vZg99g@mail.gmail.com> <CA+khW7h3VM+7CESWeFgheMkg20JckbxidC6Quy-02_kFJL96tA@mail.gmail.com>
In-Reply-To: <CA+khW7h3VM+7CESWeFgheMkg20JckbxidC6Quy-02_kFJL96tA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 9 Dec 2021 12:04:17 -0800
Message-ID: <CA+khW7g5P3-ipVLZ8KSZZUf=3_F4uMEY4FhbDH7J5kqL08ggYg@mail.gmail.com>
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

On Tue, Dec 7, 2021 at 7:49 PM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Dec 6, 2021 at 10:24 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > Some helper functions may modify its arguments, for example,
> > > bpf_d_path, bpf_get_stack etc. Previously, their argument types
> > > were marked as ARG_PTR_TO_MEM, which is compatible with read-only
> > > mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate
> > > to modify a read-only memory by passing it into one of such helper
> > > functions.
> > >
> > > This patch tags the bpf_args compatible with immutable memory with
> > > MEM_RDONLY flag. The arguments that don't have this flag will be
> > > only compatible with mutable memory types, preventing the helper
> > > from modifying a read-only memory. The bpf_args that have
> > > MEM_RDONLY are compatible with both mutable memory and immutable
> > > memory.
> > >
> > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > ---
> > >  include/linux/bpf.h      |  4 ++-
> > >  kernel/bpf/btf.c         |  2 +-
> > >  kernel/bpf/cgroup.c      |  2 +-
> > >  kernel/bpf/helpers.c     |  8 ++---
> > >  kernel/bpf/ringbuf.c     |  2 +-
> > >  kernel/bpf/syscall.c     |  2 +-
> > >  kernel/bpf/verifier.c    | 14 +++++++--
> > >  kernel/trace/bpf_trace.c | 26 ++++++++--------
> > >  net/core/filter.c        | 64 ++++++++++++++++++++--------------------
> > >  9 files changed, 67 insertions(+), 57 deletions(-)
> > >
[...]
> > > @@ -5074,6 +5074,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > >         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > >         enum bpf_reg_type expected, type = reg->type;
> > >         const struct bpf_reg_types *compatible;
> > > +       u32 compatible_flags;
> > >         int i, j;
> > >
> > >         compatible = compatible_reg_types[base_type(arg_type)];
> > > @@ -5082,6 +5083,13 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > >                 return -EFAULT;
> > >         }
> > >
> > > +       /* If arg_type is tagged with MEM_RDONLY, it's compatible with both
> > > +        * RDONLY and non-RDONLY reg values. Therefore fold this flag before
> > > +        * comparison. PTR_MAYBE_NULL is similar.
> > > +        */
> > > +       compatible_flags = arg_type & (MEM_RDONLY | PTR_MAYBE_NULL);
> > > +       type &= ~compatible_flags;
> > > +
> >
> > wouldn't
> >
> > type &= ~MEM_RDONLY; /* clear read-only flag, if any */
> > type &= ~PTR_MAYBE_NULL; /* clear nullable flag, if any */
> >
> > be cleaner and more straightforward?
> >
> >
>
> No problem. Sounds good to me.
>

I just realized the suggested transformation is wrong. Whether to fold
the flag depends on whether arg_type has the flag. So it should
instead be

if (arg_type & MEM_RDONLY)
  type &= ~MEM_RDONLY;

or

type &= ~(arg_type & MEM_RDONLY);

> > >         for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
> > >                 expected = compatible->types[i];
> > >                 if (expected == NOT_INIT)
> >
> > [...]
