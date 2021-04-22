Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FE5367CB4
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbhDVImU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhDVImU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 04:42:20 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ABBC06138B
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 01:41:46 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id s16so39513813iog.9
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/9GF1YfDxhn16pA4SsWRwQdnqJ92y1Idd/tVVwB0RI=;
        b=LC4HP9PGz3ERWrfyedQJ/0xIkEpplhFDn+XUs9iYGqkhD9kYwGk/i+JCiDAlkCZ4x4
         XBztsSL7yd8Tic7J2/ckricsb/Vre2VFLtd7ZfsA94VNcNH3nsRwbCz/wbBfA0ozbZQA
         Xrs9j2tUZ3EBJm0m46prqwwemTt1N4PlPFf2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/9GF1YfDxhn16pA4SsWRwQdnqJ92y1Idd/tVVwB0RI=;
        b=jAT5e73QQQwiGnxZC1R8SPpdGVTpAzVodhQFbuDNRYsmmkCOuKIUsLEdJmagoBSsVk
         H/btAshLS1zkM0p4W2ODiiiNm9oFHiN8x4kPB06i+Jt6LAGDf5NffPVqd5DP24XzY8RO
         OIdGu+H3OI7t8s/9uPYAZcq36KknMTNWsfZSNsitEvZjO40yr5zBIL529SYDXgoJkLez
         PIhqp7fZV+2bjioMDuAcF9IFQTjtosJn+FvH7E9nAXn7EAe+PAx/N+2TCPg1hlQnn9Fc
         L3Q1fvJhVVCTG4sxsD/RHfLtPZ6sUatN8Jp6oLrL2V75bX9J65OoVIW/vgvHLdt9WU+t
         Y1xg==
X-Gm-Message-State: AOAM533/kqSFArjno9GXwxjUIgRtPgxNqWwQ1vcOIJKSdSOvDxdT8M1K
        8KYPh5xC5dwg6ei21LFRjvli1VktJt/UlncUABSoRA==
X-Google-Smtp-Source: ABdhPJzpiaW9ZBjWvxc2yUSkjnNI3WQjqt/9jQRJRnMM08623qjk8RxIhGl8fcN1dzyNYW+zxf2OjMJzyup2Xyry8qc=
X-Received: by 2002:a05:6638:2515:: with SMTP id v21mr2236163jat.110.1619080905325;
 Thu, 22 Apr 2021 01:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210419155243.1632274-1-revest@chromium.org> <20210419155243.1632274-3-revest@chromium.org>
 <20210419225404.chlkiaku5vaxmmyh@ast-mbp.dhcp.thefacebook.com>
 <CABRcYmJO5+tFtGuL9pdtFqLnBV7fGugEjaPbNRtJ3iXpbs3kFg@mail.gmail.com> <CAADnVQKrc1Rz_qr5R50vJ2H7-K+9AzBVQZ4OMgGEno+8r6sHpw@mail.gmail.com>
In-Reply-To: <CAADnVQKrc1Rz_qr5R50vJ2H7-K+9AzBVQZ4OMgGEno+8r6sHpw@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 22 Apr 2021 10:41:34 +0200
Message-ID: <CABRcYm+38oi=wdZZm-=QEjSpS+-u2YTKFf0SQMG+jmf7oqwN-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/6] bpf: Add a ARG_PTR_TO_CONST_STR argument type
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Tue, Apr 20, 2021 at 5:23 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 20, 2021 at 5:35 AM Florent Revest <revest@chromium.org> wrote:
> >
> > On Tue, Apr 20, 2021 at 12:54 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Apr 19, 2021 at 05:52:39PM +0200, Florent Revest wrote:
> > > > This type provides the guarantee that an argument is going to be a const
> > > > pointer to somewhere in a read-only map value. It also checks that this
> > > > pointer is followed by a zero character before the end of the map value.
> > > >
> > > > Signed-off-by: Florent Revest <revest@chromium.org>
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  include/linux/bpf.h   |  1 +
> > > >  kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 42 insertions(+)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 77d1d8c65b81..c160526fc8bf 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -309,6 +309,7 @@ enum bpf_arg_type {
> > > >       ARG_PTR_TO_PERCPU_BTF_ID,       /* pointer to in-kernel percpu type */
> > > >       ARG_PTR_TO_FUNC,        /* pointer to a bpf program function */
> > > >       ARG_PTR_TO_STACK_OR_NULL,       /* pointer to stack or NULL */
> > > > +     ARG_PTR_TO_CONST_STR,   /* pointer to a null terminated read-only string */
> > > >       __BPF_ARG_TYPE_MAX,
> > > >  };
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 852541a435ef..5f46dd6f3383 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -4787,6 +4787,7 @@ static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALU
> > > >  static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_PERCPU_BTF_ID } };
> > > >  static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
> > > >  static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
> > > > +static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
> > > >
> > > >  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> > > >       [ARG_PTR_TO_MAP_KEY]            = &map_key_value_types,
> > > > @@ -4817,6 +4818,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
> > > >       [ARG_PTR_TO_PERCPU_BTF_ID]      = &percpu_btf_ptr_types,
> > > >       [ARG_PTR_TO_FUNC]               = &func_ptr_types,
> > > >       [ARG_PTR_TO_STACK_OR_NULL]      = &stack_ptr_types,
> > > > +     [ARG_PTR_TO_CONST_STR]          = &const_str_ptr_types,
> > > >  };
> > > >
> > > >  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> > > > @@ -5067,6 +5069,45 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > >               if (err)
> > > >                       return err;
> > > >               err = check_ptr_alignment(env, reg, 0, size, true);
> > > > +     } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> > > > +             struct bpf_map *map = reg->map_ptr;
> > > > +             int map_off;
> > > > +             u64 map_addr;
> > > > +             char *str_ptr;
> > > > +
> > > > +             if (reg->type != PTR_TO_MAP_VALUE || !map ||
> > >
> > > I think the 'type' check is redundant,
> > > since check_reg_type() did it via compatible_reg_types.
> > > If so it's probably better to remove it here ?
> > >
> > > '!map' looks unnecessary. Can it ever happen? If yes, it's a verifier bug.
> > > For example in check_mem_access() we just deref reg->map_ptr without checking
> > > which, I think, is correct.
> >
> > I agree with all of the above. I only thought it's better to be safe
> > than sorry but if you'd like I could follow up with a patch that
> > removes some checks?
> ...
> > Sure, does not hurt. I can also follow up with a patch unless if you
> > prefer doing it yourself.
>
> Please send a follow up patch.

Okay, doing that today :)

> I consider this kind of "safe than sorry" to be defensive programming that
> promotes less-thinking-is-fine-because-its-faster-to-code style.

Fair

> I'm sure you've seen my rants against defensive programming in the past :)

Ahah, I haven't yet but I surely don't want to make you rant again ;)
