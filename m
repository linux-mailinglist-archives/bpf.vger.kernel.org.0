Return-Path: <bpf+bounces-48740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA0A100DD
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 07:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030691888ACF
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 06:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2472397B7;
	Tue, 14 Jan 2025 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YfKDF3Pd"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFAC24023E;
	Tue, 14 Jan 2025 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736836625; cv=none; b=LkH76GUAdJxhWt+seOZl+7jbtn/p/6dqRjEz7WSZ4ZUtmlQaLS12TtGcNY7Qj1fB1Uw+IDdTEudUM4Z4u474tpc/9JmNOvFzr7zLFXP4DJsRDTlabaUyn99GgR8kCWEsRD30GImitT0pRyxkUdIhGeRRn1iGTDKppyuKPuN/LRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736836625; c=relaxed/simple;
	bh=MetRd4ao8tC0hRvIv/yDGYPQakB2mwm+mZs+t472GUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkWJ2IxlmumNiSFdeUleDFeemv8BajSxxH4/r6h/gvgSOgSZS94ZxCDE+qx+I5jj1rdhkrY4K4Viv5aiacokGiutQGA/evXT+btz5oo3es+zJgSEcbzN4cbAB6afefbVS/aEWmPsl3OW6bp0jZJbXdtgvc1Q+sEtIutPAHOMBKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YfKDF3Pd; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=p06lh+eDuk8Xksik4vNgRZUOkkFKqws0z/6pcjAQ1JM=;
	b=YfKDF3PdsPxNPCj1ALxbHcCX7R8BsR++NJETTggEfuskXntn2TlMMXl8yX0L5o
	BkcmVXBsX1Hs8RU0b1DWTDqefRaIzVVmdO+jd+J51WnBZPQsXAZLDuV4xal+ueyo
	P05bckoWd5+ucAGE9Aj56yN/LN+aseMdLkRzygncqBBNk=
Received: from osx (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3nyW2BYZn9hHdFw--.26271S2;
	Tue, 14 Jan 2025 14:35:36 +0800 (CST)
Date: Tue, 14 Jan 2025 14:35:34 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	netdev@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org, edumazet@google.com, 
	davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, song@kernel.org, andrii@kernel.org, mhal@rbox.co, 
	yonghong.song@linux.dev, daniel@iogearbox.net, xiyou.wangcong@gmail.com, horms@kernel.org, 
	corbet@lwn.net, eddyz87@gmail.com, cong.wang@bytedance.com, shuah@kernel.org, 
	mykolal@fb.com, jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me, 
	kpsingh@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf v5 1/3] bpf: fix wrong copied_seq calculation
Message-ID: <nch3maxdymvvdq647hijycfj2y242o67wgkch3vksfgrkabtt3@xuskfpo426xz>
References: <20250109094402.50838-1-mrpre@163.com>
 <20250109094402.50838-2-mrpre@163.com>
 <20250113160404.7ab0927d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113160404.7ab0927d@kernel.org>
X-CM-TRANSID:_____wD3nyW2BYZn9hHdFw--.26271S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr48XrWUZw1kKrW3KF4fAFb_yoW8GFW3pF
	yvyayqkr4UtFyxuwn8A397Xw1Fgw4Ska1UJr10qayayw18KrnagF90kr1YkrW5Kr15Zryq
	qrWUWFZxAw47Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnNVgUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWxnUp2eGAbZn-AAAs8

On Mon, Jan 13, 2025 at 04:04:04PM +0800, Jakub Kicinski wrote:
> On Thu,  9 Jan 2025 17:43:59 +0800 Jiayuan Chen wrote:
> > However, for programs where both stream_parser and stream_verdict are
> > active(strparser purpose), tcp_read_sock() was used instead of
> > tcp_read_skb() (sk_data_ready->strp_data_ready->tcp_read_sock)
> > tcp_read_sock() now still update 'sk->copied_seq', leading to duplicated
> > updates.
> 
> To state the obvious feels like the abstraction between TCP and psock
> has broken down pretty severely at this stage. You're modifying TCP
> and straight up calling TCP functions from skmsg.c :(
>
You are right!

How about we construct code like this:

sk_psock_strp_read_sock(strp)    skmsg.c
    tcp_bpf_strp_read_sock(sk)   tcp_bpf.c
        tcp_read_sock_noack(sk)  tcp.c

In skmsg.c we just register read_sock handler for strparser, then move
core code into tcp_bpf.c. I believe it makes more sense than before as
there already exist some psock with tcp operation(especially ops handler)
implemented in tcp_bpf.c.
 
> > +int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
> > +			sk_read_actor_t recv_actor, u32 noack,
> > +			u32 *copied_seq)
> > +{
> > +	return __tcp_read_sock(sk, desc, recv_actor,
> > +			       noack, copied_seq);
> > +}
> > +EXPORT_SYMBOL(tcp_read_sock_noack);
> 
> Pretty sure you don't have to export this. skmsg can't be a module.
ok, i will remove it.


