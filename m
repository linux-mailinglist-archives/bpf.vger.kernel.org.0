Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF7647815A
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhLQAcy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhLQAcx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 19:32:53 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4C5C061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:53 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id jo22so848307qvb.13
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Y++D374UBp+KZGXf7nEYXHbKyzAcpGkU19cgP9RR9g=;
        b=QjlFkg+dVVLiYeAac678OTkP1knrtmpzm4zlSy/52ru1i6vFcRoSH78xeRrpbO9hA/
         8h5ujSOcXLcZ1k5wQplKgQibPPyygxFcBlEZ6oQrp3y0KK/4ppbW5BN53Bd8jkkb0yZX
         Miqaif0jjWEXVZ8rDrOpOIyrGO7yh+XNKPVCFRCjidTxpAiMAKhXjv19p1K5Rzt/wVhX
         luBe4BcUf9G9l9OdrjUhkMETD4VFrp7uc+0J3OOCDu1ji0vA3fe0J+vbkKFKbkkEQZs+
         lAiHs9AqVkNtUDmNUc42noui/AfdqcXhgZ54xRtmA/GeENVTqHxi8S0mrVqPQwtYzbiP
         ws/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Y++D374UBp+KZGXf7nEYXHbKyzAcpGkU19cgP9RR9g=;
        b=22i4N3r4x1n+6uVpvleK8ZcUOA2tCsdhxMIIZeWxLHiveVbRcv1+SMVtePVx6tk630
         vqPFEhXIUfSQXm5/mNi2zWea0dq2CqCWKzc3t5d/opgQ6Ecw/hMZ6o0SHtoDzkf9dSWA
         8d+Kisclf9hf9G3ZBwRunlvLyx5+8F9FhJLRSfmoqbbIPVYhsRHhTNabju9miU59dE2a
         EsuxTed49n3ajnhmT1FEVSy2oor+9UmtTkIH7ifk2fDaFLS30QhM86qOoHAh3cYGH8jt
         GY6KbfcYcEbRfgNI82Rf6y27bTsgZBtgFIWbMrBOdHqUcXxsHTj7FeHiIvRhBAAHi5mV
         6aig==
X-Gm-Message-State: AOAM531W8/VU9wTalvsYTD/Hj7xh/vFA1g4H2JzdosIPJf0UHlJbMPsY
        NzzJpWwzyJ+tj5z2h5wuo9gkU3MlBOnxjA8R0hhtCQ==
X-Google-Smtp-Source: ABdhPJy5wS5/+URgoHZYBKCI/qKFKeNnjWckQyxKXwdvh8sqPcngohAMVMlYLDcb5emvcx8LmTgLt2EMVxoTUqMr+zo=
X-Received: by 2002:a05:6214:2a84:: with SMTP id jr4mr374658qvb.35.1639701172554;
 Thu, 16 Dec 2021 16:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-5-haoluo@google.com>
 <CAEf4BzaKp0XFQYMjSrUzEb5AGamurA85nGJQxegJLJQ+wiso1A@mail.gmail.com>
 <CA+khW7gVp9bp0Q4OcqQxLW2ARL=6VjiOZu6f2vWOt4vvzj29UQ@mail.gmail.com>
 <CAEf4BzZ1-5Tbq5MXkJ=8REFGRFs5aXnT0aGbaQkWYKVo4vuqcA@mail.gmail.com>
 <CAADnVQJzq5j2WecExdzwG+oc8iTP3pSm5OXsmF5cLQvPKHNKeA@mail.gmail.com>
 <CA+khW7igx04tBfvXrNqROi6zfaLsDS6umuEV79iKdzsC2SFvxg@mail.gmail.com>
 <CAADnVQLX-Ks-5+3RZJMcD-K9gakKhTn6k5qv0MkiFRG-5Muhkw@mail.gmail.com> <CAADnVQJTQ9f5V_-=kWa79ojvVLWFX2YLsRHLKOa9MZUB0gYa9A@mail.gmail.com>
In-Reply-To: <CAADnVQJTQ9f5V_-=kWa79ojvVLWFX2YLsRHLKOa9MZUB0gYa9A@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 16 Dec 2021 16:32:41 -0800
Message-ID: <CA+khW7gEsRcz7CVcb9BZ_-o2su+cE-wRu8om0EcNbEG_d0mPUg@mail.gmail.com>
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

On Sun, Dec 12, 2021 at 6:03 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Dec 12, 2021 at 5:51 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Dec 10, 2021 at 11:56 AM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Thu, Dec 9, 2021 at 1:45 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Dec 8, 2021 at 12:04 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > > > > +static const char *reg_type_str(enum bpf_reg_type type)
> > > > > > > > +{
> > > > > > > > +       static const char * const str[] = {
> > > > > > > > +               [NOT_INIT]              = "?",
> > > > > > > > +               [SCALAR_VALUE]          = "inv",
> > > > > > > > +               [PTR_TO_CTX]            = "ctx",
> > > > > > > > +               [CONST_PTR_TO_MAP]      = "map_ptr",
> > > > > > > > +               [PTR_TO_MAP_VALUE]      = "map_value",
> > > > > > > > +               [PTR_TO_STACK]          = "fp",
> > > > > > > > +               [PTR_TO_PACKET]         = "pkt",
> > > > > > > > +               [PTR_TO_PACKET_META]    = "pkt_meta",
> > > > > > > > +               [PTR_TO_PACKET_END]     = "pkt_end",
> > > > > > > > +               [PTR_TO_FLOW_KEYS]      = "flow_keys",
> > > > > > > > +               [PTR_TO_SOCKET]         = "sock",
> > > > > > > > +               [PTR_TO_SOCK_COMMON]    = "sock_common",
> > > > > > > > +               [PTR_TO_TCP_SOCK]       = "tcp_sock",
> > > > > > > > +               [PTR_TO_TP_BUFFER]      = "tp_buffer",
> > > > > > > > +               [PTR_TO_XDP_SOCK]       = "xdp_sock",
> > > > > > > > +               [PTR_TO_BTF_ID]         = "ptr_",
> > > > > > > > +               [PTR_TO_PERCPU_BTF_ID]  = "percpu_ptr_",
> > > > > > > > +               [PTR_TO_MEM]            = "mem",
> > > > > > > > +               [PTR_TO_RDONLY_BUF]     = "rdonly_buf",
> > > > > > > > +               [PTR_TO_RDWR_BUF]       = "rdwr_buf",
> > > > > > > > +               [PTR_TO_FUNC]           = "func",
> > > > > > > > +               [PTR_TO_MAP_KEY]        = "map_key",
> > > > > > > > +       };
> > > > > > > > +
> > > > > > > > +       return str[base_type(type)];
> > > > > > >
> > > > > > > well... now we lose the "_or_null" part, that can be pretty important.
> > > > > > > Same will happen with RDONLY flag, right?
> > > > > > >
> > > > > > > What can we do about that?
> > > > > > >
> > > > > >
> > > > > > We can format the string into a global buffer and return the buffer to
> > > > > > the caller. A little overhead on string formatting.
> > > > >
> > > > > Can't use global buffer, because multiple BPF verifications can
> > > > > proceed at the same time.
> > > >
> > > > I think reg_type_str() can still return a const char string
> > > > with flags.
> > > > It's not going to be a direct str[base_type(type)]; of course.
> > > > The str[] would be different.
> > >
> > > Sorry I didn't fully grasp this comment. Following is my understanding
> > > and thoughts so far. Let me know if I missed anything.
> >
> > I meant that for now we can do:
> >
> > static const char * const str[] = {
> >    [NOT_INIT]              = "?",
> >    [PTR_TO_RDONLY_BUF]     = "rdonly_buf",
> > };
> > switch(type) {
> >   case PTR_TO_RDONLY_BUF | MAYBE_NULL:return "rdonly_buf_or_null";
> >   default: return str[base_type(type)];
> > }
> >
> > > Right, we can return a char string, but the string must be provided by
> > > the caller, which is the annoying part. We could do something as
> > > following (solution 1)
> > >
> > > const char *reg_type_str(..., char *buf)
> > > {
> > >   ...
> > >   snprintf(buf, ...);
> > >   return buf;
> > > }
> > >
> > > OR, (solution 2) we may embed a buffer in bpf_verifier_env and pass
> > > env into reg_type_str(). reg_type_str() just returns the buffer in
> > > env. This doesn't require the caller to prepare the buffer.
> > >
> > > const char *reg_type_str(..., env)
> > > {
> > >   ...
> > >   snprintf(env->buf, ...);
> > >   return env->buf;
> > > }
> >
> > If we go with this approach then passing 'env' is a bit better,
> > since 'buf' doesn't need to be allocated on stack.
> >
> > > However, there will be a caveat when there are more than one
> > > reg_type_str in one verbose statement. In solution 1, the input buf
> > > has to be different. In solution 2, we just can't do that, because the
> > > buffer is implicitly shared. What do you think about solution 2?
> >
> > There is only one verbose() with two reg_type_str[] right now.
> > It can easily be split into two verbose().
> >
> > > >
> > > > If that doesn't work out we can try:
> > > > s/verbose(,"%s", reg_type_str[])
> > > > /verbose(, "%s%s", reg_type_str(), reg_type_flags_str())
> > >
> > > This is probably more cumbersome IMHO.
> > >
> > > Thinking about the implementation of reg_type_flags_str(). Because
> > > flags can be combined, I think it would be better to format a dynamic
> > > buffer, then we are back to the same problem: caller needs to pass a
> > > buffer. Of course, with only two flags right now, we could enumerate
> > > all flag combinations and map them to const strings.
> >
> > Yeah. With 3 or more flags that can be combined the const char approach
> > wouldn't scale. So let's try 'env' approach?
> >
> > The only tweak is that 'log' would be better than 'env'.
> > That temp buf can be in struct bpf_verifier_log *log.
>
> Another idea would be to add bpf specific modifiers in
> pointer() in lib/vsprintf.c for verifier's reg_state, reg_type,
> and other bpf structs.
> It might make print_verifier_state() much cleaner and
> would allow easy printing of reg state from anywhere inside
> the verifier code.
> Currently the error print has minimal info. Like:
>   verbose(env, "R%d invalid %s access off=%d size=%d\n",
>           regno, reg_type_str[reg->type], off, size);
> With vsnprintf support we could do something like:
>   verbose(env, "%Brp invalid access off=%d size=%d\n",
>           reg, off, size);
> and pointer() will do full print of struct bpf_reg_state.
>
> This is probably something to consider long term.

ACK. Thanks for the comments. The 'env' proposal looks reasonably
well. I sent out v2. Please take a look there.
