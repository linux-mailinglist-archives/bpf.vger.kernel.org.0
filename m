Return-Path: <bpf+bounces-27053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507178A84FF
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 15:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068F51F21E86
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C599013F423;
	Wed, 17 Apr 2024 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4SzhAqk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8AC13F44C
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361237; cv=none; b=V7hhY3tJSViTjU9uB/Le79ueh4QU9MLOdWFIQt14/j49lAms+RXh+OVIojyiztFcYSNi3B+vX2L61IFkoRaK8sVWSpHzGr8WuExy/7gpItgWvfmC8F2fZ5QI+2XScN+9IByJX32yUv9ssMLB9f+qJ7+GJMURj3FwHChp5NoEgEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361237; c=relaxed/simple;
	bh=T1YzZDSGgqoW0rJ8CpJf1zazBDvIHOf0D6/3Vdxzqgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PndNCmxYs1C8leWYIVB3tUNtRmQ8wjJPhHFi83lyAJDuTcwM9QMQn8dXqIiwBt9uBhJMv5cr5RvCfElmYVuWy+J5EKBZsDZK1swviVfCfMfKz0Gml4d7inpiw9Gvo5nkR9nY5hgNsPjYmQcHElsITOU/f5euQtF34EWzLLbwTXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4SzhAqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B58FC072AA;
	Wed, 17 Apr 2024 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713361236;
	bh=T1YzZDSGgqoW0rJ8CpJf1zazBDvIHOf0D6/3Vdxzqgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4SzhAqkbYgxnVaR1SyQHiUdDNzItfnmkCP8jb88lgxB4jiYjA5MUEQtv9Jmm56U0
	 z6y6OuSAwJf/pjqqwdahk/tCjK+FcUE9ZXOfrQrYTC2eWtP/2CGcWsaYAntMFmvF+M
	 +KY7Z/rdolg6ASXtmemmWZp6hqtBt9QR5j/IrO4eOxA9hx4Uyzu2gaTNWaCBciKUST
	 eXxTYx4QYy8jVP0xWaXoiftSRgJH1cG6iVVGgGtctYCVlXRrJCo++szBqUGwau8K4a
	 ZyzeXvJvr913x4nTB4wjEkP8gQQHZMyoimZtRoJpjHdjmIbSmFhHe+obr1yF44ft0E
	 TxJWgoUyJXpqg==
Date: Wed, 17 Apr 2024 10:40:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, jolsa@kernel.org, quentin@isovalent.com,
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v6 1/3] gobuffer: Add gobuffer__sort() helper
Message-ID: <Zh_RUWT4b3QC31k6@x1>
References: <cover.1711389163.git.dxu@dxuuu.xyz>
 <ba9ff49e099583ab854d3d3c8c215c3ca1b6f930.1711389163.git.dxu@dxuuu.xyz>
 <76869286-5593-470e-b04a-e38f1613c361@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76869286-5593-470e-b04a-e38f1613c361@oracle.com>

On Wed, Apr 17, 2024 at 10:20:41AM +0100, Alan Maguire wrote:
> On 25/03/2024 17:53, Daniel Xu wrote:
> > Add a helper to sort the gobuffer. Trivial wrapper around qsort().
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  gobuffer.c | 5 +++++
> >  gobuffer.h | 2 ++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/gobuffer.c b/gobuffer.c
> > index 02b2084..4655339 100644
> > --- a/gobuffer.c
> > +++ b/gobuffer.c
> > @@ -102,6 +102,11 @@ void gobuffer__copy(const struct gobuffer *gb, void *dest)
> >  	}
> >  }
> >  
> > +void gobuffer__sort(struct gobuffer *gb, unsigned int size, int (*compar)(const void *, const void *))
> > +{
> > +	qsort((void *)gb->entries, gb->nr_entries, size, compar);
> 
> nit shouldn't need to cast char * gb->entries to void * ; not worth
> respinning the series for though unless there are other issues

I can remove that while applying the series, which I'm doing now.

- Arnaldo
 
> > +}
> > +
> >  const void *gobuffer__compress(struct gobuffer *gb, unsigned int *size)
> >  {
> >  	z_stream z = {
> > diff --git a/gobuffer.h b/gobuffer.h
> > index a12c5c8..cd218b6 100644
> > --- a/gobuffer.h
> > +++ b/gobuffer.h
> > @@ -21,6 +21,8 @@ void __gobuffer__delete(struct gobuffer *gb);
> >  
> >  void gobuffer__copy(const struct gobuffer *gb, void *dest);
> >  
> > +void gobuffer__sort(struct gobuffer *gb, unsigned int size, int (*compar)(const void *, const void *));
> > +
> >  int gobuffer__add(struct gobuffer *gb, const void *s, unsigned int len);
> >  int gobuffer__allocate(struct gobuffer *gb, unsigned int len);
> >  

