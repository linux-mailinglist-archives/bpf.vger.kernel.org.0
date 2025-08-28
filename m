Return-Path: <bpf+bounces-66844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EBAB3A660
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53195681B0C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A146F1D63D8;
	Thu, 28 Aug 2025 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSyBrpCc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B82D7DF2
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398645; cv=none; b=clV+vU4N50vZkOnUCQCtV5yP5Gu7P9Sbu2VWPcsW49yatAPohio7aefoqbX3MaOf4Fpf4oVNu6MJup4EWZ9E5XuL3RHf9Tmu5tWJGXgDEStbt7wJJ9Y+xmr1hXfPlIRyN/0GX11/a8GS58RweW1rksUVrBYmM76TBu9muGQG8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398645; c=relaxed/simple;
	bh=m76LxAMVQtchw4dmA6Hl9B7zkXnysj8+K01WAkKXkyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fgwZ9kCm8s6klR/Ux+OQgjkImCQ/GU1lC94/z+xyMmOD4hxpq/FNgthqZ/a+TwQ1hwywhDKTH52w758d3jK7zW5Wy8r20SB3OdvBkXzBnBigs+c2Dn/rEssanfDBUUn9WjfG7dXHcRfshOQNx3UoOQMqxDI2sykrUV3+7TTm+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSyBrpCc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-771facea122so617780b3a.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398643; x=1757003443; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Usu7y368Lc2y8DATX0pLsJ9QOflnSrERzqyjwRyi6OI=;
        b=iSyBrpCcT40tIuDQ3ogL40rtcAxe5c2QPn6Dfl+kYh0x4qNdPHijfLSKqvRWtTa4OV
         E7rDCyo0DUCwVLih2wqWua5aLO0fCoJmb21epAzSgj5I4HTqwlVXSAR4Cs2lTCFZGB3s
         /vigA34vY+s8sratXbctOaID05TkqA32gz/hbkSlnGqwQ2+vFH6fmaQH+9wp7kJuszR5
         JlUvQ0s5bXrDvBdNWHQPplX7S/UyGwYFxyk9qBkuu3wWoGCINxbc+2Vq7hGhA/2VkCFZ
         5CvfSYVp4kpFix9NcJ8uz9UPNG1eMaYae0ctxZv17kKa+I59+KV72yzZZ5h953X/L6D6
         YO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398643; x=1757003443;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Usu7y368Lc2y8DATX0pLsJ9QOflnSrERzqyjwRyi6OI=;
        b=QB5hLkr2CkuyGQeeTHNxPpvrKB23mDDUuW+kz07QgHJQo980G21UKwom2rH+cx9gOK
         nD7PYQ0UvD+5fNH+Kr2JBGPnHkNg4Mct2oqLyxr3dt+xMfpbOUsqEStZ/ghU8Iw5mDms
         zM0FgoFhalGngqbG3O1TlE2zoP1PpI/9xDNhblJe8u8nKlC820SYD+apFvq5yvv3fRY+
         +WiNMru/HbssbuOwM0SbCc0Y0K4bQWr93TPejqjUijo9AU2KZO2MGPlRP8faZHvkYZVK
         6akTDwphR5IVYdQH/jMiENY/RljfrR3ipx63kyhVgT3Smd3q5FfxiNHklhx02QXiPKHC
         X/aA==
X-Gm-Message-State: AOJu0YxXYZWx2HVwvFXsUwQgfNivXnaRW2qsm7awIqp0LLj/WULIq23m
	3wzyBbq4Kl6cdHnl1nn+0Pru3zrt44ViGwEZfyQ29Hm3OMViK9++agBW
X-Gm-Gg: ASbGncswBXmgNNtcF+vooG1KEXLNjmwO01sleogmzZow6+NrdBpzEG2Azu5a0IBWqAE
	Udk9uqO7kX4fHCir1fe2sj599AfljuSnduB3+bNnAEJjVjwbvobj0qwAq7OKNTzHaFEO32+K9oN
	e+KMzzE1FJFPV5PD0spwcPWWF0iVFjUGToNnCaBOCxu/3iO5xE0WdVTIFJsEgao8Bl6H+GPjjUR
	JkmFCncveAnA0YDHuHtIadiXctaEFOXTA98275gtverviHuLTjcxzbCVPakQkiiZVN7U5JodSSp
	Xiswwrvv1ZBoLp2MJbD6DGQylxl4APsuLsLL6naowlm/LX3nfKw4oE/vmo5Da9mB0X1tbmU0RHd
	VT/0yuEUMD0wWbCMAHSQZ/YzL8JFJsiio+YI6KWo307arHhyqpt9oQFQ=
X-Google-Smtp-Source: AGHT+IH9dE01qGx1SnskrJB8kdvOgO85SPK6r2UXnqrMx1DpUOgZwfWLzhrJ2RlvOfZ2jYX/+IiWeA==
X-Received: by 2002:a05:6a20:3ca8:b0:243:78a:8284 with SMTP id adf61e73a8af0-24340dc8587mr32993607637.60.1756398642697;
        Thu, 28 Aug 2025 09:30:42 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:92b8:1b31:4fe2:f? ([2620:10d:c090:500::5:b3bf])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbbbbf5asm14444010a12.50.2025.08.28.09.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:30:42 -0700 (PDT)
Message-ID: <08cb366465da990279460c1d56b2fb4492c45cf5.camel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 08/11] bpf, x86: add support for indirect
 jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Thu, 28 Aug 2025 09:30:40 -0700
In-Reply-To: <aLAoUK22+PpuAbhy@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
	 <20250816180631.952085-9-a.s.protopopov@gmail.com>
	 <506e9593cf15c388ddfd4feaf89053c1e469b078.camel@gmail.com>
	 <aLAoUK22+PpuAbhy@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 09:58 +0000, Anton Protopopov wrote:

[...]

> > > @@ -16943,7 +17016,8 @@ static int check_ld_imm(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn)
> > >  		}
> > >  		dst_reg->type =3D PTR_TO_MAP_VALUE;
> > >  		dst_reg->off =3D aux->map_off;
> > > -		WARN_ON_ONCE(map->max_entries !=3D 1);
> > > +		WARN_ON_ONCE(map->map_type !=3D BPF_MAP_TYPE_INSN_ARRAY &&
> > > +			     map->max_entries !=3D 1);
> >=20
> > Q: when is this necessary?
>=20
> For all maps except INSN_ARRAY only (map->max_entries =3D=3D 1) is
> allowed. This change adds an exception for INSN_ARRAY.

I see, thank you for explaining.

[...]

> > > +static int cmp_ptr_to_u32(const void *a, const void *b)
> > > +{
> > > +	return *(u32 *)a - *(u32 *)b;
> > > +}
> >=20
> > This will overflow for e.g. `0 - 8`.
>=20
> Why? 0U - 8U =3D 0xfffffff8U (it's not an UB because values are
> unsigned).  Then it's cast to int on return which is -8.

Uh-oh. Ok, looks like this works.

[...]

> > > +static int jt_from_subprog(struct bpf_verifier_env *env,
> > > +			   int subprog_start,
> > > +			   int subprog_end,
> > > +			   struct jt *jt)
> > > +{
> > > +	struct bpf_map *map;
> > > +	struct jt jt_cur;
> > > +	u32 *off;
> > > +	int err;
> > > +	int i;
> > > +
> > > +	jt->off =3D NULL;
> > > +	jt->off_cnt =3D 0;
> > > +
> > > +	for (i =3D 0; i < env->insn_array_map_cnt; i++) {
> > > +		/*
> > > +		 * TODO (when needed): collect only jump tables, not static keys
> > > +		 * or maps for indirect calls
> > > +		 */
> > > +		map =3D env->insn_array_maps[i];
> > > +
> > > +		err =3D jt_from_map(map, &jt_cur);
> > > +		if (err) {
> > > +			kvfree(jt->off);
> > > +			return err;
> > > +		}
> > > +
> > > +		/*
> > > +		 * This is enough to check one element. The full table is
> > > +		 * checked to fit inside the subprog later in create_jt()
> > > +		 */
> > > +		if (jt_cur.off[0] >=3D subprog_start && jt_cur.off[0] < subprog_en=
d) {
> >=20
> > This won't always catch cases when insn array references offsets from
> > several subprograms. Also is one subprogram limitation really necessary=
?
>=20
> This was intentional. If you have a switch or a jump table
> defined in C, then corresponding jump tables belong to one function.
> Also, what if you have a jt which can jump from function f() to g(),
> but then g() is livepatched by another function?

Ok, yes, for gotox such limitation makes sense.

[...]

> > > @@ -18679,6 +19000,10 @@ static bool regsafe(struct bpf_verifier_env =
*env, struct bpf_reg_state *rold,
> > >  		return regs_exact(rold, rcur, idmap) && rold->frameno =3D=3D rcur-=
>frameno;
> > >  	case PTR_TO_ARENA:
> > >  		return true;
> > > +	case PTR_TO_INSN:
> > > +		/* cur =E2=8A=86 old */
> >=20
> > Out of curiosity: are unicode symbols allowed in kernel source code?
>=20
> I've replaced with words, don't see other examples of unicode around
> (but also can't find "don't use unicode" in coding-style.rst).

Personally, I like unicode symbols :)

> > > +		return (rcur->min_index >=3D rold->min_index &&
> > > +			rcur->max_index <=3D rold->max_index);
> > >  	default:
> > >  		return regs_exact(rold, rcur, idmap);
> > >  	}
> > > @@ -19825,6 +20150,67 @@ static int process_bpf_exit_full(struct bpf_=
verifier_env *env,
> > >  	return PROCESS_BPF_EXIT;
> > >  }
> > > =20
> > > +/* gotox *dst_reg */
> > > +static int check_indirect_jump(struct bpf_verifier_env *env, struct =
bpf_insn *insn)
> > > +{

[...]

> > > +	if (dst_reg->max_index >=3D map->max_entries) {
> > > +		verbose(env, "BPF_JA|BPF_X R%d is out of map boundaries: index=3D%=
u, max_index=3D%u\n",
> > > +				insn->dst_reg, dst_reg->max_index, map->max_entries-1);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	xoff =3D kvcalloc(dst_reg->max_index - dst_reg->min_index + 1, size=
of(u32), GFP_KERNEL_ACCOUNT);
> > > +	if (!xoff)
> > > +		return -ENOMEM;
> > > +
> > > +	n =3D copy_insn_array_uniq(map, dst_reg->min_index, dst_reg->max_in=
dex, xoff);
> >=20
> > Nit: I'd avoid this allocation and do a loop for(i =3D min_index; i <=
=3D max_index; i++),
> >      with map->ops->map_lookup_elem(map, &i) (or a wrapper) inside it.
>=20
> But it should be a list of unique values, how would you sort it
> without allocating memory (in a reqsonable time)?

Because of the push_state() loop below, right?
Makes sense.

> > > +	if (n < 0) {
> > > +		err =3D n;
> > > +		goto free_off;
> > > +	}
> > > +	if (n =3D=3D 0) {
> > > +		verbose(env, "register R%d doesn't point to any offset in map id=
=3D%d\n",
> > > +			     insn->dst_reg, map->id);
> > > +		err =3D -EINVAL;
> > > +		goto free_off;
> > > +	}
> > > +
> > > +	for (i =3D 0; i < n - 1; i++) {
> > > +		other_branch =3D push_stack(env, xoff[i], env->insn_idx, false);
> > > +		if (IS_ERR(other_branch)) {
> > > +			err =3D PTR_ERR(other_branch);
> > > +			goto free_off;
> > > +		}
> > > +	}
> > > +	env->insn_idx =3D xoff[n-1];
> > > +
> > > +free_off:
> > > +	kvfree(xoff);
> > > +	return err;
> > > +}
> > > +

[...]

