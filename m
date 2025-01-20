Return-Path: <bpf+bounces-49280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E38CA165BE
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 04:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0AC3A4ED5
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 03:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7FA1494AB;
	Mon, 20 Jan 2025 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cnR7vqHm"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA433987;
	Mon, 20 Jan 2025 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737344303; cv=none; b=BIqrFyjDvn7HUbrshBT+5oRsy3W3ucTUQLZ25vQoxSAmhAPTibwM/a7G0BFxq+aIgWqN21arA3cmwCVbIeCPsDxyDOjjKyivvUT/9p/OsyaLFtuiQk1CauB3eJ0odMhiY38TIZ3gKtUy6xUTasPbEM7fT4DsZfo6o5iASOuSfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737344303; c=relaxed/simple;
	bh=LU3SgtTXrFcDipPP9KKHugTnsVbFq0AW902C3yqlZ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhQ/6oyjPJge0maTMMkSbQmM1/VX7Uwt9ITycZIGunmFed+rU8rKmhgInu8H0GpCG98AZqYwvwJgnL/rWcWm9KMVvoy9t+Xx4OhWMz1FI7PleEtzb30FqRONNPjCmKshqAcH8lm5N8eBgpFpDXUqK84LRbeRcQJj2dEKseGVOPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cnR7vqHm; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=L2wRnYLIkqx8ogtBAXlZzGo+E3J3c6ZZw0OgOUPaVLQ=;
	b=cnR7vqHmsn5q7ONnigpWnzA1zo/C1k5UKj94wdewi1H6iIgFMBHCpja9pGqj4m
	+6QzleGnBwfprKjNC8Sxj2xIJVsSwlfQ8lx396j9a6pnKjyJ7eHlikryeE6fvrg6
	mHFI6lU9xycF1j1GDJK/oUyTwgLW/hhokqhOMYrJMmZ4Q=
Received: from osx (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHtt6JxI1nNuxVHQ--.33849S2;
	Mon, 20 Jan 2025 11:35:38 +0800 (CST)
Date: Mon, 20 Jan 2025 11:35:37 +0800
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
Message-ID: <j5piuelz2xt65bn42bxufmk4nmigvzjotbygwd5tin7t6cvrsj@gpon5o7px7tu>
References: <20250116140531.108636-1-mrpre@163.com>
 <20250116140531.108636-3-mrpre@163.com>
 <87ikqcdvm9.fsf@cloudflare.com>
 <4uacr7khoalvlshkybaq4lqu55muax5adsrnqkulc6hgeuzaeg@eakft72epszp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4uacr7khoalvlshkybaq4lqu55muax5adsrnqkulc6hgeuzaeg@eakft72epszp>
X-CM-TRANSID:_____wDHtt6JxI1nNuxVHQ--.33849S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1UWw1rJr4xWw45WF4Uurg_yoW8uFykpF
	yDA3yaka4DJFW7W3Z0qr97Kr13G395Kayjkryrta4fursF9r1rGFyY9rWjyr15Kr4DCr13
	JrWjgFZxAwnrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnNVgUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDxnap2eNu27+wAAAsq

On Sat, Jan 18, 2025 at 11:29:04PM +0800, Jiayuan Chen wrote:
> On Sat, Jan 18, 2025 at 03:50:22PM +0100, Jakub Sitnicki wrote:
> > On Thu, Jan 16, 2025 at 10:05 PM +08, Jiayuan Chen wrote:
> > > 'sk->copied_seq' was updated in the tcp_eat_skb() function when the
> > > action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
> > > +}
> > > +#endif /* CONFIG_BPF_STREAM_PARSER */
> > > +
> > >  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
> > >  {
> > >  	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
> > > @@ -681,6 +722,12 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
> > >  
> > >  	/* Pairs with lockless read in sk_clone_lock() */
> > >  	sock_replace_proto(sk, &tcp_bpf_prots[family][config]);
> > > +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
> > > +	if (psock->progs.stream_parser && psock->progs.stream_verdict) {
> > > +		psock->copied_seq = tcp_sk(sk)->copied_seq;
> > > +		psock->read_sock = tcp_bpf_strp_read_sock;
> > 
> > Just directly set psock->strp.cb.read_sock to tcp_bpf_strp_read_sock.
> > Then we don't need this intermediate psock->read_sock callback, which
> > doesn't do anything useful.
> >
> Ok, I will do this.
> (BTW, I intended to avoid bringing "struct strparser" into tcp_bpf.c so I
> added a wrapper function instead in skmsg.c without calling it directly) 
> 
I find that tcp_bpf_update_proto is called before sk_psock_init_strp. Any
assignment of psock->cb.strp will be overwritten in sk_psock_init_strp.

May read_sock still needed. But we can avoid adding wrapper function by
assigning psock->read_sock to cb.read_sock directly like this:

--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1137,10 +1137,11 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 {
        int ret;

-       static const struct strp_callbacks cb = {
+       struct strp_callbacks cb = {
                .rcv_msg        = sk_psock_strp_read,
                .read_sock_done = sk_psock_strp_read_done,
                .parse_msg      = sk_psock_strp_parse,
+               .read_sock      = psock->read_sock,
        };

        ret = strp_init(&psock->strp, sk, &cb);

---
Thanks


