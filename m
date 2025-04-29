Return-Path: <bpf+bounces-56889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 533B2AA002C
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 05:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B430A464770
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 03:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86E253F3F;
	Tue, 29 Apr 2025 03:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wH6hbKmf"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D142AEE1
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745896284; cv=none; b=LozlQ2mNCucTyh/xjUAI4rXLnUtRYa9c6yTYxQDrMy8QmiUkQyDwM6W0/mmJe+ouPANlSEvyPJp03ymxLxt+bgej/5SkBmAdZBtuuwFYtOS9wFpm+2+piOLwFTjZ6Nwm1UPh4emEcqvXfPkTB4Ptp3uzceUyukcWop/lcy88Sms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745896284; c=relaxed/simple;
	bh=lS4PVW6HwcnjDOEWZI2R8KMjtEZJrPRHAPms+NTOrNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEc1FFs/wqMcg88dfAmAuqOJHYUqIN8hNrEQ6YWYlVVEi9E0YIoxT/4jtRY2cxlzlI6LxGpUMjOuaTh4DXPMuhTNmk1N0y9pINHqI9orSFLZU6MZPdCnsVKmC5GRbdzUHbVpUHeePxW//ZwKlJfXXgIpB6oQ/Qp9ktU3zfGLAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wH6hbKmf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=YrqQxagEp6tOcp48fi1Z4L1BytkBmu0qUTrPjg2q66I=; b=wH6hbKmfd0tgq6O7OeimnkqnAU
	DtY8E/6Gm0MUhwcGbwEFuJfoM00qH5yarJDGpala6XyRjlmiPToQ7gn+bQpZbVl2URqefRv/BIPdV
	DXHfPru7LCW2/tWdEAGJW43kuKsdPQSEC1ldmTNAoTiAESDj2/Jg20B0L4gWMKj5rT8Ot45Wel+EW
	W0+VSvSQ+TeYcfK156/WYA8UYJi7v6Eijuj6JXKLsGJ9aaNodjxaAiYjRT9f5rmUF1NX13rGZlqXv
	aCxzFLRtv2b37cfilv8hqRaLJ3Z274wU2/4mX5CvfuLbjCjWJ8paEnu9PtSL8ofcI7a/Z3P99PIGw
	2Z8ZhX8A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9bNI-0000000EYYX-3jgk;
	Tue, 29 Apr 2025 03:11:12 +0000
Date: Tue, 29 Apr 2025 04:11:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
Message-ID: <aBBDUPzPIQ0z1RV4@casper.infradead.org>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429024139.34365-1-laoar.shao@gmail.com>

On Tue, Apr 29, 2025 at 10:41:35AM +0800, Yafang Shao wrote:
> In our container environment, we aim to enable THP selectively—allowing
> specific services to use it while restricting others. This approach is
> driven by the following considerations:
> 
> 1. Memory Fragmentation
>    THP can lead to increased memory fragmentation, so we want to limit its
>    use across services.

What?  That's precisely wrong.  _not_ using THPs increases
fragmentation.


