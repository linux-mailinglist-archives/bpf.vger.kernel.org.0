Return-Path: <bpf+bounces-64576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BEFB145B6
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 03:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891D63A7D12
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 01:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C91DE2BC;
	Tue, 29 Jul 2025 01:19:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27401D618A;
	Tue, 29 Jul 2025 01:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753751992; cv=none; b=Y/SsKNHDT41J8YGINVNekYYv1o/MoTfEb0v+EYabug8Cs1iFu6S2bW23ICMsdJ4AIQQFLuxAFLaHnlVjLqlaMs0bGMmWJF4giERLyv+uAqWfPFRqhQVllfDP0lvhm4qhpHHAPR2fIjyXRUgSf2UEGxpEFv4rPBjXLwMb86l4H0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753751992; c=relaxed/simple;
	bh=pv2t86bZQ/rELamMHgCjP+pHPtiplV7FkqeMSyQOgIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlnAyxRV8utA4yqoQS0bgkXDqBZANPBcbILUhNUxw76eGiNqEzKTKN16DhUD2NpdkaY5iJrCdt6puPgL/DM9Svl0FE/2CgEFGy6uKbfWD2E8qtgBUkxmhSUFkeWqfofSjzW8ewjcRWjKmJ1sCMKIKozlqjOdylUp0XsgjurTh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-64-688821b27ee0
Date: Tue, 29 Jul 2025 10:19:41 +0900
From: Byungchul Park <byungchul@sk.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
	harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
	brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
	almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page
 pool in page type
Message-ID: <20250729011941.GA74655@system.software.com>
References: <20250728052742.81294-1-byungchul@sk.com>
 <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxTH87zPe6Np42tB94jRZFW2pMvEC4lH3YVEPzzReItLpjM6mvGG
	txGQFKygMSmODSXAiHdLmxQXBCpZWYtQtHSjYBEvUdiY3URANolXQHANFQNSL9Fvv/zOOf9z
	PhwRa89z8aIxM0c2ZRrSdbyKVT1RV3zq/vCQsrhzJBFsrloezo3nQlW/lwObswHBs8htAaaa
	gwjG2tp5eNQ6iuDnijAG240CFv53PcdwLzggwDn3eug7O8iCr7ARw8BPl3koKZjA0BwZEuCg
	t5oBm8ciwM2GUg6OPa/E0GjpF+CPCzYeemunOBgMlLDQYa1hYeR4G4a+0mQIOmZD+OpjBG2u
	RgbCxXYeuk9fYOBol4OHfwv6EHS1DrBw/MUhHsrzSxFMjE+nDZU946D8Uq+QrKetj4cxra/5
	m6Eh/xWGNlnvCNTh3kM91XpaFOrC1O08zFP36BGB9vzl4+nlUxMsbbq7gjZ5xxha8v0QT5/e
	+4elw/5uflPsN6rPUuV0o1k2JX6RolJslR6cFVTnDnd2IwvyxRShGJFISeR+ezPzluudbi7K
	rJRATp7oEqLMSx+TUCiCoxwnfUIe3QpMe5WIpRMCKXT5+CIkirHSDlL326poj0YCUtoUYaOs
	lRRSfaMMvfYzScfp/155LOlJaPIBEx3F0lxSNSlGdYz0Obl+seLVqlnSAvJ7Q/ub03pE4rl/
	4DXPIS3VIbYMSdb3Uq3vpVrfpToQdiKtMdOcYTCmJy1S8jKNuYu+253hRtPPdPbAi+1eNHpz
	SwBJItKpNcrhQkXLGczZeRkBRESsi9NkVf6oaDWphrx9smn3t6Y96XJ2AM0VWd0HmqXhvala
	Kc2QI++S5SzZ9LbKiDHxFvQRZ1aSuDX18WMJHcsrZtpTHC3L988fLLTlq/M2Fi/WTs7bYKw7
	Y9kaCmlHOsD18GKny+ANqlbr/U89a2ntwy295lmTaQdrMtTJPfZ+d4J6ddV4+eZbfn9xy0bf
	vnUzrv3wi92+curPu+GFc37d+dWIM3/V1/O21UaWNa6Z0fdlS46OzVYMS/TYlG14CeEPn9JI
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUyMcRzA93t+z1s3Z49zeCYW18xWXof5Wpi8PmzMX4wRR888x/XirlI2
	HJXSKomi69rOKNVl2dWqI7G7nELikg4Roc20Xk/Ti9Jlxn+ffX7fz/f3z5fFimvUTFYTHiXq
	wtVaFS0jZTuC4hda5yZLSxxmJZhKS2iw/IyFWx+rKDAVVyDwDL5jYOy+E0F/7WMavjv6ENy4
	PoDB1JhAwo/SIQxfne0MWKzboa2gg4TqpEoM7RfraEhLGMZwf7CLgXNVhQSYygwMOPLqKXhR
	kU7BlaF8DJWGjww03TXR8KFkjIIOexoJ9cYiEnqyajG0pa8Dp3k6DDztRFBbWknAQGoeDc05
	dwm47DLT8DmhDYHL0U5C1kgyDbln0xEM/xzf1pXhoSD30QdmXaDg6OzGQnnRG0Jw1zwhBJvx
	PSOYrdFCWWGAkOJ2YcFafIEWrH2ZjND6upoW6q4Nk4Lt0yrBVtVPCGnxXbTQ+/UtKXTXNNM7
	lXtlq0NFrSZG1C1ee1AmmfLLcKRzUmz3y2ZkQNU+KciH5bnlfHmxlfIyyc3jr2a7GC/T3Hze
	7R7EXlZygfz3Fvu4l7GYy2b4pNJqOgWx7FRuP3/nQZB3Rs4Bn24bJL2s4CS+sDED/fFT+Pqc
	LxMecwG8e/Qb4U0x58vfGmW92odbwzfcuz7x1TTOn39Y8ZjIQHLjf7Xxv9r4rzYjXIyUmvCY
	MLVGu2KR/pgUF66JXXQ4IsyKxu+l4NTIpSrkadpiRxyLVJPk0oUkSUGpY/RxYXbEs1illEfm
	n5cU8lB13ElRF3FAF60V9Xbky5KqGfJtu8WDCu6IOko8JoqRou7vK8H6zDSg2wtobR93aM7y
	zf01s1PTxE2GeKdnj9/plzMKfj1JWe9xzgl9kFgX+mLYcvJoozNfyny+UUtdalrbMuJ3oiF7
	V4n/UHavo7Xcz9Ua3bCS/ZW3NcsyOWhZ2PxZpLIo1bw540bj6sToEMuGm7XB056eCXnW39Iz
	q75jX6bfp+NLfsiDX6lIvaReGoB1evVvqtLRXSsDAAA=
X-CFilter-Loop: Reflected

On Mon, Jul 28, 2025 at 07:36:54PM +0100, Pavel Begunkov wrote:
> On 7/28/25 06:27, Byungchul Park wrote:
> > Changes from v1:
> >       1. Rebase on linux-next.
> 
> net-next is closed, looks like until August 11.

Worth noting, this is based on linux-next, not net-next :-)

	Byungchul

> >       2. Initialize net_iov->pp = NULL when allocating net_iov in
> >          net_devmem_bind_dmabuf() and io_zcrx_create_area().
> >       3. Use ->pp for net_iov to identify if it's pp rather than
> >          always consider net_iov as pp.
> >       4. Add Suggested-by: David Hildenbrand <david@redhat.com>.
> 
> Oops, looks you killed my suggested-by tag now. Since it's still
> pretty much my diff spliced with David's suggestions, maybe
> Co-developed-by sounds more appropriate. Even more so goes for
> the second patch getting rid of __netmem_clear_lsb().
> 
> Looks fine, just one comment below.
> 
> ...> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> > index 100b75ab1e64..34634552cf74 100644
> > --- a/io_uring/zcrx.c
> > +++ b/io_uring/zcrx.c
> > @@ -444,6 +444,7 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
> >               area->freelist[i] = i;
> >               atomic_set(&area->user_refs[i], 0);
> >               niov->type = NET_IOV_IOURING;
> > +             niov->pp = NULL;
> 
> It's zero initialised, you don't need it.
> 
> And a friendly reminder, please never send patches modifying a
> subsystem without CC'ing it, especially kept in another tree.
> Sure, you CC'ed me, but it's easy to lose.
> 
> --
> Pavel Begunkov
> 

