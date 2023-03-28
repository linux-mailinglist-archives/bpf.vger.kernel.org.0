Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321FE6CCC47
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 23:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjC1Vwn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 17:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjC1Vwn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 17:52:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3513F1B8
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 14:52:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t10so55350262edd.12
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 14:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680040359;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K15NVCB9T3C+GpZJR+guf4FxY38eye9ObKs4Cu3K8Hw=;
        b=KR4VWOKHl5GGmpHSYRxnkNHp3SJmxGRR6g2Pbbcy9RMBZcVBLS/nj92q+mAdEdKk9X
         NqwbZSCZRLGbvzYYt6xNudUB/STypeHXxZav5rULPIwxzpyYY7qiO/uq1GRp3w1yWOWc
         GjhdDkFYpFept1wPb9N6a4d8nPgHOyrX5G8oGZEegUdsrwt7tAF3tmxmb8hHZXvC2f6Y
         Twkc5kyPPTMDO4mnX6P+KsK9j9PZ66auglXK5AmLFBA0Qd7NidUULUjzqHZP5NVevwDT
         hu1RrJrPWeqLuRQhkTa9kUOjWnUoAj01qBbeo/rgIpen0UoSivwWoMo4dqRLSdyGB0iY
         lm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680040359;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K15NVCB9T3C+GpZJR+guf4FxY38eye9ObKs4Cu3K8Hw=;
        b=YIRThTj0HFkvzxVIn14HK+m3hIPWGnWD2QlSr/xEOx6a+Dh2hoG9y2SHmCF/qx9hls
         216x7TXtRBmGsI+UlnBNtOBoKE+kH+St9jZELCMhk4ViPDPfPpFQWIej+gBO9Kb0PGsj
         nrx1rCn5nci/jQMFTs3KbemVlA0I1NESN/OAnD3VbtaaUByMltzWnjeAj5MdvPvlHw+0
         VvHZTTxYWkVTGDvN+wbue21GKumdaKwr3puPjo29iDsmJ2IA2I8a7VZIGa3ea58zzNDM
         iLjFrFabI/P+aBG5A8MSmtI/DodUtn5BxJ9bNMY+kcaT7AJG+wL08L+I8e93F6ZUgRKl
         rq9Q==
X-Gm-Message-State: AAQBX9eYcdF6p08rEKr+FoFYnprRkBoGhjOfWpob9Wo9ME6iSWkg21qB
        ZG+vUdJyVnBXq56beMR0/PzJCpi/ezZbsA==
X-Google-Smtp-Source: AKy350bbnLUTtZpGI8WHQ+83xt8Q7nHpeJrB/66dhqa7S7obnMwANGngaMB8IvCGZv/vpB0ElytGIA==
X-Received: by 2002:aa7:c2c8:0:b0:501:cde5:4cc9 with SMTP id m8-20020aa7c2c8000000b00501cde54cc9mr16359910edp.39.1680040359498;
        Tue, 28 Mar 2023 14:52:39 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906b29200b008c607dd7cefsm15729431ejz.79.2023.03.28.14.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 14:52:38 -0700 (PDT)
Message-ID: <b69f211724dd9d1acdb896ca1b97109065ab28b0.camel@gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Date:   Wed, 29 Mar 2023 00:52:36 +0300
In-Reply-To: <359ea18b-5996-afea-b81e-32f13f134852@iogearbox.net>
References: <20230325025524.144043-1-eddyz87@gmail.com>
         <359ea18b-5996-afea-b81e-32f13f134852@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel,

[...]
>=20
> The cover letter describes what this series does, but not /why/ we need i=
t. Would be
> useful in future to also have the rationale in here. The migration of the=
 verifier
> tests look ok, and probably simplifies things to some degree, it certainl=
y makes the
> tests more readable. Is the goal to eventually get rid of test_verifier a=
ltogether?

In total there are 57 verifier/*.c files remaining. I've inspected each and=
 came
up with the following categories:
- tool limitation;
- simplistic;
- asm parser issue;
- pseudo-call instructions;
- custom macro;
- `.fill_helper`;
- libbpf discards junk;
- small log buffer.

Categories are described in the following sections, per-test summary is in =
the end.

The files that are not 'simplistic', not '.fill_helper' and not 'libbpf dis=
cards junk'
could be migrated with some additional work.
This gives ~40 files to migrate and ~17 to leave as-is or migrate only part=
ially.

> I don't think we fully can do that, e.g. what about verifier testing of i=
nvalid insn
> encodings or things like invalid jumps into the middle of double insns, i=
nvalid call
> offsets, etc?

Looks like it is the case. E.g. for invalid instructions I can get away wit=
h
some junk using the following trick:

    asm volatile (".8byte %[raw_insn];"
                  :
                  : __imm_insn(raw_insn, BPF_RAW_INSN(0, 0, 0, 0, 0))
                  : __clobber_all);

But some junk is still rejected by libbpf.

# Migration tool limitations (23 files)

The tool does not know how to migrate tests that use specific features:
- test description field `.expected_attach_type`;
- test description field `.fixup_prog1`, `.fixup_prog2`;
- test description field `.retvals` and `.data`, this also requires support=
 on
  `test_loader.c` side;
- `BPF_ENDIAN(BPF_TO_**, BPF_REG_0, 16)` instruction;
- `BPF_SK_LOOKUP` macro;
- `#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__` blocks;

I will update migration tool to handle the cases above.

# Simplistic tests (14 files)

Some tests are just simplistic and it is not clear if moving those to inlin=
e
assembly really makes sense, for example, here is `basic_call.c`:

    {
    	"invalid call insn1",
    	.insns =3D {
    	BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, 0, 0, 0, 0),
    	BPF_EXIT_INSN(),
    	},
    	.errstr =3D "unknown opcode 8d",
    	.result =3D REJECT,
    },

# LLVM assembler parser issues (10 files)

There are parsing issues with some constructs, for example:

	r1 =3D atomic_fetch_xor((u64 *)(r10 - 8), r1);

Produces the following diagnostic:

    progs/verifier_b2_atomic_xor.c:45:1: error: unexpected token
           r1 =3D atomic_fetch_xor((u64 *)(r10 - 8), r1);    \n\
    ^
    <inline asm>:7:40: note: instantiated into assembly here
           r1 =3D atomic_fetch_xor((u64 *)(r10 - 8), r1);=20
                                                 ^

I checked LLVM tests and the syntax seems to be correct (at-least this synt=
ax is
used by disassembler). So far I know that the following constructs are affe=
cted:
- `atomic_fetch_and`
- `atomic_fetch_cmpxchg`
- `atomic_fetch_or`
- `atomic_fetch_xchg`
- `atomic_fetch_xor`

Requires further investigation and a fix in LLVM.

# Pseudo-call instructions (9 files)

An object file might contain several BPF programs plus some functions used =
from
different programs. In order to load a program from such file, `libbpf` cre=
ates
a buffer and copies the program and all functions called from this program =
into
that buffer. For each visited pseudo-call instruction `libbpf` requires it =
to
point to a valid function described in ELF header.

However, this is not how `verifier/*.c` tests are written, for example here=
 is a
translated fragment from `verifier/loops1.c`:

    SEC("tracepoint")
    __description("bounded recursion")
    __failure __msg("back-edge")
    __naked void bounded_recursion(void)
    {
            asm volatile ("                                 \
            r1 =3D 0;                                         \
            call l0_%=3D;                                     \
            exit;                                           \
    l0_%=3D:  r1 +=3D 1;                                        \
            r0 =3D r1;                                        \
            if r1 < 4 goto l1_%=3D;                           \
            exit;                                           \
    l1_%=3D:  call l0_%=3D;                                     \
            exit;                                           \
    "       ::: __clobber_all);
    }

There are several possibilities here:
- split such tests into several functions during migration;
- add a special flag for `libbpf` asking to allow such calls;
- Andrii also suggested to try using `.section` directives inside inline
  assembly block.

This requires further investigation, I'll discuss it with Andrii some time =
later
this week or on Monday.

# Custom macro definitions (5 files)

Some tests define and use custom macro, e.g. atomic_fetch.c:

    #define __ATOMIC_FETCH_OP_TEST(src_reg, dst_reg, operand1, op, operand2=
, expect) ...
   =20
    __ATOMIC_FETCH_OP_TEST(BPF_REG_1, BPF_REG_2, 1, BPF_ADD | BPF_FETCH, 2,=
 3),
    __ATOMIC_FETCH_OP_TEST(BPF_REG_0, BPF_REG_1, 1, BPF_ADD | BPF_FETCH, 2,=
 3),
    // ...

Such tests would have to be migrated manually (the tool still can translate
portions of the test).

# `.fill_helper` (5 files)

Programs for some tests are generated programmatically by specifying
`.fill_helper` function in the test description, e.g. `verifier/scale.c`:

    {
    	"scale: scale test 1",
    	.insns =3D { },
    	.data =3D { },
    	.fill_helper =3D bpf_fill_scale,
    	.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
    	.result =3D ACCEPT,
    	.retval =3D 1,
    },

Such tests cannot be migrated
(but sometimes these are not the only tests in the file).

# libbpf does not like some junk code (3 files)

`libbpf` (and bpftool) reject some junk instructions intentionally encoded =
in
the tests, e.g. empty program from `verifier/basic.c`:

    SEC("socket")
    __description("empty prog")
    __failure __msg("last insn is not an exit or jmp")
    __failure_unpriv
    __naked void empty_prog(void)
    {
            asm volatile ("" ::: __clobber_all);
    }

# Small log buffer (2 files)

Currently `test_loader.c` uses 1Mb log buffer, while `test_verifier.c` uses=
 16Mb
log buffer. There are a few tests (like in `verifier/bounds.c`) that exit w=
ith
`-ESPC` for 1Mb buffer.

I can either bump log buffer size for `test_loader.c` or wait until Andrii'=
s
rotating log implementation lands.

# Per-test summary

- atomic_and               - asm parser issue;
- atomic_bounds            - asm parser issue;
- atomic_cmpxchg           - asm parser issue;
- atomic_fetch             - asm parser issue, tool limitation;
- atomic_fetch_add         - asm parser issue, uses macro;
- atomic_invalid           - simplistic, uses macro;
- atomic_or                - asm parser issue;
- atomic_xchg              - asm parser issue;
- atomic_xor               - asm parser issue;
- basic                    - simplistic, libbpf discards junk;
- basic_call               - simplistic;
- basic_instr              - tool limitation;
- basic_stx_ldx            - simplistic;
- bounds                   - small log buffer;
- bpf_get_stack            - tool limitation;
- bpf_loop_inline          - uses macro, uses .fill_helper;
- bpf_st_mem               - asm parser issue;
- btf_ctx_access           - tool limitation;
- calls                    - tool limitation, pseudo call;
- ctx                      - simplistic, tool limitation;
- ctx_sk_lookup            - simplistic, tool limitation;
- ctx_skb                  - simplistic, tool limitation;
- d_path                   - tool limitation;
- dead_code                - pseudo call;
- direct_packet_access     - pseudo call;
- direct_value_access      - pseudo call;
- event_output             - uses macro;
- jeq_infer_not_null       - ok;
- jit                      - uses .fill_helper;
- jmp32                    - tool limitation;
- jset                     - asm parser issue, tool limitation;
- jump                     - pseudo call;
- junk_insn                - simplistic, libbpf discards junk;
- ld_abs                   - uses .fill_helper;
- ld_dw                    - simplistic, uses .fill_helper;
- ld_imm64                 - simplistic, junk rejected by bpftool
- loops1                   - small log buffer, pseudo call;
- lwt                      - tool limitation;
- map_in_map               - ok (needs __msg update because of BPF_ST_MEM r=
ewrite);
- map_kptr                 - strange runtime issue, requires further invest=
igation;
- map_ptr_mixing           - tool limitation;
- perf_event_sample_period - simplistic, tool limitation;
- precise                  - pseudo call, needs __msg update because of BPF=
_ST_MEM rewrite;
- prevent_map_lookup       - tool limitation;
- ref_tracking             - tool limitation;
- regalloc                 - pseudo call
- runtime_jit              - tool limitation;
- scale                    - simplistic, uses .fill_helper;
- search_pruning           - tool limitation;
- sleepable                - simplistic, tool limitation;
- sock                     - ok (needs __msg update because of BPF_ST_MEM r=
ewrite);
- spin_lock                - pseudo call;
- subreg                   - tool limitation;
- unpriv                   - tool limitation;
- value_illegal_alu        - tool limitation;
- value_ptr_arith          - tool limitation;
- wide_access              - simplistic, uses macro;

Thanks,
Eduard
