Return-Path: <bpf+bounces-50032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC0A22111
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 16:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771AD164E84
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3836D1DEFD6;
	Wed, 29 Jan 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EUvyeNef"
X-Original-To: bpf@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B814830F;
	Wed, 29 Jan 2025 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166297; cv=none; b=PePGb/qbGGTsxcivvMVEghe2KV5QLf5PVJAlbNa3v8uUzXeYkZyJVxIvga5oriLRsD24XeCF5z014OeKR67Ef/PKI6zx/DbjPzbnRGRi1c8xwzLH8wkRDo+T3Cgg74hNuEfrZGjbdgz7FL51dgJNDlX9w8i4tp4Eo7R6sESnC8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166297; c=relaxed/simple;
	bh=eCxsbEQuSkMB6650vlttl6iRdetXk47XxeyoDararOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WMUpS0nE+feQZT0P2dxs67bd7UTmlq4RA4zTMtf/ixf6buG3FgNgnDH/JswhlOmzLUVit99vGePfpiLmj2fQ4KyrTUQxzOC9HGbPsiyGOJ6VwHyJQQjx0OEESuLpkHpE8XUNXfGKga9SSU1q7aOdvqj97dCg8Q6giY38pV7C5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EUvyeNef; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B9E3E403FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1738166294; bh=tjfdSmbQZktN5AnxF530CGf5ncUa+GaO91f0NTTVYT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EUvyeNefOLOVUnMaofBK1H3VrSTLnaSlL87jx7p1D8vCpTe//kPARa/vTp8vnI9eh
	 ZcG53tpMFiswUuYASOHls3F6Vg5XW9ch6xNSsazTupEasEYPFW2nOxt8Ri1SOg0qfC
	 cSwBXy7FWpxJvTRK+yKEISaHvGCbkKNyRXvpdUVR/Rpkf6uDT7Io/vRbNDEnkIiO4D
	 PV60yuvuSfVyxJctDKDNc+e/lbPZncho4w6bcVdj29uUH8jLc9KZnRB9LTDvIw7oe2
	 mxBi4mFGEzdiqrwARkBYV5Gts0IDzSHT0Em/bRXG67PywB1R9Lrhr6sg6omcQPSl2O
	 ryOWxxYoG1cWw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B9E3E403FA;
	Wed, 29 Jan 2025 15:58:14 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-hardening@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [RFC v2 00/38] Improve ABI documentation generation
In-Reply-To: <20250129164157.3c7c072d@foz.lan>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
 <87h65i7e87.fsf@trenco.lwn.net> <20250129164157.3c7c072d@foz.lan>
Date: Wed, 29 Jan 2025 08:58:13 -0700
Message-ID: <87a5b96296.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> So, I'm proposing to change the minimal requirements to:
> 	- Sphinx 3.4.3;
> 	- Python 3.9
>
> By setting Sphinx minimal version to 3.4.3, we can get rid of all
> Sphinx backward-compatible code.

That's certainly a nice thought.

With regard to Python ... are all reasonable distributions at 3.9 at
least?  CentOS 9 seems to be there, and Debian beyond it.  So probably
that is a reasonable floor to set?

jon

