Return-Path: <bpf+bounces-62440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7551AF9B7A
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 22:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067164A8499
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD76422A7F9;
	Fri,  4 Jul 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNRbkpYZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B26199FBA
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751659564; cv=none; b=XGoUYPpoSHaxuwEdGrBgN7drlXqsTg0cIu5Tsi3PR1GInn09DMHKIfjPHeYRmSS40m6EycqJsVPqQbwCK0+GEtdS/+6y750MObWmasmCkLt6ZmqCJzrkYLDF/FCk06pvEOilrQN18Hs7r7yWiHnUiOBmgNfxLZYhg4C31gr5zuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751659564; c=relaxed/simple;
	bh=mUjiw2O1e0MTzRD7QD2Scm/bQP8nRAYaPirPpJoH4aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxlZJtMdn+WMNo+mRn+mMkRgxoxjGJvVzhFqByajWMzuXwWDpPAH34NTrfl6HDl7V7c4JC/hroo6RHHWwWjQbyoFlZC4zPnFzWJ8Kd9lbrnsq4Mbxl47rc3P1ewgT4s8Jbux44yz2VQ3EsZK6h5LXxk5w8KQA2KZbMxHQDtCT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNRbkpYZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so1529947f8f.0
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751659561; x=1752264361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUjiw2O1e0MTzRD7QD2Scm/bQP8nRAYaPirPpJoH4aw=;
        b=HNRbkpYZc6x/Y78tK2EaMSVG2L8EmhPdqCaZtdwgKp/PYD9b+jYnptBvuhsRB+0i3X
         NCB7LKyd4dF1QcCl2EN33pnPmc3CIkHtx3fiTCbvfEMXWk0nQE3f+8A1/pFflSdUfbcE
         yy70jt3hPUwRC3gtDcatHVeZVt8vjLdLkbCEPtDxix64iHLMA6RMTQNhQpRUj7Rv8Etc
         SH0gHk4MSm1CcOgGiYPGUbVOfqMccwDjIS973aH0rdagz9WWvbFxKleVm0cUVsDuSnR2
         91A+4QeXI30/BcvycGWvL94TGH8R1nGAYJMAEQ+FGoWvcQHqu6m6AuKpG/op81cMv0RE
         HsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751659561; x=1752264361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUjiw2O1e0MTzRD7QD2Scm/bQP8nRAYaPirPpJoH4aw=;
        b=LMLfXWKqD7cfncALfRUxi/4KYiQ5hH2R3h+5OI+jcOAbuPr0De5PAWbqnO42P7m5v2
         SzrmMC7rD3oigY8YXQZWBvsnZFV7LjfCXIsa+EXkURls53x0aoICgneLXEkVGiC0QRbt
         mQZLFPo7zQnNj4JA2FnZZRJ3a9qc63emOjBXAtHqkW6XFi5qy0rhAReoFMjrHneZ+J03
         ZhsekiWBu5NMBtxho/CJViY6RYE5HnzoUicOlmHKZt+rDcbtdXE6wNYD0RnSqGsH+WrR
         TBvnX5M60jJpCjw75NWfPqlYCQioFo2oYY1CWlkc5/3SPXmvMJ4wbCmBCfXO2HoxoFix
         0BBw==
X-Forwarded-Encrypted: i=1; AJvYcCUK2ZHDKdwo4iiHJo9QZP2cSmaYyFN9yFnWKorKQ5D7saQ0CZoEXnazbpGIvkPv1xNILrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjiJ8IjdunUBeyIe/m61fc9aBR7aJ1OPat+qEcb/6FZcZ12JRS
	N/jDS7RTVDuO0zm43PX8vnSaT1gKDYYNreJpLc/bR87yHZgjxqm/1mXMU1JJXEuOulsNcNpS2Ov
	rndHlnYfvDZw46rCcjtbu2qgTN7Gmd3Q=
X-Gm-Gg: ASbGncsYp4HSf+TAuJoM9yDlo5kQ54fCNhmjuWJ4OGTwMh9UPgiaJAWk19Gn7kXz8Tb
	tEVj4ORkBrEVkcCwtszZp8RZLPV21FBSKvfgleJFS1H3x/V3MF/n8c5YbPFlIfxYBnC6JcAaezu
	iIF0eeeoYAMpj/1i3AsgMoZRtEn0gMX0kVHOA1MqAaXvZBLELJJMYQUbVTdKiq6HuTaovy0yy0
X-Google-Smtp-Source: AGHT+IE6BooeFHAutk4w5RR9q3wvDps0xEC4RdKuQnnrTTjbFWxObgck/qPIleH+efBfhcSlZBqLG2dY3eWlb2YVe8Q=
X-Received: by 2002:a05:6000:2913:b0:3a5:2b1e:c49b with SMTP id
 ffacd0b85a97d-3b4955971d5mr3620825f8f.29.1751659560793; Fri, 04 Jul 2025
 13:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-5-eddyz87@gmail.com>
 <CAP01T74AYNX5ARJ5YXryUyKvn5o0Dv0JBoq3CCKcD8rh==uKQA@mail.gmail.com>
 <fb5b8613584dbce72359e44ef3974e4cb7c8298e.camel@gmail.com>
 <de7f3a2c5bc521c1111b0ed1870291c0889e4757.camel@gmail.com>
 <CAP01T75+cXUv4Je+bYQNb-Us_MF1s1Zc9fL0wmowLExKUQ8KNg@mail.gmail.com>
 <a8f522a0e9eaf060727b7782d700f998efaa757c.camel@gmail.com>
 <CAP01T74_diwrEB0D=LOqVGQTGjiETm65cqh3zZEL5S5EkTYaZQ@mail.gmail.com> <e5acf74c70f6aa01ca7be4c0afce9dd6a20a910e.camel@gmail.com>
In-Reply-To: <e5acf74c70f6aa01ca7be4c0afce9dd6a20a910e.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Jul 2025 13:05:49 -0700
X-Gm-Features: Ac12FXwgqvgSOkizx3qD5bLS7q15zwgEIYXF6dNSdTbVAUVW1A1G8WnVyUJSngg
Message-ID: <CAADnVQKh9pAaAcJp_bSFjz5=K-6XPgb_Jdo8yhv3VYQhb-6=xA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for global
 function parameters
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 12:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-07-04 at 21:15 +0200, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > Yeah, so if the user specifies a type and has co-re enabled, they're
> > accessing a kernel struct.
> > If they're doing it without co-re, it's broken today already, or they
> > know the struct is fixed in layout somehow so it's ok.
> > If not, they want to access things at fixed offsets. So we can just
> > use the type they're using to model untrusted derefs.
> >
> > So always using prog BTF makes sense to me.
>
> Ok, I'm switching to always using prog BTF.

Hold on. The concept of ptr_to_btf_id|untrusted that points to
prog type doesn't exist today. We should be careful when introducing
such things.
I prefer to keep btf_get_ptr_to_btf_id() in this patch
and think through untrusted|ptr_to prog type later,
since the use case of untrusted local type doesn't quite resonate with me.
Currently we only have mem_alloc|ptr_to prog type which is
read/write and came from obj_new, rbtree, link lists.
Untrusted =3D=3D readonly for prog type is quite odd.

