Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB1E6CCD32
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 00:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjC1WZW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 18:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjC1WZO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 18:25:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BDF10FD
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 15:25:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t10so55648432edd.12
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680042311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wHNbpo/BqxetD6LWxzcqincxSuZN/d5J2dqi0TJzcs=;
        b=ZT0hI62q0+S2jcYbEg6NHrQtOX/rzpHYxGwRSXVrCN9no2vP7UTW/qT1DwtuBJN23n
         fUkQHJ5TVQHMuliD4aeUher85NHy1AjZy1/R01GfEJwyc+iENolb9twfVCh1dAdk5AF3
         FhtItUss/koEtb05l0eQaBFkwt3KjYqyPZHjpdom7DMN1lOt5hkuEeJ0YyNdO1B4ulk7
         4KsA9kWhQwDnN0g6z0Pw/rjiLAh0FVZXe03GjEETY/KY8IPuZUugDc16ZzinsV7IquiH
         Vb6zGgx+RrnfEZ67D3IbTn3TVzNZNJ70lfnPjDlBMeKz5O7meiipCGIXJTSBW+Cb3jdy
         bC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680042311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wHNbpo/BqxetD6LWxzcqincxSuZN/d5J2dqi0TJzcs=;
        b=VsInij3CD9soPXcre9O6OH9eMURJyZP//v4DdCuiWmZspLMVTkp33hQdRMEWjuZBbz
         halCCKJxBiZ3lUAnPojh0xEEjJbKKvAnGfoDZH8vJX0ku5HhcvfNFrEra6Ls21M4sln2
         4gMfVpOmEvsZjbpjPqJrTQM9bsYN0JtFnYoCY9Fy0mB2HiyqneU8Cycc4UPdHoqL32Rl
         XOH6xUM9IAOyveH8X6svpGqHLAVCicpXetPKXJv0hK7aHeS/sVR44SYJFrBrcagwvd4Q
         695TR0Q1wFBu34aN5JIlmH5bXDWEGsXk6SZisPcMrDGDlDYbUn2r1QFH4nGI5q0rOjK1
         mgcw==
X-Gm-Message-State: AAQBX9cwfryKauFr/2e2wmYKClc8KfVfrOD/vbbmKMgIPQpuTA75Ufck
        LIiOmcBErnzE1zq1PHPt8tRK+yZDpXkjrfS9p8s=
X-Google-Smtp-Source: AKy350ZG++CUvmy2mEnOKaZjb5irPynZwo9lveh6knv2y799YHkZgtovE7cV7UeWgfJYkYZEPJdzQMGcZQn7CMJ76zo=
X-Received: by 2002:a17:907:8688:b0:931:c1a:b526 with SMTP id
 qa8-20020a170907868800b009310c1ab526mr8735354ejc.5.1680042311252; Tue, 28 Mar
 2023 15:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230325025524.144043-1-eddyz87@gmail.com> <359ea18b-5996-afea-b81e-32f13f134852@iogearbox.net>
 <b69f211724dd9d1acdb896ca1b97109065ab28b0.camel@gmail.com>
In-Reply-To: <b69f211724dd9d1acdb896ca1b97109065ab28b0.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Mar 2023 15:24:59 -0700
Message-ID: <CAEf4BzZtC88nCXvBBdd-6dox1rDMfwqKZBY2CtON05fi0fGzFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 2:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Hi Daniel,
>
> [...]
> >
> > The cover letter describes what this series does, but not /why/ we need=
 it. Would be
> > useful in future to also have the rationale in here. The migration of t=
he verifier
> > tests look ok, and probably simplifies things to some degree, it certai=
nly makes the
> > tests more readable. Is the goal to eventually get rid of test_verifier=
 altogether?
>
> In total there are 57 verifier/*.c files remaining. I've inspected each a=
nd came
> up with the following categories:
> - tool limitation;
> - simplistic;
> - asm parser issue;
> - pseudo-call instructions;
> - custom macro;
> - `.fill_helper`;
> - libbpf discards junk;
> - small log buffer.
>
> Categories are described in the following sections, per-test summary is i=
n the end.
>
> The files that are not 'simplistic', not '.fill_helper' and not 'libbpf d=
iscards junk'
> could be migrated with some additional work.
> This gives ~40 files to migrate and ~17 to leave as-is or migrate only pa=
rtially.
>
> > I don't think we fully can do that, e.g. what about verifier testing of=
 invalid insn
> > encodings or things like invalid jumps into the middle of double insns,=
 invalid call
> > offsets, etc?
>
> Looks like it is the case. E.g. for invalid instructions I can get away w=
ith
> some junk using the following trick:
>
>     asm volatile (".8byte %[raw_insn];"
>                   :
>                   : __imm_insn(raw_insn, BPF_RAW_INSN(0, 0, 0, 0, 0))
>                   : __clobber_all);
>
> But some junk is still rejected by libbpf.
>
> # Migration tool limitations (23 files)
>
> The tool does not know how to migrate tests that use specific features:
> - test description field `.expected_attach_type`;
> - test description field `.fixup_prog1`, `.fixup_prog2`;
> - test description field `.retvals` and `.data`, this also requires suppo=
rt on
>   `test_loader.c` side;
> - `BPF_ENDIAN(BPF_TO_**, BPF_REG_0, 16)` instruction;
> - `BPF_SK_LOOKUP` macro;
> - `#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__` blocks;
>
> I will update migration tool to handle the cases above.
>

Great, this seems to be covered.

> # Simplistic tests (14 files)
>
> Some tests are just simplistic and it is not clear if moving those to inl=
ine
> assembly really makes sense, for example, here is `basic_call.c`:
>
>     {
>         "invalid call insn1",
>         .insns =3D {
>         BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, 0, 0, 0, 0),
>         BPF_EXIT_INSN(),
>         },
>         .errstr =3D "unknown opcode 8d",
>         .result =3D REJECT,
>     },
>

For tests like this we can have a simple ELF parser/loader that
doesn't use bpf_object__open() functionality. It's not too hard to
just find all the FUNC ELF symbols and fetch corresponding raw
instructions. Assumption here is that we can take those assembly
instructions as is, of course. If there are some map references and
such, this won't work.

> # LLVM assembler parser issues (10 files)
>
> There are parsing issues with some constructs, for example:
>
>         r1 =3D atomic_fetch_xor((u64 *)(r10 - 8), r1);
>
> Produces the following diagnostic:
>
>     progs/verifier_b2_atomic_xor.c:45:1: error: unexpected token
>            r1 =3D atomic_fetch_xor((u64 *)(r10 - 8), r1);    \n\
>     ^
>     <inline asm>:7:40: note: instantiated into assembly here
>            r1 =3D atomic_fetch_xor((u64 *)(r10 - 8), r1);
>                                                  ^
>
> I checked LLVM tests and the syntax seems to be correct (at-least this sy=
ntax is
> used by disassembler). So far I know that the following constructs are af=
fected:
> - `atomic_fetch_and`
> - `atomic_fetch_cmpxchg`
> - `atomic_fetch_or`
> - `atomic_fetch_xchg`
> - `atomic_fetch_xor`
>
> Requires further investigation and a fix in LLVM.
>

+1


> # Pseudo-call instructions (9 files)
>
> An object file might contain several BPF programs plus some functions use=
d from
> different programs. In order to load a program from such file, `libbpf` c=
reates
> a buffer and copies the program and all functions called from this progra=
m into
> that buffer. For each visited pseudo-call instruction `libbpf` requires i=
t to
> point to a valid function described in ELF header.
>
> However, this is not how `verifier/*.c` tests are written, for example he=
re is a
> translated fragment from `verifier/loops1.c`:
>
>     SEC("tracepoint")
>     __description("bounded recursion")
>     __failure __msg("back-edge")
>     __naked void bounded_recursion(void)
>     {
>             asm volatile ("                                 \
>             r1 =3D 0;                                         \
>             call l0_%=3D;                                     \
>             exit;                                           \
>     l0_%=3D:  r1 +=3D 1;                                        \
>             r0 =3D r1;                                        \
>             if r1 < 4 goto l1_%=3D;                           \
>             exit;                                           \
>     l1_%=3D:  call l0_%=3D;                                     \
>             exit;                                           \
>     "       ::: __clobber_all);
>     }
>
> There are several possibilities here:
> - split such tests into several functions during migration;
> - add a special flag for `libbpf` asking to allow such calls;
> - Andrii also suggested to try using `.section` directives inside inline
>   assembly block.
>
> This requires further investigation, I'll discuss it with Andrii some tim=
e later
> this week or on Monday.

So I did try this a few weeks ago, and yes, you can make this work
with assembly directives. Except that DWARF (and thus .BTF and
.BTF.ext) information won't be emitted, as it is emitted very
painfully and manually by C compiler as explicit assembly directives.
But we might work around that by clearing .BTF and .BTF.ext
information for such object files, perhaps. So tentatively this should
be doable.

>
> # Custom macro definitions (5 files)
>
> Some tests define and use custom macro, e.g. atomic_fetch.c:
>
>     #define __ATOMIC_FETCH_OP_TEST(src_reg, dst_reg, operand1, op, operan=
d2, expect) ...
>
>     __ATOMIC_FETCH_OP_TEST(BPF_REG_1, BPF_REG_2, 1, BPF_ADD | BPF_FETCH, =
2, 3),
>     __ATOMIC_FETCH_OP_TEST(BPF_REG_0, BPF_REG_1, 1, BPF_ADD | BPF_FETCH, =
2, 3),
>     // ...
>
> Such tests would have to be migrated manually (the tool still can transla=
te
> portions of the test).
>
> # `.fill_helper` (5 files)
>
> Programs for some tests are generated programmatically by specifying
> `.fill_helper` function in the test description, e.g. `verifier/scale.c`:
>
>     {
>         "scale: scale test 1",
>         .insns =3D { },
>         .data =3D { },
>         .fill_helper =3D bpf_fill_scale,
>         .prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
>         .result =3D ACCEPT,
>         .retval =3D 1,
>     },
>
> Such tests cannot be migrated
> (but sometimes these are not the only tests in the file).

We can just write these as explicitly programmatically generated
programs, probably. There are just a few of these, shouldn't be a big
deal.

>
> # libbpf does not like some junk code (3 files)
>
> `libbpf` (and bpftool) reject some junk instructions intentionally encode=
d in
> the tests, e.g. empty program from `verifier/basic.c`:
>
>     SEC("socket")
>     __description("empty prog")
>     __failure __msg("last insn is not an exit or jmp")
>     __failure_unpriv
>     __naked void empty_prog(void)
>     {

even if you add some random "r0 =3D 0" instruction? It won't change the
meaning of the test, but should work with libbpf.

>             asm volatile ("" ::: __clobber_all);
>     }
>
> # Small log buffer (2 files)
>
> Currently `test_loader.c` uses 1Mb log buffer, while `test_verifier.c` us=
es 16Mb
> log buffer. There are a few tests (like in `verifier/bounds.c`) that exit=
 with
> `-ESPC` for 1Mb buffer.
>
> I can either bump log buffer size for `test_loader.c` or wait until Andri=
i's
> rotating log implementation lands.

Just bump to 16MB, no need to wait on anything.

>
> # Per-test summary
>
> - atomic_and               - asm parser issue;
> - atomic_bounds            - asm parser issue;
> - atomic_cmpxchg           - asm parser issue;
> - atomic_fetch             - asm parser issue, tool limitation;
> - atomic_fetch_add         - asm parser issue, uses macro;
> - atomic_invalid           - simplistic, uses macro;
> - atomic_or                - asm parser issue;
> - atomic_xchg              - asm parser issue;
> - atomic_xor               - asm parser issue;
> - basic                    - simplistic, libbpf discards junk;
> - basic_call               - simplistic;
> - basic_instr              - tool limitation;
> - basic_stx_ldx            - simplistic;
> - bounds                   - small log buffer;
> - bpf_get_stack            - tool limitation;
> - bpf_loop_inline          - uses macro, uses .fill_helper;
> - bpf_st_mem               - asm parser issue;
> - btf_ctx_access           - tool limitation;
> - calls                    - tool limitation, pseudo call;
> - ctx                      - simplistic, tool limitation;
> - ctx_sk_lookup            - simplistic, tool limitation;
> - ctx_skb                  - simplistic, tool limitation;
> - d_path                   - tool limitation;
> - dead_code                - pseudo call;
> - direct_packet_access     - pseudo call;
> - direct_value_access      - pseudo call;
> - event_output             - uses macro;
> - jeq_infer_not_null       - ok;
> - jit                      - uses .fill_helper;
> - jmp32                    - tool limitation;
> - jset                     - asm parser issue, tool limitation;
> - jump                     - pseudo call;
> - junk_insn                - simplistic, libbpf discards junk;
> - ld_abs                   - uses .fill_helper;
> - ld_dw                    - simplistic, uses .fill_helper;
> - ld_imm64                 - simplistic, junk rejected by bpftool
> - loops1                   - small log buffer, pseudo call;
> - lwt                      - tool limitation;
> - map_in_map               - ok (needs __msg update because of BPF_ST_MEM=
 rewrite);
> - map_kptr                 - strange runtime issue, requires further inve=
stigation;
> - map_ptr_mixing           - tool limitation;
> - perf_event_sample_period - simplistic, tool limitation;
> - precise                  - pseudo call, needs __msg update because of B=
PF_ST_MEM rewrite;
> - prevent_map_lookup       - tool limitation;
> - ref_tracking             - tool limitation;
> - regalloc                 - pseudo call
> - runtime_jit              - tool limitation;
> - scale                    - simplistic, uses .fill_helper;
> - search_pruning           - tool limitation;
> - sleepable                - simplistic, tool limitation;
> - sock                     - ok (needs __msg update because of BPF_ST_MEM=
 rewrite);
> - spin_lock                - pseudo call;
> - subreg                   - tool limitation;
> - unpriv                   - tool limitation;
> - value_illegal_alu        - tool limitation;
> - value_ptr_arith          - tool limitation;
> - wide_access              - simplistic, uses macro;
>
> Thanks,
> Eduard
