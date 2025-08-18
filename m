Return-Path: <bpf+bounces-65930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFD2B2B438
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 00:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E23582A72
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 22:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406662561D1;
	Mon, 18 Aug 2025 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChiQph3l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702FD1EC01D
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557403; cv=none; b=bCn0ZPITLoTIx9D5ZBfCfK4iqQoPuXUoFYeAKLekGac9sWKvXGQJCgAp1Oy8HAp2FFxSbfi3k7iTaZEsaRpnJhzwZvhuYYCBz0Jl4PBDjg2fdZHlKMe8o8V+hOAC2Uvoh8a96jn0k9M7gx9yiNSFzDJWt7j15CQ0Z5uSj69lSUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557403; c=relaxed/simple;
	bh=fx6md9cZ75FSqIDylnNd20cTxlNrK2krHbnYamyEcpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VL/coqYREkx+c6RFblcUWK5LHWxX8ERgkErle1UppJA5Zriyg0dPQrLZYQmkU4WBWOEyGwsUGVRPBa8Vu/2k9BhdDhXKihUlVczJo7N3647e6kDcruOozeE4cFnZpU9F0YYIOy5zH4VBPkE3RC/gXufLH7+CqiKAZ9T3B3F2ZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChiQph3l; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-323267bcee7so5550384a91.1
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755557402; x=1756162202; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zl7y58vvQ2Xc2Ak4NuGY0Y37uX5KGOUsoIb9zDc8Sv4=;
        b=ChiQph3lVQNpyYci6d+2J4PeXuKDjzEf9JXJSyMPlCktrjs9tD253mDczx2LZCOppx
         R1xRFNTjcUG+jAdTregxKLhsH4iJFxQPDaDqb2RXKunVGmON/HQQ6MGIe2mqqg2m8yVE
         eZhsJso6A/VCDOoI2gQVUrGiEN1E7BtpgGq7bCT3c1xNugyOREsK7ZYnI2bADcWhjmpC
         XRXq5c6NZmDOelxRYTNX8C4/saUEEcZ28Ylz/E/+r2WWia8OrHaeYdRhkA5fp+M26ogx
         oFJ1jCXeZed7X3Hh1k/BgNAmyJmyIJo+Tvp7XrIdcB7AcDSYrdbQTQ9ZPVOXvRBAgg+B
         4w1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755557402; x=1756162202;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zl7y58vvQ2Xc2Ak4NuGY0Y37uX5KGOUsoIb9zDc8Sv4=;
        b=Tt9s/VyB+llcgfV8ppNDJGPXywKPD6SxLZseyS80Ews/HnqFIW5/41sd23lGYzMJlT
         jG2NmgABkmjxownJjavvK8Gt9F0J+xjEzVxhfnj8mkUR59l4E34FPa5GYD3CxlPclk4R
         cO+1rO0wFUPnnpzBmV7iAbiLgQ89XifSnOU3t9p+wkp/dnJnIvAmGR7X/mEgJ6FUqeIu
         b5Pn43DY4A/CHBdDCY+83mh57S3MHL4OyYD34JH1lPF11bB7p0qyM/cOxwqNTuWJjnBn
         EcNBSQYpcri+nG2T3kFNdOK3kQZq/JdsHQKpt8k4eNZoKHA8Vgh1zTh7miaC/kWZ1e3a
         6vTg==
X-Forwarded-Encrypted: i=1; AJvYcCWpYGjQ480gUuWyXW/pHjv+i44LE3r43CJSiaYdjTsZkiptFYb8XBGL7VHf1rOa26GvPNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpS66L9d7zQC25+dIfoNZ52vZ+h4SJmKKt+jcAbLh0CFT7ELN5
	ozc8F+go8RM853L5y1wqZ5iRuN1kEN9buRC5fRQNnakyODS6MyjMRcyO
X-Gm-Gg: ASbGncubwC/c36crBIRSKJs3nckpCOoVo+iNq5mA25p2frQP7IO30kUf5waZAjFWeyE
	2yZKsuH+acldPasRZeEG0ODnRqvtOgTwWxQMJ76ndlvomSPhQuweZDB/xkrXUcQ1pVj7o0YdXxq
	yFyut48KVFLCsj7lZWgFSVy9gdvoxvmyaJROkcH8jwdWKC6O5kxoALtaL5bV0VSCqNoa2wItss3
	lq+BFflO6bvpqkG+y8BoqZRQNKJ1cWzdnypL60CoY00QUjTgXXK/wCzLl+x+OlayI7T7DwXl/m/
	ELsJMIwTpVoet0HXHnDchRpirj7cKoWTalHA9b91sXI/brbKqb5p+KN6w32jKME9TNEqDol6goE
	zRhO7outOj5OLA3bHQ5HrRneo0ipF
X-Google-Smtp-Source: AGHT+IGliR6qdrpX8UYDmzpRR93Opxz4+3YNQOZdzZ45ZEjEgRIS9KfiRDU/CnPRGmP6xFKNnSRHAg==
X-Received: by 2002:a17:90b:2788:b0:313:1769:eb49 with SMTP id 98e67ed59e1d1-32476a218abmr711355a91.8.1755557401617;
        Mon, 18 Aug 2025 15:50:01 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::8c7? ([2620:10d:c090:600::1:2a59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e3ecc64sm955199a91.15.2025.08.18.15.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 15:50:01 -0700 (PDT)
Message-ID: <7ac103b171a8b5ccfffff08e4cf201152d2134d4.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, Nandakumar Edamana
	 <nandakumar@nandakumar.co.in>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org
Date: Mon, 18 Aug 2025 15:49:59 -0700
In-Reply-To: <87tt24zdy4.fsf@cloudflare.com>
References: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
	 <87tt24zdy4.fsf@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-18 at 20:23 +0200, Jakub Sitnicki wrote:
> On Fri, Aug 15, 2025 at 07:35 PM +0530, Nandakumar Edamana wrote:
>=20
> [...]
>=20
> > @@ -155,6 +163,14 @@ struct tnum tnum_intersect(struct tnum a, struct t=
num b)
> >  	return TNUM(v & ~mu, mu);
> >  }
> > =20
> > +struct tnum tnum_union(struct tnum a, struct tnum b)
> > +{
> > +	u64 v =3D a.value & b.value;
> > +	u64 mu =3D (a.value ^ b.value) | a.mask | b.mask;
> > +
> > +	return TNUM(v & ~mu, mu);
> > +}
> > +
>=20
> Not sure I follow. So if I have two tnums that represent known contants,
> say a=3D(v=3D0b1010, m=3D0) and b=3D(v=3D0b0101, m=3D0), then their union=
 is an
> unknown u=3D(v=3D0b0000, m=3D0b1111)?

Yes, because a and b have no bits in common.
As far as I understand, tnum_union() computes a tnum that is a
superset of both `a` and `b`. Maybe `union` is not the best name.

