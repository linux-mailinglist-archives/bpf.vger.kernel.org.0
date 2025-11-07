Return-Path: <bpf+bounces-73921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A07E6C3E230
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 02:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFB304EA9CB
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 01:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BBA2F691A;
	Fri,  7 Nov 2025 01:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZDtFRxT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7B262FFC;
	Fri,  7 Nov 2025 01:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479205; cv=none; b=nStleW1gBe8G2B6xWPAy59Od0OpBk++EcIHVKznRDsK2EkGOUo+kXRVQCmbrBxdUAPM/YaTeeH6wUYZKGrpBDrFLSYuD7CAKmNaaV4zIC/yavtLF7RtwJ6mSDHOXPV+BnZeFxXAqohTVjNIkyDaVvXc8ponHoktDDn8LDMtvzik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479205; c=relaxed/simple;
	bh=PK7Z65DZGnYLDCAiL5Ph+9HVPYcOYAtAYKPp1a9+thY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgUwFDBhe1NDhbiAJVuQSTbzL7w0PyTuMqJXUdKAgNPsW9yveaz+0k6QSqaX0RO+ucxV6RJk1qtL7DB9rwEey5x+CJCJEjCTOeeS/748HZHnDQxdPyWS2fQOXRn0rsQsNMejEp7a+oSBWlKZqDUPdA5JYYilR7VcoCpKqwNV3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZDtFRxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2743CC116C6;
	Fri,  7 Nov 2025 01:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762479205;
	bh=PK7Z65DZGnYLDCAiL5Ph+9HVPYcOYAtAYKPp1a9+thY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HZDtFRxTxzd3xikS/f+aycu7YIXmI9UGBNqjJz6+mH/rWmM5sdTd2jsJMxzcCdzq2
	 hyDD7hww9hoFo5X224lwyesdTFd3RRyYt3gp0GGgs7Uhe+GOyUeZZj+wSkl469Kh3q
	 TSiNFhkZ6AAHXrCeg54DIWesWe6qwatLr5UXZ5XhbnUmacVzzwf79bZz9Zms3ooyP4
	 kcRrom2suZUgXqhwfDEcvFI1pUj4YyTVaUX2gMSPvI/uC0JfIDRpT/WRkIDWLW9HBm
	 82ZMVREYe5M7qwXkVriF+ggbDIg/oN1dLDh3xCTKsX1Ko0LLnuHQ4/BSTEO0jOzvab
	 LPE5mWFmXkW7g==
Date: Thu, 6 Nov 2025 17:33:20 -0800
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
Message-ID: <20251106173320.2f8e683a@kernel.org>
In-Reply-To: <20251103075108.26437-2-byungchul@sk.com>
References: <20251103075108.26437-1-byungchul@sk.com>
	<20251103075108.26437-2-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 16:51:07 +0900 Byungchul Park wrote:
> However, for net_iov not
> page-backed, the identification cannot be based on the page_type.
> Instead, nmdesc->pp can be used to see if it belongs to a page pool, by
> making sure nmdesc->pp is NULL otherwise.

Please explain why. Isn't the type just a value in a field?
Which net_iov could also set accordingly.. ?

