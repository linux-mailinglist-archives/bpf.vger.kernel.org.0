Return-Path: <bpf+bounces-76673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E2CC0A57
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 03:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D9873025FB0
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CAE2F12C1;
	Tue, 16 Dec 2025 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkIJojbm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF022DA758
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 02:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765853688; cv=none; b=PhDXBiXb5LYafugu5PVKM6Sh9F5Dl3fFnDPAOddQ+TsYaigK22ehxIgh4ty6AsNfbc8QYT9JYJTpKARdrYvcz+1tWxjCPlEufUv+k36Ag057Lb6MV1bD35Kdp5M4D5FSuHKfIohQY2dxdd/TYqCqyPcKrCR+t0rsl/gyYCvDhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765853688; c=relaxed/simple;
	bh=numGoBvFqUmKgYq+gTvwU6RDyzW/FMMZFczl/Mu6Beo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmV7f8vD1Y4X0BVI5iKP7Ubnp4ZZjXT+5FHTdaIOGHTVURiI1D4KpwQHG2IDomvGxtIOXPrC1etVFUmX7fWY6ePMgdGxpPr+cKuf0blrcL6YY7zOI2dNLIBQ9VPuRnfiYs3xSZazHCkFFBSYHZ1lT3O0J1OVCmr0qKvVXuf+CDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkIJojbm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0c09bb78cso13870315ad.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 18:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765853686; x=1766458486; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7WAisvZ8c0VsEQQ/ay4lGlVwantG9QHW/ILMt+qNiOc=;
        b=mkIJojbm5zOc5rIC91ptnT8r2j92xoAXz1j/E/L3aLFg8ub1IMoPhqnKI++9D53Za+
         3jqwNxHKrCSooTvu3e6y54PgZNOk9HDhpq25+OQNshLFKgI/TqO1KgJUvTtEzOtcy46r
         RQ5WFPcwf45PCSj9p/USVGJtPioSPXBvPJrvoRRhyOdRe6V/mxdvCQG2AyEyj82qfeKR
         fAQvoxU2Cs2365knGLsui0aJZ8CIKt2bu5ssUd0DJqMSlKBQWbQ7Jg22KbrNRu625R61
         /yEcjHo7mMFXPglshLsX+IaY8sVG2+B+8QN6Z21JY1RiFuOfaRFgJ1adniTuCyF9SqfT
         Fg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765853686; x=1766458486;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WAisvZ8c0VsEQQ/ay4lGlVwantG9QHW/ILMt+qNiOc=;
        b=FRfkFxWdCJaM+sAJS34sglNrY7w6hBOOPZTC6vWarYcbRAyQZRoWGudvwd4Z5mOd+n
         SrafSfhEcQZMxOVCgR0r5hAwUkTxW5s1JfhhY1XjbxVKCuxevo78Augt7KSML48x0tIC
         q81G8adIENKxOidOins6kh00SU9PhcmBSqlJftisR4j/IGix7S1xSnu781aqLBtnjpuF
         Ocwh2FrawGIHBf9lmc3nY8m3FSpb6otWOMzQfAcFYKRd3c6R1oo8vUv+AQvTYdbAuy93
         0tWuFavur52PJjCygpNFlzYJMnX04+vHz2d3oGfLHRWP/YpZN05DP85C4on6jGvYmdio
         6G9Q==
X-Gm-Message-State: AOJu0YxuUji5FDw749soPUrrtG/7mYXdOH8N6GBJ57n/KhDt3nvi/dGM
	nrQ0tyxrcpAAL6e+sOzkBrZ/+B2F76pjyuuG0pYk7W/Dr7ukq1yXr02A
X-Gm-Gg: AY/fxX4WkMMEjMCFIL71BwPZ9kBptDx0TYed0khZGsdg32Xx+YC/u+EpydA7ZZ5P91y
	gk49KbXQ9UCh3C98CM5usLPnnsxz3F0Giy16xkRiH7ts56PvfMlsdoiesK9ZG9wLgGJRufnw7JQ
	EYnnAdpWOfLwSMsCfgt/FyiLGP5J7sShroI8VJdUvD7aKbeeQ6GRqeIMljGfSsIi07eUnmdbEg3
	Fmd0oTn/T/kVdQoK3VX3n3HZfTw5VRBDwUP1UbFilBfJ4uzxhmB320TsynnGZK5diaat/G8k05B
	/m2wO4COp8yzytba3BR8jBMy+P+jb/czN3kQbFZDObmewWtE8mNl6IqwMCkvlIlNrtkiieT8Fbi
	gYMJH2Ls4lkQe7MQGSpZO7+pZCpbyjk58kRgKqBZ5oUX7muyyDoAUHCdWbCHfeN40VeFMoyPVpi
	xP6jT+KMaq
X-Google-Smtp-Source: AGHT+IHCrdtZDAP84b4wHx8q9geC3s/5+S5GqytXyOs32NpX6TX024B5zSY7ifUNYMrtppDYkMvk6Q==
X-Received: by 2002:a17:903:fad:b0:298:639b:a64f with SMTP id d9443c01a7336-29f24d47166mr136419605ad.6.1765853686097;
        Mon, 15 Dec 2025 18:54:46 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a094398ed0sm84118975ad.27.2025.12.15.18.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 18:54:45 -0800 (PST)
Message-ID: <9c9ac17e916162d8921e4829153b350080923339.camel@gmail.com>
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
Date: Mon, 15 Dec 2025 18:54:42 -0800
In-Reply-To: <4daf5253-685b-4047-8e2a-06ed2c72c830@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
	 <20251205223046.4155870-4-ihor.solodrai@linux.dev>
	 <386068b11e146a9dbb502f770d7e012e3dea950f.camel@gmail.com>
	 <c857acb9-977a-49ca-a03f-ef3fd68fabae@linux.dev>
	 <b37bbff7486f47404872017faecba43833116d61.camel@gmail.com>
	 <4daf5253-685b-4047-8e2a-06ed2c72c830@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 18:52 -0800, Ihor Solodrai wrote:
> On 12/15/25 6:38 PM, Eduard Zingerman wrote:
> > On Mon, 2025-12-15 at 18:31 -0800, Ihor Solodrai wrote:
> > > On 12/11/25 11:09 PM, Eduard Zingerman wrote:
> > > > On Fri, 2025-12-05 at 14:30 -0800, Ihor Solodrai wrote:
> > > > > Instead of using multiple flags, make struct btf_id tagged with a=
n
> > > > > enum value indicating its kind in the context of resolve_btfids.
> > > > >=20
> > > > > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > > ---
> > > >=20
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > >=20
> > > > (But see a question below).
> > > >=20
> > > > > @@ -213,14 +218,19 @@ btf_id__add(struct rb_root *root, char *nam=
e, bool unique)
> > > > >  			p =3D &(*p)->rb_left;
> > > > >  		else if (cmp > 0)
> > > > >  			p =3D &(*p)->rb_right;
> > > > > -		else
> > > > > -			return unique ? NULL : id;
> > > > > +		else if (kind =3D=3D BTF_ID_KIND_SYM && id->kind =3D=3D BTF_ID=
_KIND_SYM)
> > > >=20
> > > > Nit: I'd keep the 'unique' parameter alongside 'kind' and resolve t=
his
> > > >      condition on the function callsite.
> > >=20
> > > I don't like the boolean args, they're always opaque on the callsite.
> > >=20
> > > We want to allow duplicates for _KIND_SYM and forbid for other kinds.
> > > Since we are passing the kind from outside, I think it makes sense to
> > > check for this inside the function. It makes the usage simpler.
> >=20
> > On the contrary, the callsite knows exactly what it wants:
> > unique or non-unique entries. Here you need additional logic
> > to figure out the intent.
> >=20
> > Arguably the uniqueness is associated not with entry type,
> > but with a particular tree the entry is added to.
> > And that is a property of the callsite.
>=20
> You're right that the uniqueness is associated with a tree.
> This means we could even check the kind of the root...
>=20
> I'm thinking maybe it's cleaner to have btf_id__add() and
> btf_id__add_unique(). It can even be a wrapper around btf_id__add()
> with a boolean.  wdyt?

Well, sure, that would be a bit cleaner on the callsite.
Up to you, given the number of the callsites I wouldn't bother.

