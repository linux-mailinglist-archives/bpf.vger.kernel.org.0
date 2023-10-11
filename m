Return-Path: <bpf+bounces-11970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB747C6082
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B731C20D50
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 22:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9356B12E7B;
	Wed, 11 Oct 2023 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS7GlkHz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76F24A07
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:44:29 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EE4EB
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:44:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso4029315e9.2
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697064256; x=1697669056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLIvdysvZufGSXSWOY6j9baFS8fo5pqjvSKIrHFy3VQ=;
        b=kS7GlkHzMBcw+JZdwPdpzlJ18g4Du8Afms9nMjCU1MEdmX0Nl83NClolX4X20niHNU
         nA3ebO4XOLy/Lu46NTT3hoTOIi1VIT+TOfrD39bt4kfyn4HCJidi4alk2NCArupTq8Ij
         dla6U/xrSnUIix54hyfDhpxH6a1PS0jnOXHjW/vEQWOExrsPonrcaK7lLkmG7mfkdEho
         NZOw+x0suD4h4QAcoSnO7MpcYbybUPd+LzvZkksc5/xpgg9CPStZMxQvOmTcmGEtGFaO
         9MwJu5iay5T60ovIzizFUJH7Jo1N4sy5vSw/j6z5U/1LZ1hhEqUgH0oWJ7YOxC7wTL1/
         TpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064256; x=1697669056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLIvdysvZufGSXSWOY6j9baFS8fo5pqjvSKIrHFy3VQ=;
        b=T2z4O7J/VRr53D3c5Zo9imnHEXu4zgoT8JaSaH7sMmPSPvN5rqd1UnmkiCyfhDQPUB
         +OtLidBjVsRTj8dLQRcFRkkD9RfuUEj1Ddg0f/6vXaPASAzI16KW5FWT/9o8nLhv7EOv
         IIFMBT2ryfuDTv9IfdHeBQn1kAUt6/NQst1IMpj4eLq6/XZ8qCIpA4oVC+IV4O+C4fJZ
         p94FoZZ28kTK9iMesdaRtgIjm84UZwPWMUY5IherQ1BJKqk7PN2H9VhIq8uTF/yP9Mfi
         QN0WRu2DG7JGx/V00B6aWO6uQmQruRRT+6sbxYMyXL0Bx93rBWySq1x5xpQ1u7US+K93
         H2BA==
X-Gm-Message-State: AOJu0YxNl+ignArO+xwSEFizoyyfIIi8OZM58QvpHhUU9GbiarzbzF17
	QkkdOeS+0+MJL7XzO+2d3wyusWM9D1nLyIQwbCE=
X-Google-Smtp-Source: AGHT+IGmpj6B1eBjc4rF6E+agXjt8B+M0UhuwwAWy6UB1GBM2pg7WESEQfPbW8X1lOOOOUk/1/7i9bqguCebYrNUeVM=
X-Received: by 2002:adf:e388:0:b0:31a:e73f:3fe7 with SMTP id
 e8-20020adfe388000000b0031ae73f3fe7mr19009421wrm.3.1697064255507; Wed, 11 Oct
 2023 15:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221118015614.2013203-1-memxor@gmail.com> <20221118015614.2013203-23-memxor@gmail.com>
In-Reply-To: <20221118015614.2013203-23-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Oct 2023 15:44:03 -0700
Message-ID: <CAEf4BzY0h8pPn3gWGg2D5TvEy8z_EROb_jMdiqjWWo_vL87g7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 22/24] selftests/bpf: Add BPF linked list API tests
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Thu, Nov 17, 2022 at 5:57=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Include various tests covering the success and failure cases. Also, run
> the success cases at runtime to verify correctness of linked list
> manipulation routines, in addition to ensuring successful verification.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>  .../selftests/bpf/prog_tests/linked_list.c    | 255 ++++++++
>  .../testing/selftests/bpf/progs/linked_list.c | 370 +++++++++++
>  .../testing/selftests/bpf/progs/linked_list.h |  56 ++
>  .../selftests/bpf/progs/linked_list_fail.c    | 581 ++++++++++++++++++
>  6 files changed, 1264 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_list.c
>  create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c
>  create mode 100644 tools/testing/selftests/bpf/progs/linked_list.h
>  create mode 100644 tools/testing/selftests/bpf/progs/linked_list_fail.c
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing=
/selftests/bpf/DENYLIST.aarch64
> index 09416d5d2e33..affc5aebbf0f 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -38,6 +38,7 @@ kprobe_multi_test/skel_api                       # kpro=
be_multi__attach unexpect
>  ksyms_module/libbpf                              # 'bpf_testmod_ksym_per=
cpu': not found in kernel BTF
>  ksyms_module/lskel                               # test_ksyms_module_lsk=
el__open_and_load unexpected error: -2
>  libbpf_get_fd_by_id_opts                         # test_libbpf_get_fd_by=
_id_opts__attach unexpected error: -524 (errno 524)
> +linked_list
>  lookup_key                                       # test_lookup_key__atta=
ch unexpected error: -524 (errno 524)
>  lru_bug                                          # lru_bug__attach unexp=
ected error: -524 (errno 524)
>  modify_return                                    # modify_return__attach=
 failed unexpected error: -524 (errno 524)
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/s=
elftests/bpf/DENYLIST.s390x
> index be4e3d47ea3e..072243af93b0 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -33,6 +33,7 @@ ksyms_module                             # test_ksyms_m=
odule__open_and_load unex
>  ksyms_module_libbpf                      # JIT does not support calling =
kernel function                                (kfunc)
>  ksyms_module_lskel                       # test_ksyms_module_lskel__open=
_and_load unexpected error: -9                 (?)
>  libbpf_get_fd_by_id_opts                 # failed to attach: ERROR: stre=
rror_r(-524)=3D22                                (trampoline)
> +linked_list                             # JIT does not support calling k=
ernel function                                (kfunc)
>  lookup_key                               # JIT does not support calling =
kernel function                                (kfunc)
>  lru_bug                                  # prog 'printk': failed to auto=
-attach: -524
>  map_kptr                                 # failed to open_and_load progr=
am: -524 (trampoline)
> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools=
/testing/selftests/bpf/prog_tests/linked_list.c
> new file mode 100644
> index 000000000000..41e588807321
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +
> +#include "linked_list.skel.h"
> +#include "linked_list_fail.skel.h"
> +
> +static char log_buf[1024 * 1024];
> +
> +static struct {
> +       const char *prog_name;
> +       const char *err_msg;
> +} linked_list_fail_tests[] =3D {
> +#define TEST(test, off) \
> +       { #test "_missing_lock_push_front", \
> +         "bpf_spin_lock at off=3D" #off " must be held for bpf_list_head=
" }, \
> +       { #test "_missing_lock_push_back", \
> +         "bpf_spin_lock at off=3D" #off " must be held for bpf_list_head=
" }, \
> +       { #test "_missing_lock_pop_front", \
> +         "bpf_spin_lock at off=3D" #off " must be held for bpf_list_head=
" }, \
> +       { #test "_missing_lock_pop_back", \
> +         "bpf_spin_lock at off=3D" #off " must be held for bpf_list_head=
" },
> +       TEST(kptr, 32)
> +       TEST(global, 16)
> +       TEST(map, 0)
> +       TEST(inner_map, 0)
> +#undef TEST
> +#define TEST(test, op) \
> +       { #test "_kptr_incorrect_lock_" #op, \
> +         "held lock and object are not in the same allocation\n" \
> +         "bpf_spin_lock at off=3D32 must be held for bpf_list_head" }, \
> +       { #test "_global_incorrect_lock_" #op, \
> +         "held lock and object are not in the same allocation\n" \
> +         "bpf_spin_lock at off=3D16 must be held for bpf_list_head" }, \
> +       { #test "_map_incorrect_lock_" #op, \
> +         "held lock and object are not in the same allocation\n" \
> +         "bpf_spin_lock at off=3D0 must be held for bpf_list_head" }, \
> +       { #test "_inner_map_incorrect_lock_" #op, \
> +         "held lock and object are not in the same allocation\n" \
> +         "bpf_spin_lock at off=3D0 must be held for bpf_list_head" },
> +       TEST(kptr, push_front)
> +       TEST(kptr, push_back)
> +       TEST(kptr, pop_front)
> +       TEST(kptr, pop_back)
> +       TEST(global, push_front)
> +       TEST(global, push_back)
> +       TEST(global, pop_front)
> +       TEST(global, pop_back)
> +       TEST(map, push_front)
> +       TEST(map, push_back)
> +       TEST(map, pop_front)
> +       TEST(map, pop_back)
> +       TEST(inner_map, push_front)
> +       TEST(inner_map, push_back)
> +       TEST(inner_map, pop_front)
> +       TEST(inner_map, pop_back)
> +#undef TEST
> +       { "map_compat_kprobe", "tracing progs cannot use bpf_list_head ye=
t" },
> +       { "map_compat_kretprobe", "tracing progs cannot use bpf_list_head=
 yet" },
> +       { "map_compat_tp", "tracing progs cannot use bpf_list_head yet" }=
,
> +       { "map_compat_perf", "tracing progs cannot use bpf_list_head yet"=
 },
> +       { "map_compat_raw_tp", "tracing progs cannot use bpf_list_head ye=
t" },
> +       { "map_compat_raw_tp_w", "tracing progs cannot use bpf_list_head =
yet" },
> +       { "obj_type_id_oor", "local type ID argument must be in range [0,=
 U32_MAX]" },
> +       { "obj_new_no_composite", "bpf_obj_new type ID argument must be o=
f a struct" },
> +       { "obj_new_no_struct", "bpf_obj_new type ID argument must be of a=
 struct" },
> +       { "obj_drop_non_zero_off", "R1 must have zero offset when passed =
to release func" },
> +       { "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
> +       { "obj_new_acq", "Unreleased reference id=3D" },
> +       { "use_after_drop", "invalid mem access 'scalar'" },
> +       { "ptr_walk_scalar", "type=3Dscalar expected=3Dpercpu_ptr_" },
> +       { "direct_read_lock", "direct access to bpf_spin_lock is disallow=
ed" },
> +       { "direct_write_lock", "direct access to bpf_spin_lock is disallo=
wed" },
> +       { "direct_read_head", "direct access to bpf_list_head is disallow=
ed" },
> +       { "direct_write_head", "direct access to bpf_list_head is disallo=
wed" },
> +       { "direct_read_node", "direct access to bpf_list_node is disallow=
ed" },
> +       { "direct_write_node", "direct access to bpf_list_node is disallo=
wed" },
> +       { "write_after_push_front", "only read is supported" },
> +       { "write_after_push_back", "only read is supported" },
> +       { "use_after_unlock_push_front", "invalid mem access 'scalar'" },
> +       { "use_after_unlock_push_back", "invalid mem access 'scalar'" },
> +       { "double_push_front", "arg#1 expected pointer to allocated objec=
t" },
> +       { "double_push_back", "arg#1 expected pointer to allocated object=
" },
> +       { "no_node_value_type", "bpf_list_node not found at offset=3D0" }=
,
> +       { "incorrect_value_type",
> +         "operation on bpf_list_head expects arg#1 bpf_list_node at offs=
et=3D0 in struct foo, "
> +         "but arg is at offset=3D0 in struct bar" },
> +       { "incorrect_node_var_off", "variable ptr_ access var_off=3D(0x0;=
 0xffffffff) disallowed" },
> +       { "incorrect_node_off1", "bpf_list_node not found at offset=3D1" =
},
> +       { "incorrect_node_off2", "arg#1 offset=3D40, but expected bpf_lis=
t_node at offset=3D0 in struct foo" },
> +       { "no_head_type", "bpf_list_head not found at offset=3D0" },
> +       { "incorrect_head_var_off1", "R1 doesn't have constant offset" },
> +       { "incorrect_head_var_off2", "variable ptr_ access var_off=3D(0x0=
; 0xffffffff) disallowed" },
> +       { "incorrect_head_off1", "bpf_list_head not found at offset=3D17"=
 },
> +       { "incorrect_head_off2", "bpf_list_head not found at offset=3D1" =
},
> +       { "pop_front_off",
> +         "15: (bf) r1 =3D r6                      ; R1_w=3Dptr_or_null_f=
oo(id=3D4,ref_obj_id=3D4,off=3D40,imm=3D0) "
> +         "R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D40,imm=3D0)=
 refs=3D2,4\n"
> +         "16: (85) call bpf_this_cpu_ptr#154\nR1 type=3Dptr_or_null_ exp=
ected=3Dpercpu_ptr_" },
> +       { "pop_back_off",
> +         "15: (bf) r1 =3D r6                      ; R1_w=3Dptr_or_null_f=
oo(id=3D4,ref_obj_id=3D4,off=3D40,imm=3D0) "
> +         "R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D40,imm=3D0)=
 refs=3D2,4\n"
> +         "16: (85) call bpf_this_cpu_ptr#154\nR1 type=3Dptr_or_null_ exp=
ected=3Dpercpu_ptr_" },
> +};
> +

Hey Kumar,

pop_front_off/pop_back_off validation seems to rely on exact register
usage (r6 in this case) generated by the compiler, while the test
itself is written in C, so really nothing is guaranteed. And that's
exactly what seems to happen to me locally, as in my case compiler
chose to use r7 in this particular spot (see logs below).

Can you please take a look and try to make it more robust? Ideally we
should probably rewrite BPF program to use inline assembly if we are
to check the exact instruction index and registers.

Here are error logs:

test_linked_list_fail_prog:PASS:linked_list_fail__open_opts 0 nsec
test_linked_list_fail_prog:PASS:bpf_object__find_program_by_name 0 nsec
libbpf: prog 'pop_front_off': BPF program load failed: Permission denied
libbpf: prog 'pop_front_off': failed to load: -13
libbpf: failed to load object 'linked_list_fail'
libbpf: failed to load BPF skeleton 'linked_list_fail': -13
test_linked_list_fail_prog:PASS:linked_list_fail__load must fail 0 nsec
test_linked_list_fail_prog:FAIL:expected error message unexpected error: -1=
3
Expected: 15: (bf) r1 =3D r6                      ;
R1_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)
R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
16: (85) call bpf_this_cpu_ptr#154
R1 type=3Dptr_or_null_ expected=3Dpercpu_ptr_
Verifier: reg type unsupported for arg#0 function pop_front_off#173
0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
; p =3D bpf_obj_new(typeof(*p));
0: (18) r1 =3D 0xae                     ; R1_w=3D174
2: (b7) r2 =3D 0                        ; R2_w=3D0
3: (85) call bpf_obj_new_impl#25364   ;
R0_w=3Dptr_or_null_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
; if (!p)
4: (15) if r0 =3D=3D 0x0 goto pc+12       ;
R0_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
; bpf_spin_lock(&p->lock);
5: (bf) r6 =3D r0                       ;
R0_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0)
R6_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
6: (07) r6 +=3D 16                      ;
R6_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0) refs=3D2
; bpf_spin_lock(&p->lock);
7: (bf) r1 =3D r6                       ;
R1_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0)
R6_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0) refs=3D2
8: (bf) r7 =3D r0                       ;
R0_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0)
R7_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
9: (85) call bpf_spin_lock#93         ; refs=3D2
; n =3D op(&p->head);
10: (bf) r1 =3D r7                      ;
R1_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0)
R7=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
11: (85) call bpf_list_pop_front#25345        ;
R0_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
12: (bf) r7 =3D r0                      ;
R0_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)
R7_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
; bpf_spin_unlock(&p->lock);
13: (bf) r1 =3D r6                      ;
R1_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0)
R6=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0) refs=3D2,4
14: (85) call bpf_spin_unlock#94      ; refs=3D2,4
; bpf_this_cpu_ptr(n);
15: (bf) r1 =3D r7                      ;
R1_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)
R7_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
16: (85) call bpf_this_cpu_ptr#154
R1 type=3Dptr_or_null_ expected=3Dpercpu_ptr_, percpu_rcu_ptr_, percpu_trus=
ted_ptr_
processed 16 insns (limit 1000000) max_states_per_insn 0 total_states
1 peak_states 1 mark_read 1

#126/115 linked_list/pop_front_off:FAIL
test_linked_list_fail_prog:PASS:linked_list_fail__open_opts 0 nsec
test_linked_list_fail_prog:PASS:bpf_object__find_program_by_name 0 nsec
libbpf: prog 'pop_back_off': BPF program load failed: Permission denied
libbpf: prog 'pop_back_off': failed to load: -13
libbpf: failed to load object 'linked_list_fail'
libbpf: failed to load BPF skeleton 'linked_list_fail': -13
test_linked_list_fail_prog:PASS:linked_list_fail__load must fail 0 nsec
test_linked_list_fail_prog:FAIL:expected error message unexpected error: -1=
3
Expected: 15: (bf) r1 =3D r6                      ;
R1_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)
R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
16: (85) call bpf_this_cpu_ptr#154
R1 type=3Dptr_or_null_ expected=3Dpercpu_ptr_
Verifier: reg type unsupported for arg#0 function pop_back_off#176
0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
; p =3D bpf_obj_new(typeof(*p));
0: (18) r1 =3D 0xae                     ; R1_w=3D174
2: (b7) r2 =3D 0                        ; R2_w=3D0
3: (85) call bpf_obj_new_impl#25364   ;
R0_w=3Dptr_or_null_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
; if (!p)
4: (15) if r0 =3D=3D 0x0 goto pc+12       ;
R0_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
; bpf_spin_lock(&p->lock);
5: (bf) r6 =3D r0                       ;
R0_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0)
R6_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
6: (07) r6 +=3D 16                      ;
R6_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0) refs=3D2
; bpf_spin_lock(&p->lock);
7: (bf) r1 =3D r6                       ;
R1_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0)
R6_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0) refs=3D2
8: (bf) r7 =3D r0                       ;
R0_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0)
R7_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
9: (85) call bpf_spin_lock#93         ; refs=3D2
; n =3D op(&p->head);
10: (bf) r1 =3D r7                      ;
R1_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0)
R7=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D0,imm=3D0) refs=3D2
11: (85) call bpf_list_pop_back#25344         ;
R0_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
12: (bf) r7 =3D r0                      ;
R0_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)
R7_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
; bpf_spin_unlock(&p->lock);
13: (bf) r1 =3D r6                      ;
R1_w=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0)
R6=3Dptr_(id=3D2,ref_obj_id=3D2,off=3D16,imm=3D0) refs=3D2,4
14: (85) call bpf_spin_unlock#94      ; refs=3D2,4
; bpf_this_cpu_ptr(n);
15: (bf) r1 =3D r7                      ;
R1_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0)
R7_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D48,imm=3D0) refs=3D2,4
16: (85) call bpf_this_cpu_ptr#154
R1 type=3Dptr_or_null_ expected=3Dpercpu_ptr_, percpu_rcu_ptr_, percpu_trus=
ted_ptr_
processed 16 insns (limit 1000000) max_states_per_insn 0 total_states
1 peak_states 1 mark_read 1

#126/116 linked_list/pop_back_off:FAIL


Thanks!


[...]

> +
> +static __always_inline
> +int pop_ptr_off(void *(*op)(void *head))
> +{
> +       struct {
> +               struct bpf_list_head head __contains(foo, node2);
> +               struct bpf_spin_lock lock;
> +       } *p;
> +       struct bpf_list_node *n;
> +
> +       p =3D bpf_obj_new(typeof(*p));
> +       if (!p)
> +               return 0;
> +       bpf_spin_lock(&p->lock);
> +       n =3D op(&p->head);
> +       bpf_spin_unlock(&p->lock);
> +
> +       bpf_this_cpu_ptr(n);
> +       return 0;
> +}
> +
> +SEC("?tc")
> +int pop_front_off(void *ctx)
> +{
> +       return pop_ptr_off((void *)bpf_list_pop_front);
> +}
> +
> +SEC("?tc")
> +int pop_back_off(void *ctx)
> +{
> +       return pop_ptr_off((void *)bpf_list_pop_back);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.38.1
>

