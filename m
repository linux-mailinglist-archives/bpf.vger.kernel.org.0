Return-Path: <bpf+bounces-32958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5676915A5D
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 01:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0492849F9
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655F21A2C0E;
	Mon, 24 Jun 2024 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds2b3Eyu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA541A0731;
	Mon, 24 Jun 2024 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271654; cv=none; b=hLEnHS0+q77NTAAsU31MvqJ/nHpwX3M26cJ8PVLkto5sFXAMD7FQ2TWMONTrWtot0bJjokfeMzxU2VWZyiwELs1gQyPnkq2sZM1D7kDM8OTkZENxztOaBXAB6RQtGXCGNHu8v7FbHYsd/BrPGQDXR6cLsy9qLtLkM+z6nDziPHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271654; c=relaxed/simple;
	bh=eZ/tsejhJEW9+MknetIC0IiipTDo2ppO5cy+oTceKOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aeTi3UjTTPxGYG2K7OPQ1OLgm+4/SSbFFqHiliyVycjtYe4rRd9boax5WLLySGYVR7SznNLaH/qtPPuaMcoHAKnvwl+CXGlz6bDoebs6G4W2k8G0OzDf0OZSaZoIcorRO50w6q2cHdnoTNl1GipJUpEHJUaLlaczyvISYfzdkyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ds2b3Eyu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-707040e3017so3282032a12.3;
        Mon, 24 Jun 2024 16:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719271653; x=1719876453; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HbgIUA5Ww9gKgFMAvp89SuldIPQYcPQe/Oqph+Abn7o=;
        b=Ds2b3EyubY2TOSPvE4K3Ey119Thlp3f7NAiVX5SAmWQS8PTedd11OiIWUF717P2Id1
         S/MhGn6ey8lWRitOOmuk7iOBLa7n1hNusUE7WfU0ZIbYFbbzSEMrSWrjxfbxAyX8vOHe
         OAg0yflnFnS1NkVXuULatR9YLzZ7W79+dQJ1D2sjJBLIZ8f3SR9zPd084INpCQA02TC5
         zRNMgw/RVJcQwL477FdCSelRbyInDOaYfJHeGHmEQqC4y2qaBrfzrHqlJavxl6rHdAKF
         9P3ufqwe8rHzHnunj2K5WcOE8KjUHE1+TrG6P8KRIlnsDS/1+AA71tVx/+QQlarj/1eN
         X5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271653; x=1719876453;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HbgIUA5Ww9gKgFMAvp89SuldIPQYcPQe/Oqph+Abn7o=;
        b=fCopp8vk39jegvfhIdzrVzYKZiu7+OcUpAek4GTqQ+9keaYBjnITFBb+8DuKfNpaYm
         wIHnnTagzSgrllKfzbpwuN53Ha3VUjjt1IYS8hihh14UVu2tLGYrAiciIHpU9V0ADROt
         cHlAP+lKWkd7rNVi9nUns7d/C/xODfuPtQct01bXKdM36YlUsdKEpBhoh67wBv89aM3S
         QiEZngQloXbvnq1XrAkv2EBr/IGIxjEdVBZhDtqA5sVrmrang+WpKvzhorCvCUI1nzek
         3AU4x30mfBogJJjXFoNCG6wR8bDpCn4wQW+5mR7cwNJJL6xNueFCg+hfe7yJQzQy6m9l
         dbmw==
X-Forwarded-Encrypted: i=1; AJvYcCU0abDUx3IKTYDcKPI4wiL3s/Yj8KuaKT6vh1F5zJTcJljt+RC3bgy1JhDrquLrOSk6s6otubeDM0ZW+qh4AEfznpt7F6o6PmHG9iMWpTn0NfIJTdheKWi5mY55D+KxXuw2
X-Gm-Message-State: AOJu0YyoXw9NDNbMOlJAksso6RpPsqgsyWfFogJQOmqg8ioSdAfugk9z
	PyiXCTkAq7vrSwme3EwEW69e6EEeSKfwQobWePepw6SUBSl3BiQ8
X-Google-Smtp-Source: AGHT+IEnuLnGHYWtlo8YAYaho0QOw5BT3xFQXD2JXT3gL5OtGyQB083XvSVfXN3hMvuFFoO90tQc0w==
X-Received: by 2002:a05:6a21:78a2:b0:1b8:5c3c:794f with SMTP id adf61e73a8af0-1bcf7e3caf7mr7593524637.10.1719271652677;
        Mon, 24 Jun 2024 16:27:32 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819db94f7sm7316285a91.35.2024.06.24.16.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 16:27:32 -0700 (PDT)
Message-ID: <6d0a07082a064fa8b410a7e08d8b6b628845ac72.camel@gmail.com>
Subject: Re: [PATCH] bpf, btf: Make if test explicit to fix Coccinelle error
From: Eduard Zingerman <eddyz87@gmail.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org,  song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me,  haoluo@google.com, jolsa@kernel.org,
 yonghong.song@linux.dev, bpf@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 16:27:27 -0700
In-Reply-To: <99A36D9C-E171-452D-B0AB-AB0EE6C6410B@toblux.com>
References: <20240624195426.176827-2-thorsten.blum@toblux.com>
	 <faf99c63015c6a5f619d85bd45405b91a3498bf9.camel@gmail.com>
	 <99A36D9C-E171-452D-B0AB-AB0EE6C6410B@toblux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 16:08 -0700, Thorsten Blum wrote:
> On 24. Jun 2024, at 13:16, Eduard Zingerman <eddyz87@gmail.com> wrote:
> > On Mon, 2024-06-24 at 21:54 +0200, Thorsten Blum wrote:
> > > Explicitly test the iterator variable i > 0 to fix the following
> > > Coccinelle/coccicheck error reported by itnull.cocci:
> > >=20
> > > ERROR: iterator variable bound on line 4688 cannot be NULL

[...]

> > #define for_each_vsi(i, datasec_type, member) \
> > for (i =3D 0, member =3D btf_type_var_secinfo(datasec_type); \
> >     i < btf_type_vlen(datasec_type); \
> >     i++, member++)
> >=20
> > Here it sets 'i' to zero for the first iteration.
> > Why would the tool report that 'i' can't be zero?
>=20
> Coccinelle thinks i can't be a NULL pointer (not the number zero). It's
> essentially a false-positive warning, but since there are only 4 such
> warnings under kernel/, I thought it would be worthwhile to remove some
> of them by making the tests explicit.

Sorry, not really familiar with the tool, but it seems like the
following part of the itnull.cocci fires the warning:

  @r depends on !patch exists@
  iterator I;
  expression x,E;
  position p1,p2;
  @@
 =20
  *I@p1(x,...)
  { ... when !=3D x =3D E
  (
  *  x@p2 =3D=3D NULL
  |
  *  x@p2 !=3D NULL
  )
    ... when any
  }
 =20
  @script:python depends on org@
  p1 << r.p1;
  p2 << r.p2;
  @@
 =20
  cocci.print_main("iterator-bound variable",p1)
  cocci.print_secs("useless NULL test",p2)
 =20
  @script:python depends on report@
  p1 << r.p1;
  p2 << r.p2;
  @@
 =20
  msg =3D "ERROR: iterator variable bound on line %s cannot be NULL" % (p1[=
0].line)
  coccilib.report.print_report(p2[0], msg)

Is there a way to add a constraint here, requiring 'x' to have a pointer ty=
pe?
(So that the rule does not match, as it clearly shouldn't).

