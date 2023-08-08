Return-Path: <bpf+bounces-7258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258207742DC
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 19:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567BC1C20EA7
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 17:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E6A15481;
	Tue,  8 Aug 2023 17:51:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5C1B7D1;
	Tue,  8 Aug 2023 17:51:13 +0000 (UTC)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E41ACB76;
	Tue,  8 Aug 2023 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=8iItz4fAqc9eHWlkPTlOj5+qnfmys/TzLvwC/yA08jQ=; b=EMf5xQwVyzUnLtsBrpCxqvTU0F
	5Cvjq4BE1nyD8fihHctOb9LNCkiIVbbjd08EoEK1TXKDdnFDKsn9oAz1HBEp4coKLnxcnYtJ+Wfp0
	TXIAc6Va1L6Da8baMlf++ElczSmxomYyZDnTD64lVhCabao/gxZ50trd64IPE1ovX1GU=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:37588 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1qTQnA-0001gq-K0; Tue, 08 Aug 2023 13:46:49 -0400
Date: Tue, 8 Aug 2023 13:46:47 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Breno Leitao <leitao@debian.org>
Cc: sdf@google.com, axboe@kernel.dk, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 io-uring@vger.kernel.org
Message-Id: <20230808134647.3e0e702f54ef5e5b4378ff98@hugovil.com>
In-Reply-To: <ZNJ5f1hR3cre0IPd@gmail.com>
References: <20230808134049.1407498-1-leitao@debian.org>
	<20230808134049.1407498-2-leitao@debian.org>
	<20230808121323.bc144c719eba5979e161aac6@hugovil.com>
	<ZNJ5f1hR3cre0IPd@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 1/8] net: expose sock_use_custom_sol_socket
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue, 8 Aug 2023 10:21:03 -0700
Breno Leitao <leitao@debian.org> wrote:

> Hello  Hugo,
> 
> On Tue, Aug 08, 2023 at 12:13:23PM -0400, Hugo Villeneuve wrote:
> > On Tue,  8 Aug 2023 06:40:41 -0700
> > Breno Leitao <leitao@debian.org> wrote:
> > 
> > > Exposing function sock_use_custom_sol_socket(), so it could be used by
> > > io_uring subsystem.
> > > 
> > > This function will be used in the function io_uring_cmd_setsockopt() in
> > > the coming patch, so, let's move it to the socket.h header file.
> > 
> > Hi,
> > this description doesn't seem to match the code change below...
> 
> I re-read the patch comment and it seems to match what the code does,
> so, probably this description only makes sense to me (?).
> 
> That said, hat have you understood from reading the description above?
> socket.h
> Thanks for the review,

Hi Breno,
your comments says "move it to the socket.h header file" but it seems
to be moved to the net.h header file?

Hugo Villeneuve


> > > ---
> > >  include/linux/net.h | 5 +++++
> > >  net/socket.c        | 5 -----
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/net.h b/include/linux/net.h
> > > index 41c608c1b02c..14a956e4530e 100644
> > > --- a/include/linux/net.h
> > > +++ b/include/linux/net.h
> > > @@ -355,4 +355,9 @@ u32 kernel_sock_ip_overhead(struct sock *sk);
> > >  #define MODULE_ALIAS_NET_PF_PROTO_NAME(pf, proto, name) \
> > >  	MODULE_ALIAS("net-pf-" __stringify(pf) "-proto-" __stringify(proto) \
> > >  		     name)
> > > +
> > > +static inline bool sock_use_custom_sol_socket(const struct socket *sock)
> > > +{
> > > +	return test_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
> > > +}
> > >  #endif	/* _LINUX_NET_H */
> > > diff --git a/net/socket.c b/net/socket.c
> > > index 1dc23f5298ba..8df54352af83 100644
> > > --- a/net/socket.c
> > > +++ b/net/socket.c
> > > @@ -2216,11 +2216,6 @@ SYSCALL_DEFINE4(recv, int, fd, void __user *, ubuf, size_t, size,
> > >  	return __sys_recvfrom(fd, ubuf, size, flags, NULL, NULL);
> > >  }
> > >  
> > > -static bool sock_use_custom_sol_socket(const struct socket *sock)
> > > -{
> > > -	return test_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
> > > -}
> > > -
> > >  /*
> > >   *	Set a socket option. Because we don't know the option lengths we have
> > >   *	to pass the user mode parameter for the protocols to sort out.
> > > -- 
> > > 2.34.1
> > > 

