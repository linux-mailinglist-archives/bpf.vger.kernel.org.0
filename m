Return-Path: <bpf+bounces-33180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E9B9189E2
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 19:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1061F282BD0
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA9A18FDB8;
	Wed, 26 Jun 2024 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AsKI3NkM"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E913AA4C;
	Wed, 26 Jun 2024 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421951; cv=none; b=QQsacMY9ArbDlDbYHJArgWyxqMm/ZWUiqu7AizlHLcK4iduNJeXHfhAE0qJpfUpDd5Oh+9V+TBhmLgvyjY6x3sr9AkT+gCmzAmmiYm7KvWLxHSJIAT5S3mXUqrci3kk+50pgsP/x9aVA7PM3+zKNbGQ0AJhg4BC/BIIhJY87mbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421951; c=relaxed/simple;
	bh=CMM4hAJyttLghvHQFSHT0qQ72U5io+b6Qnbgd/JLRUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2MkzlzsOBH64Pt2qaiu7+a6SxNuM/jvJ2A2vL4+nzJMKg3LPONXGfC0S5BMwAvFmtFW2Hvr1tmNVMUoIyRdLcWX3Bgoyll+PnMzrY1lvXcoArWt5OVAOwDar6stevXlKOtztt5McAL1gbKHpaIi0XZGVO0J/tNfFsUSJf5N1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AsKI3NkM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ips9LKfIKk2gftFQJ4aGGOOr8WjuNVuCguVgK1bZCII=; b=AsKI3NkMkZM/E+8d+ogyXSVqb6
	E2Kt2EBPYgyXV4BsxMJytCoSTynkI4nDQHyOwvnAdpbjnPa7rt3/88wP73qJpyCfgE2pLhgPgFoyG
	jmTplXmvbMrobvZ+17hYKPnhXONxr6ueguLs70kKRgj/uxgHdjzTXmn872eteiYbi4bc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMWBh-0013m9-S2; Wed, 26 Jun 2024 19:12:05 +0200
Date: Wed, 26 Jun 2024 19:12:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v9 00/13] First try to replace page_frag with
 page_frag_cache
Message-ID: <d2601a34-7519-41b6-89c6-b4aad483602b@lunn.ch>
References: <20240625135216.47007-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625135216.47007-1-linyunsheng@huawei.com>

Silly nitpick, but maybe for the next version you change the Subject:
to Tenth try to replace page_frag with page_frag.... :-)

   Andrew

