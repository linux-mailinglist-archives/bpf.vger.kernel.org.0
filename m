Return-Path: <bpf+bounces-30611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D358CF2EE
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 11:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395C11C20615
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 09:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF858C11;
	Sun, 26 May 2024 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pqZNcuQ0"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB42944D
	for <bpf@vger.kernel.org>; Sun, 26 May 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716714255; cv=none; b=AS3i3P01nRbqCndRKXbbUzj5mrS7mPtqxi1XdmvqaFD2k/0b8MZKVso95s7SnCRvbBCINXryuLfo+ohQnCsX9x/OdzxqVoEZO9Lo0bO91C/DYcgp/igCBPXUGPsBlGW9IUOEtrHp3QWRbarcLUvs/lLM/K7Ra/GnL9+ZNadlGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716714255; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq/I5OGtlg3hpBxNaA941i0pdKZaQkeUAUNHkLw6rVLXBoFJcPOqUnzyBTA+n4osJRXrVXP84NciSd/LAlw8rXpanDW39ZBloqLldmtt1tfnHli2DtrznK0+xrVPBNARxeG+vIBL89DA2JzDbcOO6s3Y3IDDpLFSoBWcTs+KtPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pqZNcuQ0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=pqZNcuQ0AGKCciWvPw+9r6poOJ
	zRpqHn19h/N1TMHVTuNU6PdZq8xOOczDxiIjCVjbB+zwdsY0IM/QyadMfLzdQf4ePDRx855MqenrK
	0SDD0Ih75zXXc/wjwaMeSUGQoltMup+UHrUrsxyjJysN2eX/SlXpW1dKAJCa2ClhAdEYjtQK7DdoM
	ZDRUFnwnTDjnHy/ZMAThOr+Aa0KTA7ZHC4mdHSoabS6q916sa8n3JM0gG+OZ3AFRyPsWGHxby14ZT
	/NkntgV+HtEEpUZesXD9oewTNRixEUYu2MOl80UbPW8IarP5+HJEuagX6yWk2fK523gycNdOdNyT+
	FUQ75TdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sB9nZ-0000000COaD-1toQ;
	Sun, 26 May 2024 09:04:13 +0000
Date: Sun, 26 May 2024 02:04:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Fix instruction.rst indentation
Message-ID: <ZlL7DcfJ6A5NDNo6@infradead.org>
References: <20240526061815.22497-1-dthaler1968@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526061815.22497-1-dthaler1968@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


