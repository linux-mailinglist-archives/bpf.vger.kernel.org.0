Return-Path: <bpf+bounces-76797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E062BCC59C7
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 01:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD0C301A731
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 00:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81AE1EB9F2;
	Wed, 17 Dec 2025 00:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaFjBVWv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33518CBE1
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 00:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765931902; cv=none; b=egx5Pml8CgRrtauqYhJDHUGAYgSxdUPqiR07tHs8Ie3aQll/4aGw0zLn4Ret+XGlsOngD89krshhC3MV10sgfHwJ+T4E90oZiDFkD3dMjISCR6oP1cVwHHenf4Xx7iAZ32Xiq3xkASsMYBBMgEIduclWU9n2iQiiMVQYqAIuq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765931902; c=relaxed/simple;
	bh=1tRhOh6qqMw/Ci6WUJIXtBYjb4c9GePbl9osWpiJjlE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a12xQNJqGxcwHBBO+g83x+n3hims4+beB9wcOHxmLplf4mCSNt1UFYr3K0dz70vcQsw7ATzHXWcEafQo1zEZn8bILKPbQZYXqgAYC4KCYz5g/ZHaAMXgsgwbVUP3nQInnlMH5veeyEhzwio98cD7TnrxmenEj7f5JqS1WqXicOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaFjBVWv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so4443295b3a.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 16:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765931900; x=1766536700; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1tRhOh6qqMw/Ci6WUJIXtBYjb4c9GePbl9osWpiJjlE=;
        b=WaFjBVWvzx8Sv58j7wruF5comF7Q3txRgzFtZu2p8GVgY5Zzgqo7wrry/ErvXIz2zD
         qq0tvNjTbuRuOS4gCp+bwkbSXH+fVt0OXN7Ce5Pp/BUo8SgQbwNXY7wHKB9wWs/KwrSP
         YP3LdAviMq19/zrwA45/wU+ijsY3Mrt4tr0tSNaV99PwdSt2ZhyZpBvaRw8bg++PiSUn
         oRgiD7FD9tzI5WL2TH28JPS/dMXy2iTNOnndzkfX1yPGW3vtpgcoOwfW2bNUbdU1VBlH
         2aNfvcwDmfDQShPkcuLdMZJ1EwzYYLks9gbGRq/kzZd0U9bJbt2vQlwlGaR3BTKr8U9U
         4d8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765931900; x=1766536700;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tRhOh6qqMw/Ci6WUJIXtBYjb4c9GePbl9osWpiJjlE=;
        b=Ip2aPYBxMzD0XEMLPiZMnWeuz5okeOFHZ47z+q8e9t1QJomP4cwuYgsfWsNygUzCbO
         ydv8eFV012uxday4TRNsvLQFXJOmAk1VBZGVB2480FuOKm8cifM+auuRFnx2zdyQIRgz
         M0FRnctMnqUxj0iUuxNLkVogMP+ysKzSkmCJJBI/g7hNxMKCo2wXVKgzkgiC1tsyaZCU
         CsJBR4ChfijvwsWdMPOfD3ADDQzjyLo7o5+lD8QwIHkz0Dm6BbmYYqoEt9xwhfP89eA1
         Q5V/aCkQGYjWCxGOvEYI/cQlqi2DaDsX2elIafJivNNqO3EqkkfqPD5lBpxc4A+KeGgG
         HS0g==
X-Forwarded-Encrypted: i=1; AJvYcCWbf3wqHHjqZ3vcgVB3XF2F+nDs8igIoGSy+fPh6jgcrBav8snXb/F3G7+/a4KPfq4e/5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE0Vq4KYwcP6z4UNX06i15DlFGaCf1TWn1k/pXCtEjXgu/drTO
	ZWs088HNzdnnCnITAkkKQblZUCHT45i+bYIzpLd5Hczza4i72UotNox1
X-Gm-Gg: AY/fxX4WxyIqddZMJNs0robKDP7cqMk33CtzYfDstTvuRj89HXKvsQM/XBaNXuc4J9y
	qdRLo/Fz5u7S4s+ZRlTGYMSdzuWcqM/Ty9fVCBVcDy+F03WrkvTU39cTHtQfHJi4et67KXWJqSA
	st41gY6hSyVY2FSmc/Pu84P18+FEgtzesdCNA/n9TC4CLc8qlI1VPxTT51v93m1y/aXMrkSHHxS
	hD7c/j0KB8cX9FUAr7svlmJ9+qVzAq6kSF+/Izc4n0TGL0WOJe2yvcx3pRFvhhidwhjX/rC1aGa
	MNjE9gQxzo+yWxHtwpcCMtwF2FZlJHhXpYM1kPqa9T2zhcKLf9zgjEtsD7+EA8Cn31YuEyec9cQ
	coI9X7pafF/wbA7OcFSRgFbInHipIG3LD+vzbVOum5yZvJqT9uAaBVH/wq2uJqUqnuird6SmyDf
	SqT1X8JGeS
X-Google-Smtp-Source: AGHT+IE6EhSKp6I+thulqwzyGYJnQtzVRTJO8gT+bIKaJidx+BjnVhacsRLeeLuAWxB4mTIHGm2aeQ==
X-Received: by 2002:a05:6a21:328b:b0:341:84ee:7597 with SMTP id adf61e73a8af0-369afa0e194mr16130214637.47.1765931900355;
        Tue, 16 Dec 2025 16:38:20 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1726e2b02csm5551426a12.27.2025.12.16.16.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 16:38:19 -0800 (PST)
Message-ID: <199b61f28146c672875a947ab8b92d60aa8a3484.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 qmo@kernel.org, 	ihor.solodrai@linux.dev, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, 	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Tue, 16 Dec 2025 16:38:16 -0800
In-Reply-To: <CAEf4BzYbrT03M2w1gWJT4QPrVZtGC5rpCQGmHomDb4i7yEU0JA@mail.gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-4-alan.maguire@oracle.com>
	 <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
	 <6f3027ee-576d-45de-9795-9a8e620292e9@oracle.com>
	 <CAEf4BzYQeiECx9UpDqv6zRjd1EPjw8B44YX3KPGR1Z4dFKi1UA@mail.gmail.com>
	 <27e4a60100602f769f3c5410a398a75fe0151967.camel@gmail.com>
	 <CAEf4BzayA6if0xcTLux=eyASM1kpARmrOdDRmgG9F1SFa-fEcg@mail.gmail.com>
	 <26e95f737d2de5133702c9b641946e70ec2d1dae.camel@gmail.com>
	 <CAEf4BzawMy=woHx_yHY0iiD0x12B_+J8mFgV5zT3aCpG2N0s-g@mail.gmail.com>
	 <4b12236c974db52ea19985cc9c5e08e021db9ec1.camel@gmail.com>
	 <CAEf4BzbAXGdROrnGZZ_GBZmn9muKz9Cr+yUbovo+pmx-8GLdhg@mail.gmail.com>
	 <d05e0af873f2f36359b34cc3865c44c98bc291e0.camel@gmail.com>
	 <CAEf4BzYbrT03M2w1gWJT4QPrVZtGC5rpCQGmHomDb4i7yEU0JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 16:30 -0800, Andrii Nakryiko wrote:

[...]

> > > One interesting question is what to do about libbpf's BTF
> > > sanitization? Should we still try to replace unknown types with
> > > something that byte-size-wise is compatible? It might not work in all
> > > cases, depending on the semantics of unknown KIND, but it should work
> > > in practice if we are careful about adding new kinds "responsibly".
> > > WDYT?
> >=20
> > The question here is to how to compute the size for the unknown.
> > It is possible to have a flag specifying if btf_type->size is a true
> > size. But computation is more sophisticated for e.g. arrays.
> > On the other hand, if member of some structure has unknown kind,
> > it can be safely deleted, as struct has size field and offsets for all
> > members. So, sanitization by deleting types of unknown kind is
> > possible to some extent.
>=20
> I think it's unlikely we'll add some kind that will be directly
> embeddable into struct except for some modifiers. For modifiers (which
> I'm arguing we should add a flag stating that this kind is used as a
> modifier and its type field is actually a type ID field), we can
> replace them either with typedef or const and preserve layout and most
> of semantics. And for optional stuff like decl_tag, they are usually
> stand-alone pointing to types (rather than having types pointed to
> them), so just replacing them with something that is compatible in
> terms of byte size in BTF data should be sufficient.
>=20
> I think BTF sanitization will have to be best effort, but if we keep
> sanitization in mind, we can ensure reasonable behavior.
>=20
> Ultimately, though, you should always strive to use the very latest
> libbpf with your BPF object files. So maybe no sanitization of unknown
> kinds is the right (and simple) answer here: just update libbpf and it
> will take care of sanitization of *known* kinds.

Idk, this would matter if we decide to change clang to emit new BTF
kinds for BPF programs. Maybe postpone sanitization implementation
until requirements are better understood?

