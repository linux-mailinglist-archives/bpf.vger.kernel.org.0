Return-Path: <bpf+bounces-1353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10527134B4
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 14:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599B71C20F90
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 12:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19A111C9C;
	Sat, 27 May 2023 12:29:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9FD52C
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 12:29:58 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB1210A
	for <bpf@vger.kernel.org>; Sat, 27 May 2023 05:29:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f3b5881734so1901635e87.0
        for <bpf@vger.kernel.org>; Sat, 27 May 2023 05:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685190595; x=1687782595;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M+kwVZO6Xk9nR1jfdMicGRfrp8fhGb6XfuE7a8jLcxw=;
        b=fI8AtENYY02wKlV6cxS3g/U94FcyrlY105xgU1Sjdnl0+PDgDNUGMSm/U8Lgsg00MM
         NkHDEIiDSGECNoEZE64YyR7ocGnxCNJwFrHlpNdMgEossPAFx5EGOKlmUcYaQt+wlKuk
         N6eU9WjW4v62GP7NhB5k+UBjYPa3jkZQ9K+oZ0II68xW1rjA0x0hro787rGzW/sYET0d
         FeSiy4qk3ZHUkLMVCXmioN/uZxUfrdm1PuGVEzXYFqzL84BGLXNALG7wdQePoGcWrzYZ
         re8dGZn3BTo9cPPhR8VfF0/M2GaZNdsCYnZkHrDdO7iQbxeuXdTz4JdnrUJSg1FeDd8o
         X1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685190595; x=1687782595;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+kwVZO6Xk9nR1jfdMicGRfrp8fhGb6XfuE7a8jLcxw=;
        b=hmlLxRzgwy/v+MOwmkt4CoIxILMI2rW9+IC0i23VwpZiHk0QrviEcL6zBJlhCsR27T
         sxwcg6pkK4x2BCnBKJzij67qDxg+sVrxmemRq1CQ0nmRoQ7bGgfJ5yPMu79nzrlcAINN
         eqPdaNMOYul3X9MaJm/oJeJE5rv37Eil9yYGvH5RiAEnWx4psh53CCA0ehvdFub6BuRi
         V2nVwmRQoqWLsF0DGCRjO5QwWqXbW/0p71qb6gcHMCLjn+QddITgo86snLFptqQq16iZ
         8NH2+D0ZtP5pr3a4eB9KM8LH+G4kCdSBxtT0N32KKooepjWO1UNUU328hv+/NV6irpVg
         jDwQ==
X-Gm-Message-State: AC+VfDyanDlxSz6C+AkkUv1rqpLKiVSWMNdnGhBI/MQAJGrpAbxvdTCF
	69a6wyN2hexWWxdAg+V5Vbo=
X-Google-Smtp-Source: ACHHUZ4z3fYaKhEnE3JIbyKTsQpbKw0rPQ/VqniI5r8IddgkewmJ2Tl5D+KQaMGyx87d3IjrMrn5Mw==
X-Received: by 2002:ac2:4959:0:b0:4eb:3b4c:50ac with SMTP id o25-20020ac24959000000b004eb3b4c50acmr1666533lfi.65.1685190594572;
        Sat, 27 May 2023 05:29:54 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i18-20020ac25d32000000b004eae73a0530sm1108241lfb.39.2023.05.27.05.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 05:29:54 -0700 (PDT)
Message-ID: <eef495be92934cab0b6ee60a71a22a9b755d1777.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yhs@fb.com
Date: Sat, 27 May 2023 15:29:53 +0300
In-Reply-To: <0900f41a57683ce0f55ee46435bf393f36ea24cd.camel@gmail.com>
References: <20230526184126.3104040-1-eddyz87@gmail.com>
	 <20230526184126.3104040-2-eddyz87@gmail.com>
	 <ecc663f1-d8c1-0ccd-a226-00888aeee83b@meta.com>
	 <0900f41a57683ce0f55ee46435bf393f36ea24cd.camel@gmail.com>
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

On Sat, 2023-05-27 at 15:21 +0300, Eduard Zingerman wrote:
[...]
> > > @@ -15151,6 +15153,33 @@ static bool regsafe(struct bpf_verifier_env =
*env, struct bpf_reg_state *rold,
> > >  =20
> > >   	switch (base_type(rold->type)) {
> > >   	case SCALAR_VALUE:
> > > +		/* Why check_ids() for precise registers?
> > > +		 *
> > > +		 * Consider the following BPF code:
> > > +		 *   1: r6 =3D ... unbound scalar, ID=3Da ...
> > > +		 *   2: r7 =3D ... unbound scalar, ID=3Db ...
> > > +		 *   3: if (r6 > r7) goto +1
> > > +		 *   4: r6 =3D r7
> > > +		 *   5: if (r6 > X) goto ...
> > > +		 *   6: ... memory operation using r7 ...
> > > +		 *
> > > +		 * First verification path is [1-6]:
> > > +		 * - at (4) same bpf_reg_state::id (b) would be assigned to r6 and=
 r7;
> > > +		 * - at (5) r6 would be marked <=3D X, find_equal_scalars() would =
also mark
> > > +		 *   r7 <=3D X, because r6 and r7 share same id.
> > > +		 *
> > > +		 * Next verification path would start from (5), because of the jum=
p at (3).
> > > +		 * The only state difference between first and second visits of (5=
) is
> > > +		 * bpf_reg_state::id assignments for r6 and r7: (b, b) vs (a, b).
> > > +		 * Thus, use check_ids() to distinguish these states.
> > > +		 *
> > > +		 * The `rold->precise` check is a performance optimization. If `ro=
ld->id`
> > > +		 * was ever used to access memory / predict jump, the `rold` or an=
y
> > > +		 * register used in `rold =3D r?` / `r? =3D rold` operations would=
 be marked
> > > +		 * as precise, otherwise it's ID is not really interesting.
> > > +		 */
> > > +		if (rold->precise && rold->id && !check_ids(rold->id, rcur->id, id=
map))
> >=20
> > Do we need rold->id checking in the above? check_ids should have=20
> > rold->id =3D 0 properly. Or this is just an optimization?
>=20
> You are correct, the check_ids() handles this case and it should be inlin=
ed,
> so there is no need to check rold->id in this 'if' branch.
> =20
> > regs_exact() has check_ids as well. Not sure whether it makes sense to
> > create a function regs_exact_scalar() just for scalar and include the
> > above code. Otherwise, it is strange we do check_ids in different
> > places.
>=20
> I'm not sure how to best re-organize code here, regs_exact() is a nice
> compartmentalized abstraction. It is possible to merge my additional
> check_ids() call with the main 'precise' processing part as below:
>=20
> @@ -15152,21 +15154,22 @@ static bool regsafe(struct bpf_verifier_env *en=
v, struct bpf_reg_state *rold,
>         switch (base_type(rold->type)) {
>         case SCALAR_VALUE:
>                 if (regs_exact(rold, rcur, idmap))
>                         return true;
>                 if (env->explore_alu_limits)
>                         return false;
>                 if (!rold->precise)
>                         return true;
>                 /* new val must satisfy old val knowledge */
>                 return range_within(rold, rcur) &&
> -                      tnum_in(rold->var_off, rcur->var_off);
> +                      tnum_in(rold->var_off, rcur->var_off) &&
> +                      check_ids(rold->id, rcur->id, idmap);
>=20
> I'd say that extending /* new val must satisfy ... */ comment to
> explain why check_ids() is needed should be sufficient, but I'm open
> for suggestions.

On the other hand, I wanted to have a separate 'if' branch like:

  if (rold->precise && !check_ids(rold->id, rcur->id, idmap))
 =20
Specifically to explain that 'rold->precise' part is an optimization.

>=20
> >=20
> > > +			return false;
> > >   		if (regs_exact(rold, rcur, idmap))
> > >   			return true;
> > >   		if (env->explore_alu_limits)
>=20


