Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83A268840
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 11:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgINJ0x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 05:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgINJ0v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 05:26:51 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D53C061788
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 02:26:30 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a3so17175667oib.4
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N9Z0JQMEyAoqtsNY4svQdmQ8E3d+AFCPv6YizfP/1Zc=;
        b=amhh8bNkxNCj5ZxTzmr8UAgLC+60cBzEjwwmvHCeTchYkCNgxgJHgsP558Vz1oMMDp
         NMLIhEPm1NiG2Iwt3KK0C1ZjImwKYMSalZVKlin2FTgYbvCKDGhOKgaTLwiN531PNTFJ
         QuUQIdYKPA//kVAqm36iamztAHkbFOta+WxuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9Z0JQMEyAoqtsNY4svQdmQ8E3d+AFCPv6YizfP/1Zc=;
        b=RTFoqW3Rj5LbFVW+jwAPAAnDziBJj9Pt7c7ssjqF8HLj8DyXVcwfqvNW+9AgQlhes/
         YhGlGEPiUHgPmiUIUahJgbXvdj/eanUU2030QhHMZ/4/79Z4YM3gsINmLcVN86ZyKFUP
         0DGXaAIvX01vh28dtA08cDnlmq3KUlBVMP9CCRxK1kQdhitSyxI/h4SKJziKPN1GUfqB
         n0CfDItT7hHnR2Uq8WgzIHlsMp55DjZireT04OY1QAp7wBR1wyvuNfj+rUrED+60BH7w
         HmNr7jIZXIZJSMfzC60egV+3zQyo3uhL6SPb0jPLD6HrVZxAC5CIJGugL6g+7pZWgaUh
         2hfA==
X-Gm-Message-State: AOAM533XXV6h3ObHpxCpTVXugif0lgUidWyF4vv3D5lJUoHYmTnzrnWF
        Qd+TKhZr1wKQZoTfeiceVaVwZX15Z8UVbX9e2JEdOQ==
X-Google-Smtp-Source: ABdhPJzwqYrmYOEIK6mWrnKDrf5U3Gp9aKPC2GbyggUrO2IOrQsJD/Y5OumwoCnXrItLYW2QvDEhU6bU8xvGxx8I04w=
X-Received: by 2002:aca:3087:: with SMTP id w129mr7719251oiw.102.1600075589751;
 Mon, 14 Sep 2020 02:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200912045917.2992578-1-kafai@fb.com> <20200912045930.2993219-1-kafai@fb.com>
In-Reply-To: <20200912045930.2993219-1-kafai@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 14 Sep 2020 10:26:18 +0100
Message-ID: <CACAyw9-rirpChioEaSKiYC5+fLGzL38OawcBvE8Mv+16vNApZA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/2] bpf: Enable bpf_skc_to_* sock casting
 helper to networking prog type
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 12 Sep 2020 at 05:59, Martin KaFai Lau <kafai@fb.com> wrote:
>
> There is a constant need to add more fields into the bpf_tcp_sock
> for the bpf programs running at tc, sock_ops...etc.
>
> A current workaround could be to use bpf_probe_read_kernel().  However,
> other than making another helper call for reading each field and missing
> CO-RE, it is also not as intuitive to use as directly reading
> "tp->lsndtime" for example.  While already having perfmon cap to do
> bpf_probe_read_kernel(), it will be much easier if the bpf prog can
> directly read from the tcp_sock.
>
> This patch tries to do that by using the existing casting-helpers
> bpf_skc_to_*() whose func_proto returns a btf_id.  For example, the
> func_proto of bpf_skc_to_tcp_sock returns the btf_id of the
> kernel "struct tcp_sock".
>
> [ One approach is to make a separate copy of the bpf_skc_to_*
>   func_proto and use ARG_PTR_TO_SOCK_COMMON instead of ARG_PTR_TO_BTF_ID.
>   More on this later (1). ]
>
> This patch modifies the existing bpf_skc_to_* func_proto to take
> ARG_PTR_TO_SOCK_COMMON instead of taking
> "ARG_PTR_TO_BTF_ID + &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON]".
> That will allow tc, sock_ops,...etc to call these casting helpers
> because they already hold the PTR_TO_SOCK_COMMON (or its
> equivalent).  For example:
>
>         sk = sock_ops->sk;
>         if (!sk)
>                 return;
>         tp = bpf_skc_to_tcp_sock(sk);
>         if (!tp)
>                 return;
>         /* Read tp as a PTR_TO_BTF_ID */
>         lsndtime = tp->lsndtime;
>
> To ensure the current bpf prog passing a PTR_TO_BTF_ID to
> bpf_skc_to_*() still works as is, the verifier is modified such that
> ARG_PTR_TO_SOCK_COMMON can accept a reg with reg->type == PTR_TO_BTF_ID
> and reg->btf_id is btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON]
>
> To do that, an idea is borrowed from one of the Lorenz's patch:
> https://lore.kernel.org/bpf/20200904112401.667645-12-lmb@cloudflare.com/ .
> It adds PTR_TO_BTF_ID as one of the acceptable reg->type for
> ARG_PTR_TO_SOCK_COMMON and also specifies what btf_id it can take.
> By doing this, the bpf_skc_to_* will work as before and can still
> take PTR_TO_BTF_ID as the arg.  e.g. The bpf tcp iter will work
> as is.
>
> This will also make other existing helper taking ARG_PTR_TO_SOCK_COMMON
> works with the pointer obtained from bpf_skc_to_*(). For example:

Unfortunately, I think that we need to introduce a new
ARG_PTR_TO_SOCK_COMMON_OR_NULL for this to work. This is because
dereferencing a "tracing" pointer can yield NULL at runtime due to a
page fault, so the helper has to deal with this. Other than that I
think this is a really nice approach: we can gradually move helpers to
PTR_TO_SOCK_COMMON_OR_NULL and in doing so make them compatible with
BTF pointers.

[...]

> @@ -4014,7 +4022,17 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 arg,
>
>  found:
>         if (type == PTR_TO_BTF_ID) {
> -               u32 *expected_btf_id = fn->arg_btf_id[arg];
> +               u32 *expected_btf_id;
> +
> +               if (arg_type == ARG_PTR_TO_BTF_ID) {
> +                       expected_btf_id = fn->arg_btf_id[arg];

Personal preference, but what do you think about moving this to after
the assignment of compatible?

    btf_id = compatible->btf_id;
    if (arg_type == ARG_PTR_TO_BTF_ID)
       btf_id = fn->fn->arg_btf_id[arg];

That makes it clearer that we have to special case ARG_PTR_TO_BTF_ID since
it doesn't make sense to use compatible->btf_id in that case.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
