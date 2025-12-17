Return-Path: <bpf+bounces-76888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C4CC9169
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57E2D30387F9
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5825334C3C;
	Wed, 17 Dec 2025 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv/E6+Qr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58910322B69
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765992557; cv=none; b=o28MI3OrWiiqoIWyvJp6IdfsuhB77oPuhXUYfQecBLsLYLLWQP/QNTQ9gcYQkzkkPaSUxbXHtTpSV0jkeD/oN+g+PlC32Aij0fXdFX9A7eLjtJni8VIbYBECNVsL1rtAmK8Zyhm1ja+pgkxhZKr2ITGD9W9fgj8WeWrhxmQlIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765992557; c=relaxed/simple;
	bh=816TTWcn9NV206ODMfxMrKRUYk2nto5X9vb9qLhijw0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KZMoDA4a5+aLNZa9SdIV3GHg12mEwzS0sOTfsR5T/2Fgz4yqo+4PBZtJXcCPnzhN+lP2MiHTzmX/hDtr2sj5ayHDdsx9ZLYil0J9qRi8M/+66/0XyN9AYpwLbbabuxeV5TgcHbZtYa2cIk6N/apUtC0ddj982AeGnvOPXar+OfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kv/E6+Qr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f30233d8aso61109985ad.0
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765992553; x=1766597353; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3X0rSqR7eexxd5587l+OlezOO6ZVJRPAIl8d3oe+WnE=;
        b=Kv/E6+Qrtq6Eb6p50rVjxx5D/sQvG9a2nGm0r6VP6RACNVVFDRr3ugDPjeuAqT/vSg
         1ZUc3cVunsuXt/YG8uIpQwEIZY8K92g4gaxUTyRacir/Mkpy77+G4hZcsiTRlINThHZG
         nZHmNO9JAUbCEmhE0Ov4dmlLCvcnB6Ww+j6iszP+/ysbhPjeFjgbyEn/68tbJDqx6dfi
         jWQ0hx1M+ZasYWRhb6fLj5wX/vdr5DaEgQNmpAGOutPfO4gMJHyfKq092lyamdWZFHkA
         m/yBjcvRXkUXXom6pS6pz+GI3xxZu5gGIKp8t7fRsl/sIK7KzqfMj6atu3W4x+BxAT3x
         Yspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765992553; x=1766597353;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3X0rSqR7eexxd5587l+OlezOO6ZVJRPAIl8d3oe+WnE=;
        b=hZThlFa/NGgeLmjwsm7eAZwu4LgQyTADbQ5ZkfQCC0XfHz/0ckF3s27pzL8siPLw3p
         i19gRQEKdUMAQNHrWPnBBbmUiVGYNlcwilrb7PwOFIUoQY4tVYVXZKgQggvQZbVYVm1q
         BTWlQG4751vzKnoSOCenrH+x/ei8YyMrTlhS6K7fT16ScVM3wEUYk5KK+i5oKFDHWX01
         vPw3uPlOyXWo4nlw6eDsvMfAd7+d6bssnvoDHB/2UdjQA+e/zyvEHKpURD4AYaoyDl/4
         u8yo2w8K/7hlNth0osA/dcQY1My9Qb4eOKFqivaNBWpOeO/Am7lzI+38/yZsEyv+mCJk
         JEiA==
X-Forwarded-Encrypted: i=1; AJvYcCWR2ayC0Ngq78+BYqsCuRHv2brkUxpzjo0C4hB2vZW8FCsLXIWGxDuVAMCQgChrAC36dKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx95m/LIXGvJdMzvj6GBxknuwqEjDhjQiKoQ/EaA46DhagDZRfn
	9YpJPMRN+CPmEwBHWZvDmURVh5tyAZv1T3epKx4RQldLbOg41/0idAg3
X-Gm-Gg: AY/fxX4y0X/DBDMiaCoxXQwmTP+rKruIHLxP6yPnnyxDnPjIQZqJ1tCdYzkTaF9uiFI
	F4uweGf7hXD6QFt2ZdC4rTDAZRydescnntoOy8YD28RZcBu7QA5mliNxdrO9+7I+gDxN4Qr92wx
	XqhzvIWMml6Td53skaBJHt8fqR7NJ45B9YfpDhwg2A8CC01wfRthIDzJwrnGk/QPpTsbVwaXQSo
	t9afW3VvF7epiL7OVUvPmrs9AKi0Rx1mPDFW5at3KmPc7ob4KBhuOqIpgUxxNbafQoMuypa+o/C
	mVTmN1dHoR434tvlCGpR4N7fTtt/jtRSLLLxX/3Xi9waB6QRmAtcdkjI+Zs6ajAZZ1gvd86Hr4E
	U8EuRCe0M1fI3esl972V6Kza9JcKGhal1lBNNtkHEuTlJj6cxK+7nWqIefy1vnRZpJ8C3XMM90O
	CsqaoVb8U8WbCfCRMcG5fRYspM0rUg+kXqkhzeq/UZ8PXfOng=
X-Google-Smtp-Source: AGHT+IHe5xcTJoioP0/fElNpvDeMHkGnR4qWB7zRaIuxeI9mQfekOcWk60B96kbveCGHyQLzyXpJrA==
X-Received: by 2002:a17:90b:2692:b0:340:54a1:d6fe with SMTP id 98e67ed59e1d1-34abd6e705bmr17960497a91.15.1765992552573;
        Wed, 17 Dec 2025 09:29:12 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ae8e:35ce:d3ee:94ab? ([2620:10d:c090:500::6:a701])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cd9a40c83sm2020946a91.3.2025.12.17.09.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:29:12 -0800 (PST)
Message-ID: <239e3861b030a8d68f24a5be72346ffedffb8843.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 08/10] bpf: Skip anonymous types in type
 lookup for performance
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, andrii.nakryiko@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
  pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire
 <alan.maguire@oracle.com>
Date: Wed, 17 Dec 2025 09:29:10 -0800
In-Reply-To: <CAErzpmt9HKPfyrc_iW5QjT1=E5mUwFcKJihga0s-WBhqE6uiwg@mail.gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
	 <20251208062353.1702672-9-dolinux.peng@gmail.com>
	 <695de859b8af88ddcf53bca22a3ae57d7026b3af.camel@gmail.com>
	 <CAErzpmt9HKPfyrc_iW5QjT1=E5mUwFcKJihga0s-WBhqE6uiwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 17:21 +0800, Donglin Peng wrote:
> On Wed, Dec 17, 2025 at 2:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> >=20
> > [...]
> >=20
> > > @@ -550,6 +550,11 @@ u32 btf_nr_types(const struct btf *btf)
> > >       return total;
> > >  }
> > >=20
> > > +u32 btf_sorted_start_id(const struct btf *btf)
> > > +{
> > > +     return btf->sorted_start_id ?: (btf->start_id ?: 1);
> > > +}
> > > +
> >=20
> > I think that changes in this patch are correct.  However, it seems
>=20
> Thanks, I think the changes to btf_find_decl_tag_value and
> btf_prepare_func_args will cause issues if the input btf is a
> split BTF. We should search from its base BTF. Like this:
>=20
> const struct btf *base_btf =3D btf;
> while (btf_base_btf(base_btf))
>         base_btf =3D btf_base_btf(base_btf);
> id =3D base_btf->sorted_start_id > 0 ? base_btf->sorted_start_id - 1 : 0;

Missed that, makes sense.

> > error prone to remember that sorted_start_id is always set for
> > vmlinux/module BTF and might not be set for program BTF.
> > Wdyt about using the above function everywhere instead of directly
> > reading the field?
>=20
> Agreed. If so, I think we need to add another helper function to check
> whether the input BTF is sorted to improve code clarity.
>=20
> bool btf_is_sorted(const struct btf *btf)
> {
>         return btf->sorted_start_id > 0;
> }

Sure, as you see fit.

> Besides, do you think we should reject loading a  kernel module that is
> not sorted?

Not my strong side. As far as I understand, when external modules are
built for production use-cases DKMS is used. DKMS will use same
resolve_btfids as the kernel module is built for. Hence reject the
modules with not sorted BTFs should be fine. Are there other use-cases
when mismatch between resolve_btfids versions is allowed?

