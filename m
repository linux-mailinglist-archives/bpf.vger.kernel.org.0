Return-Path: <bpf+bounces-1369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7219A714170
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 02:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDBC280DCD
	for <lists+bpf@lfdr.de>; Mon, 29 May 2023 00:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCEE627;
	Mon, 29 May 2023 00:59:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D37C
	for <bpf@vger.kernel.org>; Mon, 29 May 2023 00:59:40 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3467ABB
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 17:59:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2afb2874e83so28920391fa.0
        for <bpf@vger.kernel.org>; Sun, 28 May 2023 17:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685321976; x=1687913976;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aW5PIz1OQIsqy+vxPfknWC3w+3Ulq7yGZfrBoWe2HV8=;
        b=m1/B1APfYcN1gQXvfov91AVPKhT5SK7CJ/sPh6/TBm+akFaqdbHd7FPvBwCZ1xC6V/
         cyVa3xhm32vBxof7NdISvETxRgXpAm1dZRxNW5ChKD0MI9F8d5Pcnxl/GEOC0lC7JFu7
         lT8RBdWEMjipGivg0sWkSfVyE3daoUrLLtWd5UU2s8WXBGx7glX5EPhH0M0tK88y9rOB
         e5WUmbQ9Kqd8/lRDushA87/nHwIEZReCO1RTntJ/7Y1mEWxRGInkld9SshVYwnBJYtth
         YmWJYu2FqZLHkTNnTaudoXFVP2yC7JixE8RhW8fpRqLFn7u3Jby5ohcxQ8Q+CQLSRYAV
         q/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685321976; x=1687913976;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aW5PIz1OQIsqy+vxPfknWC3w+3Ulq7yGZfrBoWe2HV8=;
        b=Je6ncSVR/rlvlGa3Az6T+1AeZifcK2hs32ids3oO9l/Z+uMG/hppaVHnH1YAziVcAv
         G7hXcBAl/UyvzjM3c91TjGwCaVWRdmN+0svm1LtNkakLmkZuaimpNmKbDuBRNJnQkhl5
         ou83dpNvUn+eeKjm7FVCEbW1lF5w7gyfS/Au/HWE0ickPDyacUrnShfz/38ZEjRHuo5Z
         0iHCpyp1EaKcybmSlpDr/WF96Gj4Txfa8u6OGIUlSrfXKOjbx6VkYDsExoeYZr6VRboA
         LwqofOC/mHSNeZ01CxYdMLxeDXRWHeoToBJfgUhP3k0vS+UPhpneWfYR5yjst+pN1qd2
         aNrg==
X-Gm-Message-State: AC+VfDygu3fS81wNBXw8cJ18HTKbFYM4Cq9mVu+0rg95JcCq2Eim2Pjv
	qjZ0isN7WkXz8N4ZLIlC/pg=
X-Google-Smtp-Source: ACHHUZ5hrzW0QkKmpGDZQMIVtgSrZI8ZYU0cY1zjfNz0uvTiylkUkWio5is9TyWYUH2snPzEdHLRPA==
X-Received: by 2002:a2e:9115:0:b0:2a8:b27f:b721 with SMTP id m21-20020a2e9115000000b002a8b27fb721mr3225659ljg.29.1685321975994;
        Sun, 28 May 2023 17:59:35 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z4-20020a05651c022400b002aa3cff0529sm2213867ljn.74.2023.05.28.17.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 17:59:35 -0700 (PDT)
Message-ID: <7c3381a3dbff95232e8cdf796990e9e43cc489fd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yhs@fb.com
Date: Mon, 29 May 2023 03:59:33 +0300
In-Reply-To: <9fe005ca-ee56-f852-33fe-24381da8bc04@meta.com>
References: <20230526184126.3104040-1-eddyz87@gmail.com>
	 <20230526184126.3104040-2-eddyz87@gmail.com>
	 <ecc663f1-d8c1-0ccd-a226-00888aeee83b@meta.com>
	 <0900f41a57683ce0f55ee46435bf393f36ea24cd.camel@gmail.com>
	 <eef495be92934cab0b6ee60a71a22a9b755d1777.camel@gmail.com>
	 <9fe005ca-ee56-f852-33fe-24381da8bc04@meta.com>
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

On Sat, 2023-05-27 at 16:43 -0700, Yonghong Song wrote:
>=20
> On 5/27/23 5:29 AM, Eduard Zingerman wrote:
> > On Sat, 2023-05-27 at 15:21 +0300, Eduard Zingerman wrote:
> > [...]
> > > > > @@ -15151,6 +15153,33 @@ static bool regsafe(struct bpf_verifier_=
env *env, struct bpf_reg_state *rold,
> > > > >   =20
> > > > >    	switch (base_type(rold->type)) {
> > > > >    	case SCALAR_VALUE:
> > > > > +		/* Why check_ids() for precise registers?
> > > > > +		 *
> > > > > +		 * Consider the following BPF code:
> > > > > +		 *   1: r6 =3D ... unbound scalar, ID=3Da ...
> > > > > +		 *   2: r7 =3D ... unbound scalar, ID=3Db ...
> > > > > +		 *   3: if (r6 > r7) goto +1
> > > > > +		 *   4: r6 =3D r7
> > > > > +		 *   5: if (r6 > X) goto ...
> > > > > +		 *   6: ... memory operation using r7 ...
> > > > > +		 *
> > > > > +		 * First verification path is [1-6]:
> > > > > +		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6=
 and r7;
> > > > > +		 * - at (5) r6 would be marked <=3D X, find_equal_scalars() wo=
uld also mark
> > > > > +		 *   r7 <=3D X, because r6 and r7 share same id.
> > > > > +		 *
> > > > > +		 * Next verification path would start from (5), because of the=
 jump at (3).
> > > > > +		 * The only state difference between first and second visits o=
f (5) is
> > > > > +		 * bpf_reg_state::id assignments for r6 and r7: (b, b) vs (a, =
b).
> > > > > +		 * Thus, use check_ids() to distinguish these states.
> > > > > +		 *
> > > > > +		 * The `rold->precise` check is a performance optimization. If=
 `rold->id`
> > > > > +		 * was ever used to access memory / predict jump, the `rold` o=
r any
> > > > > +		 * register used in `rold =3D r?` / `r? =3D rold` operations w=
ould be marked
> > > > > +		 * as precise, otherwise it's ID is not really interesting.
> > > > > +		 */
> > > > > +		if (rold->precise && rold->id && !check_ids(rold->id, rcur->id=
, idmap))
> > > >=20
> > > > Do we need rold->id checking in the above? check_ids should have
> > > > rold->id =3D 0 properly. Or this is just an optimization?
> > >=20
> > > You are correct, the check_ids() handles this case and it should be i=
nlined,
> > > so there is no need to check rold->id in this 'if' branch.
> > >  =20
> > > > regs_exact() has check_ids as well. Not sure whether it makes sense=
 to
> > > > create a function regs_exact_scalar() just for scalar and include t=
he
> > > > above code. Otherwise, it is strange we do check_ids in different
> > > > places.
> > >=20
> > > I'm not sure how to best re-organize code here, regs_exact() is a nic=
e
> > > compartmentalized abstraction. It is possible to merge my additional
> > > check_ids() call with the main 'precise' processing part as below:
> > >=20
> > > @@ -15152,21 +15154,22 @@ static bool regsafe(struct bpf_verifier_env=
 *env, struct bpf_reg_state *rold,
> > >          switch (base_type(rold->type)) {
> > >          case SCALAR_VALUE:
> > >                  if (regs_exact(rold, rcur, idmap))
> > >                          return true;
> > >                  if (env->explore_alu_limits)
> > >                          return false;
> > >                  if (!rold->precise)
> > >                          return true;
> > >                  /* new val must satisfy old val knowledge */
> > >                  return range_within(rold, rcur) &&
> > > -                      tnum_in(rold->var_off, rcur->var_off);
> > > +                      tnum_in(rold->var_off, rcur->var_off) &&
> > > +                      check_ids(rold->id, rcur->id, idmap);
> > >=20
> > > I'd say that extending /* new val must satisfy ... */ comment to
> > > explain why check_ids() is needed should be sufficient, but I'm open
> > > for suggestions.
> >=20
> > On the other hand, I wanted to have a separate 'if' branch like:
> >=20
> >    if (rold->precise && !check_ids(rold->id, rcur->id, idmap))
> >   =20
> > Specifically to explain that 'rold->precise' part is an optimization.
>=20
> Okay, I think you could keep your original implementation. I do think
> checking rold->ref_obj_id in regs_exact is not needed for
> SCALAR_VALUE but it may not be that important. The check_ids
> checking in reg_exact (for SCALAR_VALUE) can also be skipped
> if !rold->precise as an optimization. That is why I mention
> to 'inline' regs_exact and re-arrange the codes. You can still
> mention that optimization w.r.t. rold->precise. Overall if the code
> is more complex, I am okay with your current change.

I thought a bit more about this and came up with example that doesn't
work with 'rold->precise' case:

        /* Bump allocated stack */
 1:     r1 =3D 0;
        *(u64*)(r10 - 8) =3D r1;
        /* r9 =3D pointer to stack */
 2:     r9 =3D r10;
 3:     r9 +=3D -8;
        /* r8 =3D ktime_get_ns() */
 4:     call %[bpf_ktime_get_ns];
 5:     r8 =3D r0;
        /* r7 =3D ktime_get_ns() */
 6:     call %[bpf_ktime_get_ns];
 7:     r7 =3D r0;
        /* r6 =3D ktime_get_ns() */
 8:     call %[bpf_ktime_get_ns];
 9:     r6 =3D r0;
        /* scratch .id from r0 */
 10:    r0 =3D 0;
        /* if r6 > r7 is an unpredictable jump */
 11:    if r6 > r7 goto l1;
        /* tie r6 and r7 .id */
 12:    r6 =3D r7;
    l0:
        /* if r7 > 4 exit(0) */
 13:    if r7 > 4 goto l2;
        /* access memory at r9[r6] */
 14:    r9 +=3D r6;
 15:    r0 =3D *(u8*)(r9 + 0);
    l2:
 16:    r0 =3D 0;
 17:    exit;
    l1:
        /* tie r6 and r8 .id */
 18:    r6 =3D r8;
 19:    goto l0;
   =20
This example is marked as safe, however it isn't.
What happens:
(a) path 1-17 is verified first, it is marked safe
  - when 14 is processed mark_chain_precision() is called with regno set to=
 r6;
  - moving backwards mark_chain_precision() does *not* mark r7 as precise a=
t 13
    because mark_chain_precision() does not track register ids;
  - thus, for checkpiont at 13 only r6 is marked as precise.
(b) path 1-11, 18-19, 13-17 is verified next:
  - when insn 13 is processed the saved checkpiont is examined,
    the only precise register is r6, so check_ids() is called only
    for r6 and it returns true =3D> checkpiont is considered safe.

However, in reality register ID assignments differ between (a) and (b) at i=
nsn 13:
(a) r6{id=3DA}, r7{id=3DA}, r8{id=3DB}
(b) r6{id=3DB}, r7{id=3DA}, r8{id=3DB}
   =20
So, simplest and safest change is as follows:

  @@ -15152,4 +15154,6 @@ static bool regsafe(struct bpf_verifier_env *env,=
 struct bpf_reg_state *rold,
          switch (base_type(rold->type)) {
          case SCALAR_VALUE:
  +               if (!check_ids(rold->id, rcur->id, idmap))
  +                       return false;
                  if (regs_exact(rold, rcur, idmap))
                          return true;

Here regsafe() does not care about rold->precise marks,
thus differences between (a) and (b) would be detected by check_ids,
as all three registers r{6,7,8} would be fed to it.

However, it is also costly (note the filter by 40% processed states increas=
e or more):

$ ./veristat -e file,prog,states -f 'states_pct>40' -C master-baseline.log =
current.log=20
File         Program                        States (A)  States (B)  States =
 (DIFF)
-----------  -----------------------------  ----------  ----------  -------=
-------
bpf_host.o   cil_from_host                          37          52   +15 (+=
40.54%)
bpf_host.o   cil_from_netdev                        28          46   +18 (+=
64.29%)
bpf_host.o   tail_handle_ipv4_from_host            225         350  +125 (+=
55.56%)
bpf_host.o   tail_handle_ipv4_from_netdev          109         173   +64 (+=
58.72%)
bpf_host.o   tail_handle_ipv6_from_host            250         387  +137 (+=
54.80%)
bpf_host.o   tail_handle_ipv6_from_netdev          132         194   +62 (+=
46.97%)
bpf_host.o   tail_ipv4_host_policy_ingress         103         167   +64 (+=
62.14%)
bpf_host.o   tail_ipv6_host_policy_ingress          98         160   +62 (+=
63.27%)
bpf_xdp.o    __send_drop_notify                      8          14    +6 (+=
75.00%)
bpf_xdp.o    tail_handle_nat_fwd_ipv6              648         971  +323 (+=
49.85%)
loop6.bpf.o  trace_virtqueue_add_sgs               226         357  +131 (+=
57.96%)

I'll modify mark_chain_precision() to mark registers precise taking
into account scalar IDs, when comparisons are processed.
Will report on Monday.

>=20
> >=20
> > >=20
> > > >=20
> > > > > + return false; > > > > if (regs_exact(rold, rcur, idmap)) >
> > > > return true; > > > > if (env->explore_alu_limits)
> > >=20
> >=20


