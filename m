Return-Path: <bpf+bounces-72484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63613C12A80
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 03:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 531864EFB87
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 02:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0638E23D291;
	Tue, 28 Oct 2025 02:24:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A91A5B8A;
	Tue, 28 Oct 2025 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761618281; cv=none; b=A9r9ip1Q11azkL69rpzGUnBpWxGpzizdiG9gQTGF8svJ47jYgtQkWTh2nHxECJz5v3awxtn1QaEqtH22JrhTkB1ctltTzZXV20CTWzZJ5oDZtYSocveCcaoL8rjpnVMHXMevMF6RPGrDuNp23RVbfu+FzedM7Re8ti2aCO+GvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761618281; c=relaxed/simple;
	bh=q6FNcEVb7r/dd3rY9+bQk6lP5I+i/FtdOTB3/WeN3EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZYe2g9Fmoir9DuXH155tCtfzIIzHJULh7Zx7ehaT4OPuAPkjtz+8AmnrPDKiienqSpALYg7R9sMVS0M9ZW2PFjKmY7X8jCrkxFEUPTmC6HLQUwgNpMThpVa5qQ0WzTWHbSGFRwoRV1Gu01hOA+zLYgMCialQSTll7IhnmH2Mjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-8a-6900295ba92a
Date: Tue, 28 Oct 2025 11:24:21 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mina Almasry <almasrymina@google.com>
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
	toke@redhat.com, asml.silence@gmail.com, bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
	ap420073@gmail.com, dtatulea@nvidia.com
Subject: Re: [RFC mm v4 1/2] page_pool: check if nmdesc->pp is !NULL to
 confirm its usage as pp for net_iov
Message-ID: <20251028022421.GA77904@system.software.com>
References: <20251023074410.78650-1-byungchul@sk.com>
 <20251023074410.78650-2-byungchul@sk.com>
 <CAHS8izPM-s2sL_KyGyUyv37PfZxNLf029DrXpQe8fo637Rn+rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPM-s2sL_KyGyUyv37PfZxNLf029DrXpQe8fo637Rn+rw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+++cnXNcro7L6p8SwaKiIGtR9AZSZhCnIjL60EWiDnlqo23F
	ZqZR4C0qSbOs0LlkYuUyc23a1JWSm5fZ1RbKotLSUrppaYmXmelE8tvD+z7v83s+vAwhaxeH
	MCptrKDT8mo5JSElPwLzl0cvnaZaWfBqHhgtxRTcHYiHwg8VYhgs7hKBsciO4PfgWxpGq+oR
	9NU2UPDN1YugIL+fAOPLVBL+WIYIqHR0IfiafY+Cz/XtNNy1bYe2250kPDpXTkD7JTcF6anD
	BFQNdtOQXGEeCy5NpKHJniGGq0O3CChP/EDDa4eRgtbiUTF0OtNJaDTcIeHntVoC2jIioN40
	B/qffkdQaykXQf/FGxQ05zhE8KCqmYYsj4mCjtQ2BB5XOwnXfOcpyE3KQDA8MBbZnflbDLl1
	rXREGJfk9VKc63sPwZXdeSPiWrIvk5y3+omIqzS8pzmT7QRXal7GpXk9BGcrukBxtt4rNPeu
	5RHFubOHSa7y4zqusqJPxKWndFNRs/dJwmMEtSpO0K1Yf1CitLyzo+Png+N/3DCgRFQ3Mw0F
	MJhdjR1WHzGp3dbr5Lgm2UW4M6MUjWuKXYK93kG/J5hdim9WXxanIQlDsF00fv4ik0pDDDOL
	1eC6Zs24R8oCNl5t9XtkrBnhkbwGamIRhBtzPvkBxFioL89DjN8SbCgu/MtMjBfglAe5flYA
	uxO/TnL5O8xmF+LH9gbRRM9zAbjEETSh5+Eas5fMREGGKQTDFILhP8EwhWBCZBGSqbRxGl6l
	Xh2mTNCq4sMOHdPY0Njn3T7ji65AvU27nIhlkDxQ2qQeVcrEfJw+QeNEmCHkwdLwXJ9SJo3h
	E04JumMHdCfUgt6JQhlSPle6qv9kjIw9wscKRwXhuKCb3IqYgJBERMYud/7MyXGHWD1DHS0R
	Q1kzNocXKnp+7Z8+f2T+jk1b2Ld8x6k1bUHuhj3BVmUBuzBfERu1NXJddDl/8/7W5PUlewce
	6tc6Ukyr7L4vi7eVhe62JruOHj4duaGzVTtalnX2Qg2fat7xJ8wSckD57JZa8WzaGeNGRp/5
	q9HYV6VolJN6Ja9YRuj0/D+lH0RNdQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+++c8z/H0fK0rA76IVhEuC4WFb1d0S91CMqKIKigTnVow81k
	S9GwmLqoRq7ZDZuXVlmZGdKs6Swlnc7ZPWWxyDYzU7pZmUlOa21G5LeH533e3/N+eBlC3kLF
	MurUA6IuVdAosJSUbliRN297/AT1ggGHBIqrKjHc+JkJ17pqKRiu7AtbFQ4Eg8OvaAjVuxF8
	b27F8NE1gODyxSECip8aSfhRFSTAWdeH4EPhTQzv3N003LCvh8DVXhLuHa0hoPukB0O+cYSA
	+uF+GnJry8PgagMNrpI2Cp45zBScCV4hoMbQRUNHXTEGf2WIgt6mfBLarNdJ+Hq2mYCAORHc
	tmkw9PATguaqGgkMnSjB4D1fJ4E79V4aTrfbMLw1BhC0u7pJODt6DENRjhnByM8wst8ySEFR
	i59OTOBzfD7Muz59Ifjb119K+BeFBSTva3gg4Z3W1zRvs6fz1eVK3uRrJ3h7xXHM2wdO0Xzn
	i3uY9xSOkLzzzTLeWftdwufn9eON07ZJV+4VNeoMUZewepdUVdXpQGnHYjI/l1iRAbVEm1AU
	w7GLOc+tc2REk+wsrtdcjSIas7M5n2+YiOgYNp4rayigTEjKEGwfzT1+YsEmxDBTWC3X4tVG
	MjIWuOIz/rGMnC1H3K/SVvx3MJlrO98zVkCEoaOl7URkl2DjuGu/mb/2DC7vTtFYVxS7ievI
	cY3dMJWdyd13tEosaJJ1HMk6jmT9T7KOI9kQWYFi1KkZWkGtWTJfn6LKSlVnzt+zX2tH4ee6
	emi0oBYNdqxtQiyDFBNlzzQhlZwSMvRZ2ibEMYQiRrayaFQll+0Vsg6Kuv07dekaUd+E4hhS
	MV22bqu4S87uEw6IKaKYJur+TSVMVKwBOc0hpqz6V8OjKcKRi53PS/2G5PhvwcOy2M2Lg7aG
	NL0n6fCq5G1bok0LdliowHvmypD4OXB3+Qk4sh5nKo/eNv4Q5EH1WnmuZ47uUrnFbVqj9Bq7
	Ei58WZo0Kd3uV+6emzzQ6N2cnZQdHbf76YZNj3oWVcS7axpznbkzp4ZOJypIvUpYqCR0euEP
	GRjoFVgDAAA=
X-CFilter-Loop: Reflected

On Mon, Oct 27, 2025 at 06:25:38PM -0700, Mina Almasry wrote:
> On Thu, Oct 23, 2025 at 12:44 AM Byungchul Park <byungchul@sk.com> wrote:
> >
> > ->pp_magic field in struct page is current used to identify if a page
> > belongs to a page pool.  However, ->pp_magic will be removed and page
> > type bit in struct page e.g. PGTY_netpp should be used for that purpose.
> >
> > As a preparation, the check for net_iov, that is not page-backed, should
> > avoid using ->pp_magic since net_iov doens't have to do with page type.
> > Instead, nmdesc->pp can be used if a net_iov or its nmdesc belongs to a
> > page pool, by making sure nmdesc->pp is NULL otherwise.
> >
> > For page-backed netmem, just leave unchanged as is, while for net_iov,
> > make sure nmdesc->pp is initialized to NULL and use nmdesc->pp for the
> > check.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  net/core/devmem.c      |  1 +
> >  net/core/netmem_priv.h |  8 ++++++++
> >  net/core/page_pool.c   | 16 ++++++++++++++--
> >  3 files changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index d9de31a6cc7f..f81b700f1fd1 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -291,6 +291,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >                         niov = &owner->area.niovs[i];
> >                         niov->type = NET_IOV_DMABUF;
> >                         niov->owner = &owner->area;
> > +                       niov->desc.pp = NULL;
> 
> Don't you also need to = NULL the niov allocations in io_uring zcrx,
> or is that already done? Maybe mention in commit message.

Yes, that's been already done by kvmalloc_array(__GFP_ZERO).  I want to
leave a comment explaining that on io_uring side like:

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index e5ff49f3425e..f771bb3e756d 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -444,6 +444,10 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 		area->freelist[i] = i;
 		atomic_set(&area->user_refs[i], 0);
 		niov->type = NET_IOV_IOURING;
+
+		/* niov->pp is already initialized to NULL by
+		 * kvmalloc_array(__GFP_ZERO).
+		 */
 	}
 
 	area->free_count = nr_iovs;

However, I dropped it as Pavel requested:

  https://lore.kernel.org/lkml/8d833a3f-ae18-4ea6-9092-ddaa48290a63@gmail.com/

I will mention it in commit message then.

> Other than that, looks correct,
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks.

	Byungchul

