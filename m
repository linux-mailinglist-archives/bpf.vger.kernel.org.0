Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6DD46B2BB
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 07:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbhLGGMj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 01:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhLGGMj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 01:12:39 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC8C061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 22:09:09 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id j2so37877294ybg.9
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 22:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fltir+cu7pO7LA36Kn+gIgw79IL838rsGzTGlIMEyfs=;
        b=RgqwyA6w1huCEPRc0x6MbnaLVaEelLgNY2lsU3+0FZJmR/oZDpVnWTdirJddAU/Gbf
         dMAsNSE4ANVbNG3V4GIPJW6o98VV5PwWOvnQYxReNj8owar/jXT1QrqcW43+e6RjSElL
         UZo5oGh4d+uUw+5ZxXjor8OTGTGusuZI07zNpgb5gfvnL78wFQC7IT7X7QU54G5+U+Cy
         knQ/NcsC278VtiZ/evtTtXQuetEhEdgRIT5AHdJp1Jp6tPlgU9kLU/26LTKO+i+Qwi/X
         zKhcdwed9X7TdW0+eXntjlWMtsEAd6cRA8mM/APZc4dWOuLJWfS1X2tCz9oUFk4ipr4f
         rnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fltir+cu7pO7LA36Kn+gIgw79IL838rsGzTGlIMEyfs=;
        b=t9Vy4+xUewe54sl74xyUpQBPZOQ/xVhCO0++5sBseMj6C8yeX/OogRMY6UcJMWPWra
         qP0vgpDuPDaWDW47I7jhcOykADE5RWhlDPuqLji9YXqxFm0H3eVacrXFwNTjwaMpLwAx
         Nv235UuZRg8KcuVeWW0UsOT5yqchwSOzwBqgXwM+EUn9hjiHhk/NxFqQHE+X0YSvde9B
         l+tuvWaLDvsP/fGnMckNdMbiBsNorUVxezrjS/PyJAdm8j/Kt41VrifZjqpYajUQ0bD7
         l7eSjfY8Mb4HaSqnyfjtvcF/mEYfPNnmerFmUr6uK67w4NZhJ1JC4mQYcBxZilH0vTFX
         xhkQ==
X-Gm-Message-State: AOAM531OSv/J7LDy+p5T4yqazzB4Cgh5O23+xa7773n4ZwfzQBWyZZ4B
        +C+4SjzstMC/0qEyXSQQ2AWsXH0I8RCt/FjLDlQ=
X-Google-Smtp-Source: ABdhPJxUELhRvFOzGBsDppVyeFNfVS38Msi7JFl5hQgBIWxJine+EPsUU9+ZKtOFNR9Yx9t+NbCdjxM/cjMrvijArl8=
X-Received: by 2002:a25:54e:: with SMTP id 75mr46382724ybf.393.1638857348922;
 Mon, 06 Dec 2021 22:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-5-haoluo@google.com>
In-Reply-To: <20211206232227.3286237-5-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Dec 2021 22:08:57 -0800
Message-ID: <CAEf4BzaKp0XFQYMjSrUzEb5AGamurA85nGJQxegJLJQ+wiso1A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Replace PTR_TO_XXX_OR_NULL with
 PTR_TO_XXX | PTR_MAYBE_NULL
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

On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
>
> We have introduced a new type to make bpf_reg composable, by
> allocating bits in the type to represent flags.
>
> One of the flags is PTR_MAYBE_NULL which indicates a pointer
> may be NULL. This patch switches the qualified reg_types to
> use this flag. The reg_types changed in this patch include:
>
> 1. PTR_TO_MAP_VALUE_OR_NULL
> 2. PTR_TO_SOCKET_OR_NULL
> 3. PTR_TO_SOCK_COMMON_OR_NULL
> 4. PTR_TO_TCP_SOCK_OR_NULL
> 5. PTR_TO_BTF_ID_OR_NULL
> 6. PTR_TO_MEM_OR_NULL
> 7. PTR_TO_RDONLY_BUF_OR_NULL
> 8. PTR_TO_RDWR_BUF_OR_NULL
>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  drivers/net/ethernet/netronome/nfp/bpf/fw.h |   4 +-
>  include/linux/bpf.h                         |  16 +-
>  kernel/bpf/btf.c                            |   7 +-
>  kernel/bpf/map_iter.c                       |   4 +-
>  kernel/bpf/verifier.c                       | 278 ++++++++------------
>  net/core/bpf_sk_storage.c                   |   2 +-
>  net/core/sock_map.c                         |   2 +-
>  7 files changed, 126 insertions(+), 187 deletions(-)
>

[...]

> @@ -535,38 +520,35 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
>  }
>
>  /* string representation of 'enum bpf_reg_type' */
> -static const char * const reg_type_str[] = {
> -       [NOT_INIT]              = "?",
> -       [SCALAR_VALUE]          = "inv",
> -       [PTR_TO_CTX]            = "ctx",
> -       [CONST_PTR_TO_MAP]      = "map_ptr",
> -       [PTR_TO_MAP_VALUE]      = "map_value",
> -       [PTR_TO_MAP_VALUE_OR_NULL] = "map_value_or_null",
> -       [PTR_TO_STACK]          = "fp",
> -       [PTR_TO_PACKET]         = "pkt",
> -       [PTR_TO_PACKET_META]    = "pkt_meta",
> -       [PTR_TO_PACKET_END]     = "pkt_end",
> -       [PTR_TO_FLOW_KEYS]      = "flow_keys",
> -       [PTR_TO_SOCKET]         = "sock",
> -       [PTR_TO_SOCKET_OR_NULL] = "sock_or_null",
> -       [PTR_TO_SOCK_COMMON]    = "sock_common",
> -       [PTR_TO_SOCK_COMMON_OR_NULL] = "sock_common_or_null",
> -       [PTR_TO_TCP_SOCK]       = "tcp_sock",
> -       [PTR_TO_TCP_SOCK_OR_NULL] = "tcp_sock_or_null",
> -       [PTR_TO_TP_BUFFER]      = "tp_buffer",
> -       [PTR_TO_XDP_SOCK]       = "xdp_sock",
> -       [PTR_TO_BTF_ID]         = "ptr_",
> -       [PTR_TO_BTF_ID_OR_NULL] = "ptr_or_null_",
> -       [PTR_TO_PERCPU_BTF_ID]  = "percpu_ptr_",
> -       [PTR_TO_MEM]            = "mem",
> -       [PTR_TO_MEM_OR_NULL]    = "mem_or_null",
> -       [PTR_TO_RDONLY_BUF]     = "rdonly_buf",
> -       [PTR_TO_RDONLY_BUF_OR_NULL] = "rdonly_buf_or_null",
> -       [PTR_TO_RDWR_BUF]       = "rdwr_buf",
> -       [PTR_TO_RDWR_BUF_OR_NULL] = "rdwr_buf_or_null",
> -       [PTR_TO_FUNC]           = "func",
> -       [PTR_TO_MAP_KEY]        = "map_key",
> -};
> +static const char *reg_type_str(enum bpf_reg_type type)
> +{
> +       static const char * const str[] = {
> +               [NOT_INIT]              = "?",
> +               [SCALAR_VALUE]          = "inv",
> +               [PTR_TO_CTX]            = "ctx",
> +               [CONST_PTR_TO_MAP]      = "map_ptr",
> +               [PTR_TO_MAP_VALUE]      = "map_value",
> +               [PTR_TO_STACK]          = "fp",
> +               [PTR_TO_PACKET]         = "pkt",
> +               [PTR_TO_PACKET_META]    = "pkt_meta",
> +               [PTR_TO_PACKET_END]     = "pkt_end",
> +               [PTR_TO_FLOW_KEYS]      = "flow_keys",
> +               [PTR_TO_SOCKET]         = "sock",
> +               [PTR_TO_SOCK_COMMON]    = "sock_common",
> +               [PTR_TO_TCP_SOCK]       = "tcp_sock",
> +               [PTR_TO_TP_BUFFER]      = "tp_buffer",
> +               [PTR_TO_XDP_SOCK]       = "xdp_sock",
> +               [PTR_TO_BTF_ID]         = "ptr_",
> +               [PTR_TO_PERCPU_BTF_ID]  = "percpu_ptr_",
> +               [PTR_TO_MEM]            = "mem",
> +               [PTR_TO_RDONLY_BUF]     = "rdonly_buf",
> +               [PTR_TO_RDWR_BUF]       = "rdwr_buf",
> +               [PTR_TO_FUNC]           = "func",
> +               [PTR_TO_MAP_KEY]        = "map_key",
> +       };
> +
> +       return str[base_type(type)];

well... now we lose the "_or_null" part, that can be pretty important.
Same will happen with RDONLY flag, right?

What can we do about that?

> +}
>
>  static char slot_type_char[] = {
>         [STACK_INVALID] = '?',
> @@ -631,7 +613,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
>                         continue;
>                 verbose(env, " R%d", i);
>                 print_liveness(env, reg->live);
> -               verbose(env, "=%s", reg_type_str[t]);
> +               verbose(env, "=%s", reg_type_str(t));
>                 if (t == SCALAR_VALUE && reg->precise)
>                         verbose(env, "P");
>                 if ((t == SCALAR_VALUE || t == PTR_TO_STACK) &&

[...]

>         if (smin >= BPF_MAX_VAR_OFF || smin <= -BPF_MAX_VAR_OFF) {
>                 verbose(env, "value %lld makes %s pointer be out of bounds\n",
> -                       smin, reg_type_str[type]);
> +                       smin, reg_type_str(type));
>                 return false;
>         }
>
> @@ -7209,11 +7151,13 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>                 return -EACCES;
>         }
>
> -       switch (ptr_reg->type) {
> -       case PTR_TO_MAP_VALUE_OR_NULL:
> +       if (ptr_reg->type == PTR_TO_MAP_VALUE_OR_NULL) {
>                 verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",

the same message can be output for other pointer types, so instead of
special-casing, let's just combine them with more helpful message

> -                       dst, reg_type_str[ptr_reg->type]);
> +                       dst, reg_type_str(ptr_reg->type));
>                 return -EACCES;
> +       }
> +
> +       switch (base_type(ptr_reg->type)) {
>         case CONST_PTR_TO_MAP:
>                 /* smin_val represents the known value */
>                 if (known && smin_val == 0 && opcode == BPF_ADD)
> @@ -7221,14 +7165,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>                 fallthrough;
>         case PTR_TO_PACKET_END:
>         case PTR_TO_SOCKET:
> -       case PTR_TO_SOCKET_OR_NULL:
>         case PTR_TO_SOCK_COMMON:
> -       case PTR_TO_SOCK_COMMON_OR_NULL:
>         case PTR_TO_TCP_SOCK:
> -       case PTR_TO_TCP_SOCK_OR_NULL:
>         case PTR_TO_XDP_SOCK:
>                 verbose(env, "R%d pointer arithmetic on %s prohibited\n",
> -                       dst, reg_type_str[ptr_reg->type]);
> +                       dst, reg_type_str(ptr_reg->type));
>                 return -EACCES;
>         default:
>                 break;

[...]
