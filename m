Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E85365C15
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhDTPYs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Apr 2021 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbhDTPYH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Apr 2021 11:24:07 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E32C06174A;
        Tue, 20 Apr 2021 08:23:34 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m7so33170110ljp.10;
        Tue, 20 Apr 2021 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EjKoa8Hb8NJHG5oHC5Qy7PkfK1T1P6HlwUTWtNshDX0=;
        b=o0dj0xGcs+C6QHRe8wvzo6TjGXc1YXF5jX29xHml7ACBMh/BHPWzwyDZUwDNIxkTgY
         Q/ha0GpXwqWVNu7zzB/GijpBhqWp+OCYCVTDI3lwR8CLcY20U5IMhPuMvIbjJYrUfnZl
         M4NkQcVjnQe8mckDgknRB+HmTXKfpzqKZiINa0/ED9IMf1I8HyVtB59aJzKxfkXfdBd9
         mlb79D/k8UK68UAt6mfrtds8/XT8xWTF5HwkOjftgnbYxd23xq8imEOcLEU6TSYjAuQs
         34aiSQ2LVNmUy/auRBCGo2rQiF4dWn9y4ehiJ/iPFipMeQiDrj1+uO4Rkbowy7HbtHxu
         dKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EjKoa8Hb8NJHG5oHC5Qy7PkfK1T1P6HlwUTWtNshDX0=;
        b=bz5dNkvnL3aLlTB9mghpKGeH7/GOnyo8ArRkQDKZQckgtqNwnrYzILzg0WsPyaVSVQ
         8fpGzkeOww29rXky7JQrNshO6yh271bbNi0bbNYtjVgEB4YvdvgwgDj+qYtpuhsxPxSU
         oQvmRy3NSsOGdLG7+WxCHHXMctD3D3UmfMud3f0Xk/5IlwndgcXne+3wbDFWQuz1ni1P
         U0nJsv6lyV4KSimhexEN2O52Ooan0fQNb16yjXcRCM+bhu8v9fMMvOvQP5HTPUCrar/q
         eyKJg3cP2QGRzKKu89EHbQeSvvswi2zZzQ1vbULk5dYlG498wxLY4+7TMyS/J0eKd2pc
         BRJw==
X-Gm-Message-State: AOAM532XzBJHXSQ2ks5Mmf6h4v/6hFJnGDKepnkNpCvATPP+DWqavbIx
        klPJsG2oiyMpPEcGRMMQQo38N3ql/l6xJmyFYRoaU5De
X-Google-Smtp-Source: ABdhPJwaQqluiwc9vDRTAoQ9Bss3qMuRW/xYdZ1oNcJpCD20dFcdgeVhkuZgFH6l6VenpGU7NLpL/uxmOFgQ9q3T8B0=
X-Received: by 2002:a2e:3511:: with SMTP id z17mr11571026ljz.32.1618932212699;
 Tue, 20 Apr 2021 08:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155243.1632274-1-revest@chromium.org> <20210419155243.1632274-3-revest@chromium.org>
 <20210419225404.chlkiaku5vaxmmyh@ast-mbp.dhcp.thefacebook.com> <CABRcYmJO5+tFtGuL9pdtFqLnBV7fGugEjaPbNRtJ3iXpbs3kFg@mail.gmail.com>
In-Reply-To: <CABRcYmJO5+tFtGuL9pdtFqLnBV7fGugEjaPbNRtJ3iXpbs3kFg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 20 Apr 2021 08:23:21 -0700
Message-ID: <CAADnVQKrc1Rz_qr5R50vJ2H7-K+9AzBVQZ4OMgGEno+8r6sHpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/6] bpf: Add a ARG_PTR_TO_CONST_STR argument type
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 20, 2021 at 5:35 AM Florent Revest <revest@chromium.org> wrote:
>
> On Tue, Apr 20, 2021 at 12:54 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 19, 2021 at 05:52:39PM +0200, Florent Revest wrote:
> > > This type provides the guarantee that an argument is going to be a const
> > > pointer to somewhere in a read-only map value. It also checks that this
> > > pointer is followed by a zero character before the end of the map value.
> > >
> > > Signed-off-by: Florent Revest <revest@chromium.org>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/bpf.h   |  1 +
> > >  kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 42 insertions(+)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 77d1d8c65b81..c160526fc8bf 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -309,6 +309,7 @@ enum bpf_arg_type {
> > >       ARG_PTR_TO_PERCPU_BTF_ID,       /* pointer to in-kernel percpu type */
> > >       ARG_PTR_TO_FUNC,        /* pointer to a bpf program function */
> > >       ARG_PTR_TO_STACK_OR_NULL,       /* pointer to stack or NULL */
> > > +     ARG_PTR_TO_CONST_STR,   /* pointer to a null terminated read-only string */
> > >       __BPF_ARG_TYPE_MAX,
> > >  };
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 852541a435ef..5f46dd6f3383 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -4787,6 +4787,7 @@ static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALU
> > >  static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_PERCPU_BTF_ID } };
> > >  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> > >  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
> > > +static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> > >
> > >  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> > >       [ARG_PTR_TO_MAP_KEY]            = &map_key_value_types,
> > > @@ -4817,6 +4818,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> > >       [ARG_PTR_TO_PERCPU_BTF_ID]      = &percpu_btf_ptr_types,
> > >       [ARG_PTR_TO_FUNC]               = &func_ptr_types,
> > >       [ARG_PTR_TO_STACK_OR_NULL]      = &stack_ptr_types,
> > > +     [ARG_PTR_TO_CONST_STR]          = &const_str_ptr_types,
> > >  };
> > >
> > >  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > > @@ -5067,6 +5069,45 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > >               if (err)
> > >                       return err;
> > >               err = check_ptr_alignment(env, reg, 0, size, true);
> > > +     } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> > > +             struct bpf_map *map = reg->map_ptr;
> > > +             int map_off;
> > > +             u64 map_addr;
> > > +             char *str_ptr;
> > > +
> > > +             if (reg->type != PTR_TO_MAP_VALUE || !map ||
> >
> > I think the 'type' check is redundant,
> > since check_reg_type() did it via compatible_reg_types.
> > If so it's probably better to remove it here ?
> >
> > '!map' looks unnecessary. Can it ever happen? If yes, it's a verifier bug.
> > For example in check_mem_access() we just deref reg->map_ptr without checking
> > which, I think, is correct.
>
> I agree with all of the above. I only thought it's better to be safe
> than sorry but if you'd like I could follow up with a patch that
> removes some checks?
...
> Sure, does not hurt. I can also follow up with a patch unless if you
> prefer doing it yourself.

Please send a follow up patch.
I consider this kind of "safe than sorry" to be defensive programming that
promotes less-thinking-is-fine-because-its-faster-to-code style.
I'm sure you've seen my rants against defensive programming in the past :)
