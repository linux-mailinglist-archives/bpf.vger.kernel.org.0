Return-Path: <bpf+bounces-49258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FDBA15DAB
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 16:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86ABC3A7F95
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9650196C7B;
	Sat, 18 Jan 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pqs0xvsL"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB6810F2;
	Sat, 18 Jan 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737214263; cv=none; b=scQgi93mqA7m2Sr1jv24/m8+7/eprnIR2qV0K52e0KzWdEEzHRQBpDaNWhRzcQwtJvXksFjUsm5z/+sncwuA0+xZASJcg0BhoGbzJR8NOe25t/WfvlIF1IfYCY7cUTWmCgBq5VgVLia/JQ61tuKO5crxbZJdAz+6N27PLV7VJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737214263; c=relaxed/simple;
	bh=k670exMaaeh2eraHJTaPRIvbegXxucyogS5+QnX5jkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqLHzBOa33DsJxPCXShOWRs+hI4WJmv+tKdhxWr+wYTwb1dFqStVRBQbPSFikt1MU/y2g3ie32gtIohtLkl8QP1FB3+t5EauDhxbySvoQpugkqClyoazwqzv3d13TsfZSvpdKbHj2uV2jZ9G/HoIo9IglZC0zMg1I0cjD32gmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pqs0xvsL; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=vMAPIeNXw3fRUCPfq2DqrA0Nc9BSdEZHypXDiuZxYrw=;
	b=pqs0xvsLy6RCXqFwOFjNoGe+MxBBstWHxO5Xw6OIjgepofDsnkPb+gkNUcxcMU
	MLFnep7VjUHjau6pSE+ZnxLbVYQdzm/yPS32fitkWgMdH4Cq1jqm/a0koGvvkUdY
	fl8pXHnoQwNScvNoW7BLJ5oWbyrgoMTPeN/bRTWkgL/xo=
Received: from iZj6c3ewsy61ybpk7hrb16Z (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3l67AyItn2QMCGw--.51932S2;
	Sat, 18 Jan 2025 23:29:07 +0800 (CST)
Date: Sat, 18 Jan 2025 23:29:04 +0800
From: Jiayuan Chen <mrpre@163.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org, 
	martin.lau@linux.dev, ast@kernel.org, edumazet@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	song@kernel.org, andrii@kernel.org, mhal@rbox.co, yonghong.song@linux.dev, 
	daniel@iogearbox.net, xiyou.wangcong@gmail.com, horms@kernel.org, corbet@lwn.net, 
	eddyz87@gmail.com, cong.wang@bytedance.com, shuah@kernel.org, mykolal@fb.com, 
	jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf v7 2/5] bpf: fix wrong copied_seq calculation
Message-ID: <4uacr7khoalvlshkybaq4lqu55muax5adsrnqkulc6hgeuzaeg@eakft72epszp>
References: <20250116140531.108636-1-mrpre@163.com>
 <20250116140531.108636-3-mrpre@163.com>
 <87ikqcdvm9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikqcdvm9.fsf@cloudflare.com>
X-CM-TRANSID:_____wD3l67AyItn2QMCGw--.51932S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw45Zr1DKw1fJryfArWxCrg_yoW8GF45pF
	ykAw4Y9ayDJFWUWws8tFyIkr1agrZYkayjkr48ta4xursF9w1rGFyS9rWjyr15GwnI9r13
	ZrW7WFW3Awn7AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnNVgUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwHYp2eLvAVybgABs5

On Sat, Jan 18, 2025 at 03:50:22PM +0100, Jakub Sitnicki wrote:
> On Thu, Jan 16, 2025 at 10:05 PM +08, Jiayuan Chen wrote:
> > 'sk->copied_seq' was updated in the tcp_eat_skb() function when the
> > action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> > +}
> > +#endif /* CONFIG_BPF_STREAM_PARSER */
> > +
> >  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
> >  {
> >  	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
> > @@ -681,6 +722,12 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
> >  
> >  	/* Pairs with lockless read in sk_clone_lock() */
> >  	sock_replace_proto(sk, &tcp_bpf_prots[family][config]);
> > +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> > +	if (psock->progs.stream_parser && psock->progs.stream_verdict) {
> > +		psock->copied_seq = tcp_sk(sk)->copied_seq;
> > +		psock->read_sock = tcp_bpf_strp_read_sock;
> 
> Just directly set psock->strp.cb.read_sock to tcp_bpf_strp_read_sock.
> Then we don't need this intermediate psock->read_sock callback, which
> doesn't do anything useful.
>
Ok, I will do this.
(BTW, I intended to avoid bringing "struct strparser" into tcp_bpf.c so I
added a wrapper function instead in skmsg.c without calling it directly) 
> > +	}
> > +#endif
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(tcp_bpf_update_proto);


