Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FF76AF857
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 23:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCGWOw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 17:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCGWOq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 17:14:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF43580FD
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 14:14:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cw28so58390175edb.5
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 14:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678227282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Kr/Fi3v8BTP04EoR1AUz8PGDu5Shw13mOsjVyMLWzM=;
        b=G5qhr2FmJcP58rBX63aGo5jrU/sKNXPMDss1wnq1iLHtjtjSAntLMDerYuQuhli2iQ
         lm/GvNiGwqwfPnDSOvjW9OC/w9XAjK6Ur1CmpQgylH0OjO54P6LGUYrIlsY+//imzC9Y
         DZ7OV9jxOPZlIB9roVYExQHvhEfwK1cIH9EvUlSYvaLX9O1rwTS92IAu7eoczkFxm3vI
         WAj4DVSNpr4s9+tmMGBv1LrJ9G89IDtA3HJQbLukWEsZmJ+DwQeABY6ngkPzPVq+eo1M
         rosi3qiT/4hXLaWZW3XzTA1iHt67/fam1U2GLiL8agdsHcqVXk5tjzSbu2LvErpHiJf1
         pRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Kr/Fi3v8BTP04EoR1AUz8PGDu5Shw13mOsjVyMLWzM=;
        b=lu/6tTC4XYvMoBYyH6aWxgCk0pbq9XfySDrt2/77A41EyFeLPoptHomfhk4Yxfbr6C
         Ay1UfOBiC1Z6S6KAQui6xhMnrMLf34GbUi3I4F16uayjfD8M30G+S11YmlwScB/2Ma03
         MFGubehbZq5YiPw4hnIxSc/0hFJ4M/YeSdfeORMhd2oGau3dVYQRpoE07DwF0QV89YJt
         C0TEalLr7M5osemsZUHHkJKxFTuI4eWnsA1z42Gi6dNTGpgJeeTmMHi6i7UUSpanrBBa
         a58Cppbu2H0/XUq84cFNa+wGVmXWhsmekWAkHRenmf8r+mtJLEHsF1i66UbGQVXPQNOi
         4VuQ==
X-Gm-Message-State: AO0yUKURRwBDClRgTw9Po6waRm2B9XVX+LbjQDAG9tD4JuN427fEo11k
        +XkGoyqgUlE56wepqdK14ZIAcIGlMW9rKIs0wtw=
X-Google-Smtp-Source: AK7set/YChI+4imEwXDyFVNhQeSdNaWlILFXwvrfkCRVQHGzIwgFemb1Ibl0CHR2vO5VTIzx+kXEglqO+qVJDa22yis=
X-Received: by 2002:a17:907:33c1:b0:8b0:fbd5:2145 with SMTP id
 zk1-20020a17090733c100b008b0fbd52145mr8066559ejb.15.1678227282272; Tue, 07
 Mar 2023 14:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20230307215329.3895377-1-andrii@kernel.org> <20230307215329.3895377-5-andrii@kernel.org>
In-Reply-To: <20230307215329.3895377-5-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 14:14:29 -0800
Message-ID: <CAEf4BzY5HwdUjsoDYv+aVEXp=y9wHJ_rvqwaDxmix5aeizZKGQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/8] bpf: implement number iterator
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 7, 2023 at 1:53=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Implement first open-coded iterator type over a range of integers.
>
> It's public API consists of:
>   - bpf_iter_num_new() constructor, which accepts [start, end) range
>     (that is, start is inclusive, end is exclusive).
>   - bpf_iter_num_next() which will keep returning read-only pointer to in=
t
>     until the range is exhausted, at which point NULL will be returned.
>     If bpf_iter_num_next() is kept calling after this, NULL will be
>     persistently returned.
>   - bpf_iter_num_destroy() destructor, which needs to be called at some
>     point to clean up iterator state. BPF verifier enforces that iterator
>     destructor is called at some point before BPF program exits.
>
> Note that `start =3D end =3D X` is a valid combination to setup empty
> iterator. bpf_iter_num_new() will return 0 (success) for any such
> combination.
>
> If bpf_iter_num_new() detects invalid combination of input arguments, it
> returns error, resets iterator state to, effectively, empty iterator, so
> any subsequent call to bpf_iter_num_next() will keep returning NULL.
>
> BPF verifier has no knowledge that returned integers are in the
> [start, end) value range, as both `start` and `end` are not statically
> known/enforced, they are runtime values only.
>
> While implementation is pretty trivial, some care needs to be taken to
> avoid overflows and underflows. Subsequent selftests will validate
> correctness of [start, end) semantics, especially around extremes
> (INT_MIN and INT_MAX).
>
> Similarly to bpf_loop(), we enforce that no more than BPF_MAX_LOOPS can
> be specified.
>
> bpf_iter_num_{new,next,destroy}() is a logical evolution from bounded
> BPF loops and bpf_loop() helper and is the basis for implementing
> ergonomic BPF loops with no statically known or verified bounds.
> Subsequent patches implement bpf_for() macro, demonstrating how this can
> be wrapped into something that works and feels like a normal for() loop
> in C language.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  8 +++-
>  include/uapi/linux/bpf.h       |  8 ++++
>  kernel/bpf/bpf_iter.c          | 70 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/helpers.c           |  3 ++
>  kernel/bpf/verifier.c          |  6 +++
>  tools/include/uapi/linux/bpf.h |  8 ++++
>  6 files changed, 101 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6792a7940e1e..e64ff1e89fb2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1617,8 +1617,12 @@ struct bpf_array {
>  #define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
>  #define MAX_TAIL_CALL_CNT 33
>
> -/* Maximum number of loops for bpf_loop */
> -#define BPF_MAX_LOOPS  BIT(23)
> +/* Maximum number of loops for bpf_loop and bpf_iter_num.
> + * It's enum to expose it (and thus make it discoverable) through BTF.
> + */
> +enum {
> +       BPF_MAX_LOOPS =3D 8 * 1024 * 1024,
> +};
>
>  #define BPF_F_ACCESS_MASK      (BPF_F_RDONLY |         \
>                                  BPF_F_RDONLY_PROG |    \
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 976b194eb775..bf8b77d9a17e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7112,4 +7112,12 @@ enum {
>         BPF_F_TIMER_ABS =3D (1ULL << 0),
>  };
>
> +/* BPF numbers iterator state */
> +struct bpf_iter_num {
> +       /* opaque iterator state; having __u64 here allows to preserve co=
rrect
> +        * alignment requirements in vmlinux.h, generated from BTF
> +        */
> +       __u64 __opaque[1];
> +};
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 5dc307bdeaeb..96856f130cbf 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -776,3 +776,73 @@ const struct bpf_func_proto bpf_loop_proto =3D {
>         .arg3_type      =3D ARG_PTR_TO_STACK_OR_NULL,
>         .arg4_type      =3D ARG_ANYTHING,
>  };
> +
> +struct bpf_iter_num_kern {
> +       int cur; /* current value, inclusive */
> +       int end; /* final value, exclusive */
> +} __aligned(8);
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "Global functions as their definitions will be in vmlin=
ux BTF");
> +
> +__bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int=
 end)
> +{
> +       struct bpf_iter_num_kern *s =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_num_kern) !=3D sizeof(struct =
bpf_iter_num));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_num_kern) !=3D __alignof=
__(struct bpf_iter_num));
> +
> +       BTF_TYPE_EMIT(struct btf_iter_num);
> +
> +       /* start =3D=3D end is legit, it's an empty range and we'll just =
get NULL
> +        * on first (and any subsequent) bpf_iter_num_next() call
> +        */
> +       if (start > end) {
> +               s->cur =3D s->end =3D 0;
> +               return -EINVAL;
> +       }
> +
> +       /* avoid overflows, e.g., if start =3D=3D INT_MIN and end =3D=3D =
INT_MAX */
> +       if ((s64)end - (s64)start > BPF_MAX_LOOPS) {
> +               s->cur =3D s->end =3D 0;
> +               return -E2BIG;
> +       }
> +
> +       /* user will call bpf_iter_num_next() first,
> +        * which will set s->cur to exactly start value;
> +        * underflow shouldn't matter
> +        */
> +       s->cur =3D start - 1;
> +       s->end =3D end;
> +
> +       return 0;
> +}
> +
> +__bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_num* it)
> +{
> +       struct bpf_iter_num_kern *s =3D (void *)it;
> +
> +       /* check failed initialization or if we are done (same behavior);
> +        * need to be careful about overflow, so convert to s64 for check=
s,
> +        * e.g., if s->cur =3D=3D s->end =3D=3D INT_MAX, we can't just do
> +        * s->cur + 1 >=3D s->end
> +        */
> +       if ((s64)(s->cur + 1) >=3D s->end) {
> +               s->cur =3D s->end =3D 0;
> +               return NULL;
> +       }
> +
> +       s->cur++;
> +
> +       return &s->cur;
> +}
> +
> +__bpf_kfunc void bpf_iter_num_destroy(struct bpf_iter_num *it)
> +{
> +       struct bpf_iter_num_kern *s =3D (void *)it;
> +
> +       s->cur =3D s->end =3D 0;
> +}
> +
> +__diag_pop();
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 637ac4e92e75..f9b7eeedce08 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2411,6 +2411,9 @@ BTF_ID_FLAGS(func, bpf_rcu_read_lock)
>  BTF_ID_FLAGS(func, bpf_rcu_read_unlock)
>  BTF_ID_FLAGS(func, bpf_dynptr_slice, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
> +BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>  BTF_SET8_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d1246d187fac..33c305b563f6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9542,6 +9542,9 @@ enum special_kfunc_type {
>         KF_bpf_dynptr_from_xdp,
>         KF_bpf_dynptr_slice,
>         KF_bpf_dynptr_slice_rdwr,
> +       KF_bpf_iter_num_new,
> +       KF_bpf_iter_num_next,
> +       KF_bpf_iter_num_destroy,

don't really need this, this is a leftover from v1, missed it. If this
patch set is going to be applied as is, please strip these three rows.

>  };
>
>  BTF_SET_START(special_kfunc_set)
> @@ -9580,6 +9583,9 @@ BTF_ID(func, bpf_dynptr_from_skb)
>  BTF_ID(func, bpf_dynptr_from_xdp)
>  BTF_ID(func, bpf_dynptr_slice)
>  BTF_ID(func, bpf_dynptr_slice_rdwr)
> +BTF_ID(func, bpf_iter_num_new)
> +BTF_ID(func, bpf_iter_num_next)
> +BTF_ID(func, bpf_iter_num_destroy)
>
>  static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *m=
eta)
>  {
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 976b194eb775..bf8b77d9a17e 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7112,4 +7112,12 @@ enum {
>         BPF_F_TIMER_ABS =3D (1ULL << 0),
>  };
>
> +/* BPF numbers iterator state */
> +struct bpf_iter_num {
> +       /* opaque iterator state; having __u64 here allows to preserve co=
rrect
> +        * alignment requirements in vmlinux.h, generated from BTF
> +        */
> +       __u64 __opaque[1];
> +};
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> --
> 2.34.1
>
