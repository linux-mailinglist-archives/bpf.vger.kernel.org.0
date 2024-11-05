Return-Path: <bpf+bounces-43979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DB09BC276
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCA7283917
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 01:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A9F1BC49;
	Tue,  5 Nov 2024 01:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZENJDM4z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C263210FB;
	Tue,  5 Nov 2024 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769668; cv=none; b=NOnpWLEnF3igDojYOfV6f86uKvfvgY+SJ1qLZpbrAbdwk6obqsMz9hAbqKlLMUXsv94A5aIP7mhilnCNUyYBapeZYJkNz2D1NcgdY6TGJF2znRbWBLp0f4HzAhIFiAlHVlLuMBTDW0HiHkJGkVRn9ZzbePTegOn3EfTA1UmhJKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769668; c=relaxed/simple;
	bh=VZ8ZU0WsepzEPLxSHPS93xbgg2Gq28vQVhTZXl+F0Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArL6WvogBYdZnmkZrYk0cgUEWXynQKcOIwRb8DgS1UK7paicYf1buVl5Q3dPAB/kpkCbc4AVimowVn5a7WPNbROdzecCzm3eP8Ef4NDt4U1oJa2ofOOS+pjkr/rm2fMcaJEJl+I/mfdmwNkTLnBeqrQUQ71nDAZq4qKYeSu4WTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZENJDM4z; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdbe608b3so48104185ad.1;
        Mon, 04 Nov 2024 17:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730769666; x=1731374466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+LMkYkWlRPsmB3Ncg3sqZVlDRsn5em99yS0jQuNnWc=;
        b=ZENJDM4zRhgKeZwL+h1sA9GPziEE2m0+idLovxm4qAK5wM847p9JtmRv/Q8ZEtBCkU
         4X5kdcF7vcKhoZg/kV+GSYzk0vy4Jx2vkWmnPiT16DPAfc7fsheiNVmWGpxLodCZWaIF
         g/dDJW+bEAIFM7x/pjNnk/H5LiBQYaHaGOHlImMXEwFZndtq+N2zPZ693cgUvFINMeyO
         tkEt4i5WNz2XSrI1zTj3OjMz5DU6Tia7lrP4g+BlxZiPbTGGe0QBrIfmcWX63Kw9i+e7
         8IVyq0gqNgr53ThNIUUh4sup1rargI6tyiPmw82mGR6YZGGPS8ss3hVoGEBmvWJEr634
         RbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730769666; x=1731374466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+LMkYkWlRPsmB3Ncg3sqZVlDRsn5em99yS0jQuNnWc=;
        b=wuZwDTZEwMxVgN+FiBRvHUYxDbgIZf0T+ZkUUqHzuska5TAFtRZP6DpOSVp+SHdPcV
         fidwcE/UxMiQLSPnsDYfWjTjKDL1Qurhlj/8xBvc164GVtFzb8xNB3u/03KG/OtBf4rO
         kg7QEUsdFbzCiXyd88l1dr9I2zDIFMEcOgMRZLIOzD6vd9b9A83KwuIHZ/sBW8IePwCM
         q0ibImxefwzVQ0Z3LLkGW96E6TbQNAJADHCAPjVCkSm/VDKqD2h8AfsKbv/G+jqkUsAF
         uSadTyQq22dkuuIrSn/sWD18DT4xzXh8HhKBZow534soel1TVXxzUnwvtdq75Qw6utUl
         35HA==
X-Forwarded-Encrypted: i=1; AJvYcCUb/CQLAIAMPECgBbm7eJPTOLDY0T36/HQh36qiWF2qc2t5QrjIOzMiE7WFqjG9bDvNYDk=@vger.kernel.org, AJvYcCVyEp5SpTe6HidmtF5o5flGcVquLGUZlQ/Ve0CE7Hd1exV8c2DEuPzPrpylzdrWljQvOfYiRYiJ0hfY0Zcb@vger.kernel.org, AJvYcCWhlvMeGBPwN7/ZVhM+uiqlDG14Srr813vFOdax9FUzobXzz/20nxHMSrE6OhRKrmrvyN5VGCJHv+94@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2gt9BU3boD4fwWLhT3NSg8yBT1h4cV8kEW4UWb5m1ynOsYsAv
	UFKWbPBP3iQcZTlLVXcgTsuDhp0LmpuP67zb9oY17df0yA7EtBMw
X-Google-Smtp-Source: AGHT+IF64o8gpNOqMASVWYWFpE0R0w/dtjr62OjqjEwkG32O/Wkht74v20ETki9XH2sWXZ+AYqg5+A==
X-Received: by 2002:a17:902:eccd:b0:20b:6e74:b712 with SMTP id d9443c01a7336-210f76d66cemr342551005ad.45.1730769666343;
        Mon, 04 Nov 2024 17:21:06 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105705fa2sm67297965ad.64.2024.11.04.17.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 17:21:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id DBCEA420B6E5; Tue, 05 Nov 2024 08:21:00 +0700 (WIB)
Date: Tue, 5 Nov 2024 08:21:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, hdanton@sina.com, pabeni@redhat.com,
	namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	kuba@kernel.org, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v5 7/7] docs: networking: Describe irq suspension
Message-ID: <Zyly_D2DMcsf3bx9@archie.me>
References: <20241103052421.518856-1-jdamato@fastly.com>
 <20241103052421.518856-8-jdamato@fastly.com>
 <ZyinhIlMIrK58ABF@archie.me>
 <ZykRdK6WgfR_4p5X@LQ3V64L9R2>
 <87v7x296wq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nq/PazSObm4LFAxl"
Content-Disposition: inline
In-Reply-To: <87v7x296wq.fsf@trenco.lwn.net>


--nq/PazSObm4LFAxl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 11:43:17AM -0700, Jonathan Corbet wrote:
> Joe Damato <jdamato@fastly.com> writes:
>=20
> > On Mon, Nov 04, 2024 at 05:52:52PM +0700, Bagas Sanjaya wrote:
> >> On Sun, Nov 03, 2024 at 05:24:09AM +0000, Joe Damato wrote:
> >> > +It is important to note that choosing a large value for ``gro_flush=
_timeout``
> >> > +will defer IRQs to allow for better batch processing, but will indu=
ce latency
> >> > +when the system is not fully loaded. Choosing a small value for
> >> > +``gro_flush_timeout`` can cause interference of the user applicatio=
n which is
> >> > +attempting to busy poll by device IRQs and softirq processing. This=
 value
> >> > +should be chosen carefully with these tradeoffs in mind. epoll-base=
d busy
> >> > +polling applications may be able to mitigate how much user processi=
ng happens
> >> > +by choosing an appropriate value for ``maxevents``.
> >> > +
> >> > +Users may want to consider an alternate approach, IRQ suspension, t=
o help deal
> >>                                                                      t=
o help dealing
> >> > +with these tradeoffs.
> >> > +
> >
> > Thanks for the careful review. I read this sentence a few times and
> > perhaps my English grammar isn't great, but I think it should be
> > one of:
> >
> > Users may want to consider an alternate approach, IRQ suspension, to
> > help deal with these tradeoffs.  (the original)
>=20
> The original is just fine here.  Bagas, *please* do not bother our
> contributors with this kind of stuff, it does not help.

I should have hinted the fixes instead of pasting them...

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--nq/PazSObm4LFAxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZyly/AAKCRD2uYlJVVFO
o+tTAQCWkcadSmX3wxsEpjQjj8WxLObwpWps8IxxktOqM9Ta8wEAmImsEuWA7xfI
yvzVNIeGeybV8MQeKugYfMWyxL/YSA4=
=C4ow
-----END PGP SIGNATURE-----

--nq/PazSObm4LFAxl--

