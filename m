Return-Path: <bpf+bounces-74129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5595EC4B3D2
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 03:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3BC034CB0B
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DABC347BD9;
	Tue, 11 Nov 2025 02:45:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB27346E53;
	Tue, 11 Nov 2025 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829116; cv=none; b=VBr3mhHnFVi0qg7M1qKpBj/GD7KG/o1KnQGC1GU5ZYi0mgsi0nDKntS+6ZFPqS/sJadbfkhucOYIBV0NIxiqRUxSLl/p8FhB0QyCm/S2JsTlkzh7NfaojOHrBF6dmLqe/t8Aa+hTSV5PUlcQePHDTuK0nPRUsQIn2ZXdxHSo1Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829116; c=relaxed/simple;
	bh=rwaTaD8H95OEQUA2cvjGJVhLOhyYpCwkPUaKbmTZ/TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uukIxRPQ2ipu2apLefbZQ8HoThmJNexlmP+EkY1quZFdUw0j2LDhU8jJ8oVZ5nMeJm/W+cfWm4I0JusERPImoDrsiHKkb+jryOeJCTMUKn1092AM7jtduMv5hNNIYES+vub6xnSjpXFXW1f5ROTj1uBbZeLbDCPxsnO90CoRIsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-21-6912a3311e0d
Date: Tue, 11 Nov 2025 11:45:00 +0900
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
Message-ID: <20251111024500.GA79866@system.software.com>
References: <20251107015902.GA3021@system.software.com>
 <20251106180810.6b06f71a@kernel.org>
 <20251107044708.GA54407@system.software.com>
 <20251107174129.62a3f39c@kernel.org>
 <20251108022458.GA65163@system.software.com>
 <20251107183712.36228f2a@kernel.org>
 <20251110010926.GA70011@system.software.com>
 <20251111014052.GA51630@system.software.com>
 <20251110175650.78902c74@kernel.org>
 <20251111021741.GB51630@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111021741.GB51630@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUxTZxjH85739JzTYpPXCtsr3GxlCwlq3YgXD8n8uFlyLrZk2eKFumQW
	OUpjqaYgHyYmZdSgBJgbmpSCGUoGWIpI0dJWMVqwaE0cw8HOglIoExT5SgXCRyfjaMy8++f/
	/+WX5+IRsO6hKlkwWfIlq8Vo1nMaVjO94dK2jAad6bO/QglQ1+bmoGWpCJpGfCpYdk8wUOfy
	IphfHuJhrSuE4FVPLwcvu2MIGi4tYqj73c7CQtsKBn9gAsGko5WDZ6EoDy2eryHSOM7CrbJO
	DNGf7nNQaV/F0LU8w8OPvuZ1cYeNhz5vlQrOr/yGodM2wsPjQB0Hw+41FYwHK1l44LzCwtyF
	HgyRqj0Qqv8AFh9OIehp62RgseIiBwM1AQZudA3wUN1fz8GYPYKgvzvKwoX4GQ5qS6oQrC6t
	K2fOzaug9t4wv8cglsgyJ3ZPzWLx+pW/GXHQ8TMryrfDjOh3PuXFes8JsaM5XSyX+7HocZ3l
	RE/sF158MniLE+87VlnRP5op+n2vGLGydIb7Jmm/5otsyWwqkKzbdx3U5LTJY/zxeELRZMVT
	1oZ+VZcjtUDJDtrgucy/yyWxm5ySWfIpPdvX+qbnSBqV5WWs5ETyCbV31LDlSCNgMsdThzys
	UoZNJJ/OzdrWIUHQEqAtbr3C6MhtTMOPXIzCaMlG+qDmH1bJmKRT+fULRuExSaFNrwWlVpNM
	ejU4+UaZRFLpHW8vo3gomRfo9dM17NtDN9O7zTJ7DhHne1rne1rn/9p6hF1IZ7IU5BpN5h2G
	nGKLqchw6FiuB62/WOOp+AEfivV9F0REQPoNWvn5RpNOZSzIK84NIipgfaI2nkVMOm22sfik
	ZD32g/WEWcoLohSB1X+ozVgszNaRI8Z86agkHZes71ZGUCfbkGHrR/njB1JuVDPmsYqL+7aE
	ptyj1ea9j1O/igQ696YeMWxvbz84/e9p9eiEeXe07NrKx/FTQyOzQ2n7rV36zKzDBT5SuM9+
	eLbHuxCtTQ2XhVtKd0U0XkvSlzmGbefTdBma3OHEnVPXlhxZf84ntH8/EHZ/ywTWmmO9tf7M
	0B8uPZuXY/w8HVvzjP8BjLVwBF4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRiGec97ds5xtTgtXYeEoPUFiyyj4LEiin70EhQagX1RrTzkaC7b
	TLQIZg00S7MPYy4rS7Sps9UsdZZRm/nVl2jGkUxNK8tkiZk0lcoTRP27eO7rvn89HFaXK2Zx
	BlOSaDbpjVpGSSs3rzq5OLJQbVja8mop5LtdDJT9SIGbPdUKCLr6KcgvrUQwEnzDwq/aegTf
	6hoY+OIfRlB4fRRD/ksbDd/dYxi8Nf0IBuzlDHyo72WhzLMJuos/0vAgvQpD79lGBrJs4xhq
	gwEWTlQ7J4crrCz4rzQpoKUyWwEXx4owVFl7WGiryWegy/VLAR99WTQ0OUpoGMqtw9CdvRbq
	CzQw+nQQQZ27ioLRM1cYaM+roeBebTsLF1oLGOizdSNo9ffSkDuRwcDltGwE4z8mJwM5Iwq4
	/KSLXbuEpEkSQ/yDXzG5W9JBkdf2czSRHjZTxOt4y5ICzxFS4dSRTKkVE0/pKYZ4hs+zpPP1
	A4Y02sdp4n0XRbzV3yiSdTLARGt2KFfHiUZDsmhesmavMt4t9bGJE1NSBs68pa3oWkgmCuEE
	frmQNnyfkZnm5wunWspZmRl+oSBJQSxzKD9PsFXk0ZlIyWF+iBXsUpdCDmbwScLQV+ukxHEq
	HoQyl1Z21PxDLDS/KKVkR8VPF5ry3tMyY14nSD8/U7KP+XDh5k9OPofwUcIt38CfyTB+rvCo
	soHKQSrHf23Hf23Hv3YBwqUo1GBKTtAbjCsiLAfjU02GlIj9hxI8aPKJio9PnKtGI20bfIjn
	kHaqSvo03aBW6JMtqQk+JHBYG6qa2Mcb1Ko4fepR0Xxoj/mIUbT4UDhHa2eqNsaKe9X8AX2S
	eFAUE0Xz35TiQmZZ0SrN7ZXKS9ZjcVHfmzft3BKo90fr5+xJT1i+8PCN29uKBnurWjQBf6F3
	cWxOR9Gi3XWBsHXOGFNE8AlNbYBlMcGSO506e79q/fNpVzsanBej3/jO7xRjM3K53AWacGG7
	Oia709mlm91/eL3tWbrrMcna5X6v2WJ6ZlyZsvU0sX/S0pZ4faQOmy3633ErMQVAAwAA
X-CFilter-Loop: Reflected

On Tue, Nov 11, 2025 at 11:17:41AM +0900, Byungchul Park wrote:
> On Mon, Nov 10, 2025 at 05:56:50PM -0800, Jakub Kicinski wrote:
> > On Tue, 11 Nov 2025 10:40:52 +0900 Byungchul Park wrote:
> > > > > I understand the end goal. I don't understand why patch 1 is a step
> > > > > in that direction, and you seem incapable of explaining it. So please
> > > > > either follow my suggestion on how to proceed with patch 2 without
> > > >
> > > > struct page and struct netmem_desc should keep difference information.
> > > > Even though they are sharing some fields at the moment, it should
> > > > eventually be decoupled, which I'm working on now.
> > >
> > > I'm removing the shared space between struct page and struct net_iov so
> > > as to make struct page look its own way to be shrinked and let struct
> > > net_iov be independent.
> > >
> > > Introduing a new shared space for page type is non-sense.  Still not
> > > clear to you?
> > 
> > I've spent enough time reasoning with out and suggesting alternatives.
> 
> I'm not trying to be arguing but trying my best to understand you and
> want to adopt your opinion.  However, it's not about objection but I
> really don't understand what you meant.  Can anyone explain what he
> meant who understood?

If no objection against Jakub's opinion, I will resend with his
alternaltive applied.

	Byungchul

> 	Byungchul
> 
> > If you respin this please carry:
> > 
> > Nacked-by: Jakub Kicinski <kuba@kernel.org>
> > 
> > Until I say otherwise.

