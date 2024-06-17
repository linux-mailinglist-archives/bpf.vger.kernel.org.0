Return-Path: <bpf+bounces-32318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B090B6EF
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 18:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A681C237F6
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774BB1684AC;
	Mon, 17 Jun 2024 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai3N53Mx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080F17C8
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642806; cv=none; b=PjC4XhbsgScSQ5qveGwnjaPNIfru5IKFE3jMzMUHCgl47oGLDDkPqNWD1d+5PngCArlYkdeEPhbQEFna7H+EDHhFPfiAp7Y6ZNDO4Vt1k4a6gtwLarZx6i6pwdgF/Pdx2eWePod5rHgnrGXJmD2N3EM2kjYSKi311Gs+0dUrAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642806; c=relaxed/simple;
	bh=5G2SfPsrcC+3f58CwZ/WmO6YMelDQjnO2aGEcBHq5gI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CRXbQ9pPStyeJPoXyK6wOWSWCUuZz40ZEU/spwcjnobwQjQ8X8tH72GTDTXAgJx1OUhyCyGQjX7yXkSeLvRqTo3zfh2G+EislW+YDZ9ppWXJtEFQ/VtjOfGtnU2TqoURrX5EMnOHaXZxrLtlSiRhht/BhEODYSja7DuyrMyLHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai3N53Mx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-706192a30d4so189458b3a.3
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718642804; x=1719247604; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lVdPSEIaDf7Hqen7Olv8xZ/N+HJd1lr3IHNT51P6ZxY=;
        b=ai3N53MxdfR/1hrVAM7Xob8cte9h1vNP/nya1HeXB6cIHjXlSBAFpuUA7IWssaBWmi
         CFQmJr40ilAcoAvHRZcRwHcsJ6mWTAi/0zFuYKaXO9pv3kTnOQ2IQqrvMjaBXnLNpSbM
         1ctc8KSPleGnmw1MbjiAtPllDL9xuuNjcOYkXCIFEaW4uJAmg0Uc+gANpxEVoDVmGt8L
         EqKpcXe/XGLiHkZqAPsZlJv8kltDf4Bi7CEGK18lPdwdKXKb+76eQ4hdaIaxhLivxzjU
         EDODKhZMppIbXVrDJY5kdQXQQlh3SIkC+BBKUFda+57zc/X8DzdLdabp2UqDrGnbYN3o
         F0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718642804; x=1719247604;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVdPSEIaDf7Hqen7Olv8xZ/N+HJd1lr3IHNT51P6ZxY=;
        b=HgE2mEKYF5oLWpNNcBTV6GMNleUgW74zKONzKw7IX0pfl6NUVHcKeXKv06CrJzfY5L
         lNnf1YEPNIPWw9AhVYe+Nn4grIV18suE/i3QeKMJeY7JucO3Q30SWu5tSwKERc1ZXV8m
         tF+MRWwb/PjqkRG4oU2t0EGmHDTKE1U5MlxK+IPO459unBVA2qCBlHKQGPHLN9PXLaSZ
         Rxn1yLLaL00JkV7jghXDBe70P5UWzTxrf15jKhcTIUnBH9vZ4pmXgF+8/nmJ52wdwg5V
         qieBdpcsD6WKsIKCvdZViNNIoO2VrwfvihIXzRGTe8Uud1OVj6XaHAC4uvFYBtzo7ppB
         Kr8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaol3Ez3I/nCWPqFc7c4jyqkBtv8cXs9PzGrawaVx4mY5D/iIh7FIBMV6H/+Qaz5agwe6Qcpi8ReeO/t9/LET01VSY
X-Gm-Message-State: AOJu0YzL6CQzbsbkyGhEWk8BMq5dNWl4rpgY/t7yMPsq6fpsVmxnlONG
	YLyu43GA2H+/JXy21kzKOBbHleFJAqDdpVrsSfWFWgI9YRKLO6KK
X-Google-Smtp-Source: AGHT+IEPIl/8yfvYbWIrYalJIKEq70ibK8zFVOR3ft//kTamIS8vhqvO8AJqVRvrVnTtGs/2pM6afw==
X-Received: by 2002:a05:6a20:8404:b0:1b8:b517:9bf9 with SMTP id adf61e73a8af0-1bae7ebacc5mr9733328637.25.1718642803733;
        Mon, 17 Jun 2024 09:46:43 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb90a52sm7518577b3a.210.2024.06.17.09.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:46:43 -0700 (PDT)
Message-ID: <e022b0e53c1dd04daf3f29d07af1870bb80acf9c.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 8/9] libbpf,bpf: share BTF relocate-related
 code with kernel
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz, 
	bpf@vger.kernel.org
Date: Mon, 17 Jun 2024 09:46:38 -0700
In-Reply-To: <78d4775c-2b26-4eec-a032-a0d61052395b@oracle.com>
References: <20240613095014.357981-1-alan.maguire@oracle.com>
	 <20240613095014.357981-9-alan.maguire@oracle.com>
	 <3a1dd525bee2875f370e73a0416d115018ed7e52.camel@gmail.com>
	 <78d4775c-2b26-4eec-a032-a0d61052395b@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 14:31 +0100, Alan Maguire wrote:

[...]

Hi Alan,

> great catch! I think we need
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index da70914264fa..ef793731d40f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1676,14 +1676,8 @@ static void btf_free_kfunc_set_tab(struct btf *btf=
)
>=20
>         if (!tab)
>                 return;
> -       /* For module BTF, we directly assign the sets being registered, =
so
> -        * there is nothing to free except kfunc_set_tab.
> -        */
> -       if (btf_is_module(btf))
> -               goto free_tab;
>         for (hook =3D 0; hook < ARRAY_SIZE(tab->sets); hook++)
>                 kfree(tab->sets[hook]);
> -free_tab:
>         kfree(tab);
>         btf->kfunc_set_tab =3D NULL;
>  }

Agree

[...]

> > > @@ -8451,6 +8522,13 @@ int register_btf_id_dtor_kfuncs(const struct b=
tf_id_dtor_kfunc *dtors, u32 add_c
> > >  	btf->dtor_kfunc_tab =3D tab;
> > > =20
> > >  	memcpy(tab->dtors + tab->cnt, dtors, add_cnt * sizeof(tab->dtors[0]=
));
> > > +
> > > +	/* remap BTF ids based on BTF relocation (if any) */
> > > +	for (i =3D tab_cnt; i < tab_cnt + add_cnt; i++) {
> > > +		tab->dtors[i].btf_id =3D btf_relocate_id(btf, tab->dtors[i].btf_id=
);
> > > +		tab->dtors[i].kfunc_btf_id =3D btf_relocate_id(btf, tab->dtors[i].=
kfunc_btf_id);
> >=20
> > The register_btf_id_dtor_kfuncs() is exported and thus could to be
> > called from the modules, that's why you update it, right?
> > Do we want to add such call to bpf_testmod? Currently, with kernel
> > config used for selftests, I see only identity mappings.
> >=20
>=20
> Yep, we don't currently have coverage for dtors in bpf_testmod. I'll
> look at adding that. Thanks!

Great, thank you!

Eduard

