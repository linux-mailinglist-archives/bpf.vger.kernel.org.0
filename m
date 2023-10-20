Return-Path: <bpf+bounces-12838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420387D11E0
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6310D1C20FF7
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 14:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE571D539;
	Fri, 20 Oct 2023 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIVulI9W"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2878819BD8
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 14:52:16 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D081D60
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 07:52:14 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-53fc7c67a41so1751616a12.0
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697813533; x=1698418333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOZQtLcLOAEMe4qjCEag2EdNtlfoJidW35bBWWM5GAA=;
        b=EIVulI9WLf5eS7/h/eQWA+S/edRXCpPUuL3w9xSbctmpYPdajIqtoBRAnIiiRhpUyg
         Qw9y70F8hFK9s8/Ma0e2IrjSQ4f7rkj3hBbfZJXq15UFDGwtRIyCzYQXHJpK+Pzw6kJa
         yklOSZlWDKX1sEf5KvaHcAMlvxxZzD3tWq61QNwxAG6FfBsK4JcI54tPGaBoeYEBNBbB
         XXr9zGDhrWb61lfP+2VAlWaKg3CROlRCOf4RNy6UKuo0Jl16BE/HjPuJtCZvDsZojqI+
         MdXXoMer6Kp5c96TQPXKw5Ds6TvC908XRK4yY9C2+2+BlrD0QJUrFd8hzb6KB5jgZGFG
         Q0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697813533; x=1698418333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOZQtLcLOAEMe4qjCEag2EdNtlfoJidW35bBWWM5GAA=;
        b=ZEW77OLiek4H1hBf9ASlWqu744Wj4SDfoeYLcP+RryAfP91gE259Fxv7KqwQA2MxMc
         Xd9l9saqGxYE27Qi9e9G/moCsvesaEyqgcJb6PMNSlAyZDMTGV9BWENoZuh/JIOl2Yec
         WoCK7yTAcUzVUrOe+pB4CVE5jobPDTA/BttKCj5QvMf4xnEHwjUaZhr9mKoyTqBXHHGw
         33GHnBdYDEVBRgg25krU2it2r0LV6uS3Blf2SvpVMF5cnUEz1DMQkhrWwjs95EHKQSos
         xX15jo1Yqh8TB/6lLgZl/HWHS8VQUm9I6MzO7e42oQPC09OZ6Vu/RWqT41DdrLb1v2oY
         itPw==
X-Gm-Message-State: AOJu0YzGSZUBGfmKv9fPqE2OgI7yfJw7smmtrd5iGo2QhnOu+ISihP7I
	2/dk1JBMwqXkHzfa3pd0LGydSLCGTsFOtjTBNdw=
X-Google-Smtp-Source: AGHT+IGZkx28PhnnIwjD7pkBH9xtGqp/CYX4U4EU+jR6dpGLlIDFfvHjBDyVdlhCBjwyFll1aE4QRSEK/r0SikMhbao=
X-Received: by 2002:a50:9e66:0:b0:53e:ae04:40ec with SMTP id
 z93-20020a509e66000000b0053eae0440ecmr1855164ede.18.1697813532374; Fri, 20
 Oct 2023 07:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221118015614.2013203-1-memxor@gmail.com> <20221118015614.2013203-23-memxor@gmail.com>
 <CAEf4BzY0h8pPn3gWGg2D5TvEy8z_EROb_jMdiqjWWo_vL87g7w@mail.gmail.com>
 <CAP01T76SybiQeoH91tsDuWn4DU1Ba_8H53AuQP8QedZyc3ZKbg@mail.gmail.com> <CAEf4BzZZrRW7MQOEhJ28sx0N_F-o0OzT+EEnvKh1h3inXhpYEQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZZrRW7MQOEhJ28sx0N_F-o0OzT+EEnvKh1h3inXhpYEQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 20 Oct 2023 16:51:35 +0200
Message-ID: <CAP01T75YbRK65vi9zgZpZmqrkd0bFWhm3ydKL3Snt2ueb7H7RQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 22/24] selftests/bpf: Add BPF linked list API tests
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Dave Marchevsky <davemarchevsky@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Oct 2023 at 02:15, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Wed, Oct 11, 2023 at 4:02=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Thu, 12 Oct 2023 at 00:44, Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
> > >
> > > On Thu, Nov 17, 2022 at 5:57=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > Include various tests covering the success and failure cases. Also,=
 run
> > > > the success cases at runtime to verify correctness of linked list
> > > > manipulation routines, in addition to ensuring successful verificat=
ion.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
> > > >  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
> > > >  .../selftests/bpf/prog_tests/linked_list.c    | 255 ++++++++
> > > >  .../testing/selftests/bpf/progs/linked_list.c | 370 +++++++++++
> > > >  .../testing/selftests/bpf/progs/linked_list.h |  56 ++
> > > >  .../selftests/bpf/progs/linked_list_fail.c    | 581 ++++++++++++++=
++++
> > > >  6 files changed, 1264 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/linked_l=
ist.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/linked_list.c
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/linked_list.h
> > > >  create mode 100644 tools/testing/selftests/bpf/progs/linked_list_f=
ail.c
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/t=
esting/selftests/bpf/DENYLIST.aarch64
> > > > index 09416d5d2e33..affc5aebbf0f 100644
> > > > --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> > > > +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> > > > @@ -38,6 +38,7 @@ kprobe_multi_test/skel_api                       =
# kprobe_multi__attach unexpect
> > > >  ksyms_module/libbpf                              # 'bpf_testmod_ks=
ym_percpu': not found in kernel BTF
> > > >  ksyms_module/lskel                               # test_ksyms_modu=
le_lskel__open_and_load unexpected error: -2
> > > >  libbpf_get_fd_by_id_opts                         # test_libbpf_get=
_fd_by_id_opts__attach unexpected error: -524 (errno 524)
> > > > +linked_list
> > > >  lookup_key                                       # test_lookup_key=
__attach unexpected error: -524 (errno 524)
> > > >  lru_bug                                          # lru_bug__attach=
 unexpected error: -524 (errno 524)
> > > >  modify_return                                    # modify_return__=
attach failed unexpected error: -524 (errno 524)
> > > > diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/tes=
ting/selftests/bpf/DENYLIST.s390x
> > > > index be4e3d47ea3e..072243af93b0 100644
> > > > --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> > > > +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> > > > @@ -33,6 +33,7 @@ ksyms_module                             # test_k=
syms_module__open_and_load unex
> > > >  ksyms_module_libbpf                      # JIT does not support ca=
lling kernel function                                (kfunc)
> > > >  ksyms_module_lskel                       # test_ksyms_module_lskel=
__open_and_load unexpected error: -9                 (?)
> > > >  libbpf_get_fd_by_id_opts                 # failed to attach: ERROR=
: strerror_r(-524)=3D22                                (trampoline)
> > > > +linked_list                             # JIT does not support cal=
ling kernel function                                (kfunc)
> > > >  lookup_key                               # JIT does not support ca=
lling kernel function                                (kfunc)
> > > >  lru_bug                                  # prog 'printk': failed t=
o auto-attach: -524
> > > >  map_kptr                                 # failed to open_and_load=
 program: -524 (trampoline)
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b=
/tools/testing/selftests/bpf/prog_tests/linked_list.c
> > > > new file mode 100644
> > > > index 000000000000..41e588807321
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> > > > @@ -0,0 +1,255 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +#include <test_progs.h>
> > > > +#include <network_helpers.h>
> > > > +
> > > > +#include "linked_list.skel.h"
> > > > +#include "linked_list_fail.skel.h"
> > > > +
> > > > +static char log_buf[1024 * 1024];
> > > > +
> > > > +static struct {
> > > > +       const char *prog_name;
> > > > +       const char *err_msg;
> > > > +} linked_list_fail_tests[] =3D {
> > > > +#define TEST(test, off) \
> > > > +       { #test "_missing_lock_push_front", \
> > > > +         "bpf_spin_lock at off=3D" #off " must be held for bpf_lis=
t_head" }, \
> > > > +       { #test "_missing_lock_push_back", \
> > > > +         "bpf_spin_lock at off=3D" #off " must be held for bpf_lis=
t_head" }, \
> > > > +       { #test "_missing_lock_pop_front", \
> > > > +         "bpf_spin_lock at off=3D" #off " must be held for bpf_lis=
t_head" }, \
> > > > +       { #test "_missing_lock_pop_back", \
> > > > +         "bpf_spin_lock at off=3D" #off " must be held for bpf_lis=
t_head" },
> > > > +       TEST(kptr, 32)
> > > > +       TEST(global, 16)
> > > > +       TEST(map, 0)
> > > > +       TEST(inner_map, 0)
> > > > +#undef TEST
> > > > +#define TEST(test, op) \
> > > > +       { #test "_kptr_incorrect_lock_" #op, \
> > > > +         "held lock and object are not in the same allocation\n" \
> > > > +         "bpf_spin_lock at off=3D32 must be held for bpf_list_head=
" }, \
> > > > +       { #test "_global_incorrect_lock_" #op, \
> > > > +         "held lock and object are not in the same allocation\n" \
> > > > +         "bpf_spin_lock at off=3D16 must be held for bpf_list_head=
" }, \
> > > > +       { #test "_map_incorrect_lock_" #op, \
> > > > +         "held lock and object are not in the same allocation\n" \
> > > > +         "bpf_spin_lock at off=3D0 must be held for bpf_list_head"=
 }, \
> > > > +       { #test "_inner_map_incorrect_lock_" #op, \
> > > > +         "held lock and object are not in the same allocation\n" \
> > > > +         "bpf_spin_lock at off=3D0 must be held for bpf_list_head"=
 },
> > > > +       TEST(kptr, push_front)
> > > > +       TEST(kptr, push_back)
> > > > +       TEST(kptr, pop_front)
> > > > +       TEST(kptr, pop_back)
> > > > +       TEST(global, push_front)
> > > > +       TEST(global, push_back)
> > > > +       TEST(global, pop_front)
> > > > +       TEST(global, pop_back)
> > > > +       TEST(map, push_front)
> > > > +       TEST(map, push_back)
> > > > +       TEST(map, pop_front)
> > > > +       TEST(map, pop_back)
> > > > +       TEST(inner_map, push_front)
> > > > +       TEST(inner_map, push_back)
> > > > +       TEST(inner_map, pop_front)
> > > > +       TEST(inner_map, pop_back)
> > > > +#undef TEST
> > > > +       { "map_compat_kprobe", "tracing progs cannot use bpf_list_h=
ead yet" },
> > > > +       { "map_compat_kretprobe", "tracing progs cannot use bpf_lis=
t_head yet" },
> > > > +       { "map_compat_tp", "tracing progs cannot use bpf_list_head =
yet" },
> > > > +       { "map_compat_perf", "tracing progs cannot use bpf_list_hea=
d yet" },
> > > > +       { "map_compat_raw_tp", "tracing progs cannot use bpf_list_h=
ead yet" },
> > > > +       { "map_compat_raw_tp_w", "tracing progs cannot use bpf_list=
_head yet" },
> > > > +       { "obj_type_id_oor", "local type ID argument must be in ran=
ge [0, U32_MAX]" },
> > > > +       { "obj_new_no_composite", "bpf_obj_new type ID argument mus=
t be of a struct" },
> > > > +       { "obj_new_no_struct", "bpf_obj_new type ID argument must b=
e of a struct" },
> > > > +       { "obj_drop_non_zero_off", "R1 must have zero offset when p=
assed to release func" },
> > > > +       { "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
> > > > +       { "obj_new_acq", "Unreleased reference id=3D" },
> > > > +       { "use_after_drop", "invalid mem access 'scalar'" },
> > > > +       { "ptr_walk_scalar", "type=3Dscalar expected=3Dpercpu_ptr_"=
 },
> > > > +       { "direct_read_lock", "direct access to bpf_spin_lock is di=
sallowed" },
> > > > +       { "direct_write_lock", "direct access to bpf_spin_lock is d=
isallowed" },
> > > > +       { "direct_read_head", "direct access to bpf_list_head is di=
sallowed" },
> > > > +       { "direct_write_head", "direct access to bpf_list_head is d=
isallowed" },
> > > > +       { "direct_read_node", "direct access to bpf_list_node is di=
sallowed" },
> > > > +       { "direct_write_node", "direct access to bpf_list_node is d=
isallowed" },
> > > > +       { "write_after_push_front", "only read is supported" },
> > > > +       { "write_after_push_back", "only read is supported" },
> > > > +       { "use_after_unlock_push_front", "invalid mem access 'scala=
r'" },
> > > > +       { "use_after_unlock_push_back", "invalid mem access 'scalar=
'" },
> > > > +       { "double_push_front", "arg#1 expected pointer to allocated=
 object" },
> > > > +       { "double_push_back", "arg#1 expected pointer to allocated =
object" },
> > > > +       { "no_node_value_type", "bpf_list_node not found at offset=
=3D0" },
> > > > +       { "incorrect_value_type",
> > > > +         "operation on bpf_list_head expects arg#1 bpf_list_node a=
t offset=3D0 in struct foo, "
> > > > +         "but arg is at offset=3D0 in struct bar" },
> > > > +       { "incorrect_node_var_off", "variable ptr_ access var_off=
=3D(0x0; 0xffffffff) disallowed" },
> > > > +       { "incorrect_node_off1", "bpf_list_node not found at offset=
=3D1" },
> > > > +       { "incorrect_node_off2", "arg#1 offset=3D40, but expected b=
pf_list_node at offset=3D0 in struct foo" },
> > > > +       { "no_head_type", "bpf_list_head not found at offset=3D0" }=
,
> > > > +       { "incorrect_head_var_off1", "R1 doesn't have constant offs=
et" },
> > > > +       { "incorrect_head_var_off2", "variable ptr_ access var_off=
=3D(0x0; 0xffffffff) disallowed" },
> > > > +       { "incorrect_head_off1", "bpf_list_head not found at offset=
=3D17" },
> > > > +       { "incorrect_head_off2", "bpf_list_head not found at offset=
=3D1" },
> > > > +       { "pop_front_off",
> > > > +         "15: (bf) r1 =3D r6                      ; R1_w=3Dptr_or_=
null_foo(id=3D4,ref_obj_id=3D4,off=3D40,imm=3D0) "
> > > > +         "R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D40,im=
m=3D0) refs=3D2,4\n"
> > > > +         "16: (85) call bpf_this_cpu_ptr#154\nR1 type=3Dptr_or_nul=
l_ expected=3Dpercpu_ptr_" },
> > > > +       { "pop_back_off",
> > > > +         "15: (bf) r1 =3D r6                      ; R1_w=3Dptr_or_=
null_foo(id=3D4,ref_obj_id=3D4,off=3D40,imm=3D0) "
> > > > +         "R6_w=3Dptr_or_null_foo(id=3D4,ref_obj_id=3D4,off=3D40,im=
m=3D0) refs=3D2,4\n"
> > > > +         "16: (85) call bpf_this_cpu_ptr#154\nR1 type=3Dptr_or_nul=
l_ expected=3Dpercpu_ptr_" },
> > > > +};
> > > > +
> > >
> > > Hey Kumar,
> > >
> > > pop_front_off/pop_back_off validation seems to rely on exact register
> > > usage (r6 in this case) generated by the compiler, while the test
> > > itself is written in C, so really nothing is guaranteed. And that's
> > > exactly what seems to happen to me locally, as in my case compiler
> > > chose to use r7 in this particular spot (see logs below).
> > >
> > > Can you please take a look and try to make it more robust? Ideally we
> > > should probably rewrite BPF program to use inline assembly if we are
> > > to check the exact instruction index and registers.
> >
> > Thanks for the report Andrii.
> > I'll take a look and send a patch to address this.
>
> Friendly ping! Did you get a chance to look at this?
>

Hi Andrii, sorry for the delay. The fix should be relatively simple,
we just need to check whether the offset on the returned pointer is
48.
I have posted a fix here, PTAL. Thanks.

https://lore.kernel.org/bpf/20231020144839.2734006-1-memxor@gmail.com

