Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F221551E291
	for <lists+bpf@lfdr.de>; Sat,  7 May 2022 01:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444772AbiEFXpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 19:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359057AbiEFXpp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 19:45:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28AB712D4
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 16:41:59 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id d3so5743799ilr.10
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ONwLMn6fhM9Z9WPJCocGKXpWdnUJm92v83esa47RvDc=;
        b=fda4z9YJW9//K1w4/PNTl2+SHqlSQqJ4gFyV0nwunjgN4hDreu4LCu+8Z7XtdJKGQv
         b8o03BHzNW7kspXsY25CIrvCqPVWY1ESAThHZxIa+6flj0dAZ0c6Kg5V4Syl8jVspAsE
         Zx28uJxs2NSUH7UXbCCh3rYwQmOLGjjGZbKLkDXgoyKsrEqCGSl7CnsNM8x2XtdH+x2i
         jxiJk6xgzLN9kTWKiuJEyl7TkzCSOiz1MmocueYD/L9kYVtCx8EgHUBoNxU7MrnHOjoU
         Acf7VASWq3AhU0TMh/+sm/s/NkSg48S2Aqo92HQ3560AzHPo4yrwQqBsXAAjpfqe2w5m
         0M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ONwLMn6fhM9Z9WPJCocGKXpWdnUJm92v83esa47RvDc=;
        b=qpVCfCQLJ/YxOQrhg0k29Ys+TDkgv5MbIdCnUOdO9hHJD8SPdn+Vezfhn9DxJvktDX
         3bWpx1lgBJx6p3qG9kWc0GSj5gOY8qE7iyt0gGJbD8xzluLT89TSYRPXE8R+zvxX+/HM
         UqfTNu23eOlV3r1qVKGexadn+IKCPUJFE7zP951ta90TwTmVQkrKBaYi9gGms2osLOTi
         HeIHZuzOz2WyThMwHgeXowpYZDJvb+f16RvAM3FLInqHXWKlMPDyOXTN66DYSSvfJUlV
         Jwe0589m0j6u859+mgVxJocRoNx03EzusDHLKyEooBsGVa1zrKxxwfEtEaR8SusNcdc1
         g8Iw==
X-Gm-Message-State: AOAM5313fiZm4NnkEEdYDejlJazPLlX6YMfn0rmhplZ5Ki31xV60h3Em
        m8ev/t5Zxk8IYwFteKsttWU35evceU9LeoL0CF+3cTngs8A=
X-Google-Smtp-Source: ABdhPJy7Oc7a+sUocbd0rc7SNiWFXeuee9AM1a0Stlh8nP7qSj3WPGEeDj1r8qgrJtWYV3jaoq075Xl1IyrJWcE0DRc=
X-Received: by 2002:a05:6e02:1d8d:b0:2cf:2112:2267 with SMTP id
 h13-20020a056e021d8d00b002cf21122267mr2170559ila.239.1651880519360; Fri, 06
 May 2022 16:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com> <20220428211059.4065379-4-joannelkoong@gmail.com>
In-Reply-To: <20220428211059.4065379-4-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 May 2022 16:41:48 -0700
Message-ID: <CAEf4Bzaz4=tEvESd_twhx1bdepdOP3L4SmUiaKqGFJtX=CJruQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Dynptr support for ring buffers
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> Currently, our only way of writing dynamically-sized data into a ring
> buffer is through bpf_ringbuf_output but this incurs an extra memcpy
> cost. bpf_ringbuf_reserve + bpf_ringbuf_commit avoids this extra
> memcpy, but it can only safely support reservation sizes that are
> statically known since the verifier cannot guarantee that the bpf
> program won=E2=80=99t access memory outside the reserved space.
>
> The bpf_dynptr abstraction allows for dynamically-sized ring buffer
> reservations without the extra memcpy.
>
> There are 3 new APIs:
>
> long bpf_ringbuf_reserve_dynptr(void *ringbuf, u32 size, u64 flags, struc=
t bpf_dynptr *ptr);
> void bpf_ringbuf_submit_dynptr(struct bpf_dynptr *ptr, u64 flags);
> void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags);
>
> These closely follow the functionalities of the original ringbuf APIs.
> For example, all ringbuffer dynptrs that have been reserved must be
> either submitted or discarded before the program exits.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

Looks great! Modulo those four underscores, they are super confusing...

>  include/linux/bpf.h            | 10 ++++-
>  include/uapi/linux/bpf.h       | 35 +++++++++++++++++
>  kernel/bpf/helpers.c           |  6 +++
>  kernel/bpf/ringbuf.c           | 71 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c          | 18 +++++++--
>  tools/include/uapi/linux/bpf.h | 35 +++++++++++++++++
>  6 files changed, 171 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 757440406962..10efbec99e93 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -394,7 +394,10 @@ enum bpf_type_flag {
>         /* DYNPTR points to dynamically allocated memory. */
>         DYNPTR_TYPE_MALLOC      =3D BIT(8 + BPF_BASE_TYPE_BITS),
>
> -       __BPF_TYPE_LAST_FLAG    =3D DYNPTR_TYPE_MALLOC,
> +       /* DYNPTR points to a ringbuf record. */
> +       DYNPTR_TYPE_RINGBUF     =3D BIT(9 + BPF_BASE_TYPE_BITS),
> +
> +       __BPF_TYPE_LAST_FLAG    =3D DYNPTR_TYPE_RINGBUF,

it's getting a bit old to have to update __BPF_TYPE_LAST_FLAG all the
time, maybe let's do this:

__BPF_TYPE_FLAG_MAX,
__BPF_TYPE_LAST_FLAG =3D __BPF_TYPE_FLAG_MAX - 1,

and never touch it again?

>  };
>

[...]

> + *
> + * void bpf_ringbuf_discard_dynptr(struct bpf_dynptr *ptr, u64 flags)
> + *     Description
> + *             Discard reserved ring buffer sample through the dynptr
> + *             interface. This is a no-op if the dynptr is invalid/null.
> + *
> + *             For more information on *flags*, please see
> + *             'bpf_ringbuf_discard'.
> + *     Return
> + *             Nothing. Always succeeds.
>   */

let's also add bpf_dynptr_is_null() (or bpf_dynptr_is_valid(), not
sure which one is more appropriate, probably just null one), so we can
check in code whether some reservation was successful without knowing
bpf_ringbuf_reserve_dynptr()'s return value


>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \

[...]

> +BPF_CALL_4(bpf_ringbuf_reserve_dynptr, struct bpf_map *, map, u32, size,=
 u64, flags,
> +          struct bpf_dynptr_kern *, ptr)
> +{
> +       void *sample;
> +       int err;
> +
> +       err =3D bpf_dynptr_check_size(size);
> +       if (err) {
> +               bpf_dynptr_set_null(ptr);
> +               return err;
> +       }
> +
> +       sample =3D (void __force *)____bpf_ringbuf_reserve(map, size, fla=
gs);

I was so confused by these four underscored for a bit... Is this
what's defined inside BPF_CALL_4 (and thus makes it ungreppable). Can
you instead just open-code container_of and __bpf_ringbuf_reserve()
directly to make it a bit easier to follow? And flags check as well.
It will so much easier to understand what's going on.

> +
> +       if (!sample) {
> +               bpf_dynptr_set_null(ptr);
> +               return -EINVAL;
> +       }
> +
> +       bpf_dynptr_init(ptr, sample, BPF_DYNPTR_TYPE_RINGBUF, 0, size);
> +
> +       return 0;
> +}
> +
> +const struct bpf_func_proto bpf_ringbuf_reserve_dynptr_proto =3D {
> +       .func           =3D bpf_ringbuf_reserve_dynptr,
> +       .ret_type       =3D RET_INTEGER,
> +       .arg1_type      =3D ARG_CONST_MAP_PTR,
> +       .arg2_type      =3D ARG_ANYTHING,
> +       .arg3_type      =3D ARG_ANYTHING,
> +       .arg4_type      =3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | MEM=
_UNINIT,
> +};
> +
> +BPF_CALL_2(bpf_ringbuf_submit_dynptr, struct bpf_dynptr_kern *, ptr, u64=
, flags)
> +{
> +       if (!ptr->data)
> +               return 0;
> +
> +       ____bpf_ringbuf_submit(ptr->data, flags);

this just calls bpf_ringbuf_commit(), let's do it here explicitly as well

> +
> +       bpf_dynptr_set_null(ptr);
> +
> +       return 0;
> +}
> +
> +const struct bpf_func_proto bpf_ringbuf_submit_dynptr_proto =3D {
> +       .func           =3D bpf_ringbuf_submit_dynptr,
> +       .ret_type       =3D RET_VOID,
> +       .arg1_type      =3D ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ=
_RELEASE,
> +       .arg2_type      =3D ARG_ANYTHING,
> +};
> +
> +BPF_CALL_2(bpf_ringbuf_discard_dynptr, struct bpf_dynptr_kern *, ptr, u6=
4, flags)
> +{
> +       if (!ptr->data)
> +               return 0;
> +
> +       ____bpf_ringbuf_discard(ptr->data, flags);
> +

ditto


> +       bpf_dynptr_set_null(ptr);
> +
> +       return 0;
> +}
> +

[...]
