Return-Path: <bpf+bounces-71986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8974DC043A9
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 05:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BB918C1B6B
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 03:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87616261B6E;
	Fri, 24 Oct 2025 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqXfVxtg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418728DC4
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275727; cv=none; b=FkMp3SZi51oeTGB++bYR22waNiGoaftmf49TwDq0aeRfBbat4nzwuaUqzTnQB+q9rW4HWNgxI6lSb4nn1wAIhOPFiTSwvzZpy4bqD0ihnLDSVd8cJbmlOPTcv48yChShhkb4TkjW4RwARYBUBfdUlx1c66U5KuahR19S9amov2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275727; c=relaxed/simple;
	bh=U/fQ9GO8LFn4u0AVU/CFCxO1RaC5xIwwnoSuDNwYWec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d2wIFQGEAmaWDY22c1aCQp7ERBc1DONEwa52Mebn3QtpSlt8MOn7iA4P2yaYTvlGP67uu6wyPchfVdA0x95lRcT60FtTvg/4YFeXm3DVrQ1yhamDSLDEYM1UWTcofNbMLsxBYVPaenGmq2IwsOzHXxB9felxZkDTaEZdpqtfnbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqXfVxtg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a2852819a8so293893b3a.3
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 20:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761275725; x=1761880525; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U/fQ9GO8LFn4u0AVU/CFCxO1RaC5xIwwnoSuDNwYWec=;
        b=QqXfVxtgtZpRKzSYgcY0ejOO2UczABY2CgNGWLyIZdheKNKTdseiWwpOPgpOx/KIQI
         s4erM9jnl/NDq2TEzqhHKICxKCPhlMKoJs41GEvsxJX1qqGjAqGCldpryiCBDJLLf76F
         j8Xy/kKX02XSDSe87qs7DzRB1KpJP4MRQ9hRuibWcJbWgpVySf6a/FEArthSp3Zo7pqM
         7QIOe8ky3u7pE535XRps9GMLhTH5e5Heu8g2XSiYpzmT6qy/CAt9qtND/lzxZ/A05rMb
         cQxHPrQRpJ/8rt8XPSIqUMrV1XUVswtnCi98mhqXIouiPc4IYzoYeXVCDdpn+wCRfNqL
         psMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761275725; x=1761880525;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/fQ9GO8LFn4u0AVU/CFCxO1RaC5xIwwnoSuDNwYWec=;
        b=YDhO5ZWGBXOf0LgVHPO1N7m0nsd/q6v4Lx/ZKq/KCz4mXe2R7Lo6oQZoCfAWVrq/B0
         mOWUvDq1zsM2RUw1tT+TqIGXDnQT8xlCOmzh0dd6fs6QZd5gKYZega7g7fkuijv6P7iN
         mwKEPvL1MqhmBPFdLyKGso+C67byLs5e3mfJKHlnVDqC1Pf3M9jKsMJid2XF3Q8M/rWb
         STw2wUfqGVrEUYNE6ucj21P/eXqZqIUm4UTGet9GkA1mqr02qsMiQ5ckGB64m+DxUIXU
         lm0o5UEMvOxAu/PE+fpOYEBdQXzo30icsbfC5uEsnukPu2hhjkcoKEjIaaZLzHbssP8A
         ++zg==
X-Forwarded-Encrypted: i=1; AJvYcCUmSG+5ebAc4P7f7fUZsB8SqQTWfA+20n/Do9G+hignmjAtbJjzp3lDyFee2Omu5JYGCx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDVBjR2J9DseJoE8zNgcaFdnVLIWHAtr6myVKDvhHv4eRH/KF
	73mRyg9WxUf5Ewn7wpss9mVj2mlj3gb7LegkXzU8nuURQ97WTDCA9jAkk+V+0z2y
X-Gm-Gg: ASbGncsisj0qo0pudwqRryTdnOHwqKQjJ7NdavcT2d5xqk1YcS8E8y9e1eDpXQyLGge
	xM1r750Rz1NM4Ab5fuufUKEpPvt9hhcPTsNruFxugtc6sCRftcUdMVINZuX1JixSPBl4KwwHnLR
	kTdqJeELylQyshr3SOHHnkPCyZJPGAET88up1aAMIjFpZqrg/rJgNpE8r/4q4TFaR+oK+58PO3U
	G8j7w6eNKqypXC5Wm/NU8PVTg9e0Zr5KLlqcprQPxBis/dYhK/182h9+cBfSa3DGJleI3PuTgSa
	g2kNfXsNnX7cNN8gg6q9NVUYVWAp0x4lucTrUhtc1y28Y/QTYFJybbTp+mboSnv0tsmch7wj4To
	1wO/5qJym04sjLqHfAltk/7xbFrnJ88sO6HhgNpYLEyPQhR/iSkk6TPXAi7DI0tGmY8I0Ucro
X-Google-Smtp-Source: AGHT+IEIuHq7UcqS02TmVxJm8DIWd3Dpbf7GvUXrzylNp+X7NjpEw3KO3Ux4mjYeXFbE8THlmxGb9w==
X-Received: by 2002:a05:6a20:a104:b0:334:a180:b7a7 with SMTP id adf61e73a8af0-33c61fc0376mr6747573637.42.1761275724902;
        Thu, 23 Oct 2025 20:15:24 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c4d83dsm3598428a12.18.2025.10.23.20.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:15:24 -0700 (PDT)
Message-ID: <f5cb8c37dc7a23beb0d83fe2aa0a4dc29bc40fd5.camel@gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to
 enable binary search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov	
 <alexei.starovoitov@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
 Alexei Starovoitov	 <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>,  Song Liu <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Thu, 23 Oct 2025 20:15:21 -0700
In-Reply-To: <CAErzpmtJmj-ZX+uL_N9e5-r1iL+kD=0vwM9BeDL3t4C2re261A@mail.gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-3-dolinux.peng@gmail.com>
	 <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
	 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
	 <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
	 <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
	 <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com>
	 <CAEf4Bzajdv3Rd1xAxm_UZWBxPc8M0=VuUkfjJvOFSObOs19GbQ@mail.gmail.com>
	 <CAADnVQJG_tK18oxmjW37cbrxF2zPKPk_dvqXUTnOjUue7J0tLQ@mail.gmail.com>
	 <CAEf4BzYLyi6=Fyz9ziOAwkFOjUPyJmTj4c6g247XBwgwJ8m-qw@mail.gmail.com>
	 <CAErzpmtMPuGBhisLOaZMyzM5u3=0QrmZcuWqNgbMrceEEPN3TA@mail.gmail.com>
	 <CAErzpmsCJAWVjWnV2LWAnYCouynYZbUupS08LUuhixiT2do3sg@mail.gmail.com>
	 <7d9e373c7f0f3b7a50ee6a719375410da452b7ba.camel@gmail.com>
	 <CAErzpmtJmj-ZX+uL_N9e5-r1iL+kD=0vwM9BeDL3t4C2re261A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 11:04 +0800, Donglin Peng wrote:
> On Fri, Oct 24, 2025 at 10:32=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Fri, 2025-10-24 at 10:23 +0800, Donglin Peng wrote:
> > > On Fri, Oct 24, 2025 at 9:59=E2=80=AFAM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >=20
> > > > On Fri, Oct 24, 2025 at 3:40=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >=20
> > > > > On Thu, Oct 23, 2025 at 11:37=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >=20
> > > > > > On Thu, Oct 23, 2025 at 9:28=E2=80=AFAM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > Speaking of flags, though. I think adding BTF_F_SORTED flag t=
o
> > > > > > > btf_header->flags seems useful, as that would allow libbpf (a=
nd user
> > > > > > > space apps working with BTF in general) to use more optimal
> > > > > > > find_by_name implementation. The only gotcha is that old kern=
els
> > > > > > > enforce this btf_header->flags to be zero, so pahole would ne=
ed to
> > > > > > > know not to emit this when building BTF for old kernels (or, =
rather,
> > > > > > > we'll just teach pahole_flags in kernel build scripts to add =
this
> > > > > > > going forward). This is not very important for kernel, becaus=
e kernel
> > > > > > > has to validate all this anyways, but would allow saving time=
 for user
> > > > > > > space.
> > > > > >=20
> > > > > > Thinking more about it... I don't think it's worth it.
> > > > > > It's an operational headache. I'd rather have newer pahole sort=
 it
> > > > > > without on/off flags and detection, so that people can upgrade
> > > > > > pahole and build older kernels.
> > > > > > Also BTF_F_SORTED doesn't spell out the way it's sorted.
> > > > > > Things may change and we will need a new flag and so on.
> > > > > > I think it's easier to check in the kernel and libbpf whether
> > > > > > BTF is sorted the way they want it.
> > > > > > The check is simple, fast and done once. Then both (kernel and =
libbpf) can
> > > > > > set an internal flag and use different functions to search
> > > > > > within a given BTF.
> > > > >=20
> > > > > I guess that's fine. libbpf can do this check lazily on the first
> > > > > btf__find_by_name() to avoid unnecessary overhead. Agreed.
> > > >=20
> > > > Thank you for all the feedback. Based on the suggestions above, the=
 sorting
> > > > implementation will be redesigned in the next version as follows:
> > > >=20
> > > > 1. The sorting operation will be fully handled by pahole, with no d=
ependency on
> > > > libbpf. This means users can benefit from sorting simply by upgradi=
ng their
> > > > pahole version.
> > >=20
> > > I suggest that libbpf provides a sorting function, such as the
> > > btf__permute suggested
> > > by Andrii, for pahole to call. This approach allows pahole to leverag=
e
> > > libbpf's existing
> > > helper functions and avoids code duplication.
> >=20
> > Could you please enumerate the functions you'd have to reimplement in
> > pahole?
>=20
> Yes. Once the BTF types are sorted, the type IDs in both the BTF and BTF =
ext
> sections must be remapped. Libbpf provides helper functions like
> btf_field_iter_init,
> btf_field_iter_next,
> btf_ext_visit_type_ids
> to iterate through the btf_field and btf_ext_info_sec entries that
> require updating.
> We will likely need to reimplement these three functions for this purpose=
.

I think Andrii's suggestion is to have btf__permute in libbpf,
as it needs all the functions you mention.
But actual sorting can happen in pahole, then:
- allocate array of length num-types, initialize it 0..num-types;
- reorder it as one sees fit;
- call btf__permute() from libbpf and get all the renamings handled by it.

[...]

