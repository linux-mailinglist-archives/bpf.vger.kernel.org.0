Return-Path: <bpf+bounces-32513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE52F90EA91
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 14:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF36D1C23DDC
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 12:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956521428FE;
	Wed, 19 Jun 2024 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT3HCbpq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0AF1422C8;
	Wed, 19 Jun 2024 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799113; cv=none; b=l2ZHE1Khws2XhEXzh7NPQMXazhR3XgG0D5Z8XncuvdXcn0o7jvewhKpqsaCS/tZ77J9jB7SC9H+k9RHr2F5/bouXbeIqYVvkQt0x816PWAPKyOJufqltjT1bbZrg5UN1debRmj5Y0zYdrrcaxzxeNK1uj/TI+Zycbl4hNNOIrfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799113; c=relaxed/simple;
	bh=+3gqV7Iuv2ZRkcfvFpsH8CF696dpD1A7msCstk55Y0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of0EqUjyL6tuiqu3qcKRDC4O0ix82JvqfihlQjWydiVE8lyM/3TQqadpUZZ+ltZ0OG92L6h+vnPzM6Bf2zObswtUs43xhLQ4VskmmXJxy7nrte3oH0cksY6qN2SVqPxTGYdlQw7/Y+wtnDHpJCxh74U2TZZn+FEbrjI/ZU8c2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT3HCbpq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70623ec42c2so659100b3a.0;
        Wed, 19 Jun 2024 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718799111; x=1719403911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3gqV7Iuv2ZRkcfvFpsH8CF696dpD1A7msCstk55Y0E=;
        b=QT3HCbpqfUoN0gWY4A9JozXztilzNHxWNBXgKIXObtoVydFTdr8CBbveJVfGZLamk4
         g+n+mOYlwz0jVSFnRg2s+G+kEjXZkdWjpYAfWpW8q+fcXG8H44qNqgiO2/HiMVUDswvI
         Zc64mBG+iekAmM61a/x1x+4CcNYnLF3OAoHDJHuGL7u6F25O+nlixks8vozkY1231eir
         tKLr9C40Do9KRgyyO5xRS2Tgl7ZhUEGLvBlhQ2i9TVFasMn3WPdTG1hwAKMrNC5sAWaH
         EhWK3LhurWSkVapOO9W0Je9ybnupvR/cQG7sx2SXwpMn07E85b5haCXsOl8qyC/i3Bku
         PlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718799111; x=1719403911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3gqV7Iuv2ZRkcfvFpsH8CF696dpD1A7msCstk55Y0E=;
        b=uO6qwCyNWag7tX+MT/oCt/9NIpIGOVI8khO1KtXPd4weJf91t62oEAxE2n7deTNzi5
         Cov4/kBT4Qphf/rOR/AX2fxIi0R39l1jmnSj8rUITEEm1m3LNcZdC6Pb8+7jBi1qFHxb
         AoVtOXS54qxpiEhpGH7qe32QZeZrLXphXBbEsZ7HX9f+/tZXM97wm+wW4sEK3gA+mLIE
         CO7+HDRH1daID6EXmsQyBZDIofHuAGubcS5h1pL5Io2BlYmInDY/Kumb7HFrJVH2ooNs
         X/tdt8TRuVHBzqX+xYrkRAmXbgs0r5uP0dK5h2KhXRRl9mRHYrc2TWq0jezmb6CkdH6g
         Br7w==
X-Forwarded-Encrypted: i=1; AJvYcCVEiuU2M4kKt8KlbAirm4lv5/ttYQjnAuriZolxlE23GFAgUo0eXhlAjdOLmvdMSCziWm03GLbKHZIDW0OoIYLmwpG9
X-Gm-Message-State: AOJu0YyzgiiIXtygoRm9vgCVWbKdoZSwjnyL1040MEU9618Shd17CAp+
	tuXhrCIqbGXdamF+/KWsOYoc05z0Sn+4pnTYB1L8Pa8FYOmfLui/
X-Google-Smtp-Source: AGHT+IEpGpAXuLgQJ4z6VgIagioZhQFvB+Vm0B+Ee3ak9Q/Tc3qYqVNqsoJ1sW3vvYl+tiioUor6Kg==
X-Received: by 2002:a05:6a20:3c9e:b0:1b6:a7c5:4fad with SMTP id adf61e73a8af0-1bcba22f29fmr3966572637.26.1718799110818;
        Wed, 19 Jun 2024 05:11:50 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb8dd68sm10477120b3a.206.2024.06.19.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:11:49 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 91252183A81FA; Wed, 19 Jun 2024 19:11:45 +0700 (WIB)
Date: Wed, 19 Jun 2024 19:11:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Tejun Heo <tj@kernel.org>, torvalds@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 29/30] sched_ext: Documentation: scheduler: Document
 extensible scheduler class
Message-ID: <ZnLLAWbryU0-aqX1@archie.me>
References: <20240618212056.2833381-1-tj@kernel.org>
 <20240618212056.2833381-30-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QTBRT25tDLXH91dy"
Content-Disposition: inline
In-Reply-To: <20240618212056.2833381-30-tj@kernel.org>


--QTBRT25tDLXH91dy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 11:17:44AM -1000, Tejun Heo wrote:
> Add Documentation/scheduler/sched-ext.rst which gives a high-level overvi=
ew
> and pointers to the examples.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--QTBRT25tDLXH91dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZnLK/AAKCRD2uYlJVVFO
o/m3AQDvlkShSHUwxaqKX5DV/HcD2PbL5R+9f+zPNpLRV5IVSwEAqHcCISspS8dU
UWAGJ9pJNmfVZ9sLaGeXH4uN2TvS0wU=
=ciJC
-----END PGP SIGNATURE-----

--QTBRT25tDLXH91dy--

