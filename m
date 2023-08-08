Return-Path: <bpf+bounces-7265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041E37749EE
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 22:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EF81C20FD8
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED01168D8;
	Tue,  8 Aug 2023 20:07:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391818F69
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 20:07:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE1046AD
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691525230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=URef7vegGsa2wnoaw1VuQcviklx9DOBuGXAqweG7Q+o=;
	b=Mu8Xt3HZPBfWjEbQphqcJhLN5T0O+qzAUOgNzLLxf9dG+mgdQsVtCv+a6tcW3bpC5ADSUm
	Cb001oOPzasEdSpKscHelEM3+edGO+jZWJaynGvxgta6BbWtCnRoGfc4PPFz4aTkKxvhwq
	6Oy3QB+a7ltjMzooFx63jFfNChnDW2w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-sl0LyO7YNBeAhvxsMKKR6A-1; Tue, 08 Aug 2023 16:07:05 -0400
X-MC-Unique: sl0LyO7YNBeAhvxsMKKR6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CB8F101A528;
	Tue,  8 Aug 2023 20:07:04 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A040F2026D4B;
	Tue,  8 Aug 2023 20:07:03 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Hugo Villeneuve <hugo@hugovil.com>,  sdf@google.com,  axboe@kernel.dk,  asml.silence@gmail.com,  willemdebruijn.kernel@gmail.com,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,  io-uring@vger.kernel.org
Subject: Re: [PATCH v2 1/8] net: expose sock_use_custom_sol_socket
References: <20230808134049.1407498-1-leitao@debian.org>
	<20230808134049.1407498-2-leitao@debian.org>
	<20230808121323.bc144c719eba5979e161aac6@hugovil.com>
	<ZNJ5f1hR3cre0IPd@gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 08 Aug 2023 16:12:51 -0400
In-Reply-To: <ZNJ5f1hR3cre0IPd@gmail.com> (Breno Leitao's message of "Tue, 8
	Aug 2023 10:21:03 -0700")
Message-ID: <x495y5p47jw.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Breno Leitao <leitao@debian.org> writes:

> Hello  Hugo,
>
> On Tue, Aug 08, 2023 at 12:13:23PM -0400, Hugo Villeneuve wrote:
>> On Tue,  8 Aug 2023 06:40:41 -0700
>> Breno Leitao <leitao@debian.org> wrote:
>> 
>> > Exposing function sock_use_custom_sol_socket(), so it could be used by
>> > io_uring subsystem.
>> > 
>> > This function will be used in the function io_uring_cmd_setsockopt() in
>> > the coming patch, so, let's move it to the socket.h header file.
>> 
>> Hi,
>> this description doesn't seem to match the code change below...
>
> I re-read the patch comment and it seems to match what the code does,
> so, probably this description only makes sense to me (?).
>
> That said, hat have you understood from reading the description above?

The comment states the function prototype is moving to socket.h, but the
patch puts it in net.h.

Cheers,
Jeff

>
> Thanks for the review,
>
>> > ---
>> >  include/linux/net.h | 5 +++++
>> >  net/socket.c        | 5 -----
>> >  2 files changed, 5 insertions(+), 5 deletions(-)
>> > 
>> > diff --git a/include/linux/net.h b/include/linux/net.h
>> > index 41c608c1b02c..14a956e4530e 100644
>> > --- a/include/linux/net.h
>> > +++ b/include/linux/net.h
>> > @@ -355,4 +355,9 @@ u32 kernel_sock_ip_overhead(struct sock *sk);
>> >  #define MODULE_ALIAS_NET_PF_PROTO_NAME(pf, proto, name) \
>> >  	MODULE_ALIAS("net-pf-" __stringify(pf) "-proto-" __stringify(proto) \
>> >  		     name)
>> > +
>> > +static inline bool sock_use_custom_sol_socket(const struct socket *sock)
>> > +{
>> > +	return test_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
>> > +}
>> >  #endif	/* _LINUX_NET_H */
>> > diff --git a/net/socket.c b/net/socket.c
>> > index 1dc23f5298ba..8df54352af83 100644
>> > --- a/net/socket.c
>> > +++ b/net/socket.c
>> > @@ -2216,11 +2216,6 @@ SYSCALL_DEFINE4(recv, int, fd, void __user *, ubuf, size_t, size,
>> >  	return __sys_recvfrom(fd, ubuf, size, flags, NULL, NULL);
>> >  }
>> >  
>> > -static bool sock_use_custom_sol_socket(const struct socket *sock)
>> > -{
>> > -	return test_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
>> > -}
>> > -
>> >  /*
>> >   *	Set a socket option. Because we don't know the option lengths we have
>> >   *	to pass the user mode parameter for the protocols to sort out.
>> > -- 
>> > 2.34.1
>> > 


