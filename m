Return-Path: <bpf+bounces-37334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4266953D58
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816D8288906
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A3F155758;
	Thu, 15 Aug 2024 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrgPDtR5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D51156F3B
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760968; cv=none; b=gACLyFQqU4SiVWwPtvKHLN3XDUM5rZIxsjA3FFcS3zItt45I3mtpyNMir8Vc26RPH2NXtCIEwQ7yXdM0Z4RTwcoANBW8w2+Uqly5IgHiYgVZW1wBnSOrinn/KjCVD4t6rOxDQXPMrlZjL8g72M8I1g61pBM6R5R7ttPHCnuZrb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760968; c=relaxed/simple;
	bh=igpKPcAHYUqwryLlezD8qH+GQ2yyJu/1lPreMgXUP/M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=saGNDn0psrmX5W/VCpccq3ur/2Yqosc+xcLz0t2St3hN9rKX21/iu+VoUqnjabQ/gqLCpeXw8M4oRHOXrlifXg4vJemkK6c7UmRd4YAgWrdTHnCJn5Jh4HnKBaWRU+7s1CYWhAavLbVR5JU5rrtvApZrlgayvCdM35VxThuf0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrgPDtR5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201d6ac1426so11925965ad.1
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723760967; x=1724365767; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HfKCz8Cz1sRzqy6y14ECgojq8RGWCxVI4LhrMegVUbc=;
        b=GrgPDtR5W7CFlN2GoQR+xa2RiQf23T2Jqjvt6Wh1AeFGakX7jejnwRL08qW1N/fJwl
         mZItOwSF236yDSiiIXZl0oWaYaZe18qRHA1HpZZIHjhor1FljMSMnaRzR0wHIVb5fGpS
         t4WhTKth1c4N0dKoeXRafzJhsyOKQb5l5sar5Ohav3vjDAZVItmUuH3taMZ3IMe2MhOd
         bpLHbRqwtnRkfhijMx0DipNk85THX/v0OLPY1izGIN+0lpdwNS9Q54NWyStN5RawJNqy
         xTu/lNVj90gJuYuPsW9no8a1+Onxmi8/8jCG6y0seb/7I1Y97iAZNY1+h3jPRha1n+Ew
         OLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760967; x=1724365767;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfKCz8Cz1sRzqy6y14ECgojq8RGWCxVI4LhrMegVUbc=;
        b=EPHhEL3r4LVnpBunL7LZBC2RMl3UfBTQgkPcT6ZWr1kZIrN1sM4/iYR/qGSyils9Ql
         8wWkUnFsbWVYmIBlvuIn2aCC+gTfj7r9YUNhQKbQN9HFbawgrQWWuetzj8XLnZwmOGZt
         2qbvN0KhozHILdaSEac0ULm+/5WXEkkHxAb2y6MZq8ljB3uDNkx84rpICL/oppv1WPO6
         N7RXkJy8wAv/N2Ah+PKmyTSiTrJ59RbYoyBZmi3JodhqqJV7Z3wKoRCFBa5aCwIORC2q
         kL/UGOO6qkBDI1ae5j7ldNYUyel3wmJ7ouJIwlyK/kPAzK2lIXocYUD2czt3+WJEJEJD
         JmUQ==
X-Gm-Message-State: AOJu0Yx+n824IiXziJo5dM64hcV32BzgeRQE+b3Y+OM1mYpDLedLilkC
	pTyJSh7FXPbd4U2KoXDPDbYDhjyVA36UhT8KMbKZViYjxsPFl8WI
X-Google-Smtp-Source: AGHT+IFSJ++JBEkcmV6VwA65B2VXwtyLxAsHPZvoPAgj6/YM85qQfhXeeALn8Tv/5zs7vS2mS+rH+w==
X-Received: by 2002:a17:903:5c5:b0:1fc:60f1:1905 with SMTP id d9443c01a7336-20204075ae7mr10864515ad.61.1723760966595;
        Thu, 15 Aug 2024 15:29:26 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031bd78sm14768785ad.73.2024.08.15.15.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:29:26 -0700 (PDT)
Message-ID: <224688c5e80bae476587705204043b50e4c49862.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: support nocsr patterns for calls to
 kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com
Date: Thu, 15 Aug 2024 15:29:21 -0700
In-Reply-To: <1918269a-db95-4a8b-885f-7b223c029be1@linux.dev>
References: <20240812234356.2089263-1-eddyz87@gmail.com>
	 <20240812234356.2089263-2-eddyz87@gmail.com>
	 <CAEf4BzZXyq8Y85v6UQo+xZZCyxSndsnHpPQnxfR-_FOfVqMseg@mail.gmail.com>
	 <065543369ba59473ae2479957ad318b5bb393c43.camel@gmail.com>
	 <1918269a-db95-4a8b-885f-7b223c029be1@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 15:23 -0700, Yonghong Song wrote:
> On 8/15/24 3:07 PM, Eduard Zingerman wrote:
> > On Thu, 2024-08-15 at 14:24 -0700, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > > @@ -16140,6 +16140,28 @@ static bool verifier_inlines_helper_call(s=
truct bpf_verifier_env *env, s32 imm)
> > > >          }
> > > >   }
> > > >=20
> > > > +/* Same as helper_nocsr_clobber_mask() but for kfuncs, see comment=
 above */
> > > > +static u32 kfunc_nocsr_clobber_mask(struct bpf_kfunc_call_arg_meta=
 *meta)
> > > > +{
> > > > +       const struct btf_param *params;
> > > > +       u32 vlen, i, mask;
> > > > +
> > > > +       params =3D btf_params(meta->func_proto);
> > > > +       vlen =3D btf_type_vlen(meta->func_proto);
> > > > +       mask =3D 0;
> > > > +       if (!btf_type_is_void(btf_type_by_id(meta->btf, meta->func_=
proto->type)))
> > > > +               mask |=3D BIT(BPF_REG_0);
> > > > +       for (i =3D 0; i < vlen; ++i)
> > > > +               mask |=3D BIT(BPF_REG_1 + i);
> > > Somewhere deep in btf_dump implementation of libbpf, there is a
> > > special handling of `<whatever> func(void)` (no args) function as
> > > having vlen =3D=3D 1 and type being VOID (i.e., zero). I don't know i=
f
> > > that still can happen, but I believe at some point we could get this
> > > vlen=3D=3D1 and type=3DVOID for no-args functions. So I wonder if we =
should
> > > handle that here as well, or is it some compiler atavism we can forge=
t
> > > about?
> > >=20
> > I just checked BTF generated for 'int filelock_init(void)',
> > for gcc compiled kernel using latest pahole and func proto looks as fol=
lows:
> >=20
> >    FUNC_PROTO '(anon)' ret_type_id=3D12 vlen=3D0
> >=20
> > So I assume this is an atavism.
>=20
> Agree, for kernel vmlinux BTF, we should be fine.

Right, since we are dealing only with vmlinux BTF special case is not neede=
d.
Please let me know if I misunderstand you or Andrii.


