Return-Path: <bpf+bounces-48461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD66A08247
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C21163FC0
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468F3204F7C;
	Thu,  9 Jan 2025 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYUOTllp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE41FDE18;
	Thu,  9 Jan 2025 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736458615; cv=none; b=UEaKBe/iMoq6/vtVZgzoXUtC/LPb0H517d6cJU/+HCkK/wDV4v0w8Ja88CRU2GBBlJf/CoqMJOeqO551PhV/PKlulWa4B7+4/63n5iekr94RMc3Jm1XKitRSK0mUYI9uqV0UxplGhpHIIDCXCmG9gVkS3r2AqMuPqkxUcAJnx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736458615; c=relaxed/simple;
	bh=Q7E8vaLcUw7AS78vPrTnxkmvL8gCnzUtrehVYleVFvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgUz88N3cTK4Fb3l8VyR7ko25D6y2d88oXaK/A2OlFdr6QSlmTbyBv00vla2MfCam12cTD6vboDxqphDgzZ3J8tdOoKrgaXLbZTxA7/1A/wYCxvCBxyss7RmTyHzEgzd/uDUKIN/TC2ioNywjFrmXEeMmLF9mp3WtqRLwn4vSPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYUOTllp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054FCC4CEDF;
	Thu,  9 Jan 2025 21:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736458615;
	bh=Q7E8vaLcUw7AS78vPrTnxkmvL8gCnzUtrehVYleVFvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYUOTllpta0DT63t77UdXhU/vHtJGcKDFmmS7nXVOdHfJ5SACdU1fMf0xnykVFrwv
	 s2zl1lXjjCa6QjyZzpxtx3shndpHHVk0DopZ0XURBxsY8HCWqJ/AtskxI3gFMyKQJQ
	 FcdUyndyIWELubU6sCOdoA+U1IAJhnKEe9cL5yK6+JSM/c6GC7WSIqZ92eeh0Qu3+V
	 MzhFCAuTllQ9wrBw9HiJILsiPUoJUz+rALN0vDoqx//fJMpPJvI5Yrp1ybUPIVIBYH
	 0Pbj5aM49z/y/qbClm2EW/3lnAyQ5Mhz2fVCFbShqxJ+cMwm6vzZ0GplQrhIIN+sMX
	 QcMe7j6PY3m7Q==
Date: Thu, 9 Jan 2025 18:36:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, eddyz87@gmail.com, andrii@kernel.org,
	mykolal@fb.com, olsajiri@gmail.com
Subject: Re: [PATCH dwarves v4 02/10] btf_encoder: free encoder->secinfo in
 btf_encoder__delete
Message-ID: <Z4BBdLWrlMYe2xoW@x1>
References: <20250107190855.2312210-1-ihor.solodrai@pm.me>
 <20250107190855.2312210-3-ihor.solodrai@pm.me>
 <6e54430a-1e3a-4858-ae88-21b52ca49316@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e54430a-1e3a-4858-ae88-21b52ca49316@oracle.com>

On Thu, Jan 09, 2025 at 04:54:41PM +0000, Alan Maguire wrote:
> On 07/01/2025 19:09, Ihor Solodrai wrote:
> > encoder->secinfo is allocated in btf_encoder__new and is
> > never freed. Fix that.
> > 
> > Link: https://lore.kernel.org/dwarves/YiiVvWJxHUyK75b4FqlvAOnHvX9WLzCsRLG-236zf_cPZy1jmgbUq2xM4ChxRob1kaTVUdtVljtcpL2Cs3v1wXPGcP8dPeASBiYVGH3jEaQ=@pm.me/
> > 
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> 
> Good catch!
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Ihor, you forgot to collect this, I picked it and added to your v4
series.

Now looking if some other review tags are missing,

Thanks,

- Arnaldo
 
> > ---
> >  btf_encoder.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 2e51afd..6720065 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -2453,6 +2453,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
> >  	btf_encoders__delete(encoder);
> >  	for (shndx = 0; shndx < encoder->seccnt; shndx++)
> >  		__gobuffer__delete(&encoder->secinfo[shndx].secinfo);
> > +	free(encoder->secinfo);
> >  	zfree(&encoder->filename);
> >  	zfree(&encoder->source_filename);
> >  	btf__free(encoder->btf);

