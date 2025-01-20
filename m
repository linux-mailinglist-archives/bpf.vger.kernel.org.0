Return-Path: <bpf+bounces-49289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEAEA16A98
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 11:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBCC7A40C5
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC841B043C;
	Mon, 20 Jan 2025 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IXoOHnHv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE78C1AF0B0
	for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367993; cv=none; b=V2J+QAgkM7i2lR0nGDtFMiyxqHcZDnw3RvFxPWz7nEKVNnOgVW7lxD5STyFfMCKSJu+q1j6VsyDMNAYM0dyRDMa7eLO9ubOJE3WIHhQwhjd7no5nEl3I914+R4x3HViZxn8VdDeLL4vlsv4Du0eUAL9EtNpr1meNaYQMQ1Rxnfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367993; c=relaxed/simple;
	bh=POeSpLXqMDnf4ncHbT7WX49tYfW9PFR0KWRj+oU7i6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sxYTVQOFFRnxBSC5XFpKiN7LTykRXxoUK4k2ywkvUnjfT2Ld/WKvnAb6Q6qqN4tMkj6f9ZlaonwaaVLIdrqPYvKBgUo4h7GnDJLCAQGB8UXcIeRK9UOf0swT9stZZVb9PVbNqs+Xkv8XM1k8SDKirOmBBso3crzBNHZl/LaSlco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IXoOHnHv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so7894530a12.3
        for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 02:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737367990; x=1737972790; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+AmXtS555KTGh368N6qrcyGQOSWOD2uM0ZEZKy8e4w=;
        b=IXoOHnHvuITax+uU8uyj3FCD1+zVkSGMte6VFd9kwcZQy+03YCcP2InjSq6RKd7Npg
         hWAVjMa++UZ8MMeNiBC62klRpLf4PHfqAa0avOsNoCVzSpWCPGcoLRxCRvA6el2rDep9
         x9vCfhkZPsyq7JthqO52fkSSpIxG0inGYhr/sWPY4FOVFDpw5lJYm4YRyGF0c34hUp4m
         9Xn0ItD47XGtKu3RXXjPehu7QNwrBPeFtyxgJ8QAxzcAktboq3sq+6ogjlfc83dcKLgz
         8P2RZSVAYNyv/FSqCv0Xvk8+p49BPgx1z23/d1vpn4sPWmD/eV9dANZep41BMNKyiLUE
         oJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737367990; x=1737972790;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+AmXtS555KTGh368N6qrcyGQOSWOD2uM0ZEZKy8e4w=;
        b=onvEvOsm300983LSJzDghO9LSeIKFSyJA/qwbb6TFdw7YZlW+tUn5pEPIT7LsSNh+E
         i73fTp+8p+/pi1eB4/unHsIjsuj4+FVIapuVSqN78PJVpl2sGtW1a6XAIeu1IaYdVLTm
         taOylImqqll/qWfxLE5hUiSQkSjpNAOEGUzezUR4LNnqFBaqs+N+z7HTHIoJQigZOaxQ
         Q+t746z+F2bxAVHMaPF2cZCXwwdTixCKC1Ssy3X69ivtYaKWlCl49I7//ly0mKu6wzu9
         ACsn3I8YnVsjp0OD7QJ0oW8+1YiHQ3l/SaItINWB26K+lquHnebuIqUIEARlKKajlFtO
         BTMQ==
X-Gm-Message-State: AOJu0YwXOTjT/mDVRpx+br70xvK9PyaxbG/5VtNCnY8oTpgmpHkqbitq
	4h7mJjZOi6OiM/YffRuYR3OqZDnC13W3rzdXT2IoaGaOeRZZ8VZkFb4KHCisDgY=
X-Gm-Gg: ASbGncsMGtmCxJlLupokhBY0k1k/u8DJUlrQ0xv5A7uMY2bFFlXWlK0KXU5hfDcBZTR
	cDGuB7BWGDuxT3SPaaTC6iCOag541xF+tlD17bQ9HoYolO6fuFtcu9cT6fj2uqGpH770O9vUjKH
	o7Zfc2MgNuSEztNVBUQuUN0wyYzPTQ36OCHdFHdEl+rlC7gMvc8uhw5rKO34p+lk54asUxsnXjl
	fMj12scTD6iUT4//Dc8urolcmfDhSgGsDzKLzvnuoCrvEFiUVhXVhmw4j0bNaA=
X-Google-Smtp-Source: AGHT+IG3sxDHUYpin9r1buo9Oh2Jpo9gAgFq3g/a7WzAvcrq0JBMicje/huYwTSgfgvyeKZ4VF6qOw==
X-Received: by 2002:a17:907:7faa:b0:a9e:b150:a99d with SMTP id a640c23a62f3a-ab38b1b45aamr1198652366b.5.1737367990090;
        Mon, 20 Jan 2025 02:13:10 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506f:2387::38a:15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f224casm589585666b.87.2025.01.20.02.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 02:13:09 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf v7 2/5] bpf: fix wrong copied_seq calculation
In-Reply-To: <j5piuelz2xt65bn42bxufmk4nmigvzjotbygwd5tin7t6cvrsj@gpon5o7px7tu>
	(Jiayuan Chen's message of "Mon, 20 Jan 2025 11:35:37 +0800")
References: <20250116140531.108636-1-mrpre@163.com>
	<20250116140531.108636-3-mrpre@163.com>
	<87ikqcdvm9.fsf@cloudflare.com>
	<4uacr7khoalvlshkybaq4lqu55muax5adsrnqkulc6hgeuzaeg@eakft72epszp>
	<j5piuelz2xt65bn42bxufmk4nmigvzjotbygwd5tin7t6cvrsj@gpon5o7px7tu>
Date: Mon, 20 Jan 2025 11:13:08 +0100
Message-ID: <87a5bliyiz.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 20, 2025 at 11:35 AM +08, Jiayuan Chen wrote:
> On Sat, Jan 18, 2025 at 11:29:04PM +0800, Jiayuan Chen wrote:
>> On Sat, Jan 18, 2025 at 03:50:22PM +0100, Jakub Sitnicki wrote:
>> > On Thu, Jan 16, 2025 at 10:05 PM +08, Jiayuan Chen wrote:
>> > > 'sk->copied_seq' was updated in the tcp_eat_skb() function when the
>> > > action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
>> > > +}
>> > > +#endif /* CONFIG_BPF_STREAM_PARSER */
>> > > +
>> > >  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>> > >  {
>> > >  	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
>> > > @@ -681,6 +722,12 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>> > >  
>> > >  	/* Pairs with lockless read in sk_clone_lock() */
>> > >  	sock_replace_proto(sk, &tcp_bpf_prots[family][config]);
>> > > +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>> > > +	if (psock->progs.stream_parser && psock->progs.stream_verdict) {
>> > > +		psock->copied_seq = tcp_sk(sk)->copied_seq;
>> > > +		psock->read_sock = tcp_bpf_strp_read_sock;
>> > 
>> > Just directly set psock->strp.cb.read_sock to tcp_bpf_strp_read_sock.
>> > Then we don't need this intermediate psock->read_sock callback, which
>> > doesn't do anything useful.
>> >
>> Ok, I will do this.
>> (BTW, I intended to avoid bringing "struct strparser" into tcp_bpf.c so I
>> added a wrapper function instead in skmsg.c without calling it directly) 
>> 
> I find that tcp_bpf_update_proto is called before sk_psock_init_strp. Any
> assignment of psock->cb.strp will be overwritten in sk_psock_init_strp.

Or just don't set ->read_sock in strp_init.
It's being reset only because you made it so in patch 1 :-)

