Return-Path: <bpf+bounces-8556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D103788284
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 10:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBE51C20F40
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC27A925;
	Fri, 25 Aug 2023 08:42:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFD71C06
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 08:42:53 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0702100;
	Fri, 25 Aug 2023 01:42:14 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so9094051fa.3;
        Fri, 25 Aug 2023 01:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692952932; x=1693557732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juPhK3D/YRfSzOj0sctcxaBJgN+rpnSTyDi3wRfeAts=;
        b=dgwy1fhhutvwVQkMT6OB510PD8XTlN5PP3zUoYzg504/5+Zn2EEyBSrUb7lgrXx2Zj
         pTpgf1l7qzdkT2KRrRwj8gLKtsGuoN8USo9gs6xOZyHfRhw//zqPJHPdAc/ljU4UbDcf
         so4u/rosNzKe3c6KhaNXQIVXYgToYIyr7DnbmiW6mRNAhjL+NwFjoV3hcZ1bwmbN+KFT
         O1KVlflIaz2887GYOhLKCD1pWDVithU3rshRpF73tIkItBrFBLIqJNvZKVenoZ/5nuEv
         hTgo5ERBCld5XRKjkeIcSIqLTfFtKUjq4FiFMdnu5G85cdhOUky0Pz3+3jYaSTx3qQ8C
         Q2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692952932; x=1693557732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juPhK3D/YRfSzOj0sctcxaBJgN+rpnSTyDi3wRfeAts=;
        b=CT5XuOlCV1H4JRtrWF56eS/yTufu8grjt4j0i4sKjrK2v1dR0XG1rT2mlyXH+zqvcq
         JuA0gtnFUeZROoPOkyNEaUKEKOAOPlOVyskzTidIzfA3jr6S9THIUg5wAJqVgW3ySLzo
         JE1fyg4fhOrDOa9+nqLgE8U7ZsUmpoTHn4zzP3gBwDbHI5qf3YdJeH6J4w2bNDH3NTEs
         8YOMqisZCwNmHRb+FVGxDsnmkAw4JI1LhwOCPogWe7jUVpaozh62nDDGFvGgTaot9m/H
         uOq8AJvxBBaO0A62g4gLnRXJC/mQ/KEsAgYKcEleSGhXVAwpLtTKCNkeIbcZlw0HwafP
         Kc8w==
X-Gm-Message-State: AOJu0YzR1SSYR89HoaPP6Qzp1h4kKSfhppZINx/1V8LclH0jQFSr2bW+
	49snQoo70DpFWknl7BHZBqSLippsAIu0Nu6gILI=
X-Google-Smtp-Source: AGHT+IGDNKDXIX6wAoB2UrzfaLEqS4VXe9anlq4IFiT9JgNYW6/M+eLzxZephm4OI+Sq0Hb8HdpoXy5sCsvf5lSy8o8=
X-Received: by 2002:a2e:934b:0:b0:2b7:117:e54 with SMTP id m11-20020a2e934b000000b002b701170e54mr13302528ljh.4.1692952931791;
 Fri, 25 Aug 2023 01:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824133135.1176709-1-puranjay12@gmail.com>
 <20230824133135.1176709-4-puranjay12@gmail.com> <3e21f79c-71a8-663e-1a62-0d2d787b9692@huawei.com>
 <b4d5aaaf-7fe6-29fd-645a-62a4032820ae@huawei.com>
In-Reply-To: <b4d5aaaf-7fe6-29fd-645a-62a4032820ae@huawei.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 25 Aug 2023 10:42:00 +0200
Message-ID: <CANk7y0hZBsrvMjOQihRLAZkX7OqNeuK+eHojc+X=-peUtn-k7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] bpf, riscv: use prog pack allocator in
 the BPF JIT
To: Pu Lehui <pulehui@huawei.com>
Cc: bjorn@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, conor.dooley@microchip.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, linux-riscv@lists.infradead.org, 
	bpf@vger.kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Pu,

On Fri, Aug 25, 2023 at 9:34=E2=80=AFAM Pu Lehui <pulehui@huawei.com> wrote=
:
>
>
>
> On 2023/8/25 15:09, Pu Lehui wrote:
> > Hi Puranjay,
> >
> > Happy to see the RV64 pack allocator implementation.
>
> RV32 also
>
> >
> > On 2023/8/24 21:31, Puranjay Mohan wrote:
> >> Use bpf_jit_binary_pack_alloc() for memory management of JIT binaries =
in
> >> RISCV BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and =
RX
> >> buffers. The JIT writes the program into the RW buffer. When the JIT i=
s
> >> done, the program is copied to the final RX buffer with
> >> bpf_jit_binary_pack_finalize.
> >>
> >> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for RISC=
V
> >> JIT as these functions are required by bpf_jit_binary_pack allocator.
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> >> ---
> >>   arch/riscv/net/bpf_jit.h        |   3 +
> >>   arch/riscv/net/bpf_jit_comp64.c |  56 +++++++++++++---
> >>   arch/riscv/net/bpf_jit_core.c   | 113 +++++++++++++++++++++++++++---=
--
> >>   3 files changed, 146 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> >> index 2717f5490428..ad69319c8ea7 100644
> >> --- a/arch/riscv/net/bpf_jit.h
> >> +++ b/arch/riscv/net/bpf_jit.h
> >> @@ -68,6 +68,7 @@ static inline bool is_creg(u8 reg)
> >>   struct rv_jit_context {
> >>       struct bpf_prog *prog;
> >>       u16 *insns;        /* RV insns */
> >> +    u16 *ro_insns;
>
> In fact, the definition of w/ or w/o ro_ still looks a bit confusing.
> Maybe it is better for us not to change the current framework, as the
> current `image` is the final executed RX image, and the trampoline
> treats `image` as the same. Maybe it would be better to add a new RW
> image, such like `rw_iamge`, so that we do not break the existing
> framework and do not have to add too many comments.

I had thought about this and decided to create a new _ro image/header
and not _rw image/header. Here is my reasoning:
If we let the existing insns, header be considered the read_only
version from where the
program will run, and create new rw_insn and rw_header for doing the jit pr=
ocess
it would require a lot more changes to the framework.
functions like build_body(), bpf_jit_build_prologue(), etc. work on
ctx->insns and
now all these references would have to be changed to ctx->rw_insns.

Howsoever we implement this, there is no way to do it without changing
the current framework.
The crux of the problem is that we need to use the r/w area for
writing and the r/x area for calculating
offsets.

If you think this can be done in a more efficient way then I would
love to implement that, but all other
solutions that I tried made the code very difficult to follow.

>
> And any other parts, it looks great.=F0=9F=98=84
>
> >>       int ninsns;
> >>       int prologue_len;
> >>       int epilogue_offset;
> >> @@ -85,7 +86,9 @@ static inline int ninsns_rvoff(int ninsns)
> >>   struct rv_jit_data {
> >>       struct bpf_binary_header *header;
> >> +    struct bpf_binary_header *ro_header;
> >>       u8 *image;
> >> +    u8 *ro_image;
> >>       struct rv_jit_context ctx;
> >>   };
> >> diff --git a/arch/riscv/net/bpf_jit_comp64.c
> >> b/arch/riscv/net/bpf_jit_comp64.c
> >> index 0ca4f5c0097c..d77b16338ba2 100644
> >> --- a/arch/riscv/net/bpf_jit_comp64.c
> >> +++ b/arch/riscv/net/bpf_jit_comp64.c
> >> @@ -144,7 +144,11 @@ static bool in_auipc_jalr_range(s64 val)
> >>   /* Emit fixed-length instructions for address */
> >>   static int emit_addr(u8 rd, u64 addr, bool extra_pass, struct
> >> rv_jit_context *ctx)
> >>   {
> >> -    u64 ip =3D (u64)(ctx->insns + ctx->ninsns);
> >> +    /*
> >> +     * Use the ro_insns(RX) to calculate the offset as the BPF
> >> program will
> >> +     * finally run from this memory region.
> >> +     */
> >> +    u64 ip =3D (u64)(ctx->ro_insns + ctx->ninsns);
> >>       s64 off =3D addr - ip;
> >>       s64 upper =3D (off + (1 << 11)) >> 12;
> >>       s64 lower =3D off & 0xfff;
> >> @@ -465,7 +469,11 @@ static int emit_call(u64 addr, bool fixed_addr,
> >> struct rv_jit_context *ctx)
> >>       u64 ip;
> >>       if (addr && ctx->insns) {
> >
> > ctx->insns need to sync to ctx->ro_insns

Can you elaborate this more. I am missing something here.
The sync happens at the end by calling bpf_jit_binary_pack_finalize().

> >
> >> -        ip =3D (u64)(long)(ctx->insns + ctx->ninsns);
> >> +        /*
> >> +         * Use the ro_insns(RX) to calculate the offset as the BPF
> >> +         * program will finally run from this memory region.
> >> +         */
> >> +        ip =3D (u64)(long)(ctx->ro_insns + ctx->ninsns);
> >>           off =3D addr - ip;
> >>       }
> >> @@ -578,7 +586,8 @@ static int add_exception_handler(const struct
> >> bpf_insn *insn,
> >>   {
> >>       struct exception_table_entry *ex;
> >>       unsigned long pc;
> >> -    off_t offset;
> >> +    off_t ins_offset;
> >> +    off_t fixup_offset;
> >>       if (!ctx->insns || !ctx->prog->aux->extable ||
> >> BPF_MODE(insn->code) !=3D BPF_PROBE_MEM)
> >
> > ctx->ro_insns need to be checked also.

ctx->ro_insns is not initialised until we call bpf_jit_binary_pack_finalize=
()?

> >
> >>           return 0;
> >> @@ -593,12 +602,17 @@ static int add_exception_handler(const struct
> >> bpf_insn *insn,
> >>           return -EINVAL;
> >>       ex =3D &ctx->prog->aux->extable[ctx->nexentries];
> >> -    pc =3D (unsigned long)&ctx->insns[ctx->ninsns - insn_len];
> >> +    pc =3D (unsigned long)&ctx->ro_insns[ctx->ninsns - insn_len];
> >> -    offset =3D pc - (long)&ex->insn;
> >> -    if (WARN_ON_ONCE(offset >=3D 0 || offset < INT_MIN))
> >> +    /*
> >> +     * This is the relative offset of the instruction that may fault
> >> from
> >> +     * the exception table itself. This will be written to the except=
ion
> >> +     * table and if this instruction faults, the destination register
> >> will
> >> +     * be set to '0' and the execution will jump to the next
> >> instruction.
> >> +     */
> >> +    ins_offset =3D pc - (long)&ex->insn;
> >> +    if (WARN_ON_ONCE(ins_offset >=3D 0 || ins_offset < INT_MIN))
> >>           return -ERANGE;
> >> -    ex->insn =3D offset;
> >>       /*
> >>        * Since the extable follows the program, the fixup offset is
> >> always
> >> @@ -607,12 +621,25 @@ static int add_exception_handler(const struct
> >> bpf_insn *insn,
> >>        * bits. We don't need to worry about buildtime or runtime sort
> >>        * modifying the upper bits because the table is already sorted,
> >> and
> >>        * isn't part of the main exception table.
> >> +     *
> >> +     * The fixup_offset is set to the next instruction from the
> >> instruction
> >> +     * that may fault. The execution will jump to this after handling
> >> the
> >> +     * fault.
> >>        */
> >> -    offset =3D (long)&ex->fixup - (pc + insn_len * sizeof(u16));
> >> -    if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, offset))
> >> +    fixup_offset =3D (long)&ex->fixup - (pc + insn_len * sizeof(u16))=
;
> >> +    if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, fixup_offset))
> >>           return -ERANGE;
> >> -    ex->fixup =3D FIELD_PREP(BPF_FIXUP_OFFSET_MASK, offset) |
> >> +    /*
> >> +     * The offsets above have been calculated using the RO buffer but=
 we
> >> +     * need to use the R/W buffer for writes.
> >> +     * switch ex to rw buffer for writing.
> >> +     */
> >> +    ex =3D (void *)ctx->insns + ((void *)ex - (void *)ctx->ro_insns);
> >> +
> >> +    ex->insn =3D ins_offset;
> >> +
> >> +    ex->fixup =3D FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
> >>           FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
> >>       ex->type =3D EX_TYPE_BPF;
> >> @@ -1006,6 +1033,7 @@ int arch_prepare_bpf_trampoline(struct
> >> bpf_tramp_image *im, void *image,
> >>       ctx.ninsns =3D 0;
> >>       ctx.insns =3D NULL;
> >> +    ctx.ro_insns =3D NULL;
> >>       ret =3D __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr,
> >> flags, &ctx);
> >>       if (ret < 0)
> >>           return ret;
> >> @@ -1014,7 +1042,15 @@ int arch_prepare_bpf_trampoline(struct
> >> bpf_tramp_image *im, void *image,
> >>           return -EFBIG;
> >>       ctx.ninsns =3D 0;
> >> +    /*
> >> +     * The bpf_int_jit_compile() uses a RW buffer (ctx.insns) to
> >> write the
> >> +     * JITed instructions and later copies it to a RX region
> >> (ctx.ro_insns).
> >> +     * It also uses ctx.ro_insns to calculate offsets for jumps etc.
> >> As the
> >> +     * trampoline image uses the same memory area for writing and
> >> execution,
> >> +     * both ctx.insns and ctx.ro_insns can be set to image.
> >> +     */
> >>       ctx.insns =3D image;
> >> +    ctx.ro_insns =3D image;
> >>       ret =3D __arch_prepare_bpf_trampoline(im, m, tlinks, func_addr,
> >> flags, &ctx);
> >>       if (ret < 0)
> >>           return ret;
> >> diff --git a/arch/riscv/net/bpf_jit_core.c
> >> b/arch/riscv/net/bpf_jit_core.c
> >> index 7a26a3e1c73c..4c8dffc09368 100644
> >> --- a/arch/riscv/net/bpf_jit_core.c
> >> +++ b/arch/riscv/net/bpf_jit_core.c
> >> @@ -8,6 +8,8 @@
> >>   #include <linux/bpf.h>
> >>   #include <linux/filter.h>
> >> +#include <linux/memory.h>
> >> +#include <asm/patch.h>
> >>   #include "bpf_jit.h"
> >>   /* Number of iterations to try until offsets converge. */
> >> @@ -117,16 +119,27 @@ struct bpf_prog *bpf_int_jit_compile(struct
> >> bpf_prog *prog)
> >>                   sizeof(struct exception_table_entry);
> >>               prog_size =3D sizeof(*ctx->insns) * ctx->ninsns;
> >> -            jit_data->header =3D
> >> -                bpf_jit_binary_alloc(prog_size + extable_size,
> >> -                             &jit_data->image,
> >> -                             sizeof(u32),
> >> -                             bpf_fill_ill_insns);
> >> -            if (!jit_data->header) {
> >> +            jit_data->ro_header =3D
> >> +                bpf_jit_binary_pack_alloc(prog_size +
> >> +                              extable_size,
> >> +                              &jit_data->ro_image,
> >> +                              sizeof(u32),
> >> +                              &jit_data->header,
> >> +                              &jit_data->image,
> >> +                              bpf_fill_ill_insns);
> >> +            if (!jit_data->ro_header) {
> >>                   prog =3D orig_prog;
> >>                   goto out_offset;
> >>               }
> >> +            /*
> >> +             * Use the image(RW) for writing the JITed instructions.
> >> But also save
> >> +             * the ro_image(RX) for calculating the offsets in the
> >> image. The RW
> >> +             * image will be later copied to the RX image from where
> >> the program
> >> +             * will run. The bpf_jit_binary_pack_finalize() will do
> >> this copy in the
> >> +             * final step.
> >> +             */
> >> +            ctx->ro_insns =3D (u16 *)jit_data->ro_image;
> >>               ctx->insns =3D (u16 *)jit_data->image;
> >>               /*
> >>                * Now, when the image is allocated, the image can
> >> @@ -138,14 +151,12 @@ struct bpf_prog *bpf_int_jit_compile(struct
> >> bpf_prog *prog)
> >>       if (i =3D=3D NR_JIT_ITERATIONS) {
> >>           pr_err("bpf-jit: image did not converge in <%d passes!\n", i=
);
> >> -        if (jit_data->header)
> >> -            bpf_jit_binary_free(jit_data->header);
> >>           prog =3D orig_prog;
> >> -        goto out_offset;
> >> +        goto out_free_hdr;
> >>       }
> >>       if (extable_size)
> >> -        prog->aux->extable =3D (void *)ctx->insns + prog_size;
> >> +        prog->aux->extable =3D (void *)ctx->ro_insns + prog_size;
> >>   skip_init_ctx:
> >>       pass++;
> >> @@ -154,23 +165,35 @@ struct bpf_prog *bpf_int_jit_compile(struct
> >> bpf_prog *prog)
> >>       bpf_jit_build_prologue(ctx);
> >>       if (build_body(ctx, extra_pass, NULL)) {
> >> -        bpf_jit_binary_free(jit_data->header);
> >>           prog =3D orig_prog;
> >> -        goto out_offset;
> >> +        goto out_free_hdr;
> >>       }
> >>       bpf_jit_build_epilogue(ctx);
> >>       if (bpf_jit_enable > 1)
> >>           bpf_jit_dump(prog->len, prog_size, pass, ctx->insns);
> >> -    prog->bpf_func =3D (void *)ctx->insns;
> >> +    prog->bpf_func =3D (void *)ctx->ro_insns;
> >>       prog->jited =3D 1;
> >>       prog->jited_len =3D prog_size;
> >> -    bpf_flush_icache(jit_data->header, ctx->insns + ctx->ninsns);
> >> -
> >>       if (!prog->is_func || extra_pass) {
> >> -        bpf_jit_binary_lock_ro(jit_data->header);
> >> +        if (WARN_ON(bpf_jit_binary_pack_finalize(prog,
> >> +                             jit_data->ro_header,
> >> +                             jit_data->header))) {
> >> +            /* ro_header has been freed */
> >> +            jit_data->ro_header =3D NULL;
> >> +            prog =3D orig_prog;
> >> +            goto out_offset;
> >> +        }
> >> +        /*
> >> +         * The instructions have now been copied to the ROX region fr=
om
> >> +         * where they will execute.
> >> +         * Write any modified data cache blocks out to memory and
> >> +         * invalidate the corresponding blocks in the instruction cac=
he.
> >> +         */
> >> +        bpf_flush_icache(jit_data->ro_header,
> >> +                 ctx->ro_insns + ctx->ninsns);
> >>           for (i =3D 0; i < prog->len; i++)
> >>               ctx->offset[i] =3D ninsns_rvoff(ctx->offset[i]);
> >>           bpf_prog_fill_jited_linfo(prog, ctx->offset);
> >> @@ -185,6 +208,15 @@ struct bpf_prog *bpf_int_jit_compile(struct
> >> bpf_prog *prog)
> >>           bpf_jit_prog_release_other(prog, prog =3D=3D orig_prog ?
> >>                          tmp : orig_prog);
> >>       return prog;
> >> +
> >> +out_free_hdr:
> >> +    if (jit_data->header) {
> >> +        bpf_arch_text_copy(&jit_data->ro_header->size,
> >> +                   &jit_data->header->size,
> >> +                   sizeof(jit_data->header->size));
> >> +        bpf_jit_binary_pack_free(jit_data->ro_header, jit_data->heade=
r);
> >> +    }
> >> +    goto out_offset;
> >>   }
> >>   u64 bpf_jit_alloc_exec_limit(void)
> >> @@ -204,3 +236,52 @@ void bpf_jit_free_exec(void *addr)
> >>   {
> >>       return vfree(addr);
> >>   }
> >> +
> >> +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> >> +{
> >> +    int ret;
> >> +
> >> +    mutex_lock(&text_mutex);
> >> +    ret =3D patch_text_nosync(dst, src, len);
> >> +    mutex_unlock(&text_mutex);
> >> +
> >> +    if (ret)
> >> +        return ERR_PTR(-EINVAL);
> >> +
> >> +    return dst;
> >> +}
> >> +
> >> +int bpf_arch_text_invalidate(void *dst, size_t len)
> >> +{
> >> +    int ret =3D 0;
> >
> > no need to initialize it
> >
> >> +
> >> +    mutex_lock(&text_mutex);
> >> +    ret =3D patch_text_set_nosync(dst, 0, len);
> >> +    mutex_unlock(&text_mutex);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +void bpf_jit_free(struct bpf_prog *prog)
> >> +{
> >> +    if (prog->jited) {
> >> +        struct rv_jit_data *jit_data =3D prog->aux->jit_data;
> >> +        struct bpf_binary_header *hdr;
> >> +
> >> +        /*
> >> +         * If we fail the final pass of JIT (from jit_subprogs),
> >> +         * the program may not be finalized yet. Call finalize here
> >> +         * before freeing it.
> >> +         */
> >> +        if (jit_data) {
> >> +            bpf_jit_binary_pack_finalize(prog, jit_data->ro_header,
> >> +                             jit_data->header);
> >> +            kfree(jit_data);
> >> +        }
> >> +        hdr =3D bpf_jit_binary_pack_hdr(prog);
> >> +        bpf_jit_binary_pack_free(hdr, NULL);
> >> +        WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
> >> +    }
> >> +
> >> +    bpf_prog_unlock_free(prog);
> >> +}
> >
> >

Thanks,
Puranjay

