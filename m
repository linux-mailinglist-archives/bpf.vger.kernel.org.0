Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7C667DAD4
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 01:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjA0Aa0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 19:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjA0AaY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 19:30:24 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706A02CFE9
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 16:30:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so4391879wmb.2
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 16:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BIGtQyhfMg2WtbFxTmEmQ8O8DWKgQ9Ri4Tg0RMWhR+Q=;
        b=GpsYh6TtnssRr0cQmfUmQHvBUm3LatAJwTfxw6B4ShflM0VOoZUsA2Jjj5pMWj8vu+
         2De3HBIyMbR8HYNMtz0zJhsxMACCXnsmsWktnx9hIJJD65dOGEh+5jS0mx+dS5yENjQ3
         xJwnd+wA2VxjRJS0up5iVmCt/QEUAtqHqWZ0X8tl6cy0LKIUZAKgxQ5OSE3lu8XVEXCT
         ZQldMFZcLCx8paiudKco9MiNP0Ra5cBVHzTzB5RRJid9emD58nMvo9802CpkH7ySvp7A
         K8diVbEyXTbolWqCHtzERA6K4Ekny+e3MW0302nEsp5FE2hms0UV8Tz2pJx6Ga2QwXov
         umtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BIGtQyhfMg2WtbFxTmEmQ8O8DWKgQ9Ri4Tg0RMWhR+Q=;
        b=DZvqVrh0f/s3whQYteQXRfw/xtMXkh/+wiOWUy2zzvGDg6toNQD8aQRPR1cdp3zF5m
         egGA/rxQTQK7xvhIGdY0M3noxvo5bkpK4N4NRFp/VVoL0nJu2UXS50kUOC8+s9mkxM5G
         9D1i2MZkZozTPXQ8jAnw+TgN3yzLpLleg1/SpubrW2w1NGEyE6J4dPzUyQLLi/c0SmF5
         TB3M1iQd3kXGtJT+gTF6E97hlB/IU1ystjX+OkFAG5j5R5yKBy0dU7oeMwUK2KZZSXJp
         UZ6+9az4irCpIJvO+PyyyuWQd+ajCXPWy8HZnbxpEnZAJ5xtcGzKCSXhrnQuBksIcqO2
         1VAg==
X-Gm-Message-State: AFqh2kpBRq3QHPkyTwLQdGqOsI3JfaOsZw0QOdoryoakqonekQopTOMT
        fu+U9XkgwQY+6iQtKygTn8Y=
X-Google-Smtp-Source: AMrXdXv6K8zwVlkXlTWjrOISL3G7gB8DVGQKr1WfjnlmHZXo3xLfG7YRIfFPIcpanr3otyD+gJngtQ==
X-Received: by 2002:a05:600c:1c02:b0:3d2:3b8d:21e5 with SMTP id j2-20020a05600c1c0200b003d23b8d21e5mr37484779wms.14.1674779420808;
        Thu, 26 Jan 2023 16:30:20 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c384f00b003d9de0c39fasm7182848wmr.36.2023.01.26.16.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:30:20 -0800 (PST)
Message-ID: <a06cc3ac1698a9d46ec37047415db5634b219a90.camel@gmail.com>
Subject: Re: [RFC bpf-next 0/5] test_verifier tests migration to inline
 assembly
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Fri, 27 Jan 2023 02:30:19 +0200
In-Reply-To: <CAEf4Bzbu2zctHntHNRVnEDa_FJz405Ld1Sb58wvJA+JvYdS+Ag@mail.gmail.com>
References: <20230123145148.2791939-1-eddyz87@gmail.com>
         <CAEf4Bzbu2zctHntHNRVnEDa_FJz405Ld1Sb58wvJA+JvYdS+Ag@mail.gmail.com>
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

On Wed, 2023-01-25 at 17:33 -0800, Andrii Nakryiko wrote:
> On Mon, Jan 23, 2023 at 6:52 AM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> >=20
> > As a part of the discussion started in [2] I developed a script [1]
> > that can convert tests specified in test_verifier.c format to inline
> > BPF assembly compatible for use with test_loader.c.
> >=20
> > For example, test definition like below:
> >=20
> > {
> >         "invalid and of negative number",
> >         .insns =3D {
> >         BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> >         BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> >         BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> >         BPF_LD_MAP_FD(BPF_REG_1, 0),
> >         BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_e=
lem),
> >         BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),
> >         BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
> >         BPF_ALU64_IMM(BPF_AND, BPF_REG_1, -4),
> >         BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 2),
> >         BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1),
> >         BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, offsetof(struct test_val, foo)=
),
> >         BPF_EXIT_INSN(),
> >         },
> >         .fixup_map_hash_48b =3D { 3 },
> >         .errstr =3D "R0 max value is outside of the allowed memory rang=
e",
> >         .result =3D REJECT,
> >         .flags =3D F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
> > },
> >=20
> > Is converted to:
> >=20
> > struct test_val { ... };
> >=20
> > struct { ...} map_hash_48b SEC(".maps");
> >=20
> > __description("invalid and of negative number")
> > __failure __msg("R0 max value is outside of the allowed memory range")
> > __failure_unpriv
> > __flag(BPF_F_ANY_ALIGNMENT)
> > SEC("socket")
>=20
> nit: let's make sure that SEC() is the first annotation, makes
> grepping easier and is consistent with how we use SEC() with BPF
> programs

Ok, will move SEC to the top.

>=20
>=20
> > __naked void invalid_and_of_negative_number(void)
> >=20
> > {
> >         asm volatile (
> > "       r1 =3D 0;                                         \n\
>=20
> Kumar recently landed similarly formatted inline asm-based test, let's
> make sure we stick to common style. \n at the end are pretty

Tbh, the '\n\' at the end of the line is much less distracting
compared to the first variant when each instruction had it's own
string ('"r1 =3D 0;\n"'). And I find it quite useful when compiler
points to a bad asm instruction.

But I'll remove it if you insist.

> distracting, IMO (though helpful to debug syntax errors in asm, of
> course). I'd also move starting " into the same line as asm volatile:

Ok, no problem, will move the '"'.

>=20
> asm volatile ("                       \
>=20
> this will make adding/removing asm lines at the beginning simpler (and
> you already put closing quote on separate line, so that side is taken
> care of)
>=20
> >         *(u64*)(r10 - 8) =3D r1;                          \n\
> >         r2 =3D r10;                                       \n\
> >         r2 +=3D -8;                                       \n\
> >         r1 =3D %[map_hash_48b] ll;                        \n\
> >         call %[bpf_map_lookup_elem];                    \n\
> >         if r0 =3D=3D 0 goto l0_%=3D;                          \n\
> >         r1 =3D *(u8*)(r0 + 0);                            \n\
> >         r1 &=3D -4;                                       \n\
> >         r1 <<=3D 2;                                       \n\
> >         r0 +=3D r1;                                       \n\
> >         r1 =3D %[test_val_foo_offset];                    \n\
> >         *(u64*)(r0 + 0) =3D r1;                           \n\
> > l0_%=3D:                                                  \n\
> >         exit;                                           \n\
> > "       :
> >         : [test_val_foo_offset]"i"(offsetof(struct test_val, foo)),
>=20
> should we use some __imm_const(name, value) macro (or __imm_named, or
> __imm_alias, or something like that) for cases like this?
>=20
> >           __imm(bpf_map_lookup_elem),
> >           __imm_addr(map_hash_48b)
> >         : __clobber_all);
> > }
> >=20
> > The script introduces labels for gotos and calls, immediate values for
> > complex expressions like `offsetof(...)', takes care of map
> > instructions patching, inserts map declarations used in the test,
> > transfers comments from test, test fields and instructions. There are
> > some issues with BPF_ST_MEM instruction support as described in [4],
> > thus the script replaces such instructions with pairs of MOV/STX_MEM
> > instructions.
> >=20
> > This patch-set introduces changes necessary for test_loader.c and
> > includes migration of a single test from test_verifier to test_progs
> > format, here are descriptions for individual patches:
> >=20
> > 1. "Support custom per-test flags and multiple expected messages"
> >    This patch was shared by Andrii Nakryiko [3], it adds capability
> >    to specify flags required by the BPF program.
> >=20
> > 2. "Unprivileged tests for test_loader.c"
> >    Extends test_loader.c by capability to load test programs in
> >    unprivileged mode and specify separate test outcomes for
> >    privileged and unprivileged modes.
> >=20
> >    Note: for a reason I do not understand I had to use different set
> >    of capabilities compared to test_verifier:
> >    - test_verifier: CAP_NET_ADMIN, CAP_PERFMON, CAP_BPF;
> >    - test_loader  : CAP_SYS_ADMIN, CAP_PERFMON, CAP_BPF.
>=20
> CAP_SYS_ADMIN is a superset of PERFMON and BPF, so it should be
> NET_ADMIN... Setting CAP_SYS_ADMIN makes PERFMON and BPF meaningless,
> so we should investigate.
>=20

Ok, I'll dig some more and ask for help in case if I would get stuck.

> >=20
> > 3. "Generate boilerplate code for test_loader-based tests"
> >    Extends selftests/bpf Makefile to automatically generate
> >    prog_tests/tests.h entry that uses test_loader for progs/*.c
> >    BPF programs if special marker is present.
> >=20
> > 4. "__imm_insn macro to embed raw insns in inline asm"
>=20
> nit: __raw_insns perhaps, otherwise confusing given __imm and __imm_addr =
macros

Sorry, I'm a bit confused, should I rename it to __raw_insn or
__imm_insn is fine?

>=20
> >    This macro can be generated by migration script for instructions
> >    that cannot be expressed in inline assembly, e.g. invalid instructio=
ns.
> >=20
> > 5. "convert jeq_infer_not_null tests to inline assembly"
> >    Shows an example of the test migration.
> >    The test was updated slightly after automatic translation:
> >    - unnecessary comments removed;
> >    - functions renamed;
> >    - some labels renamed.
> >=20
> > The migration script has some limitations:
> > - Technical, test features that are not yet supported:
> >   - few instructions like BPF_ENDIAN;
> >   - macro like BPF_SK_LOOKUP or BPF_LD_MAP_VALUE;
> >   - program types like BPF_PROG_TYPE_CGROUP_SOCK_ADDR and
> >     BPF_PROG_TYPE_TRACING;
> >   - tests that specify fields 'expected_attach_type' or 'insn_processed=
';
> >   - a few tests expose complex structure that could not be
> >     automatically migrated, e.g.: 'atomic_fetch', 'lwt',
> >     'bpf_loop_inline'.
> > - Tests that use .run field cannot be migrated as test_loader.c tests.
> > - Tests with generated bodies, e.g. test_verifier.c:bpf_fill_scale()
> >   cannot be migrated as test_loader.c tests.
> > - LLVM related:
> >   - BPF_ST instruction is not supported by LLVM BPF assembly yet
> >     (I'll take care of it);
> >   - Issues with parsing of some assembly instructions like
> >     "r0 =3D cmpxchg_64(r10 - 8, r0, r5)"
> >     (I'll take care of it);
> > - libbpf related:
> >   - libbpf does not support call instructions within a single
> >     function, e.g.:
>=20
> it's more of an issue of not having valid relocation emitted and also
> corresponding .BTF.ext line/func info (that's my guess)
>=20
> >=20
> >       0: r1 =3D 1
> >       1: r2 =3D 2
> >       2: call 1
> >       3: exit
> >       4: r0 =3D r1
> >       5: r0 +=3D r2
> >       6: exit
>=20
> so libbpf itself doesn't care, but given we use BTF and send .BTF.ext,
> I suspect kernel just doesn't like that it can't find func_info
> information for subprog. So we'll need to split into proper functions
> or disable .BTF.ext somehow.

Actual error that I see comes from libbpf itself and looks as follows:

  libbpf: prog 'regalloc_in_callee': no .text section found yet sub-program=
 call exists
  libbpf: prog 'regalloc_in_callee': failed to relocate calls: -4005
  libbpf: failed to load object 'verifier_regalloc'

It is reported from 'libbpf.c:bpf_object__reloc_code()' when processed
instruction is 'insn_is_subprog_call(insn)' and relocation pointer is NULL.
I would like to avoid automatically splitting test cases into
functions as it means that tests with invalid CFG can't be represented
when test_loader.c is used. However if you are completely against
adding a flag to libbpf for this case I'll proceed with "function
inference" approach.

>=20
>=20
> >=20
> >     This pattern is common in verifier tests, I see two possible
> >     mitigation:
> >     (a) use an additional libbpf flag to allow such code;
>=20
> I hope not :)
>=20
> >     (b) extend migration script to split such code in several functions=
.
> >     I like (a) more.
>=20
> see above, this won't be a libbpf flag, rather some code in test
> runner to strip away .BTF.ext information
>=20
> >=20
> >   - libbpf does not allow empty programs.
>=20
> like:
>=20
> SEC("kprobe")
> int prog()
> {
>     return 0;
> }
>=20
> ?

Like this:

  SEC("kprobe") int prog() {}

No body at all, we have such test. Probably not a big deal if it is
not migrated.

> >=20
> > All in all the current script stats are as follows:
> > - 62 out of 93 files from progs/*.c can be converted w/o warnings;
> > - 55 converted files could be compiled;
> > - 40 pass testing, 15 fail.
> >=20
> > By submitting this RFC I seek the following feedback:
> > - is community interested in such migration?
>=20
> +1
>=20
> This is a great work!
>=20
> > - if yes, should I pursue partial or complete tests migration?
>=20
> I'd start with partial
>=20
> > - in case of partial migration which tests should be prioritized?
>=20
> those that work out of the box?

Ok.

>=20
> > - should I offer migrated tests one by one or in big butches?
>=20
> they come grouped in files, would it be possible to live them in
> similar groupings?

Yes, file-by-file is how the tool currently works, I will keep the grouping=
.
After this patch-set I can submit 40 patches one-by-one or as a single
patch-set. The way I understand you and Alexei a single big patch-set
is preferable, is that right?

>=20
> >=20
> > Thanks,
> > Eduard
> >=20
> > [1] https://github.com/eddyz87/verifier-tests-migrator
> > [2] https://lore.kernel.org/bpf/CAEf4BzYPsDWdRgx+ND1wiKAB62P=3DWwoLhr2u=
WkbVpQfbHqi1oA@mail.gmail.com/
> > [3] https://lore.kernel.org/bpf/CAEf4BzZH0ZxorCi7nPDbRqSK9f+410RooNwNJG=
wfw8=3D0a5i1nw@mail.gmail.com/
> > [4] https://lore.kernel.org/bpf/20221231163122.1360813-1-eddyz87@gmail.=
com/
> >=20
> > Andrii Nakryiko (1):
> >   selftests/bpf: support custom per-test flags and multiple expected
> >     messages
> >=20
> > Eduard Zingerman (4):
> >   selftests/bpf: unprivileged tests for test_loader.c
> >   selftests/bpf: generate boilerplate code for test_loader-based tests
> >   selftests/bpf: __imm_insn macro to embed raw insns in inline asm
> >   selftests/bpf: convert jeq_infer_not_null tests to inline assembly
> >=20
> >  tools/testing/selftests/bpf/Makefile          |  41 +-
> >  tools/testing/selftests/bpf/autoconf_helper.h |   9 +
> >  .../selftests/bpf/prog_tests/.gitignore       |   1 +
> >  .../bpf/prog_tests/jeq_infer_not_null.c       |   9 -
> >  tools/testing/selftests/bpf/progs/bpf_misc.h  |  49 +++
> >  .../selftests/bpf/progs/jeq_infer_not_null.c  | 186 +++++++++
> >  .../bpf/progs/jeq_infer_not_null_fail.c       |   1 +
> >  tools/testing/selftests/bpf/test_loader.c     | 370 +++++++++++++++---
> >  tools/testing/selftests/bpf/test_progs.h      |   1 +
> >  tools/testing/selftests/bpf/test_verifier.c   |  25 +-
> >  tools/testing/selftests/bpf/unpriv_helpers.c  |  26 ++
> >  tools/testing/selftests/bpf/unpriv_helpers.h  |   7 +
> >  .../bpf/verifier/jeq_infer_not_null.c         | 174 --------
> >  13 files changed, 625 insertions(+), 274 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/autoconf_helper.h
> >  delete mode 100644 tools/testing/selftests/bpf/prog_tests/jeq_infer_no=
t_null.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/jeq_infer_not_nul=
l.c
> >  create mode 100644 tools/testing/selftests/bpf/unpriv_helpers.c
> >  create mode 100644 tools/testing/selftests/bpf/unpriv_helpers.h
> >  delete mode 100644 tools/testing/selftests/bpf/verifier/jeq_infer_not_=
null.c
> >=20
> > --
> > 2.39.0
> >=20

