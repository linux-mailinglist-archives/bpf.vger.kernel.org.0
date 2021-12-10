Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797EB4707EA
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 18:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhLJR7p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 12:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbhLJR7p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 12:59:45 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67BAC061746
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 09:56:09 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id g17so22988110ybe.13
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 09:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lT7glRwXHOFZngk6OUO7Jy4qtrgqUJqFSyFD7CFQWkU=;
        b=jP0Hb2EBsk9l+zlsknHcL7nN9f/DlMAhodKyMOkDTiHEXirBdehZM50qmS2TcLp0ch
         GutDFv/KofZP8trXH+MzEGm4L5pizyl5ItLoF52ID9vm0/afT9pC0IoAd+6WtSguz55L
         PCFSJyDyX6cr7vNxudu+PZ9CDIHpg+upGrtCnmEpDSA1pBiTlxfJxa+e0cKjIDK2y+SI
         0NKMMT4uJbLofjfxxmfpV0Ub8IT36kqJ6D0LoqqrQ86VJZOXS3tRvkttBI1vjOtZiKoV
         V8X4z43+I5uaX1cK1yQQE8D1zUE3jX1fyP7e2Y0IRTbnpRFVK+DJUGTrxOBAvHEkA5tU
         5NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lT7glRwXHOFZngk6OUO7Jy4qtrgqUJqFSyFD7CFQWkU=;
        b=0GPT+uvzNFtIfX5EXNJrjDco+AWBORxvAidtVIe8m9iQ5Wpwku9H8ohijTiNQF4Iqf
         HTKWnyCZQEtGZHX01riydKsIUqKFYkQ+cqdnZFC4La+HjRenDcHy4W/C26XT7Sme81Zg
         iHuUJFBAWYmYbBgPhyzB4B5paWT/66cBSKujyu7UzJ2Xzro4vRtjKLenMI7ZIqhIjwR9
         Ku9zQ68MPjRLcG5PhGaavetkWsCliM+/X94ivNxcaiNmFM1va7aS14TIto9L2oT8yjEy
         JmNZ0Q+EOO9PddeYNPXWSUjAOlrlI9umBj0eSvzF9IxynC9XWqj+SsrQivB6a19pA+59
         ifDQ==
X-Gm-Message-State: AOAM531FA4D4Pw2iQYhG40pDS8NGbXX8MJgUYaxBg6++zFgVW/BRZ/vX
        E0WxVj8Gjt2oRmjmzRb3ZNzJwsaBYgL+ARWEIz0=
X-Google-Smtp-Source: ABdhPJyzSJoBSknTvC56y9tKPPKdPOf55CsTpg+4fDBykfoswWtcehFUi6/33QXH+mDjjd52KWvdHxrUwRL70RAdEto=
X-Received: by 2002:a25:e90a:: with SMTP id n10mr15616045ybd.180.1639158969022;
 Fri, 10 Dec 2021 09:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-9-haoluo@google.com>
 <CAEf4Bzb3nyWbS4=e7M8Am5BvMSPbMhMzXPKvd3spk+D9vZg99g@mail.gmail.com>
 <CA+khW7h3VM+7CESWeFgheMkg20JckbxidC6Quy-02_kFJL96tA@mail.gmail.com> <CA+khW7g5P3-ipVLZ8KSZZUf=3_F4uMEY4FhbDH7J5kqL08ggYg@mail.gmail.com>
In-Reply-To: <CA+khW7g5P3-ipVLZ8KSZZUf=3_F4uMEY4FhbDH7J5kqL08ggYg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Dec 2021 09:55:58 -0800
Message-ID: <CAEf4BzaxJjq9wyM=VpPBFcsBYYrhWy3AZ94o+0-pFhma32Vcmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Add MEM_RDONLY for helper args that
 are pointers to rdonly mem.
To:     Hao Luo <haoluo@google.com>
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

On Thu, Dec 9, 2021 at 12:04 PM Hao Luo <haoluo@google.com> wrote:
>
> On Tue, Dec 7, 2021 at 7:49 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Mon, Dec 6, 2021 at 10:24 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > Some helper functions may modify its arguments, for example,
> > > > bpf_d_path, bpf_get_stack etc. Previously, their argument types
> > > > were marked as ARG_PTR_TO_MEM, which is compatible with read-only
> > > > mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate
> > > > to modify a read-only memory by passing it into one of such helper
> > > > functions.
> > > >
> > > > This patch tags the bpf_args compatible with immutable memory with
> > > > MEM_RDONLY flag. The arguments that don't have this flag will be
> > > > only compatible with mutable memory types, preventing the helper
> > > > from modifying a read-only memory. The bpf_args that have
> > > > MEM_RDONLY are compatible with both mutable memory and immutable
> > > > memory.
> > > >
> > > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > > ---
> > > >  include/linux/bpf.h      |  4 ++-
> > > >  kernel/bpf/btf.c         |  2 +-
> > > >  kernel/bpf/cgroup.c      |  2 +-
> > > >  kernel/bpf/helpers.c     |  8 ++---
> > > >  kernel/bpf/ringbuf.c     |  2 +-
> > > >  kernel/bpf/syscall.c     |  2 +-
> > > >  kernel/bpf/verifier.c    | 14 +++++++--
> > > >  kernel/trace/bpf_trace.c | 26 ++++++++--------
> > > >  net/core/filter.c        | 64 ++++++++++++++++++++--------------------
> > > >  9 files changed, 67 insertions(+), 57 deletions(-)
> > > >
> [...]
> > > > @@ -5074,6 +5074,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > > >         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > > >         enum bpf_reg_type expected, type = reg->type;
> > > >         const struct bpf_reg_types *compatible;
> > > > +       u32 compatible_flags;
> > > >         int i, j;
> > > >
> > > >         compatible = compatible_reg_types[base_type(arg_type)];
> > > > @@ -5082,6 +5083,13 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > > >                 return -EFAULT;
> > > >         }
> > > >
> > > > +       /* If arg_type is tagged with MEM_RDONLY, it's compatible with both
> > > > +        * RDONLY and non-RDONLY reg values. Therefore fold this flag before
> > > > +        * comparison. PTR_MAYBE_NULL is similar.
> > > > +        */
> > > > +       compatible_flags = arg_type & (MEM_RDONLY | PTR_MAYBE_NULL);
> > > > +       type &= ~compatible_flags;
> > > > +
> > >
> > > wouldn't
> > >
> > > type &= ~MEM_RDONLY; /* clear read-only flag, if any */
> > > type &= ~PTR_MAYBE_NULL; /* clear nullable flag, if any */
> > >
> > > be cleaner and more straightforward?
> > >
> > >
> >
> > No problem. Sounds good to me.
> >
>
> I just realized the suggested transformation is wrong. Whether to fold
> the flag depends on whether arg_type has the flag. So it should
> instead be
>
> if (arg_type & MEM_RDONLY)
>   type &= ~MEM_RDONLY;
>
> or
>
> type &= ~(arg_type & MEM_RDONLY);

You are totally right. I think this deserves a big verbose comment
explaining that:

ARG_PTR_TO_MEM+RDONLY is compatible with PTR_TO_MEM and PTR_TO_MEM+RDONLY, but
ARG_PTR_TO_MEM is compatible only with PTR_TO_MEM and NOT with PTR_TO_MEM+RDONLY

Same for MAYBE_NULL:

ARG_PTR_TO_MEM + MAYBE_NULL is compatible with PTR_TO_MEM and
PTR_TO_MEM+MAYBE_NULL, but
ARG_PTR_TO_MEM is compatible only with PTR_TO_MEM but NOT with
PTR_TO_MEM+MAYBE_NULL

It might not be true for other future modifiers, so I'd do each of
RDONLY and MAYBE_NULL with a separate if and comment.

Good catch, btw! (but hopefully selftests would have caught this? if
not, we need better tests)

>
> > > >         for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
> > > >                 expected = compatible->types[i];
> > > >                 if (expected == NOT_INIT)
> > >
> > > [...]
