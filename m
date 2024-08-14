Return-Path: <bpf+bounces-37139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB339511A6
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34231C22162
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 01:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B1D1864C;
	Wed, 14 Aug 2024 01:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AueS/u5Y"
X-Original-To: bpf@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781BEDC;
	Wed, 14 Aug 2024 01:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600128; cv=none; b=X/F2uzULotwd6LxyKt2VjQvDRpvVHQ22C7nYnkopULOn2/oQu5SDktkdZMMitBEf18KaEi+WRUiFIprQS8djJWKOSpeIxaWtXP8xNRd+PvFkYxvpkbvc6U7TWNH1AAmqQAaqAQFHgi2r77queAVmQbxKr6F2viKd+VuJ7eEOvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600128; c=relaxed/simple;
	bh=Il4bHX9AaecI1cwr3XF2SfvG7qxH5l4hNka0ybn1aak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUmHhsooikoHAvHjQcZ6z1+A4M5MvgULSHxwGhSAYHwxGSBn+fdAe7zckOR4k++t1N4Q4QuN4Z0mv39Tl+Ao2a9ycvb+JYXdJrsA4GvNSIhZEhu2KEy5BkIRFRqn+kmxAWDDXY0a9eVfoCCqflTiCEaQdoETGRKeBrTEm7Xw+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AueS/u5Y; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MjkeWq7O9U+r76a6NCiL25eqQy0v+wAzBQJ5818MIoY=; b=AueS/u5YDYx2B0z2U70u87dujQ
	vYWWcn8GiRxUDk0E6r2g7+W7ruhnSsVYR4ZUqO70UgZI+Hnl1qyvAWQRbGE5NgNb9tgGoUL5OW2sg
	YQItPhzFNWBtKauAGw2ZqoLzX8p7yG0UZqiI50OSvG7TQkdhV5eJDZeR9/sLsUQti9z8rZGNZMGD2
	U+D4K9iQ6oeoYWSj7WueAC7XYdUfHAHxx0OKGiZNN/nCNj8n//qrhIMYGCZAqB1rRLcJyULpB4+bZ
	xj26yKEwOOKl0HfYIbjn2/+/riazzlvmYlyh7ioSdK5pn6J9TaZTE8pFTG0woDO5QFJ6rNgT1tb9j
	KpSKRlCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1se37w-00000001UK2-380O;
	Wed, 14 Aug 2024 01:48:40 +0000
Date: Wed, 14 Aug 2024 02:48:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the
 vfs-brauner tree
Message-ID: <20240814014840.GN13701@ZenIV>
References: <20240814105629.0ad9631b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814105629.0ad9631b@canb.auug.org.au>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 14, 2024 at 10:56:29AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   fs/coda/inode.c
> 
> between commit:
> 
>   626c2be9822d ("coda: use param->file for FSCONFIG_SET_FD")

FWIW, I'm not sure that FSCONFIG_SET_FD is a good idea, seeing
that it went without a single user for 6 years and this case
does not look convincing.

Oh, well - too late for that, by 8 years or so...

