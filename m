Return-Path: <bpf+bounces-58914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B058AC37AD
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 03:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFC81888533
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 01:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF2D78F37;
	Mon, 26 May 2025 01:16:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EEB28E3F;
	Mon, 26 May 2025 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748222202; cv=none; b=kd8pwIKXSpt4VVYA8mBEv0k3rRaQKLe/SGvDaSpvJJQscfs2t33W/cbW1DTsGTmmsyvxhkSXpy2LBB4DUpTJu4s43QBr5SKMkgVUjuOynPc5truSZhlgUZPVFlJrvT4KD/g+eTA8NbjrHcP0v9a3eiO21vVMiXBBvnkxhr2Z1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748222202; c=relaxed/simple;
	bh=vPC7s3LcQmlrYUBTEwifpjCi/Dl4uWzFm+XS/k5cr/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEmGh0LrXw1d+ITbBzcK25sWJMFZDUNL8PlAm7Acueg7Zsu/XNBor1+u5Nf+TFZ5fElYw7qvVlhl+u4c1Koq6us8p9TPVLaQ56GSLaRa/HJNyzVY7mGMOpvM7ZhxLMX419OK1nql+GsEgNVCnMZyywnoXvohfljuMPFsz4/TmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-19-6833c0f4cac1
Date: Mon, 26 May 2025 10:16:30 +0900
From: Byungchul Park <byungchul@sk.com>
To: SeongJae Park <sj@kernel.org>
Cc: willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com
Subject: Re: [PATCH 00/18] Split netmem from struct page
Message-ID: <20250526011630.GC74632@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523174749.58392-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523174749.58392-1-sj@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTcRTG+7+3va4Wr1Prb1dcVDAoSyVOEFZf4v+hoAsRZGlLX9ryyqam
	UaAlRdLMrtRatRJ1mrSYoVuoeMsLzXvWylJbN0otdWmm3dwq6tuP5znnec6Hw9PyHHYer0lI
	FrUJqjgFJ2WkQ7NurfhcHape1ZQXAEZLCQe3J9KgsN/GgrG4DMHnrz0ScNc3cpB3c5wGY1sW
	A2OWSRreNLgk0FfwloGKk+U0uM40caDPmqLhmM1MQXtZDgsXJvNpKM/ol0DXfSMHvSU/WXhb
	q2eg2VDEQF/OBmgwzYHxh4MI6i3lFIyfvsZB3dggBec7TRy8yupD0FnnYuBqZg4CS5WThakJ
	I7dBQe4VPaWI3fBCQkzWFFJqVpJsZydNrMWnOGIdPSchzx9XcKTp8hRD7DY3RfTHP3Jk5M0z
	hnyq6uaI5V43QxymeglxWxdtFXZL18WIcZpUURscvk+qvnRnEiWd4tJswxszkJPJRj48FsJw
	a80w/Zcze3unmecZYSmuOL/AI3PCcux0fvWO+AtBuPVVB5uNpDwtfGHxoPsk5TH8BMDvKuze
	TNk0Ox5leHW5EIkvj+b+0X1x85XXXqYFJXb+eE95umhhPi78wXtkHyEU5303e1cDhCW4uqyR
	8nRhoYjHVS/t6PedgbjG7GRykWD4L9bwX6zhX6wJ0cVIrklIjVdp4sJWqtMTNGkroxPjrWj6
	SwqOfouwodH2HbVI4JFilmyfIlQtZ1WpuvT4WoR5WuEvW2BcpZbLYlTph0VtYpQ2JU7U1aL5
	PKOYKwsZPxQjFw6oksVYUUwStX9diveZl4HCXSnJi5VB/cGzA7dvWXOwI6Zmb5TZ0Rxo7p7p
	n5KvVHfe3O/wiZ1c3dX04XR/WBt3bGhAXUkCHkYu6qEiWq5lDqxNtG5Bc2XhM1hH9J7SJyHD
	rH34xFCIfjBp4TZXgbVlJ135QLZ+2d3rZ/XfL/YUEN329Q25frvcm3qOjGy+4atgdGrVaiWt
	1al+AVMfsPghAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+d3XrqPRdVle1IpmDxLKwopDRVhEXYLCCjJCy9Fubuh0bTXU
	CFYOquHsOVtr1kTyXYMlOkvEpqkjs7TM2WMrcz1gVD6y1NLaKOq/L5/v+Zzzz6Fx8RARRSuy
	jvDqLGmmhBISwh3r8peNNifIVxjGcLDaayio/p4D5a+dJFir6hCMjr8QwEhrOwWlJcGJR3oC
	vtoncPC3DQjAV/aOgMZT9TgMnO2gwKifxOGkswKDlmI3CY/rCkm4NHEDh3rdawE8uWOlwFsz
	TcI7l5EAt6WSAF9hIrTZ5sDYgwCCVns9BmMFxRS0fA1gcLHHRsFbvQ9BT8sAAVdPFCKwN3lI
	mPxupRJjudrKfoxrsLwScDbHUe52RRxn8PTgnKPqDMU5hi8IuJfPGimuwzxJcA3OEYwz5n+i
	uCH/c4L73NRLcaUfvmCcvbaX4DptrYKk8H3C9TI+U6Hl1fEb0oTyolsTSHWGynF+2ahDHsKA
	wmiWWcWe8HpxA6JpglnENl6MCWKKWcJ6PON4MEcwC9iut92kAQlpnPlGsoGRU1iwmMUA+76x
	IbRH9Dt3PtWFuJjZz5qHz/3h4az7ymAo40wc65n6iAVv4Uw0Wz5FB3EYk8CW/qwIqbOZWLa5
	rh07h0SW/2zLf7bln21DeBWKUGRplVJF5urlmgx5bpYiZ/nBbKUD/X6EsuM/zjvR6JOtLsTQ
	SDJDlCZJkItJqVaTq3QhlsYlEaIY6wq5WCST5ubx6uwD6qOZvMaFomlCEinalsyniZl06RE+
	g+dVvPpvi9FhUTo0767J5o259sb9iewK2xXIT+9etmevefO9ftXgfO8brbFoun5tfJ3CmJ50
	SGZOzAtXbs5IaYgal/o3mvpOl28qSa723VmYWn5/5uC34sOXVR92PjRpTxbslvm3+JTzj5m3
	U9oDYkP3Uj8ec9PUr3fPTU1Zw1xfm9vnjzy/OM/iipYQGrl0ZRyu1kh/AUkpHdoEAwAA
X-CFilter-Loop: Reflected

On Fri, May 23, 2025 at 10:47:48AM -0700, SeongJae Park wrote:
> Hi Byungchul,
> 
> On Fri, 23 May 2025 12:25:51 +0900 Byungchul Park <byungchul@sk.com> wrote:
> 
> > The MM subsystem is trying to reduce struct page to a single pointer.
> > The first step towards that is splitting struct page by its individual
> > users, as has already been done with folio and slab.  This patchset does
> > that for netmem which is used for page pools.
> 
> I found checkpatch.pl outputs some complaints to a few patches of this
> patch series.  Most warnings and errors look not critical or even unnecessary,
> but seems some of those would better to be reduced in my opinion.

Thanks for the suggestion.  I will check it.

	Byungchul
> 
> 
> Thanks,
> SJ
> 
> [...]

