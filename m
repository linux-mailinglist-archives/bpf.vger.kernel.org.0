Return-Path: <bpf+bounces-76792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 521FACC57FF
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 00:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A603305D1D7
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6BD340282;
	Tue, 16 Dec 2025 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBsSjUV8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372333FE34
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765928180; cv=none; b=Ut0bODArj2eQ3kBzAm8PgTE5k0kUjgDRoI4tt8C9yEwGhfgP+u+Ln9Vrcm3oYZYx19ikAE+VFxS+Cv60nT4ZCVnHcp1iEwZJcSyhLwpJlIu0NoDf07QgmgS1JLovqNAY1s1148HlgYWM8B/JSrAT/ukETs6a3eSi9bGDkR92Hds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765928180; c=relaxed/simple;
	bh=bKDKc+TgL1L70lkY9u/6MjaATMsNRJgBoVpoC9MhowM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JYCadSAnE+ZgwTC3TGt3nm0nGe/FGbKcoaI3Nj6kqVA+DHG5kUxGSlbPlCJE2K19YtJdD7yFYjt2ytI2UZDGxDTHV8thIe8zSOLaerZHF48sYU4dkiUHhr2Stv8r4CrjheZn5no42ATLlWYAwgHKCmWJj+DJP2Cz5bjW4WxX+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBsSjUV8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so6087380b3a.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 15:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765928178; x=1766532978; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bKDKc+TgL1L70lkY9u/6MjaATMsNRJgBoVpoC9MhowM=;
        b=HBsSjUV87I/Unwqtb6EtjV8nvsVMVjArkqaqFpZThD0cK6ZNAbwLzjbfwrpp00A57k
         Ai4z5lPf/uvhZtv14qKsLsHZ8BwfotnrJldfT0i6fMkXR0HjcMBeNsdZtyTdheIQVtJ5
         wTbQ8s5ZFF02cfL7OGAKFiyRpoPRiBEvVWiZBSjrWiLSFl3yOHbORNNoIorNfgKcybqp
         e2bj8DhkOIaaNg1Z6e4H29eJiR5U/V1hYN2QkGRVj8i6hESfCJt/ZgV6C6CRRimSLWlF
         0mpXRBfE6sDm38jCYwueGZkGdwu2IS3mLruYEct7ifPcKx3famWGaqWY23BwdI/MBpY2
         35yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765928178; x=1766532978;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKDKc+TgL1L70lkY9u/6MjaATMsNRJgBoVpoC9MhowM=;
        b=Lq3ZkNEtockSTZqgm6O6lLsottpXGAFHXykvNlrs85fLpTWdq88JyEGuz79KlJFEpb
         hHc7KUuRMyN1VvkRsPxhqdlE7DadBXUlmtsCf7KT0QE6RzRMmu49Jz0MBMKZS3SK5o/U
         AOcM7piTknCLgN+KKAoXAWYI0D7/sWuuiSBFG3QRUYG4Rox1/J2ZtaRsLwoTh96T8ShL
         UIzBxqFCpQ9kzKkzXNgudx992jjif8dUdTGcELrAK3l4FXQt74Q7b+wSCmE4b4zaeAnN
         dNr6WcBCv0VoBV07l2kgyjgnbWaBEacSzFTKiFvf2f4aaYU4cmwvLOYvUgf/34ArFEFY
         y+DA==
X-Forwarded-Encrypted: i=1; AJvYcCXGUM7zqaFzMmUb1gDZycNB7jDoPpJCfTa1IDVZYHw7z1i/bj6fz7RdY2O+SkMNiSe+g2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxtJQs8U2eydjwnuPQBfkEP9dLmZjLsXfePfLSAl0npSMh+Ytj
	ofM6IRZlCPATIhb05oRZdM1B7qKaFA3GGHq8n6LcIc6oE6GKo6FPCvGd
X-Gm-Gg: AY/fxX5gyj/JPa/iY2YjutbIol5XHSjYX0RbBjql0KwwhFMVvgCYH6fzu61uBprTREw
	WIENOTnI3a3nq2zAFik7qgcpRAhyGVn2F+efrPnVpzGNSaoVqWpmScI1RcobH0eUwDalWAe4/qz
	VVOC8n/ubmFnATrH87LPiV1HBvdKbcwnQB71utNCx5a1n1Mequ+HFAzweTmA8Q2fCDylxVmIOPx
	CQUJ+UBmEYq6xeKPdQaBYlo7rdn7Yf4O64WJpFrbzJeVdfUQl+a/curYYO0Dp6JhylLx7rVQwU+
	NM6l+z/C7gTGwk2TZWh2w+7VUC148JRZzYDuJI5KRe32s3zw1rEJcBmNEVXNIBTawek4lIsfKP6
	uoXtAreiAaThh4zOcXPyLb6vJuMvLw2E9kmQSlavfeR+tKqShnVHeOwqmPVufL9WIGmXEE9dVHl
	DrrMnpaL3m
X-Google-Smtp-Source: AGHT+IFEIDlu5Wc939J/FgSPbSQ4mhNtxmp/8/V33HL92O6XbOUrHvTVyWIZjrGjZZtS4Gi3dEQEJA==
X-Received: by 2002:a05:6a21:e081:b0:35f:9743:f4a with SMTP id adf61e73a8af0-369adfb32a9mr14781552637.26.1765928178020;
        Tue, 16 Dec 2025 15:36:18 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cdc38d275sm882452a91.13.2025.12.16.15.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 15:36:17 -0800 (PST)
Message-ID: <d05e0af873f2f36359b34cc3865c44c98bc291e0.camel@gmail.com>
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
Date: Tue, 16 Dec 2025 15:36:14 -0800
In-Reply-To: <CAEf4BzbAXGdROrnGZZ_GBZmn9muKz9Cr+yUbovo+pmx-8GLdhg@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 15:00 -0800, Andrii Nakryiko wrote:
> On Tue, Dec 16, 2025 at 2:35=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2025-12-16 at 14:23 -0800, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > Ok, so what you are saying is that if there is layout info we should
> > > always use that instead of hard-coded knowledge about kind layout,
> > > right? Ok, I can agree to that, but see note about extensibility
> > > below.
> > >=20
> > > But that's a bit different from validating that the recorded layout
> > > of, say, BTF_KIND_STRUCT is what we expect (sizeof(struct btf_type) +
> > > vlen * sizeof(struct btf_member)). Because if we enforce that, then w=
e
> > > still preclude any extensions to those layouts in the future. And if
> > > we do that, what's the point of looking at layout info for kinds we d=
o
> > > know about?
> >=20
> > If full flexibility is allowed, then all places where e.g. libbpf
> > iterates params or struct members require an update. That's a big
> > change.
> >=20
> > I suggested checking layout sizes for existing types as a half-measure
> > allowing to avoid such changes.
>=20
> Shouldn't we just say that layout info will never change for the kind?
> Whatever fixed + vlen size it starts with, that's set in stone.

If we are not going full flexibility road (a lot of work with unclear purpo=
se),
then fixing the layouts for existing types is what we should do.
I suggested adding layout sizes check in BTF validation phase to
enforce a consistent view at the BTF layout.

> > > > Given that BTF rewrites would only be unsound in presence of unknow=
n
> > > > types the whole feature looks questionable to me.
> > >=20
> > > What are those "BTF rewrites" you are referring to? I'm getting a bit
> > > lost in this discussion, tbh.
> >=20
> > E.g. btf__permute(), as it will not permute all types if some of the
> > are unknown. Or dedup.
>=20
> Yes, agreed, I don't think we should allow modifications like that of
> course, who said we should?

No one says, I suggested adding a check in libbpf,
so that btf_ensure_modifiable() can report an error in such cases.

> >=20
> > > This feature is designed to allow introducing new (presumably,
> > > optional) kinds and not break older versions of libbpf/bpftool to at
> > > least be able to dump known contents. Does the current implementation
> > > achieve that goal? What other goals do you think this feature should
> > > support?
> >=20
> > I don't think anything other than dump is possible to support.
>=20
> Ok, then we are on the same page.
>=20
> One interesting question is what to do about libbpf's BTF
> sanitization? Should we still try to replace unknown types with
> something that byte-size-wise is compatible? It might not work in all
> cases, depending on the semantics of unknown KIND, but it should work
> in practice if we are careful about adding new kinds "responsibly".
> WDYT?

The question here is to how to compute the size for the unknown.
It is possible to have a flag specifying if btf_type->size is a true
size. But computation is more sophisticated for e.g. arrays.
On the other hand, if member of some structure has unknown kind,
it can be safely deleted, as struct has size field and offsets for all
members. So, sanitization by deleting types of unknown kind is
possible to some extent.

