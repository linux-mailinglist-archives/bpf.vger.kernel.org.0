Return-Path: <bpf+bounces-76666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DFFCC09E2
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 075A7301E932
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C192E8881;
	Tue, 16 Dec 2025 02:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI60THRW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2017722097
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 02:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765852738; cv=none; b=XIBYA0CthKtDM2SixowFoAalQNEHGKY6b7cXQsCB3G6/F1anvl5mnIuL67JPoGQv6Ftg9/CYXeJ8syQ4NJCgGnpS95il6taUXydVs0fUbNitCn+P60Bpv2MCjmE5MLN1nILB0ysTCBCFFjf9KopbBnUdmi/Il7DsO+TcoCj6DUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765852738; c=relaxed/simple;
	bh=CRqvv3fNFlF/pMhl/fYHATl3VT03MbTVoZsGl5GO+QA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZoxPd1CzNNPvPLvsd0OPHiTFwHcARNyouStOESVuYKbqme1N/+3+GmEHkkZ7aJSjLFvtp8ve2mQNTB7IWjgXernECYgVXmDcmob+o275wTx0LAuTmbOKy49+zdFVbsePz/9kmcwCW9LmWldap83lvFnIWD5EWQTJUpvWPi+qFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI60THRW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so4312450b3a.2
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 18:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765852736; x=1766457536; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PFYZGHPIDqEcscjEAD6wlaUMrMUa0OQ70xZuQLsYAvQ=;
        b=KI60THRWvUfwjZyfazfiOG3enHDWoYijAokjxAqVpx4IL7nsdSmsqS/mxGYpC89QkG
         WXOZ8jTxlOhxLYQwAd6JGB1RKV2lEienrcMv2dX0ht65qsRhrXtPB9samXUejzxBwczh
         HrFDux3KXLJi27iZPYh+6+JelljLCzz1/QCogkkfXlu7N9+DrfkewbjSclTi1XeaH3kL
         LrSIeDPH8YV/rArcldbF01ZPnwniCLf8W+xo10wAi3M4UzWa/jy5IgezhxUMP6giddIN
         3S2biSdvx0n97qmxWa/oVHxocGg1le8OhrMNO7u/CCyHzWvMncXCIaElFvkuMIo5YvsM
         vWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765852736; x=1766457536;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFYZGHPIDqEcscjEAD6wlaUMrMUa0OQ70xZuQLsYAvQ=;
        b=WSokbBEHw987uP6l2PVJ82M7PuXfZF5pInsLmP7eQMcbL2OcP1r8Ik6maVN5C3FiTI
         e43JV1KdMvC6LjQoxBvaFcx2YLwBvPUXcvv8v/ZRjLWE86KH5ByotlPfSMSjoASiLAIJ
         zD5yYy6L0WLxATeXXsw5KP+Yc9O2TcfSl6viv1gkPCM6XnwMA1Ixg869KSZywCzqDHu6
         xLWA0Tqjea8F1js0MSsr283go87fn4zGQQmuuiyguk43uHr/p7j++MM3euTFza/x0pZf
         vhKXdepx1j0pY/NFyLgU9Imw/QkX8peUrj8MugsWjJXAhTHYWqkBPeWif7onDD7kg2On
         zkBA==
X-Gm-Message-State: AOJu0Yz66sOyE2Qk7p44tvO7tZqgt1hGrA31llkXevS31mHfzVacDSxJ
	/DhWypBluLPr7IWvbjYg5EZT0fni0QMUS38AONdiBLeL5MXeKKWTFmZrFOrRxv1z
X-Gm-Gg: AY/fxX67itiLS8jjCMw5j/mL+NBl+msrbqN+OqG2M72N3LOs6Zrjf6gPgvTR98KPOno
	CbEDguuoGNXGxg4KEM/YE5kv7/khDz+Jl54LNE9dxI0mrkGOkRTyxW7518VBOXyu6G7+KEthyHw
	JMTji+wL7wiU6QaA7uZICKc3TNAqc9JPXpx9fWvJN5oMuX6bhcFf7Rv4iVRvjNwX/WY3w5o9Xgf
	tUBmxPEQSAimPBLI5DfYvFVUTYg3wbuepK8fp8Hs6KjSM0FtZXV7uB9PH0dKU9cldtEDPSdzMUY
	sXyleSbxnfLF1UTtYNUYBIErDtGGgdNkXuKpv64IvV0mnATYqOgjjzT4IoXyoMpZ3afUCiuMmkp
	vGRhOB1mW44efSayawtstZiG/yHoG2Wsd+NpDoSwYLX3V/M30EsAMP3vFSmfsSYohtYcx0qKffO
	5C8Of/hdKe
X-Google-Smtp-Source: AGHT+IHEIg3J+lGR4aNsRmfuVPwq4rJAZ56la77XOJ3WlFamSh1GHnswzh6XaH/onObOFEP5iTw7DA==
X-Received: by 2002:a05:6a20:3d05:b0:35d:8881:e6a4 with SMTP id adf61e73a8af0-369b4c32d75mr12649177637.25.1765852736157;
        Mon, 15 Dec 2025 18:38:56 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c11d3e8af1asm8153533a12.2.2025.12.15.18.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 18:38:55 -0800 (PST)
Message-ID: <b37bbff7486f47404872017faecba43833116d61.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] resolve_btfids: Introduce enum
 btf_id_kind
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier	 <nsc@kernel.org>, Tejun Heo
 <tj@kernel.org>, David Vernet <void@manifault.com>,  Andrea Righi
 <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Shuah Khan
 <shuah@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng	
 <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kbuild@vger.kernel.org
Date: Mon, 15 Dec 2025 18:38:52 -0800
In-Reply-To: <c857acb9-977a-49ca-a03f-ef3fd68fabae@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
	 <20251205223046.4155870-4-ihor.solodrai@linux.dev>
	 <386068b11e146a9dbb502f770d7e012e3dea950f.camel@gmail.com>
	 <c857acb9-977a-49ca-a03f-ef3fd68fabae@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 18:31 -0800, Ihor Solodrai wrote:
> On 12/11/25 11:09 PM, Eduard Zingerman wrote:
> > On Fri, 2025-12-05 at 14:30 -0800, Ihor Solodrai wrote:
> > > Instead of using multiple flags, make struct btf_id tagged with an
> > > enum value indicating its kind in the context of resolve_btfids.
> > >=20
> > > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > ---
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
> > (But see a question below).
> >=20
> > > @@ -213,14 +218,19 @@ btf_id__add(struct rb_root *root, char *name, b=
ool unique)
> > >  			p =3D &(*p)->rb_left;
> > >  		else if (cmp > 0)
> > >  			p =3D &(*p)->rb_right;
> > > -		else
> > > -			return unique ? NULL : id;
> > > +		else if (kind =3D=3D BTF_ID_KIND_SYM && id->kind =3D=3D BTF_ID_KIN=
D_SYM)
> >=20
> > Nit: I'd keep the 'unique' parameter alongside 'kind' and resolve this
> >      condition on the function callsite.
>=20
> I don't like the boolean args, they're always opaque on the callsite.
>=20
> We want to allow duplicates for _KIND_SYM and forbid for other kinds.
> Since we are passing the kind from outside, I think it makes sense to
> check for this inside the function. It makes the usage simpler.

On the contrary, the callsite knows exactly what it wants:
unique or non-unique entries. Here you need additional logic
to figure out the intent.

Arguably the uniqueness is associated not with entry type,
but with a particular tree the entry is added to.
And that is a property of the callsite.

> > > +			return id;
> > > +		else {
> > > +			pr_err("Unexpected duplicate symbol %s of kind %d\n", name, id->k=
ind);
> > > +			return NULL;
> > > +		}
> >=20
> > [...]
> >=20
> > > @@ -491,28 +515,24 @@ static int symbols_collect(struct object *obj)
> > >  			id =3D add_symbol(&obj->funcs, prefix, sizeof(BTF_FUNC) - 1);
> > >  		/* set8 */
> > >  		} else if (!strncmp(prefix, BTF_SET8, sizeof(BTF_SET8) - 1)) {
> > > -			id =3D add_set(obj, prefix, true);
> > > +			id =3D add_set(obj, prefix, BTF_ID_KIND_SET8);
> > >  			/*
> > >  			 * SET8 objects store list's count, which is encoded
> > >  			 * in symbol's size, together with 'cnt' field hence
> > >  			 * that - 1.
> > >  			 */
> > > -			if (id) {
> > > +			if (id)
> > >  				id->cnt =3D sym.st_size / sizeof(uint64_t) - 1;
> > > -				id->is_set8 =3D true;
> > > -			}
> > >  		/* set */
> > >  		} else if (!strncmp(prefix, BTF_SET, sizeof(BTF_SET) - 1)) {
> > > -			id =3D add_set(obj, prefix, false);
> > > +			id =3D add_set(obj, prefix, BTF_ID_KIND_SET);
> > >  			/*
> > >  			 * SET objects store list's count, which is encoded
> > >  			 * in symbol's size, together with 'cnt' field hence
> > >  			 * that - 1.
> > >  			 */
> > > -			if (id) {
> > > +			if (id)
> >=20
> > Current patch is not a culprit, but shouldn't resolve_btfids fail if
> > `id` cannot be added? (here and in a hunk above).
>=20
> By the existing design, resolve_btfids generally fails if
> CONFIG_WERROR is set and `warnings > 0`.
>=20
> And in this particular place it would fails with -ENOMEM a bit below:
>=20
>        [...]
> 		} else if (!strncmp(prefix, BTF_SET, sizeof(BTF_SET) - 1)) {
> 			id =3D add_set(obj, prefix, BTF_ID_KIND_SET);
> 			/*
> 			 * SET objects store list's count, which is encoded
> 			 * in symbol's size, together with 'cnt' field hence
> 			 * that - 1.
> 			 */
> 			if (id)
> 				id->cnt =3D sym.st_size / sizeof(int) - 1;
> 		} else {
> 			pr_err("FAILED unsupported prefix %s\n", prefix);
> 			return -1;
> 		}
>=20
>   /* --> */	if (!id)
> 			return -ENOMEM;
>=20
> So I think an error code change may be appropriate, and that's about it.

Oh, ok, sorry, didn't notice that.

>=20
> >=20
> > >  				id->cnt =3D sym.st_size / sizeof(int) - 1;
> > > -				id->is_set =3D true;
> > > -			}
> > >  		} else {
> > >  			pr_err("FAILED unsupported prefix %s\n", prefix);
> > >  			return -1;
> >=20
> > [...]
> >=20

