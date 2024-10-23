Return-Path: <bpf+bounces-42852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7E29ABA72
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 02:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE49F284F50
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 00:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E20168DA;
	Wed, 23 Oct 2024 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jASZzAAR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D994A32;
	Wed, 23 Oct 2024 00:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642662; cv=none; b=D2wAsGah3rTAOup3c75wtMks8rd0HgfRi86+ok1+aJ3BPafMJydKUFR0EafGveLto+ABgRoyGJgIF4A60GGzmHHNUmnd28o63GdQ9XS6hIYJOxdlrVK+KivT5ixOdkeodNyvKPdO5e/PiNubihvipv3VaXHbWsrMHKUcOnq3nnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642662; c=relaxed/simple;
	bh=w2dfDhbJwPb603y3rKaFQwdDE4y8ER+wb0z8YE5+40U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rdz1a39jSnA1yYUA0AOA6sLAj3Qg+TD7+e1Er0j3inYBgT3saOSau6ASPITtAL4W5iTD7qJOTb5ksBeTKVj3+48drfdZJrrfX4sBJbFETryRUkKivD1NzMb9MX/kebEICKWezgucdn0YceC02Y068zZgwNRS/QXgTaPwX0jKCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jASZzAAR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbce16d151so34959816d6.2;
        Tue, 22 Oct 2024 17:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729642659; x=1730247459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boylB+uwzpxY0w9wSizac5iiAY/4ZflfFk8qCL8Suxo=;
        b=jASZzAAR0KDc9ftpXfzYFbnxUFd9esE4DdqHlkgu7R+WvWFyrQpVlHm0tLtGvLLO38
         QTivVT8eEYf3uWS1egB39GVnwklcDODggXrgyfsQ809xyVuXiICr3QTAF/54klEgYjzI
         3SRXxVVwjMQotMa6RS6lR7f1LitdqvPq+nzxMD3OVDinxkNHCC8daMbXyw0bdLLaHNrV
         glQ97DCoDCtAZ8OFXcjIux49AcBL+9bl1t8BGfm+usBqzFA3IYiPIroaXlQ99tysRd/8
         Gjyyjp24kg4LLOnxkdkPbgf55cfoh7lFULyE3bVOAvFrkGJkdxGBBmKPNOSZBvKVgoO1
         AoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729642659; x=1730247459;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=boylB+uwzpxY0w9wSizac5iiAY/4ZflfFk8qCL8Suxo=;
        b=bzvY7/mYTtXINLjZ7meSx+hWxBCzGd0UALIgXlJ750GWjmEQTyro1yid4lilowVX1A
         UxoLXYFiRatRxAo9ALEgRee6HrgWBLF3yeY/D6lq/O3qsQb4LwfI/jnHY8oayS6bBC+J
         eC0SKdffqUBM6BFwcEtlibe05MnWvtg4fFSSvx7B8QNBya46tIoD7psVHT9n/UKVz3WU
         oPyob86AuE9NgTZCz30WQDbJ1Ly491HH3ctW9PjK76rFeVYVfdG8PU08yMrTJEbVV90r
         tPgRm8PyPwUcp/yLSTevs5zDf45HvQqz5NYgtE6OislNWbTZocf3a3v4mfP0twSnWPJW
         EFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/NHo/dUcfewG38CdPRMFzv/+fVWbOEfe5l9r/SnjVE3z59dkeG4/Jg7mSDSDvZcrfdi/PbJKJ@vger.kernel.org, AJvYcCVHBpuRAUnUYMloMDHQ32nIVei/XVhlMYhXtTEfbz7vIe8kHZ1Rkby6QsRBCTNsF27UjL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUSqKlu1UTrv0u87te8HJtaUFc6TYz0IJd0+zXhyxBAYqqmiv8
	Qw8gjPW2kJcsNltTmp6oxhaVQEzDueamNxwGiBl8jRq7buj5M98z
X-Google-Smtp-Source: AGHT+IEeWigQcxNvCtQ+Pqos0y5Ym1KDIcCms964HY3zOrJB5J3kdHojaxw0rxhyWisvFJ9qRPU11g==
X-Received: by 2002:a05:6214:5c01:b0:6cb:2456:537 with SMTP id 6a1803df08f44-6ce341a6784mr14737426d6.29.1729642659415;
        Tue, 22 Oct 2024 17:17:39 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008fbb9dsm34691396d6.40.2024.10.22.17.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 17:17:38 -0700 (PDT)
Date: Tue, 22 Oct 2024 20:17:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <671840a23227e_1420e529466@willemb.c.googlers.com.notmuch>
In-Reply-To: <8a5f7f86-0784-4da3-a1b0-c2d88f3572d0@linux.dev>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com>
 <67157b7ec615_14e1829490@willemb.c.googlers.com.notmuch>
 <8a5f7f86-0784-4da3-a1b0-c2d88f3572d0@linux.dev>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin KaFai Lau wrote:
> On 10/20/24 2:51 PM, Willem de Bruijn wrote:
> > Jason Xing wrote:
> >> From: Jason Xing <kernelxing@tencent.com>
> >>
> >> Willem suggested that we use a static key to control. The advantage
> >> is that we will not affect the existing applications at all if we
> >> don't load BPF program.
> >>
> >> In this patch, except the static key, I also add one logic that is
> >> used to test if the socket has enabled its tsflags in order to
> >> support bpf logic to allow both cases to happen at the same time.
> >> Or else, the skb carring related timestamp flag doesn't know which
> >> way of printing is desirable.
> >>
> >> One thing important is this patch allows print from both applications
> >> and bpf program at the same time. Now we have three kinds of print:
> >> 1) only BPF program prints
> >> 2) only application program prints
> >> 3) both can print without side effect
> >>
> >> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > 
> > Getting back to this thread. It is long, instead of responding to
> > multiple messages, let me combine them in a single response.
> > 
> > 
> > * On future extensions:
> > 
> > +1 that the UDP case, and datagrams more broadly, must have a clear
> > development path, before we can merge TCP.
> > 
> > Similarly, hardware timestamps need not be supported from the start,
> > but must clearly be supportable.
> > 
> > 
> > * On queueing packets to userspace:
> > 
> >>> the current behavior is to just queue to the sk_error_queue as long
> >>> as there is "SOF_TIMESTAMPING_TX_*" set in the skb's tx_flags and it
> >>> is regardless of the sk_tsflags. "
> > 
> >> Totally correct. SOF_TIMESTAMPING_SOFTWARE is a report flag while
> >> SOF_TIMESTAMPING_TX_* are generation flags. Without former, users can
> >> read the skb from the errqueue but are not able to parse the
> >> timestamps
> > 
> > Before queuing a packet to userspace on the error queue, the relevant
> > reporting flag is always tested. sock_recv_timestamp has:
> > 
> >          /*
> >           * generate control messages if
> >           * - receive time stamping in software requested
> >           * - software time stamp available and wanted
> >           * - hardware time stamps available and wanted
> >           */
> >          if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> >              (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
> >              (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
> >              (hwtstamps->hwtstamp &&
> >               (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
> >                  __sock_recv_timestamp(msg, sk, skb);
> > 
> > Otherwise applications could get error messages queued, and
> > epoll/poll/select would unexpectedly behave differently.
> 
> I just tried the following diff to remove setsockopt from txtimestamp.c and run 
> "./txtimestamp -6 -c 1 -C -N -L ::1". It is getting the skb from the error queue 
> with only cmsg flag.

That it surprising and against the API intent as I understand it.
Let me reproduce and take a closer look.

> I did a printk in __skb_tstamp_tx to ensure the
> sk->sk_tsflags is empty also.
> 
> diff --git i/tools/testing/selftests/net/txtimestamp.c 
> w/tools/testing/selftests/net/txtimestamp.c
> index dae91eb97d69..5d9d2773b076 100644
> --- i/tools/testing/selftests/net/txtimestamp.c
> +++ w/tools/testing/selftests/net/txtimestamp.c
> @@ -319,6 +319,8 @@ static void __recv_errmsg_cmsg(struct msghdr *msg, int 
> payload_len)
>   	for (cm = CMSG_FIRSTHDR(msg);
>   	     cm && cm->cmsg_len;
>   	     cm = CMSG_NXTHDR(msg, cm)) {
> +		printf("cm->cmsg_level %d cm->cmsg_type %d\n",
> +		       cm->cmsg_level, cm->cmsg_type);
>   		if (cm->cmsg_level == SOL_SOCKET &&
>   		    cm->cmsg_type == SCM_TIMESTAMPING) {
>   			tss = (void *) CMSG_DATA(cm);
> @@ -362,7 +364,7 @@ static void __recv_errmsg_cmsg(struct msghdr *msg, int 
> payload_len)
>   	if (batch > 1) {
>   		fprintf(stderr, "batched %d timestamps\n", batch);
>   	} else if (!batch) {
> -		fprintf(stderr, "Failed to report timestamps\n");
> +		fprintf(stderr, "Failed to report timestamps. payload_len %d\n", payload_len);
>   		test_failed = true;
>   	}
>   }
> @@ -578,9 +580,12 @@ static void do_test(int family, unsigned int report_opt)
>   	if (cfg_loop_nodata)
>   		sock_opt |= SOF_TIMESTAMPING_OPT_TSONLY;
> 
> +	(void)sock_opt;
> +/*
>   	if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING,
>   		       (char *) &sock_opt, sizeof(sock_opt)))
>   		error(1, 0, "setsockopt timestamping");
> +*/
> 
>   	for (i = 0; i < cfg_num_pkts; i++) {
>   		memset(&msg, 0, sizeof(msg));
> > 
> >> SOF_TIMESTAMPING_SOFTWARE is only used in traditional SO_TIMESTAMPING
> >> features including cmsg mode. But it will not be used in bpf mode.
> > 
> > For simplicity, the two uses of the API are best kept identical. If
> > there is a technical reason why BPF has to diverge from established
> > behavior, this needs to be explicitly called out in the commit
> > message.
> 
> SOF_TIMESTAMPING_OPT_TSONLY will not be supported. The orig_skb can always be 
> passed directly to the bpf if needed without extra cost. The same probably goes 
> for SOF_TIMESTAMPING_OPT_PKTINFO. SOF_TIMESTAMPING_SOFTWARE does not seem to be 
> useful either. I think only a subset of SOF_* will be supported, probably only 
> the TX_* and RX_* ones.
> 
> > 
> > Also, if you want to extend the API for BPF in the future, good to
> > call this out now and ideally extensions will apply to both, to
> > maintain a uniform API.
> > 
> > 
> > * On extra measurement points, at sendmsg or tcp_write_xmit:
> > 
> > The first is interesting. For application timestamping, this was
> > never needed, as the application can just call clock_gettime before
> > sendmsg.
> > 
> > In general, additional measurement points are not only useful if the
> > interval between is not constant. So far, we have seen no need for
> > any additional points.
> > 
> > 
> > * On skb state:
> > 
> >>> For now, is there thing we can explore to share in the skb_shared_info?
> > 
> > skb_shinfo space is at a premium. I don't think we can justify two
> > extra fields just for this use case.
> > 
> >> My initial thought is just to reuse these fields in skb. It can work
> >> without interfering one another.
> > 
> > I'm skeptical that two methods can work at the same time. If they are
> > started at different times, their sk_tskey will be different, for one.
> 
> For the skb's tx_flags, Jason seems to be able to figure out by only using the 
> new sk_tsflags_bpf. In the worst case, it seems there is still one bit left in 
> tx_flags.
> 
> I am also not very positive on the skb's tskey for now.
> 
> Willem, I recalled I had tried to reuse the tx_flags and hwtstamp when keeping 
> the delivery time in skb->tstamp for a skb redirecting from egress to ingress. I 
> think that approach was stalled because the tx_flags could be changed by the 
> netdevice like "skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS". How about the 
> skb_shinfo(skb)->hwtstamps? At least for the TX path, it should not be changed 
> until the netdevice calling skb_tstamp_tx() to report the hwtstamp? or the clone 
> in the tcp stack will still break things if the hwtstamps is reused for other 
> purpose?

True. I think on Tx hwtstamps is only used on the path from the driver
tx completion handler to when it calls skb_tstamp_tx.

It does not even really have to be an skb field. The first driver
cscope happens to point me to indeed just allocates it on the stack:
tsnep_tx_poll.

> > 
> > There may be workarounds. Maybe BPF can store its state in some BPF
> > specific field, indeed. Or perhaps it can store per-sk shadow state
> > that resolves the conflict. For instance, the offset between sk_tskey
> > and bpf_tskey.
> 
> I have also been proposing to explore other way for the key since bpf has direct 
> access to the skb (also the sk, bpf prog can store data in the sk).
> 
> The bpf prog can learn what is the seq_no of the egress-ing skb. When the ack 
> comes back, it can also learn the ack seq no. Does it help? It will be harder to 
> use because it probably needs to store this info in the bpf map (or in the bpf 
> sk storage). However, if it needs to learn the timestamp at the 
> tcp_sendmsg/tcp_transmit_skb/tcp_write_xmit, this timestamp has to be stored 
> somewhere also. Either in a bpf map or in a bpf sk storage.
> 
> SEC("cgroup/setsockopt") prog can also enforce the user space setsockopt. e.g. 
> it can add SOF_TIMESTAMPING_OPT_ID_TCP when user space only use 
> SOF_TIMESTAMPING_OPT_ID.



