Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CBE67ECAE
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 18:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjA0Rlw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 12:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjA0Rlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 12:41:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445F67D2BB
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:41:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id n6so2746049edo.9
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GbqHwGc+ppXnlm2paWGTvmJSi2PnLegynGXn//75uDM=;
        b=Pgr7U7NS65xQWQw4vZne4muoD/bvgGxGOX0Mjb0GL5uooBnaTG1zSemXd4QV+Rv7lf
         maKEjwh/UPC0MlSe9iujLyqQCyFIPykjImR5KBqglCzF44CB7md/CQeDQuLLnFyo5dnp
         6w+GbTDs0Aqgc19hF1WPwpaQsU7ZTfqvLriSnuOqDReL0bDJFoN7Vbo6qfTtzpmSgEog
         EOHfTDUbH9AzOw30A8dLVSwrmBqPGWOSRsk4ECCrjoUJ7k74cP33/Mb15kzQUZ9Ex8xz
         +xRQA82N4qVu7o7bpdUCPZJA7msEepCKwz4/dOtCZJWzmp8mVB4IQDYKW6M8cQC2xzxK
         gIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbqHwGc+ppXnlm2paWGTvmJSi2PnLegynGXn//75uDM=;
        b=n+8TCmOQ0u44MKCpoeCvPbM2LLQdfkMo136FtyPcZmOxY2TmuXO+VgNMkhodDwe2k8
         pbIAoxUhwTI9mLtrVEOYV8l6rcv7xXeWrphSr7dr7ZgIKcIc8LW3toxLIUDLqQie3SL1
         sdZBH2Hjog3lo/qXtFaf3ck4FW4Cg7YU3t1hB3J0fGcKAsS/2AwchVJfxxc4RT1CPUj6
         BHi0q12CoA88AxR/O4RIs2YL+Cb+3YT4YGdr6xxYoloWsXbeR7VS/XZ8740YNllcl32w
         UiUUZRNazXElNwspSIFeZvyWGfu7s53MdvX0/dOQuuuVkY/10tBB3xju9omrH0i58Obi
         i0TQ==
X-Gm-Message-State: AO0yUKXMbCMnY11qRZAu3ztypSwTu+/6Y8Obd/IKz84QVTRDEK5zwslq
        ET6gkxNFpzqN25fmJMvmwDgjsUIgL9ffpSVq+us=
X-Google-Smtp-Source: AK7set8a5HUA8zQ4OoznLo8kFC7bOAt15pkTQkc0+jAWS7BBfiotDG+PMPInQIVc4ntlmeD/lFBLYtG1vaQWsb/lc8w=
X-Received: by 2002:a05:6402:510d:b0:4a0:cfed:1a47 with SMTP id
 m13-20020a056402510d00b004a0cfed1a47mr2305796edd.18.1674841299731; Fri, 27
 Jan 2023 09:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20230123145148.2791939-1-eddyz87@gmail.com> <CAEf4Bzbu2zctHntHNRVnEDa_FJz405Ld1Sb58wvJA+JvYdS+Ag@mail.gmail.com>
 <a06cc3ac1698a9d46ec37047415db5634b219a90.camel@gmail.com>
In-Reply-To: <a06cc3ac1698a9d46ec37047415db5634b219a90.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 27 Jan 2023 09:41:27 -0800
Message-ID: <CAEf4BzbYF703ndHjM8Un+6bOiRCRDzMhO4SdkTszvry2ps38pA@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/5] test_verifier tests migration to inline assembly
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 26, 2023 at 4:30 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2023-01-25 at 17:33 -0800, Andrii Nakryiko wrote:
> > On Mon, Jan 23, 2023 at 6:52 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > As a part of the discussion started in [2] I developed a script [1]
> > > that can convert tests specified in test_verifier.c format to inline
> > > BPF assembly compatible for use with test_loader.c.
> > >
> > > For example, test definition like below:
> > >
> > > {
> > >         "invalid and of negative number",
> > >         .insns = {
> > >         BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> > >         BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> > >         BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> > >         BPF_LD_MAP_FD(BPF_REG_1, 0),
> > >         BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> > >         BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
> > >         BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
> > >         BPF_ALU64_IMM(BPF_AND, BPF_REG_1, -4),
> > >         BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
> > >         BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
> > >         BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)),
> > >         BPF_EXIT_INSN(),
> > >         },
> > >         .fixup_map_hash_48b = { 3 },
> > >         .errstr = "R0 max value is outside of the allowed memory range",
> > >         .result = REJECT,
> > >         .flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
> > > },
> > >
> > > Is converted to:
> > >
> > > struct test_val { ... };
> > >
> > > struct { ...} map_hash_48b SEC(".maps");
> > >
> > > __description("invalid and of negative number")
> > > __failure __msg("R0 max value is outside of the allowed memory range")
> > > __failure_unpriv
> > > __flag(BPF_F_ANY_ALIGNMENT)
> > > SEC("socket")
> >
> > nit: let's make sure that SEC() is the first annotation, makes
> > grepping easier and is consistent with how we use SEC() with BPF
> > programs
>
> Ok, will move SEC to the top.
>
> >
> >
> > > __naked void invalid_and_of_negative_number(void)
> > >
> > > {
> > >         asm volatile (
> > > "       r1 = 0;                                         \n\
> >
> > Kumar recently landed similarly formatted inline asm-based test, let's
> > make sure we stick to common style. \n at the end are pretty
>
> Tbh, the '\n\' at the end of the line is much less distracting
> compared to the first variant when each instruction had it's own
> string ('"r1 = 0;\n"'). And I find it quite useful when compiler
> points to a bad asm instruction.
>
> But I'll remove it if you insist.

I'm not strongly opposed, but when writing new tests by hand I
wouldn't want to add all those \n's. So it's mostly style consistency.

>
> > distracting, IMO (though helpful to debug syntax errors in asm, of
> > course). I'd also move starting " into the same line as asm volatile:
>
> Ok, no problem, will move the '"'.
>
> >
> > asm volatile ("                       \
> >
> > this will make adding/removing asm lines at the beginning simpler (and
> > you already put closing quote on separate line, so that side is taken
> > care of)
> >
> > >         *(u64*)(r10 - 8) = r1;                          \n\
> > >         r2 = r10;                                       \n\
> > >         r2 += -8;                                       \n\
> > >         r1 = %[map_hash_48b] ll;                        \n\
> > >         call %[bpf_map_lookup_elem];                    \n\
> > >         if r0 == 0 goto l0_%=;                          \n\
> > >         r1 = *(u8*)(r0 + 0);                            \n\
> > >         r1 &= -4;                                       \n\
> > >         r1 <<= 2;                                       \n\
> > >         r0 += r1;                                       \n\
> > >         r1 = %[test_val_foo_offset];                    \n\
> > >         *(u64*)(r0 + 0) = r1;                           \n\
> > > l0_%=:                                                  \n\
> > >         exit;                                           \n\
> > > "       :
> > >         : [test_val_foo_offset]"i"(offsetof(struct test_val, foo)),
> >
> > should we use some __imm_const(name, value) macro (or __imm_named, or
> > __imm_alias, or something like that) for cases like this?
> >
> > >           __imm(bpf_map_lookup_elem),
> > >           __imm_addr(map_hash_48b)
> > >         : __clobber_all);
> > > }
> > >
> > > The script introduces labels for gotos and calls, immediate values for
> > > complex expressions like `offsetof(...)', takes care of map
> > > instructions patching, inserts map declarations used in the test,
> > > transfers comments from test, test fields and instructions. There are
> > > some issues with BPF_ST_MEM instruction support as described in [4],
> > > thus the script replaces such instructions with pairs of MOV/STX_MEM
> > > instructions.
> > >
> > > This patch-set introduces changes necessary for test_loader.c and
> > > includes migration of a single test from test_verifier to test_progs
> > > format, here are descriptions for individual patches:
> > >
> > > 1. "Support custom per-test flags and multiple expected messages"
> > >    This patch was shared by Andrii Nakryiko [3], it adds capability
> > >    to specify flags required by the BPF program.
> > >
> > > 2. "Unprivileged tests for test_loader.c"
> > >    Extends test_loader.c by capability to load test programs in
> > >    unprivileged mode and specify separate test outcomes for
> > >    privileged and unprivileged modes.
> > >
> > >    Note: for a reason I do not understand I had to use different set
> > >    of capabilities compared to test_verifier:
> > >    - test_verifier: CAP_NET_ADMIN, CAP_PERFMON, CAP_BPF;
> > >    - test_loader  : CAP_SYS_ADMIN, CAP_PERFMON, CAP_BPF.
> >
> > CAP_SYS_ADMIN is a superset of PERFMON and BPF, so it should be
> > NET_ADMIN... Setting CAP_SYS_ADMIN makes PERFMON and BPF meaningless,
> > so we should investigate.
> >
>
> Ok, I'll dig some more and ask for help in case if I would get stuck.
>
> > >
> > > 3. "Generate boilerplate code for test_loader-based tests"
> > >    Extends selftests/bpf Makefile to automatically generate
> > >    prog_tests/tests.h entry that uses test_loader for progs/*.c
> > >    BPF programs if special marker is present.
> > >
> > > 4. "__imm_insn macro to embed raw insns in inline asm"
> >
> > nit: __raw_insns perhaps, otherwise confusing given __imm and __imm_addr macros
>
> Sorry, I'm a bit confused, should I rename it to __raw_insn or
> __imm_insn is fine?

nope, keep it as __imm_insn, I haven't seen patch 4 before replying
here, I assumed this raw instruction macro will be used inline in the
body of asm volatile, but it's done as passing immediate 8-byte value,
so it makes sense to name it with __imm prefix

>
> >
> > >    This macro can be generated by migration script for instructions
> > >    that cannot be expressed in inline assembly, e.g. invalid instructions.
> > >
> > > 5. "convert jeq_infer_not_null tests to inline assembly"
> > >    Shows an example of the test migration.
> > >    The test was updated slightly after automatic translation:
> > >    - unnecessary comments removed;
> > >    - functions renamed;
> > >    - some labels renamed.
> > >
> > > The migration script has some limitations:
> > > - Technical, test features that are not yet supported:
> > >   - few instructions like BPF_ENDIAN;
> > >   - macro like BPF_SK_LOOKUP or BPF_LD_MAP_VALUE;
> > >   - program types like BPF_PROG_TYPE_CGROUP_SOCK_ADDR and
> > >     BPF_PROG_TYPE_TRACING;
> > >   - tests that specify fields 'expected_attach_type' or 'insn_processed';
> > >   - a few tests expose complex structure that could not be
> > >     automatically migrated, e.g.: 'atomic_fetch', 'lwt',
> > >     'bpf_loop_inline'.
> > > - Tests that use .run field cannot be migrated as test_loader.c tests.
> > > - Tests with generated bodies, e.g. test_verifier.c:bpf_fill_scale()
> > >   cannot be migrated as test_loader.c tests.
> > > - LLVM related:
> > >   - BPF_ST instruction is not supported by LLVM BPF assembly yet
> > >     (I'll take care of it);
> > >   - Issues with parsing of some assembly instructions like
> > >     "r0 = cmpxchg_64(r10 - 8, r0, r5)"
> > >     (I'll take care of it);
> > > - libbpf related:
> > >   - libbpf does not support call instructions within a single
> > >     function, e.g.:
> >
> > it's more of an issue of not having valid relocation emitted and also
> > corresponding .BTF.ext line/func info (that's my guess)
> >
> > >
> > >       0: r1 = 1
> > >       1: r2 = 2
> > >       2: call 1
> > >       3: exit
> > >       4: r0 = r1
> > >       5: r0 += r2
> > >       6: exit
> >
> > so libbpf itself doesn't care, but given we use BTF and send .BTF.ext,
> > I suspect kernel just doesn't like that it can't find func_info
> > information for subprog. So we'll need to split into proper functions
> > or disable .BTF.ext somehow.
>
> Actual error that I see comes from libbpf itself and looks as follows:
>
>   libbpf: prog 'regalloc_in_callee': no .text section found yet sub-program call exists
>   libbpf: prog 'regalloc_in_callee': failed to relocate calls: -4005
>   libbpf: failed to load object 'verifier_regalloc'
>
> It is reported from 'libbpf.c:bpf_object__reloc_code()' when processed
> instruction is 'insn_is_subprog_call(insn)' and relocation pointer is NULL.
> I would like to avoid automatically splitting test cases into
> functions as it means that tests with invalid CFG can't be represented
> when test_loader.c is used. However if you are completely against
> adding a flag to libbpf for this case I'll proceed with "function
> inference" approach.

Ok, I see. Libbpf has restriction that subprograms have to be in
.text, they can't be in SEC("kprobe") and whatnot. The latter is due
to inability to distinguish which function in SEC("kprobe") (as one
specific example of program section) is entry program and which one is
subprog. So any subprogram is just an unannotated function in .text.

Have you tried .section directive to temporarily put subprogram into
.text and then go back to the main program? This probably won't be
enough, but I'm thinking something like

r1 = 1
r2 = 2
call 1
exit
.section .text, "rx"
r0 = r1
r0 += r2
exit
.section kprobe, "rx"


We might need more directives to properly annotate subprog (function)
definition, we can check what compiler generates from C code for
subprogs.


>
> >
> >
> > >
> > >     This pattern is common in verifier tests, I see two possible
> > >     mitigation:
> > >     (a) use an additional libbpf flag to allow such code;
> >
> > I hope not :)
> >
> > >     (b) extend migration script to split such code in several functions.
> > >     I like (a) more.
> >
> > see above, this won't be a libbpf flag, rather some code in test
> > runner to strip away .BTF.ext information
> >
> > >
> > >   - libbpf does not allow empty programs.
> >
> > like:
> >
> > SEC("kprobe")
> > int prog()
> > {
> >     return 0;
> > }
> >
> > ?
>
> Like this:
>
>   SEC("kprobe") int prog() {}
>
> No body at all, we have such test. Probably not a big deal if it is
> not migrated.

prog returns int, so at the very least it should have `return 0;`. And
in general, any BPF function should at least have `exit` BPF
instruction, right?

>
> > >
> > > All in all the current script stats are as follows:
> > > - 62 out of 93 files from progs/*.c can be converted w/o warnings;
> > > - 55 converted files could be compiled;
> > > - 40 pass testing, 15 fail.
> > >
> > > By submitting this RFC I seek the following feedback:
> > > - is community interested in such migration?
> >
> > +1
> >
> > This is a great work!
> >
> > > - if yes, should I pursue partial or complete tests migration?
> >
> > I'd start with partial
> >
> > > - in case of partial migration which tests should be prioritized?
> >
> > those that work out of the box?
>
> Ok.
>
> >
> > > - should I offer migrated tests one by one or in big butches?
> >
> > they come grouped in files, would it be possible to live them in
> > similar groupings?
>
> Yes, file-by-file is how the tool currently works, I will keep the grouping.
> After this patch-set I can submit 40 patches one-by-one or as a single
> patch-set. The way I understand you and Alexei a single big patch-set
> is preferable, is that right?

yes, one larger patch set would be easier to manager than 40 separate
ones in this particular case

>
> >
> > >
> > > Thanks,
> > > Eduard
> > >
> > > [1] https://github.com/eddyz87/verifier-tests-migrator
> > > [2] https://lore.kernel.org/bpf/CAEf4BzYPsDWdRgx+ND1wiKAB62P=WwoLhr2uWkbVpQfbHqi1oA@mail.gmail.com/
> > > [3] https://lore.kernel.org/bpf/CAEf4BzZH0ZxorCi7nPDbRqSK9f+410RooNwNJGwfw8=0a5i1nw@mail.gmail.com/
> > > [4] https://lore.kernel.org/bpf/20221231163122.1360813-1-eddyz87@gmail.com/
> > >
> > > Andrii Nakryiko (1):
> > >   selftests/bpf: support custom per-test flags and multiple expected
> > >     messages
> > >
> > > Eduard Zingerman (4):
> > >   selftests/bpf: unprivileged tests for test_loader.c
> > >   selftests/bpf: generate boilerplate code for test_loader-based tests
> > >   selftests/bpf: __imm_insn macro to embed raw insns in inline asm
> > >   selftests/bpf: convert jeq_infer_not_null tests to inline assembly
> > >
> > >  tools/testing/selftests/bpf/Makefile          |  41 +-
> > >  tools/testing/selftests/bpf/autoconf_helper.h |   9 +
> > >  .../selftests/bpf/prog_tests/.gitignore       |   1 +
> > >  .../bpf/prog_tests/jeq_infer_not_null.c       |   9 -
> > >  tools/testing/selftests/bpf/progs/bpf_misc.h  |  49 +++
> > >  .../selftests/bpf/progs/jeq_infer_not_null.c  | 186 +++++++++
> > >  .../bpf/progs/jeq_infer_not_null_fail.c       |   1 +
> > >  tools/testing/selftests/bpf/test_loader.c     | 370 +++++++++++++++---
> > >  tools/testing/selftests/bpf/test_progs.h      |   1 +
> > >  tools/testing/selftests/bpf/test_verifier.c   |  25 +-
> > >  tools/testing/selftests/bpf/unpriv_helpers.c  |  26 ++
> > >  tools/testing/selftests/bpf/unpriv_helpers.h  |   7 +
> > >  .../bpf/verifier/jeq_infer_not_null.c         | 174 --------
> > >  13 files changed, 625 insertions(+), 274 deletions(-)
> > >  create mode 100644 tools/testing/selftests/bpf/autoconf_helper.h
> > >  delete mode 100644 tools/testing/selftests/bpf/prog_tests/jeq_infer_not_null.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/jeq_infer_not_null.c
> > >  create mode 100644 tools/testing/selftests/bpf/unpriv_helpers.c
> > >  create mode 100644 tools/testing/selftests/bpf/unpriv_helpers.h
> > >  delete mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_null.c
> > >
> > > --
> > > 2.39.0
> > >
>
