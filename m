Return-Path: <bpf+bounces-45817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C594A9DB324
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 08:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7C5B21BBC
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 07:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF201482E7;
	Thu, 28 Nov 2024 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZxuFi7p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071813A865
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732778821; cv=none; b=dGdI6wCuy0MxZlrW9S9MM6vKzfzI020ZWHXMD3/0o87a1WukGCsy/8mzaBrBkZl1g8SBkU52jTvfzLSqB7AQ7vBGCkLTYySeLFeCoBAab7E9aIRs9RznbR7BhpnnkWtmEJ65sSk2h7yaCPeynXyYRrSypQeN8tR4/E7n4I9ho0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732778821; c=relaxed/simple;
	bh=CvgPoas3O/Mdpw3fEZyKN1JT06pcypE2aDOYg7CrFpY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lDsbWjrU5+D4bS4IbD53lzBqnCm9CxAz/rQwwbXSpB4czeNNVfwElj6m8U4yU35VGidLNoauNw6y0KlbSjneCSzS2Ns0bIYwmiR2ysBN+tUyQBH9G6qvgY9xisRBW862xbTa/5L/PX9NNnI8Q1c9JhQOd8W9rJ/SscfNnyqainY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZxuFi7p; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ed91d2a245so434600a91.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 23:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732778819; x=1733383619; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x8YrkMf1Gkxju0oeCWjXF31SQhEBlD8PBUDbdNRIB9E=;
        b=iZxuFi7p3V+XpN8Pzsie9PTYc4OULQEciQ00/6x6UU4cBTmV8TREUG0HDU/gjWqslt
         KxqyGvnbtnX2cdSwiaPOsSIJCxb2cofdXVGMvhkT9dW3Z+pHmZ+cmf0d3ERG/i/QyMOK
         SihfFpPnqirbmdjjb5DJKBuNOpLoGyiDYTfnk+mJj5d3hAbchKtR3VANDbxIzwDCj1W6
         LV/HpAZEZwViKfS/PqUbag4At2ZgSPKF3En4UGZlHyeIwBNhe4WfEkRMUOtaVBToj324
         +HPRzb5LcCO/vuibNVOoGBBRoHZQc7x7e7HTfvMqLeQAA0aF/KJMeIwK+KOrsnBtxM/i
         i2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732778819; x=1733383619;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x8YrkMf1Gkxju0oeCWjXF31SQhEBlD8PBUDbdNRIB9E=;
        b=ij/5lfCbPb1zqxfHV01gfwMMzQuhXwEk8Ox6JBg3XNFRUmf2m8ioyicHKsqeEYcJBV
         Rgr+dHKuuJjVwY5esJlgVWRC2uPvHj6d+BN9gt/9U2ri1i20y2ZJcKlBFBKY1OmY2zIU
         63JhFRwpxN7LDpUmeHYYgvc+sdRcbtMJ/HO4tIrheTwUI4lDnefuTW8xyThuFtneWuXf
         9iPtWWfxH6OX26xVcOU8kEofIjIrLg0sDbFI+9Mk/jhmHl99dvtZ3UUWXzp4948PQpJS
         GbkKSgalozrGFlvrahlWNKWB/tZPQH6HoXY+Vv/MPgvbgGtK1M091RmeDUqHpm0Ohk5K
         47gA==
X-Gm-Message-State: AOJu0Yw6ZDPuGThYGNtJFvXOWmkUcN2xKhulEMr+FFf/o7pACuX55Cfn
	o903RaW2EdWFrnPwtJjC4lb3Q/S/G2WYwdsPLv/zwcvxIKzsIXP+2VORZA==
X-Gm-Gg: ASbGncsMJUlv0eE+AmZn622OPR+UGYabnGdGFelhfMDkCwHxE44UZw5jS+diAOEjw8s
	/3mFLr5vd16em75IxhxR087WHQwrJLDDRLIXkcEzjYOsdVw263Y7JjfpzBRgQDlEWT2PKgO48qB
	W5ouveYVGhS7fjxCiwWRRaUOit+B0D2mqSIYmQxwsH/hUuqu9RKJx8A+lw+hQAsVENcVJ0PirLt
	sXJ6GzcHNUzr7MJS4eMPcARu5HQ+UIl9omUqYWKAvb+EXI=
X-Google-Smtp-Source: AGHT+IGj4D6fMxdOUyYGWMlLDYANMzqWEtVI1ip8nOmlEVdFg8hFPAPhR/Goljdpe9JdBRTvul49KA==
X-Received: by 2002:a17:90b:2250:b0:2ea:a25d:3bc1 with SMTP id 98e67ed59e1d1-2ee095c0040mr6604230a91.28.1732778819253;
        Wed, 27 Nov 2024 23:26:59 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2b2b8524sm765604a91.46.2024.11.27.23.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 23:26:58 -0800 (PST)
Message-ID: <3587e5033070486ac4351f7be2a5f4428fd7a633.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf: Introduce support for
 bpf_local_irq_{save,restore}
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>,
 kernel-team@fb.com
Date: Wed, 27 Nov 2024 23:26:53 -0800
In-Reply-To: <CAP01T75nGn+sXDoa6N8yj_prtaYZemdCZtm_sNOzE7KvZzzpOQ@mail.gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
	 <20241127165846.2001009-5-memxor@gmail.com>
	 <8559a9a9892311772778268eb9cee7c533a576d0.camel@gmail.com>
	 <CAP01T75nGn+sXDoa6N8yj_prtaYZemdCZtm_sNOzE7KvZzzpOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 05:39 +0100, Kumar Kartikeya Dwivedi wrote:

[...]

> > > +static bool is_irq_flag_reg_valid_uninit(struct bpf_verifier_env *en=
v, struct bpf_reg_state *reg)
> > > +{
> > > +     struct bpf_func_state *state =3D func(env, reg);
> > > +     struct bpf_stack_state *slot;
> > > +     int spi, i;
> > > +
> > > +     /* For -ERANGE (i.e. spi not falling into allocated stack slots=
), we
> > > +      * will do check_mem_access to check and update stack bounds la=
ter, so
> > > +      * return true for that case.
> > > +      */
> > > +     spi =3D irq_flag_get_spi(env, reg);
> > > +     if (spi =3D=3D -ERANGE)
> > > +             return true;
> >=20
> > Nit: is it possible to swap is_irq_flag_reg_valid_uninit() and
> >      check_mem_access(), so that ERANGE special case would be not neede=
d?
> >=20
>=20
> I don't think so. For dynptr, iter, irq, ERANGE indicates stack needs
> to be grown, so check_mem_access will naturally do that when writing.
> When not ERANGE, we need to catch cases where we have a bad slot_type.
> If we overwrote it with check_mem_access, then it would scrub the slot
> type as well.
>=20
> When I fixed this stuff for dynptr, we had to additionally
> destroy_if_dynptr_stack_slot because it wasn't required to 'release' a
> dynptr when overwriting it.
> Andrii made sure this was necessary for iters so now slot_type =3D=3D
> STACK_ITER is just rejected instead of overwrite without a destroy
> operation.
> Similar idea is followed for irq flag.
>=20
> Just paging in context for all this, but I may be missing if you have
> something in mind.

I see, makes sense. And is_dynptr_reg_valid_uninit() has the same check.
Thank you for explaining.

> > > +     if (spi < 0)
> > > +             return false;
> > > +
> > > +     slot =3D &state->stack[spi];
> > > +
> > > +     for (i =3D 0; i < BPF_REG_SIZE; i++)
> > > +             if (slot->slot_type[i] =3D=3D STACK_IRQ_FLAG)
> > > +                     return false;
> > > +     return true;
> > > +}
> >=20
> > [...]
> >=20



