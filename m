Return-Path: <bpf+bounces-47914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA784A01FFC
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B003A3417
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 07:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C8B1D54F4;
	Mon,  6 Jan 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VQWLAz2u"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF765184F;
	Mon,  6 Jan 2025 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736149052; cv=none; b=myf+mT5OO/xow61HadbwxM9DUnK1d4Lpwxc4TuBMcTHHD5N63m6FWBeLsLzPRSWHenj8lXFDJ9XKfTCOb46yk2eQvLceNOC1cFjslqxmbkd186HnjhDD4bVoDXRkjgrRWcI3tQfO9Wi4Embig/V7bHqxlE3WdFwPx2vHWy+wHPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736149052; c=relaxed/simple;
	bh=Tyumh1CB+btpYXVfR9YsyTiQzEBfoBoQ0Hl+mVnpDqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSt4sR4RLKcGTqrqYGYlP5ap3hHOsymOgSdETfsaM6lC6KNow2MmguuEu4DkGiC+BpYx+nh1zXuEkKWVRxUJwnuxabDeKXN4TA9wx4FtXzucPV+2IPZvO+A074XUCr1ZkYXHuiI/aJmVVsQa02v2vQ70OKuFkChalDmDyRGHzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VQWLAz2u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JrYxbYSuhWPmWtfO+OtFAYtumYZrpI/Z+uaU0zNmXPA=; b=VQWLAz2uoZtqQvVkvA//o23JD5
	xaa8QRQC+d3sIhdEI3UY8U2KHGFmURkK8QMc6NEQnatRSYnDFl1cm8fEvNBbCRmg/+UufnYl6aZp/
	OzOYsdIS9h98A2wikJxu+6r+BHlgw0YG6efH5NSvRXMpXXIETLUcenq7bh/gvMQiDcEUFL0nIEwsn
	AJGt9ua1GKl/z/RuDYqzhJLoAE2TOR0tPmdh/7LsNQM9mZN/9hEVQ2cRyPzJADZRhYan1vPgnIP2x
	Uu862/Yj4Xx/S6efU6dY5w9vm+8AdU6qOmbqY2VpFCN+V+CpWuBlbqOfTbMPoU2XmUIYAdfXC1GXz
	QpmMfllQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tUhg0-00000000QBN-47yr;
	Mon, 06 Jan 2025 07:37:29 +0000
Date: Sun, 5 Jan 2025 23:37:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vishnu ks <ksvishnu56@gmail.com>
Cc: Song Liu <song@kernel.org>, hch@infradead.org, yanjun.zhu@linux.dev,
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
Message-ID: <Z3uIOPxr4s09qS1X@infradead.org>
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jan 04, 2025 at 11:22:40PM +0530, Vishnu ks wrote:
> 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors

You can't.  Drivers can and often do change the sector during submission
processing.

> 2. Captures sector numbers (not data) of changed blocks in real-time
> 3. Periodically syncs the actual data from these sectors based on
> configurable RPO
> 4. Layers these incremental changes on top of base snapshots

And all of that is broken.  If you are interested in this kind of
mechanism help upstreaming the blk-filter work, which has been
explicitly designed to support that.

Before that you should really undestand how block devices and
file systems work, as the rest of the mail suggested a very dangerous
misunderstanding of the basic principles.

