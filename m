Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA61471F3B
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 03:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhLMCDG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Dec 2021 21:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLMCDF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Dec 2021 21:03:05 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952DBC06173F
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 18:03:05 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id m24so10113647pls.10
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 18:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1uSshd0FiXVVbxzAFI+0bvUDMO8DEq/IOMXGV9XhiY=;
        b=V6YIbZi0W7jVdz9L2cPIvAm9UlM4RH/YhTCB70rRNfDibTxpPKv91gS3pS6FJQFQYT
         rfrtAHDRfXF28HR6I2+7DMuLhweuIuTPMHce+h+tFtR+ivHa2TWr6zYxzk0pQCd//3kp
         ofveo6jDTKiCLe3cFM3FNGiDtd/L515fblMbnYp8INFBS8lLxX4mpCNCqe6JoIu57In4
         6YHhAE/rciIZGdjfXAhZp9IODoh20BWA2+gAZKjrwyAZIh6slbCuPZsHff6Zq6OK89Tc
         bf734jkpKNGkQkBz2oAotQSsfWGficvzYQMNPBJGlRepdUPEgIhSk51VT7Qp9YukBtct
         ml1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1uSshd0FiXVVbxzAFI+0bvUDMO8DEq/IOMXGV9XhiY=;
        b=JjKg1X757VNFzeKUXehzM3qr9mHxlffEU1WjWb3j85r3J2z91PmY/xOwhz90Ay3xdg
         r5nHjr9Yb0nOU743FEiOUitQUOx5/AkO3uFMHkmd0a9i0z8gwJx7YO8aQWXgjbd1UtIF
         EEwz5JVePsvMBxA6DMq1l2axSM7O/h+m4r07BtNQKJEZ+4SgcDdvP/2oJXQXEwHy8h+f
         cLP0w+127ULsqnkVrbVh+ftQ55vHMlNsJ9m4qWXC4+mNzlYMc/JEjM/TG8fhAteWcJEx
         qdWO/t9iUynFgIPJKtEmkkNJISaO1Amu2iAk8WmdeaDpRVxR7E6H66vyo+tTnXk7ABna
         ysmQ==
X-Gm-Message-State: AOAM5338JlHiYjxUiH/yfDqDDas0/hyvaxYOWe8idubdw0IowK467N4V
        30QbeGONx3UNxFcnvEmLun1JMiKGXVuN15OYMjs=
X-Google-Smtp-Source: ABdhPJyeVBmLI8X2gxWya/DiwR8dUVzODU+CrZN/3EGDnNs7SS1fcjmpLoZWSKKlHIu6Vj88IlugeN29ksmUCnvdMMo=
X-Received: by 2002:a17:902:b588:b0:143:b732:834 with SMTP id
 a8-20020a170902b58800b00143b7320834mr93178208pls.22.1639360985024; Sun, 12
 Dec 2021 18:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-5-haoluo@google.com>
 <CAEf4BzaKp0XFQYMjSrUzEb5AGamurA85nGJQxegJLJQ+wiso1A@mail.gmail.com>
 <CA+khW7gVp9bp0Q4OcqQxLW2ARL=6VjiOZu6f2vWOt4vvzj29UQ@mail.gmail.com>
 <CAEf4BzZ1-5Tbq5MXkJ=8REFGRFs5aXnT0aGbaQkWYKVo4vuqcA@mail.gmail.com>
 <CAADnVQJzq5j2WecExdzwG+oc8iTP3pSm5OXsmF5cLQvPKHNKeA@mail.gmail.com>
 <CA+khW7igx04tBfvXrNqROi6zfaLsDS6umuEV79iKdzsC2SFvxg@mail.gmail.com> <CAADnVQLX-Ks-5+3RZJMcD-K9gakKhTn6k5qv0MkiFRG-5Muhkw@mail.gmail.com>
In-Reply-To: <CAADnVQLX-Ks-5+3RZJMcD-K9gakKhTn6k5qv0MkiFRG-5Muhkw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 12 Dec 2021 18:02:53 -0800
Message-ID: <CAADnVQJTQ9f5V_-=kWa79ojvVLWFX2YLsRHLKOa9MZUB0gYa9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Replace PTR_TO_XXX_OR_NULL with
 PTR_TO_XXX | PTR_MAYBE_NULL
To:     Hao Luo <haoluo@google.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Dec 12, 2021 at 5:51 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 10, 2021 at 11:56 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Thu, Dec 9, 2021 at 1:45 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Dec 8, 2021 at 12:04 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > > > > +static const char *reg_type_str(enum bpf_reg_type type)
> > > > > > > +{
> > > > > > > +       static const char * const str[] = {
> > > > > > > +               [NOT_INIT]              = "?",
> > > > > > > +               [SCALAR_VALUE]          = "inv",
> > > > > > > +               [PTR_TO_CTX]            = "ctx",
> > > > > > > +               [CONST_PTR_TO_MAP]      = "map_ptr",
> > > > > > > +               [PTR_TO_MAP_VALUE]      = "map_value",
> > > > > > > +               [PTR_TO_STACK]          = "fp",
> > > > > > > +               [PTR_TO_PACKET]         = "pkt",
> > > > > > > +               [PTR_TO_PACKET_META]    = "pkt_meta",
> > > > > > > +               [PTR_TO_PACKET_END]     = "pkt_end",
> > > > > > > +               [PTR_TO_FLOW_KEYS]      = "flow_keys",
> > > > > > > +               [PTR_TO_SOCKET]         = "sock",
> > > > > > > +               [PTR_TO_SOCK_COMMON]    = "sock_common",
> > > > > > > +               [PTR_TO_TCP_SOCK]       = "tcp_sock",
> > > > > > > +               [PTR_TO_TP_BUFFER]      = "tp_buffer",
> > > > > > > +               [PTR_TO_XDP_SOCK]       = "xdp_sock",
> > > > > > > +               [PTR_TO_BTF_ID]         = "ptr_",
> > > > > > > +               [PTR_TO_PERCPU_BTF_ID]  = "percpu_ptr_",
> > > > > > > +               [PTR_TO_MEM]            = "mem",
> > > > > > > +               [PTR_TO_RDONLY_BUF]     = "rdonly_buf",
> > > > > > > +               [PTR_TO_RDWR_BUF]       = "rdwr_buf",
> > > > > > > +               [PTR_TO_FUNC]           = "func",
> > > > > > > +               [PTR_TO_MAP_KEY]        = "map_key",
> > > > > > > +       };
> > > > > > > +
> > > > > > > +       return str[base_type(type)];
> > > > > >
> > > > > > well... now we lose the "_or_null" part, that can be pretty important.
> > > > > > Same will happen with RDONLY flag, right?
> > > > > >
> > > > > > What can we do about that?
> > > > > >
> > > > >
> > > > > We can format the string into a global buffer and return the buffer to
> > > > > the caller. A little overhead on string formatting.
> > > >
> > > > Can't use global buffer, because multiple BPF verifications can
> > > > proceed at the same time.
> > >
> > > I think reg_type_str() can still return a const char string
> > > with flags.
> > > It's not going to be a direct str[base_type(type)]; of course.
> > > The str[] would be different.
> >
> > Sorry I didn't fully grasp this comment. Following is my understanding
> > and thoughts so far. Let me know if I missed anything.
>
> I meant that for now we can do:
>
> static const char * const str[] = {
>    [NOT_INIT]              = "?",
>    [PTR_TO_RDONLY_BUF]     = "rdonly_buf",
> };
> switch(type) {
>   case PTR_TO_RDONLY_BUF | MAYBE_NULL:return "rdonly_buf_or_null";
>   default: return str[base_type(type)];
> }
>
> > Right, we can return a char string, but the string must be provided by
> > the caller, which is the annoying part. We could do something as
> > following (solution 1)
> >
> > const char *reg_type_str(..., char *buf)
> > {
> >   ...
> >   snprintf(buf, ...);
> >   return buf;
> > }
> >
> > OR, (solution 2) we may embed a buffer in bpf_verifier_env and pass
> > env into reg_type_str(). reg_type_str() just returns the buffer in
> > env. This doesn't require the caller to prepare the buffer.
> >
> > const char *reg_type_str(..., env)
> > {
> >   ...
> >   snprintf(env->buf, ...);
> >   return env->buf;
> > }
>
> If we go with this approach then passing 'env' is a bit better,
> since 'buf' doesn't need to be allocated on stack.
>
> > However, there will be a caveat when there are more than one
> > reg_type_str in one verbose statement. In solution 1, the input buf
> > has to be different. In solution 2, we just can't do that, because the
> > buffer is implicitly shared. What do you think about solution 2?
>
> There is only one verbose() with two reg_type_str[] right now.
> It can easily be split into two verbose().
>
> > >
> > > If that doesn't work out we can try:
> > > s/verbose(,"%s", reg_type_str[])
> > > /verbose(, "%s%s", reg_type_str(), reg_type_flags_str())
> >
> > This is probably more cumbersome IMHO.
> >
> > Thinking about the implementation of reg_type_flags_str(). Because
> > flags can be combined, I think it would be better to format a dynamic
> > buffer, then we are back to the same problem: caller needs to pass a
> > buffer. Of course, with only two flags right now, we could enumerate
> > all flag combinations and map them to const strings.
>
> Yeah. With 3 or more flags that can be combined the const char approach
> wouldn't scale. So let's try 'env' approach?
>
> The only tweak is that 'log' would be better than 'env'.
> That temp buf can be in struct bpf_verifier_log *log.

Another idea would be to add bpf specific modifiers in
pointer() in lib/vsprintf.c for verifier's reg_state, reg_type,
and other bpf structs.
It might make print_verifier_state() much cleaner and
would allow easy printing of reg state from anywhere inside
the verifier code.
Currently the error print has minimal info. Like:
  verbose(env, "R%d invalid %s access off=%d size=%d\n",
          regno, reg_type_str[reg->type], off, size);
With vsnprintf support we could do something like:
  verbose(env, "%Brp invalid access off=%d size=%d\n",
          reg, off, size);
and pointer() will do full print of struct bpf_reg_state.

This is probably something to consider long term.
