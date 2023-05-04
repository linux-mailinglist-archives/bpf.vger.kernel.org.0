Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424546F729A
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 21:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjEDTEB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 15:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjEDTDU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 15:03:20 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20769ED1
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 12:02:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso1744603a12.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683226955; x=1685818955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1M40+jv/N+PyHIWWv5AM2uJEY4wS/PY6MqmarzFO9Y=;
        b=DhaonV5E8WMf9HEaRexbMJ1sJ0vtJUphTtZME9z1Bjer3RYxD/f6d/50LiggQEQ1j9
         Cksq7ZuTe92iWXNUIFT47ao7Gtt87hwFcIGdTmowJHJCzo+btuC1rpGjnCPSmPQ5eImQ
         QhJVLi19qsXD3TkTuaFPQRYw2lnEt2tLkEiNLi8VBMT5P/ELQVHMcbDVcr/4HtO26p/1
         cmkVi6xdFeFvLa7NGBLN1o+BhUIPwVRS2/3kikd1FUe2aixMtogFPrUwZIHShbmo++tn
         2lu5BB0zNVgOZj7MH5yTBcU0vRE+eVIdsWHfK4Y5+kkZs4bSas6XQ+bp/1iN8Q6/p2Bt
         xcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683226955; x=1685818955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1M40+jv/N+PyHIWWv5AM2uJEY4wS/PY6MqmarzFO9Y=;
        b=hEgcL+u+gvz7w9w2yhaVfJo2L93+X+CujqzcpNHJThg5jFjNDsqjJGUj6BtU3zfZ9w
         4h8/g4cOJOYwhqefXfKodB7/n6jNLxsGdmLm6eH/FSSKe+FBImmnj3rVSFln+lUnEqCj
         LDlKB9MzUoBf6syl4DuI68jW/9Tk5DxP/XwI5zB04cAMcZ5HZwbcMGsllpijLNi4s783
         Q5yUIdZYV77bfyPjmvogTcS0ljoOOMms01CfBL2ncClDuYN8hdi4BeksOXaDRDt+5xAX
         w20jl6/owr3oQe/bLqeHjh0ddPCIZ6/v2A9+nCc9W1fYAWlGJbauIuajo2B11czw2ATC
         Cutg==
X-Gm-Message-State: AC+VfDwCkeVdX+GDm5NGqkCkoD7IalKjDc3DrdQO3+6LbbYpxyLuxKIR
        IqS1CbTWl18MG9tLzpr9UY5q3r9agOyFccmB8le88jR7
X-Google-Smtp-Source: ACHHUZ47BWCT10RuSMFKLIo8v6UGqRLt4ZII2g+2ngh1P52AC8yv/LjVrtJvw8/jEVsmB2cCKbKJxBlBtUVY+LnNXUc=
X-Received: by 2002:a17:907:960a:b0:94f:3f92:c7b0 with SMTP id
 gb10-20020a170907960a00b0094f3f92c7b0mr7222141ejc.60.1683226953930; Thu, 04
 May 2023 12:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230425234911.2113352-1-andrii@kernel.org> <20230425234911.2113352-4-andrii@kernel.org>
 <20230504025309.actotyekpawodfar@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230504025309.actotyekpawodfar@dhcp-172-26-102-232.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 4 May 2023 12:02:22 -0700
Message-ID: <CAEf4BzZ7jbEQ6MSdthOe=bj1eptCft3spJ_KucERi7jGxuSqzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/10] bpf: encapsulate precision backtracking bookkeeping
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 3, 2023 at 7:53=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Few early comments so far...
>
> On Tue, Apr 25, 2023 at 04:49:04PM -0700, Andrii Nakryiko wrote:
> > Add struct backtrack_state and straightforward API around it to keep
> > track of register and stack masks used and maintained during precision
> > backtracking process. Having this logic separately allow to keep
> > high-level backtracking algorithm cleaner, but also it sets us up to
> > cleanly keep track of register and stack masks per frame, allowing (wit=
h
> > some further logic adjustments) to perform precision backpropagation
> > across multiple frames (i.e., subprog calls).
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf_verifier.h |  15 ++
> >  kernel/bpf/verifier.c        | 258 ++++++++++++++++++++++++++---------
> >  2 files changed, 206 insertions(+), 67 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 3dd29a53b711..185bfaf0ec6b 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -238,6 +238,10 @@ enum bpf_stack_slot_type {
> >
> >  #define BPF_REG_SIZE 8       /* size of eBPF register in bytes */
> >
> > +#define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
> > +                       (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
> > +                       (1 << BPF_REG_5))
> > +
> >  #define BPF_DYNPTR_SIZE              sizeof(struct bpf_dynptr_kern)
> >  #define BPF_DYNPTR_NR_SLOTS          (BPF_DYNPTR_SIZE / BPF_REG_SIZE)
> >
> > @@ -541,6 +545,16 @@ struct bpf_subprog_info {
> >       bool is_async_cb;
> >  };
> >
> > +struct bpf_verifier_env;
> > +
> > +struct backtrack_state {
> > +     struct bpf_verifier_env *env;
> > +     u32 frame;
> > +     u32 bitcnt;
> > +     u32 reg_masks[MAX_CALL_FRAMES];
> > +     u64 stack_masks[MAX_CALL_FRAMES];
> > +};
> > +
> >  /* single container for all structs
> >   * one verifier_env per bpf_check() call
> >   */
> > @@ -578,6 +592,7 @@ struct bpf_verifier_env {
> >               int *insn_stack;
> >               int cur_stack;
> >       } cfg;
> > +     struct backtrack_state bt;
> >       u32 pass_cnt; /* number of times do_check() was called */
> >       u32 subprog_cnt;
> >       /* number of instructions analyzed by the verifier */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fea6fe4acba2..1cb89fe00507 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -1254,6 +1254,12 @@ static bool is_spilled_reg(const struct bpf_stac=
k_state *stack)
> >       return stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL;
> >  }
> >
> > +static bool is_spilled_scalar_reg(const struct bpf_stack_state *stack)
> > +{
> > +     return stack->slot_type[BPF_REG_SIZE - 1] =3D=3D STACK_SPILL &&
> > +            stack->spilled_ptr.type =3D=3D SCALAR_VALUE;
> > +}
> > +
> >  static void scrub_spilled_slot(u8 *stype)
> >  {
> >       if (*stype !=3D STACK_INVALID)
> > @@ -3144,12 +3150,137 @@ static const char *disasm_kfunc_name(void *dat=
a, const struct bpf_insn *insn)
> >       return btf_name_by_offset(desc_btf, func->name_off);
> >  }
> >
> > +static inline void bt_init(struct backtrack_state *bt, u32 frame)
> > +{
> > +     bt->frame =3D frame;
> > +}
> > +
> > +static inline void bt_reset(struct backtrack_state *bt)
> > +{
> > +     struct bpf_verifier_env *env =3D bt->env;
> > +     memset(bt, 0, sizeof(*bt));
> > +     bt->env =3D env;
> > +}
> > +
> > +static inline u32 bt_bitcnt(struct backtrack_state *bt)
> > +{
> > +     return bt->bitcnt;
> > +}
>
> I could have missed it, but it doesn't look that any further patch uses
> the actual number of bits set.
> All uses are: if (bt_bitcnt(bt) !=3D 0)
>
> Hence keeping bitcnt as extra 4 bytes and doing ++, -- on it
> seems wasteful.
> Maybe rename bt_bitcnt into bt_empty or bt_non_empty that
> will do !!bt->reg_masks[bt->frame] | !!bt->stack_masks[bt->frame]

Yes, number of bits doesn't matter, it's whether there are any or not.
So I'll rename.

As for the counter. I did it to avoid going over all MAX_CALL_FRAMES
frames to calculate the final mask. So it was a choice of maintaining
count proactively, or doing a loop each time we need to know if there
are any bits set:

u64 mask =3D 0;

for (i =3D 0; i <=3D bt->frame; i++)
    mask |=3D bt->reg_masks[i] | bt->stack_masks[i];

return mask !=3D 0;


I don't think this one is very expensive either, so I can just switch
to this, if you prefer that. That will eliminate all the ifs, of
course.


>
>
> > +static inline int bt_subprog_enter(struct backtrack_state *bt)
> > +{
> > +     if (bt->frame =3D=3D MAX_CALL_FRAMES - 1) {
> > +             verbose(bt->env, "BUG subprog enter from frame %d\n", bt-=
>frame);
> > +             WARN_ONCE(1, "verifier backtracking bug");
> > +             return -EFAULT;
> > +     }
> > +     bt->frame++;
> > +     return 0;
> > +}
> > +
> > +static inline int bt_subprog_exit(struct backtrack_state *bt)
> > +{
> > +     if (bt->frame =3D=3D 0) {
> > +             verbose(bt->env, "BUG subprog exit from frame 0\n");
> > +             WARN_ONCE(1, "verifier backtracking bug");
> > +             return -EFAULT;
> > +     }
> > +     bt->frame--;
> > +     return 0;
> > +}
> > +
> > +static inline void bt_set_frame_reg(struct backtrack_state *bt, u32 fr=
ame, u32 reg)
> > +{
> > +     if (bt->reg_masks[frame] & (1 << reg))
> > +             return;
> > +
> > +     bt->reg_masks[frame] |=3D 1 << reg;
> > +     bt->bitcnt++;
> > +}
>
> It doesnt' look that any further patch is using bt_set_frame_reg with exp=
licit frame.
> If not, collapse bt_set_frame_reg and bt_set_reg ?

We do later on, in patch #8, e.g., to propagate r1-r5 bits from
subprog back to caller.

>
> > +
> > +static inline void bt_clear_frame_reg(struct backtrack_state *bt, u32 =
frame, u32 reg)
> > +{
> > +     if (!(bt->reg_masks[frame] & (1 << reg)))
> > +             return;
> > +
> > +     bt->reg_masks[frame] &=3D ~(1 << reg);
> > +     bt->bitcnt--;
> > +}
>
> If we remove ++,-- of bitcnt this function will be much shorter and faste=
r:
> +static inline void bt_clear_frame_reg(struct backtrack_state *bt, u32 fr=
ame, u32 reg)
> +{
> +       bt->reg_masks[frame] &=3D ~(1 << reg);
> +}
>
> Removing runtime conditional has a nice perf benefit. Obviously tiny in a=
 grand scheme, but still.
>

Yep, see above. I did it to avoid doing a loop over up to 8 frame
levels to OR all reg_masks and stack_masks. Maybe a wrong tradeoff and
it's best to do one small loop when we need to check if there are any
bits left to clear?

> Overall it's a nice cleanup.

Thanks!


will fix missing empty line you mentioned in another reply
