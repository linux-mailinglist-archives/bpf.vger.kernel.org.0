Return-Path: <bpf+bounces-28806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F36E8BE106
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF7A2837D7
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0677815252E;
	Tue,  7 May 2024 11:30:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C315217A;
	Tue,  7 May 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081443; cv=none; b=kV8iNFeManl2wFw0QBynJTpia7ucsJlGHe4Uso1DzbzXmmPGZXUKEus5N6Lqt6E/PzgTbFyAxbtIBfabjMp4l1WTkVttAQEA70lXIGVK2nqVaYJU/vXXwTPMh2dAmC4kZ99l/RUDsnxwjzGEmLkbS1b37bRH461zyKkL0XS3vj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081443; c=relaxed/simple;
	bh=9j0JLWV0qb7i28xSyz1X46XIyoh1dWIHa0+a4CgaztE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApSpI0q61qG7/eIMiOEaZ7O9iacMO4BFLduiZS002Bzjs+Yqt3MI+M3jJaOP+jipIFregfKchVgg2OPGF1ixJp1rwYflO9BEZ+gYabJdCPkj7VcP6jckKuEQ35qEtTi4ZAhkM4hVYevYZUu3V5wLsI0hTmUshGvbQEBnf4dBWKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C16968AFE; Tue,  7 May 2024 13:30:36 +0200 (CEST)
Date: Tue, 7 May 2024 13:30:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] dma: skip calling no-op sync ops when possible
Message-ID: <20240507113035.GA25218@lst.de>
References: <20240507112026.1803778-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507112026.1803778-1-aleksander.lobakin@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

applied to the dma-mapping for-next tree.


