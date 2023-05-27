Return-Path: <bpf+bounces-1351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F92C7134A7
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 14:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B002817EB
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEC011C91;
	Sat, 27 May 2023 12:22:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7DAD31
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 12:22:06 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90AFE1
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 05:22:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4eed764a10cso1764587e87.0
        for <bpf@vger.kernel.org>; Sat, 27 May 2023 05:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685190122; x=1687782122;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=beH7Eu3eqO1sEDzB2abrKFKcYhHfq9YgaNQ4WJz1Ydg=;
        b=grWX/d+dCFxy+JrKwxMd0wbsHCPJkcnXgd2xkzwhK4Sl42xf6QCqcrRSFdM3sPTd4M
         oLIsOuBlrYJqSqdyC+nwfs3ckJvL9K3redtYzxrd3Wl+c9CkbKnhOgclBgn8cuO5M299
         VlN/fhQ/eNWjX5vlQ38ZE5Rq7OgqwZMMDuSb0H4ia9Ceppr6S0z/e5YMjFlYFnAtP3fm
         I1QHNKSxa25EQwkloR+H701dQA5Qs5OaX0nvnNi8H9qHdYSBzwUe+mXY6W0SVojVfld7
         YCq/5tuG07cGeXsFHetEwi4VwBvekcGbJGRN08pokijz/LKiM7ElAKlCGyzBsGeITA2j
         ktdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685190122; x=1687782122;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=beH7Eu3eqO1sEDzB2abrKFKcYhHfq9YgaNQ4WJz1Ydg=;
        b=ZYfCwPxPTrXo5MT0Jv5ffRV6OsJzTyTy/JlUo8ps657DePe2d4i+06KzogS1bbNORQ
         FsrY+HXvwlo0sjeD+FpgHY3SZb0thNmFzW8J95eSAJJUh2g4Eas1MXNtW3D03sh/A+uC
         JzhQQuOIFGiFAnSclyAF5Y9hlxHtauNX1VKVqq3dTA83phKjj9b/Zx0V8B3oj88+6q6m
         oX1Qq0ky5gLnrWC0VMkHPhAX4KkFyXHXVBjceg9smJ3TOIgzbTLIJGsrcYGO95PNb/xB
         lFntcqrXi7qGEO7kkUM72YWLdLKDjsu9q/W7oudCO9mGkD+4C9aBgISNWmw+gZZ+UV1f
         WD9Q==
X-Gm-Message-State: AC+VfDwvjzpiU7053mUj5PQrveEYNEx1MWSpQSCZVxFyM6AtPe8xJTlj
	bT4S88Wk92+YQNEhw6oiuuCMHo8azZc=
X-Google-Smtp-Source: ACHHUZ7vV9GmoELKVjay0CFqgSwZsy8Pr/ujbqgfAOeQZPD1A/M++k/3908mACiMvmKbfIn2blrhHA==
X-Received: by 2002:a19:a416:0:b0:4f3:b520:e0af with SMTP id q22-20020a19a416000000b004f3b520e0afmr1312776lfc.13.1685190121754;
        Sat, 27 May 2023 05:22:01 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y16-20020ac255b0000000b004f252a753e1sm1108413lfg.22.2023.05.27.05.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 05:22:01 -0700 (PDT)
Message-ID: <0900f41a57683ce0f55ee46435bf393f36ea24cd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yhs@fb.com
Date: Sat, 27 May 2023 15:21:59 +0300
In-Reply-To: <ecc663f1-d8c1-0ccd-a226-00888aeee83b@meta.com>
References: <20230526184126.3104040-1-eddyz87@gmail.com>
	 <20230526184126.3104040-2-eddyz87@gmail.com>
	 <ecc663f1-d8c1-0ccd-a226-00888aeee83b@meta.com>
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

On Fri, 2023-05-26 at 17:40 -0700, Yonghong Song wrote:
>=20
> On 5/26/23 11:41 AM, Eduard Zingerman wrote:
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
> > This commit updates regsafe() to call check_ids() for scalar registers.
> >=20
> > The change in check_alu_op() to avoid assigning scalar id to constants
> > is performance optimization. W/o it the regsafe() change becomes
> > costly for some programs, e.g. for
> > tools/testing/selftests/bpf/progs/pyperf600.c the difference is:
> >=20
> > File             Program   States (A)  States (B)  States    (DIFF)
> > ---------------  --------  ----------  ----------  ----------------
> > pyperf600.bpf.o  on_event       22200       37060  +14860 (+66.94%)
> >=20
> > Where A -- this patch,
> >        B -- this patch but w/o check_alu_op() changes.
> >=20
> > Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register ass=
ignments.")
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >   kernel/bpf/verifier.c | 31 ++++++++++++++++++++++++++++++-
> >   1 file changed, 30 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index af70dad655ab..624556eda430 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12806,10 +12806,12 @@ static int check_alu_op(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn)
> >   				/* case: R1 =3D R2
> >   				 * copy register state to dest reg
> >   				 */
> > -				if (src_reg->type =3D=3D SCALAR_VALUE && !src_reg->id)
> > +				if (src_reg->type =3D=3D SCALAR_VALUE && !src_reg->id &&
> > +				    !tnum_is_const(src_reg->var_off))
> >   					/* Assign src and dst registers the same ID
> >   					 * that will be used by find_equal_scalars()
> >   					 * to propagate min/max range.
> > +					 * Skip constants to avoid allocation of useless ID.
> >   					 */
>=20
> The above is for ALU64.
>=20
> We also have ALU32 version:
>     } else if (src_reg->type =3D=3D SCALAR_VALUE) {
>         bool is_src_reg_u32 =3D src_reg->umax_value <=3D U32_MAX;
>=20
>         if (is_src_reg_u32 && !src_reg->id)
>               src_reg->id =3D ++env->id_gen;
>         copy_register_state(dst_reg, src_reg);
>         ...
>=20
> Do you think we should do the same thing if src_reg is a constant,
> not to change src_reg->id?

This is a good point, thank you. Adding the same check for 32-bit case
actually helps with the verifier performance a bit:

$ ./veristat -e file,prog,states -f 'insns_pct>1' -C master-baseline.log cu=
rrent.log
File       Program                         States (A)  States (B)  States (=
DIFF)
---------  ------------------------------  ----------  ----------  --------=
-----
bpf_xdp.o  tail_handle_nat_fwd_ipv6               648         660   +12 (+1=
.85%)
bpf_xdp.o  tail_nodeport_nat_ingress_ipv4         375         455  +80 (+21=
.33%)
bpf_xdp.o  tail_rev_nodeport_lb4                  398         472  +74 (+18=
.59%)

(all +1% - +3% cases from the cover letter are gone).

> If this is added, could you have a test case for 32-bit subregister
> as well?

I will add the 32-bit test case.

>=20
> >   					src_reg->id =3D ++env->id_gen;
> >   				copy_register_state(dst_reg, src_reg);
> > @@ -15151,6 +15153,33 @@ static bool regsafe(struct bpf_verifier_env *e=
nv, struct bpf_reg_state *rold,
> >  =20
> >   	switch (base_type(rold->type)) {
> >   	case SCALAR_VALUE:
> > +		/* Why check_ids() for precise registers?
> > +		 *
> > +		 * Consider the following BPF code:
> > +		 *   1: r6 =3D ... unbound scalar, ID=3Da ...
> > +		 *   2: r7 =3D ... unbound scalar, ID=3Db ...
> > +		 *   3: if (r6 > r7) goto +1
> > +		 *   4: r6 =3D r7
> > +		 *   5: if (r6 > X) goto ...
> > +		 *   6: ... memory operation using r7 ...
> > +		 *
> > +		 * First verification path is [1-6]:
> > +		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and r=
7;
> > +		 * - at (5) r6 would be marked <=3D X, find_equal_scalars() would al=
so mark
> > +		 *   r7 <=3D X, because r6 and r7 share same id.
> > +		 *
> > +		 * Next verification path would start from (5), because of the jump =
at (3).
> > +		 * The only state difference between first and second visits of (5) =
is
> > +		 * bpf_reg_state::id assignments for r6 and r7: (b, b) vs (a, b).
> > +		 * Thus, use check_ids() to distinguish these states.
> > +		 *
> > +		 * The `rold->precise` check is a performance optimization. If `rold=
->id`
> > +		 * was ever used to access memory / predict jump, the `rold` or any
> > +		 * register used in `rold =3D r?` / `r? =3D rold` operations would b=
e marked
> > +		 * as precise, otherwise it's ID is not really interesting.
> > +		 */
> > +		if (rold->precise && rold->id && !check_ids(rold->id, rcur->id, idma=
p))
>=20
> Do we need rold->id checking in the above? check_ids should have=20
> rold->id =3D 0 properly. Or this is just an optimization?

You are correct, the check_ids() handles this case and it should be inlined=
,
so there is no need to check rold->id in this 'if' branch.
=20
> regs_exact() has check_ids as well. Not sure whether it makes sense to
> create a function regs_exact_scalar() just for scalar and include the
> above code. Otherwise, it is strange we do check_ids in different
> places.

I'm not sure how to best re-organize code here, regs_exact() is a nice
compartmentalized abstraction. It is possible to merge my additional
check_ids() call with the main 'precise' processing part as below:

@@ -15152,21 +15154,22 @@ static bool regsafe(struct bpf_verifier_env *env,=
 struct bpf_reg_state *rold,
        switch (base_type(rold->type)) {
        case SCALAR_VALUE:
                if (regs_exact(rold, rcur, idmap))
                        return true;
                if (env->explore_alu_limits)
                        return false;
                if (!rold->precise)
                        return true;
                /* new val must satisfy old val knowledge */
                return range_within(rold, rcur) &&
-                      tnum_in(rold->var_off, rcur->var_off);
+                      tnum_in(rold->var_off, rcur->var_off) &&
+                      check_ids(rold->id, rcur->id, idmap);

I'd say that extending /* new val must satisfy ... */ comment to
explain why check_ids() is needed should be sufficient, but I'm open
for suggestions.

>=20
> > +			return false;
> >   		if (regs_exact(rold, rcur, idmap))
> >   			return true;
> >   		if (env->explore_alu_limits)


