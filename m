Return-Path: <bpf+bounces-74126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9D4C4B300
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 03:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98AEF188EA4E
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D56346FD2;
	Tue, 11 Nov 2025 02:17:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B03446C5;
	Tue, 11 Nov 2025 02:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827477; cv=none; b=D9ScVo+1Cms2iGcS1KxLVVbKNS7DJOLFHgvS1kN1ycCDYHOP/e9RadtELfXvBuvj9zijAGOx6IdjAUfVr3rKgW+wLldDRynHZYXvQwCibswg/dWtMJJGXqmPFPJdrmeH+N9S4gVebIuvBZ123AI/MZHpDECwxyLGvi6S8ippKBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827477; c=relaxed/simple;
	bh=bYsZjtJawtkd8QLTuI04PFok1Qb8IgGzTJfuLXKRcDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWDqb9yRMcvMmzx8HKJNLCgil5gMp1emQgpqWgHfBak+Kkux8umIx700O8vladKTRsxE91oNWEYX6O/2b3h0NEzAPySbsxAljy7+GMzHsrtSY/F1zgscAlhNPz+zjZD8IuD7Lz02pmo3H1aodCYS9XIUKP8Y2jw95lREm08TpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-71-69129ccbaebc
Date: Tue, 11 Nov 2025 11:17:41 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org,
	tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
	sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com,
	dtatulea@nvidia.com
Subject: Re: [RFC mm v5 1/2] page_pool: check nmdesc->pp to see its usage as
 page pool for net_iov not page-backed
Message-ID: <20251111021741.GB51630@system.software.com>
References: <20251106173320.2f8e683a@kernel.org>
 <20251107015902.GA3021@system.software.com>
 <20251106180810.6b06f71a@kernel.org>
 <20251107044708.GA54407@system.software.com>
 <20251107174129.62a3f39c@kernel.org>
 <20251108022458.GA65163@system.software.com>
 <20251107183712.36228f2a@kernel.org>
 <20251110010926.GA70011@system.software.com>
 <20251111014052.GA51630@system.software.com>
 <20251110175650.78902c74@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110175650.78902c74@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUxTZxjH95739JxDY5PXivqu7EI7jQmJ+JGaPCRmEm88F86Y6GKiF3qU
	EzlaqraAsGWxSLOJWlSUCLUzdR+KgKJF+ahgFBAVgxAUPW6s1aowHRSkFflS1rIYvfvn+f+f
	3/O/eASsb9UYBMWSIVstktnIaVlt/7RfF95z65XF718ZwF1ZwUH5SDace1qrgdGKXgbcZdUI
	IqN/8TDZ0IIg3Hybg3+bhhD8dmYYg7vdwcLbyjEMdb5eBK+LL3DwsiXIQ7n3Wwic7WGh/uca
	DMEjdzhwOsYxNIyGeNhfWxoFV9l56Kgu0MCJsT8w1Nif8vDA5+bAXzGpgZ5GJwt3XedZGCxq
	xhAoSIEWzywYvteHoLmyhoHhw79w0FXiY+BqQxcPxzs9HDx3BBB0NgVZKJo4wMGp3AIE4yNR
	ZOhoRAOnbvn5lCQxV1U5salvAItXzj9hxEfFx1hRvd7KiHWuv3nR480Uq0oTxYNqJxa9Zfmc
	6B0q5MXuR/WceKd4nBXrniWLdbVhRnTmhbi1Mzdql6fKZiVLti76Zos2zec5xu8+qc1uc/xg
	R2P8QRQnUGKik++D7Ed98kGEi2mWzKf54dM4pjmygKrq6JSOJ/Ooo6okmtcKmAzytFj1a2LG
	DJJBBwfs0ZAg6AhQe0Aby+hJNaa/P+mbWtaR6fRuyYupY5gkUvXDKyaWxySBnvsgxMZxZAkt
	zA1OdZhJvqY3qm8zMQ4leXH0z4cvmP+LfklvlqrsUURcn2Fdn2Fdn7AehMuQXrFkpUuK2ZSU
	lmNRspO27Ur3ouiHnf1xYlMtGupY14iIgIzTdOo/0xW9Rsqy5aQ3IipgY7xuYitR9LpUKed7
	2bprszXTLNsaUYLAGmfrlg7vTdWT7VKGvFOWd8vWjy4jxBnsaH9h/QrTMs2NpIsJY93zTKS/
	3nitYUD6aXHAMBnfHX5+IC3SdV+2ODe0P043HCrvf7PpZoi5orwLrTNfCqsj9lZpx57Vc/K2
	PzalXNv63ZEVMy5/1Z45d5V/QXbyF7bImlUP12du2cy0JYcPSb0nmjp6Vq4vUtr8Vanh/Ouv
	W52+fUbWliYtScRWm/Qf6eEt3l0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUiTaxjHuZ/7eXO0uJvLngoi1jl4kNSCoit6YRSd7hMV5/SlwzlBTn3I
	ka7azDSJZi0yT3o0i3StWlRmuhKmzRcywi3NpBcU5enNlb2oJTZziVN7cULUtx/X9f/9uT5c
	Ita4uDmi0ZQum02GVB2vYlWbVxyOvefQGBcVP1gBjioXD5WjmXDlRR0HIVcvA44KD4Jg6KkA
	XxubEQz7Wnh47/2I4OKFEQyOhzYWPlWNYahv6EXwruQaD2+aewSodG8Cf9lbFm4ercXQ8/9d
	HvJt4xgaQ4MCHKornyyutgrgPdvKwSNPAQcnxy5jqLW+EKCjwcFDt+srB2+b8llotV9lIXDK
	h8FfoIdmZxSMtA0g8FXVMjBy/CwPnaUNDNxo7BSguN3JwyubH0G7t4eFUxO5PJzJKUAwPjpZ
	OVgY5ODMnW5BH09zFIWn3oEPmNZcfczQrpIiliq37jG03v5coE73XlpdHkPzlHZM3RXHeOr+
	eEKgz7pu8vRuyThL618up/V1wwzNPzzI/xn1j2plspxqzJDN8asTVCkNziJh92lV5n1bthWN
	CXkoQpTIEul0R5APM0t+lY4Nn8Nh5km0pCihKdaSXyRbdSmbh1QiJgFBKlG6ufAikqRLgQ/W
	yZAoqglIVr8qnNEQD5YuPR6YktVkhtRa+poNMyYxkvKlnwnnMZkrXfkihscRZLF0Iqdn6oaZ
	ZIF029PCFCK1/Sfb/pNt/2E7Ea5AWqMpI81gTF0aZ9mZkmUyZsYl7Upzo8kfKjswUVSHgh3r
	mxARkW6aWumbYdRwhgxLVloTkkSs06onEolRo042ZO2Xzbu2m/emypYmNFdkdbPUG7bKCRqy
	w5Au75Tl3bL5+5YRI+ZYUey69Y7/MqJ+S6Lbsmfrn5VOd81v4/ZfH++NWxZ5Z2joZP+nls9b
	RufFayv8f5H3Pl1fdeXB7AjTnn/XxBaeS/o9cXVie/SryH0b9nkclsDaRUs3Thvq7YrUdp4P
	BIs1n1f6juhzvZbcZfq/3/Wte7KwrKhM1fbHteTQqpqhuGHzqukHdawlxbA4Bpsthm+MZrNg
	PwMAAA==
X-CFilter-Loop: Reflected

On Mon, Nov 10, 2025 at 05:56:50PM -0800, Jakub Kicinski wrote:
> On Tue, 11 Nov 2025 10:40:52 +0900 Byungchul Park wrote:
> > > > I understand the end goal. I don't understand why patch 1 is a step
> > > > in that direction, and you seem incapable of explaining it. So please
> > > > either follow my suggestion on how to proceed with patch 2 without
> > >
> > > struct page and struct netmem_desc should keep difference information.
> > > Even though they are sharing some fields at the moment, it should
> > > eventually be decoupled, which I'm working on now.
> >
> > I'm removing the shared space between struct page and struct net_iov so
> > as to make struct page look its own way to be shrinked and let struct
> > net_iov be independent.
> >
> > Introduing a new shared space for page type is non-sense.  Still not
> > clear to you?
> 
> I've spent enough time reasoning with out and suggesting alternatives.

I'm not trying to be arguing but trying my best to understand you and
want to adopt your opinion.  However, it's not about objection but I
really don't understand what you meant.  Can anyone explain what he
meant who understood?

	Byungchul

> If you respin this please carry:
> 
> Nacked-by: Jakub Kicinski <kuba@kernel.org>
> 
> Until I say otherwise.

