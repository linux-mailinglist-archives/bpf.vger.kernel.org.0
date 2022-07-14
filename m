Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A81574519
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 08:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiGNGb1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 02:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiGNGb0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 02:31:26 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BB31E3C8
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 23:31:25 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v185so607669ioe.11
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 23:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=axbhI+vcnwCADXLORJOGRytQl2zO/ACfvqCc3ugTQ+0=;
        b=n+z4dT0967FC1By5q78s4oBwzraCN8aqTwOJNupbprGxFhLWkZOUT3zYpcLcmVqP8f
         fzWWeT3EYG1hgeMT8dpfSHpGzBiO+5Qa0nQgch7yitP+mRzLMqWelxs4GHZu79FjFewb
         chDbOqqbIjcyUDaJlxcwHBO+8tW05O1bXCiLW+79QqJIwjCJlqAYDnFXIpuxnoYsTjwC
         ylj9485txGmWcieg2z5dXPkzSx99cFNWhauU+NnpgI05D1iC+W6RNZhTaLFTyrJmZEUL
         95RQO847w6P2hMDBPiguGAE108KvLeQq+Veub6MijLz7ORvOkHgcojwgMvJd8eYrGoeX
         zbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axbhI+vcnwCADXLORJOGRytQl2zO/ACfvqCc3ugTQ+0=;
        b=mKNEzm0mRphcUdPCV9VFI5G9sFEaBzPbX8WFFHoOnA/c6w+cWnyG3rq2+UNGk0NUK8
         ch/Llvcnysn45SdmuxdAVySpZ22kCEkkbvxw55TK8KyAwzLyddH00Z9k2nOoE+OxYtbt
         7EGtyBAJoYnDyrOMs5VOJL5XDUcLW3FEwtA4oyLZDGa+vJI5KX54oSoV6r7PDAQ6BejV
         jF9j7CQet+iM2mNiln+AfRoAn7iNWuiEl8xFU3KWA1tEAL7+04DW233NR2TITarMVfVB
         zcsNK3F3AQ/DE3ZWv8dlB6MVUiS0b/7RVQs0HZX1GmflJ3NhfuAJoDBYwC9diUxmI9QS
         Aqbw==
X-Gm-Message-State: AJIora+S5u1C1BHu2mYfyphDXQqtcFRaxjUij7dwfFLC40wYz4I2XyV9
        uaD2VGwtM4MnuDNA3mJu00xyvTB3SXtx1iji0Vw=
X-Google-Smtp-Source: AGRyM1ueKdqAPGL6TNN0jwwoE2BK4wYWWpf/mLhhZ3bDJRLOIm9bpL6Rfi/aWBr8P5gxk/+Cb0fLrcJTCZAQpxPys+c=
X-Received: by 2002:a02:c4c3:0:b0:33f:4fb4:834b with SMTP id
 h3-20020a02c4c3000000b0033f4fb4834bmr4104624jaj.231.1657780284531; Wed, 13
 Jul 2022 23:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220713234529.4154673-1-davemarchevsky@fb.com>
In-Reply-To: <20220713234529.4154673-1-davemarchevsky@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 14 Jul 2022 08:30:48 +0200
Message-ID: <CAP01T74k86cwBk22M=YgY=Vao196_wDezvmHjk5u_Nry98A6hQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add kptr_xchg to may_be_acquire_function check
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, kafai@fb.com
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

On Thu, 14 Jul 2022 at 01:46, Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> The may_be_acquire_function check is a weaker version of
> is_acquire_function that only uses bpf_func_id to determine whether a
> func may be acquiring a reference. Most funcs which acquire a reference
> do so regardless of their input, so bpf_func_id is all that's necessary
> to make an accurate determination. However, map_lookup_elem only
> acquires when operating on certain MAP_TYPEs, so commit 64d85290d79c
> ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH") added the
> may_be check.
>
> Any helper which always acquires a reference should pass both
> may_be_acquire_function and is_acquire_function checks. Recently-added
> kptr_xchg passes the latter but not the former. This patch resolves this
> discrepancy and does some refactoring such that the list of functions
> which always acquire is in one place so future updates are in sync.
>

Thanks for the fix.
I actually didn't add this on purpose, because the reason for using
the may_be_acquire_function (in check_refcount_ok) doesn't apply to
kptr_xchg, but maybe that was a poor choice on my part. I'm actually
not sure of the need for may_be_acquire_function, and
check_refcount_ok.

Can we revisit why iit is needed? It only prevents
ARG_PTR_TO_SOCK_COMMON (which is not the only arg type that may be
refcounted) from being argument type of acquire functions. What is the
reason behind this? Should we rename arg_type_may_be_refcounted to a
less confusing name? It probably only applies to socket lookup
helpers.

> Fixes: c0a5a21c25f3 ("bpf: Allow storing referenced kptr in map")
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>
> Sent to bpf-next instead of bpf as kptr_xchg not passing
> may_be_acquire_function isn't currently breaking anything, just
> logically inconsistent.
>
>  kernel/bpf/verifier.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 26e7e787c20a..df4b923e77de 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -477,13 +477,30 @@ static bool type_may_be_null(u32 type)
>         return type & PTR_MAYBE_NULL;
>  }
>
> +/* These functions acquire a resource that must be later released
> + * regardless of their input
> + */
> +static bool __check_function_always_acquires(enum bpf_func_id func_id)
> +{
> +       switch (func_id) {
> +       case BPF_FUNC_sk_lookup_tcp:
> +       case BPF_FUNC_sk_lookup_udp:
> +       case BPF_FUNC_skc_lookup_tcp:
> +       case BPF_FUNC_ringbuf_reserve:
> +       case BPF_FUNC_kptr_xchg:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static bool may_be_acquire_function(enum bpf_func_id func_id)
>  {
> -       return func_id == BPF_FUNC_sk_lookup_tcp ||
> -               func_id == BPF_FUNC_sk_lookup_udp ||
> -               func_id == BPF_FUNC_skc_lookup_tcp ||
> -               func_id == BPF_FUNC_map_lookup_elem ||
> -               func_id == BPF_FUNC_ringbuf_reserve;
> +       /* See is_acquire_function for the conditions under which funcs
> +        * not in __check_function_always_acquires acquire a resource
> +        */
> +       return __check_function_always_acquires(func_id) ||
> +               func_id == BPF_FUNC_map_lookup_elem;
>  }
>
>  static bool is_acquire_function(enum bpf_func_id func_id,
> @@ -491,11 +508,7 @@ static bool is_acquire_function(enum bpf_func_id func_id,
>  {
>         enum bpf_map_type map_type = map ? map->map_type : BPF_MAP_TYPE_UNSPEC;
>
> -       if (func_id == BPF_FUNC_sk_lookup_tcp ||
> -           func_id == BPF_FUNC_sk_lookup_udp ||
> -           func_id == BPF_FUNC_skc_lookup_tcp ||
> -           func_id == BPF_FUNC_ringbuf_reserve ||
> -           func_id == BPF_FUNC_kptr_xchg)
> +       if (__check_function_always_acquires(func_id))
>                 return true;
>
>         if (func_id == BPF_FUNC_map_lookup_elem &&
> --
> 2.30.2
>
