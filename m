Return-Path: <bpf+bounces-37028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F8F950670
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF76281C3C
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 13:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C019B589;
	Tue, 13 Aug 2024 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ELXuWbgn"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B461D556;
	Tue, 13 Aug 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555637; cv=none; b=Eop6Y+G3oC6e1CsljIcV5f0JZOv+Fi6eCQ2U75Dj6VX3oBf2/Udwo/41q+iGdZ0Z8EDhnzQpTbfGiYkee+iMT4X5zvqynR7llrnSpVX1YLmJr2O4JchRV1QnQNGl1Vs9F38+NoZM2eDMWaG0jjnquZMqrKORIvJwyr7Yz9f5NEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555637; c=relaxed/simple;
	bh=UNvGmqt0AAljcNwk4q1d7STNYX7jBmUZq01g70fzIyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJPnYBg3PkzjA9TdJp/al1RAPiP59dsLjGpc9s818EAjL6R0M4a9/TMtKAiJw3Qx3gUy1D9AQXnoy5mj1KZF/g9Gri8NPykYLBIbP3/pExhNZR0o9peDur5JFdLbJI2QougbQ4BYMMfz2k3QdqNXgt9GY5jqp0piQVUPl2HqMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ELXuWbgn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K5IfbmljgN5ZT12EcwjvS/hcIRwYSP4JIS/aWuVMa0Y=; b=ELXuWbgnazTCdivOK1n3Nr+SPi
	tWkyuQXUnKxVe0RRGfUFf3VDPUGTBbDskidD82VEdStzLp4r++ifdeW0LHKXYz6Xe1WWmeO4/eI/I
	DKF5ASbMDJQeSYkkPAZbdQ+CVvcDSa92TsvLIbe2QaQ4NFuD8iwiBLYOIkALoZNp5sDBdfMtS+HS8
	Z+ueijAA54AF2LvmFrLDMmp6xXuL4DutBV8wDeaijlM+RSpJBwQwwFAnFp+EADqV15r2Hnav1+hf9
	L40lUcckb43Ji1Q2o8m7y8F28+CctTkYFAlJw9ljOL09PMkrwVfbkC6gi48v6MiK9IBcLUTgU65/V
	ebDy0WtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdrYO-00000003rs5-21Ar;
	Tue, 13 Aug 2024 13:27:12 +0000
Date: Tue, 13 Aug 2024 06:27:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] btrfs: update target inode's ctime on unlink
Message-ID: <ZrtfMK8KwSvm0I-p@infradead.org>
References: <20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 12, 2024 at 12:30:52PM -0400, Jeff Layton wrote:
> Unlink changes the link count on the target inode. POSIX mandates that
> the ctime must also change when this occurs.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Found using the nfstest_posix testsuite with knfsd exporting btrfs.

Can you also wire this up for xfstests?  I suspect other file systems
might have similar issues, so running this as part of normal file system
QA would be helpful.


