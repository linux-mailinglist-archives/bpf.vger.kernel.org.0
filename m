Return-Path: <bpf+bounces-73555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC2C33A0F
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 02:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6AF3BA74C
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 01:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C153623D7D9;
	Wed,  5 Nov 2025 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyNyCFB7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21821C01
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305797; cv=none; b=JtHnzw8aGZggc1QhaA2IlEc9TC2w4YSSR3qpUrjg3413949YapOrbeViiX3u6rzf3zaGTEfwUZ1yVUNWmDQbEOEvXZ4WYJ42b+yyIrla4ZM1hUQeP/KdCZiqlqiGQ0+DmGhZxA1fp4ZDccDwZLXgMA+A6nzeXVo7CLFAs8oEYHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305797; c=relaxed/simple;
	bh=asHptWAIRpCDRG7vCQpbpikZfRL/+LcVaKzT/QlO1ws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lmXJBjuCYxyvJcQCMORWRUs3VjMhIp3iHrxfrPW5wrCmIHGdvvVgYVJFFoCHZ2AAP2OgyZeT0gohwnt2GlP7upDxd+dqdPHLChSQ/e4zAhlX6gcRm3YrnHVNs8BNok86PH1YGc7ZXS7qYSvN8SP8Ydv8bGcmbaIeoIIIvqpKVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyNyCFB7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso3466255a91.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 17:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305795; x=1762910595; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qg8PbE+dxmcwjVIqp0Xi3l9ojlu/aC0i4dngxNtaEDY=;
        b=eyNyCFB7hL2O9NvzTFt/xwYtNqrNuQwi9Efqe3MiLXGUHkyyU/h4nKpZejoFWEmQdF
         ppL0asckDRH2vxFQ6E/rfUFbcLbeEmf1JHCEOOla+JA7P+7oGnSSqZKBwK3+7jBmTrrx
         6g2fjRouIK34LXvSpe+QtvZr23k+yu3VHnef91PdjF/DXcVas0uocy2+3aP1v+6ZIOIg
         Nzy2/FRzOAbhvQSwCtjjrbWdTnUE+HQ62B33kU/RWnEuGKlybXo8OKZ0QLHX/kPzp42x
         sb9sBCBHKJkw+jLNFOunQgxOu8oMMBRgiU06FjEMM9Y5QTgHL1RGHnQGG1oxOLr+4+Rp
         ADaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305795; x=1762910595;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qg8PbE+dxmcwjVIqp0Xi3l9ojlu/aC0i4dngxNtaEDY=;
        b=xQEEDg9zRzyWCIneCoI2isBzvzt5Riw5XYGLAmdBv7GyuetxIK1/sf+EJfoMyhMFOm
         XmiwSXEUSI0xCGgWZSz/KZs7IZXlUczcYesYJv8ab8Et9f3tsIdEisP/3IxvcST4HILm
         lPLKAhMOOFzGSlKycxBv190JHJqbobreQPhScNblKQumEw2hhDoBMJW+me/7PrXmkCFD
         Tj3O5oDK+bRIP06e+tsB/2xpCrd8RY0Ia67RGISVuhdwNXOjwD6B4VYGs6fjLuctGImG
         uNlswy1/fdmWLJbFPBOFR7jFHbCXKAsT3fcrqlkOqDkYXQXhm53VROWGXuiGfopkdj7M
         GpAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyX3SVt/TVGNLHWeEKBii61Cl/8B41uYmepcUzY/M1ZLDrEQjc4X783/v0FxjVztVJgSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXi75+z38PHyjiYAym53dwI4FQKG/Op2Om8OQwEcGXBURISRt
	RfDVxVxNYyTqbo6QZKyCmfgrf5MpCnnm7JCKxMu4I5uszHIDYB+YqIl9
X-Gm-Gg: ASbGnctckv79lzroff42b1LETo7cyzZoCZKVKbOzhxZlhgmST6hu0/B6ZoTX2AeUWEN
	slG+q2mBvVCaJkGrpD2aUG9f2Du5DfKe5LN/gjv+sGW8pJ/7QhIjRpkORMWSablewYwbxhNMcMM
	BmIkZaSyzfRFcj9QM5qJ0swOPldMCbguFNCLS/BO9oP3Rqn23wQz6yBFaC/eHo/TAmAaBcX2VJa
	zKOzRCJy9ukxxJB0j6gkPT7cpJ38dWLDlBhvrmZAZledi8Q6OyfHhsIfxOtpJIdBnEW64YsbrKF
	0asBjbR3hkPF0/lyEqsBn7WAnN+bgE+6hzJDZxCN7cveZhHlkLDBADKU0J37EeujHxIzKHAj/db
	GPGPOBNLX+KlsPrgCoZlmLWvs0n2/Du+HThDtOz9R7eydYq78BxjsQ8Mn0hWHKlxyxD6q3d4Ujp
	AT6vKWTUU4x7FHbbvAECkreF2Cb5rTCivBjw==
X-Google-Smtp-Source: AGHT+IEEF5q2pzOeT+ddol1Ge84bNFSKdXLiqj1O+j3LaeUUjsRbWBWu2E2oABf5RHox9Z71r7KRUA==
X-Received: by 2002:a17:90b:3842:b0:340:b908:9665 with SMTP id 98e67ed59e1d1-341a7013a7amr1827066a91.37.1762305795224;
        Tue, 04 Nov 2025 17:23:15 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68e8029sm941145a91.17.2025.11.04.17.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:23:14 -0800 (PST)
Message-ID: <61f94d36d6777b9b84e9bf865edd17476a278e73.camel@gmail.com>
Subject: Re: [RFC PATCH v4 1/7] libbpf: Extract BTF type remapping logic
 into helper function
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Alan Maguire
	 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, pengdonglin
	 <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 17:23:13 -0800
In-Reply-To: <CAEf4BzanAmmSe84GnvWSR_KLFVmeEvrxVVJAvApFNRjgeRXk8Q@mail.gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-2-dolinux.peng@gmail.com>
	 <CAEf4BzaPDKJvQtCss4Gm1073wyBGXmixv4s9V5twnF7uEHRhPg@mail.gmail.com>
	 <61e92756ea7f202f2e501747b574e97b2f5bc32f.camel@gmail.com>
	 <CAEf4BzanAmmSe84GnvWSR_KLFVmeEvrxVVJAvApFNRjgeRXk8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 16:57 -0800, Andrii Nakryiko wrote:
> On Tue, Nov 4, 2025 at 4:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> >=20
> > [...]
> >=20
> > > > @@ -3400,6 +3400,37 @@ int btf_ext__set_endianness(struct btf_ext *=
btf_ext, enum btf_endianness endian)
> > > >         return 0;
> > > >  }
> > > >=20
> > > > +static int btf_remap_types(struct btf *btf, struct btf_ext *btf_ex=
t,
> > > > +                          btf_remap_type_fn visit, void *ctx)
> > >=20
> > > tbh, my goal is to reduce the amount of callback usage within libbpf,
> > > not add more of it...
> > >=20
> > > I don't like this refactoring. We should convert
> > > btf_ext_visit_type_ids() into iterators, have btf_field_iter_init +
> > > btf_field_iter_next usable in for_each() form, and not try to reuse 5
> > > lines of code. See my comments in the next patch.
> >=20
> > Remapping types is a concept.
> > I hate duplicating code for concepts.
> > Similarly, having patch #3 =3D=3D patch #5 and patch #4 =3D=3D patch #6=
 is
> > plain ugly. Just waiting for a bug because we changed the one but
> > forgot to change another in a year or two.
>=20
> Tricky and evolving part (iterating all type ID fields) is abstracted
> behind the iterator (and we should do the same for btf_ext). Iterating
> types is not something tricky or requiring constant maintenance.
>=20
> Same for binary search, I don't see why we'd need to adjust it. So no,
> I don't want to share code between kernel and libbpf just to reuse
> binary search implementation, sorry.

<rant>

Sure binary search is trivial, but did you count how many times you
asked people to re-implement binary search as in [1]?

[1] https://elixir.bootlin.com/linux/v6.18-rc4/source/kernel/bpf/verifier.c=
#L2952

</rant>

