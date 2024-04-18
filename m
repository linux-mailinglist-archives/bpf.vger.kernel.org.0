Return-Path: <bpf+bounces-27113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5738A93A8
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 09:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E96A1C217F9
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 07:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259CD37719;
	Thu, 18 Apr 2024 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rBbpI56B"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6D836B01
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423685; cv=none; b=Sl6hx/FNNRVBWxYiV/lN/jrkIftGoLhtA67FGCNw8/4aP07dGaU04tC+Y7Zs9cDzBHrvRVcPf2SpXCcDbqmwwYHR6s0LDY9x8YFAtjM26TBd0YnlOPwaCVEXVyQ3qUe7jPIGw0EmpXu2o+MS2A+Vy+YfND2qmVBocOt8t9JK46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423685; c=relaxed/simple;
	bh=c1eEJ6WrlN+IRxAWWyBbNWCiGA+znHPvIQ3CK/U5kqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3WFTnnD7AH2buQugIqiMEzdfzVFNIVIXUkor5VclFDcJB3+pbLrbWl9NEWOt3assBY3M381Lr/mgOYkQcz3r60uD+sHoQRal0pKq4tGvbL5oFupk+1k+Tha1r1VIyCpCW+EBH44dLCNeEGQ3gQWY/GU4gv7YOC/ka/kYBrwHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rBbpI56B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c1eEJ6WrlN+IRxAWWyBbNWCiGA+znHPvIQ3CK/U5kqE=; b=rBbpI56B+OjPpqnHVaO8ILIJhH
	s+uidZmTRXSMtI/aFaRGmaeZFj/gfJJu8cQ2/to+rhMfN5kkcOLlO3u8jltJn1NpasaWT4n65S2ke
	wCIG6/kXBdMlByyBF6P/UbM0vpVOHEQkJ5xUJ94s/ctotOJEhGMlN0X++GvGDm3J/VlhO86ez8taj
	ViRUmcYCta/vV18d2vBV9Vlv/gapUgGc+Hu53jvsgBxBh2j7lg5BGdaGIGjNTFaCjtmPG8Kj43WDM
	30aqDtPoN3+SdSDVm45Sd4Y5GxxOt8fVlvrRRvyl18oJeczC4s7T1SyAknadwvXf3NONu5XeJS7Vl
	KjqEYlAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxLls-00000001CkZ-0CXJ;
	Thu, 18 Apr 2024 07:01:24 +0000
Date: Thu, 18 Apr 2024 00:01:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: 'Watson Ladd' <watsonbladd@gmail.com>,
	'David Vernet' <void@manifault.com>, bpf@vger.kernel.org,
	bpf@ietf.org
Subject: Re: [Bpf] Follow up on "call helper function by address" terminology
Message-ID: <ZiDFRI3sdClyG-dj@infradead.org>
References: <0a0f01da8795$5496b250$fdc416f0$@gmail.com>
 <20240405215044.GC19691@maniforge>
 <CACsn0cmWzT4-+g0w0-ETC5ZMC1hdW0v-Rh1ZNCG2O23m9YCALQ@mail.gmail.com>
 <003001da8907$efd41140$cf7c33c0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003001da8907$efd41140$cf7c33c0$@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Maybe "static ID", or "pre-assigned" id?


