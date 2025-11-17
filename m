Return-Path: <bpf+bounces-74693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81912C624EF
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 05:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD57A359A51
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 04:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6007C314D15;
	Mon, 17 Nov 2025 04:26:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488642E92D2;
	Mon, 17 Nov 2025 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763353580; cv=none; b=PPlTkFUk+OxEzZa8VGdU6mV6Fa0vfQuYR3L+iEPN7oY0dznJNK6qASyhR6VxHjUZ1b3Vtu6HMMn0S5io0fTJ0SeDGwypUk6Yxqy1Qh74axjnjue/utQtsmpeiVR1UymufgUDkIqQmiDB2CfAlEtJ1Sq5mW6AWnLCv8EV60oPRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763353580; c=relaxed/simple;
	bh=EHb93/suw9DCP+STvM20RaX9ju6vTOGSuWMIkB6L9+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECX1PHPIaoCooAGNIE6x1M+1Ch48nupx8jGI3FkW4BFCdQcsLTG2tVU64tBN4rJNhwQtAu5Jth1pW1Ds6qDuKJ7DxBqBzhgzwHWnM3FSUnw9AgeyhkEixdXmu5I1ky19DZlfrY4Yn6/Ky698t9mOPbh4M/q72eHwK4qnJyM1pmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-9f-691aa3dcc437
Date: Mon, 17 Nov 2025 13:25:58 +0900
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
Message-ID: <20251117042558.GA18510@system.software.com>
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-2-byungchul@sk.com>
 <20251106173320.2f8e683a@kernel.org>
 <20251107015902.GA3021@system.software.com>
 <20251106180810.6b06f71a@kernel.org>
 <20251107044708.GA54407@system.software.com>
 <20251107174129.62a3f39c@kernel.org>
 <20251112074118.GA31149@system.software.com>
 <20251114172318.3aafc438@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114172318.3aafc438@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH89zn9t5LY81jRXws+2LRmJAMRf1wNMui+7Dc6LaomJi4LNqN
	q9zworaAINlS22YCEwYMDFSMRSPyZliKllLBIG+CxEjYJFdF6JiDgYiIHbPUwbiQZX775X/+
	+Z3z4QhYf19jEOSUVMmcYkoyclpW+3JFxYeDVw3yln9GDVBeX8dB7dsMuO73aiBYN8ZAeY0H
	QSD4lIeFli4EbzrucfCifQbB1YpZDOUPHSz8VT+Hock3hmCi9AYHf3SN8FDr/hyGK0dZaD7X
	iGHkx24O8hwhDC3BKR5s3qpFcYOVhz5PvgaK565haLT6efjFV87BUN2CBkbb8ljocVazMF3S
	gWE4fxd0uSJgtncSQUd9IwOz5y9x8KjMx8Ctlkc8/NTv4uB3xzCC/vYRFkreZXNw8Ww+gtDb
	ReVUQUADFzuH+F0x4llF4cT2yVdYvFn9mBEHSgtZUblznxGbnM940eVOExuqosVcpR+L7poc
	TnTPFPHi4EAzJ3aXhlix6bcdYpP3DSPm2ae4fWsOaz+Kl5LkdMm8+eOj2oSR3gnmpG1lxqXK
	CsaKvHwuChMo2U59BQNsLhKW2PN8pxqzZCP1XxhDKnNkE1WUIFY5nGygjoayxbpWwGSap6XK
	kEYdrCapdPqVdamkI0CvBCc5lfUkB9O61uPL+SraU/acVRmTaKrMjzPqXkwi6fV5QY3DSCy9
	8WB8SbmGRNFWzz1G3UVJQKAvnuSzyzevo3erFLYAEed7Wud7Wuf/WhfCNUgvp6Qnm+Sk7TEJ
	mSlyRsw3J5LdaPHDKr9996UXzfTFtSEiIOMKnV9ZJ+s1pnRLZnIbogI2huvOfUZlvS7elHlG
	Mp84Yk5LkixtKFJgjWt1W2dPx+vJcVOqlChJJyXzf1NGCDNY0YGVtuw//7Y/scVd/tqq+Gp8
	34cNNv6adooJxkXsfp0VvqfL7tudVvKDrejMeq5vT8+2xAv22mLD+fWoO+pg1upjUd25lv2d
	X7nJAA58Zw/25u11fXr7ExSKL4zQPD4StAx+sHdjh9z/s98zMz9RPQ6O9MmQLrugtShw6Ius
	HOc2I2tJMMVGY7PF9C8NHjvqXQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+5//uTlanJbVv1UUqyjsKiS9XSihDx2iiwURlFTDDm40tTaV
	WQTLpMvIS/e5ZmgXK5sJs+a0rJzLSxGFop5InZkXLDExk5aWuSLy24/neZ/n/fLwWOVk1Lw+
	PlEyxmsNGlZBK7atPbm0+aZav6KpjANHkZOF+9/NcKfNw0DA2U2Bo8CNYDDwnoPR8ioEX33V
	LHyuHEBwM28Ig+NNGg3fin5gKC3rRvDJVshCZ1U7B/ddW8Gf30XDk9MlGNoza1hITxvGUB7o
	4yDVc3esuNjCQWVOLQNv3RkMXPpxG0OJpY2D+jIHC63OUQa6vOk01Nrv0dB/2YfBnxEJVbnT
	YOhVLwJfUQkFQ+dyWGjILqPgUXkDBxfrcln4mOZHUFfZTsPlkTMsXDuRgWD4+1hlX9YgA9de
	tHKRy8UTssyKlb1fsPjw3jtKbLSdp0X56UtKLLW3cGKuK0ksvhsmWuU6LLoKzrKia+ACJzY3
	PmHFGtswLZZ+WC2Wer5SYvrJPjZq2h7FuoOSQZ8sGZevP6DQtb/6RB1OnWTOyc+jLMjDWRHP
	E2ElcXessaIQnhYWkLYr3SjIrLCQyHIABzlUmE/SirNpK1LwWOjniE1uZYLGFCGR9H+x/DlS
	CkBuBHrZIKuEs5g4n8f+1SeT2uwOOshYCCPyrx4q+BcLM8mdX3xQDhHCSeHrnj+VU4V55Lm7
	mspCSvu4tH1c2v4/nYtwAQrVxyfHafWGiGWmQ7qUeL15WUxCnAuNbSj/+Mh5Dxqs3+RFAo80
	E5WLiFqvYrTJppQ4LyI81oQqT28hepXyoDblqGRM2G9MMkgmL5rJ05rpys27pQMqIVabKB2S
	pMOS8Z9L8SFqC4p4wF1S+Nxm8/XHr6Nd6qsStWpn197O6KaWmGpH1zNX6tz9zD5N02qf7Urh
	yPaagTnNMd4o5akj8tHq7LxtybGfdYuP+W9Zf1Yo1mx4Mb+lcWDWBN3bq7MNOx7vdc1IjZCS
	ov1FG5dEJw6PPqro5yfE7aqoy+xpmFQVq44Z7Zh6vEdDm3Ta8DBsNGl/A8QjZDA/AwAA
X-CFilter-Loop: Reflected

On Fri, Nov 14, 2025 at 05:23:18PM -0800, Jakub Kicinski wrote:
> On Wed, 12 Nov 2025 16:41:18 +0900 Byungchul Park wrote:
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 651e2c62d1dd..b42d75ecd411 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -114,10 +114,21 @@ struct net_iov {
> >                       atomic_long_t pp_ref_count;
> >               };
> >       };
> > +
> > +     unsigned int page_type;
> >       struct net_iov_area *owner;
> >       enum net_iov_type type;
> 
> type is 4B already in net-next, so you may want to reorder @type
> with @owner to avoid a hole and increasing the struct size.

Sure.  Better reorder them.  I will.  Thanks.

	Byungchul

> Other than that LGTM!
> 
> struct net_iov {
>         union {
>                 struct netmem_desc desc;                 /*     0    48 */
>                 struct {
>                         long unsigned int _flags;        /*     0     8 */
>                         long unsigned int pp_magic;      /*     8     8 */
>                         struct page_pool * pp;           /*    16     8 */
>                         long unsigned int _pp_mapping_pad; /*    24     8 */
>                         long unsigned int dma_addr;      /*    32     8 */
>                         atomic_long_t pp_ref_count;      /*    40     8 */
>                 };                                       /*     0    48 */
>         };                                               /*     0    48 */
>         struct net_iov_area *      owner;                /*    48     8 */
>         enum net_iov_type          type;                 /*    56     4 */
> 
>         /* size: 64, cachelines: 1, members: 3 */
>         /* padding: 4 */
> };

