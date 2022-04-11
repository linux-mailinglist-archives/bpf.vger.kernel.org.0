Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3ED4FC5C6
	for <lists+bpf@lfdr.de>; Mon, 11 Apr 2022 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiDKUbG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Apr 2022 16:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiDKUbE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Apr 2022 16:31:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AA835857
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 13:28:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u7so11592631lfs.8
        for <bpf@vger.kernel.org>; Mon, 11 Apr 2022 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7to7rdg8hgLB3yIWeW4mYll+ym182Rl0IniHRC9Bo9Q=;
        b=XAC5sMTQ1DHTEl2R1A6cmk9EwEgUTEHjmEzTXfpaG6DHdGh1hRqFSouHvaCRkPsoB8
         69nq7bPkhwPAPdWVt9YQReuHyL+hnv81cYQnqPGYI2UmwKvXbh7XLyskrQdJqaAw5z6J
         7o1czTMJHLG3QPDMVrndt+ld2geBtkqalS2zl+GRzRFMsKXdazQHo1OATxzKxIFC5fD/
         kzvjQJdxBb7V4wrYrwvpEylkp2mInTIb++lKHGfFit7KjJXHqygncmy+6WXWGmQJbBmH
         1uk0St1XvHra87VyN24aIX1vgXnPqQVlo0KdUlN+KKjsRpMPlwA89JbUPHTQ4hwB4Haz
         c7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7to7rdg8hgLB3yIWeW4mYll+ym182Rl0IniHRC9Bo9Q=;
        b=C5bcjlO6xiCus+np/uECDi14glxSrfPuBZa18lx/6nsyYckGWMIOrZRfS2ynsB1m+C
         X92ldTZIdBYFOwnI5tiAWM5Rba6eVt+Byjo83XG4s5nZp1JJwcIHTAyG3WvoptFXrnBe
         swMaMBkaYwvdx8YGDyInqhu2Q3Xw3LZRnipOqSscm0Z+H/7A+oPiVKmZ5FIyeFVU3q3V
         WIBhV+9Yj2iC/q7BH7pfTXWXWn9vDPEVCwCZLhwjGc2hiRywRKkEnrQLK7yOL2rzUU5C
         DsX/tZf7rj7JGbGDIglFFSzynCiS/C7nZt0Rq6Bbv9taQwc/nTR+Xo9sTn9njrIq/V20
         jdlA==
X-Gm-Message-State: AOAM532xNcPjjGFIKE34wUiRmGL04XPscpwxPbLKAnmLOLnAi/0Fb3NO
        Cw3FnInkXkmkuZA8FzzLi39odx7KRIf2hdOkBAs=
X-Google-Smtp-Source: ABdhPJyGCEBDeyTi3VhHvQ7MqYP7eZ6IJ++5myWlF5qAfOZleUiV8vlKfI5NiX/jhLfaRxdyUuYWNEQE+/hwFer69pM=
X-Received: by 2002:a05:6512:2311:b0:44b:4bb:3425 with SMTP id
 o17-20020a056512231100b0044b04bb3425mr23715044lfu.288.1649708927696; Mon, 11
 Apr 2022 13:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220409093303.499196-1-memxor@gmail.com> <20220409093303.499196-3-memxor@gmail.com>
In-Reply-To: <20220409093303.499196-3-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 11 Apr 2022 13:28:36 -0700
Message-ID: <CAJnrk1YTocMacnX2ATEznbuWL7dXTB2yX-cFj8wtLuGkN-sDPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 02/13] bpf: Move check_ptr_off_reg before check_map_access
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
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

On Sat, Apr 9, 2022 at 1:40 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Some functions in next patch want to use this function, and those
> functions will be called by check_map_access, hence move it before
> check_map_access.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

LGTM.

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  kernel/bpf/verifier.c | 76 +++++++++++++++++++++----------------------
>  1 file changed, 38 insertions(+), 38 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9c1a02b82ecd..71827d14724a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3469,6 +3469,44 @@ static int check_mem_region_access(struct bpf_verifier_env *env, u32 regno,
>         return 0;
>  }
>
> +static int __check_ptr_off_reg(struct bpf_verifier_env *env,
> +                              const struct bpf_reg_state *reg, int regno,
> +                              bool fixed_off_ok)
> +{
> +       /* Access to this pointer-typed register or passing it to a helper
> +        * is only allowed in its original, unmodified form.
> +        */
> +
> +       if (reg->off < 0) {
> +               verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
> +                       reg_type_str(env, reg->type), regno, reg->off);
> +               return -EACCES;
> +       }
> +
> +       if (!fixed_off_ok && reg->off) {
> +               verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
> +                       reg_type_str(env, reg->type), regno, reg->off);
> +               return -EACCES;
> +       }
> +
> +       if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
> +               char tn_buf[48];
> +
> +               tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +               verbose(env, "variable %s access var_off=%s disallowed\n",
> +                       reg_type_str(env, reg->type), tn_buf);
> +               return -EACCES;
> +       }
> +
> +       return 0;
> +}
> +
> +int check_ptr_off_reg(struct bpf_verifier_env *env,
> +                     const struct bpf_reg_state *reg, int regno)
> +{
> +       return __check_ptr_off_reg(env, reg, regno, false);
> +}
> +
>  /* check read/write into a map element with possible variable offset */
>  static int check_map_access(struct bpf_verifier_env *env, u32 regno,
>                             int off, int size, bool zero_size_allowed)
> @@ -3980,44 +4018,6 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
>  }
>  #endif
>
> -static int __check_ptr_off_reg(struct bpf_verifier_env *env,
> -                              const struct bpf_reg_state *reg, int regno,
> -                              bool fixed_off_ok)
> -{
> -       /* Access to this pointer-typed register or passing it to a helper
> -        * is only allowed in its original, unmodified form.
> -        */
> -
> -       if (reg->off < 0) {
> -               verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
> -                       reg_type_str(env, reg->type), regno, reg->off);
> -               return -EACCES;
> -       }
> -
> -       if (!fixed_off_ok && reg->off) {
> -               verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
> -                       reg_type_str(env, reg->type), regno, reg->off);
> -               return -EACCES;
> -       }
> -
> -       if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
> -               char tn_buf[48];
> -
> -               tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> -               verbose(env, "variable %s access var_off=%s disallowed\n",
> -                       reg_type_str(env, reg->type), tn_buf);
> -               return -EACCES;
> -       }
> -
> -       return 0;
> -}
> -
> -int check_ptr_off_reg(struct bpf_verifier_env *env,
> -                     const struct bpf_reg_state *reg, int regno)
> -{
> -       return __check_ptr_off_reg(env, reg, regno, false);
> -}
> -
>  static int __check_buffer_access(struct bpf_verifier_env *env,
>                                  const char *buf_info,
>                                  const struct bpf_reg_state *reg,
> --
> 2.35.1
>
