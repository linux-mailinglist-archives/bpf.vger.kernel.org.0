Return-Path: <bpf+bounces-71968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C98C034C3
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 22:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5FF81AA192E
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 20:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD7B34DB53;
	Thu, 23 Oct 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfTdpcb4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C58A2737E1
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761249593; cv=none; b=MwMiL6qEosjhrY2GzvdRtjCJHCbPAxTLgyx75NTVOKnY7Re0pOPJtosBqY0cyFU8FyFUjYW6RvvQMsW4dBIsC+Lu9RbTsX1/5YhM2lxeOujny+nKtzHgGrmkc9KPZqJsaJYcnNk/vcORYm8ZJ+J2BinAt+kAqbguKwMRC0S+sks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761249593; c=relaxed/simple;
	bh=PVoflk5bks2rDfIyc6nMhrTwcevQLQDmmSqaK6i9AJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r8hJpcXNu7/NlpYjmdSQZMtDZkAmKw7dFDx8OiNtWmfsNMtopLeqFHLxwATA1wnib28skVRVoc5RF+6drUGdg1BS2DC7x1rRdqA3jstC/M9vD06Xvx55shD3PnLtVQI8kjIt2kdTQAlN3ZAkiloPMt6sMMthbEIW+udR3x0z8lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfTdpcb4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a27053843bso1751304b3a.1
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761249590; x=1761854390; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c+D/Wy18jaKdjnIGgDJTgXQPS4lujBJF2BCSV9abIvQ=;
        b=VfTdpcb4TgjNQb1TUMXoETeRUKPw1lSurnr1TYPOPjh5lK4vvhRc1ug6X26RNo2h0M
         eYa7esRDcMLLixz+8XVdEvtLwjPkiukspck9ytrdcU4pbG7zWX/5L4ACJ/tSWMYAT9i2
         SscM6445NXNDV0s4I+coDhzHvTmbW2l2o3ztd9VrfVeOX00AnvJptyK+jUUYS5Q0TYuP
         IGVs1xvgOc5LH4OVY7CQNdVjdaAEmqomjKe1wKJY1kEUNepaer67T6UlfV7cRuYN7iv/
         bNTFv0zEibu5WdXuLS59dS5hi0Ipgdy/PtTPYK7ih9pTd0lIwRPDW+F/nPJpvK9MT/Mt
         64+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761249590; x=1761854390;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c+D/Wy18jaKdjnIGgDJTgXQPS4lujBJF2BCSV9abIvQ=;
        b=k2/dfu0R0H8suptvcBggShquGwsagJoFbe4uS0T1XtSRSr5PXk1bfEak5/ymmU9ELs
         WbVO8JYKaLh0cwhRq0JUUXQmLcEfyY4HJhzui0+ldOJn1RIWGYk5xhN8lGsPimZ/OFG8
         LvJKSzBqxFGgzdrE5QAtml84cC06eyfkpEL9XSy0dClMBnn9vvT6AYp4lISLjNkwuBPQ
         gfTQ6SW72UIMrzbuiK+Kp8nF8++E+gT0tDZSCbDIVZLiKOXEe5IdOynbAHi+Z1Q98n6l
         bl/Gwit7zOwpx5ALWpWJYZJJOCyU9Zc7F8ug6lEw7WaeE55CrvvtjoGhHY6G2LVk09uF
         6SFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwuzrTy65JC33tYoJ0iugYMPWpPH0hoRUBWWYsLRSWiWmQydN9Dz62u081F0xi28xiVo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZn4mejcP38Z6IehVaLcDehZTg+UGYeuLkuPBvTUw2FO3VrJ9y
	ukZ8JyRAQZgq77Vg27j0clzSKXR5VbIliwaqZgtzU5H790CsVB4Sqn0L
X-Gm-Gg: ASbGncu0//ghgHIfni0dHlmfJIuBsQq1FTXMSyFl1Qi8OoOq0GMNqpZulK33PVU0jIt
	25hIQDyvJa9sqnD694QUeiyN8UKwaK8zBKPWRU8xfx+UtDUgqaeGXtJApEiJull9syCKZL6RPPR
	Tauw46zjp88LNzKMst1dzqBDXSEYW8j5OocnBFU5waa2HW6S7EwT+K2/mztNXfq02T6v4vc4PYv
	cVovYBrrcWB77jBalG4Hh3RrwjMr8NY0d2h5JZYPsfWNsXtVZZ38FRPzDWLsO6uOULF+ohwg7lx
	g1BY1hhhOUnkUUpFMlv+xSYJNH+BoJ1jNnQIdPh/9eRbdXD8MhfsT+vWvMaf+yCO4EQdhqZ9hdI
	9dJolDnZm6l2o8JnESJr0uirFIRCmJsST5h301/QNBVLaFnVl6EGbeYTMTZ0noq6a2WoDHEtJvw
	==
X-Google-Smtp-Source: AGHT+IE6mxXhhg8tmcYdpDrXJG0Bnmow58nBLoeEUYjtcD1UXPBEQ8NpVBmPHszF0K9TXYmfMnMPjg==
X-Received: by 2002:a17:902:f64c:b0:28e:cb51:1232 with SMTP id d9443c01a7336-290c9cf8a6amr341048785ad.3.1761249590301;
        Thu, 23 Oct 2025 12:59:50 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff37c14sm3319857a91.2.2025.10.23.12.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 12:59:49 -0700 (PDT)
Message-ID: <8b591c90fad1c467cf02db3a5cb29267944f2887.camel@gmail.com>
Subject: Re: [RFC bpf-next 02/15] libbpf: Add support for BTF kinds
 LOC_PARAM, LOC_PROTO and LOCSEC
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Date: Thu, 23 Oct 2025 12:59:47 -0700
In-Reply-To: <de9b8201c4312ff891899b1a7a443332879d9043.camel@gmail.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
		 <20251008173512.731801-3-alan.maguire@oracle.com>
	 <de9b8201c4312ff891899b1a7a443332879d9043.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-23 at 12:18 -0700, Eduard Zingerman wrote:
> On Wed, 2025-10-08 at 18:34 +0100, Alan Maguire wrote:
>=20
> [...]
>=20
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 18907f0fcf9f..0abd7831d6b4 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>=20
> [...]
>=20
> > @@ -588,6 +621,34 @@ static int btf_validate_type(const struct btf *btf=
, const struct btf_type *t, __
> >  		}
> >  		break;
> >  	}
> > +	case BTF_KIND_LOC_PARAM:
> > +		break;
> > +	case BTF_KIND_LOC_PROTO: {
> > +		__u32 *p =3D btf_loc_proto_params(t);
> > +
> > +		n =3D btf_vlen(t);
> > +		for (i =3D 0; i < n; i++, p++) {
> > +			err =3D btf_validate_id(btf, *p, id);
> > +			if (err)
> > +				return err;
> > +		}
> > +		break;
> > +	}
> > +	case BTF_KIND_LOCSEC: {
> > +		const struct btf_loc *l =3D btf_locsec_locs(t);
> > +
> > +		n =3D btf_vlen(t);
> > +		for (i =3D 0; i < n; i++, l++) {
> > +			err =3D btf_validate_str(btf, l->name_off, "loc name", id);
> > +			if (!err)
> > +				err =3D btf_validate_id(btf, l->func_proto, id);
> > +			if (!err)
> > +				btf_validate_id(btf, l->loc_proto, id);
> > +			if (err)
> > +				return err;
> > +		}
> > +		break;
>=20
> Do we want to also check that number of parameters in loc_proto is the
> same (or less then) number of parameters in func_proto?
> Also, would it make sense to support a case when e.g. parameters #1
> and #3 are in known locations, but parameter #2 is absent?

Doodling with [1], it looks like ~4% of inline locations have such
partial information for gcc compiled kernel (~19K out of ~480K).
For clang compiled kernel numbers are much smaller: 0.8% (~4K out of 464K).

[1] https://github.com/eddyz87/inline-address-printer/

>=20
> > +	}
> >  	default:
> >  		pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
> >  		return -EINVAL;
>=20
> [...]

