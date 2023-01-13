Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248B1669EB4
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 17:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjAMQtl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 11:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjAMQtW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 11:49:22 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1430C6B5B9
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 08:47:39 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mp20so7025106ejc.7
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 08:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+SpRVgdTAspMfbhaUaHBJ9ig7E05YPo2zvYtGYw3nGw=;
        b=ivBoc+OinvUGNLBXSrqLIgHwEOjdWoIn12I/jBhhZY2xcNGTENecAxeOtL3grr0Euc
         PskXoG1av+4isBN6EC4yiGnlt1ekErjePrqN4GRRw0pghyUkQLVd514nLh9u6MN8cl4z
         g+4sIbUWPeEr0LAOzr1nC18UzpupHKNnLB/7WJ8kgqsglRBxNgClUzTmXLRArWU1BXkM
         4qhGtLlyt09GH2yEIW3dDMhKN6YkgqcZYT1a2fBuUIKO7y71P+/IMWISgrqnxffpJ6Ce
         qpylH2ZhQ2rQbtaEyBHmH+T15gnm4cIxJI0XaB6d1dySut7mNghpU/2aTtCcUcgONjAI
         hvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SpRVgdTAspMfbhaUaHBJ9ig7E05YPo2zvYtGYw3nGw=;
        b=4mqnLOJL7pgv7qTOd/e46pydQaeAFE0FW6CQGDzfEXAILmv1c3alZ4vzaeBKMNeigK
         S4+NYK28+AUfURVKEI2aFhYbIzduU8zjb13rkEcsUdY0G0YAO7uz2aS+/m6+tcz6xv+d
         h3LYVMEFidLe8T/9HQ3bLUWuiXCSdwGzC1vXOs/wAtuToQZVrCDu7AgWO4d/XXaJ9IMp
         C/nMK2VZuprEA2l8nxxYaF276S2pIKc5NYA0GjyuAF1w60tFirUPdRh1idL0ZgK51B8z
         LcRAHr0bBujkoJqo8Rrjsbn4hKaJX2SKOuWhFYT4Hx6ZRdRgT2tH5ge/lFqxtpPfyJoD
         uIbw==
X-Gm-Message-State: AFqh2kpalsgVfxr7JjPYJ6QHhiEtkakFEog0nXhguuPQfUW2arN8TMKy
        Z3blSvqtcyzPbNeX0Jp2oXc=
X-Google-Smtp-Source: AMrXdXto3WrfSyKco52fZYphWl+Fd3I/2vIP0gDUOXmglPvjmiqFcChortXGYDiCLK1J6xW1mIxPBA==
X-Received: by 2002:a17:907:c208:b0:84c:e73c:d224 with SMTP id ti8-20020a170907c20800b0084ce73cd224mr31591537ejc.10.1673628458289;
        Fri, 13 Jan 2023 08:47:38 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709061b4300b007c09da0d773sm3356919ejg.100.2023.01.13.08.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:47:37 -0800 (PST)
Message-ID: <f1e4282bf00aa21a72fc5906f8c3be1ae6c94a5e.camel@gmail.com>
Subject: Re: [RFC bpf-next 0/5] Support for BPF_ST instruction in LLVM C
 compiler
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com, david.faust@oracle.com,
        James Hilliard <james.hilliard1@gmail.com>
Date:   Fri, 13 Jan 2023 18:47:36 +0200
In-Reply-To: <87a62mhl3m.fsf@oracle.com>
References: <20221231163122.1360813-1-eddyz87@gmail.com>
         <CAEf4BzbNM_U4b3gi4AwiTV5GMXEsAsJx8sMVA32ijJRygrVpFg@mail.gmail.com>
         <874jt5mh2j.fsf@oracle.com>
         <1155fda8d54188f04270bb72c625d91f772e9999.camel@gmail.com>
         <20230112222719.gdxwdocfutpbxust@MacBook-Pro-6.local.dhcp.thefacebook.com>
         <790ab9fd-dbcf-4593-1634-6f706675cde2@meta.com> <87a62mhl3m.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-01-13 at 09:53 +0100, Jose E. Marchesi wrote:
> > On 1/12/23 2:27 PM, Alexei Starovoitov wrote:
> > > On Thu, Jan 05, 2023 at 02:07:05PM +0200, Eduard Zingerman wrote:
> > > > On Thu, 2023-01-05 at 11:06 +0100, Jose E. Marchesi wrote:
> > > > > > On Sat, Dec 31, 2022 at 8:31 AM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > > > > > >=20
> > > > > > > BPF has two documented (non-atomic) memory store instructions=
:
> > > > > > >=20
> > > > > > > BPF_STX: *(size *) (dst_reg + off) =3D src_reg
> > > > > > > BPF_ST : *(size *) (dst_reg + off) =3D imm32
> > > > > > >=20
> > > > > > > Currently LLVM BPF back-end does not emit BPF_ST instruction =
and does
> > > > > > > not allow one to be specified as inline assembly.
> > > > > > >=20
> > > > > > > Recently I've been exploring ways to port some of the verifie=
r test
> > > > > > > cases from tools/testing/selftests/bpf/verifier/*.c to use in=
line assembly
> > > > > > > and machinery provided in tools/testing/selftests/bpf/test_lo=
ader.c
> > > > > > > (which should hopefully simplify tests maintenance).
> > > > > > > The BPF_ST instruction is popular in these tests: used in 52 =
of 94 files.
> > > > > > >=20
> > > > > > > While it is possible to adjust LLVM to only support BPF_ST fo=
r inline
> > > > > > > assembly blocks it seems a bit wasteful. This patch-set conta=
ins a set
> > > > > > > of changes to verifier necessary in case when LLVM is allowed=
 to
> > > > > > > freely emit BPF_ST instructions (source code is available her=
e [1]).
> > > > > >=20
> > > > > > Would we gate LLVM's emitting of BPF_ST for C code behind some =
new
> > > > > > cpu=3Dv4? What is the benefit for compiler to start automatical=
ly emit
> > > > > > such instructions? Such thinking about logistics, if there isn'=
t much
> > > > > > benefit, as BPF application owner I wouldn't bother enabling th=
is
> > > > > > behavior risking regressions on old kernels that don't have the=
se
> > > > > > changes.
> > > > >=20
> > > > > Hmm, GCC happily generates BPF_ST instructions:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0$ echo 'int v; void foo () {  v =3D 666; }' | b=
pf-unknown-none-gcc -O2 -xc -S -o foo.s -
> > > > > =C2=A0=C2=A0=C2=A0$ cat foo.s
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.file	"<std=
in>"
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.text
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.align	3
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.global	foo
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.type	foo, =
@function
> > > > > =C2=A0=C2=A0=C2=A0foo:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lddw	%r0,v
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stw	[%r0+0]=
,666
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exit
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.size	foo, =
.-foo
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.global	v
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.type	v, @o=
bject
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.lcomm	v,4,=
4
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.ident	"GCC=
: (GNU) 12.0.0 20211206 (experimental)"
> > > > >=20
> > > > > Been doing that since October 2019, I think before the cpu versio=
ning
> > > > > mechanism was got in place?
> > > > >=20
> > > > > We weren't aware this was problematic.  Does the verifier reject =
such
> > > > > instructions?
> > > >=20
> > > > Interesting, do BPF selftests generated by GCC pass the same way th=
ey
> > > > do if generated by clang?
> > > >=20
> > > > I had to do the following changes to the verifier to make the
> > > > selftests pass when BPF_ST instruction is allowed for selection:
> > > >=20
> > > > - patch #1 in this patchset: track values of constants written to
> > > > =C2=A0=C2=A0=C2=A0stack using BPF_ST. Currently these are tracked i=
mprecisely, unlike
> > > > =C2=A0=C2=A0=C2=A0the writes using BPF_STX, e.g.:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fp[-8] =3D 42;   cu=
rrently verifier assumes that
> > > > fp[-8]=3Dmmmmmmmm
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0after such instructio=
n, where m stands for "misc",
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0just a note that some=
thing is written at fp[-8].
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0r1 =3D 42;       verifier tracks r1=3D42 after
> > > > this instruction.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fp[-8] =3D r1;   verifier tracks fp[-=
8]=3D42 after this instruction.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0So the patch makes both cases equivalent.
> > > > =C2=A0=C2=A0=C2=A0- patch #3 in this patchset: adjusts
> > > > verifier.c:convert_ctx_access()
> > > > =C2=A0=C2=A0=C2=A0to operate on BPF_ST alongside BPF_STX.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Context parameters for some BPF=
 programs types are "fake"
> > > > data
> > > > =C2=A0=C2=A0=C2=A0structures. The verifier matches all BPF_STX and =
BPF_LDX
> > > > =C2=A0=C2=A0=C2=A0instructions that operate on pointers to such con=
texts and rewrites
> > > > =C2=A0=C2=A0=C2=A0these instructions. It might change an offset or =
add another layer
> > > > =C2=A0=C2=A0=C2=A0of indirection, etc. E.g. see filter.c:bpf_conver=
t_ctx_access().
> > > > =C2=A0=C2=A0=C2=A0(This also implies that verifier forbids writes t=
o non-constant
> > > > =C2=A0=C2=A0=C2=A0=C2=A0offsets inside such structures).
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0So the patch extends this=
 logic to also handle BPF_ST.
> > > The patch 3 is necessary to land before llvm starts generating 'st'
> > > for ctx access.
> > > That's clear, but I'm missing why patch 1 is necessary.
> > > Sure, it's making the verifier understand scalar spills with 'st' and
> > > makes 'st' equivalent to 'stx', but I'm missing why it's necessary.
> > > What kind of programs fail to be verified when llvm starts generating=
 'st' ?

I should have added an example to the summary. There are a few
test_prog tests that fail w/o this patch, namely atomic_bounds,
dynptr, for_each, xdp_noinline, xdp_synproxy.

Here is how atomic_bounds looks:

  SEC("fentry/bpf_fentry_test1")
  int BPF_PROG(sub, int x)
  {
          int a =3D 0;
          int b =3D __sync_fetch_and_add(&a, 1);
          /* b is certainly 0 here. Can the verifier tell? */
          while (b)
                  continue;
          return 0;
  }

    Compiled w/o BPF_ST                  Compiled with BPF_ST
 =20
  <sub>:                               <sub>:
    w1 =3D 0x0
    *(u32 *)(r10 - 0x4) =3D r1             *(u32 *)(r10 - 0x4) =3D 0x0
    w1 =3D 0x1                             w1 =3D 0x1
    lock *(u32 *)(r10 - 0x4) +=3D r1       lock *(u32 *)(r10 - 0x4) +=3D r1
    if w1 =3D=3D 0x0 goto +0x1 <LBB0_2>      if w1 =3D=3D 0x0 goto +0x1 <LB=
B0_2>
 =20
  <LBB0_1>:                            <LBB0_1>:
    goto -0x1 <LBB0_1>                   goto -0x1 <LBB0_1>
 =20
  <LBB0_2>:                            <LBB0_2>:
    w0 =3D 0x0                             w0 =3D 0x0
    exit                                 exit

When compiled with BPF_ST and verified w/o the patch #1 verification log
looks as follows:

  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
  0: (62) *(u32 *)(r10 -4) =3D 0          ; R10=3Dfp0 fp-8=3Dmmmm????
  1: (b4) w1 =3D 1                        ; R1_w=3D1
  2: (c3) r1 =3D atomic_fetch_add((u32 *)(r10 -4), r1)    ; R1_w=3Dscalar(u=
max=3D4294967295,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0 fp-8=3Dmmmm????
  3: (16) if w1 =3D=3D 0x0 goto pc+1        ; R1_w=3Dscalar(umax=3D42949672=
95,var_off=3D(0x0; 0xffffffff))
  4: (05) goto pc-1
  4: (05) goto pc-1
  4: (05) goto pc-1
  4: (05) goto pc-1
  infinite loop detected at insn 4

When compiled w/o BPF_ST and verified w/o the patch #1 verification log
looks as follows:

  func#0 @0
  reg type unsupported for arg#0 function sub#5
  0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
  0: (b4) w1 =3D 0                        ; R1_w=3D0
  1: (63) *(u32 *)(r10 -4) =3D r1
  last_idx 1 first_idx 0
  regs=3D2 stack=3D0 before 0: (b4) w1 =3D 0
  2: R1_w=3D0 R10=3Dfp0 fp-8=3D0000????
  2: (b4) w1 =3D 1                        ; R1_w=3D1
  ; int b =3D __sync_fetch_and_add(&a, 1);
  3: (c3) r1 =3D atomic_fetch_add((u32 *)(r10 -4), r1)    ; R1_w=3DP0 R10=
=3Dfp0 fp-8=3Dmmmm????
  4: (16) if w1 =3D=3D 0x0 goto pc+1
  6: R1_w=3DP0
  6: (b4) w0 =3D 0                        ; R0_w=3D0
  7: (95) exit
  processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0

The difference comes from the way zero write to `r10-4` is processed,
with BPF_ST it is tracked as `fp-8=3Dmmmm????` after write, without BPF_ST
it is tracked as `fp-8=3D0000???? after` write.

Which is caused by the way `check_stack_write_fixed_off()` is written.
For the register spills it either saves the complete register state or
STACK_ZERO if register is known to be zero. However, for the BPF_ST it
just saves STACK_MISC. Hence, the patch #1.

> > > Regarind -mcpu=3Dv4.
> > > I think we need to add all of our upcoming instructions as a single f=
lag.
> > > Otherwise we'll have -mcpu=3Dv5,v6,v7 and full combinations of them.
> > > -mcpu=3Dv4 could mean:
> > > - ST
> > > - sign extending loads
> > > - sign extend a register
> > > - 32-bit JA
> > > - proper bswap insns: bswap16, bswap32, bswap64
> > > The sign and 32-bit JA we've discussed earlier.
> > > The bswap was on my wish list forever.
> > > The existing TO_LE, TO_BE insns are really odd from compiler pov.
> > > The compiler should translate bswap IR op into proper bswap insn
> > > just like it does on all cpus.
> > > Maybe add SDIV to -mcpu=3Dv4 as well?

There is also BPF_JSET "PC +=3D off if dst & src" which is not currently
emitted by LLVM backend as far as I can tell.

> >=20
> > Right, we should add these insns in llvm17 with -mcpu=3Dv4, so we
> > can keep the number of cpu generations minimum.
>=20
> How do you plan to encode the sign-extend load instructions?
>=20
> I guess a possibility would be to use one of the available op-mode for
> load instructions that are currently marked as reserved.  For example:
>=20
> =C2=A0=C2=A0=C2=A0IMM  =3D 0b000
> =C2=A0=C2=A0=C2=A0ABS  =3D 0b001
> =C2=A0=C2=A0=C2=A0IND  =3D 0b010
> =C2=A0=C2=A0=C2=A0MEM  =3D 0b011
> =C2=A0=C2=A0=C2=A0SEM =3D 0b100  <- new
>=20
> Then we would have the following code fields for sign-extending LDX
> instructions:
>=20
> =C2=A0=C2=A0=C2=A0op-mode:SEM op-size:{W,H,B,DW} op-class:LDX

I second the Jose's question about encoding for the new instructions.

> - sign extend a register

E.g. like this:

BPF_SEXT =3D 0xb0=20
opcode: BPF_SEXT | BPF_X | BPF_ALU
imm32: {8,16,32}                    // to be consistent with BPF_END insn
    or BPF_{B,H,W}                  // to be consistent with LDX/STX

Sign extend 8,16,32-bit value from src to 64-bit dst register:
  src =3D sext{8,16,32}(dst)

> The sign and 32-bit JA we've discussed earlier.

Could you please share a link for this discussion?

> - proper bswap insns: bswap16, bswap32, bswap64

Could you please extrapolate on this.
Current instructions operate on a single register, e.g.:

  dst_reg =3D htole16(dst_reg).

It looks like this could be reflected in x86 assembly as a single
instruction using either bswap or xchg instructions (see [1] and [2]).
x86/net/bpf_jit_comp.c:1266 can probably be adjusted to use xchg for
16-bit case.

For ARM rev16, rev32, rev64 allow to use the same register for source
and destination ([3]).

[1] https://www.felixcloutier.com/x86/bswap
[2] https://www.felixcloutier.com/x86/xchg
[3] https://developer.arm.com/documentation/ddi0602/2022-06/Base-Instructio=
ns/REV16--Reverse-bytes-in-16-bit-halfwords-?lang=3Den
    https://developer.arm.com/documentation/ddi0602/2022-06/Base-Instructio=
ns/REV32--Reverse-bytes-in-32-bit-words-?lang=3Den
    https://developer.arm.com/documentation/ddi0602/2022-06/Base-Instructio=
ns/REV64--Reverse-Bytes--an-alias-of-REV-?lang=3Den
   =20
