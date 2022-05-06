Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474FC51E277
	for <lists+bpf@lfdr.de>; Sat,  7 May 2022 01:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380258AbiEFWo4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 18:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444826AbiEFWo4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 18:44:56 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1583662128
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 15:41:12 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id s14so5670256ild.6
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYAUR0LJq2gy2Zv6fZtY8YXj1fLfL2yk8K2qM/5ZErA=;
        b=IMF5cgUersL4k0E717a1ubmlocwyt9yHLiMZ7AAc0Crrm6FfslaMW8G7DZKH3nNeED
         W5BC23j4bRqUQZstTnBtoDUwCGHVqKytnSRuVbcGqGeyrV8Grwnu2pG1cvDWg4GMLDyo
         n5GHxUtdvk/kdzAJ315a7r0MhNkOZIr7/LzuDptW4p7GGGcn9OT6yJZCX27elohLxwfD
         9zl/YIxnSPxuyEwMd38SfagXgAgQgx4JuHRfpTkDhfFcnOOnI27HM8TPQt0b16rUE541
         jeOLTjC5g2a5GPOKFUnNcy5d5QZJ4hsMp7z1VpND7farfojSKT9QKByEZUfpcMjSlCOB
         FYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYAUR0LJq2gy2Zv6fZtY8YXj1fLfL2yk8K2qM/5ZErA=;
        b=clitYwgedmjjHs7UT7Bi2Sb7kakbyQRjH71VvvDJTP/L5XCCyIylhTaN2A0rE83ESf
         rJ3t2r1t4HHu5JhDDZ/MCpVF5zrjdSaACNO2UraeyyF6OAkNIvIJpUdtzmBRK1ttTfcC
         wN9OMxOL9hoQ9/2MyGwrkA2JW/iHQjhvXjSfxDUi5n1XvYvCstAJmGF9LT/vRgYDaOvb
         Aaf4KWbLfhL1sIaSgFvYCapup9ixxkHsu0ozs2375dh/BRnl/3+9SvK2WPyB8IBZ27lf
         SQ6DOCi+WtO4NAIs/ZlHi5PRBIFrxJh0Ai810ixDX0H6MetVcK0/YMeuN5u2F5C1lS+b
         XztA==
X-Gm-Message-State: AOAM5318gT9Fk9eVXY3MVPEUZ+1Q5/iat6hU11iDvpiJLhaXl1e0Ky9m
        lO2XUCK5B9QPlCHnEAnFFo1Aw4vwiApVw91Y3XE=
X-Google-Smtp-Source: ABdhPJz8eHMfQY9Rsa7GMk1eB2LAgmbM/4xAvhMUVmuDzXncvEhzjf8GY5SwxSbO4aOGZJIHMqa0ktkBDcPQ15C3DoA=
X-Received: by 2002:a05:6e02:1c03:b0:2cf:2a1d:d99c with SMTP id
 l3-20020a056e021c0300b002cf2a1dd99cmr2125997ilh.98.1651876871520; Fri, 06 May
 2022 15:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com> <20220428211059.4065379-2-joannelkoong@gmail.com>
In-Reply-To: <20220428211059.4065379-2-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 May 2022 15:41:00 -0700
Message-ID: <CAEf4BzbXOm_ff0MbvDaZoTDztxxy=gabXckSdFTwSsGsaq06Cg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Add MEM_UNINIT as a bpf_type_flag
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
> Instead of having uninitialized versions of arguments as separate
> bpf_arg_types (eg ARG_PTR_TO_UNINIT_MEM as the uninitialized version
> of ARG_PTR_TO_MEM), we can instead use MEM_UNINIT as a bpf_type_flag
> modifier to denote that the argument is uninitialized.
>
> Doing so cleans up some of the logic in the verifier. We no longer
> need to do two checks against an argument type (eg "if
> (base_type(arg_type) == ARG_PTR_TO_MEM || base_type(arg_type) ==
> ARG_PTR_TO_UNINIT_MEM)"), since uninitialized and initialized
> versions of the same argument type will now share the same base type.
>
> In the near future, MEM_UNINIT will be used by dynptr helper functions
> as well.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

LGTM, see minor suggestion below

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h   | 17 +++++++++--------
>  kernel/bpf/helpers.c  |  4 ++--
>  kernel/bpf/verifier.c | 26 ++++++++------------------
>  3 files changed, 19 insertions(+), 28 deletions(-)
>

[...]

> @@ -6189,9 +6179,9 @@ static bool check_raw_mode_ok(const struct bpf_func_proto *fn)
>  static bool check_args_pair_invalid(enum bpf_arg_type arg_curr,
>                                     enum bpf_arg_type arg_next)
>  {
> -       return (arg_type_is_mem_ptr(arg_curr) &&
> +       return (base_type(arg_curr) == ARG_PTR_TO_MEM &&
>                 !arg_type_is_mem_size(arg_next)) ||
> -              (!arg_type_is_mem_ptr(arg_curr) &&
> +              (base_type(arg_curr) != ARG_PTR_TO_MEM &&
>                 arg_type_is_mem_size(arg_next));

trying to parse this check I realized that it can be written as !=
(basically it's a XOR, both conditions are either true or both are
false)

return (base_type(arg_curr) == ARG_PTR_TO_MEM) !=
arg_type_is_mem_size(arg_next);


>  }
>
> @@ -6203,7 +6193,7 @@ static bool check_arg_pair_ok(const struct bpf_func_proto *fn)
>          * helper function specification.
>          */
>         if (arg_type_is_mem_size(fn->arg1_type) ||
> -           arg_type_is_mem_ptr(fn->arg5_type)  ||
> +           base_type(fn->arg5_type) == ARG_PTR_TO_MEM ||
>             check_args_pair_invalid(fn->arg1_type, fn->arg2_type) ||
>             check_args_pair_invalid(fn->arg2_type, fn->arg3_type) ||
>             check_args_pair_invalid(fn->arg3_type, fn->arg4_type) ||
> --
> 2.30.2
>
