Return-Path: <bpf+bounces-21002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2AE846902
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 08:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698F71C25CA9
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 07:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03CE1758D;
	Fri,  2 Feb 2024 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jT74cUU/"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9FE17C62
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857633; cv=none; b=Tyo70FLtQexMcBA0CGryVe717sp+5GoMX2WxqN1ym4NwE8yG423cac7Qdy4Gps+eHTX02ckh/Pt5QNAjR4EaZYQrAiFNmyjEoQArHfzb2c9rt2lMCMvBShfmA3Rn4Jis+ESiE6QMdb3Taraa7m78Q1J67ZuUWhyPm0071C3DhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857633; c=relaxed/simple;
	bh=wLkj6AYwXHorWcbm+P6UYrPxaEJ2md7KS3DZW0uDzHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN5bGhldi4Di6MLTqxicOpzc5TbmyQ3+51VbtLIZwrgoXBYeKCRyTpsX1c/IsgC2EZT1D8WjuY7OG96KJ7YlPovETPn8Am19pqSj2rU8f6Z2mkFXdHlt7B6p7P6k/Ihoju0VVdlvOZmK8uUZBthNeET1Qc2Jlt6CXXQTxJZTkOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jT74cUU/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wLkj6AYwXHorWcbm+P6UYrPxaEJ2md7KS3DZW0uDzHw=; b=jT74cUU/9nQHvN4i8O+UpS7zWI
	YmOxYSsojrrEzsPFT9uqePtLiOcz2P+kiwYcAOFBlN6CPCsOlBCK2b4HDFaxZnRr6Ec2omPyg9NvN
	E+AlcvkvOXRUazApoLrKVb3XjL0MAKskAotRf1bN9vkA8nukMSjnu5fJyy4x560ZFDCk9EYCHGGdL
	m4Fi80cjNVda5XgLdBFupdSG0ih4HphPIOrinP8Y1VDmztwxmK4Qy4h9AJ0699tKsAsFXkPevDIjW
	dz68iYtARXujorVo7+a95vy1xdlxqE/7GHHkM7VY60hQK/z+48WFtvi7PC9ZRvBImYQ4rQL8bdvkF
	4XGXvenw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVndm-0000000AXo4-2qI4;
	Fri, 02 Feb 2024 07:07:10 +0000
Date: Thu, 1 Feb 2024 23:07:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: dthaler1968@googlemail.com
Cc: 'David Vernet' <void@manifault.com>,
	'Dave Thaler' <dthaler1968=40googlemail.com@dmarc.ietf.org>,
	bpf@vger.kernel.org, bpf@ietf.org, kuba@kernel.org,
	jose.marchesi@oracle.com, hch@infradead.org, ast@kernel.org
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Expand set of initial
 conformance groups
Message-ID: <ZbyUnlAI4PoeE7mr@infradead.org>
References: <20240127170314.15881-1-dthaler1968@gmail.com>
 <20240129210423.GB753614@maniforge>
 <20240131192646.GB1051028@maniforge>
 <0ce001da5489$8216dc80$86449580$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce001da5489$8216dc80$86449580$@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Fine with me as well.


