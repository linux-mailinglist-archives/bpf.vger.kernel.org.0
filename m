Return-Path: <bpf+bounces-8564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40458788628
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 13:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625451C20F91
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 11:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67E1D2F0;
	Fri, 25 Aug 2023 11:40:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429EC2FF
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:40:51 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2D51FD7;
	Fri, 25 Aug 2023 04:40:48 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b962c226ceso11775151fa.3;
        Fri, 25 Aug 2023 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692963647; x=1693568447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7zXBNjC9cy/dhW6wJfTjLbYuXFRUmAsDxA3SYBGnp8=;
        b=j7i1T3bTS7E2B+QsF8TfKzXpkoB6VZ4k/eSnDs5ZyoFhCyLIzzAbXEIKP/DIhmWpD8
         rFeI0REni6B70aqsI7dwF/mf1DyMLec2azxzBHSF8alIF3YWxxwrJHykig0Ru+AXA2Mc
         M/TvIGN9uHJCrOuuttLUpS9i2zI4+QhgDx2vrVNFN9Y7ufIZSDUkyj0iYzLc9z+B5/Na
         r4WBEw4TnNQpghktP7/MmfwI62C+qJIuLDRqeI0loY7tEjfCZ/yuHT21/Ul2DCOnkJlQ
         592uysUg/qlRGLAUd5q5LRhjy1yYV5dMugE6PWZtDJLWYpCz3p4KFRsk2kflt/GaM2Dg
         zQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692963647; x=1693568447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7zXBNjC9cy/dhW6wJfTjLbYuXFRUmAsDxA3SYBGnp8=;
        b=kIHmFEn6DL5LD7XJMeDb1r31Eh6rUbLtnQ4tl/+wmxuK2Pc1WokXPuaDhfVoFCZ8T6
         APUPKSPWTS6kF2PA/t5tM6s+T8xqDNvWVId0uMqWMKN8wvieS52OyWiQbThQkQyEl1bq
         V12HKM8paMI2ihBMIubAsYwKrXdvItQCEJrx8TbqR3NSA7AHo9lZ1ARJlxoa83r2z9bK
         vxRB4r1iUKH0jwRJmxWzgiYVGcolGoJcM838HqVxIrfQCNwkj/ckMWivWhwPN07LuvBh
         UkmEk1t9HBB1KifQjCcfRcTePt1Y3rzPPbt6bVQ3+SyLaAda+BiYFTrgX8XauMbuzy3C
         bvzg==
X-Gm-Message-State: AOJu0YxVsc03+lWrNGLRgNjHZjmLMxmpxSI+/qkiF0dXEO8EzG22J3nS
	Oic05xbSqnxOmxw61qQq6mKW74mxQSiIZGOhOlo=
X-Google-Smtp-Source: AGHT+IH3Jm3oOGJDg8Kz1SjQ8dAVA7Ih2QkPW0ksIPDdnqu1A6ewp4UQUohHGzPCwPqgrTtoPtcYREYd/Eho4NPzzL0=
X-Received: by 2002:a2e:9b4c:0:b0:2b9:e053:7a07 with SMTP id
 o12-20020a2e9b4c000000b002b9e0537a07mr13295707ljj.45.1692963646535; Fri, 25
 Aug 2023 04:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824133135.1176709-1-puranjay12@gmail.com>
 <20230824133135.1176709-4-puranjay12@gmail.com> <3e21f79c-71a8-663e-1a62-0d2d787b9692@huawei.com>
 <b4d5aaaf-7fe6-29fd-645a-62a4032820ae@huawei.com> <CANk7y0hZBsrvMjOQihRLAZkX7OqNeuK+eHojc+X=-peUtn-k7g@mail.gmail.com>
 <a8bce2e9-80e1-246c-9b87-19e2fdef25a8@huawei.com>
In-Reply-To: <a8bce2e9-80e1-246c-9b87-19e2fdef25a8@huawei.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 25 Aug 2023 13:40:35 +0200
Message-ID: <CANk7y0h=0oTvDf7fZqZtFmkNUrvt4L+npAMypR+eyyjRKrUYeA@mail.gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Pu,

On Fri, Aug 25, 2023 at 1:12=E2=80=AFPM Pu Lehui <pulehui@huawei.com> wrote=
:
>
>
>
> On 2023/8/25 16:42, Puranjay Mohan wrote:
> > Hi Pu,
> >
> > On Fri, Aug 25, 2023 at 9:34=E2=80=AFAM Pu Lehui <pulehui@huawei.com> w=
rote:
> >>
> >>
> >>
> >> On 2023/8/25 15:09, Pu Lehui wrote:
> >>> Hi Puranjay,
> >>>
> >>> Happy to see the RV64 pack allocator implementation.
> >>
> >> RV32 also
> >>
> >>>
> >>> On 2023/8/24 21:31, Puranjay Mohan wrote:
> >>>> Use bpf_jit_binary_pack_alloc() for memory management of JIT binarie=
s in
> >>>> RISCV BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW an=
d RX
> >>>> buffers. The JIT writes the program into the RW buffer. When the JIT=
 is
> >>>> done, the program is copied to the final RX buffer with
> >>>> bpf_jit_binary_pack_finalize.
> >>>>
> >>>> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for RI=
SCV
> >>>> JIT as these functions are required by bpf_jit_binary_pack allocator=
.
> >>>>
> >>>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> >>>> ---
> >>>>    arch/riscv/net/bpf_jit.h        |   3 +
> >>>>    arch/riscv/net/bpf_jit_comp64.c |  56 +++++++++++++---
> >>>>    arch/riscv/net/bpf_jit_core.c   | 113 +++++++++++++++++++++++++++=
-----
> >>>>    3 files changed, 146 insertions(+), 26 deletions(-)
> >>>>
> >>>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> >>>> index 2717f5490428..ad69319c8ea7 100644
> >>>> --- a/arch/riscv/net/bpf_jit.h
> >>>> +++ b/arch/riscv/net/bpf_jit.h
> >>>> @@ -68,6 +68,7 @@ static inline bool is_creg(u8 reg)
> >>>>    struct rv_jit_context {
> >>>>        struct bpf_prog *prog;
> >>>>        u16 *insns;        /* RV insns */
> >>>> +    u16 *ro_insns;
> >>
> >> In fact, the definition of w/ or w/o ro_ still looks a bit confusing.
> >> Maybe it is better for us not to change the current framework, as the
> >> current `image` is the final executed RX image, and the trampoline
> >> treats `image` as the same. Maybe it would be better to add a new RW
> >> image, such like `rw_iamge`, so that we do not break the existing
> >> framework and do not have to add too many comments.
> >
> > I had thought about this and decided to create a new _ro image/header
> > and not _rw image/header. Here is my reasoning:
> > If we let the existing insns, header be considered the read_only
> > version from where the
> > program will run, and create new rw_insn and rw_header for doing the ji=
t process
> > it would require a lot more changes to the framework.
> > functions like build_body(), bpf_jit_build_prologue(), etc. work on
> > ctx->insns and
>
> Hmm, the other parts should be fine, but the emit instruction is a
> problem. All right, let's go ahead.
>
> > now all these references would have to be changed to ctx->rw_insns.
> >
> > Howsoever we implement this, there is no way to do it without changing
> > the current framework.
> > The crux of the problem is that we need to use the r/w area for
> > writing and the r/x area for calculating
> > offsets.
> >
> > If you think this can be done in a more efficient way then I would
> > love to implement that, but all other
> > solutions that I tried made the code very difficult to follow.
> >
> >>
> >> And any other parts, it looks great.=F0=9F=98=84
> >>
> >>>>        int ninsns;
> >>>>        int prologue_len;
> >>>>        int epilogue_offset;
> >>>> @@ -85,7 +86,9 @@ static inline int ninsns_rvoff(int ninsns)
> >>>>    struct rv_jit_data {
> >>>>        struct bpf_binary_header *header;
> >>>> +    struct bpf_binary_header *ro_header;
> >>>>        u8 *image;
> >>>> +    u8 *ro_image;
> >>>>        struct rv_jit_context ctx;
> >>>>    };
> >>>> diff --git a/arch/riscv/net/bpf_jit_comp64.c
> >>>> b/arch/riscv/net/bpf_jit_comp64.c
> >>>> index 0ca4f5c0097c..d77b16338ba2 100644
> >>>> --- a/arch/riscv/net/bpf_jit_comp64.c
> >>>> +++ b/arch/riscv/net/bpf_jit_comp64.c
> >>>> @@ -144,7 +144,11 @@ static bool in_auipc_jalr_range(s64 val)
> >>>>    /* Emit fixed-length instructions for address */
> >>>>    static int emit_addr(u8 rd, u64 addr, bool extra_pass, struct
> >>>> rv_jit_context *ctx)
> >>>>    {
> >>>> -    u64 ip =3D (u64)(ctx->insns + ctx->ninsns);
> >>>> +    /*
> >>>> +     * Use the ro_insns(RX) to calculate the offset as the BPF
> >>>> program will
> >>>> +     * finally run from this memory region.
> >>>> +     */
> >>>> +    u64 ip =3D (u64)(ctx->ro_insns + ctx->ninsns);
> >>>>        s64 off =3D addr - ip;
> >>>>        s64 upper =3D (off + (1 << 11)) >> 12;
> >>>>        s64 lower =3D off & 0xfff;
> >>>> @@ -465,7 +469,11 @@ static int emit_call(u64 addr, bool fixed_addr,
> >>>> struct rv_jit_context *ctx)
> >>>>        u64 ip;
> >>>>        if (addr && ctx->insns) {
> >>>
> >>> ctx->insns need to sync to ctx->ro_insns
> >
> > Can you elaborate this more. I am missing something here.
> > The sync happens at the end by calling bpf_jit_binary_pack_finalize().
>
> if (addr && ctx->insns) {
>         ip =3D (u64)(long)(ctx->ro_insns + ctx->ninsns);
>         off =3D addr - ip;
> }
> emit ctx->insns + off
>
> Here we are assuming ctx->insns =3D=3D ctx->ro_insns, if they not, the
> offset calculated by ctx->ro_insns will not meaningful for ctx->insns.

We are not assuming that ctx->insns =3D=3D ctx->ro_insns at this point.
We are just finding the offset: off =3D addr(let's say in kernel) -
ip(address of the instruction);

> I was curious why we need to use ro_insns to calculate offset? Is that
> any problem if we do jit iteration with ctx->insns and the final copy
> ctx->insns to ro_insns?

All the offsets within the image can be calculated using ctx->insns and it =
will
work but if the emit_call() is for an address in the kernel code let's
say, then the
offset between this address(in kernel) and the R/W image would be different=
 from
the offset between the address(in kernel) and the R/O image.
We need the offset between the R/X Image and the kernel address. Because th=
e
CPU will execute the instructions from there.

>
> >
> >>>
> >>>> -        ip =3D (u64)(long)(ctx->insns + ctx->ninsns);
> >>>> +        /*
> >>>> +         * Use the ro_insns(RX) to calculate the offset as the BPF
> >>>> +         * program will finally run from this memory region.
> >>>> +         */
> >>>> +        ip =3D (u64)(long)(ctx->ro_insns + ctx->ninsns);
> >>>>            off =3D addr - ip;
> >>>>        }
> >>>> @@ -578,7 +586,8 @@ static int add_exception_handler(const struct
> >>>> bpf_insn *insn,
> >>>>    {
> >>>>        struct exception_table_entry *ex;
> >>>>        unsigned long pc;
> >>>> -    off_t offset;
> >>>> +    off_t ins_offset;
> >>>> +    off_t fixup_offset;
> >>>>        if (!ctx->insns || !ctx->prog->aux->extable ||
> >>>> BPF_MODE(insn->code) !=3D BPF_PROBE_MEM)
> >>>
> >>> ctx->ro_insns need to be checked also.
> >
> > ctx->ro_insns is not initialised until we call bpf_jit_binary_pack_fina=
lize()?

ctx->ro_insns and ctx->insns are both allocated together by
bpf_jit_binary_pack_alloc().
ctx->ro_insns is marked R/X and ctx->insns is marked R/W. We dump all
instructions in
ctx->insns and then copy them to ctx->ro_insns with
bpf_jit_binary_pack_finalize().

The catch is that instructions that work with offsets like JAL need
the offsets from ctx->ro_insns.
as explained above.

>
> if (!ctx->insns || !ctx->prog->aux->extable ||
> ...
> pc =3D (unsigned long)&ctx->ro_insns[ctx->ninsns - insn_len];
>
> The uninitialized ctx->ro_insns may lead to illegal address access.
> Although it will never happen, because we also assume that ctx->insns =3D=
=3D
> ctx->ro_insns.

Here also we are not assuming ctx->insns =3D=3D ctx->ro_insns. The ctx->ro_=
insns is
allocated but not initialised yet. So all addresses in range
ctx->ro_insns to ctx->ro_insns + size
are valid addresses. Here we are using the addresses only to find the
offset and not accessing those
addresses.

>
> >
> >>>
> >>>>            return 0;
> >>>> @@ -593,12 +602,17 @@ static int add_exception_handler(const struct
> >>>> bpf_insn *insn,
> >>>>            return -EINVAL;
> >>>>        ex =3D &ctx->prog->aux->extable[ctx->nexentries];
> >>>> -    pc =3D (unsigned long)&ctx->insns[ctx->ninsns - insn_len];
> >>>> +    pc =3D (unsigned long)&ctx->ro_insns[ctx->ninsns - insn_len];
> >>>> -    offset =3D pc - (long)&ex->insn;
> >>>> -    if (WARN_ON_ONCE(offset >=3D 0 || offset < INT_MIN))
> >>>> +    /*
> >>>> +     * This is the relative offset of the instruction that may faul=
t
> >>>> from
> >>>> +     * the exception table itself. This will be written to the exce=
ption
> >>>> +     * table and if this instruction faults, the destination regist=
er
> >>>> will
> >>>> +     * be set to '0' and the execution will jump to the next
> >>>> instruction.
> >>>> +     */
> >>>> +    ins_offset =3D pc - (long)&ex->insn;
> >>>> +    if (WARN_ON_ONCE(ins_offset >=3D 0 || ins_offset < INT_MIN))
> >>>>            return -ERANGE;
> >>>> -    ex->insn =3D offset;
> >>>>        /*
> >>>>         * Since the extable follows the program, the fixup offset is
> >>>> always
> >>>> @@ -607,12 +621,25 @@ static int add_exception_handler(const struct
> >>>> bpf_insn *insn,
> >>>>         * bits. We don't need to worry about buildtime or runtime so=
rt
> >>>>         * modifying the upper bits because the table is already sort=
ed,
> >>>> and
> >>>>         * isn't part of the main exception table.
> >>>> +     *
> >>>> +     * The fixup_offset is set to the next instruction from the
> >>>> instruction
> >>>> +     * that may fault. The execution will jump to this after handli=
ng
> >>>> the
> >>>> +     * fault.
> >>>>         */
> >>>> -    offset =3D (long)&ex->fixup - (pc + insn_len * sizeof(u16));
> >>>> -    if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, offset))
> >>>> +    fixup_offset =3D (long)&ex->fixup - (pc + insn_len * sizeof(u16=
));
> >>>> +    if (!FIELD_FIT(BPF_FIXUP_OFFSET_MASK, fixup_offset))
> >>>>            return -ERANGE;
> >>>> -    ex->fixup =3D FIELD_PREP(BPF_FIXUP_OFFSET_MASK, offset) |
> >>>> +    /*
> >>>> +     * The offsets above have been calculated using the RO buffer b=
ut we
> >>>> +     * need to use the R/W buffer for writes.
> >>>> +     * switch ex to rw buffer for writing.
> >>>> +     */
> >>>> +    ex =3D (void *)ctx->insns + ((void *)ex - (void *)ctx->ro_insns=
);
> >>>> +
> >>>> +    ex->insn =3D ins_offset;
> >>>> +
> >>>> +    ex->fixup =3D FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
> >>>>            FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
> >>>>        ex->type =3D EX_TYPE_BPF;
> >>>> @@ -1006,6 +1033,7 @@ int arch_prepare_bpf_trampoline(struct
> >>>> bpf_tramp_image *im, void *image,
> >>>>        ctx.ninsns =3D 0;
> >>>>        ctx.insns =3D NULL;
> >>>> +    ctx.ro_insns =3D NULL;
> >>>>        ret =3D __arch_prepare_bpf_trampoline(im, m, tlinks, func_add=
r,
> >>>> flags, &ctx);
> >>>>        if (ret < 0)
> >>>>            return ret;
> >>>> @@ -1014,7 +1042,15 @@ int arch_prepare_bpf_trampoline(struct
> >>>> bpf_tramp_image *im, void *image,
> >>>>            return -EFBIG;
> >>>>        ctx.ninsns =3D 0;
> >>>> +    /*
> >>>> +     * The bpf_int_jit_compile() uses a RW buffer (ctx.insns) to
> >>>> write the
> >>>> +     * JITed instructions and later copies it to a RX region
> >>>> (ctx.ro_insns).
> >>>> +     * It also uses ctx.ro_insns to calculate offsets for jumps etc=
.
> >>>> As the
> >>>> +     * trampoline image uses the same memory area for writing and
> >>>> execution,
> >>>> +     * both ctx.insns and ctx.ro_insns can be set to image.
> >>>> +     */
> >>>>        ctx.insns =3D image;
> >>>> +    ctx.ro_insns =3D image;
> >>>>        ret =3D __arch_prepare_bpf_trampoline(im, m, tlinks, func_add=
r,
> >>>> flags, &ctx);
> >>>>        if (ret < 0)
> >>>>            return ret;
> >>>> diff --git a/arch/riscv/net/bpf_jit_core.c
> >>>> b/arch/riscv/net/bpf_jit_core.c
> >>>> index 7a26a3e1c73c..4c8dffc09368 100644
> >>>> --- a/arch/riscv/net/bpf_jit_core.c
> >>>> +++ b/arch/riscv/net/bpf_jit_core.c
> >>>> @@ -8,6 +8,8 @@
> >>>>    #include <linux/bpf.h>
> >>>>    #include <linux/filter.h>
> >>>> +#include <linux/memory.h>
> >>>> +#include <asm/patch.h>
> >>>>    #include "bpf_jit.h"
> >>>>    /* Number of iterations to try until offsets converge. */
> >>>> @@ -117,16 +119,27 @@ struct bpf_prog *bpf_int_jit_compile(struct
> >>>> bpf_prog *prog)
> >>>>                    sizeof(struct exception_table_entry);
> >>>>                prog_size =3D sizeof(*ctx->insns) * ctx->ninsns;
> >>>> -            jit_data->header =3D
> >>>> -                bpf_jit_binary_alloc(prog_size + extable_size,
> >>>> -                             &jit_data->image,
> >>>> -                             sizeof(u32),
> >>>> -                             bpf_fill_ill_insns);
> >>>> -            if (!jit_data->header) {
> >>>> +            jit_data->ro_header =3D
> >>>> +                bpf_jit_binary_pack_alloc(prog_size +
> >>>> +                              extable_size,
> >>>> +                              &jit_data->ro_image,
> >>>> +                              sizeof(u32),
> >>>> +                              &jit_data->header,
> >>>> +                              &jit_data->image,
> >>>> +                              bpf_fill_ill_insns);
> >>>> +            if (!jit_data->ro_header) {
> >>>>                    prog =3D orig_prog;
> >>>>                    goto out_offset;
> >>>>                }
> >>>> +            /*
> >>>> +             * Use the image(RW) for writing the JITed instructions=
.
> >>>> But also save
> >>>> +             * the ro_image(RX) for calculating the offsets in the
> >>>> image. The RW
> >>>> +             * image will be later copied to the RX image from wher=
e
> >>>> the program
> >>>> +             * will run. The bpf_jit_binary_pack_finalize() will do
> >>>> this copy in the
> >>>> +             * final step.
> >>>> +             */
> >>>> +            ctx->ro_insns =3D (u16 *)jit_data->ro_image;
> >>>>                ctx->insns =3D (u16 *)jit_data->image;
> >>>>                /*
> >>>>                 * Now, when the image is allocated, the image can
> >>>> @@ -138,14 +151,12 @@ struct bpf_prog *bpf_int_jit_compile(struct
> >>>> bpf_prog *prog)
> >>>>        if (i =3D=3D NR_JIT_ITERATIONS) {
> >>>>            pr_err("bpf-jit: image did not converge in <%d passes!\n"=
, i);
> >>>> -        if (jit_data->header)
> >>>> -            bpf_jit_binary_free(jit_data->header);
> >>>>            prog =3D orig_prog;
> >>>> -        goto out_offset;
> >>>> +        goto out_free_hdr;
> >>>>        }
> >>>>        if (extable_size)
> >>>> -        prog->aux->extable =3D (void *)ctx->insns + prog_size;
> >>>> +        prog->aux->extable =3D (void *)ctx->ro_insns + prog_size;
> >>>>    skip_init_ctx:
> >>>>        pass++;
> >>>> @@ -154,23 +165,35 @@ struct bpf_prog *bpf_int_jit_compile(struct
> >>>> bpf_prog *prog)
> >>>>        bpf_jit_build_prologue(ctx);
> >>>>        if (build_body(ctx, extra_pass, NULL)) {
> >>>> -        bpf_jit_binary_free(jit_data->header);
> >>>>            prog =3D orig_prog;
> >>>> -        goto out_offset;
> >>>> +        goto out_free_hdr;
> >>>>        }
> >>>>        bpf_jit_build_epilogue(ctx);
> >>>>        if (bpf_jit_enable > 1)
> >>>>            bpf_jit_dump(prog->len, prog_size, pass, ctx->insns);
> >>>> -    prog->bpf_func =3D (void *)ctx->insns;
> >>>> +    prog->bpf_func =3D (void *)ctx->ro_insns;
> >>>>        prog->jited =3D 1;
> >>>>        prog->jited_len =3D prog_size;
> >>>> -    bpf_flush_icache(jit_data->header, ctx->insns + ctx->ninsns);
> >>>> -
> >>>>        if (!prog->is_func || extra_pass) {
> >>>> -        bpf_jit_binary_lock_ro(jit_data->header);
> >>>> +        if (WARN_ON(bpf_jit_binary_pack_finalize(prog,
> >>>> +                             jit_data->ro_header,
> >>>> +                             jit_data->header))) {
> >>>> +            /* ro_header has been freed */
> >>>> +            jit_data->ro_header =3D NULL;
> >>>> +            prog =3D orig_prog;
> >>>> +            goto out_offset;
> >>>> +        }
> >>>> +        /*
> >>>> +         * The instructions have now been copied to the ROX region =
from
> >>>> +         * where they will execute.
> >>>> +         * Write any modified data cache blocks out to memory and
> >>>> +         * invalidate the corresponding blocks in the instruction c=
ache.
> >>>> +         */
> >>>> +        bpf_flush_icache(jit_data->ro_header,
> >>>> +                 ctx->ro_insns + ctx->ninsns);
> >>>>            for (i =3D 0; i < prog->len; i++)
> >>>>                ctx->offset[i] =3D ninsns_rvoff(ctx->offset[i]);
> >>>>            bpf_prog_fill_jited_linfo(prog, ctx->offset);
> >>>> @@ -185,6 +208,15 @@ struct bpf_prog *bpf_int_jit_compile(struct
> >>>> bpf_prog *prog)
> >>>>            bpf_jit_prog_release_other(prog, prog =3D=3D orig_prog ?
> >>>>                           tmp : orig_prog);
> >>>>        return prog;
> >>>> +
> >>>> +out_free_hdr:
> >>>> +    if (jit_data->header) {
> >>>> +        bpf_arch_text_copy(&jit_data->ro_header->size,
> >>>> +                   &jit_data->header->size,
> >>>> +                   sizeof(jit_data->header->size));
> >>>> +        bpf_jit_binary_pack_free(jit_data->ro_header, jit_data->hea=
der);
> >>>> +    }
> >>>> +    goto out_offset;
> >>>>    }
> >>>>    u64 bpf_jit_alloc_exec_limit(void)
> >>>> @@ -204,3 +236,52 @@ void bpf_jit_free_exec(void *addr)
> >>>>    {
> >>>>        return vfree(addr);
> >>>>    }
> >>>> +
> >>>> +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> >>>> +{
> >>>> +    int ret;
> >>>> +
> >>>> +    mutex_lock(&text_mutex);
> >>>> +    ret =3D patch_text_nosync(dst, src, len);
> >>>> +    mutex_unlock(&text_mutex);
> >>>> +
> >>>> +    if (ret)
> >>>> +        return ERR_PTR(-EINVAL);
> >>>> +
> >>>> +    return dst;
> >>>> +}
> >>>> +
> >>>> +int bpf_arch_text_invalidate(void *dst, size_t len)
> >>>> +{
> >>>> +    int ret =3D 0;
> >>>
> >>> no need to initialize it
> >>>
> >>>> +
> >>>> +    mutex_lock(&text_mutex);
> >>>> +    ret =3D patch_text_set_nosync(dst, 0, len);
> >>>> +    mutex_unlock(&text_mutex);
> >>>> +
> >>>> +    return ret;
> >>>> +}
> >>>> +
> >>>> +void bpf_jit_free(struct bpf_prog *prog)
> >>>> +{
> >>>> +    if (prog->jited) {
> >>>> +        struct rv_jit_data *jit_data =3D prog->aux->jit_data;
> >>>> +        struct bpf_binary_header *hdr;
> >>>> +
> >>>> +        /*
> >>>> +         * If we fail the final pass of JIT (from jit_subprogs),
> >>>> +         * the program may not be finalized yet. Call finalize here
> >>>> +         * before freeing it.
> >>>> +         */
> >>>> +        if (jit_data) {
> >>>> +            bpf_jit_binary_pack_finalize(prog, jit_data->ro_header,
> >>>> +                             jit_data->header);
> >>>> +            kfree(jit_data);
> >>>> +        }
> >>>> +        hdr =3D bpf_jit_binary_pack_hdr(prog);
> >>>> +        bpf_jit_binary_pack_free(hdr, NULL);
> >>>> +        WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
> >>>> +    }
> >>>> +
> >>>> +    bpf_prog_unlock_free(prog);
> >>>> +}
> >>>
> >>>
> >
> > Thanks,
> > Puranjay


Thanks,
Puranjay

