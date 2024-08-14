Return-Path: <bpf+bounces-37138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F036C9511A1
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1412860DD
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 01:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC8518026;
	Wed, 14 Aug 2024 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JmQmYNZg"
X-Original-To: bpf@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E1D195;
	Wed, 14 Aug 2024 01:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723599723; cv=none; b=O/xliqnlKsbb7ru/k+yZb21js1nGvYzIfplUMgiDwdfZxbaPyu2vBdZOGp3sutoGLeSw8v21TwqbUqA1FTZVQK06LgKGagjEByn2AiCMjHG5cYKleimBK25nXsQZgFHPLydHsHNGAjsbyDgyDg2PhfHxzK5GXJR+GU5H62cJ4Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723599723; c=relaxed/simple;
	bh=v7xjZZ1Uy9JXpwj1rcwu45oC1v3jG4Kc1hcr8NJK+CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ky/ckOxn8xfuS6qdD+FVF/6krrVfpF1erbe/uP6Y1QrY05Zi3ZLsSp3XodRNAFlVmDkAIzc0CHc2fu/NxLDvAaYY/ifrBpwT7bZ/DU2QspEwpWQao5w7WAFfDodovdI5x0NZ5VU639x39lNCQvTnDRO5DirqZEEizB/8ZAX9MNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JmQmYNZg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=18mKasJHJA4e49i5Ihc0wUDfz+tDEOsamtkS6hb0GWs=; b=JmQmYNZgYMGZ+XIY1CGWFQ13OQ
	dgmhsbaaITE5zYjvP21bbAkwZfG3ItmvM3KJa+UhBK7tYHvhH2MsAwpJDIGHSboKug6GTLYkaU7lb
	PIQLOT2qdSJ5sc9kjHXZmVi3FvqrPgu0VxJ5oAbBIfODDXJTeZFHjDTAvzAUIQaTKz++/0c/eQVlL
	5ixmFJD/NVNOsX6TZYo/iX5XVibZQXVSJuupz96kAtFCxaGAgQ5TXvirUu3Q3DRo/G315fp0KU1uw
	LDJNc9cmyi2iKftaz7MLRGY8R1c0q9ny245fpPQBnuwcNjyd6UbREcAO9/NJHE5G8pho1cySuAdGx
	CGzmfT8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1se31S-00000001UFQ-08Qg;
	Wed, 14 Aug 2024 01:41:58 +0000
Date: Wed, 14 Aug 2024 02:41:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20240814014157.GM13701@ZenIV>
References: <20240814112504.42f77e3c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814112504.42f77e3c@canb.auug.org.au>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 14, 2024 at 11:25:04AM +1000, Stephen Rothwell wrote:
>  	if (at_flags & AT_EMPTY_PATH && vfs_empty_path(dfd, pathname)) {
>  		CLASS(fd, f)(dfd);
> -		if (!f.file)
> +		if (!fd_file(f))

		if (fd_empty(f))

actually, and similar for the rest of it.  Anyway, that'll need to be
sorted out in vfs/vfs.git; sorry about the delay.

