Return-Path: <bpf+bounces-5072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D2755914
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 03:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2064E28131B
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 01:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1859D1119;
	Mon, 17 Jul 2023 01:39:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9861A49
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 01:39:33 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086EC11A
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 18:39:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbea147034so36149685e9.0
        for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 18:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689557970; x=1692149970;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LYa6gQ4dgIi7PV+7LgpSTk9RuFPHY24qASnegne4Glo=;
        b=FsSBtNBCF4c+LnPJFblx13peA1M670EgASKUCYhlkfaBAbnbeWMqCgC3+p0OJOe3pl
         YAwfa/dh093hIZcXwqhrK03HuOxtz4VNWKu03DTjTg63lE0fXI+MCI9vG/giejnmyzkv
         HbFwKmV7044tSeN8fMYOHeIlEi8277Yu6C03otVdLoDLTReEEI+rk6KebgyI40iCEh0w
         ulg9hx0/gqU9KrRnhe+kicXZ+sWOHANO+DnbQpmNrWEGfmYsAK4msBezwr58RqiOkEms
         7a1BLSTL2ycXFY6Zmml+yjHbY5pNlYEqSoZvCGPV7V8fUK6AqPqKjyfbUDjBFH9Dx4N3
         jz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689557970; x=1692149970;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYa6gQ4dgIi7PV+7LgpSTk9RuFPHY24qASnegne4Glo=;
        b=FwaxK49FuLXN5OQAuMloJwaD9m0EnPqa1tTE8EVek3VKArggkL8E3GpIdEvMX8UYsY
         d+jxRVIgmlb05o085Qa3uBPp+Sg5YDULQyz6hc/n07sHVtBwYzgW+6NijIYB4MHe2+qe
         zp2Wx0rDbQxcrmfw7wO6tp2cK9JdVOCAW44LFsB6BrmhqsluItzP4X8D9uVDcwtUxgPR
         lOJ/GdINozVfss97gl23Fsk64gaJAyWWcrn6OBz61GqJSx4WkLXvcu0Ls4T+6sk++wng
         8ZVPDhDP4yCsKaQfD9O+dYAJmQ/zSCkiYUt3Rqx74oHfkMc86go8vqZ7rsSKNoMdVfhl
         LcBg==
X-Gm-Message-State: ABy/qLawL3410+3hQboRMU1EqG2+tJS1U8BAXRhnB52DragGkXNcPLG5
	mV8IkgjmAoVn+6NryfY3RtQ=
X-Google-Smtp-Source: APBJJlHVotPBgXBWkrih0Dk5vAi23qUceisdgKvJgeCsqsr0F5rIWtZKLWQcaHh89S5ecpjElcHCZQ==
X-Received: by 2002:a05:600c:11cf:b0:3fb:e4ce:cc65 with SMTP id b15-20020a05600c11cf00b003fbe4cecc65mr7793625wmi.25.1689557970283;
        Sun, 16 Jul 2023 18:39:30 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c224600b003fbc89af035sm6819294wmm.17.2023.07.16.18.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 18:39:29 -0700 (PDT)
Message-ID: <8b3e804bc23d44ba3a30b9d69e6590bede857ed3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 00/15] bpf: Support new insns from cpu v4
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song
 <maskray@google.com>, kernel-team@fb.com
Date: Mon, 17 Jul 2023 04:39:28 +0300
In-Reply-To: <20230713060718.388258-1-yhs@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-12 at 23:07 -0700, Yonghong Song wrote:
> > In previous discussion ([1]), it is agreed that we should introduce
> > cpu version 4 (llvm flag -mcpu=3Dv4) which contains some instructions
> > which can simplify code, make code easier to understand, fix the
> > existing problem, or simply for feature completeness. More specifically=
,
> > the following new insns are proposed:
> >   . sign extended load
> >   . sign extended mov
> >   . bswap
> >   . signed div/mod
> >   . ja with 32-bit offset
> >=20
> > This patch set added kernel support for insns proposed in [1] except
> > BPF_ST which already has full kernel support. Beside the above proposed
> > insns, LLVM will generate BPF_ST insn as well under -mcpu=3Dv4 ([2]).
> >=20
> > The patchset implements interpreter and jit support for these new
> > insns as well as necessary verifier support.

Hi Yonghong,

Sorry for delayed response, I'm still in the middle of the series.
I've tested this patch-set using updated LLVM version and have
a few notes:
- kernel/bpf/disasm.c needs an update to handle new instructions;
- test_verifier test 'invalid 64-bit BPF_END' from basic_instr.c
 is failing because '.code =3D BPF_ALU64 | BPF_END | BPF_TO_LE'
 is now valid;
- I've looked through the usage of BPF_LDX and found that there
 is a function seccomp.c:seccomp_check_filter(), that directly
 checks possible CLASS / CODE combinations. Should this function
 be updated to handle new instructions?

Thanks,
Eduard

> >=20
> > To test this patch set, you need to have latest llvm from 'main' branch
> > of llvm-project repo and apply [2] on top of it.
> >=20
> >   [1] https://lore.kernel.org/bpf/4bfe98be-5333-1c7e-2f6d-42486c8ec039@=
meta.com/
> >   [2] https://reviews.llvm.org/D144829
> >=20
> > Changelogs:
> >   RFCv1 -> v2:
> >    . add more verifier supports for signed extend load and mov insns.
> >    . rename some insn names to be more consistent with intel practice.
> >    . add cpuv4 test runner for test progs.
> >    . add more unit and C tests.
> >    . add documentation.
> >=20
> > Yonghong Song (15):
> >   bpf: Support new sign-extension load insns
> >   bpf: Fix sign-extension ctx member accesses
> >   bpf: Support new sign-extension mov insns
> >   bpf: Support new unconditional bswap instruction
> >   bpf: Support new signed div/mod instructions.
> >   bpf: Fix jit blinding with new sdiv/smov insns
> >   bpf: Support new 32bit offset jmp instruction
> >   selftests/bpf: Add a cpuv4 test runner for cpu=3Dv4 testing
> >   selftests/bpf: Add unit tests for new sign-extension load insns
> >   selftests/bpf: Add unit tests for new sign-extension mov insns
> >   selftests/bpf: Add unit tests for new bswap insns
> >   selftests/bpf: Add unit tests for new sdiv/smod insns
> >   selftests/bpf: Add unit tests for new gotol insn
> >   selftests/bpf: Test ldsx with more complex cases
> >   docs/bpf: Add documentation for new instructions
> >=20
> >  Documentation/bpf/bpf_design_QA.rst           |   5 -
> >  .../bpf/standardization/instruction-set.rst   | 100 ++-
> >  arch/x86/net/bpf_jit_comp.c                   | 131 ++-
> >  include/linux/filter.h                        |  14 +-
> >  include/uapi/linux/bpf.h                      |   1 +
> >  kernel/bpf/cgroup.c                           |  14 +-
> >  kernel/bpf/core.c                             | 174 +++-
> >  kernel/bpf/verifier.c                         | 315 ++++++--
> >  tools/include/uapi/linux/bpf.h                |   1 +
> >  tools/testing/selftests/bpf/.gitignore        |   2 +
> >  tools/testing/selftests/bpf/Makefile          |  18 +-
> >  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   9 +-
> >  .../selftests/bpf/prog_tests/test_ldsx_insn.c |  88 ++
> >  .../selftests/bpf/prog_tests/verifier.c       |  10 +
> >  .../selftests/bpf/progs/test_ldsx_insn.c      |  75 ++
> >  .../selftests/bpf/progs/verifier_bswap.c      |  45 ++
> >  .../selftests/bpf/progs/verifier_gotol.c      |  30 +
> >  .../selftests/bpf/progs/verifier_ldsx.c       | 115 +++
> >  .../selftests/bpf/progs/verifier_movsx.c      | 177 ++++
> >  .../selftests/bpf/progs/verifier_sdiv.c       | 763 ++++++++++++++++++
> >  20 files changed, 1929 insertions(+), 158 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ldsx_in=
sn.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_ldsx_insn.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bswap.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_gotol.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_ldsx.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_movsx.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_sdiv.c
> >=20


