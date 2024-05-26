Return-Path: <bpf+bounces-30610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB618CF2ED
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 11:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BD2B21626
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 09:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3047B8F68;
	Sun, 26 May 2024 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hOo8lZGx"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952998F54
	for <bpf@vger.kernel.org>; Sun, 26 May 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716714165; cv=none; b=gJm6p65T96orBWarvmXY/fbjY/kGP1YsgpwzMtkMPa2enD6n5e9I9l4tHxl8iXymVQI8oZ+nKBEg+flYLLHM7iwY+5m3BM33Mt03WQb3g/QJ9ONKg5c6Rum+leidbS9waNcrfjdurv9Uen7t21xv3UYulESZ5ugKOkADR//e0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716714165; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQDQaShp6oXBfhZKf6z9eMdrd9ITjY7frMKa7NSLV9BQAPdASYe5jY/6MLIEDaKXKSM7nWQ+NDK6oSAaSYvY6ZjCS/k9XF/wnW/Ehg796WAp4fqJcjniD0/OJn00ao0QeNys8cy0vpX7rs6HgeCk6fptyoGUxR7H7Mndj0jAZhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hOo8lZGx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=hOo8lZGx4Gxeh3K0C8Z2bNzqqm
	jHog9UKfQFd2GdW0OYmqtB+s4WxFNhjo1fzg8w9L7eqWcmP2bMPHl/kF5epHbogleVzCucFlrbAbQ
	lPjS/bMUEIXpUHhxAdcFMu3TeGoEbQq3CNasuNHUlsccJMr0/1LtdKozE03xLBv03QO39WoXPFwjw
	ZxiAP2Wwuw3HWBMn1+5RNzJfOdkbhFF94yCzim0yvR3XKz/cqP5Ws+JblzDVMkYRxePinL4DBqwGR
	2/vr9/2B5vNCI//8NglQVv1agN0bA54ndRdaCoPepKKIsGsV8ynd2VyQ0P4Pru9VR7mx4YEyJQqfW
	9CzZOqsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sB9m7-0000000COSw-46nZ;
	Sun, 26 May 2024 09:02:43 +0000
Date: Sun, 26 May 2024 02:02:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Add table captions
Message-ID: <ZlL6s0G4idDqHklA@infradead.org>
References: <20240524164618.18894-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524164618.18894-1-dthaler1968@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


