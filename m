Return-Path: <bpf+bounces-2142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309E2728795
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 21:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6901C2084F
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582361F164;
	Thu,  8 Jun 2023 19:05:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E40C14ABB
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 19:05:28 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5425F2D40
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 12:05:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f63ab1ac4aso1188611e87.0
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 12:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686251121; x=1688843121;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qv31MMmt8wevec3BjajFBgUe+JMtilRAcdNZ0s6yQ2o=;
        b=iu20ZgVdKis66rjzvIfP28FJ7bQlnzHo6V7ZwQXCCg3ltL4kHUgjN3GjnC1BTK+X1I
         EhBm5xrPIfS9EMX8Q+gUmL3HXR/w5sPwcU4krOaIV3FL2A83M4YKJ3hJTYfX1BRT4DAQ
         mPpKrYLyTdqkFCfVwxZBorF4tnMAo2ot3UMaHTMaBO48MwLp8nGKHwl5UbRQWBbJsSXa
         jGGojxIFtPkJ9c2Uy21pzzO3H6MvlC0ULNu2B/keDaWS99afETM49H408Bj9gdkTglPA
         h9ylJpP+Gdl1BiMfGUtlgq3B5z/FPP9Ck1ttHhA3sP+JSnEFDeRzYrX9b/1IlWBjemic
         dl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686251121; x=1688843121;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qv31MMmt8wevec3BjajFBgUe+JMtilRAcdNZ0s6yQ2o=;
        b=Plb0nbyfQRDUZ46uldtg380pLFSy/td1A1BkaGT1qDinccI7b+V96SpJUBR/Y2KMc1
         pOvw1UT783b0Rq/wejRftNV/KePUfaxNyYWskclicmnYhG4xHJ/sV0oRh3TZp49eWAVD
         UJ0oVd+QbLHCB9npD0BVlu7/uMahm7Me0ov5VG1+PFhkYRrCFIu+kyhNjAeUKd7l8qzo
         OOhhI9LUk9pij6xapdPEfpNWuAkf2jhm3LVJXLJF23mw69vZgWqvEeZ+d/XdjF4jdsCL
         NtKf2HC2F0d1QvZZLUYBmuFyT4NrdgUEHGhmheLX+cF0UsSzLDdaPs6LDiJgVUfgLj9/
         GlUw==
X-Gm-Message-State: AC+VfDzgtR0o1bqzZsXWYQFHFAQm6fqNU3z+OuZ9/GMi1nsKL+aKvQLw
	LtER/CZEY0xb1rJTQDK9m/gqKXzkaP6VUQ==
X-Google-Smtp-Source: ACHHUZ4bPW57h+TwOlZhbEMVgUpMJanjRo8TQfuHebuu4tCHZaUz/PQrVmRZUDJhmnCP0Cka+2gLyA==
X-Received: by 2002:a19:da11:0:b0:4f6:1504:f93c with SMTP id r17-20020a19da11000000b004f61504f93cmr18517lfg.66.1686251121123;
        Thu, 08 Jun 2023 12:05:21 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t9-20020ac24c09000000b004f38411f148sm273748lfq.84.2023.06.08.12.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:05:20 -0700 (PDT)
Message-ID: <5bb3a6c3daf8c36a88eae6d0a3a8e52d7b24f842.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Thu, 08 Jun 2023 22:05:19 +0300
In-Reply-To: <CAEf4Bzaj6K4UuLQU-eRPWQt+nnyXwj_-yf9NAyqMkW-fc1m0OA@mail.gmail.com>
References: <20230606222411.1820404-1-eddyz87@gmail.com>
	 <20230606222411.1820404-4-eddyz87@gmail.com>
	 <CAEf4BzbbGV6gTJ1KdBB8EwLWV3aNE-iyNtP2pC-W1=MTDNRq5Q@mail.gmail.com>
	 <cc31b95783afa7dc8fb806c973f8420d22a49e58.camel@gmail.com>
	 <CAEf4Bzaj6K4UuLQU-eRPWQt+nnyXwj_-yf9NAyqMkW-fc1m0OA@mail.gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-06-08 at 10:21 -0700, Andrii Nakryiko wrote:
> On Wed, Jun 7, 2023 at 6:26=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Wed, 2023-06-07 at 14:40 -0700, Andrii Nakryiko wrote:
> > > On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >=20
> > > > Make sure that the following unsafe example is rejected by verifier=
:
> > > >=20
> > > > 1: r9 =3D ... some pointer with range X ...
> > > > 2: r6 =3D ... unbound scalar ID=3Da ...
> > > > 3: r7 =3D ... unbound scalar ID=3Db ...
> > > > 4: if (r6 > r7) goto +1
> > > > 5: r6 =3D r7
> > > > 6: if (r6 > X) goto ...
> > > > --- checkpoint ---
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
> > > > path 1-6 is taken by verifier first, and checkpoint is created at (=
6)
> > > > the path [1-4, 6] would be considered safe.
> > > >=20
> > > > This commit updates regsafe() to call check_ids() for precise scala=
r
> > > > registers.
> > > >=20
> > > > To minimize the impact on verification performance, avoid generatin=
g
> > > > bpf_reg_state::id for constant scalar values when processing BPF_MO=
V
> > > > in check_alu_op(). Scalar IDs are utilized by find_equal_scalars() =
to
> > > > propagate information about value ranges for registers that hold th=
e
> > > > same value. However, there is no need to propagate range informatio=
n
> > > > for constants.
> > > >=20
> > > > Still, there is some performance impact because of this change.
> > > > Using veristat to compare number of processed states for selftests
> > > > object files listed in tools/testing/selftests/bpf/veristat.cfg and
> > > > Cilium object files from [1] gives the following statistics:
> > > >=20
> > > > $ ./veristat -e file,prog,states -f "states_pct>10" \
> > > >     -C master-baseline.log current.log
> > > > File         Program                         States  (DIFF)
> > > > -----------  ------------------------------  --------------
> > > > bpf_xdp.o    tail_handle_nat_fwd_ipv6        +155 (+23.92%)
> > > > bpf_xdp.o    tail_nodeport_nat_ingress_ipv4  +102 (+27.20%)
> > > > bpf_xdp.o    tail_rev_nodeport_lb4            +83 (+20.85%)
> > > > loop6.bpf.o  trace_virtqueue_add_sgs          +25 (+11.06%)
> > > >=20
> > > > Also test case verifier_search_pruning/allocated_stack has to be
> > > > updated to avoid conflicts in register ID assignments between cache=
d
> > > > and new states.
> > > >=20
> > > > [1] git@github.com:anakryiko/cilium.git
> > > >=20
> > > > Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register=
 assignments.")
> > > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > ---
> > >=20
> > > So I checked it also on our internal BPF object files, and it looks
> > > mostly good. Here are the only regressions:
> > >=20
> > > Program                                   States (A)  States (B)
> > > States   (DIFF)
> > > ----------------------------------------  ----------  ----------
> > > ---------------
> > > balancer_ingress                               29219       34531
> > > +5312 (+18.18%)
> > > syar_bind6_protect6                             3257        3599
> > > +342 (+10.50%)
> > > syar_bind4_protect4                             2590        2931
> > > +341 (+13.17%)
> > > on_alloc                                         415         526
> > > +111 (+26.75%)
> > > on_free                                          406         517
> > > +111 (+27.34%)
> > > pycallcount                                      395         506
> > > +111 (+28.10%)
> > > resume_context                                   405         516
> > > +111 (+27.41%)
> > > on_py_event                                      395         506
> > > +111 (+28.10%)
> > > on_event                                         284         394
> > > +110 (+38.73%)
> > > handle_cuda_event                                268         378
> > > +110 (+41.04%)
> > > handle_cuda_launch                               276         386
> > > +110 (+39.86%)
> > > handle_cuda_malloc_ret                           272         382
> > > +110 (+40.44%)
> > > handle_cuda_memcpy                               270         380
> > > +110 (+40.74%)
> > > handle_cuda_memcpy_async                         270         380
> > > +110 (+40.74%)
> > > handle_pytorch_allocate_ret                      271         381
> > > +110 (+40.59%)
> > > handle_pytorch_malloc_ret                        272         382
> > > +110 (+40.44%)
> > > on_event                                         284         394
> > > +110 (+38.73%)
> > > on_event                                         284         394
> > > +110 (+38.73%)
> > > syar_task_enter_execve                           309         329
> > > +20 (+6.47%)
> > > kprobe__security_inode_link                      968         986
> > > +18 (+1.86%)
> > > kprobe__security_inode_symlink                   838         854
> > > +16 (+1.91%)
> > > tw_twfw_egress                                   249         251
> > > +2 (+0.80%)
> > > tw_twfw_ingress                                  250         252
> > > +2 (+0.80%)
> > > tw_twfw_tc_eg                                    248         250
> > > +2 (+0.81%)
> > > tw_twfw_tc_in                                    250         252
> > > +2 (+0.80%)
> > > raw_tracepoint__sched_process_exec               136         139
> > > +3 (+2.21%)
> > > kprobe_ret__do_filp_open                         869         871
> > > +2 (+0.23%)
> > > read_erlang_stack                                572         573
> > > +1 (+0.17%)
> > >=20
> > >=20
> > > They are mostly on small-ish programs. The only mild concern from my
> > > side is balancer_ingress, which is one of Katran BPF programs. It add
> > > +18% of states (which translates to about 70K more instructions
> > > verified, up from 350K). I think we can live with this, but would be
> > > nice to check why it's happening.
> >=20
> > Thank you for reviewing this series.
> >=20
> > I looked at the logs that you've shared, the difference is indeed
> > caused by some scalar registers having a unique ID in cached state and
> > no ID in current state or vice versa. The !rold->id trick that we
> > discussed for V2 helps :)
> >=20
> > What do you think about an alternative way to exclude unique scalars
> > as in the patch below? (on top of this patch-set):
> >=20
> > --- 8< -------------------------
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 235d7eded565..ece9722dff3b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15149,6 +15149,13 @@ static bool check_ids(u32 old_id, u32 cur_id, =
struct bpf_id_pair *idmap)
> >         return false;
> >  }
> >=20
> > +static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_verifi=
er_env *env)
> > +{
> > +       old_id =3D old_id ? old_id : env->id_gen++;
> > +       cur_id =3D cur_id ? cur_id : env->id_gen++;
> > +       return check_ids(old_id, cur_id, env->idmap_scratch);
> > +}
> > +
> >  static void clean_func_state(struct bpf_verifier_env *env,
> >                              struct bpf_func_state *st)
> >  {
> > @@ -15325,7 +15332,7 @@ static bool regsafe(struct bpf_verifier_env *en=
v, struct bpf_reg_state *rold,
> >                  */
> >                 return range_within(rold, rcur) &&
> >                        tnum_in(rold->var_off, rcur->var_off) &&
> > -                      check_ids(rold->id, rcur->id, idmap);
> > +                      check_scalar_ids(rold->id, rcur->id, env);
> >         case PTR_TO_MAP_KEY:
> >         case PTR_TO_MAP_VALUE:
> >         case PTR_TO_MEM:
> >=20
> > ------------------------- >8 ---
> >=20
> > For me this patch removes all veristat differences compared to the
> > master. If doing it for real, I'd like to reset env->id_gen at exit
> > from states_equal() to the value it had at entry (to avoid allocating
> > too many ids).
>=20
> Hm.. It's clever and pretty minimal, I like it. We are basically
> allocating virtual ID for SCALAR that doesn't have id, just to make
> sure we get a conflict if the SCALAR with ID cannot be mapped into two
> different SCALARs, right?
>=20
> The only question would be if it's safe to do that for case when
> old_reg->id !=3D 0 and cur_reg->id =3D=3D 0? E.g., if in old (verified)
> state we have r6.id =3D r7.id =3D 123, and in new state we have r6.id =3D=
 0
> and r7.id =3D 0, then your implementation above will say that states are
> equivalent. But are they, given there is a link between r6 and r7 that
> might be required for correctness. Which we don't have in current
> state.

You mean the other way around, rold.id =3D=3D 0, rcur.id !=3D 0, right?
(below 0/2 means: original value 0, replaced by new id 2).

(1)   old cur
r6.id 0/2   1
r7.id 0/3   1 check_ids returns true

(2)   old cur
r6.id 1   0/2
r7.id 1   0/3 check_ids returns false

Also, (1) is no different from (3):

(3)   old cur
r6.id 1     3
r7.id 2     3 check_ids returns true

Current check:

		if (!rold->precise)
			return true;
		return range_within(rold, rcur) &&
		       tnum_in(rold->var_off, rcur->var_off) &&
		       check_ids(rold->id, rcur->id, idmap);

Will reject (1) and (2), but will accept (3).

New check:

		if (!rold->precise)
			return true;
		return range_within(rold, rcur) &&
		       tnum_in(rold->var_off, rcur->var_off) &&
		       check_scalar_ids(rold->id, rcur->id, idmap);

Will reject (2), but will accept (1) and (3).

And modification of check_scalar_ids() to generate IDs only for rold
or only for rcur would not reject (3) either.

(3) would be rejected only if current check is used together with
elimination of unique scalar IDs from old states.

My previous experiments show that eliminating unique IDs from old
states and not eliminating unique IDs from cur states is *very* bad
for performance.

>=20
> So with this we are getting to my original concerns with your
> !rold->id approach, which tries to ignore the necessity of link
> between registers.
>=20
> What if we do this only for old registers? Then, (in old state) r6.id
> =3D 0, r7.id =3D 0, (in new state) r6.id =3D r7.id =3D 123. This will be
> rejected because first we'll map 123 to newly allocated X for r6.id,
> and then when we try to match r7.id=3D123 to another allocated ID X+1
> we'll get a conflict, right?
>=20
> >=20
> > >=20
> > > I suspect that dropping SCALAR IDs as we discussed (after fixing
> > > register fill/spill ID generation) might completely mitigate that.
> > >=20
> > > Overall, LGTM:
> > >=20
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > >=20
> > > >  kernel/bpf/verifier.c                         | 34 +++++++++++++++=
+---
> > > >  .../bpf/progs/verifier_search_pruning.c       |  3 +-
> > > >  2 files changed, 32 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 2aa60b73f1b5..175ca22b868e 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -12933,12 +12933,14 @@ static int check_alu_op(struct bpf_verifi=
er_env *env, struct bpf_insn *insn)
> > > >                 if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> > > >                         struct bpf_reg_state *src_reg =3D regs + in=
sn->src_reg;
> > > >                         struct bpf_reg_state *dst_reg =3D regs + in=
sn->dst_reg;
> > > > +                       bool need_id =3D (src_reg->type =3D=3D SCAL=
AR_VALUE && !src_reg->id &&
> > > > +                                       !tnum_is_const(src_reg->var=
_off));
> > > >=20
> > >=20
> > > nit: unnecessary outer ()
> > >=20
> > > >                         if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)=
 {
> > > >                                 /* case: R1 =3D R2
> > > >                                  * copy register state to dest reg
> > > >                                  */
> > > > -                               if (src_reg->type =3D=3D SCALAR_VAL=
UE && !src_reg->id)
> > > > +                               if (need_id)
> > > >                                         /* Assign src and dst regis=
ters the same ID
> > > >                                          * that will be used by fin=
d_equal_scalars()
> > > >                                          * to propagate min/max ran=
ge.
> > >=20
> > > [...]
> >=20


