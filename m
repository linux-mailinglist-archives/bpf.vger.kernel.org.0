Return-Path: <bpf+bounces-59438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5AFACB7D3
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 17:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA96A942675
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3779D22D4C5;
	Mon,  2 Jun 2025 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dQZvvNMo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE122259F
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876867; cv=none; b=luTH6/zeeDrwLJlyw2t/vsJIfYBP4i6xUlH0TG9hOeCvhwxQguW1Fdk2ro3jfqitqdLHga6lAFy1KRTl2qYQMpoq/8GBDN4RuzFVrHI2auMP9w7XYDHVyNsbdJZC1oXSdcsrSeaDlFin9DL0e8PzbeRMfGe3MvCHnZBFV3HXiWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876867; c=relaxed/simple;
	bh=YS7JBPHbS6sCNPOiRhuoVUZgpPJBUX9cs2X5mWxMiZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7npz5fppBxKtuM5OhAih0dVBD+HbXf3L0bLI/o4sbWOZhW1Mjia/xg+zFdpuj1poXcpKLGkcBBFeEDuOuWUESc0Lj9sS9pi0gdNjXysYN74b/qShh8eqC7tWtku52sTmalAPzKWbdQ4TTAGBV5CsM6SBxSm8Akx0Npx1MWidVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dQZvvNMo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450dd065828so19227465e9.2
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748876863; x=1749481663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmZbX0hlsaI3hZ8qq+l4gSqxZaZCX/s2ZALq5WLxKE8=;
        b=dQZvvNMoEvGoJYpCcHGcll5p8jJ8u2dlv9VpCaO9pibvvbNCEKH+dtqqM6aRQmqT/p
         f75gWERJ1i9NIYh3hbmIDQrCkaMYb/6fp3TaQU22UFdkbeNZXq4voa9C6LOxKix8nGYf
         IEfMy5EuaJAQZLqFun7CRYMlk9MjgPMwfHRYE4QVcDYMprPJFy3BkevWdZrMez6ZUr5l
         SbY09De5xrWOcgbU0tFY9RnIAOrZUgAWYt5hkBcBCLOyjcvqwAYfeOHkiOSISce9LPEf
         C0SYxhIZmGvS5VQQzaTeGEIbQsKxFFscUU1bV1VyENn2UDEjbaoe7nwz3jf59Z57RZhQ
         HM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748876863; x=1749481663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmZbX0hlsaI3hZ8qq+l4gSqxZaZCX/s2ZALq5WLxKE8=;
        b=t0k8Ckg+rbgdzOU6qUTBOxDUemefM2sVeqbGvxH52hWarsmObND+h/qAz3Z9eJKOBZ
         lV7dY/19wDkS+1GBeWMY8hR7ZHF9LYZ0hWJhaYigaUYKJMOZuY63HpcZGFfy0Ped10sF
         vnLlRbDVyDeTIg2X1ANCBRo2iOgGcwDdoLDfMBGskSS2TwN0o4+AquFfcLsKk+MCLM5F
         AkCFO8XPA70mgd5X60fkTLzpjppvXQIB8dH9L1UH48e9ZN2xBXYpOn7Q5PdILwrFiSy9
         hFIR20VbbFJ+f3iqzUkgJM+toeRXLkf2a2inwJiT4tE7Fzw28jkVGlw/FNootbmPwWfj
         ABLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLi8UUtBaJZmqOHXygk2NrKvBM/fzn9jiKkNWqA4bO5HdVovmtilzrqchijB1OKPbJKXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHZPUf+xWEnRxKrMCTNvv6pcmjq3EJiCcsJruUmF3XC7iSWA8d
	CBQjSEZ2o1VW1maOs7FaTf+KjtrzTvTxEk7IE4/Ic2p1hddaDJwUz34pxZmcBWYD4xMsdIDKauS
	zeyqUR2A=
X-Gm-Gg: ASbGnctIh3sZqdMnojGqiSoQw/rtY5xX/SfRizq56yacISGBxsUTKrsaJc7pT+EJrV0
	071VT1Pm715zFLmcrhYVuCjJBKae15vmJlWX2PQ1QN2Zw4ce02lBS/RQedUXHYlzS8PiGNNkkQi
	mwyc9QNm+E7kGDrX0Seht0T6bLqfAbQfbhs9q2FZwpEGs6WIbFOUX8+WgmRd/DRj3IoAbHE9EjA
	AvWqoiY+coGZ1lWrPzx9zcsNiSVCasZOn67+hzIOqsn7UmwZxDOZSsbsMMr6qO2g6pXmarRtzU3
	oOk/IZIrinoaeZoycFSKRKu7DAVwB8s1GRWQI8NVxLP6khB6AdhpiamNHFilAbiz
X-Google-Smtp-Source: AGHT+IEV3ITHhmGwWx2FlchqXvrVWIl3FpfBnBI/wAlqdH3JCQ/rjbxCxS0wIzpVGp9Z5bEQIbTdVA==
X-Received: by 2002:a05:600c:4e92:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-450d882488dmr131286665e9.10.1748876861445;
        Mon, 02 Jun 2025 08:07:41 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa2342sm129350345e9.10.2025.06.02.08.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 08:07:40 -0700 (PDT)
Date: Mon, 2 Jun 2025 17:07:39 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/3 cgroup/for-6.16] sched_ext: Introduce
 cgroup_lifetime_notifier
Message-ID: <kzgswr6dlvzvcxcd6yajoqshpumus7fiwft7mmsh5vcygdc5zd@mfauedvifz7f>
References: <aCQfffBvNpW3qMWN@mtj.duckdns.org>
 <aCQfvCuVWOYkv_X5@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7mpvcqhixvxwskac"
Content-Disposition: inline
In-Reply-To: <aCQfvCuVWOYkv_X5@mtj.duckdns.org>


--7mpvcqhixvxwskac
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3 cgroup/for-6.16] sched_ext: Introduce
 cgroup_lifetime_notifier
MIME-Version: 1.0

On Wed, May 14, 2025 at 12:44:44AM -0400, Tejun Heo <tj@kernel.org> wrote:
> Other subsystems may make use of the cgroup hierarchy with the cgroup_bpf
> support being one such example. For such a feature, it's useful to be able
<snip>

> other uses are planned.
<snip>

> @@ -5753,6 +5765,15 @@ static struct cgroup *cgroup_create(stru
>  			goto out_psi_free;
>  	}
> =20
> +	ret =3D blocking_notifier_call_chain_robust(&cgroup_lifetime_notifier,
> +						  CGROUP_LIFETIME_ONLINE,
> +						  CGROUP_LIFETIME_OFFLINE, cgrp);

This is with cgroup_mutex taken.

Wouldn't it be more prudent to start with atomic or raw notifier chain?
(To prevent future unwitting expansion of cgroup_mutex.)


Thanks,
Michal

--7mpvcqhixvxwskac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaD2+OAAKCRAt3Wney77B
SYMKAP4kKLubHhxkJ4m+25CaI+uUpkXSQYSkq6ZvnVwycFJtHwD9FXw1ryxaxlez
wPFLo2G1jfcEoXRQWwzLuL6Qe0BsdA0=
=KPDi
-----END PGP SIGNATURE-----

--7mpvcqhixvxwskac--

