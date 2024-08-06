Return-Path: <bpf+bounces-36491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767B3949898
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 21:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C104FB213AC
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACFF150990;
	Tue,  6 Aug 2024 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cehIxl6D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440E770E8;
	Tue,  6 Aug 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973572; cv=none; b=jsQR1ycBJjKWZuYmjmaoydgagXhCXemeA5f/dTbmvYb89qoXR/JGUSciK77Y7XGYwKGZ2furzHavuZz3uJMRf35SPv65VuyGA+b4QxAcxt59ASNs/wLKiSCaZVoocQA7LMYLXhKSKz2ebxSnVlNLb+EFhmDCX/z2LTIjbCuDjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973572; c=relaxed/simple;
	bh=8OVcb3dZ1VO4XcyfPRDSzFf3tzDg5T8DtRci4AcrYHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cqe63v1oeV2s1j3beihxgxgWxm6V4Du/AVHaqct+Me49WpDUe3ctWVUkB/YFjsNaCWX83sNe1KAU4+XShAZltdYBnGS8/cg4DEA39n5CvWfe0MZ0j3lOTkkXaS/g6XJXdkFgiuiNBXa9e/dgTz9vEYiqMUx9KSrePLvRji8GHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cehIxl6D; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7bd16405aa7so475892a12.3;
        Tue, 06 Aug 2024 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722973570; x=1723578370; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lckbPoFrnafIqmtpB7EBRaFzQq1hvN6k/HAUf2JiMUo=;
        b=cehIxl6D9cbeMvKwGVsSyEfDyXOoIdr/HLEL5fYOCDTj6fB6Ao7f+nTeA0qyA+C9B2
         S0yOTItQ840TjqQkp+KzNnSRahMUnbVThO0bKncsSTkFyrOa84trz7ApLNDtRFXKeg2e
         KrwHRsj2lc09lcEEBQ8ODaipirKBtXXCiLYp87l7/0G7+Dvq28yFWV9CUTi0ZgfZHJcR
         d/LrN2YtbDHs5ID+c0/pWv/c3JArGCqEqK5Or8WOjZtuNbJ8pKQ6r+03E27MkxVaCVSf
         P2FULBm6PeV7y/WbMl6lXuB1CAWKE9gLlO8a/CoRPjCrPHUMLpU/bc5OqG/zvQxy9G+n
         TXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722973570; x=1723578370;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lckbPoFrnafIqmtpB7EBRaFzQq1hvN6k/HAUf2JiMUo=;
        b=ZXZsNdJMRVzGZU/403bS4HwXn0ZnDWtjf2efBQQx1c0pJzrAsW8LyhOKy936WdO92T
         anLphBW7mw70pHXatCEWgObYglHAXc9BxhN7L57uDsu47dBf2QflxX45CXMfJW5rxVeJ
         lgxXK3ciaJk3iaz0UgCb6h2ftTZOTtJFboUGvysVxsLzfphDVnJLOqMGXjqoFgKE8rRE
         B+Grv6LbasIe8UJ7BKB7ctw4Qxk/a9sV99YtxRu8UHAbzKII2m2uM3jmN63eAegnWfBA
         BDKJxt1WTKBQ7UeKrmLAGVNq64jRmJ8GMIBbtgax1wfMcMdi4eDkI/5Qa7oI+lKFppuw
         rVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+kvreBikwfnfmPSQzgA4BzrUfvUDsA5gKtoFt8OHUgoQoym9bTz6kDOsXj91cy+mTl1BVdueFGkeAc4wHKLYZQKpT6q4OpcmD5OvEJ/V3TTQhlUguSblEDjZM2/5GgtozSwwx
X-Gm-Message-State: AOJu0YxLqypO5qW+L339I8AZREmV8xHDoh/GNubscD/9L4Umj9n7SIqp
	6JpMTQ+vcdsUpnqCmDuzQDJKjLabNiQ3kJovGu2dyC96wvIKXGbE
X-Google-Smtp-Source: AGHT+IGUE23FnUmKf1bpId4Cq7YAtT3ivLG+MQoKRKx+bujxGq9pEDXsCjRd81TBYgavPovWcshCJA==
X-Received: by 2002:a17:90b:383:b0:2ca:4a6f:1dd with SMTP id 98e67ed59e1d1-2cff955cbcemr14382462a91.41.1722973569960;
        Tue, 06 Aug 2024 12:46:09 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb390ca3sm9494819a91.57.2024.08.06.12.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 12:46:09 -0700 (PDT)
Message-ID: <e00616fe71af77600c77d6c894f8a64ced12c55b.camel@gmail.com>
Subject: Re: [PATCH] libbpf: check the btf_type kind to prevent error
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,  Yonghong Song <yonghong.song@linux.dev>,
 jolsa@kernel.org
Date: Tue, 06 Aug 2024 12:46:04 -0700
In-Reply-To: <57d88cd3-3cbc-4d30-be82-92990a7a50fd@linux.dev>
References: <20240806105142.2420140-1-make24@iscas.ac.cn>
	 <57d88cd3-3cbc-4d30-be82-92990a7a50fd@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-06 at 10:38 -0700, Yonghong Song wrote:
> On 8/6/24 3:51 AM, Ma Ke wrote:
> > To prevent potential error return values, it is necessary to check the
> > return value of btf__type_by_id. We can add a kind checking to fix the
> > issue.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 430025e5dca5 ("libbpf: Add subskeleton scaffolding")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> > ---
> >   tools/lib/bpf/libbpf.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >=20
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index a3be6f8fac09..d1eb45d16054 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -13850,6 +13850,9 @@ int bpf_object__open_subskeleton(struct bpf_obj=
ect_subskeleton *s)
> >   		var =3D btf_var_secinfos(map_type);
> >   		for (i =3D 0; i < len; i++, var++) {
> >   			var_type =3D btf__type_by_id(btf, var->type);
> > +			if (!var_type)
> > +				return libbpf_err(-ENOENT);
>=20
> Could you give a detailed example when this error could be triggered?

I'm curious as well, tools/lib/bpf/btf.c:btf_validate_type() has the follow=
ing code:

static int btf_validate_type(const struct btf *btf, const struct btf_type *=
t, __u32 id)
{
	...
	switch (kind) {
	...
	case ...
	case BTF_KIND_VAR:
	case ...
		err =3D btf_validate_id(btf, t->type, id);
		if (err)
			return err;
		break;

That should catch situations exactly like this one.

>=20
> > +
> >   			var_name =3D btf__name_by_offset(btf, var_type->name_off);
> >   			if (strcmp(var_name, var_skel->name) =3D=3D 0) {
> >   				*var_skel->addr =3D map->mmaped + var->offset;


