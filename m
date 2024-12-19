Return-Path: <bpf+bounces-47357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C139F864B
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 21:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5564C16E459
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 20:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5DD19DF60;
	Thu, 19 Dec 2024 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M07zn216"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F38C147;
	Thu, 19 Dec 2024 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641407; cv=none; b=cCT6ddz66ByCCeMxNxRYE4R6CLaAnkNr1rp1pk4EZ/0EIV5KGZ8bj2jnO7T7NXZzYQgbPw4vEA6K5N4FCQls1FDhl8/2ANOKNmWVFAmtZqBdne8zbLtCBk3JQG86/JyQnGr/ToWa9emaEkAqU15r0UC9/KBz56Lc7v3V+gyZiLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641407; c=relaxed/simple;
	bh=AwLeNMr7klnYTB9oSkdjlyFhOaUqWb0//dbtX6f7VjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQcbLTxlTFebOGsR6Gfg8WJehKDVqbZ7hnnH/xr+8d59vU4U/AYvtO6F/O+2sl/+ARjVtpJhvmYV4vTRteHo9pEjtqr7U+1MXISwVhOLqB4x140Yt+lR+uI7QsMDQ+QfnbREaWE3l/JdRorVC2QQ5rrZELDZ5XNBlfayqLq9ezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M07zn216; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f00b10bc1dso10774567b3.3;
        Thu, 19 Dec 2024 12:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734641403; x=1735246203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPyjLo+/vlNdwC7BVchJoSOTV+i9znnwKlG2PENk6PA=;
        b=M07zn2167cXbHpSXWaHEOZA0MqumSp5KaY3DpIuTtjO+6c9lZI4TX5kvqH4zEstuOx
         QGdBqe4ZWfZmnVGsbyUfqr51twBziI64CTBtsQAWqGRiXzOp/kzV/IpmnGjcCsQeehN0
         Zr03o2nlRXCvnoq/r+QSuJSyk3zJV/LqxR+21PrbjFKU/dME905hh5q/zFGdhtwBS2AT
         UCiSMASSaohBSU/L/9s4ROBFvCrEMKKWP5ndQPoxmIsuvN7s9JxGDMaSpLy2GQZ74eI4
         sxtEO8mXAjkZhI4lrQicz5f+9ldXN0f/YB+HJt2HVVPJF1Li89Ig9x9xZzlaFgIYm+Ok
         UD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734641403; x=1735246203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPyjLo+/vlNdwC7BVchJoSOTV+i9znnwKlG2PENk6PA=;
        b=ZH8Q/NdDCf1Wjd11WcUJ61iGeZnlU46H36XOe0SJfDVRChQHhtbJ0rOL6pibN8Pv3v
         MwYxPnmPJGVs2n/JFJoQcfe2KtlFO0fRL0tYQsx8CrsWCpn6KDYaUuRILiADFf7pXr4B
         uM81V+iO3NK7T2bQQMeYbNEf3Ldpnbbrgyeb3xyRPh3SC97aJRhQy3RGhgWEaksXrVBU
         LLt4GKXCtxMOZEZcoaF9rUzUrDrB1WDM8czwt97BKobliVDcgRHcINxywrdb/A3bEXeW
         qVe5FdqLTr2viQy0mvTQBnXJqmf3qIwBf01LS5xHmtFIqaqrSZJxh4wXyiY0ZAOctwTj
         hQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCUIPzzwqMu3npVKmxUfaS94OuaBLe+F55MfomJiRK1jBkypkTpPCuHR9tALqI/Yv+OubdQ=@vger.kernel.org, AJvYcCUsTr3xBWSZ823DCZIT79e3FKvVnKI3PK/55OmlB2C6Nrss5qKgdqWHScP6FXMQoH7FI6ZGjZ0X@vger.kernel.org
X-Gm-Message-State: AOJu0YwH5ZED5CaITjeyePYgpXxUnualYn6wGwstI2eHV6xvb88XmVcS
	x6IUBbA3bNHgWKtPR6LTHpcwmz6uWLVqvp8JT7Kvvnc8JSZdyOFCaJ6HIB2NcrRNjMIoLlQ/qQn
	cLdiSZqRAdta9W4To0ZTSRMCFUgtDsw==
X-Gm-Gg: ASbGnctXz8L7lceTCA6VhfqzWacTyAPs04036fAXY+olEcsB+P+BCCVpbynlAtfotnD
	/HcNFfvKKztYerz6FN19wmsK8zp2zrLrZQgW84A==
X-Google-Smtp-Source: AGHT+IG8EUaqoXsd9Va/PvfyblaueBCB1Pb2fz4tmQ2BxYFAbwXrCdtDexBpQFebBsz/tyfCaaNta6l2jKdN2P+tiAU=
X-Received: by 2002:a05:690c:6703:b0:6ef:7d04:231c with SMTP id
 00721157ae682-6f3f8115fedmr1810897b3.18.1734641403189; Thu, 19 Dec 2024
 12:50:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-3-amery.hung@bytedance.com> <dd5e82d1-d00a-4bda-be4b-802204167352@linux.dev>
In-Reply-To: <dd5e82d1-d00a-4bda-be4b-802204167352@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 19 Dec 2024 12:49:52 -0800
Message-ID: <CAMB2axP0bHfGnm0xh8tEL-tP_0FMnGtAPOrVCV2BeKsH1w_dbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 02/13] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Amery Hung <amery.hung@bytedance.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 7:41=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
>
> On 12/13/24 3:29 PM, Amery Hung wrote:
> > Test referenced kptr acquired through struct_ops argument tagged with
> > "__ref". The success case checks whether 1) a reference to the correct
> > type is acquired, and 2) the referenced kptr argument can be accessed i=
n
> > multiple paths as long as it hasn't been released. In the fail cases,
> > we first confirm that a referenced kptr acquried through a struct_ops
> > argument is not allowed to be leaked. Then, we make sure this new
> > referenced kptr acquiring mechanism does not accidentally allow referen=
ced
> > kptrs to flow into global subprograms through their arguments.
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  7 ++
> >   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  2 +
> >   .../prog_tests/test_struct_ops_refcounted.c   | 58 ++++++++++++++++
> >   .../bpf/progs/struct_ops_refcounted.c         | 67 ++++++++++++++++++=
+
> >   ...ruct_ops_refcounted_fail__global_subprog.c | 32 +++++++++
> >   .../struct_ops_refcounted_fail__ref_leak.c    | 17 +++++
> >   6 files changed, 183 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct=
_ops_refcounted.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refco=
unted.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refco=
unted_fail__global_subprog.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refco=
unted_fail__ref_leak.c
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/to=
ols/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index 987d41af71d2..244234546ae2 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -1135,10 +1135,17 @@ static int bpf_testmod_ops__test_maybe_null(int=
 dummy,
> >       return 0;
> >   }
> >
> > +static int bpf_testmod_ops__test_refcounted(int dummy,
> > +                                         struct task_struct *task__ref=
)
> > +{
> > +     return 0;
> > +}
> > +
> >   static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> >       .test_1 =3D bpf_testmod_test_1,
> >       .test_2 =3D bpf_testmod_test_2,
> >       .test_maybe_null =3D bpf_testmod_ops__test_maybe_null,
> > +     .test_refcounted =3D bpf_testmod_ops__test_refcounted,
> >   };
> >
> >   struct bpf_struct_ops bpf_bpf_testmod_ops =3D {
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/to=
ols/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> > index fb7dff47597a..0e31586c1353 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> > @@ -36,6 +36,8 @@ struct bpf_testmod_ops {
> >       /* Used to test nullable arguments. */
> >       int (*test_maybe_null)(int dummy, struct task_struct *task);
> >       int (*unsupported_ops)(void);
> > +     /* Used to test ref_acquired arguments. */
> > +     int (*test_refcounted)(int dummy, struct task_struct *task);
> >
> >       /* The following fields are used to test shadow copies. */
> >       char onebyte;
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_ref=
counted.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcount=
ed.c
> > new file mode 100644
> > index 000000000000..976df951b700
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted=
.c
> > @@ -0,0 +1,58 @@
> > +#include <test_progs.h>
> > +
> > +#include "struct_ops_refcounted.skel.h"
> > +#include "struct_ops_refcounted_fail__ref_leak.skel.h"
> > +#include "struct_ops_refcounted_fail__global_subprog.skel.h"
> > +
> > +/* Test that the verifier accepts a program that first acquires a refe=
renced
> > + * kptr through context and then releases the reference
> > + */
> > +static void refcounted(void)
> > +{
> > +     struct struct_ops_refcounted *skel;
> > +
> > +     skel =3D struct_ops_refcounted__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_and_load"))
> > +             return;
> > +
> > +     struct_ops_refcounted__destroy(skel);
> > +}
> > +
> > +/* Test that the verifier rejects a program that acquires a referenced
> > + * kptr through context without releasing the reference
> > + */
> > +static void refcounted_fail__ref_leak(void)
> > +{
> > +     struct struct_ops_refcounted_fail__ref_leak *skel;
> > +
> > +     skel =3D struct_ops_refcounted_fail__ref_leak__open_and_load();
> > +     if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load")=
)
> > +             return;
> > +
> > +     struct_ops_refcounted_fail__ref_leak__destroy(skel);
> > +}
> > +
> > +/* Test that the verifier rejects a program that contains a global
> > + * subprogram with referenced kptr arguments
> > + */
> > +static void refcounted_fail__global_subprog(void)
> > +{
> > +     struct struct_ops_refcounted_fail__global_subprog *skel;
> > +
> > +     skel =3D struct_ops_refcounted_fail__global_subprog__open_and_loa=
d();
> > +     if (ASSERT_ERR_PTR(skel, "struct_ops_module_fail__open_and_load")=
)
> > +             return;
> > +
> > +     struct_ops_refcounted_fail__global_subprog__destroy(skel);
> > +}
> > +
> > +void test_struct_ops_refcounted(void)
> > +{
> > +     if (test__start_subtest("refcounted"))
> > +             refcounted();
> > +     if (test__start_subtest("refcounted_fail__ref_leak"))
> > +             refcounted_fail__ref_leak();
> > +     if (test__start_subtest("refcounted_fail__global_subprog"))
> > +             refcounted_fail__global_subprog();
> > +}
> > +
> > diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted.c =
b/tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
> > new file mode 100644
> > index 000000000000..2c1326668b92
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
> > @@ -0,0 +1,67 @@
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "../bpf_testmod/bpf_testmod.h"
> > +#include "bpf_misc.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +extern void bpf_task_release(struct task_struct *p) __ksym;
> > +
> > +/* This is a test BPF program that uses struct_ops to access a referen=
ced
> > + * kptr argument. This is a test for the verifier to ensure that it
> > + * 1) recongnizes the task as a referenced object (i.e., ref_obj_id > =
0), and
> > + * 2) the same reference can be acquired from multiple paths as long a=
s it
> > + *    has not been released.
> > + *
> > + * test_refcounted() is equivalent to the C code below. It is written =
in assembly
> > + * to avoid reads from task (i.e., getting referenced kptrs to task) b=
eing merged
> > + * into single path by the compiler.
> > + *
> > + * int test_refcounted(int dummy, struct task_struct *task)
> > + * {
> > + *         if (dummy % 2)
> > + *                 bpf_task_release(task);
> > + *         else
> > + *                 bpf_task_release(task);
> > + *         return 0;
> > + * }
> > + */
> > +SEC("struct_ops/test_refcounted")
> > +int test_refcounted(unsigned long long *ctx)
> > +{
> > +     asm volatile ("                                 \
> > +     /* r6 =3D dummy */                                \
> > +     r6 =3D *(u64 *)(r1 + 0x0);                        \
> > +     /* if (r6 & 0x1 !=3D 0) */                        \
> > +     r6 &=3D 0x1;                                      \
> > +     if r6 =3D=3D 0 goto l0_%=3D;                          \
> > +     /* r1 =3D task */                                 \
> > +     r1 =3D *(u64 *)(r1 + 0x8);                        \
> > +     call %[bpf_task_release];                       \
> > +     goto l1_%=3D;                                     \
> > +l0_%=3D:       /* r1 =3D task */                                 \
> > +     r1 =3D *(u64 *)(r1 + 0x8);                        \
> > +     call %[bpf_task_release];                       \
> > +l1_%=3D:       /* return 0 */                                  \
> > +"    :
> > +     : __imm(bpf_task_release)
> > +     : __clobber_all);
> > +     return 0;
> > +}
>
> You can use clang nomerge attribute to prevent bpf_task_release(task) mer=
ging. For example,
>

Thanks for the info! That simplifies this test a lot. I will change it
in the next version.

> $ cat t.c
> struct task_struct {
>          int a;
>          int b;
>          int d[20];
> };
>
>
> __attribute__((nomerge)) extern void bpf_task_release(struct task_struct =
*task);
>
> int test_refcounted(int dummy, struct task_struct *task)
> {
>          if (dummy % 2)
>                  bpf_task_release(task);
>          else
>                  bpf_task_release(task);
>          return 0;
> }
>
> $ clang --version
> clang version 19.1.5 (https://github.com/llvm/llvm-project.git ab4b5a2db5=
82958af1ee308a790cfdb42bd24720)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /home/yhs/work/llvm-project/llvm/build.19/Release/bin
> $ clang --target=3Dbpf -O2 -mcpu=3Dv3 -S t.c
> $ cat t.s
>          .text
>          .file   "t.c"
>          .globl  test_refcounted                 # -- Begin function test=
_refcounted
>          .p2align        3
>          .type   test_refcounted,@function
> test_refcounted:                        # @test_refcounted
> # %bb.0:
>          w1 &=3D 1
>          if w1 =3D=3D 0 goto LBB0_2
> # %bb.1:
>          r1 =3D r2
>          call bpf_task_release
>          goto LBB0_3
> LBB0_2:
>          r1 =3D r2
>          call bpf_task_release
> LBB0_3:
>          w0 =3D 0
>          exit
> .Lfunc_end0:
>          .size   test_refcounted, .Lfunc_end0-test_refcounted
>                                          # -- End function
>          .addrsig
>
> > +
> > +/* BTF FUNC records are not generated for kfuncs referenced
> > + * from inline assembly. These records are necessary for
> > + * libbpf to link the program. The function below is a hack
> > + * to ensure that BTF FUNC records are generated.
> > + */
> > +void __btf_root(void)
> > +{
> > +     bpf_task_release(NULL);
> > +}
> > +
> > +SEC(".struct_ops.link")
> > +struct bpf_testmod_ops testmod_refcounted =3D {
> > +     .test_refcounted =3D (void *)test_refcounted,
> > +};
> > +
> > +
> > diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fa=
il__global_subprog.c b/tools/testing/selftests/bpf/progs/struct_ops_refcoun=
ted_fail__global_subprog.c
> > new file mode 100644
> > index 000000000000..c7e84e63b053
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__glo=
bal_subprog.c
> > @@ -0,0 +1,32 @@
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "../bpf_testmod/bpf_testmod.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +extern void bpf_task_release(struct task_struct *p) __ksym;
> > +
> > +__noinline int subprog_release(__u64 *ctx __arg_ctx)
> > +{
> > +     struct task_struct *task =3D (struct task_struct *)ctx[1];
> > +     int dummy =3D (int)ctx[0];
> > +
> > +     bpf_task_release(task);
> > +
> > +     return dummy + 1;
> > +}
> > +
> > +SEC("struct_ops/test_refcounted")
> > +int test_refcounted(unsigned long long *ctx)
> > +{
> > +     struct task_struct *task =3D (struct task_struct *)ctx[1];
> > +
> > +     bpf_task_release(task);
> > +
> > +     return subprog_release(ctx);
> > +}
> > +
> > +SEC(".struct_ops.link")
> > +struct bpf_testmod_ops testmod_ref_acquire =3D {
> > +     .test_refcounted =3D (void *)test_refcounted,
> > +};
> > diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fa=
il__ref_leak.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fa=
il__ref_leak.c
> > new file mode 100644
> > index 000000000000..6e82859eb187
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref=
_leak.c
> > @@ -0,0 +1,17 @@
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "../bpf_testmod/bpf_testmod.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +SEC("struct_ops/test_refcounted")
> > +int BPF_PROG(test_refcounted, int dummy,
> > +          struct task_struct *task)
> > +{
> > +     return 0;
> > +}
> > +
> > +SEC(".struct_ops.link")
> > +struct bpf_testmod_ops testmod_ref_acquire =3D {
> > +     .test_refcounted =3D (void *)test_refcounted,
> > +};
>

