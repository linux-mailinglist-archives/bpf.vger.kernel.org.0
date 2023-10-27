Return-Path: <bpf+bounces-13463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2717B7D9FC4
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5745C1C20A16
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E883C083;
	Fri, 27 Oct 2023 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWM5GPmk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8337C9E
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 18:20:42 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA9018F
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:20:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so386261166b.3
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698430837; x=1699035637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqmiZmjBD0+9/jPDrSH0XeNW4tiUbOY3mRzWFEy07AE=;
        b=KWM5GPmkvU7AnZr6WMy3y/txHL0r0VFf75J8lXa3x7T0FGBoJR6JDDiQfmUeiDJuD+
         nl3dHPY2i4weVO2JmzKo7zh32wfOPHTL176LAcx0/vi5vz2MfJ/aEU8fVFwJpZ8+QgTw
         otnlaoGrF1Oad0MBRR/hv5sHp6SDDuHhIAebncte4E+ODoUW5vVBlvcUf/xzAv71R6lQ
         KdUgHaYVQo19DKou5b0Geo8LcdK/Ms3Y+PDXKU4JTchZt6Qw9woUmSiqv7KNxAXj6lTg
         7NOoBOH/v1dGMCWLmXlDUWTU8qFKCGRr7+Vi1USnOCtxSbi5sovvIHyLVykDToX3awzr
         1CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698430837; x=1699035637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqmiZmjBD0+9/jPDrSH0XeNW4tiUbOY3mRzWFEy07AE=;
        b=mPfNA3/T58/aNPUrkosg9fFjT30Z9ovHgl1dANZIdGpyqGLuAUIZIO/5y1crayzxNq
         DH5TztnfKFgkSAPJn69sBpG44dTMMtJIEAaxwS+jfy379gFrzbaoPdjrhM2/+Y2hqCJN
         fW+C8so9rU6kd8CzMuV5SvdL52QpOOuRrc0ohcrUs/mWgXX3OXXQAwVMO2ktjbg8HIZU
         tS3fXEyQdihhU5Y4kOQnp0Ax5UUfh/B8FfwwXHZEjQR6tGWcN0SrIpZJRZXsxq3QtZoB
         faRAjQI/LKi1fjYfhJ1LfSeE4gXbcUsVWJb0NpLhYiTiB8Xsd6COG/NTP6HwbGEitxou
         pZnw==
X-Gm-Message-State: AOJu0Yx3t1knyX3e09XC4AKjKmGJDXl6NhVNTcKaq6wHhCX8pOA5PtcH
	zVik5G1DEK3qUJx7V1LAgDy5F8k5nuHDgRunSNk=
X-Google-Smtp-Source: AGHT+IEKeg90HuYo1E4g9naNgpe2d6FDeFoRuMDbCnY3PSm2QIi1bMJFI4704e2AO1DHws8Y57K15SrIN0qWEmjbfEU=
X-Received: by 2002:a17:907:26c4:b0:9ae:5120:5147 with SMTP id
 bp4-20020a17090726c400b009ae51205147mr2495654ejc.38.1698430837320; Fri, 27
 Oct 2023 11:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020220216.263948-1-tao.lyu@epfl.ch> <CAEf4Bzb6uXiKK4=1++9Lu=GyfU1Co6VcqRwNO8PsQL=TzGzs-A@mail.gmail.com>
 <a1c717381a0049da9f5472f691477ba8@epfl.ch>
In-Reply-To: <a1c717381a0049da9f5472f691477ba8@epfl.ch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Oct 2023 11:20:25 -0700
Message-ID: <CAEf4BzYpvmcw4snk-kAFbYu515xxYRg6c-E2XNtURwmFwaACvw@mail.gmail.com>
Subject: Re: [PATCH] Accept program in priv mode when returning from subprog
 with r10 marked as precise
To: Tao Lyu <tao.lyu@epfl.ch>
Cc: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@google.com" <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>, 
	"mathias.payer@nebelwelt.net" <mathias.payer@nebelwelt.net>, 
	"meng.xu.cs@uwaterloo.ca" <meng.xu.cs@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 2:06=E2=80=AFAM Tao Lyu <tao.lyu@epfl.ch> wrote:
>
> >>
> >> There is another issue about the backtracking.
> >> When uploading the following program under privilege mode,
> >> the verifier reports a "verifier backtracking bug".
> >>
> >> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> >> 0: (85) call pc+2
> >> caller:
> >>  R10=3Dfp0
> >> callee:
> >>  frame1: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> >> 3: frame1:
> >> 3: (bf) r3 =3D r10                      ; frame1: R3_w=3Dfp0 R10=3Dfp0
> >> 4: (bc) w0 =3D w10                      ; frame1: R0_w=3Dscalar(umax=
=3D4294967295,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0
> >> 5: (0f) r3 +=3D r0
> >> mark_precise: frame1: last_idx 5 first_idx 0 subseq_idx -1
> >> mark_precise: frame1: regs=3Dr0 stack=3D before 4: (bc) w0 =3D w10
> >> mark_precise: frame1: regs=3Dr10 stack=3D before 3: (bf) r3 =3D r10
> >> mark_precise: frame1: regs=3Dr10 stack=3D before 0: (85) call pc+2
> >> BUG regs 400
> >>
> >> This bug is manifested by the following check:
> >>
> >> if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
> >>     verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
> >>     WARN_ONCE(1, "verifier backtracking bug");
> >>     return -EFAULT;
> >> }
> >>
> >> Since the verifier allows add operation on stack pointers,
> >> it shouldn't show this WARNING and reject the program.
> >>
> >> I fixed it by skipping the warning if it's privilege mode and only r10=
 is marked as precise.
> >>
> >
> >See my reply to your other email. It would be nice if you can rewrite
> >your tests in inline assembly, it would be easier to follow and debug.
> >
>
> Sorry, I'm new to this community.
> Could you explain a little bit more about what the inline assembly is?
> I wrote the test confirming to the test cases under "tools/testing/selfte=
sts/bpf".

see progs/verifier_subprog_precision.c under
tools/testing/selftests/bpf, those examples show how we write verifier
tests using BPF assembly, instead of constructing BPF programs out of
BPF_XXX() macros (which are much harder to write and read)

>
> >I think your fix is papering over the fact that we don't recognize
> >non-r10 stack access. Once we fix that, we shouldn't need extra hacks.
> >So let's solve the underlying problem first.
>
> Sure, we can fix the non-r10 stack access first.
>
> However, the bug here is not related to the r10 stack access tracking, as=
 there is no stack access in the test case.
> The root cause is that when meeting subprog calling instruction, the veri=
fier asserts that r10 can't be marked as precise.
> However, under privileged mode, the verifier allows arithmetic operations=
 (e.g., sub and add) on stack pointers, and thus, it's legal that r10 can b=
e marked as precise.
> In this situation, the verifier might incorrectly reject programs.
>
> Solutions for this issue:
> 1) Never mark r10 as precise during backtracking
> 2) Modify this assertion so that under privileged mode, even if the verif=
ier sees r10 is marked as precise, it does throw the WARNING.
>

I'm not entirely sure, but I think the right solution is to prevent
r10 and generally PTR_TO_STACK from being marked as precise. It should
be precise implicitly, just like any other non-SCALAR_VALUE register.

> The patch I provided is the second solution.
>
> >> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> >> ---
> >>  kernel/bpf/verifier.c                            |  4 +++-
> >>  .../bpf/verifier/ret-without-checing-r10.c       | 16 +++++++++++++++=
+
> >>  2 files changed, 19 insertions(+), 1 deletion(-)
> >>  create mode 100644 tools/testing/selftests/bpf/verifier/ret-without-c=
hecing-r10.c
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index e777f50401b6..1ce80cdc4f1d 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -3495,6 +3495,7 @@ static int backtrack_insn(struct bpf_verifier_en=
v *env, int idx, int subseq_idx,
> >>         u32 dreg =3D insn->dst_reg;
> >>         u32 sreg =3D insn->src_reg;
> >>         u32 spi, i;
> >> +       u32 reg_mask;
> >>
> >>         if (insn->code =3D=3D 0)
> >>                 return 0;
> >> @@ -3621,7 +3622,8 @@ static int backtrack_insn(struct bpf_verifier_en=
v *env, int idx, int subseq_idx,
> >>                                  * precise, r0 and r6-r10 or any stack=
 slot in
> >>                                  * the current frame should be zero by=
 now
> >>                                  */
> >> -                               if (bt_reg_mask(bt) & ~BPF_REGMASK_ARG=
S) {
> >> +                               reg_mask =3D bt_reg_mask(bt) & ~BPF_RE=
GMASK_ARGS;
> >> +                               if (reg_mask && !((reg_mask =3D=3D 1 <=
< BPF_REG_10) && env->allow_ptr_leaks)) {
> >>                                         verbose(env, "BUG regs %x\n", =
bt_reg_mask(bt));
> >>                                         WARN_ONCE(1, "verifier backtra=
cking bug");
> >>                                         return -EFAULT;
> >> diff --git a/tools/testing/selftests/bpf/verifier/ret-without-checing-=
r10.c b/tools/testing/selftests/bpf/verifier/ret-without-checing-r10.c
> >> new file mode 100644
> >> index 000000000000..56e529cf922b
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/verifier/ret-without-checing-r10.c
> >> @@ -0,0 +1,16 @@
> >> +{
> >> +  "pointer arithmetic: when returning from subprog in priv, do not ch=
ecking r10",
> >> +  .insns =3D {
> >> +       BPF_CALL_REL(2),
> >> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> >> +       BPF_EXIT_INSN(),
> >> +       BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
> >> +       BPF_MOV32_REG(BPF_REG_0, BPF_REG_10),
> >> +       BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_0),
> >> +       BPF_MOV64_IMM(BPF_REG_0, 0),
> >> +       BPF_EXIT_INSN(),
> >> +  },
> >> +  .result  =3D ACCEPT,
> >> +  .result_unpriv =3D REJECT,
> >> +  .errstr_unpriv =3D "loading/calling other bpf or kernel functions a=
re allowed for CAP_BPF and CAP_SYS_ADMIN",
> >> +},
> >> --
> >> 2.25.1
> >>

