Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B8846CB98
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 04:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243926AbhLHDk7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 22:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbhLHDk6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 22:40:58 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483CAC061574
        for <bpf@vger.kernel.org>; Tue,  7 Dec 2021 19:37:27 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id m192so917781qke.2
        for <bpf@vger.kernel.org>; Tue, 07 Dec 2021 19:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+T5tnMMzny8M2Z2GFHTmsCM2OO0l2hTsh0026QwgrVk=;
        b=psRxRx+wuXpu1ZK2biJNTruFuXJLEtyZAXZi32dQY8Ms/gX+f+lvu03BEyignw80fV
         b3Ue29aEnWHRjY/fxbgHb0roEEL4hwRRqRPkQ9OURegCJ+xlMiP6i6vADH/v1Nl6bpEa
         ex9EEQKn3XtzxKLmCzqPBlqN29nWpEw/LkduwjL0apeUTJhEiu76IKulZs+x5Wl/CXHu
         lZQzH4c6vqPtjXsu5ijxyv7yejzoupr2FAH3/QOwqwBY/JTc4vTZ2uP7QhqD09dBH7yy
         yLX1C/Qg0i9FuPbshb6xxGzCv5x7lkrKfM5QETIV6AsnZb48/9Xd0QEUMQrEm4E7JxED
         7F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+T5tnMMzny8M2Z2GFHTmsCM2OO0l2hTsh0026QwgrVk=;
        b=cY2XdKeWuMqT9xHQSxDHuYON1Q/skETvjIEql6LEJ5u7O6/OGZojVJOSQGFsxu96e/
         2Ozj/LFY0vSRenfhYKVbqiArte/RCZCMyu77yQQA/SoFXkbyMkKeYsj2UzlUcIcmxr+g
         yIuwdhMzF1QP0dorsasjPRTev5KMoCyH2TgC/MXawxW/pSkdWMTVFP2O2Y9EB7REWDvT
         KW+ceXJeehrBDu4Z8T8tivQeIxersenxbVbCfr+vrGpIDWNy0LJcINn5Dk3mf/4aNo3a
         H27S+dms8j3OcYveSSXDPvxsPcFqZn4apCtTco6CHiEWMmFrE1dO+htBTcE1Mh9DxFpC
         bJ6A==
X-Gm-Message-State: AOAM533NOgLQlnLbk0OKaFzJnCP7ybnDOPz/qPHdJnvYa89qpgC65tLI
        LNSQHZzOP+Nzj3ZkUF2dcRC28h4Eu1titT7JLZMaEw==
X-Google-Smtp-Source: ABdhPJywcDYQ8CWajL3t8S02RvQue5UZRXRplogsSGngrekjVKh3s4v9WZeTO+C/3MOb2KNTbnOUflvDGSkQvSNGdZo=
X-Received: by 2002:a05:620a:454d:: with SMTP id u13mr3752062qkp.221.1638934646176;
 Tue, 07 Dec 2021 19:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-5-haoluo@google.com>
 <CAEf4BzaKp0XFQYMjSrUzEb5AGamurA85nGJQxegJLJQ+wiso1A@mail.gmail.com>
In-Reply-To: <CAEf4BzaKp0XFQYMjSrUzEb5AGamurA85nGJQxegJLJQ+wiso1A@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 7 Dec 2021 19:37:15 -0800
Message-ID: <CA+khW7gVp9bp0Q4OcqQxLW2ARL=6VjiOZu6f2vWOt4vvzj29UQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Replace PTR_TO_XXX_OR_NULL with
 PTR_TO_XXX | PTR_MAYBE_NULL
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

On Mon, Dec 6, 2021 at 10:09 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
> >
> > We have introduced a new type to make bpf_reg composable, by
> > allocating bits in the type to represent flags.
> >
> > One of the flags is PTR_MAYBE_NULL which indicates a pointer
> > may be NULL. This patch switches the qualified reg_types to
> > use this flag. The reg_types changed in this patch include:
> >
> > 1. PTR_TO_MAP_VALUE_OR_NULL
> > 2. PTR_TO_SOCKET_OR_NULL
> > 3. PTR_TO_SOCK_COMMON_OR_NULL
> > 4. PTR_TO_TCP_SOCK_OR_NULL
> > 5. PTR_TO_BTF_ID_OR_NULL
> > 6. PTR_TO_MEM_OR_NULL
> > 7. PTR_TO_RDONLY_BUF_OR_NULL
> > 8. PTR_TO_RDWR_BUF_OR_NULL
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  drivers/net/ethernet/netronome/nfp/bpf/fw.h |   4 +-
> >  include/linux/bpf.h                         |  16 +-
> >  kernel/bpf/btf.c                            |   7 +-
> >  kernel/bpf/map_iter.c                       |   4 +-
> >  kernel/bpf/verifier.c                       | 278 ++++++++------------
> >  net/core/bpf_sk_storage.c                   |   2 +-
> >  net/core/sock_map.c                         |   2 +-
> >  7 files changed, 126 insertions(+), 187 deletions(-)
> >
>
> [...]
>
> > @@ -535,38 +520,35 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
> >  }
> >
> >  /* string representation of 'enum bpf_reg_type' */
> > -static const char * const reg_type_str[] = {
> > -       [NOT_INIT]              = "?",
> > -       [SCALAR_VALUE]          = "inv",
> > -       [PTR_TO_CTX]            = "ctx",
> > -       [CONST_PTR_TO_MAP]      = "map_ptr",
> > -       [PTR_TO_MAP_VALUE]      = "map_value",
> > -       [PTR_TO_MAP_VALUE_OR_NULL] = "map_value_or_null",
> > -       [PTR_TO_STACK]          = "fp",
> > -       [PTR_TO_PACKET]         = "pkt",
> > -       [PTR_TO_PACKET_META]    = "pkt_meta",
> > -       [PTR_TO_PACKET_END]     = "pkt_end",
> > -       [PTR_TO_FLOW_KEYS]      = "flow_keys",
> > -       [PTR_TO_SOCKET]         = "sock",
> > -       [PTR_TO_SOCKET_OR_NULL] = "sock_or_null",
> > -       [PTR_TO_SOCK_COMMON]    = "sock_common",
> > -       [PTR_TO_SOCK_COMMON_OR_NULL] = "sock_common_or_null",
> > -       [PTR_TO_TCP_SOCK]       = "tcp_sock",
> > -       [PTR_TO_TCP_SOCK_OR_NULL] = "tcp_sock_or_null",
> > -       [PTR_TO_TP_BUFFER]      = "tp_buffer",
> > -       [PTR_TO_XDP_SOCK]       = "xdp_sock",
> > -       [PTR_TO_BTF_ID]         = "ptr_",
> > -       [PTR_TO_BTF_ID_OR_NULL] = "ptr_or_null_",
> > -       [PTR_TO_PERCPU_BTF_ID]  = "percpu_ptr_",
> > -       [PTR_TO_MEM]            = "mem",
> > -       [PTR_TO_MEM_OR_NULL]    = "mem_or_null",
> > -       [PTR_TO_RDONLY_BUF]     = "rdonly_buf",
> > -       [PTR_TO_RDONLY_BUF_OR_NULL] = "rdonly_buf_or_null",
> > -       [PTR_TO_RDWR_BUF]       = "rdwr_buf",
> > -       [PTR_TO_RDWR_BUF_OR_NULL] = "rdwr_buf_or_null",
> > -       [PTR_TO_FUNC]           = "func",
> > -       [PTR_TO_MAP_KEY]        = "map_key",
> > -};
> > +static const char *reg_type_str(enum bpf_reg_type type)
> > +{
> > +       static const char * const str[] = {
> > +               [NOT_INIT]              = "?",
> > +               [SCALAR_VALUE]          = "inv",
> > +               [PTR_TO_CTX]            = "ctx",
> > +               [CONST_PTR_TO_MAP]      = "map_ptr",
> > +               [PTR_TO_MAP_VALUE]      = "map_value",
> > +               [PTR_TO_STACK]          = "fp",
> > +               [PTR_TO_PACKET]         = "pkt",
> > +               [PTR_TO_PACKET_META]    = "pkt_meta",
> > +               [PTR_TO_PACKET_END]     = "pkt_end",
> > +               [PTR_TO_FLOW_KEYS]      = "flow_keys",
> > +               [PTR_TO_SOCKET]         = "sock",
> > +               [PTR_TO_SOCK_COMMON]    = "sock_common",
> > +               [PTR_TO_TCP_SOCK]       = "tcp_sock",
> > +               [PTR_TO_TP_BUFFER]      = "tp_buffer",
> > +               [PTR_TO_XDP_SOCK]       = "xdp_sock",
> > +               [PTR_TO_BTF_ID]         = "ptr_",
> > +               [PTR_TO_PERCPU_BTF_ID]  = "percpu_ptr_",
> > +               [PTR_TO_MEM]            = "mem",
> > +               [PTR_TO_RDONLY_BUF]     = "rdonly_buf",
> > +               [PTR_TO_RDWR_BUF]       = "rdwr_buf",
> > +               [PTR_TO_FUNC]           = "func",
> > +               [PTR_TO_MAP_KEY]        = "map_key",
> > +       };
> > +
> > +       return str[base_type(type)];
>
> well... now we lose the "_or_null" part, that can be pretty important.
> Same will happen with RDONLY flag, right?
>
> What can we do about that?
>

We can format the string into a global buffer and return the buffer to
the caller. A little overhead on string formatting.

I assume there is already synchronization around the verifier to
prevent race on the buffer. If not, we have to ask the caller of
reg_type_str() to pass in a buffer.

> > +}
> >
> >  static char slot_type_char[] = {
> >         [STACK_INVALID] = '?',
> > @@ -631,7 +613,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
> >                         continue;
> >                 verbose(env, " R%d", i);
> >                 print_liveness(env, reg->live);
> > -               verbose(env, "=%s", reg_type_str[t]);
> > +               verbose(env, "=%s", reg_type_str(t));
> >                 if (t == SCALAR_VALUE && reg->precise)
> >                         verbose(env, "P");
> >                 if ((t == SCALAR_VALUE || t == PTR_TO_STACK) &&
>
> [...]
>
> >         if (smin >= BPF_MAX_VAR_OFF || smin <= -BPF_MAX_VAR_OFF) {
> >                 verbose(env, "value %lld makes %s pointer be out of bounds\n",
> > -                       smin, reg_type_str[type]);
> > +                       smin, reg_type_str(type));
> >                 return false;
> >         }
> >
> > @@ -7209,11 +7151,13 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
> >                 return -EACCES;
> >         }
> >
> > -       switch (ptr_reg->type) {
> > -       case PTR_TO_MAP_VALUE_OR_NULL:
> > +       if (ptr_reg->type == PTR_TO_MAP_VALUE_OR_NULL) {
> >                 verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
>
> the same message can be output for other pointer types, so instead of
> special-casing, let's just combine them with more helpful message
>

Ok. Just want to confirm my understanding, do you mean checking for
NULL? Like the following replacement:

- if (ptr_reg->type == PTR_TO_MAP_VALUE_OR_NULL) {
+ if (ptr_reg->type & PTR_MAYBE_NULL) {

> > -                       dst, reg_type_str[ptr_reg->type]);
> > +                       dst, reg_type_str(ptr_reg->type));
> >                 return -EACCES;
> > +       }
> > +
> > +       switch (base_type(ptr_reg->type)) {
> >         case CONST_PTR_TO_MAP:
> >                 /* smin_val represents the known value */
> >                 if (known && smin_val == 0 && opcode == BPF_ADD)
> > @@ -7221,14 +7165,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
> >                 fallthrough;
> >         case PTR_TO_PACKET_END:
> >         case PTR_TO_SOCKET:
> > -       case PTR_TO_SOCKET_OR_NULL:
> >         case PTR_TO_SOCK_COMMON:
> > -       case PTR_TO_SOCK_COMMON_OR_NULL:
> >         case PTR_TO_TCP_SOCK:
> > -       case PTR_TO_TCP_SOCK_OR_NULL:
> >         case PTR_TO_XDP_SOCK:
> >                 verbose(env, "R%d pointer arithmetic on %s prohibited\n",
> > -                       dst, reg_type_str[ptr_reg->type]);
> > +                       dst, reg_type_str(ptr_reg->type));
> >                 return -EACCES;
> >         default:
> >                 break;
>
> [...]
