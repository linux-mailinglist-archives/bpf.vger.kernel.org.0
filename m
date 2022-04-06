Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3287F4F6B51
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 22:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiDFUZL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 16:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbiDFUYF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 16:24:05 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C111DD3DE
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 11:42:12 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id k15so2616417ils.0
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5BJuOoWoacodwMxekiD3W9pKg6GJ2JCpgxdRqt12eY=;
        b=F6vf4A9ApY7MPWK2Fh6L5AW3Ka6YMZWVo884/qL7TdWzMCSRUH+8ZJ2Br+d0++/owY
         hW+9d7Viz+HO/3o1yFkaYR03SBpveZm4eiWwQSyQ4s2SrByO0u9+fhhr4r3/8PvG8Q1I
         8NqhT54z08fyybkl+hxG0w56/jYlZcNaHn8eoHo6IO/6JStB6Rtz8Qrgx++15gRWirXT
         SKa5xQPhL0Sy3rXioef1bn1fhkRbhllZ0FummdkalD8Rta40KQ0AqOwrC+aweYY+tT1N
         f7z26M401Y+TSFbFTMgkgNEqijKitvo9n3gysCrqFc7G6E9WLWb8aPQHkhBcwuLtVwsu
         uSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5BJuOoWoacodwMxekiD3W9pKg6GJ2JCpgxdRqt12eY=;
        b=qhIzwZ4qucGDxzwBqYC0Oge4RVMLaSf8s6S4W4mu63MPuPQa31Mp8LKVgLCRlRZeeT
         YrpVy7corIvA+HJcFNx7yvFYnJAfqkALa87PRLtA1DnWErNDnHEhTlM1qikllIcS26CH
         kaUHR6dnblAUXl2ISq6nD+WfswHXT8LnKYk/RHR2q4ZQBqRhSfxjcBMiAR/R33YkhbKx
         G+Qztx7YVZl4WMiuOhHaCSsd+SdUqS9PAOMXX7sEC0nGqOLqyltz0lBdCVisXfEkxDmf
         Uvi96xfqaWA5giOtdE2pjxsorhcfkNouGWDBkce4Q9CBtn4QzHLUi3jdTFOo4CvOqSmi
         c0jQ==
X-Gm-Message-State: AOAM530dEsyogsEgc6nTFEsTvox/03NVpQi/kRmmfz1tZoL65VXv4opl
        do+jWOPFtlHpcYYdiNt1tQHLAHrbjvbkXw3vjaQ=
X-Google-Smtp-Source: ABdhPJz8SsgmWpA3jXJ5VmJPkYRjgoORLBP6DU4xLOGVDBxyiAUJ/HKbmF+tAfqR/5m0I2AgbfJogpbTn0fGGuAx1GQ=
X-Received: by 2002:a05:6e02:1562:b0:2ca:50f1:72f3 with SMTP id
 k2-20020a056e02156200b002ca50f172f3mr4696954ilu.71.1649270531654; Wed, 06 Apr
 2022 11:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-3-joannekoong@fb.com>
In-Reply-To: <20220402015826.3941317-3-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 11:42:00 -0700
Message-ID: <CAEf4Bza0WECzFJyK4-mkJhd=fppUjhsbQbnPT16bdt76SJfjwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/7] bpf: Add MEM_RELEASE as a bpf_type_flag
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Fri, Apr 1, 2022 at 7:00 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> From: Joanne Koong <joannelkoong@gmail.com>
>
> Currently, we hardcode in the verifier which functions are release
> functions. We have no way of differentiating which argument is the one
> to be released (we assume it will always be the first argument).
>
> This patch adds MEM_RELEASE as a bpf_type_flag. This allows us to
> determine which argument in the function needs to be released, and
> removes having to hardcode a list of release functions into the
> verifier.
>
> Please note that currently, we only support one release argument in a
> helper function. In the future, if/when we need to support several
> release arguments within the function, MEM_RELEASE is necessary
> since there needs to be a way of differentiating which arguments are the
> release ones.
>
> In the near future, MEM_RELEASE will be used by dynptr helper functions
> such as bpf_free.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h          |  4 +++-
>  include/linux/bpf_verifier.h |  3 +--
>  kernel/bpf/btf.c             |  3 ++-
>  kernel/bpf/ringbuf.c         |  4 ++--
>  kernel/bpf/verifier.c        | 42 ++++++++++++++++++------------------
>  net/core/filter.c            |  2 +-
>  6 files changed, 30 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6f2558da9d4a..cb9f42866cde 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -344,7 +344,9 @@ enum bpf_type_flag {
>
>         MEM_UNINIT              = BIT(5 + BPF_BASE_TYPE_BITS),
>
> -       __BPF_TYPE_LAST_FLAG    = MEM_UNINIT,
> +       MEM_RELEASE             = BIT(6 + BPF_BASE_TYPE_BITS),

"MEM_" part seems a bit too specific, it's not necessarily (just)
about memory, it's more generally about "releasing resources" in
general, right? ARG_RELEASE or OBJ_RELEASE maybe?

> +
> +       __BPF_TYPE_LAST_FLAG    = MEM_RELEASE,
>  };
>

[...]

> -/* Determine whether the function releases some resources allocated by another
> - * function call. The first reference type argument will be assumed to be
> - * released by release_reference().
> +/* Determine whether the type releases some resources allocated by a
> + * previous function call.
>   */
> -static bool is_release_function(enum bpf_func_id func_id)
> +static bool type_is_release_mem(u32 type)
>  {
> -       return func_id == BPF_FUNC_sk_release ||
> -              func_id == BPF_FUNC_ringbuf_submit ||
> -              func_id == BPF_FUNC_ringbuf_discard;
> +       return type & MEM_RELEASE;
>  }
>

same skepticism regarding the need for this helper function, just
makes grepping code slightly harder

>  static bool may_be_acquire_function(enum bpf_func_id func_id)

[...]
