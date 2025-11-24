Return-Path: <bpf+bounces-75314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB66C7F0B2
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 07:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027023A5B6E
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 06:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADF82D2483;
	Mon, 24 Nov 2025 06:26:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF4A26FDA8;
	Mon, 24 Nov 2025 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763965595; cv=none; b=rk+/ZjN5RPiNQX3Z5amvfB8f2MfGBmOQ4hLjdWmQ93i/eXpYUSbse0NrQVggDnhZurZmAY3Y77bQtJbQqphzw4xN6g292jqc6q84An/pH3bgqQuNB3nuhXEKZwZtmeAUhzWrc3h1c0mDYTGdsr6TMkWzTJSqOXrcXMlTQ+GD/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763965595; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmXsKV0tjKAXk8TegPu4OMkeazVyIWJBF38zcA2HK9G4nGmxnnHLGx1PJQchWL1rzAWI6lx/yKRcKvdEg/GSzq45/lekcot5WqEoNyUgMkfM3yTlV6aIONwXfgb44aMCGvYYHww8nKYHqpYTH8QQbMsIhHER3+CaU/cxgwSbf0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F59968B05; Mon, 24 Nov 2025 07:26:29 +0100 (CET)
Date: Mon, 24 Nov 2025 07:26:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	mpatocka@redhat.com, song@kernel.org, yukuai@fnnas.com, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, jaegeuk@kernel.org,
	chao@kernel.org, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH V2 1/5] block: ignore discard return value
Message-ID: <20251124062629.GA16702@lst.de>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com> <20251124025737.203571-2-ckulkarnilinux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124025737.203571-2-ckulkarnilinux@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


