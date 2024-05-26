Return-Path: <bpf+bounces-30608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B5B8CF2EA
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 11:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BE1CB218C7
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F358F54;
	Sun, 26 May 2024 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jOOvp69k"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF78C1F
	for <bpf@vger.kernel.org>; Sun, 26 May 2024 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716714061; cv=none; b=k2QyBaZphltJoswq2eMYTzGjBqJWG3XV+ifyzhxJBc2V6S+HYXCoM97kP2QelCotxazZNKboVbY6vWq47SNxa5iPhQH33ERWOmdv12tidtKhgQVdFmFrprzqbQnfri7wqVwXWMSGPq6jNS9RD0N8ECctow2O3CCoWAZgUL5I1Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716714061; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+v68cOzvf9Ih47Vpcn3RwjmzVT8nRvB0oFS4cVB91rgMl9fcSmMHOggli8ysrq+eJ6b5Rc9btQxOjYCTNOjIW/uLZZN8VGmnCGLD8S8NKI7OOpqIm00ebk0neMt3kJp0teuLDfWiqpS9YZmHmOQuCZ/1nxBgkPZd2wxQAkWsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jOOvp69k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jOOvp69kNacTPkiddj+yvd+cxL
	dfGeIqMwDiN0dvutOKSFS1z189kgPht2F8SOrUJdBYDKBirBfN1z+M4944qPE5nYPpdswtu5dCmwE
	1qb/YoE7eMWR80Dwe2sdQ44xSBLRBCw0V7vdDMyjNLwuRyI8bpnmmEnuPJ/CLSN3cyU03KgK4wCpf
	BHJZmI/2rYvG2kiw22O9XzIR/D2WUp3Wka34dNuSgDLi4U1W6YJs8FHnfvpkiH6ESNYRFYj3c9f0t
	QS+ub+FdCG3GgS4A2fAZfXQ5SKnytrjCuW5IiBUlY+xBWrJQiRxqAWHxSJNUz/JhslOiuFnZD8SVO
	75Vnqw+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sB9kN-0000000COKk-0okJ;
	Sun, 26 May 2024 09:00:55 +0000
Date: Sun, 26 May 2024 02:00:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Move sentence about returning
 R0 to abi.rst
Message-ID: <ZlL6R4k2zmnosfkc@infradead.org>
References: <20240517153445.3914-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517153445.3914-1-dthaler1968@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


