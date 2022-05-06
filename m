Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571EF51E29B
	for <lists+bpf@lfdr.de>; Sat,  7 May 2022 01:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbiEGABf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 20:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiEGABe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 20:01:34 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640A16A006
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 16:57:50 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e3so9701636ios.6
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 16:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnWUdFogkvI2JGqcq9Z8I1Xb9s6zZCN/L38XSf6iz40=;
        b=q7NJWBT9Im6tl9sDQ0l3s7yCFsWifmdd+lk+9ymIw3Dtn5wuDCknCsRBFeuw3L3a47
         8QDnm3zMfsH9MD22vnfXc5TnAyc0qsp3HrnZujFyN4BabgOfcbIQF8AaVO5cGlMj228c
         LBVq7IhRp2ZZ820VVsuQDjvDz4F32rLjwXTva44Ne7HWaCgN9ZjI7NAaWmxKMoONZNdq
         a/1LCz/zXu0AdmZH8GDRq95rpvGVgThnIxnCEAwqlWqv6ATKwJT/athMmXS6izEfvFo/
         kPwWaQ/xWBId8I1XnYUSr6xPnK8XQ5Vz8B08SY+XMF70tyafiiGTlKzfvh3rLT0tSNE6
         hrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnWUdFogkvI2JGqcq9Z8I1Xb9s6zZCN/L38XSf6iz40=;
        b=nwEYLbEey/eT6WRK+mroWTcdyY6JIw0fa2FGqJqsp6aSojeZK7Sy3/bGP8Sj1MrVRH
         uaTOhCTOuewsmv8NVq09HAPhms92VDZGuFJu90/uxVbiVAInhfBRPS9vOBfnftD96Pcw
         2WNz2UBGdpx7pvQ+pFttegFbzIRUCMAw7jNfElINQooTEX1xY/LVQLrRg0IvoxwsaFl8
         4UrwKDMiLyQXb1eMeIQHNJqX/Hz716fA/E/WHfE+uzgNepMGJPjWB07lvy3CiLfKt58O
         TN9QwHX3rOzehs+Y5B5aQk6gA3qxzjt78cL+J0epaqefx8bn6vG70vQQoOgaZMJkF/Xb
         V4ag==
X-Gm-Message-State: AOAM533PQaWmFXQ6nKkDrXeV2IfmsQ6G6xRDKFLwIKFUvekm4KrE4VMi
        aTLKJ3aYP4fuWedpArtQ1Zglrud+6/SHRpWNySI=
X-Google-Smtp-Source: ABdhPJyinejcszMEFMhlou5uHTmZaVv5ss3JPIJKaAZTeP+0PcvfxBlZeq7oJzbtUXHpxVQYTaDWm7sOKZ2hJWE1YHg=
X-Received: by 2002:a05:6638:533:b0:32a:d418:b77b with SMTP id
 j19-20020a056638053300b0032ad418b77bmr2507654jar.237.1651881469824; Fri, 06
 May 2022 16:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com> <20220428211059.4065379-6-joannelkoong@gmail.com>
In-Reply-To: <20220428211059.4065379-6-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 May 2022 16:57:39 -0700
Message-ID: <CAEf4BzY9eE1ud7RA4m6+kCGjNxhVsHo4uOQgrmbtS4C1i6Dv0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/6] bpf: Add dynptr data slices
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> This patch adds a new helper function
>
> void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len);
>
> which returns a pointer to the underlying data of a dynptr. *len*
> must be a statically known value. The bpf program may access the returned
> data slice as a normal buffer (eg can do direct reads and writes), since
> the verifier associates the length with the returned pointer, and
> enforces that no out of bounds accesses occur.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h            |  4 +++
>  include/uapi/linux/bpf.h       | 12 +++++++
>  kernel/bpf/helpers.c           | 28 +++++++++++++++
>  kernel/bpf/verifier.c          | 64 ++++++++++++++++++++++++++++++----
>  tools/include/uapi/linux/bpf.h | 12 +++++++
>  5 files changed, 114 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b276dbf942dd..4d2de868bdbc 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -397,6 +397,9 @@ enum bpf_type_flag {
>         /* DYNPTR points to a ringbuf record. */
>         DYNPTR_TYPE_RINGBUF     = BIT(9 + BPF_BASE_TYPE_BITS),
>
> +       /* MEM is memory owned by a dynptr */
> +       MEM_DYNPTR              = BIT(10 + BPF_BASE_TYPE_BITS),

do we need this yet another bit? It seems like it only matters for
verifier log dynptr_ output? Can we just reuse MEM_ALLOC? Or there is
some ringbuf-specific logic that we'll interfere with? If feels a bit
unnecessary, let's think if we can avoid adding bits just for this.

> +
>         __BPF_TYPE_LAST_FLAG    = DYNPTR_TYPE_RINGBUF,
>  };
>

[...]

> +               if (is_dynptr_ref_function(func_id)) {
> +                       int i;
> +
> +                       /* Find the id of the dynptr we're acquiring a reference to */
> +                       for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> +                               if (arg_type_is_dynptr(fn->arg_type[i])) {
> +                                       id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);

let's make sure that we have only one such argument?

> +                                       break;
> +                               }
> +                       }
> +                       if (unlikely(i == MAX_BPF_FUNC_REG_ARGS)) {

please don't use unlikely(), especially for non-performance critical code path

> +                               verbose(env, "verifier internal error: no dynptr args to a dynptr ref function");
> +                               return -EFAULT;
> +                       }
> +               } else {
> +                       id = acquire_reference_state(env, insn_idx);
> +                       if (id < 0)
> +                               return id;
> +               }

[...]
