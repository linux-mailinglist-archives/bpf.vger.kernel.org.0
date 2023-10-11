Return-Path: <bpf+bounces-11972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A787C60D1
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 01:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4761F282678
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 23:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1895A21A1F;
	Wed, 11 Oct 2023 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxG3HC11"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0416920321
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 23:02:42 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE30C9D
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 16:02:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-9ad8a822508so59916466b.0
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697065358; x=1697670158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghvuRLyWd00cgFu+T1U+FbJgg3MsqZn+fawb5PTUq+g=;
        b=FxG3HC11omtNMyBSlg+m1U1aAqunDJHGWONt7gxtmrzqgGs7fzgJkTol2J4QEfX8Pm
         xkhh+pfJh7MCIr5dzUVP9D3P0nKSU9n0bNnpQuPG4u0TDam6oF1yA0WmKPZvJgVmLEcU
         LIaQzmO2yNIw6smXFGYDNhdH/xtzL4QFCwXiEy4h278NLg0zZ2OWazn2IkjNF6bjFQq8
         q3hLYFijHU/uKR0cf2JIlT7TNctO8dt5UBcEVVeXMVqC6cMO8aA8BtO6xfQt35+wSw6s
         wwSng1UUJFBGMTJKdFxB5zfIt56W6Z3OFhBL5Dnsf4aakwwjC7b4KuVWwTldxDqQ2Q9L
         uFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697065358; x=1697670158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghvuRLyWd00cgFu+T1U+FbJgg3MsqZn+fawb5PTUq+g=;
        b=MED1eNMkgkXVQfzKXBQ33alg8mn6Po+8aYIiILoKoW/6L0Ncjt690EFyaJqA3btf71
         kHXNUwHchbTWW6/U3W1ivpm2mopjoL7xUoZDEyyrnZ6YoL9coud3uWfQxDtjN/2J81E3
         4Io3GCcHMKuBmknEAeOwqKOTiN/pSqXqPWS3VdFkcpMzKyIvMiNhg/uP3N5VX/qfTMOk
         YR9yOBh08B7DHox0YoDkv933aWFk7l0SJUYtHqdF5kDQK5kkw3rxwmz2NS9Rukai9Q2H
         NKSt5L8dostpsT7XuFh+tgIOeoCRX5eM3vhWsw1UvtX+6FmE0H/6/F3SjSPnXP4sIxwb
         LBFA==
X-Gm-Message-State: AOJu0YwrYqXwSKPXRI9GAZFfKOz8pGHAjiPLrKATpl3ewoHatb1b2HOb
	m3Q8f14YJFKLadWkFX5C6SYD5Evn0IGsz7cx2s0=
X-Google-Smtp-Source: AGHT+IFSV+cil28vm3pVa5aYuS1iTCcC6wO8kt0BFRWkXlvGNW+ivJ/7PKNr5jbL33jeFAK0O/4RMBgOn7j3QDhPIc4=
X-Received: by 2002:a17:906:8e:b0:9a9:d5f4:1a0d with SMTP id
 14-20020a170906008e00b009a9d5f41a0dmr16822855ejc.45.1697065357841; Wed, 11
 Oct 2023 16:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221118015614.2013203-1-memxor@gmail.com> <20221118015614.2013203-23-memxor@gmail.com>
 <CAEf4BzY0h8pPn3gWGg2D5TvEy8z_EROb_jMdiqjWWo_vL87g7w@mail.gmail.com>
In-Reply-To: <CAEf4BzY0h8pPn3gWGg2D5TvEy8z_EROb_jMdiqjWWo_vL87g7w@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 12 Oct 2023 01:02:01 +0200
Message-ID: <CAP01T76SybiQeoH91tsDuWn4DU1Ba_8H53AuQP8QedZyc3ZKbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 22/24] selftests/bpf: Add BPF linked list API tests
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Dave Marchevsky <davemarchevsky@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 12 Oct 2023 at 00:44, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Thu, Nov 17, 2022 at 5:57=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Include various tests covering the success and failure cases. Also, run
> > the success cases at runtime to verify correctness of linked list
> > manipulation routines, in addition to ensuring successful verification.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
> >  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
> >  .../selftests/bpf/prog_tests/linked_list.c    | 255 ++++++++
> >  .../testing/selftests/bpf/progs/linked_list.c | 370 +++++++++++
> >  .../testing/selftests/bpf/progs/linked_list.h |  56 ++
> >  .../selftests/bpf/progs/linked_list_fail.c    | 581 ++++++++++++++++++
> >  6 files changed, 1264 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.=
c
> >  create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/linked_list.h
> >  create mode 100644 tools/testing/selftests/bpf/progs/linked_list_fail.=
c
> >
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testi=
ng/selftests/bpf/DENYLIST.aarch64
> > index 09416d5d2e33..affc5aebbf0f 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > @@ -38,6 +38,7 @@ kprobe_multi_test/skel_api                       # kp=
robe_multi__attach unexpect
> >  ksyms_module/libbpf                              # 'bpf_testmod_ksym_p=
ercpu': not found in kernel BTF
> >  ksyms_module/lskel                               # test_ksyms_module_l=
skel__open_and_load unexpected error: -2
> >  libbpf_get_fd_by_id_opts                         # test_libbpf_get_fd_=
by_id_opts__attach unexpected error: -524 (errno 524)
> > +linked_list
> >  lookup_key                                       # test_lookup_key__at=
tach unexpected error: -524 (errno 524)
> >  lru_bug                                          # lru_bug__attach une=
xpected error: -524 (errno 524)
> >  modify_return                                    # modify_return__atta=
ch failed unexpected error: -524 (errno 524)
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing=
/selftests/bpf/DENYLIST.s390x
> > index be4e3d47ea3e..072243af93b0 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> > +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> > @@ -33,6 +33,7 @@ ksyms_module                             # test_ksyms=
_module__open_and_load unex
> >  ksyms_module_libbpf                      # JIT does not support callin=
g kernel function                                (kfunc)
> >  ksyms_module_lskel                       # test_ksyms_module_lskel__op=
en_and_load unexpected error: -9                 (?)
> >  libbpf_get_fd_by_id_opts                 # failed to attach: ERROR: st=
rerror_r(-524)=3D22                                (trampoline)
> > +linked_list                             # JIT does not support calling=
 kernel function                                (kfunc)
> >  lookup_key                               # JIT does not support callin=
g kernel function                                (kfunc)
> >  lru_bug                                  # prog 'printk': failed to au=
to-attach: -524
> >  map_kptr                                 # failed to open_and_load pro=
gram: -524 (trampoline)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/too=
ls/testing/selftests/bpf/prog_tests/linked_list.c
> > new file mode 100644
> > index 000000000000..41e588807321
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> > @@ -0,0 +1,255 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +#include <network_helpers.h>
> > +
> > +#include "linked_list.skel.h"
> > +#include "linked_list_fail.skel.h"
> > +
> > +static char log_buf[1024 * 1024];
> > +
> > +static struct {
> > +       const char *prog_name;
> > +       const char *err_msg;
> > +} linked_list_fail_tests[] =3D {
> > +#define TEST(test, off) \
> > +       { #test "_missing_lock_push_front", \
> > +         "bpf_spin_lock at off=3D" #off " must be held for bpf_list_he=
ad" }, \
> > +       { #test "_missing_lock_push_back", \
> > +         "bpf_spin_lock at off=3D" #off " must be held for bpf_list_he=
ad" }, \
> > +       { #test "_missing_lock_pop_front", \
> > +         "bpf_spin_lock at off=3D" #off " must be held for bpf_list_he=
ad" }, \
> > +       { #test "_missing_lock_pop_back", \
> > +         "bpf_spin_lock at off=3D" #off " must be held for bpf_list_he=
ad" },
> > +       TEST(kptr, 32)
> > +       TEST(global, 16)
> > +       TEST(map, 0)
> > +       TEST(inner_map, 0)
> > +#undef TEST
> > +#define TEST(test, op) \
> > +       { #test "_kptr_incorrect_lock_" #op, \
> > +         "held lock and object are not in the same allocation\n" \
> > +         "bpf_spin_lock at off=3D32 must be held for bpf_list_head" },=
 \
> > +       { #test "_global_incorrect_lock_" #op, \
> > +         "held lock and object are not in the same allocation\n" \
> > +         "bpf_spin_lock at off=3D16 must be held for bpf_list_head" },=
 \
> > +       { #test "_map_incorrect_lock_" #op, \
> > +         "held lock and object are not in the same allocation\n" \
> > +         "bpf_spin_lock at off=3D0 must be held for bpf_list_head" }, =
\
> > +       { #test "_inner_map_incorrect_lock_" #op, \
> > +         "held lock and object are not in the same allocation\n" \
> > +         "bpf_spin_lock at off=3D0 must be held for bpf_list_head" },
> > +       TEST(kptr, push_front)
> > +       TEST(kptr, push_back)
> > +       TEST(kptr, pop_front)
> > +       TEST(kptr, pop_back)
> > +       TEST(global, push_front)
> > +       TEST(global, push_back)
> > +       TEST(global, pop_front)
> > +       TEST(global, pop_back)
> > +       TEST(map, push_front)
> > +       TEST(map, push_back)
> > +       TEST(map, pop_front)
> > +       TEST(map, pop_back)
> > +       TEST(inner_map, push_front)
> > +       TEST(inner_map, push_back)
> > +       TEST(inner_map, pop_front)
> > +       TEST(inner_map, pop_back)
> > +#undef TEST
> > +       { "map_compat_kprobe", "tracing progs cannot use bpf_list_head =
yet" },
> > +       { "map_compat_kretprobe", "tracing progs cannot use bpf_list_he=
ad yet" },
> > +       { "map_compat_tp", "tracing progs cannot use bpf_list_head yet"=
 },
> > +       { "map_compat_perf", "tracing progs cannot use bpf_list_head ye=
t" },
> > +       { "map_compat_raw_tp", "tracing progs cannot use bpf_list_head =
yet" },
> > +       { "map_compat_raw_tp_w", "tracing progs cannot use bpf_list_hea=
d yet" },
> > +       { "obj_type_id_oor", "local type ID argument must be in range [=
0, U32_MAX]" },
> > +       { "obj_new_no_composite", "bpf_obj_new type ID argument must be=
 of a struct" },
> > +       { "obj_new_no_struct", "bpf_obj_new type ID argument must be of=
 a struct" },
> > +       { "obj_drop_non_zero_off", "R1 must have zero offset when passe=
d to release func" },
> > +       { "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
> > +       { "obj_new_acq", "Unreleased reference id=3D" },
> > +       { "use_after_drop", "invalid mem access 'scalar'" },
> > +       { "ptr_walk_scalar", "type=3Dscalar expected=3Dpercpu_ptr_" },
> > +       { "direct_read_lock", "direct access to bpf_spin_lock is disall=
owed" },
> > +       { "direct_write_lock", "direct access to bpf_spin_lock is disal=
lowed" },
> > +       { "direct_read_head", "direct access to bpf_list_head is disall=
owed" },
> > +       { "direct_write_head", "direct access to bpf_list_head is disal=
lowed" },
> > +       { "direct_read_node", "direct access to bpf_list_node is disall=
owed" },
> > +       { "direct_write_node", "direct access to bpf_list_node is disal=
lowed" },
> > +       { "write_after_push_front", "only read is supported" },
> > +       { "write_after_push_back", "only read is supported" },
> > +       { "use_after_unlock_push_front", "invalid mem access 'scalar'" =
},
> > +       { "use_after_unlock_push_back", "invalid mem access 'scalar'" }=
,
> > +       { "double_push_front", "arg#1 expected pointer to allocated obj=
ect" },
> > +       { "double_push_back", "arg#1 expected pointer to allocated obje=
ct" },
> > +       { "no_node_value_type", "bpf_list_node not found at offset=3D0"=
 },
> > +       { "incorrect_value_type",
> > +         "operation on bpf_list_head expects arg#1 bpf_list_node at of=
fset=3D0 in struct foo, "
> > +         "but arg is at offset=3D0 in struct bar" },
> > +       { "incorrect_node_var_off", "variable ptr_ access var_off=3D(0x=
0; 0xffffffff) disallowed" },
> > +       { "incorrect_node_off1", "bpf_list_node not found at offset=3D1=
" },
> > +       { "incorrect_node_off2", "arg#1 offset=3D40, but expected bpf_l=
ist_node at offset=3D0 in struct foo" },
> > +       { "no_head_type", "bpf_list_head not found at offset=3D0" },
> > +       { "incorrect_head_var_off1", "R1 doesn't have constant offset" =
},
> > +       { "incorrect_head_var_off2", "variable ptr_ access var_off=3D(0=
x0; 0xffffffff) disallowed" },
> > +       { "incorrect_head_off1", "bpf_list_head not found at offset=3D1=
7" },
> > +       { "incorrect_head_off2", "bpf_list_head not found at offset=3D1=
" },
> > +       { "pop_front_off",
> > +         "15: (bf) r1 =3D r6                      ; R1_w=3Dptr_or_null=
_foo(id=3D4,ref_obj_id=3D4,off=3D40,imm=3D0) "
> > +         "R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D40,imm=3D=
0) refs=3D2,4\n"
> > +         "16: (85) call bpf_this_cpu_ptr#154\nR1 type=3Dptr_or_null_ e=
xpected=3Dpercpu_ptr_" },
> > +       { "pop_back_off",
> > +         "15: (bf) r1 =3D r6                      ; R1_w=3Dptr_or_null=
_foo(id=3D4,ref_obj_id=3D4,off=3D40,imm=3D0) "
> > +         "R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D40,imm=3D=
0) refs=3D2,4\n"
> > +         "16: (85) call bpf_this_cpu_ptr#154\nR1 type=3Dptr_or_null_ e=
xpected=3Dpercpu_ptr_" },
> > +};
> > +
>
> Hey Kumar,
>
> pop_front_off/pop_back_off validation seems to rely on exact register
> usage (r6 in this case) generated by the compiler, while the test
> itself is written in C, so really nothing is guaranteed. And that's
> exactly what seems to happen to me locally, as in my case compiler
> chose to use r7 in this particular spot (see logs below).
>
> Can you please take a look and try to make it more robust? Ideally we
> should probably rewrite BPF program to use inline assembly if we are
> to check the exact instruction index and registers.

Thanks for the report Andrii.
I'll take a look and send a patch to address this.

>
> Here are error logs:
>
> test_linked_list_fail_prog:PASS:linked_list_fail__open_opts 0 nsec
> test_linked_list_fail_prog:PASS:bpf_object__find_program_by_name 0 nsec
> libbpf: prog 'pop_front_off': BPF program load failed: Permission denied
> libbpf: prog 'pop_front_off': failed to load: -13
> libbpf: failed to load object 'linked_list_fail'
> libbpf: failed to load BPF skeleton 'linked_list_fail': -13
> test_linked_list_fail_prog:PASS:linked_list_fail__load must fail 0 nsec
> test_linked_list_fail_prog:FAIL:expected error message unexpected error: =
-13
> Expected: 15: (bf) r1 =3D r6                      ;
> R1_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)
> R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
> 16: (85) call bpf_this_cpu_ptr#154
> R1 type=3Dptr_or_null_ expected=3Dpercpu_ptr_
> Verifier: reg type unsupported for arg#0 function pop_front_off#173
> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> ; p =3D bpf_obj_new(typeof(*p));
> 0: (18) r1 =3D 0xae                     ; R1_w=3D174
> 2: (b7) r2 =3D 0                        ; R2_w=3D0
> 3: (85) call bpf_obj_new_impl#25364   ;
> R0_w=3Dptr_or_null_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
> ; if (!p)
> 4: (15) if r0 =3D=3D 0x0 goto pc+12       ;
> R0_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
> ; bpf_spin_lock(&p->lock);
> 5: (bf) r6 =3D r0                       ;
> R0_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0)
> R6_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
> 6: (07) r6 +=3D 16                      ;
> R6_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0) refs=3D2
> ; bpf_spin_lock(&p->lock);
> 7: (bf) r1 =3D r6                       ;
> R1_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0)
> R6_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0) refs=3D2
> 8: (bf) r7 =3D r0                       ;
> R0_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0)
> R7_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
> 9: (85) call bpf_spin_lock#93         ; refs=3D2
> ; n =3D op(&p->head);
> 10: (bf) r1 =3D r7                      ;
> R1_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0)
> R7=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
> 11: (85) call bpf_list_pop_front#25345        ;
> R0_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
> 12: (bf) r7 =3D r0                      ;
> R0_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)
> R7_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
> ; bpf_spin_unlock(&p->lock);
> 13: (bf) r1 =3D r6                      ;
> R1_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0)
> R6=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0) refs=3D2,4
> 14: (85) call bpf_spin_unlock#94      ; refs=3D2,4
> ; bpf_this_cpu_ptr(n);
> 15: (bf) r1 =3D r7                      ;
> R1_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)
> R7_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
> 16: (85) call bpf_this_cpu_ptr#154
> R1 type=3Dptr_or_null_ expected=3Dpercpu_ptr_, percpu_rcu_ptr_, percpu_tr=
usted_ptr_
> processed 16 insns (limit 1000000) max_states_per_insn 0 total_states
> 1 peak_states 1 mark_read 1
>
> #126/115 linked_list/pop_front_off:FAIL
> test_linked_list_fail_prog:PASS:linked_list_fail__open_opts 0 nsec
> test_linked_list_fail_prog:PASS:bpf_object__find_program_by_name 0 nsec
> libbpf: prog 'pop_back_off': BPF program load failed: Permission denied
> libbpf: prog 'pop_back_off': failed to load: -13
> libbpf: failed to load object 'linked_list_fail'
> libbpf: failed to load BPF skeleton 'linked_list_fail': -13
> test_linked_list_fail_prog:PASS:linked_list_fail__load must fail 0 nsec
> test_linked_list_fail_prog:FAIL:expected error message unexpected error: =
-13
> Expected: 15: (bf) r1 =3D r6                      ;
> R1_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)
> R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
> 16: (85) call bpf_this_cpu_ptr#154
> R1 type=3Dptr_or_null_ expected=3Dpercpu_ptr_
> Verifier: reg type unsupported for arg#0 function pop_back_off#176
> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> ; p =3D bpf_obj_new(typeof(*p));
> 0: (18) r1 =3D 0xae                     ; R1_w=3D174
> 2: (b7) r2 =3D 0                        ; R2_w=3D0
> 3: (85) call bpf_obj_new_impl#25364   ;
> R0_w=3Dptr_or_null_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
> ; if (!p)
> 4: (15) if r0 =3D=3D 0x0 goto pc+12       ;
> R0_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
> ; bpf_spin_lock(&p->lock);
> 5: (bf) r6 =3D r0                       ;
> R0_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0)
> R6_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
> 6: (07) r6 +=3D 16                      ;
> R6_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0) refs=3D2
> ; bpf_spin_lock(&p->lock);
> 7: (bf) r1 =3D r6                       ;
> R1_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0)
> R6_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0) refs=3D2
> 8: (bf) r7 =3D r0                       ;
> R0_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0)
> R7_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
> 9: (85) call bpf_spin_lock#93         ; refs=3D2
> ; n =3D op(&p->head);
> 10: (bf) r1 =3D r7                      ;
> R1_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0)
> R7=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
> 11: (85) call bpf_list_pop_back#25344         ;
> R0_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
> 12: (bf) r7 =3D r0                      ;
> R0_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)
> R7_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
> ; bpf_spin_unlock(&p->lock);
> 13: (bf) r1 =3D r6                      ;
> R1_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0)
> R6=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0) refs=3D2,4
> 14: (85) call bpf_spin_unlock#94      ; refs=3D2,4
> ; bpf_this_cpu_ptr(n);
> 15: (bf) r1 =3D r7                      ;
> R1_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)
> R7_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
> 16: (85) call bpf_this_cpu_ptr#154
> R1 type=3Dptr_or_null_ expected=3Dpercpu_ptr_, percpu_rcu_ptr_, percpu_tr=
usted_ptr_
> processed 16 insns (limit 1000000) max_states_per_insn 0 total_states
> 1 peak_states 1 mark_read 1
>
> #126/116 linked_list/pop_back_off:FAIL
>
>
> Thanks!
>
>
> [...]
>
> > +
> > +static __always_inline
> > +int pop_ptr_off(void *(*op)(void *head))
> > +{
> > +       struct {
> > +               struct bpf_list_head head __contains(foo, node2);
> > +               struct bpf_spin_lock lock;
> > +       } *p;
> > +       struct bpf_list_node *n;
> > +
> > +       p =3D bpf_obj_new(typeof(*p));
> > +       if (!p)
> > +               return 0;
> > +       bpf_spin_lock(&p->lock);
> > +       n =3D op(&p->head);
> > +       bpf_spin_unlock(&p->lock);
> > +
> > +       bpf_this_cpu_ptr(n);
> > +       return 0;
> > +}
> > +
> > +SEC("?tc")
> > +int pop_front_off(void *ctx)
> > +{
> > +       return pop_ptr_off((void *)bpf_list_pop_front);
> > +}
> > +
> > +SEC("?tc")
> > +int pop_back_off(void *ctx)
> > +{
> > +       return pop_ptr_off((void *)bpf_list_pop_back);
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > --
> > 2.38.1
> >

