Return-Path: <bpf+bounces-76840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65812CC6C7E
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A473028F71
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72847338585;
	Wed, 17 Dec 2025 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf0zD30b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0E26059D
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765963286; cv=none; b=pgdmIvAQBEvU2yy7ez3adG9NeW+mzP6VOOqNWGUS6UHX/yczDhZsCe9TWcyahKxaN9C8H3h39wHUqaZ1Djj6ww3hElvZeOGPhvxN5YcoB1ZbWZDOy2K7CggnMj4ekVEdxUDNQEyU7mK14kptKfis/VUjw1vwmWuD8M87HBo87HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765963286; c=relaxed/simple;
	bh=zBl5MGE0nmnvKIGjXuEAmbqrirwgcAZkFDdKy0HyHDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKTte4Rx2aEF9U0yltMCD30PIaYiBAP3HBbrKK+69fawRnMPeXIrvd68v/dMN/UQ7PsbJfA+xKgszrzpxn+iAkIMjRSIb0mdAvowcdp5zhgmzPwX1JQGSNJR64rHAExuu7K8eRgvcHnWZvHsFAYzTXo/7w3qi4aseOagsp/BUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mf0zD30b; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-649728a2228so7424891a12.3
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 01:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765963283; x=1766568083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpASDk3NM2fKiMnuB/c03rnowLUr/0iOxyoTyQMTKJU=;
        b=Mf0zD30bIfaV6sgvt6lrocvmNhJEQ6vUDE5n8nbrp2xhtlLRv7MBcx5OT2WVEPXnzZ
         0oyudJcR79peg0gUVsluTHBQ9eVx+y85OagSxsCMutYneOE6bEUD+l8k5iU2FcCImJ7r
         lQA3t6vhiWN3EHHhf6Vaaa2Nl4zimb3IBvaXk91exI60MrtZYDoVACs35wp339QkqQ1c
         pFcgiF/fwaTxHwkyN3mel6XBMi/zXozy1sPtBCQnWriwOEGTGTYRt5L3q8g4vOz55Y0Y
         kFTJvGgCyEf/6szkeWHCOsbBylsTrMOH/KyGd5J3T1Ut1Fitonft0g4TLTOUfDjPXsDj
         toiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765963283; x=1766568083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hpASDk3NM2fKiMnuB/c03rnowLUr/0iOxyoTyQMTKJU=;
        b=v01bMSlc9Gx6/Vr0x3T+Xdx/gNgXcbeMhCev4SzdRUV4Sfn2pIn3uy998E+k/mDoW7
         UTM0n9QcBodKXUOQJAA+affGIZpoekeNjvD395mcnBwMq6uRII7vOXwQ5wzyvoUussy6
         vGcZoEU1EHlVYS19pagMjC+HKFLEWCbksgsiK8n5VcqFmPoVf7NY+voawLqkUQn9Hc7h
         k2neRe8PQ1x9TPU56Zf2Qg9q2QqyxF9AJXyLMTlIbfl6L3gkE6NSZFpVxoBMxSf1Ye83
         oz8Yi1TbGR3TXY3pThcb9fgmr3+cQ+USWzfepTWqo2z09IPhFuvJHyoEBACS/oPN5BZW
         idOg==
X-Forwarded-Encrypted: i=1; AJvYcCU0Ey2lf4RAtFcL/Sg7Z5zjm/Yioqnl6LHY0KsjvqfDU0mn9R+WvLpWqoeyaf3XMp2WETg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE3ywLirjLi0+0rfazZj0CF5FzAz8psRcvn2yEHP0lwMg8ijN/
	Nw1l6fC5dwpYa08XAnNjB0nHQNuN/4M5K5Xm7Z1SAwjGOCjhicWOmzSAuNGA3MUVDb415sF0/bd
	iADdWKBOqu+Y8wy8R4obKwTm7jixhvXQ=
X-Gm-Gg: AY/fxX7Jxj7eh5kfQ/DepmhoUZXPniVMIxtQOVAJAuZNFFyGwaokOLUKWrOh8H+PFrK
	6/UyIv2T51A2dRxmu+v8Adna26AcwfRGeGv7A/TJrNKe2aZOWYQIkUOX4pe5r2aQRvbeerBkjw9
	Ezt+jrpjNvPh7RyQkG4KhpXABR3AaIpAQpocffCQEgJkfaAYiOlMRz/97Pw7aC1Pspt8EfapBl6
	lNUIbtH9xZc37RQ9LwSFWQ65ObN8KJF4s9OMetfSzkgsC4Uu9dkd2Br2RvyMv8m3qAaB04fOi9e
	mb69F4k=
X-Google-Smtp-Source: AGHT+IGbtCHKw27pCvvZsPfet0fKW44lW4ZSUv6bzaNu+U1k27zMY7LYW6AQLnWhw2rPPOv2nwF50GCzIeM5JzbwyCc=
X-Received: by 2002:a17:907:1c1f:b0:b70:df0d:e2e9 with SMTP id
 a640c23a62f3a-b7d23a3467cmr1758080166b.44.1765963283239; Wed, 17 Dec 2025
 01:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
 <20251208062353.1702672-9-dolinux.peng@gmail.com> <695de859b8af88ddcf53bca22a3ae57d7026b3af.camel@gmail.com>
In-Reply-To: <695de859b8af88ddcf53bca22a3ae57d7026b3af.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 17 Dec 2025 17:21:11 +0800
X-Gm-Features: AQt7F2odNkg1DixPlkywZk4A1DuU5s3FLmC3a5k0RgKaq-EIIXytmCdUmlfXlwg
Message-ID: <CAErzpmt9HKPfyrc_iW5QjT1=E5mUwFcKJihga0s-WBhqE6uiwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 08/10] bpf: Skip anonymous types in type
 lookup for performance
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 2:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
>
> [...]
>
> > @@ -550,6 +550,11 @@ u32 btf_nr_types(const struct btf *btf)
> >       return total;
> >  }
> >
> > +u32 btf_sorted_start_id(const struct btf *btf)
> > +{
> > +     return btf->sorted_start_id ?: (btf->start_id ?: 1);
> > +}
> > +
>
> I think that changes in this patch are correct.  However, it seems

Thanks, I think the changes to btf_find_decl_tag_value and
btf_prepare_func_args will cause issues if the input btf is a
split BTF. We should search from its base BTF. Like this:

const struct btf *base_btf =3D btf;
while (btf_base_btf(base_btf))
        base_btf =3D btf_base_btf(base_btf);
id =3D base_btf->sorted_start_id > 0 ? base_btf->sorted_start_id - 1 : 0;

> error prone to remember that sorted_start_id is always set for
> vmlinux/module BTF and might not be set for program BTF.
> Wdyt about using the above function everywhere instead of directly
> reading the field?

Agreed. If so, I think we need to add another helper function to check
whether the input BTF is sorted to improve code clarity.

bool btf_is_sorted(const struct btf *btf)
{
        return btf->sorted_start_id > 0;
}

Besides, do you think we should reject loading a  kernel module that is
not sorted?

Thanks,
Donglin


>
> >  /*
> >   * Assuming that types are sorted by name in ascending order.
> >   */
>
> [...]

