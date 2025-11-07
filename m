Return-Path: <bpf+bounces-73929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCE3C3E368
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 03:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D79C3A57AB
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 02:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD042EA156;
	Fri,  7 Nov 2025 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCm/SkLf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73878219A86;
	Fri,  7 Nov 2025 02:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481294; cv=none; b=fWqBkbWKEXoJpJZVph1EJQptGaUMnVkLxHeQWN84yOGgJbNVcmtODonj1+nTW4cpg7OI7gyR8uYfe7Q/e3DwrdTcv3SGylQJ7Wm9tDYf1CPio7ovHPONVr7Ff0q7bfvwURmyC31r/TWiMTgznjIRkghlkXJIBktNxwzzOmf6q/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481294; c=relaxed/simple;
	bh=krN2HbEAPJ9LZ7iRNlMAlG+UbT7YoouhmyVRCR+YH4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SS+w3b6dh4/uYgpPQR7wB/1j0n5R5Pt5hOA4OziLeWVEyLFtDPwSa5JchLi7sJ7lV6ghU00z5usOYc04C43ok/a6OS47NOmuFptjOCBkUEF8RBFLuJYYHF4ML9Njc80K632D40MIoS8JmRkohVAq87WZkTSCvYePJ2GSWmKwxPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCm/SkLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FB7C4CEFB;
	Fri,  7 Nov 2025 02:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762481294;
	bh=krN2HbEAPJ9LZ7iRNlMAlG+UbT7YoouhmyVRCR+YH4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NCm/SkLf0sDAsmYdC0ji01eys0nbyjJVvHg3S7lgfslaEnD9BVkC/1GHvsGoJdtcD
	 6aFFfWl+eRdUa2P1IoiFv7Dm4LKqOdxkMEjcj0D7G9kE/QdBQjWl01CAqqMZlLk9gU
	 OEKganv0Zc9V1YeZc8eewaAHC8E6S3BmHqVXJEkNXfY4ZohJUOvegj8GstXxpWV+dS
	 bH8w8zRnLdd3MBCHEQhkcLSEgwh0QK8DGVApLdJqeFVKnO8+KZWlbOHbJo4Z8UCy0l
	 q3fLPgBC9KjsOaNAodtNomC/uutUVR/IkxCfXaDgb5L4m5cwdnNmIfHePUsmOlTYTk
	 t9ibqp7zouV1Q==
Date: Thu, 6 Nov 2025 18:08:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
 dtatulea@nvidia.com
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
Message-ID: <20251106180810.6b06f71a@kernel.org>
In-Reply-To: <20251107015902.GA3021@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
	<20251103075108.26437-2-byungchul@sk.com>
	<20251106173320.2f8e683a@kernel.org>
	<20251107015902.GA3021@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Nov 2025 10:59:02 +0900 Byungchul Park wrote:
> > > page-backed, the identification cannot be based on the page_type.
> > > Instead, nmdesc->pp can be used to see if it belongs to a page pool, by
> > > making sure nmdesc->pp is NULL otherwise.  
> > 
> > Please explain why. Isn't the type just a value in a field?
> > Which net_iov could also set accordingly.. ?  
> 
> page_type field is in 'struct page', so 'struct page' can check the type.
> 
> However, the field is not in 'struct net_iov', so 'struct net_iov' that
> is not backed by page, cannot use the type checking to see if it's page
> pool'ed instance.
> 
> I'm afraid I didn't get your questions.  I will try to explain again
> properly if you give me more detail and example about your questions or
> requirement.

net_iov has members in the same place as page. page_type is just 
a field right now.

static __always_inline int Page##uname(const struct page *page)		\
{									\
	return data_race(page->page_type >> 24) == PGTY_##lname;	\
}									\

The whole thing works right now by overlaying one struct on top of
another, and shared members being in the same places.

Is this clear enough?

