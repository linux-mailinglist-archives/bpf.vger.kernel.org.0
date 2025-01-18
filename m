Return-Path: <bpf+bounces-49259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42343A15DBB
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 16:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506C83A703C
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF62E19CD01;
	Sat, 18 Jan 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jVTeFStU"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709DC273F9;
	Sat, 18 Jan 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737215349; cv=none; b=q91qAlYQt2HLv1Du2PejI1CkkZkc5t8EOlT9Wfok+Q9hA82Dkxgobo1QZ7WunwpIll5ghyb4Oxhr3GWlrZw5d8XyvC3+/qX5WxQ+U06U2YR6Becxbkqcw+GGLnQPUtPatE1En5kEzsdJYw1XiY7apXaezhF/MafFzfram/M9iQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737215349; c=relaxed/simple;
	bh=e5nIJONa/PLWJ1IxLY3QAmLKmHxeF5YrIDqo7zj7/vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqRPHxVunBy7L8PKOwrLvKLYUidfYd6o+mhdNWctNmq9Od7UQSQUuF0vCMwHjzmng6Ki/7ylYDKqDOj6d7sR/iJZh56MdrWemuUyjqod6Los0lJTIY6kFYt9mB1H6/uT8lXTkVhayxp+P1sCp5ffu/sBoBFubYKyy2ZsyskBQgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jVTeFStU; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=uZ0o+M3jbLCh9v0peRE957xke+pW1Ch4rMmlp7OhAts=;
	b=jVTeFStUDKESalGklj4YCuDCfJom/o7DolUEYgHWojMk9Kxu1I3XRr5h5pAC3v
	ObaOaeMuwrYYM0vkmdP7DtU7rQz3hLQagt3zTQvtIPIoDHe3xZN1x6pkpBKBIc3V
	QqO0VQHFRgg0K71E3oP741MN3c/rVcns9NfAyo2k3VUQk=
Received: from iZj6c3ewsy61ybpk7hrb16Z (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnv3V3yYtnZwhtHA--.49434S2;
	Sat, 18 Jan 2025 23:32:10 +0800 (CST)
Date: Sat, 18 Jan 2025 23:32:07 +0800
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
Subject: Re: [PATCH bpf v7 3/5] bpf: disable non stream socket for strparser
Message-ID: <ywlrfaa7rbutt4j35ku5zmsgtpvjx5ztmiqyqt5amty4wt63j7@mr3thty7gz7p>
References: <20250116140531.108636-1-mrpre@163.com>
 <20250116140531.108636-4-mrpre@163.com>
 <87a5bodv0a.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5bodv0a.fsf@cloudflare.com>
X-CM-TRANSID:_____wDnv3V3yYtnZwhtHA--.49434S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWrZrWxCFykKry3GFy8Krg_yoWDGrgEv3
	43KFyxZF17GF43t3s0934fJFnavrWkZr1kZrWDZFnrJw1fGrWvvrW5uFnxAr9rG3yfGFy7
	KFn5Jay0gF9I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbBHq7UUUUU==
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbBDwfYp2eLvAXPQQABst

On Sat, Jan 18, 2025 at 04:03:33PM +0100, Jakub Sitnicki wrote:
> On Thu, Jan 16, 2025 at 10:05 PM +08, Jiayuan Chen wrote:
> > +	if (sk_is_tcp(sk))
> > +		return true;
> > +	return false;
> > +}
> > +
> 
> We don't need this yet, so please don't add it. Especially since this is
> fix. It should be kept down to a minimum. Do the sk_is_tcp() check
> directly from sock_map_link().
> 
Ok, I will do this.
> >  static int sock_map_link(struct bpf_map *map, struct sock *sk)
> >  {
> >  	struct sk_psock_progs *progs = sock_map_progs(map);
> > @@ -303,7 +311,10 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
> >  
> >  	write_lock_bh(&sk->sk_callback_lock);
> >  	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
> > -		ret = sk_psock_init_strp(sk, psock);
> > +		if (sock_map_sk_strp_allowed(sk))
> > +			ret = sk_psock_init_strp(sk, psock);
> > +		else
> > +			ret = -EOPNOTSUPP;
> >  		if (ret) {
> >  			write_unlock_bh(&sk->sk_callback_lock);
> >  			sk_psock_put(sk, psock);


