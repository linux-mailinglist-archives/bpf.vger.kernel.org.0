Return-Path: <bpf+bounces-2080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A6D727447
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 03:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EE62815C2
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 01:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64447A51;
	Thu,  8 Jun 2023 01:26:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2F7F6
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 01:26:12 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8642103
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 18:26:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f629ccb8ebso135331e87.1
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 18:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686187568; x=1688779568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lKGlpXKDLoSYHfB3uM9TQnMe7P48kEJ/z1bNddPcfVI=;
        b=ghgjb+a6dHX3F0iES2IidrZOM8lmRRu27HKMeSfVYBd17G6AeD5a9UZjvgpkm17RXI
         F6b9lJcndJhvP4dw2G0VP6IAWTRzHnzxSvinsCr3yXeTBg7hVarkEOOCjB4sBZ0GAfFi
         MSx3GfF/z9WsEWA5cjIocHOPIR9/PDzTFgDFkkTXv7e7CATHRVUYfAbw7Onm8TGgjiWO
         V5ITlFeRf/Gqj8aKAx0Xcf8qkImdfO84GhXDJPIxE5JAX5JVppb75XVlLwOAbSYFuZwd
         fXf09rrhJuJU3c7U/cW7Oa+sAI3dzKoqLjbfY9OuZlEE1KQYgv9/pzTj3RN2MWKASg4Y
         cdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686187568; x=1688779568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKGlpXKDLoSYHfB3uM9TQnMe7P48kEJ/z1bNddPcfVI=;
        b=dKa6R8EpeTWmkJfe3OBx3OnRhZ+XsHAxG15clPM7KSyf8Sen//Gn15oxVxR/iKWpeQ
         OQdfvAgH5YNZgFC6IKM78CGrTWRzijUQ1BkX5ywsy+cD5DakU8I1sEDGRhxCY0rlbfuw
         pABNSEVOZsugKq24WiS1BCipxSoqYK5xmDJheJ5pVxntILHzwNohK6Ok/I9rix6ipBYk
         zqrBP3G2izybxaYqy+UI8B4KryJIvLGhngQavx3YT20gQE638zei2NS0nbp7zj+S/DVT
         qjs2PutxD6ACMLa8A0KIuys/APJV9AzfGqz7qi+A37RCHjz6LL8ZPCiCPIIzW+c0BxFo
         pf1A==
X-Gm-Message-State: AC+VfDy3nMLeux3i7mAcWMxS//WhxDcs+88cHHfdp1BhMr3SNCR9Tfvv
	u3S212NRRv1PMpE0iP1GAxA=
X-Google-Smtp-Source: ACHHUZ4gYoDU2qGf43MpoWfOz5RuaiwdUv0w38zrrfcttlolrFrZVOpP3WB8nsUNDdzKiGaeC/hyDw==
X-Received: by 2002:ac2:5a19:0:b0:4f6:2e4f:5054 with SMTP id q25-20020ac25a19000000b004f62e4f5054mr2642441lfn.40.1686187567725;
        Wed, 07 Jun 2023 18:26:07 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r10-20020ac252aa000000b004f3a1033078sm12171lfm.52.2023.06.07.18.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 18:26:07 -0700 (PDT)
Message-ID: <cc31b95783afa7dc8fb806c973f8420d22a49e58.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Date: Thu, 08 Jun 2023 04:26:06 +0300
In-Reply-To: <CAEf4BzbbGV6gTJ1KdBB8EwLWV3aNE-iyNtP2pC-W1=MTDNRq5Q@mail.gmail.com>
References: <20230606222411.1820404-1-eddyz87@gmail.com>
	 <20230606222411.1820404-4-eddyz87@gmail.com>
	 <CAEf4BzbbGV6gTJ1KdBB8EwLWV3aNE-iyNtP2pC-W1=MTDNRq5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-06-07 at 14:40 -0700, Andrii Nakryiko wrote:
> On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > Make sure that the following unsafe example is rejected by verifier:
> >=20
> > 1: r9 =3D ... some pointer with range X ...
> > 2: r6 =3D ... unbound scalar ID=3Da ...
> > 3: r7 =3D ... unbound scalar ID=3Db ...
> > 4: if (r6 > r7) goto +1
> > 5: r6 =3D r7
> > 6: if (r6 > X) goto ...
> > --- checkpoint ---
> > 7: r9 +=3D r7
> > 8: *(u64 *)r9 =3D Y
> >=20
> > This example is unsafe because not all execution paths verify r7 range.
> > Because of the jump at (4) the verifier would arrive at (6) in two stat=
es:
> > I.  r6{.id=3Db}, r7{.id=3Db} via path 1-6;
> > II. r6{.id=3Da}, r7{.id=3Db} via path 1-4, 6.
> >=20
> > Currently regsafe() does not call check_ids() for scalar registers,
> > thus from POV of regsafe() states (I) and (II) are identical. If the
> > path 1-6 is taken by verifier first, and checkpoint is created at (6)
> > the path [1-4, 6] would be considered safe.
> >=20
> > This commit updates regsafe() to call check_ids() for precise scalar
> > registers.
> >=20
> > To minimize the impact on verification performance, avoid generating
> > bpf_reg_state::id for constant scalar values when processing BPF_MOV
> > in check_alu_op(). Scalar IDs are utilized by find_equal_scalars() to
> > propagate information about value ranges for registers that hold the
> > same value. However, there is no need to propagate range information
> > for constants.
> >=20
> > Still, there is some performance impact because of this change.
> > Using veristat to compare number of processed states for selftests
> > object files listed in tools/testing/selftests/bpf/veristat.cfg and
> > Cilium object files from [1] gives the following statistics:
> >=20
> > $ ./veristat -e file,prog,states -f "states_pct>10" \
> >     -C master-baseline.log current.log
> > File         Program                         States  (DIFF)
> > -----------  ------------------------------  --------------
> > bpf_xdp.o    tail_handle_nat_fwd_ipv6        +155 (+23.92%)
> > bpf_xdp.o    tail_nodeport_nat_ingress_ipv4  +102 (+27.20%)
> > bpf_xdp.o    tail_rev_nodeport_lb4            +83 (+20.85%)
> > loop6.bpf.o  trace_virtqueue_add_sgs          +25 (+11.06%)
> >=20
> > Also test case verifier_search_pruning/allocated_stack has to be
> > updated to avoid conflicts in register ID assignments between cached
> > and new states.
> >=20
> > [1] git@github.com:anakryiko/cilium.git
> >=20
> > Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register ass=
ignments.")
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
>=20
> So I checked it also on our internal BPF object files, and it looks
> mostly good. Here are the only regressions:
>=20
> Program                                   States (A)  States (B)
> States   (DIFF)
> ----------------------------------------  ----------  ----------
> ---------------
> balancer_ingress                               29219       34531
> +5312 (+18.18%)
> syar_bind6_protect6                             3257        3599
> +342 (+10.50%)
> syar_bind4_protect4                             2590        2931
> +341 (+13.17%)
> on_alloc                                         415         526
> +111 (+26.75%)
> on_free                                          406         517
> +111 (+27.34%)
> pycallcount                                      395         506
> +111 (+28.10%)
> resume_context                                   405         516
> +111 (+27.41%)
> on_py_event                                      395         506
> +111 (+28.10%)
> on_event                                         284         394
> +110 (+38.73%)
> handle_cuda_event                                268         378
> +110 (+41.04%)
> handle_cuda_launch                               276         386
> +110 (+39.86%)
> handle_cuda_malloc_ret                           272         382
> +110 (+40.44%)
> handle_cuda_memcpy                               270         380
> +110 (+40.74%)
> handle_cuda_memcpy_async                         270         380
> +110 (+40.74%)
> handle_pytorch_allocate_ret                      271         381
> +110 (+40.59%)
> handle_pytorch_malloc_ret                        272         382
> +110 (+40.44%)
> on_event                                         284         394
> +110 (+38.73%)
> on_event                                         284         394
> +110 (+38.73%)
> syar_task_enter_execve                           309         329
> +20 (+6.47%)
> kprobe__security_inode_link                      968         986
> +18 (+1.86%)
> kprobe__security_inode_symlink                   838         854
> +16 (+1.91%)
> tw_twfw_egress                                   249         251
> +2 (+0.80%)
> tw_twfw_ingress                                  250         252
> +2 (+0.80%)
> tw_twfw_tc_eg                                    248         250
> +2 (+0.81%)
> tw_twfw_tc_in                                    250         252
> +2 (+0.80%)
> raw_tracepoint__sched_process_exec               136         139
> +3 (+2.21%)
> kprobe_ret__do_filp_open                         869         871
> +2 (+0.23%)
> read_erlang_stack                                572         573
> +1 (+0.17%)
>=20
>=20
> They are mostly on small-ish programs. The only mild concern from my
> side is balancer_ingress, which is one of Katran BPF programs. It add
> +18% of states (which translates to about 70K more instructions
> verified, up from 350K). I think we can live with this, but would be
> nice to check why it's happening.

Thank you for reviewing this series.

I looked at the logs that you've shared, the difference is indeed
caused by some scalar registers having a unique ID in cached state and
no ID in current state or vice versa. The !rold->id trick that we
discussed for V2 helps :)

What do you think about an alternative way to exclude unique scalars
as in the patch below? (on top of this patch-set):

--- 8< -------------------------

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 235d7eded565..ece9722dff3b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15149,6 +15149,13 @@ static bool check_ids(u32 old_id, u32 cur_id, stru=
ct bpf_id_pair *idmap)
        return false;
 }
=20
+static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_verifier_e=
nv *env)
+{
+       old_id =3D old_id ? old_id : env->id_gen++;
+       cur_id =3D cur_id ? cur_id : env->id_gen++;
+       return check_ids(old_id, cur_id, env->idmap_scratch);
+}
+
 static void clean_func_state(struct bpf_verifier_env *env,
                             struct bpf_func_state *st)
 {
@@ -15325,7 +15332,7 @@ static bool regsafe(struct bpf_verifier_env *env, s=
truct bpf_reg_state *rold,
                 */
                return range_within(rold, rcur) &&
                       tnum_in(rold->var_off, rcur->var_off) &&
-                      check_ids(rold->id, rcur->id, idmap);
+                      check_scalar_ids(rold->id, rcur->id, env);
        case PTR_TO_MAP_KEY:
        case PTR_TO_MAP_VALUE:
        case PTR_TO_MEM:

------------------------- >8 ---

For me this patch removes all veristat differences compared to the
master. If doing it for real, I'd like to reset env->id_gen at exit
from states_equal() to the value it had at entry (to avoid allocating
too many ids).

>=20
> I suspect that dropping SCALAR IDs as we discussed (after fixing
> register fill/spill ID generation) might completely mitigate that.
>=20
> Overall, LGTM:
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>=20
> >  kernel/bpf/verifier.c                         | 34 ++++++++++++++++---
> >  .../bpf/progs/verifier_search_pruning.c       |  3 +-
> >  2 files changed, 32 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 2aa60b73f1b5..175ca22b868e 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12933,12 +12933,14 @@ static int check_alu_op(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn)
> >                 if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> >                         struct bpf_reg_state *src_reg =3D regs + insn->=
src_reg;
> >                         struct bpf_reg_state *dst_reg =3D regs + insn->=
dst_reg;
> > +                       bool need_id =3D (src_reg->type =3D=3D SCALAR_V=
ALUE && !src_reg->id &&
> > +                                       !tnum_is_const(src_reg->var_off=
));
> >=20
>=20
> nit: unnecessary outer ()
>=20
> >                         if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
> >                                 /* case: R1 =3D R2
> >                                  * copy register state to dest reg
> >                                  */
> > -                               if (src_reg->type =3D=3D SCALAR_VALUE &=
& !src_reg->id)
> > +                               if (need_id)
> >                                         /* Assign src and dst registers=
 the same ID
> >                                          * that will be used by find_eq=
ual_scalars()
> >                                          * to propagate min/max range.
>=20
> [...]


