Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3A06410E0
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 23:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiLBWtG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 17:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbiLBWsq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 17:48:46 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B9E4661
        for <bpf@vger.kernel.org>; Fri,  2 Dec 2022 14:48:21 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id n1so6944356ljg.3
        for <bpf@vger.kernel.org>; Fri, 02 Dec 2022 14:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iFKi3W4T2lEhOqCVOCv/JjhSxqUcfivpMfY8gPckrQs=;
        b=kvjuTUpdxr2apqjvbkFWx5FBI7LSK82EtFr27BizAm0PjhvWwImgKHMXp6tCgM4WBw
         YiaTCAfMK1dnNfrxdzL6od+jbEkm/NHxnwyec8v27SefVo6iVUqY9gWBwQ2gCFx6SRDQ
         gEUK5ogOMiXWpnn9DBxKLPyR5JYmvejGjPq5kteTX2q0VK6uk+3qTV/u4KfN8CQNXD1c
         SBT7UAbdjRy3RWWXpTTA6CipNiPTPb1XkFR7fh88bZ7sO0ZvCYBPW9a7f2bgVd8LSsyD
         O3QHBGBBNsLN2OcDWEq2wfSgzdxHoicnKT8GCUSe34kjB9yXNmQ/LVaNfx7ot7b0PXHO
         QlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFKi3W4T2lEhOqCVOCv/JjhSxqUcfivpMfY8gPckrQs=;
        b=i7Kf89dQErc9ypGg+dFjU7+TNHnWjQFBz2PVWcgL6Zyod5CdPqh3P+D9Qs0S6RFZuX
         WBBz9X3VE5IiLq8H2axl/KHC+mhLVotoNY8OuRf+h2Bz2487sr16MlKb1G1HjKEHp8xF
         gFHi7xrjRHFt7kfZYSv2MbLC9M7hI8gwpND+WR5rxh2ZOg1oAFB97xaEtndvquM/pUlv
         8h0qg9QdbJUJof9vlKp9gWKt59P6Kr3qSqNG/5ZwbStSMnHMemTEedeQRTUoLBiKrBzF
         YqpPxmhaWImOhqzXHur/6QqpufdhMiMyS78XLC16mDhDdq41WT50Se/FMWg7aKxnqZoO
         LZAA==
X-Gm-Message-State: ANoB5pkWAEg83BBWGIrR/VxSBmzaBYKNO9ZetK4QGQD61wDgPlX4cjnU
        w1jIzQwx+yn3Pa04Ln56rQi44OVi8Ho=
X-Google-Smtp-Source: AA0mqf58aKF18qnCKgi06I1IfbKQH8A+RAu9M4rSOg1M2gF1cqmar1NmEff4CpesJB7bAJ2929hZnQ==
X-Received: by 2002:a2e:9c51:0:b0:277:e8e:8d90 with SMTP id t17-20020a2e9c51000000b002770e8e8d90mr18537563ljj.243.1670021299386;
        Fri, 02 Dec 2022 14:48:19 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id dw8-20020a0565122c8800b004998d9ccb62sm1159369lfb.99.2022.12.02.14.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:48:18 -0800 (PST)
Message-ID: <517af2c57ee4b9ce2d96a8cf33f7295f2d2dfe13.camel@gmail.com>
Subject: Re: [RFC bpf-next 1/2] bpf: verify scalar ids mapping in regsafe()
 using check_ids()
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Sat, 03 Dec 2022 00:48:17 +0200
In-Reply-To: <8c5560dd1e27ed9eee57ca24b4e6a7304875c669.camel@gmail.com>
References: <20221128163442.280187-1-eddyz87@gmail.com>
         <20221128163442.280187-2-eddyz87@gmail.com>
         <CAEf4BzZBYQ2EXH4Rj8kmTFb08SkRpnpesjpj6X-AKAtsJnuV6g@mail.gmail.com>
         <859d531ef1e2b4dab103d316e6f109958f3f1bad.camel@gmail.com>
         <8c5560dd1e27ed9eee57ca24b4e6a7304875c669.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-12-01 at 20:33 +0200, Eduard Zingerman wrote:
> On Thu, 2022-12-01 at 03:14 +0200, Eduard Zingerman wrote:
> > On Wed, 2022-11-30 at 16:26 -0800, Andrii Nakryiko wrote:
> > > On Mon, Nov 28, 2022 at 8:35 AM Eduard Zingerman <eddyz87@gmail.com> =
wrote:
> > > >=20
> > > > Prior to this commit the following unsafe example passed verificati=
on:
> > > >=20
> > > > 1: r9 =3D ... some pointer with range X ...
> > > > 2: r6 =3D ... unbound scalar ID=3Da ...
> > > > 3: r7 =3D ... unbound scalar ID=3Db ...
> > > > 4: if (r6 > r7) goto +1
> > > > 5: r6 =3D r7
> > > > 6: if (r6 > X) goto ...   ; <-- suppose checkpoint state is created=
 here
> > > > 7: r9 +=3D r7
> > > > 8: *(u64 *)r9 =3D Y
> > > >=20
> > > > This example is unsafe because not all execution paths verify r7 ra=
nge.
> > > > Because of the jump at (4) the verifier would arrive at (6) in two =
states:
> > > > I.  r6{.id=3Db}, r7{.id=3Db} via path 1-6;
> > > > II. r6{.id=3Da}, r7{.id=3Db} via path 1-4, 6.
> > > >=20
> > > > Currently regsafe() does not call check_ids() for scalar registers,
> > > > thus from POV of regsafe() states (I) and (II) are identical. If th=
e
> > > > path 1-6 is taken by verifier first and checkpoint is created at (6=
)
> > > > the path 1-4, 6 would be considered safe.
> > > >=20
> > > > This commit makes the following changes:
> > > > - a call to check_ids() is added in regsafe() for scalar registers =
case;
> > > > - a function mark_equal_scalars_as_read() is added to ensure that
> > > >   registers with identical IDs are preserved in the checkpoint stat=
es
> > > >   in case when find_equal_scalars() updates register range for seve=
ral
> > > >   registers sharing the same ID.
> > > >=20
> > >=20
> > > Fixes tag missing?
> > >=20
> > > These are tricky changes with subtle details. Let's split check_ids()
> > > change and all the liveness manipulations into separate patches? They
> > > are conceptually completely independent, right?
> > >=20
> > >=20
> > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > > >  kernel/bpf/verifier.c | 87 +++++++++++++++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 85 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 6599d25dae38..8a5b7192514a 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -10638,10 +10638,12 @@ static int check_alu_op(struct bpf_verifi=
er_env *env, struct bpf_insn *insn)
> > > >                                 /* case: R1 =3D R2
> > > >                                  * copy register state to dest reg
> > > >                                  */
> > > > -                               if (src_reg->type =3D=3D SCALAR_VAL=
UE && !src_reg->id)
> > > > +                               if (src_reg->type =3D=3D SCALAR_VAL=
UE && !src_reg->id &&
> > > > +                                   !tnum_is_const(src_reg->var_off=
))
> > > >                                         /* Assign src and dst regis=
ters the same ID
> > > >                                          * that will be used by fin=
d_equal_scalars()
> > > >                                          * to propagate min/max ran=
ge.
> > > > +                                        * Skip constants to avoid =
allocation of useless ID.
> > > >                                          */
> > > >                                         src_reg->id =3D ++env->id_g=
en;
> > > >                                 *dst_reg =3D *src_reg;
> > > > @@ -11446,16 +11448,86 @@ static bool try_match_pkt_pointers(const =
struct bpf_insn *insn,
> > > >         return true;
> > > >  }
> > > >=20
> > > > +/* Scalar ID generation in check_alu_op() and logic of
> > > > + * find_equal_scalars() make the following pattern possible:
> > > > + *
> > > > + * 1: r9 =3D ... some pointer with range X ...
> > > > + * 2: r6 =3D ... unbound scalar ID=3Da ...
> > > > + * 3: r7 =3D ... unbound scalar ID=3Db ...
> > > > + * 4: if (r6 > r7) goto +1
> > > > + * 5: r6 =3D r7
> > > > + * 6: if (r6 > X) goto ...   ; <-- suppose checkpoint state is cre=
ated here
> > > > + * 7: r9 +=3D r7
> > > > + * 8: *(u64 *)r9 =3D Y
> > > > + *
> > > > + * Because of the jump at (4) the verifier would arrive at (6) in =
two states:
> > > > + * I.  r6{.id=3Db}, r7{.id=3Db}
> > > > + * II. r6{.id=3Da}, r7{.id=3Db}
> > > > + *
> > > > + * Relevant facts:
> > > > + * - regsafe() matches ID mappings for scalars using check_ids(), =
this makes
> > > > + *   states (I) and (II) non-equal;
> > > > + * - clean_func_state() removes registers not marked as REG_LIVE_R=
EAD from
> > > > + *   checkpoint states;
> > > > + * - mark_reg_read() modifies reg->live for reg->parent (and it's =
parents);
> > > > + * - when r6 =3D r7 is process the bpf_reg_state is copied in full=
, meaning
> > > > + *   that parent pointers are copied as well.
> > >=20
> > > not too familiar with liveness handling, but is this correct and
> > > expected? Should this be fixed instead of REG_LIVE_READ manipulations=
?
>=20
>=20
> TLDR:
>=20
> - looks like it is safe to avoid bpf_reg_state->parent update when
>   registers are copied, but it has some performance impact. If this
>   impact is acceptable I'd like to move this way are remove
>   mark_equal_scalars_as_read().
>=20
> - unrelated question: does anything has to be done to
>   __mark_chain_precision to make it know about shared scalar IDs?
>   E.g. in the following case:
>     ...
>   --- checkpoint 1 --- r6 would be marked as precise here
>   r6 =3D r7
>     ...
>   --- checkpoint 2 --- r6 won't be marked as precise here
>     ...
>   if r6 < 10
>   --- checkpoint 3 ---
>   fp[r7] =3D 42
>  =20
>   The additional precision marks could be inferred if additional info
>   is added the jump stack.
>=20
> -----
> Long version about bpf_reg_state->parent.
>=20
> All functions that copy register states:
> - save_register_state()
>   Register is copied to stack spill location.
>=20
> - check_kfunc_mem_size_reg()
>   Makes a tmp register copy, harmless.
>=20
> - sanitize_ptr_alu()
>   Register copy is visible in the speculative branch.
>=20
> - check_alu_op()
>   Register is copied when reg to reg MOV is processed.
>=20
> - find_equal_scalars()
>   Register is copied to the registers with the same ID.
>=20
> Original commit introducing bpf_reg_state->parent:
> - 679c782de14bd48c19dd74cd1af20a2bc05dd936 2018-08-30
>   bpf/verifier: per-register parent pointers
>  =20
>   Updates mark_reg_read() and removes mark_stack_slot_read().
>   Previous version accessed parent state registers directly using
>   regno w/o any additional manipulations.
>=20
>   In this commit:
>   - save_register_state() - does not exist yet, its function is
>     performed by check_stack_write(), has a direct register state copy
>     as in save_register_state();
>   - check_kfunc_mem_size_reg() - does not exist yet;
>   - sanitize_ptr_alu() - does not exist yet;
>   - check_alu_op() - has a direct register state copy unchanged for
>     reg to reg MOV.
>=20
> Commit introducing find_equal_scalars():
> - 75748837b7e56919679e02163f45d5818c644d03 2020-10-09
>   bpf: Propagate scalar ranges through register assignments.
>  =20
>   Has a direct register copy *reg =3D *known_reg.
>=20
> It looks like that for places where registers are copied ->parent
> change is an unintentional side effect. Removal of this side effect
> might in theory lead to some additional register read marks, e.g. in
> this case:
>=20
>   r6 =3D r7
>   if (r6 > X) goto +42
>   r5 =3D r7              ; this would lead to a read mark on r7 not
>                        ; present previously.
>=20

Upon detailed examination of the differences in tests behaviour with and wi=
thout
preserving register parentage chains I came up with the following test case=
:
{
	"write tracking and register parent chain bug",
	.insns =3D {
	/* r6 =3D ktime_get_ns() */
	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
	/* r0 =3D ktime_get_ns() */
	BPF_EMIT_CALL(BPF_FUNC_ktime_get_ns),
	/* if r0 > r6 goto +1 */
	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_6, 1),
	/* *(u64 *)(r10 - 8) =3D 0xdeadbeef */
	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 0xdeadbeef),
	/* r1 =3D 42 */
	BPF_MOV64_IMM(BPF_REG_1, 42),
	/* *(u8 *)(r10 - 8) =3D r1 */
	BPF_STX_MEM(BPF_B, BPF_REG_FP, BPF_REG_1, -8),
	/* r2 =3D *(u64 *)(r10 - 8) */
	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_FP, -8),
	/* exit(0) */
	BPF_MOV64_IMM(BPF_REG_0, 0),
	BPF_EXIT_INSN(),
	},
	.flags =3D BPF_F_TEST_STATE_FREQ,
	.errstr =3D "invalid read from stack off -8+1 size 8",
	.result =3D REJECT,
},
This test case is currently marked as safe, which is not true, because the
write of 0xdeadbeef to fp[-8] might be omitted. The bug is caused by tossin=
g
around the register parent pointers. So there is no real choice here, this
behaviour has to be changed.

I'll submit a separate patch shortly.


> This should not hinder correctness.
> However, there is some negative performance impact:
>=20
> $ ./veristat -e file,prog,states -f 'states_pct!=3D0' -C master-baseline.=
log current.log=20
> File                      Program                           States (A)  S=
tates (B)  States  (DIFF)
> ------------------------  --------------------------------  ----------  -=
---------  --------------
> bpf_host.o                cil_to_netdev                            358   =
      455   +97 (+27.09%)
> bpf_host.o                tail_handle_nat_fwd_ipv4                1746   =
     1891   +145 (+8.30%)
> bpf_host.o                tail_handle_nat_fwd_ipv6                 709   =
      717     +8 (+1.13%)
> bpf_host.o                tail_nodeport_ipv4_dsr                    31   =
       42   +11 (+35.48%)
> bpf_host.o                tail_nodeport_nat_egress_ipv4           2269   =
     2274     +5 (+0.22%)
> bpf_host.o                tail_nodeport_nat_ingress_ipv4           276   =
      316   +40 (+14.49%)
> bpf_host.o                tail_nodeport_nat_ingress_ipv6           243   =
      254    +11 (+4.53%)
> bpf_lxc.o                 tail_handle_nat_fwd_ipv4                1746   =
     1891   +145 (+8.30%)
> bpf_lxc.o                 tail_handle_nat_fwd_ipv6                 709   =
      717     +8 (+1.13%)
> bpf_lxc.o                 tail_ipv4_ct_egress                      248   =
      251     +3 (+1.21%)
> bpf_lxc.o                 tail_ipv4_ct_ingress                     248   =
      251     +3 (+1.21%)
> bpf_lxc.o                 tail_ipv4_ct_ingress_policy_only         248   =
      251     +3 (+1.21%)
> bpf_lxc.o                 tail_nodeport_ipv4_dsr                    31   =
       42   +11 (+35.48%)
> bpf_lxc.o                 tail_nodeport_nat_ingress_ipv4           276   =
      316   +40 (+14.49%)
> bpf_lxc.o                 tail_nodeport_nat_ingress_ipv6           243   =
      254    +11 (+4.53%)
> bpf_overlay.o             tail_handle_nat_fwd_ipv4                1082   =
     1109    +27 (+2.50%)
> bpf_overlay.o             tail_nodeport_ipv4_dsr                    31   =
       42   +11 (+35.48%)
> bpf_overlay.o             tail_nodeport_nat_egress_ipv4           2238   =
     2243     +5 (+0.22%)
> bpf_overlay.o             tail_nodeport_nat_ingress_ipv4           276   =
      316   +40 (+14.49%)
> bpf_overlay.o             tail_nodeport_nat_ingress_ipv6           243   =
      254    +11 (+4.53%)
> bpf_sock.o                cil_sock4_connect                         47   =
       64   +17 (+36.17%)
> bpf_sock.o                cil_sock4_sendmsg                         45   =
       62   +17 (+37.78%)
> bpf_xdp.o                 tail_handle_nat_fwd_ipv4                1461   =
     1912  +451 (+30.87%)
> bpf_xdp.o                 tail_lb_ipv4                            4643   =
     4738    +95 (+2.05%)
> bpf_xdp.o                 tail_nodeport_nat_egress_ipv4           1066   =
     1069     +3 (+0.28%)
> bpf_xdp.o                 tail_rev_nodeport_lb4                    404   =
      411     +7 (+1.73%)
> bpf_xdp.o                 tail_rev_nodeport_lb6                   1076   =
     1083     +7 (+0.65%)
> pyperf600_bpf_loop.bpf.o  on_event                                 285   =
      287     +2 (+0.70%)
> xdp_synproxy_kern.bpf.o   syncookie_tc                           22513   =
    22564    +51 (+0.23%)
> xdp_synproxy_kern.bpf.o   syncookie_xdp                          22207   =
    24206  +1999 (+9.00%)
> ------------------------  --------------------------------  ----------  -=
---------  --------------
>=20
> >=20
> > Well, that's what I wanted to ask, actually :)
> > Here is how current logic works:
> > - is_state_visited() has the following two loops in the end:
> >=20
> > 	for (j =3D 0; j <=3D cur->curframe; j++) {
> > 		for (i =3D j < cur->curframe ? BPF_REG_6 : 0; i < BPF_REG_FP; i++)
> > 			cur->frame[j]->regs[i].parent =3D &new->frame[j]->regs[i];
> > 		for (i =3D 0; i < BPF_REG_FP; i++)
> > 			cur->frame[j]->regs[i].live =3D REG_LIVE_NONE;
> > 	}
> >=20
> > 	/* all stack frames are accessible from callee, clear them all */
> > 	for (j =3D 0; j <=3D cur->curframe; j++) {
> > 		struct bpf_func_state *frame =3D cur->frame[j];
> > 		struct bpf_func_state *newframe =3D new->frame[j];
> >=20
> > 		for (i =3D 0; i < frame->allocated_stack / BPF_REG_SIZE; i++) {
> > 			frame->stack[i].spilled_ptr.live =3D REG_LIVE_NONE;
> > 			frame->stack[i].spilled_ptr.parent =3D
> > 						&newframe->stack[i].spilled_ptr;
> > 		}
> > 	}
> >=20
> >   These connect the bpf_reg_state members of the new state with
> >   corresponding (index-wise) members of the parent state.
> > - find_equal_scalars() looks as follows:
> >   static void find_equal_scalars(struct bpf_verifier_state *vstate,
> >                                struct bpf_reg_state *known_reg)
> >   {
> > 	struct bpf_func_state *state;
> > 	struct bpf_reg_state *reg;
> >=20
> > 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > 		if (reg->type =3D=3D SCALAR_VALUE && reg->id =3D=3D known_reg->id)
> > 			*reg =3D *known_reg;  // <--- full copy, incl. parent pointer
> > 	}));
> >   }
> > - mark_reg_read() updates the ->live field of the *parent* register
> >   when called only if ->live field of the *current* register is not
> >   marked as written.
> > - in case if register is overwritten it's ->live field is marked as
> >   written, e.g. see check_stack_read_fixed_off().
> >  =20
> > Suppose we have an example:
> >=20
> > ---- checkpoint ----
> > r1 =3D r0               ; now r1.parent =3D=3D &checkpoint->regs[0]
> > r2 =3D r1               ; now r2.parent =3D=3D &checkpoint->regs[0]
> > if (r1 =3D=3D 0) goto +42
> > ...
> >=20
> > Given the above logic only &checkpoint->regs[0] would receive read
> > marks. Although I'm not the original author but this behavior seem to
> > make sense.
> >=20
> > >=20
> > > > + *
> > > > + * Thus, for execution path 1-6:
> > > > + * - both r6->parent and r7->parent point to the same register in =
the parent state (r7);
> > > > + * - only *one* register in the checkpoint state would receive REG=
_LIVE_READ mark;
> > >=20
> > > I'm trying to understand this. Clearly both r6 and r7 are read. r6 fo=
r
> > > if (r6 > X) check, r7 for r9 manipulations. Why do we end up not
> > > marking one of them as read using a normal logic?
> >=20
> > When (r6 > X) is processed find_equal_scalars() updates parent
> > pointers for all registers with the same ID as r6, in this case only
> > for r7. So, after find_equal_scalars() is done both current state r6
> > and r7 ->parent point to the r6 of the latest checkpoint state.
> >=20
> > >=20
> > > I have this bad feeling I'm missing something very important here or
> > > we have some bug somewhere else. So please help me understand which
> > > one it is. This special liveness manipulation seems wrong.
> > >=20
> > > My concern is that if I have some code like
> > >=20
> > > r6 =3D r7;
> > > r9 +=3D r6;
> > >=20
> > > and I never use r7 anymore after that, then we should be able to
> > > forget r7 and treat it as NOT_INIT. But you are saying it's unsafe
> > > right now and that doesn't make much sense to me.
> >=20
> > It is unsafe because of the "spooky action at a distance" produced by
> > a combination of:
> > - allocation of scalar IDs for moves, see check_alu_op() case for
> >   64-bit move;
> > - find_equal_scalars() that propagates range, this one is only
> >   executed for conditional jumps.
> >=20
> > >=20
> > >=20
> > > > + * - clean_func_state() would remove r6 from checkpoint state (mar=
k it NOT_INIT).
> > > > + *
> > > > + * Consequently, when execution path 1-4, 6 reaches (6) in state (=
II)
> > > > + * regsafe() won't be able to see a mismatch in ID mappings.
> > > > + *
> > > > + * To avoid this issue mark_equal_scalars_as_read() conservatively
> > > > + * marks all registers with matching ID as REG_LIVE_READ, thus
> > > > + * preserving r6 and r7 in the checkpoint state for the example ab=
ove.
> > > > + */
> > > > +static void mark_equal_scalars_as_read(struct bpf_verifier_state *=
vstate, int id)
> > > > +{
> > > > +       struct bpf_verifier_state *st;
> > > > +       struct bpf_func_state *state;
> > > > +       struct bpf_reg_state *reg;
> > > > +       bool move_up;
> > > > +       int i =3D 0;
> > > > +
> > > > +       for (st =3D vstate, move_up =3D true; st && move_up; st =3D=
 st->parent) {
> > > > +               move_up =3D false;
> > > > +               bpf_for_each_reg_in_vstate(st, state, reg, ({
> > > > +                       if (reg->type =3D=3D SCALAR_VALUE && reg->i=
d =3D=3D id &&
> > > > +                           !(reg->live & REG_LIVE_READ)) {
> > > > +                               reg->live |=3D REG_LIVE_READ;
> > > > +                               move_up =3D true;
> > > > +                       }
> > > > +                       ++i;
> > > > +               }));
> > > > +       }
> > > > +}
> > > > +
> > > >  static void find_equal_scalars(struct bpf_verifier_state *vstate,
> > > >                                struct bpf_reg_state *known_reg)
> > > >  {
> > > >         struct bpf_func_state *state;
> > > >         struct bpf_reg_state *reg;
> > > > +       int count =3D 0;
> > > >=20
> > > >         bpf_for_each_reg_in_vstate(vstate, state, reg, ({
> > > > -               if (reg->type =3D=3D SCALAR_VALUE && reg->id =3D=3D=
 known_reg->id)
> > > > +               if (reg->type =3D=3D SCALAR_VALUE && reg->id =3D=3D=
 known_reg->id) {
> > > >                         *reg =3D *known_reg;
> > > > +                       ++count;
> > > > +               }
> > > >         }));
> > > > +
> > > > +       /* Count equal to 1 means that find_equal_scalars have not
> > > > +        * found any registers with the same ID (except self), thus
> > > > +        * the range knowledge have not been transferred and there =
is
> > > > +        * no need to preserve registers with the same ID in a pare=
nt
> > > > +        * state.
> > > > +        */
> > > > +       if (count > 1)
> > > > +               mark_equal_scalars_as_read(vstate->parent, known_re=
g->id);
> > > >  }
> > > >=20
> > > >  static int check_cond_jmp_op(struct bpf_verifier_env *env,
> > > > @@ -12878,6 +12950,12 @@ static bool regsafe(struct bpf_verifier_en=
v *env, struct bpf_reg_state *rold,
> > > >                  */
> > > >                 return equal && rold->frameno =3D=3D rcur->frameno;
> > > >=20
> > > > +       /* even if two registers are identical the id mapping might=
 diverge
> > > > +        * e.g. rold{.id=3D1}, rcur{.id=3D1}, idmap{1->2}
> > > > +        */
> > > > +       if (equal && rold->type =3D=3D SCALAR_VALUE && rold->id)
> > > > +               return check_ids(rold->id, rcur->id, idmap);
> > >=20
> > > nit: let's teach check_ids() to handle the id =3D=3D 0 case properly
> > > instead of guarding everything with `if (rold->id)`?
> > >=20
> > > but also I think this applies not just to SCALARs, right? the memcmp(=
)
> > > check above has to be augmented with check_ids() for id and ref_obj_i=
d
> >=20
> > Yes, it is the same issue as described in [1] as you pointed out.
> > I'll updated it for other branches, but I want the main issue to
> > be sorted out first.
> >=20
> > [1] https://lore.kernel.org/bpf/CAEf4BzbFB5g4oUfyxk9rHy-PJSLQ3h8q9mV=3D=
rVoXfr_JVm8+1Q@mail.gmail.com/
> >=20
> > >=20
> > > > +
> > > >         if (equal)
> > > >                 return true;
> > > >=20
> > > > @@ -12891,6 +12969,11 @@ static bool regsafe(struct bpf_verifier_en=
v *env, struct bpf_reg_state *rold,
> > > >                 if (env->explore_alu_limits)
> > > >                         return false;
> > > >                 if (rcur->type =3D=3D SCALAR_VALUE) {
> > > > +                       /* id relations must be preserved, see comm=
ent in
> > > > +                        * mark_equal_scalars_as_read() for SCALAR_=
VALUE example.
> > > > +                        */
> > > > +                       if (rold->id && !check_ids(rold->id, rcur->=
id, idmap))
> > > > +                               return false;
> > > >                         if (!rold->precise)
> > > >                                 return true;
> > > >                         /* new val must satisfy old val knowledge *=
/
> > > > --
> > > > 2.34.1
> > > >=20
> >=20
>=20

