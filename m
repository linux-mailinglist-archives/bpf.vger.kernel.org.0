Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681506ED564
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 21:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjDXTej (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 15:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjDXTei (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 15:34:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E32123
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 12:34:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4eed6ddcae1so20972535e87.0
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 12:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682364874; x=1684956874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHuErsuR6HokUoMGhIvmWPav2RzBk1SHXbCAUrEIPgA=;
        b=T332eYa4rMKk6/JakyJDWGfNbu1SzwfGYQJizuRm5byvU8vmr33ldlnjhHQdAjtvg4
         FmbmNSJ8J3QFeqkNGrRiL4MIs5KgsAZpBDOp5hPhALS3PHJVh5vUqPK5ANdMZwVJ/4ku
         tizk7oRl05YGOML5e+D1zq4MdotJENdUZoo/KjoyiBRyQhs2Z9lcJeNffCUfugy1Van4
         evHDOWCQ1acjsTtJ6GctO+pJgTKyqn+EbIpqklkCAYrWgCfagJy8Kxf3QKk3MGeu5jKp
         ktAtbSZ7ROrBqvcOfEQaoo90NVL7a2yXn9U+nPsMTRP/Zndr3k9x/awCofja/eKipmzs
         LnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682364874; x=1684956874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHuErsuR6HokUoMGhIvmWPav2RzBk1SHXbCAUrEIPgA=;
        b=GnFX80N7mf8av8z74O59iNAnzd+TVTKOV+dkLXJUGi1cO9PYdjUdoHbszqCdNJbP/c
         Dqe3mbUhtvUcPBF7l6OldiFU14KI/JUOMw6gNwq6WtiSLYgyVQDgeXxAeLOLSOgtX6+F
         eu9E+2x60QOrtnjSVRMFYU2IwFajDbnIzbEuEGTrts8UcW0lgB0BxIIizcFYi/wdPBrI
         jHkDzLk2d6IZ88LJRBrHh+0U+s6jST84naTkVftU6tJ6r2Y9WviecmL2c+8F+oEQzfMx
         HWWz+1HKpQJElaD5gUh4KfsBuoqH6iBPiyyV+qL7PdzOQHaOYghxFLUENhPC16jtd+vB
         owiA==
X-Gm-Message-State: AAQBX9dU48KtHK2e06duKXi34yjz84+pqEI71ZeWvpJt+I8X9Il/BRFL
        BGkOBXuSOwM9V14jKyXue9C7C+R0U8ueeHL6CQU=
X-Google-Smtp-Source: AKy350YQIO3ur6y+UEoY14HaZe4PQSCV69lbPaBYVMV/TdLEWOHGEpSGd//hIGDHLYmZLrS62WOeEkCstBxo+F6/Yzs=
X-Received: by 2002:a2e:ba09:0:b0:2a9:7985:b2f5 with SMTP id
 p9-20020a2eba09000000b002a97985b2f5mr3168162lja.24.1682364874288; Mon, 24 Apr
 2023 12:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230424192924.1549667-1-davemarchevsky@fb.com>
In-Reply-To: <20230424192924.1549667-1-davemarchevsky@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Apr 2023 12:34:22 -0700
Message-ID: <CAADnVQ+yiZLpx6G=GPjYt9Z53d5TnCQ2n0TmnjC7NP5e-CZVSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Disable bpf_refcount_acquire kfunc calls
 until race conditions are fixed
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Mon, Apr 24, 2023 at 12:29=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb=
.com> wrote:
>
> As reported by Kumar in [0], the shared ownership implementation for BPF
> programs has some race conditions which need to be addressed before it
> can safely be used. This patch does so in a minimal way instead of
> ripping out shared ownership entirely, as proper fixes for the issues
> raised will follow ASAP, at which point this patch's commit can be
> reverted to re-enable shared ownership.
>
> The patch removes the ability to call bpf_refcount_acquire_impl from BPF
> programs. Programs can only bump refcount and obtain a new owning
> reference using this kfunc, so removing the ability to call it
> effectively disables shared ownership.
>
> Instead of changing success / failure expectations for
> bpf_refcount-related selftests, this patch just disables them from
> running for now.
>
>   [0]: https://lore.kernel.org/bpf/d7hyspcow5wtjcmw4fugdgyp3fwhljwuscp3xy=
ut5qnwivyeru@ysdq543otzv2/
>
> Reported-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  kernel/bpf/helpers.c                          |  1 -
>  kernel/bpf/verifier.c                         | 21 +++----------------
>  .../bpf/prog_tests/refcounted_kptr.c          |  2 --
>  3 files changed, 3 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 8d368fa353f9..3886b9815a25 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2325,7 +2325,6 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>  #endif
>  BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
> -BTF_ID_FLAGS(func, bpf_refcount_acquire_impl, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, bpf_list_push_front_impl)
>  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
>  BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0d73139ee4d8..9926046f30c2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9579,7 +9579,6 @@ enum kfunc_ptr_arg_type {
>  enum special_kfunc_type {
>         KF_bpf_obj_new_impl,
>         KF_bpf_obj_drop_impl,
> -       KF_bpf_refcount_acquire_impl,
>         KF_bpf_list_push_front_impl,
>         KF_bpf_list_push_back_impl,
>         KF_bpf_list_pop_front,
> @@ -9600,7 +9599,6 @@ enum special_kfunc_type {
>  BTF_SET_START(special_kfunc_set)
>  BTF_ID(func, bpf_obj_new_impl)
>  BTF_ID(func, bpf_obj_drop_impl)
> -BTF_ID(func, bpf_refcount_acquire_impl)
>  BTF_ID(func, bpf_list_push_front_impl)
>  BTF_ID(func, bpf_list_push_back_impl)
>  BTF_ID(func, bpf_list_pop_front)
> @@ -9619,7 +9617,6 @@ BTF_SET_END(special_kfunc_set)
>  BTF_ID_LIST(special_kfunc_list)
>  BTF_ID(func, bpf_obj_new_impl)
>  BTF_ID(func, bpf_obj_drop_impl)
> -BTF_ID(func, bpf_refcount_acquire_impl)
>  BTF_ID(func, bpf_list_push_front_impl)
>  BTF_ID(func, bpf_list_push_back_impl)
>  BTF_ID(func, bpf_list_pop_front)
> @@ -9929,8 +9926,7 @@ static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
>
>  static bool is_bpf_graph_api_kfunc(u32 btf_id)
>  {
> -       return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(b=
tf_id) ||
> -              btf_id =3D=3D special_kfunc_list[KF_bpf_refcount_acquire_i=
mpl];
> +       return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(b=
tf_id);
>  }
>
>  static bool is_callback_calling_kfunc(u32 btf_id)
> @@ -10691,8 +10687,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>         if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, =
t)) {
>                 /* Only exception is bpf_obj_new_impl */
>                 if (meta.btf !=3D btf_vmlinux ||
> -                   (meta.func_id !=3D special_kfunc_list[KF_bpf_obj_new_=
impl] &&
> -                    meta.func_id !=3D special_kfunc_list[KF_bpf_refcount=
_acquire_impl])) {
> +                   (meta.func_id !=3D special_kfunc_list[KF_bpf_obj_new_=
impl])) {
>                         verbose(env, "acquire kernel function does not re=
turn PTR_TO_BTF_ID\n");
>                         return -EINVAL;
>                 }
> @@ -10740,15 +10735,6 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                                 insn_aux->obj_new_size =3D ret_t->size;
>                                 insn_aux->kptr_struct_meta =3D
>                                         btf_find_struct_meta(ret_btf, ret=
_btf_id);
> -                       } else if (meta.func_id =3D=3D special_kfunc_list=
[KF_bpf_refcount_acquire_impl]) {
> -                               mark_reg_known_zero(env, regs, BPF_REG_0)=
;
> -                               regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | =
MEM_ALLOC;
> -                               regs[BPF_REG_0].btf =3D meta.arg_refcount=
_acquire.btf;
> -                               regs[BPF_REG_0].btf_id =3D meta.arg_refco=
unt_acquire.btf_id;
> -
> -                               insn_aux->kptr_struct_meta =3D
> -                                       btf_find_struct_meta(meta.arg_ref=
count_acquire.btf,
> -                                                            meta.arg_ref=
count_acquire.btf_id);
>                         } else if (meta.func_id =3D=3D special_kfunc_list=
[KF_bpf_list_pop_front] ||
>                                    meta.func_id =3D=3D special_kfunc_list=
[KF_bpf_list_pop_back]) {
>                                 struct btf_field *field =3D meta.arg_list=
_head.field;
> @@ -17417,8 +17403,7 @@ static int fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                 insn_buf[2] =3D addr[1];
>                 insn_buf[3] =3D *insn;
>                 *cnt =3D 4;
> -       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_dro=
p_impl] ||
> -                  desc->func_id =3D=3D special_kfunc_list[KF_bpf_refcoun=
t_acquire_impl]) {
> +       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_dro=
p_impl]) {
>                 struct btf_struct_meta *kptr_struct_meta =3D env->insn_au=
x_data[insn_idx].kptr_struct_meta;
>                 struct bpf_insn addr[2] =3D { BPF_LD_IMM64(BPF_REG_2, (lo=
ng)kptr_struct_meta) };

imo that is too much.
Could you disable it with a single line that is easy to revert?

Something like this:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0d73139ee4d8..c558a35cb19e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10509,6 +10509,10 @@ static int check_kfunc_args(struct
bpf_verifier_env *env, struct bpf_kfunc_call_
                                verbose(env, "arg#%d doesn't point to
a type with bpf_refcount field\n", i);
                                return -EINVAL;
                        }
+                       if (rec->refcount_off >=3D 0) {
+                               verbose(env, "disabled for now\n");
+                               return -EINVAL;
+                       }


> diff --git a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c b/t=
ools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> index 2ab23832062d..595cbf92bff5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/refcounted_kptr.c
> @@ -9,10 +9,8 @@
>
>  void test_refcounted_kptr(void)
>  {
> -       RUN_TESTS(refcounted_kptr);
>  }
>
>  void test_refcounted_kptr_fail(void)
>  {
> -       RUN_TESTS(refcounted_kptr_fail);
>  }

and these two, of course.

> --
> 2.34.1
>
