Return-Path: <bpf+bounces-30609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A8B8CF2EB
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 11:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468311F21424
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 09:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17F78C1F;
	Sun, 26 May 2024 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZ9YE9nt"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1611D8F45
	for <bpf@vger.kernel.org>; Sun, 26 May 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716714098; cv=none; b=rA12rumnJztDxBM65JDCuzyMOzXjeim0Rkex5A4oxm03nsZ+TD+uugbEbmR2UowaFqmjCkAxryXJY9mrdENPtDMhenrsRe9bjx9y/PGNS1n9+VvhBJvq6FNBt3+lPGI1XotkxczeTar9QCdvSl0iqMbVyo4BOKKy4C1VewFjB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716714098; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6jbvVizP3JUK/g3Oiaf/G4cykoRi7GzbEWtbkyUsgOFkyd6h2uGah8d+umC9+2nv1VaO+gTZgjRfpgItSsMFoo4BBsCHi82kpDGy3VosNaJU/CBe0N9qsJKA+yhkqLCldYtkwr8zZb53ZqTFIBVVc+VoYqC2/wMuQbs6YSwSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NZ9YE9nt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NZ9YE9ntgsC8xKa4FuFS6jCvga
	w4SRMCNydVi94p65Uwz+Vx2q139Ng9X6H1O5YI30/fhmQS7zjk7Mx2OAYlr1zGhgS6cvxElaBL+77
	LJjDeSAdMXJmur9ieohbvWP/q41m1RcBaRXY7pTD95P7tTce23SwU7XQX2o0g2oLojTozLZL9wqM8
	44bu9ppIbjv0A+xuTmZEuW5j2wriov6VoY8u6l1568iZV0j9JJns78SujOR1z/mCbVeTX1QFO0Ayw
	6LjYMmY9LYa59w32uQyernDoUDglX84qX1fLKUmbQJt9txstE7a0ZYzFEsfaw8v6LEPbpXw1U3wEa
	U3dQqWBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sB9l2-0000000COP5-0O2O;
	Sun, 26 May 2024 09:01:36 +0000
Date: Sun, 26 May 2024 02:01:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>,
	Dave Thaler <dthaler1968@googlemail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Use RFC 2119 language for ISA
 requirements
Message-ID: <ZlL6cI0PMzwVu3u4@infradead.org>
References: <20240517165855.4688-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517165855.4688-1-dthaler1968@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

