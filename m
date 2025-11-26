Return-Path: <bpf+bounces-75594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E5EC8A996
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 16:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 417E4345730
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 15:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF1331201;
	Wed, 26 Nov 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="f4biDeBJ"
X-Original-To: bpf@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C2E331233
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170447; cv=none; b=AAhjII9yjsvCtY3uhA3V5i+kIonfpKiMRnsUKoJXNEHVn2+FwlBbfD0reZ1nHOY/2bc71W/cMY+rIsNylsb2N/2Ykjrqg1WpGTc9d6pYlFRabZh2JaEYGk8+hCXV5MS7ID1ZFakIRsCnDtpCQiRgMtsg75CIy4owCsVuITmwgsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170447; c=relaxed/simple;
	bh=5GRcIa/YaBI4AyoMCBcFhjhi8kYcF6nz5JNvHTsbns0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d8d0XB5RbmVqaEw+Pr+4ElCC8Q/zYdCy3ZnxV00yYBnf+/GW0+ly2KbLKu0mHJHpPhsn3eGl2fSDam4/60cIj2sNeQpZVPK2AXpCjhF98eY2qXZk8EwD3WTjVk3Qie6qHoHlOIwEw4BG0BmvUZYIXz8GYrgNkbZLoZqrDuEfPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=f4biDeBJ; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5GRcIa/YaBI4AyoMCBcFhjhi8kYcF6nz5JNvHTsbns0=; b=f4biDeBJ6tcql1AACsjQmcSyt2
	d83oKifGra+ytLN2uZfmePX0tbVE6dnKn1WfJ3OvlN9URdjn9F1hJOrwg4FIu8Uwm52dJliu/zpQ9
	h96QZ4hXbuvGHfI2Fv60NbBkIpm6lgfFqEqCOSPxp7QvANPdUBrt4P0JYQw2Q42hHtIWuEtgGqbPo
	0+gUcp3OGJMz2AbREPzjIOVaiIFq6ni7gsazZOuPivrdYAz7fLawDuFGA6KyncJ1L+0x9/sTFe/iM
	B2FMi50IIQnWC0ciz9Htfa0cG0ugjRQYV2/PKFRgxjXmVZ7zFYdIVS9XKJyN0Mm/DjYn4NIg12POx
	f9lWqbww==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1vOHCb-000000000s9-23S9;
	Wed, 26 Nov 2025 10:13:06 -0500
Message-ID: <177c8e4d0567456baecc962bf5c1038f05358cc0.camel@surriel.com>
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global
 mode
From: Rik van Riel <riel@surriel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yafang Shao
	 <laoar.shao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov	
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko	
 <andrii@kernel.org>, David Hildenbrand <david@redhat.com>, Lorenzo Stoakes	
 <lorenzo.stoakes@oracle.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard	 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Zi Yan <ziy@nvidia.com>,
  Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, Johannes Weiner
 <hannes@cmpxchg.org>, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com,  Matthew Wilcox <willy@infradead.org>,
 Amery Hung <ameryhung@gmail.com>, David Rientjes <rientjes@google.com>, 
 Jonathan Corbet	 <corbet@lwn.net>, Barry Song <21cnbao@gmail.com>, Shakeel
 Butt	 <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>,
 lance.yang@linux.dev,  Randy Dunlap <rdunlap@infradead.org>, Chris Mason
 <clm@meta.com>, bpf <bpf@vger.kernel.org>, linux-mm	 <linux-mm@kvack.org>
Date: Wed, 26 Nov 2025 10:13:06 -0500
In-Reply-To: <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
References: <20251026100159.6103-1-laoar.shao@gmail.com>
	 <20251026100159.6103-7-laoar.shao@gmail.com>
	 <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 18:32 -0700, Alexei Starovoitov wrote:
> On Sun, Oct 26, 2025 at 3:03=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
>
> wrote:
> >=20
> > The per-process BPF-THP mode is unsuitable for managing shared
> > resources
> > such as shmem THP and file-backed THP. This aligns with known
> > cgroup
> > limitations for similar scenarios [0].
> >=20
> > Introduce a global BPF-THP mode to address this gap. When
> > registered:
> > - All existing per-process instances are disabled
> > - New per-process registrations are blocked
> > - Existing per-process instances remain registered (no forced
> > unregistration)
> >=20
> > The global mode takes precedence over per-process instances.
> > Updates are
> > type-isolated: global instances can only be updated by new global
> > instances, and per-process instances by new per-process instances.
>=20
> ...
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&thp_ops_lock);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Each process is exclusively ma=
naged by a single BPF-THP.
> > */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rcu_access_pointer(mm->bpf_mm=
.bpf_thp)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Each process is exclusively ma=
naged by a single BPF-THP.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Global mode disables per-=
process instances.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rcu_access_pointer(mm->bpf_mm=
.bpf_thp) ||
> > rcu_access_pointer(bpf_thp_global)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 err =3D -EBUSY;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto out;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> You didn't address the issue and instead doubled down
> on this broken global approach.
>=20
> This bait-and-switch patchset is frankly disingenuous.
> 'lets code up some per-mm hack, since people will hate it anyway,
> and I'm not going to use it either, and add this global mode
> as a fake "fallback"...'

Should things be the other way around, where
per-process BPF THP policy overrides global
policy?

I can definitely see a use for global policy,
but also a reason to override it for some
programs or containers.

--=20
All Rights Reversed.

