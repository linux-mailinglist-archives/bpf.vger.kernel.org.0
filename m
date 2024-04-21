Return-Path: <bpf+bounces-27329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2D08AC027
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 18:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76ADF28155E
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C93C1BF34;
	Sun, 21 Apr 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="enIqn7jj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="enIqn7jj"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735337E6
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713717831; cv=none; b=dD6HytZMhIvBuRvqPh33WxFtg2SbwbgfDOeOAEBq0U06Fk6UloxxQ1RS7jBmrOKhd+sC7Lh8iY41jieYb+bjJePEBcugT/d5MHdjDuCgrki+m4UBMHjWahn1oWXVSURpr9SReZJ5161bd/dQztASanLwwhiWPL8jPbD97R9SMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713717831; c=relaxed/simple;
	bh=Z50hir7+9aB2ZXuDfPCfgdzbEP+OGGfBR/9xdkO1wQY=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=KUY21nipPtwdbKlmGPYqb6+bc1UEaThr5SsLw4geIONT/0FKUhqTcnBZyVDYLFBMXG7DUXlUillJbeV4P/lgDAkociTGjYh3ZJzK3emKSReCa6OXV3/qw0STPPvmE0n78FCJSYk1R4DqPjeKJStUJ0laie+mBxDcnR7GU4D9Y9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=enIqn7jj; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=enIqn7jj; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E3721C14F74E
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713717829; bh=Z50hir7+9aB2ZXuDfPCfgdzbEP+OGGfBR/9xdkO1wQY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=enIqn7jjoeAj5waqNvUIwdy8J4gyD2SirGZ7hYHQmJol/zjPpIa7OFLycHyp8zFcv
	 25DOd86/2TmgeEQxlykcc0cRPdNSmwli/lcRwc+9Rhb4B4MHiAw0s4BTG7jtLTjOgy
	 QR4RQKVZPuqizM/VYwvHk4o8gcihuwFEHVrruBiI=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sun Apr 21 09:43:49 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BEF44C14F610;
	Sun, 21 Apr 2024 09:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713717829; bh=Z50hir7+9aB2ZXuDfPCfgdzbEP+OGGfBR/9xdkO1wQY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=enIqn7jjoeAj5waqNvUIwdy8J4gyD2SirGZ7hYHQmJol/zjPpIa7OFLycHyp8zFcv
	 25DOd86/2TmgeEQxlykcc0cRPdNSmwli/lcRwc+9Rhb4B4MHiAw0s4BTG7jtLTjOgy
	 QR4RQKVZPuqizM/VYwvHk4o8gcihuwFEHVrruBiI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id D150EC14F610
 for <bpf@ietfa.amsl.com>; Sun, 21 Apr 2024 09:43:48 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.648
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KjfWxPVcTuyW for <bpf@ietfa.amsl.com>;
 Sun, 21 Apr 2024 09:43:45 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com
 [209.85.219.170])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 1517BC14F5F4
 for <bpf@ietf.org>; Sun, 21 Apr 2024 09:43:45 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id
 3f1490d57ef6-dbed0710c74so3228496276.1
 for <bpf@ietf.org>; Sun, 21 Apr 2024 09:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713717824; x=1714322624;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OgB5Wt7dnb9h7Kf0i5PWU7WaIffMTEQFiHfzWrpNVFo=;
 b=OTIaxJw9SkXh5oX2v+8cSUJVH9SgZLtH0dcTI2jzp9IbEkr/yYBvfWJviT7kpUuDy1
 wvGWP0L5RCiG98bFuB9g2ZNmcYUbJRGZHsEDdBCgfFKnrJwgc4aCS+GRWunzsU0veckH
 lRD2pyHNqZvaPfoJQ8Pf9uXpf0bg7BfEmnudiN6gqqNMDRMpv3mB0m8xFlIJke0IrTEH
 9FY0nkVzLNTZ2v+ReXXIvtw22fL05gT9mZwlOv2MyFLQmbHTtBwOokanchySj3DQn+dt
 4P6lAxanXAKXOlEUV10XXcukLe5MH6ij/+tEHYkdGjpSCBIdj4TvylPJrn8kAig95s8o
 W9tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJtBds/DyAqvbiZFPbVtTz+ZSFdXGssb9lHMdTrlltQhx7kSDbxljptKiC2yh1FQNtH3Fo99kCZ5ihTvI=
X-Gm-Message-State: AOJu0YwlSUkhzmVTtWZXbnJ9mgAw9VKdggG24v59cuaq2DAigNxwKd0V
 LY4EtAhKzJuY8bnj8WcBH5hfI7gxZ2qCtmlGGLoruPblR9uoZjNi
X-Google-Smtp-Source: AGHT+IGgPRisTdssxmdmqCdqpN2R9Jz61mbY1M5qsQBF5kDodr2inO/FMTJsCb4BMiXMKRlZmZdMuA==
X-Received: by 2002:a05:6902:1368:b0:dbd:be40:2191 with SMTP id
 bt8-20020a056902136800b00dbdbe402191mr6917129ybb.42.1713717824118; 
 Sun, 21 Apr 2024 09:43:44 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a056902102300b00dcc0cbb0aeesm1623518ybt.27.2024.04.21.09.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Apr 2024 09:43:43 -0700 (PDT)
Date: Sun, 21 Apr 2024 11:43:41 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Message-ID: <20240421164341.GB8626@maniforge>
References: <20240419203617.6850-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240419203617.6850-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/dSqTtBbLo7T0UQzbJP0miykzA34>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Clarify helper ID and pointer terms in instruction-set.rst
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============0143476813000248998=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


--===============0143476813000248998==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xehouMHa8hWunsgx"
Content-Disposition: inline


--xehouMHa8hWunsgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 01:36:17PM -0700, Dave Thaler wrote:
> Per IETF 119 meeting discussion and mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/2JwWQwFdOeMGv0VTbD0CKWwAOEA/
> the following changes are made.
>=20
> First, say call by "static ID" rather than call by "address"
>=20
> Second, change "pointer" to "address"
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--xehouMHa8hWunsgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZiVCPQAKCRBZ5LhpZcTz
ZHumAQDLmR7Pz/HATaYYxb8i4sUjO3AQQ7MHUYnaKi6KmV3VRQD9Gbamw80Stg+O
YzddgTurSchQDup9L234MMhfmknCMg0=
=LgNB
-----END PGP SIGNATURE-----

--xehouMHa8hWunsgx--


--===============0143476813000248998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============0143476813000248998==--


