Return-Path: <bpf+bounces-28419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8E28B9361
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 04:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10018284387
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 02:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9C17BBA;
	Thu,  2 May 2024 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIy5mhX2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD012F5E;
	Thu,  2 May 2024 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616693; cv=none; b=fH1ycuDeS7LR7yx0RGiy6hwoJquLjY5hqjPp6DGHuTmncLQHT6mTlTQLKh5RWRiago0vgXAvhsgg7pGsRf6nMf3liPKrjbCSXw8cV0bZ1ee4crDqGXAjA6K8IxraqcNoV3+OrBeRgtMNE66ing/ecliHHhooMbNwC7x6GNHToqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616693; c=relaxed/simple;
	bh=xrTQoHWv3EtMeuf3B3Rm+LDsh6sOE+ST1aB231dLTr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVfW3JTCFx5J+nQQgU6hi0zljtkfroVxrpv5a1cqq9SpLK8aswz3qPZ+sBiM3qcwjCJzA4pcd9EKhNVl6axkjCDIoFJx6OrFNiyhO84ZL8NKyX1i84B4EgXfgVGkoW0ByqGQHXxPWkZxCe1z61OJ3T3CnuNJEQDj0GkyzPju+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIy5mhX2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so6696180b3a.0;
        Wed, 01 May 2024 19:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714616692; x=1715221492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xrTQoHWv3EtMeuf3B3Rm+LDsh6sOE+ST1aB231dLTr8=;
        b=lIy5mhX2cHtQnWEVQsEZPl/1NhFkk+VC1H540pBQxkoUagPY3zux5GYAcD2ss/8eZF
         i3CvyrnKLTmj89+k29la0KzpxwqWf8E5QznkFQ2fw+dhEt31BMZHxxq/LWXWZ7BhNFGs
         /E+pLzSac90oOWaiY1qDjV0+Gqd/UPxGx5juvl6JhDdy2ysewV/XFznNtdHpHWj7Ap5t
         oTBIOM7E42+qajc1rCvVhGXMoUFrY+dPU7XBEJMpHgXGgpLs6vMpDTqpAT2ZSFLMG1na
         RCoCHVye/RYYLD5VSM3fXN4Id+8IwSGNu3l03neh04g7vApNR4Hp30Up4zJZwj3lNcyy
         u52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714616692; x=1715221492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrTQoHWv3EtMeuf3B3Rm+LDsh6sOE+ST1aB231dLTr8=;
        b=huOpvTnU0SMhEuMtMZw7fQHiV6/NYpVBv0moghtgoclze8apAiZ1A9P9xLSxNL1A7m
         JUwD3UJvJIvC/1KiqPFx2I4Qn8OaxxNI9/NWua4y8Znx/voVqt9RZ6ZYxf8kXeNd/Tkj
         tBzg/pL3JfH7G1GFxqRpIYc0ZM6NKKWyGJoYPFPLxe9KoepfQasFwqwl9ITejg1oReHI
         ZpG1/J1Tt2LB3jestt7HdYukV5ka5tsbN+95ogkrfva1f8VtqS/loBNWGmEO62NBQmx1
         SeiWyHwM4IV0UvJDNzpEmSJtv34hKeqswsdrGUw01yDU0Bvu/jDxKIEIPYEPsJ05v+kE
         hvbg==
X-Forwarded-Encrypted: i=1; AJvYcCUT2ZkiywnmY/dukqfa6m0jitsbb5JMTXZJgHgQicuXz4jorbXuynFA0AW8ds+FGIHVqQWaMMS524fxNptmM/3RIG9O
X-Gm-Message-State: AOJu0Ywdn4au5LlIiG9oAPzWuISucQ6l/QO36uhe5xV/L4RSeEDw9zXE
	Gla8ODHIVgolUvHv3tbnJKNCBgKRnHwXYMdYHQsZ3jjf8cNNpYpI
X-Google-Smtp-Source: AGHT+IEx6Cn9aBZ41WAY4tzUNjB8lWHGCj87MQZE+E2qxJy6F4KdxVJ7neCYhNcXIbnFSHnHZFYCfA==
X-Received: by 2002:a05:6a00:1305:b0:6f3:e71f:2d6e with SMTP id j5-20020a056a00130500b006f3e71f2d6emr893122pfu.9.1714616691452;
        Wed, 01 May 2024 19:24:51 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id x16-20020a056a000bd000b006f3ef4e7551sm75000pfu.217.2024.05.01.19.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 19:24:50 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B3C351848D5B5; Thu, 02 May 2024 09:24:47 +0700 (WIB)
Date: Thu, 2 May 2024 09:24:47 +0700
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
	andrea.righi@canonical.com, joel@joelfernandes.org,
	YouHong Li <liyouhong@kylinos.cn>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH 38/39] sched_ext: Documentation: scheduler: Document
 extensible scheduler class
Message-ID: <ZjL5b-zipMrV2JSg@archie.me>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-39-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fcduo8LxL1NdM4pB"
Content-Disposition: inline
In-Reply-To: <20240501151312.635565-39-tj@kernel.org>


--Fcduo8LxL1NdM4pB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 05:10:13AM -1000, Tejun Heo wrote:
> Add Documentation/scheduler/sched-ext.rst which gives a high-level overvi=
ew
> and pointers to the examples.
>=20

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Fcduo8LxL1NdM4pB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjL5awAKCRD2uYlJVVFO
o4D6AP0b0L1twya8PouA/EIkgqcNG14MyQMcuaFSl40YPFG1ygD9HyzhHX7R27te
TQyJoSRgdVAp0ukw/0DIyIRz6+6q2AM=
=h0Rx
-----END PGP SIGNATURE-----

--Fcduo8LxL1NdM4pB--

