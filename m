Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74465EA6B
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 13:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjAEMHQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Jan 2023 07:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjAEMHK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Jan 2023 07:07:10 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979558D2E
        for <bpf@vger.kernel.org>; Thu,  5 Jan 2023 04:07:09 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m6so44389172lfj.11
        for <bpf@vger.kernel.org>; Thu, 05 Jan 2023 04:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=55P0k+X70cvzak8ADyEtFj0nHSFB0ZK6QLV9QZoBWrE=;
        b=TAyEo+RcVzvzd2ESu+YDnapakriLEMebNxqUCLJQCrSpGF6mMbNZdjWHOA0M/Fc+/o
         5Mq/Po89oQ3SckTsS+EbqXSHTqWcBCdByUaGOluHrXko3Ug163vErRzGiYAmUhacHElf
         YAJtHZ9HilMBuHoi8icWRJe4ciFnJ2qkRviB4b84jD4FqcJeqhtWE62GNl8gz9oCv5Vo
         PsGROAncC2CZUOjjovLLt/7v9esHEUlnwt40FV0o+2vdTKw7dVTyeS13jQzJ6ugQkMGP
         xMIqWzOF7xB5M3baBiS0v1VrRE4g0+RzeaHR+8UgDXenfaL4HBQhyIMvhlQd43/SeCa9
         apZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55P0k+X70cvzak8ADyEtFj0nHSFB0ZK6QLV9QZoBWrE=;
        b=pecQgE90UnLQaiwQScN7QEvg1I0Kg3vszdkP0n0+D9+5HG4pjLdKZcsXWv53A1sNms
         NK7ONlKsAYxnczcyVlj5l3ar8DXLfmVEUGv4tPMG66rQlidNIEZMFV2V1dnGjhV+s+fN
         pdhRZZFCRbAZ4CteJGmYYGX8wqJrK0iKOkBXxs6+VKTOqkPtrC/ZpksJCTSiO/iR1BCe
         JzNPrBGl4tb3d9oxvoFDbzE4gc/03iB6jLlZ1ZuuVsPdME1/i93Ve5sY+Hd2A0DvbLmR
         cwkgJf9R8Wu5xuvEC0EAoRk1ShkyxX92z7zjhLpnEHRLi/lKT7BpuzY5OOaDlajv5CMk
         1iFg==
X-Gm-Message-State: AFqh2krAF0wsHDkCHHQuNyqH0unFl7gNPbexuru4n+vGFY2rptWvO86z
        p3Baa9PpHIhWiReLBlNc058=
X-Google-Smtp-Source: AMrXdXuFIOwLS+0lWy/idd36TpqQI/dZ1HHkpDPbAAkFqxkVXM7iK3dsu9UoF4qKIUSQVqHTT3PEsw==
X-Received: by 2002:a19:f514:0:b0:4b7:2a7:1241 with SMTP id j20-20020a19f514000000b004b702a71241mr13153456lfb.64.1672920427313;
        Thu, 05 Jan 2023 04:07:07 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g16-20020a2ea4b0000000b0027fe7098f11sm1225399ljm.11.2023.01.05.04.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:07:06 -0800 (PST)
Message-ID: <1155fda8d54188f04270bb72c625d91f772e9999.camel@gmail.com>
Subject: Re: [RFC bpf-next 0/5] Support for BPF_ST instruction in LLVM C
 compiler
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        david.faust@oracle.com, James Hilliard <james.hilliard1@gmail.com>
Date:   Thu, 05 Jan 2023 14:07:05 +0200
In-Reply-To: <874jt5mh2j.fsf@oracle.com>
References: <20221231163122.1360813-1-eddyz87@gmail.com>
         <CAEf4BzbNM_U4b3gi4AwiTV5GMXEsAsJx8sMVA32ijJRygrVpFg@mail.gmail.com>
         <874jt5mh2j.fsf@oracle.com>
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

On Thu, 2023-01-05 at 11:06 +0100, Jose E. Marchesi wrote:
> > On Sat, Dec 31, 2022 at 8:31 AM Eduard Zingerman <eddyz87@gmail.com> wr=
ote:
> > >=20
> > > BPF has two documented (non-atomic) memory store instructions:
> > >=20
> > > BPF_STX: *(size *) (dst_reg + off) =3D src_reg
> > > BPF_ST : *(size *) (dst_reg + off) =3D imm32
> > >=20
> > > Currently LLVM BPF back-end does not emit BPF_ST instruction and does
> > > not allow one to be specified as inline assembly.
> > >=20
> > > Recently I've been exploring ways to port some of the verifier test
> > > cases from tools/testing/selftests/bpf/verifier/*.c to use inline ass=
embly
> > > and machinery provided in tools/testing/selftests/bpf/test_loader.c
> > > (which should hopefully simplify tests maintenance).
> > > The BPF_ST instruction is popular in these tests: used in 52 of 94 fi=
les.
> > >=20
> > > While it is possible to adjust LLVM to only support BPF_ST for inline
> > > assembly blocks it seems a bit wasteful. This patch-set contains a se=
t
> > > of changes to verifier necessary in case when LLVM is allowed to
> > > freely emit BPF_ST instructions (source code is available here [1]).
> >=20
> > Would we gate LLVM's emitting of BPF_ST for C code behind some new
> > cpu=3Dv4? What is the benefit for compiler to start automatically emit
> > such instructions? Such thinking about logistics, if there isn't much
> > benefit, as BPF application owner I wouldn't bother enabling this
> > behavior risking regressions on old kernels that don't have these
> > changes.
>=20
> Hmm, GCC happily generates BPF_ST instructions:
>=20
> =C2=A0=C2=A0$ echo 'int v; void foo () {  v =3D 666; }' | bpf-unknown-non=
e-gcc -O2 -xc -S -o foo.s -
> =C2=A0=C2=A0$ cat foo.s
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.file	"<stdin>"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.text
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.align	3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.global	foo
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.type	foo, @function
> =C2=A0=C2=A0foo:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lddw	%r0,v
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stw	[%r0+0],666
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0exit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.size	foo, .-foo
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.global	v
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.type	v, @object
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.lcomm	v,4,4
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.ident	"GCC: (GNU) 12.0.0=
 20211206 (experimental)"
>=20
> Been doing that since October 2019, I think before the cpu versioning
> mechanism was got in place?
>=20
> We weren't aware this was problematic.  Does the verifier reject such
> instructions?

Interesting, do BPF selftests generated by GCC pass the same way they
do if generated by clang?

I had to do the following changes to the verifier to make the
selftests pass when BPF_ST instruction is allowed for selection:

- patch #1 in this patchset: track values of constants written to
  stack using BPF_ST. Currently these are tracked imprecisely, unlike
  the writes using BPF_STX, e.g.:
 =20
    fp[-8] =3D 42;   currently verifier assumes that fp[-8]=3Dmmmmmmmm
                   after such instruction, where m stands for "misc",
                   just a note that something is written at fp[-8].
                  =20
    r1 =3D 42;       verifier tracks r1=3D42 after this instruction.
    fp[-8] =3D r1;   verifier tracks fp[-8]=3D42 after this instruction.

  So the patch makes both cases equivalent.
 =20
- patch #3 in this patchset: adjusts verifier.c:convert_ctx_access()
  to operate on BPF_ST alongside BPF_STX.
 =20
  Context parameters for some BPF programs types are "fake" data
  structures. The verifier matches all BPF_STX and BPF_LDX
  instructions that operate on pointers to such contexts and rewrites
  these instructions. It might change an offset or add another layer
  of indirection, etc. E.g. see filter.c:bpf_convert_ctx_access().
  (This also implies that verifier forbids writes to non-constant
   offsets inside such structures).
  =20
  So the patch extends this logic to also handle BPF_ST.

>=20
> > So I feel like the biggest benefit is to be able to use this
> > instruction in embedded assembly, to make writing and maintaining
> > tests easier.
> >=20
> > > The changes include:
> > > =C2=A0- update to verifier.c:check_stack_write_*() functions to track
> > > =C2=A0=C2=A0=C2=A0constant values spilled to stack via BPF_ST instruc=
tion in a same
> > > =C2=A0=C2=A0=C2=A0way stack spills of known registers by BPF_STX are =
tracked;
> > > =C2=A0- updates to verifier.c:convert_ctx_access() and it's callbacks=
 to
> > > =C2=A0=C2=A0=C2=A0handle BPF_ST instruction in a way similar to BPF_S=
TX;
> > > =C2=A0- some test adjustments and a few new tests.
> > >=20
> > > With the above changes applied and LLVM from [1] all test_verifier,
> > > test_maps, test_progs and test_progs-no_alu32 test cases are passing.
> > >=20
> > > When built using the LLVM version from [1] BPF programs generated for
> > > selftests and Cilium programs (taken from [2]) see certain reduction
> > > in size, e.g. below are total numbers of instructions for files with
> > > over 5K instructions:
> > >=20
> > > File                                    Insns   Insns   Insns   Diff
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0w/o     with    diff    pct
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0BPF_ST  BPF_ST
> > > cilium/bpf_host.o                       44620   43774   -846    -1.90=
%
> > > cilium/bpf_lxc.o                        36842   36060   -782    -2.12=
%
> > > cilium/bpf_overlay.o                    23557   23186   -371    -1.57=
%
> > > cilium/bpf_xdp.o                        26397   25931   -466    -1.77=
%
> > > selftests/core_kern.bpf.o               12359   12359    0       0.00=
%
> > > selftests/linked_list_fail.bpf.o        5501    5302    -199    -3.62=
%
> > > selftests/profiler1.bpf.o               17828   17709   -119    -0.67=
%
> > > selftests/pyperf100.bpf.o               49793   49268   -525    -1.05=
%
> > > selftests/pyperf180.bpf.o               88738   87813   -925    -1.04=
%
> > > selftests/pyperf50.bpf.o                25388   25113   -275    -1.08=
%
> > > selftests/pyperf600.bpf.o               78330   78300   -30     -0.04=
%
> > > selftests/pyperf_global.bpf.o           5244    5188    -56     -1.07=
%
> > > selftests/pyperf_subprogs.bpf.o         5262    5192    -70     -1.33=
%
> > > selftests/strobemeta.bpf.o              17154   16065   -1089   -6.35=
%
> > > selftests/test_verif_scale2.bpf.o       11337   11337    0       0.00=
%
> > >=20
> > > (Instructions are counted by counting the number of instruction lines
> > > =C2=A0in disassembly).
> > >=20
> > > Is community interested in this work?
> > > Are there any omissions in my changes to the verifier?
> > >=20
> > > Known issue:
> > >=20
> > > There are two programs (one Cilium, one selftest) that exhibit
> > > anomalous increase in verifier processing time with this patch-set:
> > >=20
> > > =C2=A0File                 Program                        Insns (A)  =
Insns (B)  Insns   (DIFF)
> > > =C2=A0-------------------  -----------------------------  ---------  =
---------  --------------
> > > =C2=A0bpf_host.o           tail_ipv6_host_policy_ingress       1576  =
     2403  +827 (+52.47%)
> > > =C2=A0map_kptr.bpf.o       test_map_kptr                        400  =
      475   +75 (+18.75%)
> > > =C2=A0-------------------  -----------------------------  ---------  =
---------  --------------
> > >=20
> > > These are under investigation.
> > >=20
> > > Thanks,
> > > Eduard
> > >=20
> > > [1] https://reviews.llvm.org/D140804
> > > [2] git@github.com:anakryiko/cilium.git
> > >=20
> > > Eduard Zingerman (5):
> > > =C2=A0=C2=A0bpf: more precise stack write reasoning for BPF_ST instru=
ction
> > > =C2=A0=C2=A0selftests/bpf: check if verifier tracks constants spilled=
 by
> > > =C2=A0=C2=A0=C2=A0=C2=A0BPF_ST_MEM
> > > =C2=A0=C2=A0bpf: allow ctx writes using BPF_ST_MEM instruction
> > > =C2=A0=C2=A0selftests/bpf: test if pointer type is tracked for BPF_ST=
_MEM
> > > =C2=A0=C2=A0selftests/bpf: don't match exact insn index in expected e=
rror message
> > >=20
> > > =C2=A0kernel/bpf/cgroup.c                           |  49 +++++---
> > > =C2=A0kernel/bpf/verifier.c                         | 102 +++++++++--=
-----
> > > =C2=A0net/core/filter.c                             |  72 ++++++-----=
-
> > > =C2=A0.../selftests/bpf/prog_tests/log_fixup.c      |   2 +-
> > > =C2=A0.../selftests/bpf/prog_tests/spin_lock.c      |   8 +-
> > > =C2=A0.../bpf/verifier/bounds_mix_sign_unsign.c     | 110 ++++++++++-=
-------
> > > =C2=A0.../selftests/bpf/verifier/bpf_st_mem.c       |  29 +++++
> > > =C2=A0tools/testing/selftests/bpf/verifier/ctx.c    |  11 --
> > > =C2=A0tools/testing/selftests/bpf/verifier/unpriv.c |  23 ++++
> > > =C2=A09 files changed, 249 insertions(+), 157 deletions(-)
> > > =C2=A0create mode 100644 tools/testing/selftests/bpf/verifier/bpf_st_=
mem.c
> > >=20
> > > --
> > > 2.39.0
> > >=20

