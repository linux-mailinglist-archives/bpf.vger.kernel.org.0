Return-Path: <bpf+bounces-2131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C66972863C
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 19:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB5E28163D
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B7B19935;
	Thu,  8 Jun 2023 17:22:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06719922
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 17:22:22 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E026A1BFF
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:21:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977c89c47bdso159775266b.2
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686244914; x=1688836914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl3pjUEIeqQyRBeOSjpJ7sWyO31DJERu00mMr9UruXA=;
        b=qggtQ2KLYjcHObGm4dtMhAQH03Brq4kvS/VxM88CYEWgrt8zPTjbLSz07jbdqSMgM/
         arfN5MhP0hpe6D3P9UJc3AfcW91DPHDgkdNi0u9eYComEV+kYw+J0u43f33U00beWDN3
         5EilLMUktuXG/nPJrlNK105X3bN2gKtFeZNoUsiwvXKNyCQSrO2ccmuaH4SBJ5FqcIN4
         tkxQHNPH6iAYWTp+y53P+X9AuwFFF9TKyzwVkfWOaMSYxgBA8qXVAWTPGCkAeiOFmTwE
         cvN91Xt+4grfJJcE77BRv4CQ/nok4FRD7Mt1BvS1s1+iEgCJJCeUswI1Jb83Ah0lSFrW
         masg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686244914; x=1688836914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tl3pjUEIeqQyRBeOSjpJ7sWyO31DJERu00mMr9UruXA=;
        b=R/iHSRLKGLTOQ3VF72ujHopM/MwHXIeXYoVmLKzPgS7PAh+t02XHoBX4vymt6xMSjS
         99ht69DzHL1r1Y7oLwsFXq+tE/KS+SL+Q0fz5a6cyP0v0M4wYdwoGGkTyqWYMTLzj444
         5ZJNbdb64ZnEZTISH81Vvo/REySEUtbOtE80VSatF6DRIFpaUYvOGUaCCUUZP0UTQd7s
         n8IRl4HrBTIyw+S/oFFL/zA8nCJXy1rShcAd4MnH1U7qBbkuTbtCyYXzL1pRj/s3Mr9v
         /O+DQHbLZogornRejnUgHEXeBZwh0XT02rB57iRzd1EfMl4osWjcuSnl0LYRlxTUJytw
         qo5w==
X-Gm-Message-State: AC+VfDxwzgkkCvjGkJRlf1E/J/btvLHRBUupb6ToGjt94ekqoqwZ8FnZ
	0lx4trviM4WM4L2IOqQSSrowYmzcMDIpuMyOjCY=
X-Google-Smtp-Source: ACHHUZ4kK5R6e6gtykfIHJ0JGO/ps21TgM/mD7/kNjvBxwiGg92cr6ACVl3T7T6TAC3tM4AkJe50yRWnzDFUozgZsSY=
X-Received: by 2002:a17:907:804:b0:96f:5cb3:df66 with SMTP id
 wv4-20020a170907080400b0096f5cb3df66mr390243ejb.18.1686244914032; Thu, 08 Jun
 2023 10:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606222411.1820404-1-eddyz87@gmail.com> <20230606222411.1820404-4-eddyz87@gmail.com>
 <CAEf4BzbbGV6gTJ1KdBB8EwLWV3aNE-iyNtP2pC-W1=MTDNRq5Q@mail.gmail.com> <cc31b95783afa7dc8fb806c973f8420d22a49e58.camel@gmail.com>
In-Reply-To: <cc31b95783afa7dc8fb806c973f8420d22a49e58.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jun 2023 10:21:42 -0700
Message-ID: <CAEf4Bzaj6K4UuLQU-eRPWQt+nnyXwj_-yf9NAyqMkW-fc1m0OA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 7, 2023 at 6:26=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2023-06-07 at 14:40 -0700, Andrii Nakryiko wrote:
> > On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > Make sure that the following unsafe example is rejected by verifier:
> > >
> > > 1: r9 =3D ... some pointer with range X ...
> > > 2: r6 =3D ... unbound scalar ID=3Da ...
> > > 3: r7 =3D ... unbound scalar ID=3Db ...
> > > 4: if (r6 > r7) goto +1
> > > 5: r6 =3D r7
> > > 6: if (r6 > X) goto ...
> > > --- checkpoint ---
> > > 7: r9 +=3D r7
> > > 8: *(u64 *)r9 =3D Y
> > >
> > > This example is unsafe because not all execution paths verify r7 rang=
e.
> > > Because of the jump at (4) the verifier would arrive at (6) in two st=
ates:
> > > I.  r6{.id=3Db}, r7{.id=3Db} via path 1-6;
> > > II. r6{.id=3Da}, r7{.id=3Db} via path 1-4, 6.
> > >
> > > Currently regsafe() does not call check_ids() for scalar registers,
> > > thus from POV of regsafe() states (I) and (II) are identical. If the
> > > path 1-6 is taken by verifier first, and checkpoint is created at (6)
> > > the path [1-4, 6] would be considered safe.
> > >
> > > This commit updates regsafe() to call check_ids() for precise scalar
> > > registers.
> > >
> > > To minimize the impact on verification performance, avoid generating
> > > bpf_reg_state::id for constant scalar values when processing BPF_MOV
> > > in check_alu_op(). Scalar IDs are utilized by find_equal_scalars() to
> > > propagate information about value ranges for registers that hold the
> > > same value. However, there is no need to propagate range information
> > > for constants.
> > >
> > > Still, there is some performance impact because of this change.
> > > Using veristat to compare number of processed states for selftests
> > > object files listed in tools/testing/selftests/bpf/veristat.cfg and
> > > Cilium object files from [1] gives the following statistics:
> > >
> > > $ ./veristat -e file,prog,states -f "states_pct>10" \
> > >     -C master-baseline.log current.log
> > > File         Program                         States  (DIFF)
> > > -----------  ------------------------------  --------------
> > > bpf_xdp.o    tail_handle_nat_fwd_ipv6        +155 (+23.92%)
> > > bpf_xdp.o    tail_nodeport_nat_ingress_ipv4  +102 (+27.20%)
> > > bpf_xdp.o    tail_rev_nodeport_lb4            +83 (+20.85%)
> > > loop6.bpf.o  trace_virtqueue_add_sgs          +25 (+11.06%)
> > >
> > > Also test case verifier_search_pruning/allocated_stack has to be
> > > updated to avoid conflicts in register ID assignments between cached
> > > and new states.
> > >
> > > [1] git@github.com:anakryiko/cilium.git
> > >
> > > Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register a=
ssignments.")
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > ---
> >
> > So I checked it also on our internal BPF object files, and it looks
> > mostly good. Here are the only regressions:
> >
> > Program                                   States (A)  States (B)
> > States   (DIFF)
> > ----------------------------------------  ----------  ----------
> > ---------------
> > balancer_ingress                               29219       34531
> > +5312 (+18.18%)
> > syar_bind6_protect6                             3257        3599
> > +342 (+10.50%)
> > syar_bind4_protect4                             2590        2931
> > +341 (+13.17%)
> > on_alloc                                         415         526
> > +111 (+26.75%)
> > on_free                                          406         517
> > +111 (+27.34%)
> > pycallcount                                      395         506
> > +111 (+28.10%)
> > resume_context                                   405         516
> > +111 (+27.41%)
> > on_py_event                                      395         506
> > +111 (+28.10%)
> > on_event                                         284         394
> > +110 (+38.73%)
> > handle_cuda_event                                268         378
> > +110 (+41.04%)
> > handle_cuda_launch                               276         386
> > +110 (+39.86%)
> > handle_cuda_malloc_ret                           272         382
> > +110 (+40.44%)
> > handle_cuda_memcpy                               270         380
> > +110 (+40.74%)
> > handle_cuda_memcpy_async                         270         380
> > +110 (+40.74%)
> > handle_pytorch_allocate_ret                      271         381
> > +110 (+40.59%)
> > handle_pytorch_malloc_ret                        272         382
> > +110 (+40.44%)
> > on_event                                         284         394
> > +110 (+38.73%)
> > on_event                                         284         394
> > +110 (+38.73%)
> > syar_task_enter_execve                           309         329
> > +20 (+6.47%)
> > kprobe__security_inode_link                      968         986
> > +18 (+1.86%)
> > kprobe__security_inode_symlink                   838         854
> > +16 (+1.91%)
> > tw_twfw_egress                                   249         251
> > +2 (+0.80%)
> > tw_twfw_ingress                                  250         252
> > +2 (+0.80%)
> > tw_twfw_tc_eg                                    248         250
> > +2 (+0.81%)
> > tw_twfw_tc_in                                    250         252
> > +2 (+0.80%)
> > raw_tracepoint__sched_process_exec               136         139
> > +3 (+2.21%)
> > kprobe_ret__do_filp_open                         869         871
> > +2 (+0.23%)
> > read_erlang_stack                                572         573
> > +1 (+0.17%)
> >
> >
> > They are mostly on small-ish programs. The only mild concern from my
> > side is balancer_ingress, which is one of Katran BPF programs. It add
> > +18% of states (which translates to about 70K more instructions
> > verified, up from 350K). I think we can live with this, but would be
> > nice to check why it's happening.
>
> Thank you for reviewing this series.
>
> I looked at the logs that you've shared, the difference is indeed
> caused by some scalar registers having a unique ID in cached state and
> no ID in current state or vice versa. The !rold->id trick that we
> discussed for V2 helps :)
>
> What do you think about an alternative way to exclude unique scalars
> as in the patch below? (on top of this patch-set):
>
> --- 8< -------------------------
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 235d7eded565..ece9722dff3b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15149,6 +15149,13 @@ static bool check_ids(u32 old_id, u32 cur_id, st=
ruct bpf_id_pair *idmap)
>         return false;
>  }
>
> +static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_verifier=
_env *env)
> +{
> +       old_id =3D old_id ? old_id : env->id_gen++;
> +       cur_id =3D cur_id ? cur_id : env->id_gen++;
> +       return check_ids(old_id, cur_id, env->idmap_scratch);
> +}
> +
>  static void clean_func_state(struct bpf_verifier_env *env,
>                              struct bpf_func_state *st)
>  {
> @@ -15325,7 +15332,7 @@ static bool regsafe(struct bpf_verifier_env *env,=
 struct bpf_reg_state *rold,
>                  */
>                 return range_within(rold, rcur) &&
>                        tnum_in(rold->var_off, rcur->var_off) &&
> -                      check_ids(rold->id, rcur->id, idmap);
> +                      check_scalar_ids(rold->id, rcur->id, env);
>         case PTR_TO_MAP_KEY:
>         case PTR_TO_MAP_VALUE:
>         case PTR_TO_MEM:
>
> ------------------------- >8 ---
>
> For me this patch removes all veristat differences compared to the
> master. If doing it for real, I'd like to reset env->id_gen at exit
> from states_equal() to the value it had at entry (to avoid allocating
> too many ids).

Hm.. It's clever and pretty minimal, I like it. We are basically
allocating virtual ID for SCALAR that doesn't have id, just to make
sure we get a conflict if the SCALAR with ID cannot be mapped into two
different SCALARs, right?

The only question would be if it's safe to do that for case when
old_reg->id !=3D 0 and cur_reg->id =3D=3D 0? E.g., if in old (verified)
state we have r6.id =3D r7.id =3D 123, and in new state we have r6.id =3D 0
and r7.id =3D 0, then your implementation above will say that states are
equivalent. But are they, given there is a link between r6 and r7 that
might be required for correctness. Which we don't have in current
state.

So with this we are getting to my original concerns with your
!rold->id approach, which tries to ignore the necessity of link
between registers.

What if we do this only for old registers? Then, (in old state) r6.id
=3D 0, r7.id =3D 0, (in new state) r6.id =3D r7.id =3D 123. This will be
rejected because first we'll map 123 to newly allocated X for r6.id,
and then when we try to match r7.id=3D123 to another allocated ID X+1
we'll get a conflict, right?

>
> >
> > I suspect that dropping SCALAR IDs as we discussed (after fixing
> > register fill/spill ID generation) might completely mitigate that.
> >
> > Overall, LGTM:
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > >  kernel/bpf/verifier.c                         | 34 ++++++++++++++++-=
--
> > >  .../bpf/progs/verifier_search_pruning.c       |  3 +-
> > >  2 files changed, 32 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 2aa60b73f1b5..175ca22b868e 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -12933,12 +12933,14 @@ static int check_alu_op(struct bpf_verifier=
_env *env, struct bpf_insn *insn)
> > >                 if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> > >                         struct bpf_reg_state *src_reg =3D regs + insn=
->src_reg;
> > >                         struct bpf_reg_state *dst_reg =3D regs + insn=
->dst_reg;
> > > +                       bool need_id =3D (src_reg->type =3D=3D SCALAR=
_VALUE && !src_reg->id &&
> > > +                                       !tnum_is_const(src_reg->var_o=
ff));
> > >
> >
> > nit: unnecessary outer ()
> >
> > >                         if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
> > >                                 /* case: R1 =3D R2
> > >                                  * copy register state to dest reg
> > >                                  */
> > > -                               if (src_reg->type =3D=3D SCALAR_VALUE=
 && !src_reg->id)
> > > +                               if (need_id)
> > >                                         /* Assign src and dst registe=
rs the same ID
> > >                                          * that will be used by find_=
equal_scalars()
> > >                                          * to propagate min/max range=
.
> >
> > [...]
>

