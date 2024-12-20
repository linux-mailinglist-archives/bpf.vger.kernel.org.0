Return-Path: <bpf+bounces-47404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C987F9F8D0F
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 08:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1769C168AF6
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 07:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4098319DF47;
	Fri, 20 Dec 2024 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmbr3g4h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFAB143895;
	Fri, 20 Dec 2024 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734678405; cv=none; b=nXKGPigWL2tcqzlLzCCnewnNtb1IEcNHkwJ51570jAw7eOnI3ZzJoiVzZhiPh3f4iI9EOn8YImh2fBXXQ1aKAhWT8scQtCW1Dgw/wU+cY6b5HHGyMrmhkt03vVk5GVPd/99E9yaGzkvJKM0N2RL+rK/fopJNaA9J0r6D7PqbWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734678405; c=relaxed/simple;
	bh=nuxXMTlPUc5jc/AIemBhkoNdMFmXojiybIWn1boL6E4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=brHXNsJPg9xwnknJV1hR2/RGwWQ1ESGidInaTogodQG0RSNfx7v4Y9tNZ3FljgX7ieAFgXASt19LYriHqQNDG342yqzNIM9qZl1ObIO2hWDDV6o+7668IsgixUlUeIutvd7fPIC2QwdRujyNZAOpQwJZGhC8iakF3WEEv1WX2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmbr3g4h; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163bd70069so14677495ad.0;
        Thu, 19 Dec 2024 23:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734678403; x=1735283203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFd2678B4719Hkfdn31bd9iVBYUOVkAjA8Fjx6Hdqco=;
        b=nmbr3g4hwY4GkK2xIGmqDetgGWB9uHfGY+h2vDUn4UH3FdOE55g3QXEamo9T0sbC4A
         BRWQ3fv2gtJaYXPen9lskyV4accrwEMVvCHPJRMTT/Ya4AcLEH62d8DaPnwkhOWq0Vcv
         7JegonkQu88OmBsanPQywZb1uqmjDfQptA7Lm2+w6mjxj523YlAM50wwbcuwsElsBKff
         sbfHDjl4qy4oaoYPBVep4xcZSncajtgq4j0pJRlue53aRZ79HIWIpFo5e7UOtrn3Wq8S
         fff4/dxom3zc5w63j+A1leXV5kQQVTFk6jGVsxz3fBpab//irYW4hQR97ZzPlDCw+xtg
         VdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734678403; x=1735283203;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JFd2678B4719Hkfdn31bd9iVBYUOVkAjA8Fjx6Hdqco=;
        b=sznI0jHvH85g2Fy4jpjsIyDP2LgPYlEZdqppUEXn5zKtG8FJcjg3jtG1chFhTtzWvk
         h4YaenugvgCz4vS6iwk55eRYJVovHU8fP3uyGSu3xVgxttDWzjnmqcVbVz6dtlbktAyg
         uAS/Wo0hhLgZ+iFT+lQzgT2D1/LX2yEb61bpUcpkqLr396iuUoST6kE+5WtIHkJY9jAO
         tEhIa5uOZpHzbGi+HHbVV2r6a3UOtoLDAK908IsRCMq+e19SHDMrDOBwsSe8pCLq42jy
         K6Ws+loynymIDDj0XoxEGia+TZ8/0YK/VacC2lkTcPgytc9IjtHKerwzTLUWn3opEXHW
         6w1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaryxvfxcqDANOG7TeGLD3dZh0dJIK8YYoJmzrrowOxsVSTgtGQOBhlcEgDHwMGbwUCXEdYrBK7iL66VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcuX7jAqe1MxJRRBAXbDKM22qSBPuH0BOirsO/t2VJ/ORkqr+U
	Fjb4n/q72x+y0HDeD0TalPTtZy4rPqIoch6yGhJC8OqHC9rw6U0A
X-Gm-Gg: ASbGncuiPIJiyv2QjI4ydNWHjkTkihmSb7F1xwj6RX5bVhjwU3kiAjOEVyvzI73ZlLz
	sSl3fQeMBHkue0LRcmGhgxkwMGAuXJ9Kx8CBlc4KzODsT5Se+RaKY6iAsEItAexdCFHihtr1MZT
	bG3ogfg8gRHIkK7PRYAMhXxqbD4JymjPUYkvlqGs/C3Q2ct7JH0+NIc1NMDn5LKbBMY6Oivlz/R
	rMXuIo18u5tGWEx5giqbn92/lSBJPIqj/Kbcsz6oCuGCAJ0YIHo+YJnpg==
X-Google-Smtp-Source: AGHT+IF55TXa60gpIAb58xF4UZwz78ABU7J7Vd2RQl5UPyFBPBaTi+Euu4rqt5okUyD2VJcCPLHaJg==
X-Received: by 2002:a17:902:ef07:b0:216:5e6e:68c7 with SMTP id d9443c01a7336-219e6f3802bmr22269125ad.57.1734678403306;
        Thu, 19 Dec 2024 23:06:43 -0800 (PST)
Received: from localhost ([98.97.40.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02e3dsm22175575ad.282.2024.12.19.23.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 23:06:42 -0800 (PST)
Date: Thu, 19 Dec 2024 23:06:41 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <mrpre@163.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, 
 martin.lau@linux.dev, 
 ast@kernel.org, 
 edumazet@google.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 linux-kernel@vger.kernel.org, 
 song@kernel.org, 
 john.fastabend@gmail.com, 
 andrii@kernel.org, 
 mhal@rbox.co, 
 yonghong.song@linux.dev, 
 daniel@iogearbox.net, 
 xiyou.wangcong@gmail.com, 
 horms@kernel.org
Message-ID: <67651781a0ec7_1f295208c8@john.notmuch>
In-Reply-To: <ojwjcubviyjxpucryc3ypi4b77h5f5g6ouv7ovaljah5harfyj@jue7hqit2t5n>
References: <20241218053408.437295-1-mrpre@163.com>
 <20241218053408.437295-2-mrpre@163.com>
 <87jzbxvw9y.fsf@cloudflare.com>
 <ojwjcubviyjxpucryc3ypi4b77h5f5g6ouv7ovaljah5harfyj@jue7hqit2t5n>
Subject: Re: [PATCH bpf v3 1/2] bpf: fix wrong copied_seq calculation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jiayuan Chen wrote:
> On Wed, Dec 18, 2024 at 04:35:53PM +0800, Jakub Sitnicki wrote:
> [...]
> > On Wed, Dec 18, 2024 at 01:34 PM +08, Jiayuan Chen wrote:
> > > +		if (tcp_flags & TCPHDR_FIN)
> > > +			break;
> > > +	}
> > > +
> > > +	WRITE_ONCE(psock->strp_offset, offset);
> > > +	return copied;
> > > +}
> > > +
> > >  enum {
> > >  	TCP_BPF_IPV4,
> > >  	TCP_BPF_IPV6,
> > 
> > [...]
> > 
> > To reiterate my earlier question / suggestion [1] - it would be great if
> > we can avoid duplicating what tcp_read_skb / tcp_read_sock already do.
> > 
> > Keeping extra state in sk_psock / strparser seems to be the key. I think
> > you should be able to switch strp_data_ready / str_read_sock to
> > ->read_skb and make an adapter around strp_recv.
> > 
> > Rough code below is what I have in mind. Not tested, compiled
> > only. Don't expect it to work. And I haven't even looked how to address
> > the kTLS path. But you get the idea.
> > 
> > [1] https://msgid.link/87o71bx1l4.fsf@cloudflare.com
> > 
> > ---8<---
> > 
> > diff --git a/include/net/strparser.h b/include/net/strparser.h
> > index 41e2ce9e9e10..0dd48c1bc23b 100644
> > --- a/include/net/strparser.h
> > +++ b/include/net/strparser.h
> > @@ -95,9 +95,14 @@ struct strparser {
> >  	u32 interrupted : 1;
> >  	u32 unrecov_intr : 1;
> >  
> > +	unsigned int need_bytes;
> > +
> >  	struct sk_buff **skb_nextp;
> >  	struct sk_buff *skb_head;
> > -	unsigned int need_bytes;
> > +
> > +	int rcv_err;
> > +	unsigned int rcv_off;
> > +
> >  	struct delayed_work msg_timer_work;
> >  	struct work_struct work;
> >  	struct strp_stats stats;
> > diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
> > index 8299ceb3e373..8a08996429d3 100644
> > --- a/net/strparser/strparser.c
> > +++ b/net/strparser/strparser.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/poll.h>
> >  #include <linux/rculist.h>
> >  #include <linux/skbuff.h>
> > +#include <linux/skmsg.h>
> >  #include <linux/socket.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/workqueue.h>
> > @@ -327,13 +328,39 @@ int strp_process(struct strparser *strp, struct sk_buff *orig_skb,
> >  }
> >  EXPORT_SYMBOL_GPL(strp_process);
> >  
> > -static int strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
> > -		     unsigned int orig_offset, size_t orig_len)
> > +static int strp_read_skb(struct sock *sk, struct sk_buff *skb)
> >  {
> > -	struct strparser *strp = (struct strparser *)desc->arg.data;
> > -
> > -	return __strp_recv(desc, orig_skb, orig_offset, orig_len,
> > -			   strp->sk->sk_rcvbuf, strp->sk->sk_rcvtimeo);
> > +	struct sk_psock *psock = sk_psock_get(sk);
> > +	struct strparser *strp = &psock->strp;
> > +	read_descriptor_t desc = {
> > +		.arg.data = strp,
> > +		.count = 1,
> > +		.error = 0,
> > +	};
> > +	unsigned int off;
> > +	size_t len;
> > +	int used;
> > +
> > +	off = strp->rcv_off;
> > +	len = skb->len - off;
> > +	used = __strp_recv(&desc, skb, off, len,
> > +			   sk->sk_rcvbuf, sk->sk_rcvtimeo);

I guess the main complication here is read_skb has already unlinked
the skb so we would lose the skb entirely in some cases here? Easy
example would be ENOMEM on __strp_recv clone.

OTOH you could likely optimize __strp_recv a fair amount for the
good case (if it happens to be true in your case) where all data
is in the skb normally and skip the clone or something. Although
not clear to me how common case that is.

> > +	/* skb not consumed */
> > +	if (used <= 0) {
> > +		strp->rcv_err = used;
> > +		return used;
> > +	}
> > +	/* skb partially consumed */
> > +	if (used < len) {
> > +		strp->rcv_err = 0;
> > +		strp->rcv_off += used;
> > +		return -EPIPE;	/* stop reading */
> > +	}
> > +	/* skb fully consumed */
> > +	strp->rcv_err = 0;
> > +	strp->rcv_off = 0;
> > +	tcp_eat_recv_skb(sk, skb);
> > +	return used;
> >  }
> >  
> >  static int default_read_sock_done(struct strparser *strp, int err)
> > @@ -345,21 +372,14 @@ static int default_read_sock_done(struct strparser *strp, int err)
> >  static int strp_read_sock(struct strparser *strp)
> >  {
> >  	struct socket *sock = strp->sk->sk_socket;
> > -	read_descriptor_t desc;
> >  
> > -	if (unlikely(!sock || !sock->ops || !sock->ops->read_sock))
> > +	if (unlikely(!sock || !sock->ops || !sock->ops->read_skb))
> >  		return -EBUSY;
> >  
> > -	desc.arg.data = strp;
> > -	desc.error = 0;
> > -	desc.count = 1; /* give more than one skb per call */
> > -
> >  	/* sk should be locked here, so okay to do read_sock */
> > -	sock->ops->read_sock(strp->sk, &desc, strp_recv);
> > -
> > -	desc.error = strp->cb.read_sock_done(strp, desc.error);
> > +	sock->ops->read_skb(strp->sk, strp_read_skb);
> >  
> > -	return desc.error;
> > +	return strp->cb.read_sock_done(strp, strp->rcv_err);
> >  }
> >  
> >  /* Lower sock lock held */
> 
> Thanks Jakub Sitnicki.
> 
> I understand your point about using tcp_read_skb to replace
> tcp_read_sock, avoiding code duplication and reducing the number of
> interfaces.
> 
> Currently, not all modules using strparser have issues with
> copied_seq miscalculation. The issue exists mainly with
> bpf::sockmap + strparser because bpf::sockmap implements a
> proprietary read interface for user-land: tcp_bpf_recvmsg_parser().
> 
> Both this and strp_recv->tcp_read_sock update copied_seq, leading
> to errors.
> 
> This is why I rewrote the tcp_read_sock() interface specifically for
> bpf::sockmap.
> 
> So far, I found two other modules that use the standard strparser module:
> 
> 1.kcmsock.c
> 2.espintcp.c (ESP over TCP implementation)
> (Interesting, these two don't have self-tests)
> 
> Take kcm as an example: its custom read interface kcm_recvmsg()
> does not conflict with copied_seq updates in tcp_read_sock().
> 
> Therefore, for kcmsock, updating copied_seq in tcp_read_sock is
> necessary and aligns with the read semantics. espintcp is similar.
> 
> In summary, different modules using strp_recv have different needs
> for copied_seq. I still insist on implementing tcp_bpf_read_sock()
> specifically for bpf::sockmap without affecting others.
> 
> Otherwise, we may need tcp_read_skb() to determine whether
> to update copied_seq according to the different needs of each module.
> 
> 
> Additionally,
> I've found that KTLS has its own read_sock() and
> a strparser-like implementation (in tls_strp.c), separate from the
> standard strparser module. Therefore, even with your proposed
> solution, KTLS may be not affected.
> 
> regards
> 
> 

