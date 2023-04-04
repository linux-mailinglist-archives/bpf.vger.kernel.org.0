Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D666D7067
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 01:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjDDXHi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 19:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjDDXHh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 19:07:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984A310CA
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 16:07:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-4fa3ca4090fso46108a12.3
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 16:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680649654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mSJ6PcUu4UeZb8QNPzTlljz4bKDu7GHhmriebrmJJo=;
        b=I4nuY0BEJ6q87kWsM7kdoNfI5JTeSoqHw80RCrNRJG/S8E7uGFSzHc2ieBwUzdtbWb
         NORD84dK5DfMaDlFwSsdyZzgyvxoFBHzeaNvUaHmYbrOLuy+2YTIzFifND7do4Ddv+0c
         INHKyIYA0fTl/OedFhbvO9NLEHZCGa/SLh4HoczCfR4UbnJIrCRg6FDiHkNUE4V5gl3a
         kpGg+BG5fVDu+kE8T8S6VoZAHMKkLqdKVxwH8WluFFQSofYeytMtNWqFBR+UZOUhvS/u
         5ndWOHQ7uw9KwGFXDXR26xCUM0ci0icOCLh7WE4LeAXxU3hzA0WBvIQRFxIuHY0fgJTV
         y8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680649654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mSJ6PcUu4UeZb8QNPzTlljz4bKDu7GHhmriebrmJJo=;
        b=WqKH+EhAtzLjqaG1XO3XmJwTQhlQXWLDNeNuWqSuw6hfzn0MeEo5HfFD4/VmnOq0xL
         Oh/u5LZM2GfDocPzkftXk4UsO3DsSzA3RiScRvLTIHTjfreiY4dMIsFC3iWstj6sPyND
         nNBVIIqB5uv6K8UkjlQYLi8iiAMO4rHnPlzRwV1qCG0fMS4BK5o0blRSskvtB6LQRVGQ
         ZJ0qX1JopqAeH5zyi4lkb0IK1aW67rtZaXjcYfVnOD5yaKTiA+2PUxETy+qbbtHfTRDo
         JM66nivnnrfvdvgrmuc1qaPoKanBbAmsx4wIEpMKDBQOFaGXey5C7uQLnGeko8jbmg40
         1GVA==
X-Gm-Message-State: AAQBX9d5ACSVFNsW89+0gRhbU6ygAmEZRv4KbUCa0TjhskUFEcxKvVDo
        JKh12PAszFfpYKJXj9MUSX4XVCX3DzAdfZv8gIo=
X-Google-Smtp-Source: AKy350Y3Yyt5xeFAZ1nsd/Pe0IH40Gkaevyhi0wIyYP1wMdtqhzLXJeGVuYQAbsavyE3BpNtyuH5OxbeqrFBkGPj5I8=
X-Received: by 2002:a50:bae1:0:b0:4fc:2096:b15c with SMTP id
 x88-20020a50bae1000000b004fc2096b15cmr126348ede.1.1680649653905; Tue, 04 Apr
 2023 16:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230403172833.1552354-1-iii@linux.ibm.com>
In-Reply-To: <20230403172833.1552354-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 4 Apr 2023 16:07:21 -0700
Message-ID: <CAEf4BzbOL0vr7JXHEmAwE7k=D19RxxqyWf+-1_qsSOb4q=2+xA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: Support 64-bit pointers to kfuncs
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 3, 2023 at 10:29=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> test_ksyms_module fails to emit a kfunc call targeting a module on
> s390x, because the verifier stores the difference between kfunc
> address and __bpf_call_base in bpf_insn.imm, which is s32, and modules
> are roughly (1 << 42) bytes away from the kernel on s390x.
>
> Fix by keeping BTF id in bpf_insn.imm for BPF_PSEUDO_KFUNC_CALLs,
> and storing the absolute address in bpf_kfunc_desc.
>
> Introduce bpf_jit_supports_far_kfunc_call() in order to limit this new
> behavior to the s390x JIT. Otherwise other JITs need to be modified,
> which is not desired.
>
> Introduce bpf_get_kfunc_addr() instead of exposing both
> find_kfunc_desc() and struct bpf_kfunc_desc.
>
> In addition to sorting kfuncs by imm, also sort them by offset, in
> order to handle conflicting imms from different modules. Do this on
> all architectures in order to simplify code.
>
> Factor out resolving specialized kfuncs (XPD and dynptr) from
> fixup_kfunc_call(). This was required in the first place, because
> fixup_kfunc_call() uses find_kfunc_desc(), which returns a const
> pointer, so it's not possible to modify kfunc addr without stripping
> const, which is not nice. It also removes repetition of code like:
>
>         if (bpf_jit_supports_far_kfunc_call())
>                 desc->addr =3D func;
>         else
>                 insn->imm =3D BPF_CALL_IMM(func);
>
> and separates kfunc_desc_tab fixups from kfunc_call fixups.
>
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>
> v3: https://lore.kernel.org/bpf/20230222223714.80671-1-iii@linux.ibm.com/
> v3 -> v4: Use Jiri's proposal and make it work on s390x.
>
>  arch/s390/net/bpf_jit_comp.c |   5 ++
>  include/linux/bpf.h          |   2 +
>  include/linux/filter.h       |   1 +
>  kernel/bpf/core.c            |  11 ++++
>  kernel/bpf/verifier.c        | 116 +++++++++++++++++++++++++----------
>  5 files changed, 101 insertions(+), 34 deletions(-)
>

[...]

> @@ -2452,6 +2453,11 @@ struct bpf_kfunc_btf {
>  };
>
>  struct bpf_kfunc_desc_tab {
> +       /* Sorted by func_id (BTF ID) and offset (fd_array offset) during
> +        * verification. JITs do lookups by bpf_insn, where func_id may n=
ot be
> +        * available, therefore at the end of verification do_misc_fixups=
()
> +        * sorts this by imm and offset.
> +        */
>         struct bpf_kfunc_desc descs[MAX_KFUNC_DESCS];
>         u32 nr_descs;
>  };
> @@ -2492,6 +2498,19 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 f=
unc_id, u16 offset)
>                        sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
>  }
>
> +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id, u16 off=
set,

nit: offset is so generic, if it's fd array index, should we call it
that: btf_fd_idx or something like that?

> +                      u8 **func_addr)
> +{
> +       const struct bpf_kfunc_desc *desc;
> +
> +       desc =3D find_kfunc_desc(prog, func_id, offset);
> +       if (!desc)
> +               return -EFAULT;
> +
> +       *func_addr =3D (u8 *)desc->addr;
> +       return 0;
> +}
> +
>  static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
>                                          s16 offset)
>  {
> @@ -2672,7 +2691,8 @@ static int add_kfunc_call(struct bpf_verifier_env *=
env, u32 func_id, s16 offset)
>                 return -EINVAL;
>         }
>
> -       call_imm =3D BPF_CALL_IMM(addr);
> +       call_imm =3D bpf_jit_supports_far_kfunc_call() ? func_id :
> +                                                      BPF_CALL_IMM(addr)=
;
>         /* Check whether or not the relative offset overflows desc->imm *=
/
>         if ((unsigned long)(s32)call_imm !=3D call_imm) {
>                 verbose(env, "address of kernel function %s is out of ran=
ge\n",

this check makes no sense and would have misleading message if
bpf_jit_supports_far_kfunc_call(), so how about actually making it a
proper if/else and doing check only if call_imm is a 32-bit address
offset?

> @@ -2690,6 +2710,7 @@ static int add_kfunc_call(struct bpf_verifier_env *=
env, u32 func_id, s16 offset)
>         desc->func_id =3D func_id;
>         desc->imm =3D call_imm;
>         desc->offset =3D offset;
> +       desc->addr =3D addr;
>         err =3D btf_distill_func_proto(&env->log, desc_btf,
>                                      func_proto, func_name,
>                                      &desc->func_model);
> @@ -2699,19 +2720,15 @@ static int add_kfunc_call(struct bpf_verifier_env=
 *env, u32 func_id, s16 offset)
>         return err;
>  }
>
> -static int kfunc_desc_cmp_by_imm(const void *a, const void *b)
> +static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
>  {
>         const struct bpf_kfunc_desc *d0 =3D a;
>         const struct bpf_kfunc_desc *d1 =3D b;
>
> -       if (d0->imm > d1->imm)
> -               return 1;
> -       else if (d0->imm < d1->imm)
> -               return -1;
> -       return 0;
> +       return d0->imm - d1->imm ?: d0->offset - d1->offset;

very succinct, but does it work for all possible inputs? let's see:

$ cat t.c
#include <stdio.h>
#include <limits.h>

int main() {
        int x1 =3D INT_MAX;
        int x2 =3D INT_MIN;
        int d1 =3D x1 - x2;
        int d2 =3D x2 - x1;

        printf("x1 %d x2 %d d1 %d d2 %d\n", x1, x2, d1, d2);
        return 0;
}
$ cc t.c && ./a.out
x1 2147483647 x2 -2147483648 d1 -1 d2 1

I believe d1 should be positive and d2 should be negative, though,
right? So maybe let's not be too clever here and just do:

if (d0->imm !=3D d1->imm)
    return d0->imm < d10>imm ? -1 : 1:
if (d0->off !=3D d1->off)
    return d0->off < d10>off ? -1 : 1;
return 0;

Still succinct enough, I think.


>  }
>
> -static void sort_kfunc_descs_by_imm(struct bpf_prog *prog)
> +static void sort_kfunc_descs_by_imm_off(struct bpf_prog *prog)
>  {
>         struct bpf_kfunc_desc_tab *tab;
>

[...]

>  static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_ins=
n *insn,
>                             struct bpf_insn *insn_buf, int insn_idx, int =
*cnt)
>  {
>         const struct bpf_kfunc_desc *desc;
> -       void *xdp_kfunc;
>
>         if (!insn->imm) {
>                 verbose(env, "invalid kernel function call not eliminated=
 in verifier pass\n");
> @@ -17306,16 +17372,6 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>
>         *cnt =3D 0;
>
> -       if (bpf_dev_bound_kfunc_id(insn->imm)) {
> -               xdp_kfunc =3D bpf_dev_bound_resolve_kfunc(env->prog, insn=
->imm);
> -               if (xdp_kfunc) {
> -                       insn->imm =3D BPF_CALL_IMM(xdp_kfunc);
> -                       return 0;
> -               }
> -
> -               /* fallback to default kfunc when not supported by netdev=
 */
> -       }
> -
>         /* insn->imm has the btf func_id. Replace it with
>          * an address (relative to __bpf_call_base).

update comment mentioning bpf_jit_supports_far_kfunc_call() ?

>          */
> @@ -17326,7 +17382,8 @@ static int fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                 return -EFAULT;
>         }
>
> -       insn->imm =3D desc->imm;
> +       if (!bpf_jit_supports_far_kfunc_call())
> +               insn->imm =3D BPF_CALL_IMM(desc->addr);
>         if (insn->off)
>                 return 0;
>         if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl])=
 {
> @@ -17351,17 +17408,6 @@ static int fixup_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                    desc->func_id =3D=3D special_kfunc_list[KF_bpf_rdonly_=
cast]) {
>                 insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
>                 *cnt =3D 1;
> -       } else if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_dynptr_=
from_skb]) {
> -               bool seen_direct_write =3D env->seen_direct_write;
> -               bool is_rdonly =3D !may_access_direct_pkt_data(env, NULL,=
 BPF_WRITE);
> -
> -               if (is_rdonly)
> -                       insn->imm =3D BPF_CALL_IMM(bpf_dynptr_from_skb_rd=
only);
> -
> -               /* restore env->seen_direct_write to its original value, =
since
> -                * may_access_direct_pkt_data mutates it
> -                */
> -               env->seen_direct_write =3D seen_direct_write;
>         }
>         return 0;
>  }
> @@ -17384,6 +17430,8 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>         struct bpf_map *map_ptr;
>         int i, ret, cnt, delta =3D 0;
>
> +       fixup_kfunc_desc_tab(env);
> +
>         for (i =3D 0; i < insn_cnt; i++, insn++) {
>                 /* Make divide-by-zero exceptions impossible. */
>                 if (insn->code =3D=3D (BPF_ALU64 | BPF_MOD | BPF_X) ||
> @@ -17891,7 +17939,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>                 }
>         }
>
> -       sort_kfunc_descs_by_imm(env->prog);
> +       sort_kfunc_descs_by_imm_off(env->prog);
>
>         return 0;
>  }
> --
> 2.39.2
>
