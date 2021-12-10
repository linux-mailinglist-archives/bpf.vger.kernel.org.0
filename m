Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03CB470B2A
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 20:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243676AbhLJUAa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 15:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbhLJUAY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 15:00:24 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16382C061746
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 11:56:49 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a2so9408135qtx.11
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 11:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJNTm+ZR2xejGrVOjpwy8O20J6IfWU+uCS3OBTgZvJ4=;
        b=GXna/rhd+IO3/XVEPaAL5Y+L0y+PJyGftHdylH7tAI78T4VnHF3W4y2wyDUu48jpCP
         CMj/Uy5nvEGlBGSuNEaNzhr4f4z1iy9TuNgaRJMii2j1lr1iWQ/yxZq0zEBcwfYI9A2k
         XOOZb6mHgrM0MQ3nTEK1vkoFK8gkUcksZK2MvwBmggJkSWrjPQiYv+CZzR6ijcT7R0YF
         Ibd1QQGAmaOLFGif9d9EBy0ZREgZtAo8EUz5+gXIscedHDYNyu/tey5FCLZbZPgB4m77
         dymE8HejOX2mreJtx4ur56DyKKADBh0gd9WoPnnmu9pUfg0PFYWETlI2BPHPVgGSeKYl
         6AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJNTm+ZR2xejGrVOjpwy8O20J6IfWU+uCS3OBTgZvJ4=;
        b=SnpOYNHrVBXHSQusyahtpYC1Lig8IGQj8TiadMiy1rU9GuegNA4I5/+unh23Hy1YPX
         2/j5ZXRjETjw3GnDxzUirktGBTMymVJd4JxVj21SYUpt90r0YA4R0pt0ikERPTR+rfZM
         KjWa5pMZ/UsgQrtJZApwS7QCILnLX88djWbYIK5XoX19Q4V4cEgLF837r3EAvu0uKLj0
         lulnNj3CeV/jmrHMG+AAFNGSrF1UPm2ODpQClwMWGd9p9CWnEKSSfmlRbkF6AcU+atRo
         NysbZXMALyWbcpWtXVp/IRf6kGAnxhboHHFOduH6LLC+ELXs393XM6ZXKPhvmLX66/oV
         IdNw==
X-Gm-Message-State: AOAM530dGpamrM4ddYND5lJf3GGt0iIEKciatpeXYc6M0XN4zZfIEDkh
        rXgYg3X7H7YU21K1UWXGVqVlzhNEUBYBGfU5NT5RPg==
X-Google-Smtp-Source: ABdhPJzh19o50qhnyPv1jZpLu8gSLxSZkToY65hTDclHYL16XGQvf5fW81ir/wFa3puuvsCY4MaIZGK2wiMWF5U7UKQ=
X-Received: by 2002:ac8:58d1:: with SMTP id u17mr29833494qta.137.1639166208002;
 Fri, 10 Dec 2021 11:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-5-haoluo@google.com>
 <CAEf4BzaKp0XFQYMjSrUzEb5AGamurA85nGJQxegJLJQ+wiso1A@mail.gmail.com>
 <CA+khW7gVp9bp0Q4OcqQxLW2ARL=6VjiOZu6f2vWOt4vvzj29UQ@mail.gmail.com>
 <CAEf4BzZ1-5Tbq5MXkJ=8REFGRFs5aXnT0aGbaQkWYKVo4vuqcA@mail.gmail.com> <CAADnVQJzq5j2WecExdzwG+oc8iTP3pSm5OXsmF5cLQvPKHNKeA@mail.gmail.com>
In-Reply-To: <CAADnVQJzq5j2WecExdzwG+oc8iTP3pSm5OXsmF5cLQvPKHNKeA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 10 Dec 2021 11:56:37 -0800
Message-ID: <CA+khW7igx04tBfvXrNqROi6zfaLsDS6umuEV79iKdzsC2SFvxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Replace PTR_TO_XXX_OR_NULL with
 PTR_TO_XXX | PTR_MAYBE_NULL
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, Dec 9, 2021 at 1:45 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 8, 2021 at 12:04 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > > > > +static const char *reg_type_str(enum bpf_reg_type type)
> > > > > +{
> > > > > +       static const char * const str[] = {
> > > > > +               [NOT_INIT]              = "?",
> > > > > +               [SCALAR_VALUE]          = "inv",
> > > > > +               [PTR_TO_CTX]            = "ctx",
> > > > > +               [CONST_PTR_TO_MAP]      = "map_ptr",
> > > > > +               [PTR_TO_MAP_VALUE]      = "map_value",
> > > > > +               [PTR_TO_STACK]          = "fp",
> > > > > +               [PTR_TO_PACKET]         = "pkt",
> > > > > +               [PTR_TO_PACKET_META]    = "pkt_meta",
> > > > > +               [PTR_TO_PACKET_END]     = "pkt_end",
> > > > > +               [PTR_TO_FLOW_KEYS]      = "flow_keys",
> > > > > +               [PTR_TO_SOCKET]         = "sock",
> > > > > +               [PTR_TO_SOCK_COMMON]    = "sock_common",
> > > > > +               [PTR_TO_TCP_SOCK]       = "tcp_sock",
> > > > > +               [PTR_TO_TP_BUFFER]      = "tp_buffer",
> > > > > +               [PTR_TO_XDP_SOCK]       = "xdp_sock",
> > > > > +               [PTR_TO_BTF_ID]         = "ptr_",
> > > > > +               [PTR_TO_PERCPU_BTF_ID]  = "percpu_ptr_",
> > > > > +               [PTR_TO_MEM]            = "mem",
> > > > > +               [PTR_TO_RDONLY_BUF]     = "rdonly_buf",
> > > > > +               [PTR_TO_RDWR_BUF]       = "rdwr_buf",
> > > > > +               [PTR_TO_FUNC]           = "func",
> > > > > +               [PTR_TO_MAP_KEY]        = "map_key",
> > > > > +       };
> > > > > +
> > > > > +       return str[base_type(type)];
> > > >
> > > > well... now we lose the "_or_null" part, that can be pretty important.
> > > > Same will happen with RDONLY flag, right?
> > > >
> > > > What can we do about that?
> > > >
> > >
> > > We can format the string into a global buffer and return the buffer to
> > > the caller. A little overhead on string formatting.
> >
> > Can't use global buffer, because multiple BPF verifications can
> > proceed at the same time.
>
> I think reg_type_str() can still return a const char string
> with flags.
> It's not going to be a direct str[base_type(type)]; of course.
> The str[] would be different.

Sorry I didn't fully grasp this comment. Following is my understanding
and thoughts so far. Let me know if I missed anything.

Right, we can return a char string, but the string must be provided by
the caller, which is the annoying part. We could do something as
following (solution 1)

const char *reg_type_str(..., char *buf)
{
  ...
  snprintf(buf, ...);
  return buf;
}

OR, (solution 2) we may embed a buffer in bpf_verifier_env and pass
env into reg_type_str(). reg_type_str() just returns the buffer in
env. This doesn't require the caller to prepare the buffer.

const char *reg_type_str(..., env)
{
  ...
  snprintf(env->buf, ...);
  return env->buf;
}

However, there will be a caveat when there are more than one
reg_type_str in one verbose statement. In solution 1, the input buf
has to be different. In solution 2, we just can't do that, because the
buffer is implicitly shared. What do you think about solution 2?

>
> If that doesn't work out we can try:
> s/verbose(,"%s", reg_type_str[])
> /verbose(, "%s%s", reg_type_str(), reg_type_flags_str())

This is probably more cumbersome IMHO.

Thinking about the implementation of reg_type_flags_str(). Because
flags can be combined, I think it would be better to format a dynamic
buffer, then we are back to the same problem: caller needs to pass a
buffer. Of course, with only two flags right now, we could enumerate
all flag combinations and map them to const strings.
