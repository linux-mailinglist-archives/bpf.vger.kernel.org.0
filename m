Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9622543B
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 17:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfEUPl5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 11:41:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34996 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfEUPl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 11:41:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so6213451wrv.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lWKZ0fTCl66amGszMBQwOE+gmAoKqjSyVUyEoeR16P4=;
        b=Uk9xUkkZGWL4DCSX5kc84hSC3YLv4w4GKw4xLfq60RuaNCqpxA+ROm1SfxPyDZJK8f
         fhDzSIqSEakFOZoFIko+UVrXPbB2mDG38UEaEk3vsTrVgQQCVNHzJg4yEh1sLQqgrdN6
         IxcfnSo7c3Fblg62o/Y/Z8tDvwkOJHSoiBt0HjhKBIBeMC8vuzyZAZHSLXaV+pZa970Y
         7+lkE6RT1+K8Tj0v9k6UI3P/hReposGXDw6Vzy3VToN9UFHbSdS0AqfjlWNItD8uNEio
         dk3sVoYpqyt+PTuPNNwbU28DxfG9ntoc13PngJ6FmrJ/gvPlJix6nHL77mQXE3dC2SFg
         dKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lWKZ0fTCl66amGszMBQwOE+gmAoKqjSyVUyEoeR16P4=;
        b=D3auns453wr3XgjgWxiyweFfISvxTNgAf+65GyIsXI1AWZKxYSrgdLZ200zSgXTj+3
         O16WFmVeGWfmafR3bvwACvCj0iSyHCceLHt+7Gof3X/Mmdhn8TO1YJbAWJMq2T1JlYBn
         CTObVvY1OKapfZWzwhEZkZNIlx8rBPBhBR0w2NiiOOeikupYyAWZyUo/IqGmpHQMFxUX
         i40VlG9moaSrV4snlu/kHkDYIQT15ENVSZDcU3P6TEkCdzjEOXT3JlSPmDpKNP70kDuo
         TkM+2pChdK74U+Ewbq+gMg5eWJAEziVwpL7MueFaZ3a1ZWEnenLqUfq+zJ1c5LgCHHEE
         986w==
X-Gm-Message-State: APjAAAUw65jF6CYAv6DLp9mpK2myvVE2PTMUYeZ62X0eMXGWjYYf5kab
        VjvDXvkhnocRdjdL4GEGraVqEGce/FQ=
X-Google-Smtp-Source: APXvYqzx4v2EysEbotYVE1xblwXp6DJ9OzBD2XU3meMZiDlE2waKJwICngY1p0EGK+bntP7YcAXmbA==
X-Received: by 2002:adf:f44b:: with SMTP id f11mr21127797wrp.128.1558453314481;
        Tue, 21 May 2019 08:41:54 -0700 (PDT)
Received: from [172.20.1.229] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a15sm5908595wrw.49.2019.05.21.08.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 08:41:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/9] eBPF support for GNU binutils
From:   Jiong Wang <jiong.wang@netronome.com>
In-Reply-To: <20190520164526.13491-1-jose.marchesi () oracle ! com>
Date:   Tue, 21 May 2019 16:41:56 +0100
Cc:     binutils@sourceware.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
References: <20190520164526.13491-1-jose.marchesi () oracle ! com>
To:     jose.marchesi@oracle.com
X-Mailer: Apple Mail (2.3273)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

CCing BPF kernel community who is defining the ISA and various runtime =
stuff.

Also two inline comments below about the assembler

> On 20 May 2019, at 17:45, Jose E. Marchesi <jose.marchesi oracle ! =
com> wrote:
>=20
> Hi people!
>=20
> This patch series introduces support for eBPF, which is a virtual
> machine that resides in the Linux kernel.  Initially intended for
> user-level packet capture and filtering, eBPF is nowadays generalized
> to serve as a general-purpose infrastructure also for non-networking
> purposes.
>=20
> The first patch is preparatory, and adds support to config.guess to
> recognize bpf-*-* triplets.  This will be submitted as a patch to the
> `config' project as soon as this series gets upstreamed.
>=20
> The second and third patches add support for an ELF64 based eBPF
> target to BFD, in both little-endian and big-endian vectors.
>=20
> The fourth patch adds a CGEN cpu description for eBPF, plus support
> code.  This description covers the full eBPF ISA.  Due to the 64-bit
> instruction fields used in some instructions, we needed to fix a
> bug/limitation in CGEN impacting 32-bit hosts.  The fix is in a patch
> submitted to CGEN last week, that is still waiting for review:
> http://www.sourceware.org/ml/cgen/2019-q2/msg00008.html None of the
> existing CGEN ports in binutils are impacted by that patch: the code
> generated for these remains exactly the same.
>=20
> The fifth patch adds opcodes and disassembler support for eBPF, based
> on the CGEN description.
>=20
> The sixth patch adds a GAS port, including a testsuite and manual
> updates.  By default the assembler generates objects using the same
> endianness than the host.  This can be overrided by the usual -EB and
> -EB command-line options.
>=20
> Support for linking eBPF ELF files with ld/bfd is provided in the
> seventh patch.  A couple of simple tests are included.
>=20
> The eighth patch adds support for eBPF to readelf, and makes a little
> adjustment in the `nm' testsuite to not fail in bpf-*-* targets.
>=20
> Finally, the last patch adds myself as the maintainer of the BPF
> target.  We are committing to maintain this port.
>=20
> Future work on the binutils port:
> * Support for semantic actions in bpf.cpu, and support code for a
>  simulator in sim/.
> * Support for ld.gold.
>=20
> Next stop is GCC.  An eBPF backend is on the works.  We plan to
> upstream it before September.
>=20
> Regressions tested in all targets.
> Regressions tested with --enable-targets=3Dall
> Tested in 64-bit x86_64 host.
> Tested in 32-bit x86 host.
>=20
> Oh, a little note regarding interoperability:
>=20
> There is a clang/llvm based toolchain for eBPF.  However, at this
> moment compiled eBPF doesn't have established conventions.  The
> details on what is expected to be in an ELF file containing eBPF is
> determined, in practice, by what the llvm BPF backend supports and
> what the sample bpf_load.c in the Linux kernel source tree expects
> [1].
>=20
> Despite using a different syntax for the assembler (the llvm assembler
> uses a C-ish expression-based syntax while the GNU assembler opts for
> a more classic assembly-language syntax) this implementation tries to
> provide inter-operability with clang/llvm generated objects.

I also noticed your implementation doesn=E2=80=99t seem to use the same =
sub-register
syntax as what LLVM assembler is doing.

  x register for 64-bit, and w register for 32-bit sub-register.

So:
  add r0, r1, r2 means BPF_ALU64 | BPF_ADD | BFF_X
  add w0, w1, w1 means BPF_ALU | BPF_ADD | BPF_X

ASAICT, different register prefix for different register width is also =
adopted
by quite a few other GNU assembler targets like AArch64, X86_64.

>=20
> In particular, the numbers of the relocations used for instruction
> fields are the same.  These are R_BPF_INSN_64 and R_BPF_INSN_DISP32.
> The later is resolved at load-time by bpf_load.c.

I think you missed the latest JMP32 instructions.

  =
https://github.com/torvalds/linux/blob/master/Documentation/networking/fil=
ter.txt#L870


>=20
> [1] We expect/hope that the addition of eBPF support to the GNU
>    toolchain will help to mature the domain of compiled eBPF.  We
>    will certainly be working with the kernel people to that effect.
>=20
> Salud!
>=20
> Jose E. Marchesi (9):
>  config: recognize eBPF triplets
>  include: add elf/bpf.h
>  bfd: add support for eBPF
>  cpu: add eBPF cpu description
>  opcodes: add support for eBPF
>  gas: add support for eBPF
>  ld: add support for eBPF
>  binutils: add support for eBPF
>  binutils: add myself as the maintainer for BPF
>=20
> ChangeLog                              |    4 +
> bfd/ChangeLog                          |   20 +
> bfd/Makefile.am                        |    4 +
> bfd/Makefile.in                        |    7 +
> bfd/archures.c                         |    4 +
> bfd/bfd-in2.h                          |    9 +
> bfd/config.bfd                         |    6 +
> bfd/configure                          |   30 +-
> bfd/configure.ac                       |    2 +
> bfd/cpu-bpf.c                          |   41 +
> bfd/elf64-bpf.c                        |  463 +++++++++
> bfd/libbfd.h                           |    5 +
> bfd/reloc.c                            |   13 +
> bfd/targets.c                          |    7 +
> binutils/ChangeLog                     |   13 +
> binutils/MAINTAINERS                   |    1 +
> binutils/readelf.c                     |    8 +
> binutils/testsuite/binutils-all/nm.exp |    3 +-
> config.sub                             |    4 +-
> cpu/ChangeLog                          |    5 +
> cpu/bpf.cpu                            |  647 +++++++++++++
> cpu/bpf.opc                            |  191 ++++
> gas/ChangeLog                          |   45 +
> gas/Makefile.am                        |    2 +
> gas/Makefile.in                        |    6 +
> gas/config/tc-bpf.c                    |  357 +++++++
> gas/config/tc-bpf.h                    |   51 +
> gas/configure                          |   38 +-
> gas/configure.ac                       |    6 +
> gas/configure.tgt                      |    1 +
> gas/doc/Makefile.am                    |    1 +
> gas/doc/Makefile.in                    |    6 +-
> gas/doc/all.texi                       |    1 +
> gas/doc/as.texi                        |   34 +
> gas/doc/c-bpf.texi                     |  364 +++++++
> gas/testsuite/gas/all/gas.exp          |    3 +
> gas/testsuite/gas/all/org-1.l          |    2 +-
> gas/testsuite/gas/all/org-1.s          |    2 +
> gas/testsuite/gas/bpf/alu-be.d         |   59 ++
> gas/testsuite/gas/bpf/alu.d            |   58 ++
> gas/testsuite/gas/bpf/alu.s            |   51 +
> gas/testsuite/gas/bpf/alu32-be.d       |   65 ++
> gas/testsuite/gas/bpf/alu32.d          |   64 ++
> gas/testsuite/gas/bpf/alu32.s          |   57 ++
> gas/testsuite/gas/bpf/atomic-be.d      |   12 +
> gas/testsuite/gas/bpf/atomic.d         |   11 +
> gas/testsuite/gas/bpf/atomic.s         |    5 +
> gas/testsuite/gas/bpf/bpf.exp          |   38 +
> gas/testsuite/gas/bpf/call-be.d        |   19 +
> gas/testsuite/gas/bpf/call.d           |   18 +
> gas/testsuite/gas/bpf/call.s           |   11 +
> gas/testsuite/gas/bpf/exit-be.d        |   11 +
> gas/testsuite/gas/bpf/exit.d           |   10 +
> gas/testsuite/gas/bpf/exit.s           |    2 +
> gas/testsuite/gas/bpf/jump-be.d        |   32 +
> gas/testsuite/gas/bpf/jump.d           |   31 +
> gas/testsuite/gas/bpf/jump.s           |   25 +
> gas/testsuite/gas/bpf/lddw-be.d        |   18 +
> gas/testsuite/gas/bpf/lddw.d           |   17 +
> gas/testsuite/gas/bpf/lddw.s           |    6 +
> gas/testsuite/gas/bpf/mem-be.d         |   30 +
> gas/testsuite/gas/bpf/mem.d            |   29 +
> gas/testsuite/gas/bpf/mem.s            |   24 +
> include/ChangeLog                      |    4 +
> include/elf/bpf.h                      |   45 +
> ld/ChangeLog                           |   15 +
> ld/Makefile.am                         |    2 +
> ld/Makefile.in                         |    4 +
> ld/configure                           |   28 +-
> ld/configure.tgt                       |    1 +
> ld/emulparams/elf64bpf.sh              |   10 +
> ld/testsuite/ld-bpf/bar.s              |    5 +
> ld/testsuite/ld-bpf/baz.s              |    5 +
> ld/testsuite/ld-bpf/bpf.exp            |   29 +
> ld/testsuite/ld-bpf/call-1.d           |   23 +
> ld/testsuite/ld-bpf/foo.s              |    5 +
> ld/testsuite/ld-bpf/jump-1.d           |   23 +
> ld/testsuite/lib/ld-lib.exp            |    1 +
> opcodes/ChangeLog                      |   24 +
> opcodes/Makefile.am                    |   17 +
> opcodes/Makefile.in                    |   23 +
> opcodes/bpf-asm.c                      |  590 ++++++++++++
> opcodes/bpf-desc.c                     | 1638 =
++++++++++++++++++++++++++++++++
> opcodes/bpf-desc.h                     |  266 ++++++
> opcodes/bpf-dis.c                      |  624 ++++++++++++
> opcodes/bpf-ibld.c                     |  956 +++++++++++++++++++
> opcodes/bpf-opc.c                      | 1495 =
+++++++++++++++++++++++++++++
> opcodes/bpf-opc.h                      |  151 +++
> opcodes/configure                      |   19 +-
> opcodes/configure.ac                   |    1 +
> opcodes/disassemble.c                  |   35 +
> opcodes/disassemble.h                  |    1 +
> 92 files changed, 9116 insertions(+), 33 deletions(-)
> create mode 100644 bfd/cpu-bpf.c
> create mode 100644 bfd/elf64-bpf.c
> create mode 100644 cpu/bpf.cpu
> create mode 100644 cpu/bpf.opc
> create mode 100644 gas/config/tc-bpf.c
> create mode 100644 gas/config/tc-bpf.h
> create mode 100644 gas/doc/c-bpf.texi
> create mode 100644 gas/testsuite/gas/bpf/alu-be.d
> create mode 100644 gas/testsuite/gas/bpf/alu.d
> create mode 100644 gas/testsuite/gas/bpf/alu.s
> create mode 100644 gas/testsuite/gas/bpf/alu32-be.d
> create mode 100644 gas/testsuite/gas/bpf/alu32.d
> create mode 100644 gas/testsuite/gas/bpf/alu32.s
> create mode 100644 gas/testsuite/gas/bpf/atomic-be.d
> create mode 100644 gas/testsuite/gas/bpf/atomic.d
> create mode 100644 gas/testsuite/gas/bpf/atomic.s
> create mode 100644 gas/testsuite/gas/bpf/bpf.exp
> create mode 100644 gas/testsuite/gas/bpf/call-be.d
> create mode 100644 gas/testsuite/gas/bpf/call.d
> create mode 100644 gas/testsuite/gas/bpf/call.s
> create mode 100644 gas/testsuite/gas/bpf/exit-be.d
> create mode 100644 gas/testsuite/gas/bpf/exit.d
> create mode 100644 gas/testsuite/gas/bpf/exit.s
> create mode 100644 gas/testsuite/gas/bpf/jump-be.d
> create mode 100644 gas/testsuite/gas/bpf/jump.d
> create mode 100644 gas/testsuite/gas/bpf/jump.s
> create mode 100644 gas/testsuite/gas/bpf/lddw-be.d
> create mode 100644 gas/testsuite/gas/bpf/lddw.d
> create mode 100644 gas/testsuite/gas/bpf/lddw.s
> create mode 100644 gas/testsuite/gas/bpf/mem-be.d
> create mode 100644 gas/testsuite/gas/bpf/mem.d
> create mode 100644 gas/testsuite/gas/bpf/mem.s
> create mode 100644 include/elf/bpf.h
> create mode 100644 ld/emulparams/elf64bpf.sh
> create mode 100644 ld/testsuite/ld-bpf/bar.s
> create mode 100644 ld/testsuite/ld-bpf/baz.s
> create mode 100644 ld/testsuite/ld-bpf/bpf.exp
> create mode 100644 ld/testsuite/ld-bpf/call-1.d
> create mode 100644 ld/testsuite/ld-bpf/foo.s
> create mode 100644 ld/testsuite/ld-bpf/jump-1.d
> create mode 100644 opcodes/bpf-asm.c
> create mode 100644 opcodes/bpf-desc.c
> create mode 100644 opcodes/bpf-desc.h
> create mode 100644 opcodes/bpf-dis.c
> create mode 100644 opcodes/bpf-ibld.c
> create mode 100644 opcodes/bpf-opc.c
> create mode 100644 opcodes/bpf-opc.h
>=20
> --=20
> 2.11.0

