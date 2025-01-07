Return-Path: <bpf+bounces-48174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DECA04B08
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 21:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4174C7A24ED
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277A1F7552;
	Tue,  7 Jan 2025 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="RLE+gVky"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491DF1D958E
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282111; cv=none; b=T/3GrXY0o5Nz4MWSP0Bc28R8RgplcgR8JZDUIVrlvRrT/Vtkjn3C8W/OGlheu8CqkPSibWuOgturXHITEiW/phWJSgR8YFcSEMQdz8G4ATv/WmO7twGjr1GnWhhGLj4OMjGcgwI8J6PW38jDacYOmfmjP2ow2RvBCGoxXXD19ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282111; c=relaxed/simple;
	bh=mm+ZTBbnQHgEFMtxNMxBaCNH8iiVYBIW4JJNc64twKA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMLgZbeS6i7BJdYCjOtFAda/PHcU9lyYubBrsGX3IRUqYlaeI6K/ACLHRSdHwfR47cfFdSOgX07Y6yqq1SqD6dk3Zf6MHhETy7KnVRINEAs21eAmtKRQ8yf1ynnpPHUjSaxGoL6IHrI1iNwP1zNiYZZefeotT/5Cn1VdPoz561M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=RLE+gVky; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736282108; x=1736541308;
	bh=XEKzfoi3G3lwPriPI6AkJ5SlMXjAAi0kviQcypWe1oo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=RLE+gVkycY6m8aOtdsDWLJHZMoLDKFXi0q+KBhWCr5g7hQkAYbxoyItXUsXp/upwY
	 1XcsTKMd3X6YZYFhLf0qIHbO0otv8IpOD2wBbRaBgWLeGz5uOTRZCdYmy1qESJD12G
	 VOqqraTEMHOEqEJ4h6YWgXdSLcK/42L6rQaM07h0UYgRdZOh6BwMHaVHwA1RssuUop
	 mP57qEvuig/pHE8JTO6gEbt4aP0tDIu+bhhKCv/rtTTR3d/FGJWP3U5We/cBsMystu
	 9F/h8nYfksMtAZmVngcdQhX9jRzdhT1bh0oF1qZEhGeAAV/z5uVFaEnGZCmuqC7HXT
	 66XQ+YtkEPX7w==
Date: Tue, 07 Jan 2025 20:35:01 +0000
To: alan.maguire@oracle.com, acme@kernel.org, dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: Re: [PATCH dwarves v4 00/10] pahole: faster reproducible BTF encoding
Message-ID: <ITLAjYpItfkWpWQEiz80tH1ACeynhOt3fy0-wdliNGQlzctskjBNpTXXMl6wdiNfQoNVNiCF4UYWlS3wblgyDrnjws1wi2MTkN4zILTa96s=@pm.me>
In-Reply-To: <20250107190855.2312210-1-ihor.solodrai@pm.me>
References: <20250107190855.2312210-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 91ec4e1854cf06b212fe9011b3f33b90f7198d49
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, January 7th, 2025 at 11:08 AM, Ihor Solodrai <ihor.solodrai@pm.=
me> wrote:

>=20
>=20
> This is v4 of the series aiming to speed up parallel reproducible BTF
> encoding. This version mostly addresses feedback from Jiri Olsa on v3.
>=20
> A notable adition is a patch 10/10, which changes func_states in
> btf_encoder from a list to an array.
>=20
> [...]

Alan, Arnaldo,

I'd like to also remind about two small patches that I sent separately:

  * dwarves: set cu->obstack chunk size to 128Kb
    * https://lore.kernel.org/dwarves/20241221030445.33907-1-ihor.solodrai@=
pm.me/
  * btf_encoder: fix memory access bugs
    * https://lore.kernel.org/dwarves/20241216183112.206072-1-ihor.solodrai=
@pm.me/

In particular, obstack chunk size change significantly improves the
runtime of BTF encoding on top of this patch series, on the machines\
with lots of cores.

Please take a look at them when you get a chance.
They can be applied independently.

Thanks.

