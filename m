Return-Path: <bpf+bounces-61334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3755EAE5970
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CE23BB8A1
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 01:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3111F30AD;
	Tue, 24 Jun 2025 01:55:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D223741;
	Tue, 24 Jun 2025 01:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750730113; cv=none; b=oNlFcLLWT3q3GZ0vq3dJVjBqWeoVmhWkqrBSfQxX2DeHrMoxPyVSzEKNczCvWQFWiJ9mfQlGWRr5/XRmuOjm5qz8eRZaNb6DVz8vxhLBcA7+gR91MNDJnh6mjKSG/B4vcbdYpx7FGiHypzG2GmpApmR3uZUsB6f2X+7DZ2h0tdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750730113; c=relaxed/simple;
	bh=2ISrvwIgX3jixWuefaXZJkNIcgEtijnZyZas0qVkkuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUk68mWCNce9XpoOec/0LevIYtlG81eAKanwLqp7TOpwPcteFecGh+hD3VqlW6nmI5tVQjtQ1UUHvB6Fs2OWC7/Yd4oUmM6d+kgUFDlKcc+jvlcDb/ymTFHnyUSKurdZo7eqEqEOQC1jbG7e11WCswyDY2vNp2xYgTJAyTJ1WGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-0d-685a05782dd9
Date: Tue, 24 Jun 2025 10:54:58 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	willy@infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, hannes@cmpxchg.org, jackmanb@google.com
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
Message-ID: <20250624015458.GD5820@system.software.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
 <20250623101622.GB3199@system.software.com>
 <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
 <a8d40a05-db4c-400f-839b-3c6159a1feab@redhat.com>
 <41e68e52-5747-4b18-810d-4b20ada01c9a@gmail.com>
 <CAHS8izPRVBhz+55DJQw1yjBdWqAUo7y4T6StsyD_dkL3X1wcGQ@mail.gmail.com>
 <69762ce3-ead1-4324-ba33-9839efbe31e7@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69762ce3-ead1-4324-ba33-9839efbe31e7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG/e+cnXMcDY7L8p8S0SpKS62QerMLIwgO3VQMSftgKw9t5SVm
	2SwKLSGSvNAFalpNIp0XWE2ds0zqaF7ooqysmeZslthNS8ums8s2ifz243mf93neDy9DyKrF
	gYw69QivSVUmyykJKfkyqyRUK05QrfwxwkKxsYqCSqcWyvotYiiuMCP4PtFDw1hzKwU3S8YJ
	KO7IIeGHcZKA9y0OGipNO8BeOkhCw9k6AhwFbRTk5bgIuD8xTMNpi0EEneZ8MVyavEVAXVY/
	Dc/vFlPQV/VHDINCHgntunIS7PkKaNHPhfHHnxE0G+tEMH7+GgUXrXoKBnLsCKxNDhKKsvMR
	GBttYnA53RlFj/poxWKu6fMIwdWUd4u4et0bmtObjnLVhhAu12YlOFPFOYozjV6gud6XDRTX
	dsVFcvWWMRGXd2aY4r69f01yI41dFGes6SK5J/pmOtovQbIhiU9WZ/Ca8E17JaoJ4TZ1+INU
	25PbgbLQJ0ku8mUwG4ELv+aI/3FrVj3pYZJdgvVD/bSHKXYpttkmCA/7s8vxp1eCW5cwBNtC
	4a/vnnkXZrNa7HIMek1Sdi3OuygQHpOM7SZw+806enrgh9uvvvMuEO7UqetWt4lxcxAu+81M
	ywvwmdoib44vuxE/sL322uewi/ADc6vIk4nZNgYbDW+p6avn4YcGG1mI/HQzKnQzKnT/K3Qz
	KvSIrEAydWpGilKdHBGmykxVa8P2p6WYkPuVSk9O7bGg0c5YAbEMks+SWiLjVTKxMiM9M0VA
	mCHk/lJhc5xKJk1SZh7nNWmJmqPJfLqAghhSHiBdPX4sScYeUB7hD/H8YV7zbypifAOzULjk
	LaxQCNk3Ohevjd4+0B1sdvgEnFBHj8X0x7tMRYnOW0PYfqo3csuL+LL566IUDcfu9ah+BR+0
	S3f+DImMPI47nLu3VY+OmrcGvDJoG1cve3pPUbBu12WfNSsHohbWD/eGJnxMCbRmHuq606d2
	7k+relgbsa8k0ScuODdmfW9grJxMVylXhRCadOVfzLhcDUYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e+cnXMcrY5Hy4MFwiqspBsUvd3EROokFHa1IqhRhzZ0KlvZ
	LCpr0kXSLgrVnDUTc85itdbcwjSOpVmSsdKmVg7TaRh5ycRb2ZxEfnt43t/z+/RSGJMrDqWU
	SUd5dZI8UUZIcMnWtbrFWvE+xbKqBWCw3CegdEgLxR6HGAxmO4KB4RYSfr6oIaCwYBADQ30G
	Dr8sIxh0VLeRUGrdAq33vDiUXyjDoO3KKwKyMkYxeDb8g4RzDpMIqvJrxfDOni2G3JEiDMrS
	PSS8f2og4Mv9cTF4hSwcavUlOLRmR0G1cRYMvvmO4IWlTASDl/MJyHEZCfia0YrAVdWGQ97Z
	bASWCrcYRod8jryXX8io+VzV9x6Ms5U0iTin/jPJGa3HuMemRVym24VxVvMlgrP2Xye5T43l
	BPfq5ijOOR0/RVyW7gfB9XU041xPRQPBFXb1ijiLrQGPY/ZJ1h3mE5WpvHpp5EGJYlh4SKR8
	k2pbMutROuqWZKIAiqVXsDXpTnwi4/R81tjlIScyQYezbvcwNpGD6Qi2+6Pg6yUURlcTbG/7
	W/8giNayo21ePySlV7FZOQI2ATF0E8bWFpaRk4dAtvZWu3+A+axjt10+iPLl2WzxH2qyDmN1
	T/L8ngB6Pfvc3ezHZ9Jz2ef2GtFVNF0/xaSfYtL/N+mnmIwIN6NgZVKqSq5MXLlEk6BIS1Jq
	lxxKVlmR71funRq75kAD7zcJiKaQbJrUsWavghHLUzVpKgGxFCYLlgrRuxWM9LA87QSvTj6g
	PpbIawQ0m8JlIdLYeP4gQx+RH+UTeD6FV/+7iqiA0HTUWHJa+eGSe7wAizcVfZon7HRqTTfs
	21K3n+QLHlzcHaSb8duQvOHuFV2LPD8u7lHrnJNPwpxDzMLje5r6YhvGVLuQJZzqrKhf76nz
	hpy5Y4+S2s7sjwlU1TFmBcGf37w6NmZxtMadELFhR29d5Jbiyv5K2+sV1tz+zojAjd+UIzJc
	o5AvX4SpNfK/8tmQEicDAAA=
X-CFilter-Loop: Reflected

On Mon, Jun 23, 2025 at 07:14:41PM +0100, Pavel Begunkov wrote:
> On 6/23/25 18:28, Mina Almasry wrote:
> > On Mon, Jun 23, 2025 at 10:05 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> ...>> As you said, it's just a sanity check, all page pool pages should
> > > be freed by the networking code. It checks the ownership with
> > > netmem_is_pp(), which is basically the same as page_pool_page_is_pp()
> > > but done though some aliasing.
> > > 
> > > static inline bool netmem_is_pp(netmem_ref netmem)
> > > {
> > >          return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
> > > }
> > > 
> > > I assume there is no point in moving the check to skbuff.c as it
> > > already does exactly same test, but we can probably just kill it.
> > > 
> > 
> > Even if we do kill it, maybe lets do that in a separate patch, and
> > maybe a separate series. I would recommend not complicating this one?
> FWIW, the discussion somewhat mentioned "long term", but I'm not
> suggesting actually removing it, it serves the purpose. And in
> long term the helper will be converted to use page->type / etc.
> without touching pp fields, that should reduce the degree of
> ugliness and make it more acceptable for keeping in mm.

Agree.

	Byungchul
> 
> > Also, AFAIU, this is about removing/moving the checks in
> > bad_page_reason() and page_expected_state()? I think this check does
> > fire sometimes. I saw at least 1 report in the last year of a
> > bad_page_reason() check firing because the page_pool got its
> > accounting wrong and released a page to the buddy allocator early, so
> > maybe that new patch that removes that check should explain why this
> > check is no longer necessary.
> 
> --
> Pavel Begunkov

