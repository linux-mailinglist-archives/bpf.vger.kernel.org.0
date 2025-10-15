Return-Path: <bpf+bounces-71062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2539BBE0EEC
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 00:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E475424FE
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 22:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4600330CDB8;
	Wed, 15 Oct 2025 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZJ65puO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123E3101D5
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567371; cv=none; b=fKtPBwC2B7eqIfm3FElJ/2BSA6xrbH4Sd5mTmkJalLqP38KWY+tJAmpfxW6paR3GfG3oyktPS9wp7O+fER01W6K1mEWqGNIvapsQaHVk2kCyuo8VysyesTT/te1RSEH/yqCD7oMnPfbQ8t7RWWbtpaXO2RiaWSpsZBCSWMmyRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567371; c=relaxed/simple;
	bh=kHssTEGcABWkZZi9jJhYOfEznm/36vheQIa5I3L+mII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxxN8fr3kGUJ+N+wnl3wYaaxw/DnEPIRkuFg8A8DrcCHBjp5W+XMO0FUm/8YWzHDMzu/u6OlbOdXJ/jLZPyb7VAaJ/zOVOm8y8nHIohCoN3I0E1PRozPEkyPvclrTrSFPa16da2VFfJr/VTPdjjKGU3KYJugLuBybxsGSGVn9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZJ65puO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so148594a91.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760567369; x=1761172169; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VjLug/eSqwgfkOr0pTN6aVQ7Me7F57zWSfQGAoqH24A=;
        b=HZJ65puOwCFoHGMu5CCGN4hGNT4ArRgzFHnjbyEaxrxQTsBKCgQqGUsYUy56qpuNwz
         6rmD9ulvCwphiScyNSGHnHi7Mz+ee6J/UVY0PsIXMqZUzq1NRKPgDwckfb2Z9ZUk4ogV
         Nsy1CfP69W3nZILgHc4pwkcknh2Bqy9rgXU8Y/cFdgWIL795WaUlvOKZVnxiEkV9Z5cq
         p2Qk9+wq+jkR5xnf15OJu9Al5FOC0k++OtpVO1aLl31OdZRp/8m+1EatZe6Czn72ATjZ
         y0GZyZz/5lE+cfE47hzt0+kmP9NKmFpSMeJmwqjaREgd7q3inm+jPlgm4OfVhmFAPc+B
         uvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567369; x=1761172169;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjLug/eSqwgfkOr0pTN6aVQ7Me7F57zWSfQGAoqH24A=;
        b=vCeLr7kXgdvOZ0zkwTkDVuTx/rY4Xx/fnbwNoMPoss6e2Gu0B47fJ3A5CPstRyVFcU
         0rvwYYxrj1C7Otb3EDGSGnp7axTzfTv3hT8b7DhtjM/F1UzpY1Kbh4UKV8rUdia95muG
         FjVGaJH0tweMbZDfQ73nfIfw++tN0jXfiXi2tWyMJrzJceUh5/ezvFovOUcNGwGofSZQ
         VAvKQCJaMnwcNKeUrYn27CVfWkgcLabKDOj3uywjrG7feViOiHrRNMBuNencJd4cNysm
         DHKqVBx/A87MX47rBjlyI2vrpbrg5GmmQK5uA7JVN3OVphWFPGOL9cLU4ECbeR+yjNnF
         iIpA==
X-Forwarded-Encrypted: i=1; AJvYcCUHS08IA16+Ee+ouUTrHF8wzwYtWrIj1XKQNEHJES9dJmQyQwEcWKNfespTJL/TpEHs6zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKAZnEqTqYo6NupDxmyFuB6wkGfjA/LLs9p0viorDKZgepsRE
	Iuf02bJM7T2BSbfgthsasSuJ5cBj9K72uRUYMAYUasK2pomU2eb2ytfx
X-Gm-Gg: ASbGncvV0950XFkyGn1ljHwr11+ktjeBqfAe2cRcOGxbuiIgwCvqLiX5ikqT9iWMp3q
	ycb5+hj05GGKNp6TeKxq1Og1SeMqk3uPndDk6X8T6NX+bAHkd+bMNdE+L0GqeQ+vR1fmvnTZFxi
	jY4t0hXdmdXrJCOuRJFjetSx2OaObBk3Z1pf0t/ky2D8OliVICNhHhitT/uriBm8Xi3OwZylX7F
	w/kh1uqr+/0l4pDz+FfrK7IJDc4LQXTMm6MMI6483QBNanDL5k67MRmCqJGcoXlwlF9cGKUWOoc
	Xt/zEBVu4Ku6C5cSrckK0jnlFps95L0LZL1XzckD4iNiB0Eqg/URGsHUhaP9yAobpG35zq2ApP1
	k58V4Fh6Tm0trv8hq7g2NbQnSepu6nZ27dxff8mxuPpqjxbE7MpPTiDOtek0VpMsMa2lMHwDsJQ
	==
X-Google-Smtp-Source: AGHT+IFsNW1Kqo7VIuO28XRDV3+or11VtytUVSt2uDZZzQ5AR+hzzgp5fqMR4stSnQXU1IeXKBH4Fg==
X-Received: by 2002:a17:90b:1b11:b0:32e:70f5:6988 with SMTP id 98e67ed59e1d1-33b51391ab4mr38038126a91.32.1760567369568;
        Wed, 15 Oct 2025 15:29:29 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61ac7cc0sm20666476a91.19.2025.10.15.15.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:29 -0700 (PDT)
Message-ID: <aeeed0cab6875dbef70857868df003a638d647d8.camel@gmail.com>
Subject: Re: [RFC PATCH v2 08/11] bpf: add kfuncs and helpers support for
 file dynptrs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 15 Oct 2025 15:29:26 -0700
In-Reply-To: <0cb5dec3-5019-4ed9-8cf5-ed2ec0d8f74c@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
	 <20251015161155.120148-9-mykyta.yatsenko5@gmail.com>
	 <a2b0241a646c991c280fbc35925e0a52d01b419a.camel@gmail.com>
	 <0cb5dec3-5019-4ed9-8cf5-ed2ec0d8f74c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 23:25 +0100, Mykyta Yatsenko wrote:
> On 10/15/25 23:16, Eduard Zingerman wrote:
> > On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> >=20
> > Overall, lgtm.
> >=20
> > [...]
> >=20
> > > @@ -4253,13 +4308,45 @@ __bpf_kfunc int bpf_task_work_schedule_resume=
(struct task_struct *task, struct b
> > >   	return bpf_task_work_schedule(task, tw, map__map, callback, aux__p=
rog, TWA_RESUME);
> > >   }
> > >  =20
> > > -__bpf_kfunc int bpf_dynptr_from_file(struct file *file, u32 flags, s=
truct bpf_dynptr *ptr__uninit)
> > > +static int make_file_dynptr(struct file *file, u32 flags, bool may_s=
leep,
> > > +			    struct bpf_dynptr_kern *ptr)
> > >   {
> > > +	struct bpf_dynptr_file_impl *state;
> > > +
> > > +	/* flags is currently unsupported */
> > > +	if (flags) {
> > > +		bpf_dynptr_set_null(ptr);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	state =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_dynptr_fi=
le_impl));
> > > +	if (!state) {
> > > +		bpf_dynptr_set_null(ptr);
> > > +		return -ENOMEM;
> > > +	}
> > > +	state->offset =3D 0;
> > > +	state->size =3D U64_MAX; /* Don't restrict size, as file may change=
 anyways */
> >
> > If ->size field can't be relied upon, why tracking it at all?
> > Why not just return U64_MAX from __bpf_dynptr_size()?
>
> Good point. This is a little bit ugly part of the implementation=20
> bpf_dynptr_adjust()
> is still implemented for the file dynptr (for the sake of supporting=20
> generic dynptr API),
>  =C2=A0and it sets the size, because it makes sense that=20
> bpf_dynptr_adjust(start, end) leaves dynptr
> with size =3D end - start.

I see, makes sense.
Thank you for explaining.

