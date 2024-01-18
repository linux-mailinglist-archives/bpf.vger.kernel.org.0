Return-Path: <bpf+bounces-19850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69DA83225E
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90ABF28697C
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 23:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC4C1E88F;
	Thu, 18 Jan 2024 23:45:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F1928E01
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 23:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705621554; cv=none; b=gkIDTXYz2k4O1696BZo6mv5sQKsH+t9ZAXFMdGtau7/SNSPbZ6lsB++Cdd8Gio80Z8w8MfPWztrf1AaTglq66ez+C/3VkaysGeO7NZzz6stbKKZh0wgkRvvx2w9K5W51H/979jra5RI+QZHcBDRFv3rY41IY05+ggtwRrYmfEGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705621554; c=relaxed/simple;
	bh=lD1WcXOmAacBezmh0ne+DCmg7yQK+EEyNaUDf1ah3c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FG/Y0nN8F9JyQ1BCC/X2ApdGAB7jkUBZdKdbFl1xu763FTGfC5A7urwVQCzpeIsvw3IXhalCEcPYeKDt5xiNHmRuVDK78L5bay0yCmBhHFCmgEvYko9ZBwVGr3XOq43PN9BcgIbUUKH92PjZ/toLVIJ7na2Ezg227gC98h4Ibmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd562d17dcso199220b6e.3
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 15:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705621551; x=1706226351;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lD1WcXOmAacBezmh0ne+DCmg7yQK+EEyNaUDf1ah3c0=;
        b=ThCYdJtz+dX4LoOg7Y7RlyN1CnKB5pMGNGgQ3V7ZZgvbgl6PKlFsND3AyQ+TgyNW3B
         KH3w7cE6A+vyN5phsSRJ/nS9GX7ZmGDNqWy6vrUxI1ErpY13+LhElHi0LEZSiYbT8t0Z
         oO0s+ttbzSslFp7d0YFydWGzSaR23zZ4921XRqPZ+Po8n0//33sq1kBuUkI8CatIuTl7
         bPtQ1AxfJp8DSeYTooeGk0mL0HcrpMVKEUIb3Mt6IAmE40nJ6oK17xGa/atF2gL8veOU
         K6nuNDp3XZiif1DqPDw+VaYAV5/JShXNTvs4BKXfs2Ej+HCu3FU3k4tCjsE2GYsn1Hyb
         TbqQ==
X-Gm-Message-State: AOJu0YxIRDVM49qlr5TmeGfZS4Rrr7WbyE9eJ8URUMr6YjSaPWb9uAEw
	CdftOSvXZAKMVI7ZpYoEVhZ+mlDlnu4PaYjH3auhAEMCoPMMLMH/
X-Google-Smtp-Source: AGHT+IFMZFuMqplydlVFsKEo5oZ02dOzRxnUN8VVDq4akmfcmB88XbNEAd+eOuICsqOuoyJ9TnL69g==
X-Received: by 2002:a05:6808:1287:b0:3bd:9800:522c with SMTP id a7-20020a056808128700b003bd9800522cmr1847985oiw.3.1705621551562;
        Thu, 18 Jan 2024 15:45:51 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id he23-20020a05622a601700b0042a09928c10sm2555346qtb.33.2024.01.18.15.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 15:45:50 -0800 (PST)
Date: Thu, 18 Jan 2024 17:45:48 -0600
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Clarify that MOVSX is only for
 BPF_X not BPF_K
Message-ID: <20240118234548.GA879563@maniforge>
References: <20240118232954.27206-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lcMjBK8GJPtDYmvr"
Content-Disposition: inline
In-Reply-To: <20240118232954.27206-1-dthaler1968@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--lcMjBK8GJPtDYmvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 03:29:54PM -0800, Dave Thaler wrote:
> Per discussion on the mailing list at
> https://mailarchive.ietf.org/arch/msg/bpf/uQiqhURdtxV_ZQOTgjCdm-seh74/
> the MOVSX operation is only defined to support register extension.
>=20
> The document didn't previously state this and incorrectly implied
> that one could use an immediate value.
>=20
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: David Vernet <void@manifault.com>

--lcMjBK8GJPtDYmvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZam4LAAKCRBZ5LhpZcTz
ZOQHAP9jnnEL4ycoLA7xRNG9ulw63+NnQRtlJAuql2vC4p4V0QD/WQxPmYpC4p81
uZ6Crcy2OkJqIlOE5AdFBoN9iQBcnAI=
=zQ1F
-----END PGP SIGNATURE-----

--lcMjBK8GJPtDYmvr--

