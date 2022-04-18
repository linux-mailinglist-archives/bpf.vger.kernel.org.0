Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD6505C8A
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 18:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbiDRQnx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 12:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiDRQnv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 12:43:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB091CFC5
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 09:41:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b21so25009885lfb.5
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKbRgzdnNtBNZEEmLvpdHjqTR84K5/skgEHujfW+PYk=;
        b=objcO3WqHt+98Gs4Q3nczbJBTwFDskQK/obUzQSfSkNda/sTYMULm8zjZPd8weE878
         qRXO5HJOlXPKwMgcnaag0g3oIyLLfUU6u3OU0xVk/So93jb1SxQbbYkJ2bTAodwOIOJx
         QdhhLCaJFOfkAeMi286abtm0c0LrfTAeywC68KM+IJZfF46pmFVMArNQut4bLVjz6WpU
         qtbWkuFSmGhkqxPJvkD0v73M1mifuuqUE5YpBVC44nz53SsBAfzvqlOL8pHsYcoJ8XQX
         kip0bVwNu5lSRONzMlZHdeFPSd//xHGfheWsuH5eFk7wbUI2RIMQc2ukUnGgyxn3IwKz
         n5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKbRgzdnNtBNZEEmLvpdHjqTR84K5/skgEHujfW+PYk=;
        b=MG6s0pp60mG8int7zF6UQsgGaI2nBR6d0cMdoY0vb/7n24tSl3cW5H5m8ycojKw7cl
         SIUz0v6peeT06KzWtOBuO4QbqcaGQVIZANZ5cYeC7PuaL1akKEtpqh0URK1jC+ntydUU
         aGiUA7APW52ifX/uw+p9+xwgsm0AbNP97DzJ1Jq8qKASOuOA520P06oXh9ULp5nk0fXW
         KTN/Ym/ce+DplwCsTbUlYfQggKnubkPGrk3VhCc5Pd8XkjXyi+5IO+eKe3jMQOvrHGUP
         pAsiVAD8ZdNVM+kIOE493cBdBzNYGz8Rtuj6SWgdaqu8acDF17dL9mbBSmkmsKHoOOGB
         dEmA==
X-Gm-Message-State: AOAM532k7rLbZPDwTl0PXta2F3fHpv5sqeFhzSeT+5FlO3+6ZGfPDlY5
        nxvSKO9VNadSoIJ87ZfZjxspIuAq31Mp2LkE3DQ=
X-Google-Smtp-Source: ABdhPJxlQLA9rISGZ40WsMxOFNJvYGfxnGk3bwe7H34eVBGP20OP+3l0xY4rEkqA73ITj8bnroszqdjcM0S84wcf83k=
X-Received: by 2002:a05:6512:a95:b0:471:a03f:fd3f with SMTP id
 m21-20020a0565120a9500b00471a03ffd3fmr1838397lfu.437.1650300069711; Mon, 18
 Apr 2022 09:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416081341.23istudnhlrwjztb@apollo.legion> <20220416081921.mn56boji5yrvgfdh@apollo.legion>
In-Reply-To: <20220416081921.mn56boji5yrvgfdh@apollo.legion>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 18 Apr 2022 09:40:58 -0700
Message-ID: <CAJnrk1bEpUTzDmLVM0coFyO6zS6+qbA=3pSxA9o3k1U8f9daNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/7] Dynamic pointers
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
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

On Sat, Apr 16, 2022 at 1:19 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, Apr 16, 2022 at 01:43:41PM IST, Kumar Kartikeya Dwivedi wrote:
> > On Sat, Apr 16, 2022 at 12:04:22PM IST, Joanne Koong wrote:
> > > This patchset implements the basics of dynamic pointers in bpf.
> > >
> > > A dynamic pointer (struct bpf_dynptr) is a pointer that stores extra metadata
> > > alongside the address it points to. This abstraction is useful in bpf, given
> > > that every memory access in a bpf program must be safe. The verifier and bpf
> > > helper functions can use the metadata to enforce safety guarantees for things
> > > such as dynamically sized strings and kernel heap allocations.
> > >
> > > From the program side, the bpf_dynptr is an opaque struct and the verifier
> > > will enforce that its contents are never written to by the program.
> > > It can only be written to through specific bpf helper functions.
> > >
> > > There are several uses cases for dynamic pointers in bpf programs. A list of
> > > some are: dynamically sized ringbuf reservations without any extra memcpys,
> > > dynamic string parsing and memory comparisons, dynamic memory allocations that
> > > can be persisted in a map, and dynamic parsing of sk_buff and xdp_md packet
> > > data.
> > >
> > > At a high-level, the patches are as follows:
> > > 1/7 - Adds MEM_UNINIT as a bpf_type_flag
> > > 2/7 - Adds MEM_RELEASE as a bpf_type_flag
> > > 3/7 - Adds bpf_dynptr_from_mem, bpf_dynptr_alloc, and bpf_dynptr_put
> > > 4/7 - Adds bpf_dynptr_read and bpf_dynptr_write
> > > 5/7 - Adds dynptr data slices (ptr to underlying dynptr memory)
> > > 6/7 - Adds dynptr support for ring buffers
> > > 7/7 - Tests to check that verifier rejects certain fail cases and passes
> > > certain success cases
> > >
> > > This is the first dynptr patchset in a larger series. The next series of
> > > patches will add persisting dynamic memory allocations in maps, parsing packet
> > > data through dynptrs, dynptrs to referenced objects, convenience helpers for
> > > using dynptrs as iterators, and more helper functions for interacting with
> > > strings and memory dynamically.
> > >
> >
> > test_verifier has 5 failed tests, the following diff fixes them (three for
> > changed verifier error string, and two because we missed to do offset checks for
> > ARG_PTR_TO_ALLOC_MEM in check_func_arg_reg_off). Since this is all, I guess you
> > can wait for the review to complete for this version before respinning.
> >
>
> Ugh, hit send too early.
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bf64946ced84..24e5d494d991 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5681,7 +5681,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>                 /* Some of the argument types nevertheless require a
>                  * zero register offset.
>                  */
> -               if (arg_type != ARG_PTR_TO_ALLOC_MEM)
> +               if (base_type(arg_type) != ARG_PTR_TO_ALLOC_MEM)
>                         return 0;
>                 break;
>         /* All the rest must be rejected, except PTR_TO_BTF_ID which allows
> diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> index fbd682520e47..f1ad3b3cc145 100644
> --- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
> +++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> @@ -796,7 +796,7 @@
>         },
>         .prog_type = BPF_PROG_TYPE_SCHED_CLS,
>         .result = REJECT,
> -       .errstr = "reference has not been acquired before",
> +       .errstr = "arg 1 is an unacquired reference",
>  },
>  {
>         /* !bpf_sk_fullsock(sk) is checked but !bpf_tcp_sock(sk) is not checked */
> diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/selftests/bpf/verifier/sock.c
> index 86b24cad27a7..055a61205906 100644
> --- a/tools/testing/selftests/bpf/verifier/sock.c
> +++ b/tools/testing/selftests/bpf/verifier/sock.c
> @@ -417,7 +417,7 @@
>         },
>         .prog_type = BPF_PROG_TYPE_SCHED_CLS,
>         .result = REJECT,
> -       .errstr = "reference has not been acquired before",
> +       .errstr = "arg 1 is an unacquired reference",
>  },
>  {
>         "bpf_sk_release(bpf_sk_fullsock(skb->sk))",
> @@ -436,7 +436,7 @@
>         },
>         .prog_type = BPF_PROG_TYPE_SCHED_CLS,
>         .result = REJECT,
> -       .errstr = "reference has not been acquired before",
> +       .errstr = "arg 1 is an unacquired reference",
>  },
>  {
>         "bpf_sk_release(bpf_tcp_sock(skb->sk))",
> @@ -455,7 +455,7 @@
>         },
>         .prog_type = BPF_PROG_TYPE_SCHED_CLS,
>         .result = REJECT,
> -       .errstr = "reference has not been acquired before",
> +       .errstr = "arg 1 is an unacquired reference",
>  },
>  {
>         "sk_storage_get(map, skb->sk, NULL, 0): value == NULL",
>
> > [...]
Awesome, thanks for noting this Kumar! I'll make sure to locally run
the verifier tests before I submit the next iteration of it upstream
>
> --
> Kartikeya
