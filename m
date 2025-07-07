Return-Path: <bpf+bounces-62547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C10AFBAF4
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 20:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD7D188B432
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F746264F9C;
	Mon,  7 Jul 2025 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ayy6TpDX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5A25D535;
	Mon,  7 Jul 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913738; cv=none; b=XbIxP0/Xb9IpW1STfx/4YJ+iy3FplBO9DblQQxK+6HidA0Nbsgn9RenB8GtEJJFTbjndLYNrviu6pipt8gyIbuB5izTa0BKGo0N/mMV2ZFv1SOBnoT+f1M0lIJjsXkdkMyROXfKd1AeN6D/pK2y00QxpoKtBVHErCnsWYWYc4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913738; c=relaxed/simple;
	bh=svufrlSg5VMPdiC2WbZRbSi05zkjM8GgF5LVVHLvPAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3NE5O9AAnEFQYe35x6If4XKp+FA17tG9DY/C+Y8e85a7Uw8kiBzigzBMGiSlkm6glE0b7EfkVCaLhb6KlBp0TL85otd1n8T4pBvuv3SoKJQf2uBo6wH54/a3ohwiTdd48B7Mf64e6bQbbTeTxkoV26DC8sxYa8NK3qNZk8/lB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ayy6TpDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C836C4CEE3;
	Mon,  7 Jul 2025 18:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751913738;
	bh=svufrlSg5VMPdiC2WbZRbSi05zkjM8GgF5LVVHLvPAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ayy6TpDXykOXrx9tClyfIoyZblPccvqwQPng1ukaWyYHy7VdrA1h6eTkTX7c5i4RO
	 4llVxMwpmCENDLtT7l+n6i/e3RKzjMn6JoGyzNX0Zw7Shy8Z1ZNqPrk/JEOjOxkUsv
	 zpWbSMJyRlVw7s/z0DQ1NoS3qipR5O0XDIihbpyG9zcRtE/VGl7x38TiBCE7dtJ5Ee
	 5v59IIGw/zPJj17TzZ2qX74Kmkcan652SQJF3pOAeFfQEurULwp2PZiRTjv+7MaHPm
	 Gztp9/wexVu3FKMI2hOe+fQ5gPIbgPhgE1/gj7HUR+6+TUe4QgDdNtc8P6KrVa8grr
	 WTOLxBSt6YCDQ==
Date: Mon, 7 Jul 2025 11:42:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, almasrymina@google.com,
 ilias.apalodimas@linaro.org, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Subject: Re: [PATCH net-next v7 1/7] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250707114216.20c24489@kernel.org>
In-Reply-To: <20250707002141.GA3379@system.software.com>
References: <20250625043350.7939-1-byungchul@sk.com>
	<20250625043350.7939-2-byungchul@sk.com>
	<20250626174904.4a6125c9@kernel.org>
	<20250627035405.GA4276@system.software.com>
	<20250627173730.15b25a8c@kernel.org>
	<aGHNmKRng9H6kTqz@hyeyoo>
	<20250701164508.0738f00f@kernel.org>
	<20250707002141.GA3379@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Jul 2025 09:21:41 +0900 Byungchul Park wrote:
> > Thanks a lot, this clarifies things for me.
> > 
> > Unfortunately, I still think that it's hard to judge patches 1 and 7
> > in context limited to this series, so let's proceed to reposting just
> > the "middle 5" patches.  
> 
> Just in case, I sent v8 with the "middle 5" last week as you requested.
> I'm convinced they are non-controversial but lemme know if any.

Please don't ping maintainers like this.
It was 4th of July weekend in the US.
We'll get to your patches when we do.

